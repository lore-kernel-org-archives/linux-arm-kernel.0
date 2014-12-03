From: wens@csie.org (Chen-Yu Tsai)
Date: Wed,  3 Dec 2014 14:35:55 +0800
Subject: [PATCH 00/10] ARM: sun9i: Enable MMC support on Allwinner A80
Message-ID: <1417588565-26215-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

This series enables MMC support on the A80 using existing drivers
we have. The A80 has 4 MMC controllers. These controllers share
a common clock gate and reset control, which are then sub-divided
to each controller.

The phase clocks are the same as the older SoCs, so it should be
straight forward to add them with the rest of the sunxi family.
I did find that Allwinner's kernel uses different delay values
for the A80, but so far I've not run into any issues using the
mainline kernel.

Patch 1 adds module 0 type clock support for the A80. These are
essentially the same as mod0 clocks on other Allwinner SoCs, except
for the wider mux bits.

Patch 2 adds mmc mod clocks to the DTSI.

Patch 3 adds support for the mmc config (term from user manual) clocks.
This is the part that breaks out the clock gates and reset controls
for each controller. This is implemented as a platform driver, as
the shared reset control must be de-asserted for any of either this
or the mmc blocks to work.

Patch 4 adds clock-indices properties to the AHB/APB gate clocks.
This is needed for of_clk_get_parent_name to work properly, as we
use bit indices instead of counting the entries.

Patch 5 adds the mmc config clock nodes to the DTSI.

Patch 6 adds the mmc controller nodes to the DTSI.

Patch 7 and 9 add the pinmux settings for mmc0 and mmc2.

Patch 8 and 10 enable mmc0 and mmc2 on the A80 Optimus Board.

Kudos to Andreas for figuring out all the DT bits. His SoB
is on the relevant patches.


Cheers
ChenYu Tsai


Chen-Yu Tsai (10):
  clk: sunxi: Add module 0 (storage) style clock support for A80
  ARM: dts: sun9i: Add mmc module clock nodes for A80
  clk: sunxi: Add driver for A80 MMC config clocks/resets
  ARM: dts: sun9i: Add clock-indices property for bus gate clocks
  ARM: dts: sun9i: Add mmc config clock nodes
  ARM: dts: sun9i: Add mmc controller nodes to the A80 dtsi
  ARM: dts: sun9i: Add pinmux setting for mmc0
  ARM: dts: sun9i: Enable mmc0 on A80 Optimus Board
  ARM: dts: sun9i: Add pinmux settings for mmc2
  ARM: dts: sun9i: Enable mmc2 on A80 Optimus Board

 Documentation/devicetree/bindings/clock/sunxi.txt |   2 +
 arch/arm/boot/dts/sun9i-a80-optimus.dts           |  33 ++++
 arch/arm/boot/dts/sun9i-a80.dtsi                  | 122 ++++++++++++
 drivers/clk/sunxi/Makefile                        |   1 +
 drivers/clk/sunxi/clk-mod0.c                      |  24 +++
 drivers/clk/sunxi/clk-sun9i-mmc.c                 | 228 ++++++++++++++++++++++
 6 files changed, 410 insertions(+)
 create mode 100644 drivers/clk/sunxi/clk-sun9i-mmc.c

-- 
2.1.3
