class DancingTotem < Formula
  desc "Menu bar GIF that dances faster as CPU usage rises"
  homepage "https://github.com/syc030403/dancing-totem"
  url "https://github.com/syc030403/dancing-totem/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "5361e7f1a3ab0148c6903025cb5405185868087fac0090f6e6a5bffea47fb2fe"

  depends_on macos: :ventura

  def install
    system "./build.sh"
    prefix.install "build/Dancing Totem.app"

    # `dancing-totem` 명령으로 앱을 띄운다.
    (bin/"dancing-totem").write <<~SH
      #!/bin/bash
      exec open "#{opt_prefix}/Dancing Totem.app" "$@"
    SH
    chmod 0755, bin/"dancing-totem"
  end

  service do
    run [opt_prefix/"Dancing Totem.app/Contents/MacOS/DancingTotem"]
    process_type :interactive
  end

  def caveats
    <<~EOS
      실행:
        dancing-totem

      로그인할 때 자동으로 켜려면:
        brew services start dancing-totem

      처음 실행하면 메뉴바의 "GIF 선택"을 눌러 재생할 GIF를 고르세요.
    EOS
  end

  test do
    assert_predicate prefix/"Dancing Totem.app/Contents/MacOS/DancingTotem", :executable?
  end
end
