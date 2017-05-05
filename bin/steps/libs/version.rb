#!/usr/bin/env ruby
require 'yaml'
require 'rubygems'
require 'pathname'

manifest = ARGV[0]

version = ARGV[1].gsub('python-', '')

if version.match(/\.x$/)
  v = version.gsub(/\.x$/, '.')
  hash = YAML.load_file(manifest)['dependencies']
  entries = hash.select do |e|
      e['name'] == 'python' && e['version'].start_with?(v)
  end.sort_by do |e|
    Gem::Version.new(e['version'])
  end
  full_version = "python-#{entries.last['version']}" if entries.last
else
  full_version = "python-#{version}"
end

puts full_version
