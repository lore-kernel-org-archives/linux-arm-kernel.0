From: wens@csie.org (Chen-Yu Tsai)
Date: Mon,  1 Feb 2016 22:42:47 +0800
Subject: [PATCH 0/2] clk: sunxi: Fix APBS clock for Allwinner A80
Message-ID: <1454337769-4130-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

When I did the A80 PRCM support, I failed to notice the A80's APBS clock
was not the same as the A23's APB0 clock. The former is a zero-based
divider, while the latter is a power-of-two divider. But the lowest 2
dividers are the same.

The hardware defaults to the lowest setting, or a /1 divider. Since the
child gates do not propagate clk_set_rate up, and no consumers here do
clk_set_rate, this actually works.

I realized my mistake while reviewing the A83T's PRCM patches. The A83T
shares the same PRCM clocks as the A80.


Regards
ChenYu


Chen-Yu Tsai (2):
  clk: sunxi: Add support for A80 APBS clock
  ARM: dts: sun9i: Fix apbs clock compatible

 Documentation/devicetree/bindings/clock/sunxi.txt |  1 +
 arch/arm/boot/dts/sun9i-a80.dtsi                  |  2 +-
 drivers/clk/sunxi/Makefile                        |  2 +-
 drivers/clk/sunxi/clk-sun9i-apbs.c                | 64 +++++++++++++++++++++++
 4 files changed, 67 insertions(+), 2 deletions(-)
 create mode 100644 drivers/clk/sunxi/clk-sun9i-apbs.c

-- 
2.7.0
