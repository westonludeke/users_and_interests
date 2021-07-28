require "yaml"
require "tilt/erubis"
require "sinatra"
require "sinatra/reloader"

before do
  @contents = YAML.load_file("users.yaml")
end

helpers do
  def count_interests
    @i = 0
    @contents.each do |key, value| 
      value.each do |k, v| 
        @i += v.size if k.to_s == "interests" 
      end
    end
    @i
  end
end

get "/" do
  redirect "/users"
end

get "/users" do
  erb :users
end

not_found do 
  redirect "/"
end

get "/users/:username" do 
  @username = params[:username].to_s

  redirect "/" unless @contents.keys.include?(@username.to_sym)

  erb :userpage
end
