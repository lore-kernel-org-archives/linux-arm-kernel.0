From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 18 Jul 2013 15:31:06 +0800
Subject: [PATCH 0/4] ARM: imx6q: clean up board specific CLKO setup
Message-ID: <1374132670-791-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CLKO is widely used by imx6q board designs to clock audio codec.
Currently, imx6q-sabrelite and imx6qdl-sabresd set up CLKO in board
specific hooks, while imx6qdl-wandboard handles that in U-Boot.
Since most audio codecs accept 24 MHz frequency, the series adds missing
CLKO pieces into clock driver, and initially sets up CLKO with OSC24M
(cko <-- cko2 <-- osc).  Then those board specific CLKO setup for audio
codec can be removed, while it improves the power efficiency@the same
time by saving the use of PLL.

Shawn

Shawn Guo (4):
  ARM: imx6q: add spdif gate clock
  ARM: imx6q: add cko2 clocks
  ARM: imx6q: add the missing cko output selection
  ARM: imx6q: remove board specific CLKO setup

 .../devicetree/bindings/clock/imx6q-clock.txt      |    5 ++
 arch/arm/boot/dts/imx6q-sabrelite.dts              |    2 +-
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi             |    2 +-
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi           |    2 +-
 arch/arm/mach-imx/clk-imx6q.c                      |   30 ++++++++-
 arch/arm/mach-imx/mach-imx6q.c                     |   69 --------------------
 6 files changed, 37 insertions(+), 73 deletions(-)

-- 
1.7.9.5
