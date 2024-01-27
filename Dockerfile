# 使用するRubyのバージョンを指定
FROM ruby:2.7.4

# 必要なパッケージのインストール
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# アプリケーションディレクトリを作成
WORKDIR /myapp

# ホストのGemfileとGemfile.lockをコンテナにコピー
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

# Bundlerを介してGemをインストール
RUN bundle install

# ホストの現在のディレクトリからコンテナの作業ディレクトリにファイルをコピー
COPY . /myapp

# コンテナがリッスンするポート番号を指定
EXPOSE 3000

# Railsサーバーを起動
CMD ["rails", "server", "-b", "0.0.0.0"]