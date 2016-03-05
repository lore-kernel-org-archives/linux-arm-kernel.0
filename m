From: vishnupatekar0510@gmail.com (Vishnu Patekar)
Date: Sat,  5 Mar 2016 23:42:53 +0800
Subject: [PATCH v3 00/13] Add A83T clk, r_pio, mmc rsb support
Message-ID: <1457192586-25596-1-git-send-email-vishnupatekar0510@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,
This is v3 of series which adds further support for A83T, mainly adds clock 
support.Also adds R_PIO, PRCM related clocks, mmc, rsb support.

A83T difference in short:
R_PIO is slightly different from A23 r_pio. AHB1 has different parents as
compared to a31-ahb1, APB1 has different dividers.Bus gates are similar to H3,
apb0 gates are different.mmc and rsb are compatible with earlier sunxi socs.

These patches are based on Maxime's sunxi/for-next branch.
https://git.kernel.org/cgit/linux/kernel/git/mripard/linux.git/

v2->v3 Changes:
1. Corrected wrong configuration of uart0 and timer in dtsi.
2. corrected clock gate name of "spdif" in dtsi.
3. Added kconfig for sunxi clocks, added sun8i-apb0 and sun9i-cpus clocks to it.

v1->v2 Changes:
1. Patches for apb0 gates clock, bus gates, low speed oscillators are already
   merged, so, not included again in this series.
1. sorted the R_PIO Kconfig options.
2. removed un-necessary a83t apb1 div table.
3. combined the three ahb reset registers into one reset node.
4. Changed the bus gates names to bus_spidf and bus_usb_otg.
5. removed un-necessary #address-cells and #size-cells from R_PIO node.
6. splited rsb pins and rsb controller nodes in different patches.
7. used PF6 as mmc0 CD reference design pin.
8. corrected the style related errors.

Patch 1: adds support for r_pio pin controller.

patch 2: adds ahb1 clock support, 0b1x is pll6 parent otherwise it's same as a31
ahb1.

patch 3: adds apb1 clock support, apb1 has different dividers compared to a10 
apb0 clock.

patch 4: adds basics clocks nodes to dtsi, pll6, ahb1, ahb2, apb1, apb2,
bus gates, and resets.

patch 5-6: adds mmc and it's clock nodes.

patch 7: adds A83T PRCM related clocks, clock resets.

patch 8: adds r_pio pin controller nodes to dtsi

patch 9: adds RSB controller nodes to dtsi

patch 10: adds common MMC CD detect pin as reference design pin 

patch 11: enables mmc0 support for h8homlet board, tested by LABBE Corentin.

patch 12: This patch adds support for Sinovoip BPI-M3 A83T based board, it has 
2GB LPDDR3, u-boot support is added recently for this board.

patch 13: Adds kconfig for clocks(sun8i-apb0 and sun9i-cpus).


Vishnu Patekar (13):
  pinctrl: sunxi: Add A83T R_PIO controller support
  clk: sunxi: add ahb1 clock for A83T
  clk: sunxi: Add APB1 clock for A83T
  ARM: dts: sun8i-a83t: Add basic clocks and resets
  ARM: dts: sun8i-a83t: add mmc clock nodes
  ARM: dts: sun8i-a83t: Add mmc controller nodes
  ARM: dts: sun8i-a83t: Add PRCM related clocks and resets
  ARM: dts: sun8i-a83t: Add R_PIO controller node to the dtsi
  ARM: dts: sun8i-a83t: Add RSB controller device node to dtsi
  ARM: dts: sun8i-a83t: add mmc0 CD pin
  ARM: dts: sun8i: enable mmc for H8Homlet Board.
  ARM: dts: sun8i: Add A83T based Sinovoip Bpi-M3 Board
  ARM: sunxi: Add Kconfig for sunxi clocks

 Documentation/devicetree/bindings/clock/sunxi.txt  |   2 +
 .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 .../boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts  |  11 +
 ...omlet-v2.dts => sun8i-a83t-sinovoip-bpi-m3.dts} |  21 +-
 arch/arm/boot/dts/sun8i-a83t.dtsi                  | 285 ++++++++++++++++++++-
 drivers/clk/Kconfig                                |   1 +
 drivers/clk/sunxi/Kconfig                          |   5 +
 drivers/clk/sunxi/Makefile                         |   4 +-
 drivers/clk/sunxi/clk-sunxi.c                      |  89 +++++++
 drivers/pinctrl/sunxi/Kconfig                      |   5 +
 drivers/pinctrl/sunxi/Makefile                     |   1 +
 drivers/pinctrl/sunxi/pinctrl-sun8i-a83t-r.c       | 119 +++++++++
 13 files changed, 538 insertions(+), 7 deletions(-)
 copy arch/arm/boot/dts/{sun8i-a83t-allwinner-h8homlet-v2.dts => sun8i-a83t-sinovoip-bpi-m3.dts} (83%)
 create mode 100644 drivers/clk/sunxi/Kconfig
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun8i-a83t-r.c

-- 
1.9.1
