From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 18 Dec 2014 15:00:47 +0800
Subject: [PATCH v2 00/11] ARM: sun9i: Enable MMC support on Allwinner A80
Message-ID: <1418886058-8145-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

This is v2 of the sun9i mmc series. It is based on your v2 of your
sunxi mmc phase clocks series. The clock bits will conflict with
Hans' work on the mod0 clock. The DT bits might conflict with your
header conversion series. Assuming this series is OK, how would
you like to proceed?

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

Patch 6 changes sunxi-common-regulators.dtsi to use labels to
reference the pio node.

Patch 7 adds the mmc controller nodes to the DTSI.

Patch 8 and 10 add the pinmux settings for mmc0 and mmc2.

Patch 9 and 11 enable mmc0 and mmc2 on the A80 Optimus Board.

Kudos to Andreas for figuring out all the DT bits. His SoB
is on the relevant patches.

Changes since v1:

  - Use sunxi-common-regulators.dtsi for vmmc regulator
  - Rebased onto sunxi mmc phase clock series v2
  - Use new multi-output mmc module clock style
  - Rename sun9i mmc config clock name and compatible
  - Make mmc2_pins include all pins needed, and change
    name to mmc2_8bit_pins
  - Add spaces between pin names in mmc pins
  - Add clk_prepare_enable()/clk_disable_unprepare() calls to
    reset control ops for the mmc config clock
  - Use DIV_ROUND_UP when calculating number of clocks in sun9i
    mmc config clock probe function
  - Add required properties and outputs section for sun9i mmc
    config clock in bindings doc; also add an example

Cheers
ChenYu Tsai

Chen-Yu Tsai (11):
  clk: sunxi: Add mod0 and mmc module clock support for A80
  ARM: dts: sun9i: Add mmc module clock nodes for A80
  clk: sunxi: Add driver for A80 MMC config clocks/resets
  ARM: dts: sun9i: Add clock-indices property for bus gate clocks
  ARM: dts: sun9i: Add mmc config clock nodes
  ARM: dts: sunxi: Use label to reference pio in sunxi-common-regulators
  ARM: dts: sun9i: Add mmc controller nodes to the A80 dtsi
  ARM: dts: sun9i: Add pinmux setting for mmc0
  ARM: dts: sun9i: Enable mmc0 on A80 Optimus Board
  ARM: dts: sun9i: Add 8 bit mmc pinmux setting for mmc2
  ARM: dts: sun9i: Enable mmc2 on A80 Optimus Board

 Documentation/devicetree/bindings/clock/sunxi.txt |  30 ++-
 arch/arm/boot/dts/sun9i-a80-optimus.dts           |  27 +++
 arch/arm/boot/dts/sun9i-a80.dtsi                  | 124 ++++++++++++
 arch/arm/boot/dts/sunxi-common-regulators.dtsi    |  54 +++---
 drivers/clk/sunxi/Makefile                        |   1 +
 drivers/clk/sunxi/clk-mod0.c                      |  99 ++++++++++
 drivers/clk/sunxi/clk-sun9i-mmc.c                 | 222 ++++++++++++++++++++++
 7 files changed, 527 insertions(+), 30 deletions(-)
 create mode 100644 drivers/clk/sunxi/clk-sun9i-mmc.c

-- 
2.1.3
