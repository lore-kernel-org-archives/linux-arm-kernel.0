From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 12 Feb 2016 17:31:13 +0800
Subject: [PATCH v2 0/2] clk: sunxi: Fix APBS clock for Allwinner A80
Message-ID: <1455269475-8180-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This is v2 of the A80 APBS clock fixes series.

When I did the A80 PRCM support, I failed to notice the A80's APBS clock
was not the same as the A23's APB0 clock. The former is a zero-based
divider, while the latter is a power-of-two divider. But the lowest 2
dividers are the same.

The hardware defaults to the lowest setting, or a /1 divider. Since the
child gates do not propagate clk_set_rate up, and no consumers here do
clk_set_rate, this actually works.

I realized my mistake while reviewing the A83T's PRCM patches. The A83T
shares the same PRCM clocks as the A80.

Maxime, since this was introduced in 4.5-rc1, please apply this series
for 4.5 so we fix it before the release.


Changes since v1:

  - Replace the CLK_OF_DECLARE version of sun8i-a23-apb0-clk with the
    A80 APBS version, instead of writing a new driver.

Regards
ChenYu


Chen-Yu Tsai (2):
  clk: sunxi: Add support for A80 APBS clock
  ARM: dts: sun9i: Fix apbs clock compatible

 Documentation/devicetree/bindings/clock/sunxi.txt |  1 +
 arch/arm/boot/dts/sun9i-a80.dtsi                  |  2 +-
 drivers/clk/sunxi/clk-sun8i-apb0.c                | 23 ++++++++---------------
 3 files changed, 10 insertions(+), 16 deletions(-)

-- 
2.7.0
