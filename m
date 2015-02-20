From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 20 Feb 2015 18:04:19 +0100
Subject: [PATCHv2 00/15] ARM: mvebu: Armada 39x basic support,
 and preparatory cleanups
Message-ID: <1424451874-25375-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is the second version of the patch series adding Armada 39x basic
support.

This set of patches add basic support for a new family of Marvell EBU
processors: the Armada 39x. They are based on Cortex-A9 (like Armada
375 and 38x) and the most important new feature is probably the
addition of 10 GbE support.

See http://www.marvell.com/embedded-processors/armada-39x/ for a basic
introduction.

Note that this web page talks about an Armada 395 and Armada 398, but
so far the technical documentation we have been given access to only
describes Armada 390 and Armada 398, so this series supports only
Armada 390 and Armada 398 so far. Support for Armada 395 might be
added in the future, once we get access to the appropriate technical
details.

Compared to the previous version of this patch series, this version
brings a number of changes:

 - At the SoC level, add the description of SPI controller 0 and 1,
   NAND flash controller, SDHCI controller, Core Divider Clock (needed
   by the NAND flash controller), the main PLL clock (needed by the
   Core Divider Clock) and the XOR engines.

 - At the board level, add the description of the SPI flash connected
   to SPI bus 1, which contains the bootloader, and the description of
   the NAND flash.

 - Fix space vs. tab.

 - Use __initconst when defining the dt_compat table for Armada
   39x. Suggested by Stephen Boyd.

 - Fix typo in commit log of "ARM: mvebu: add core support for Armada
   39x", noticed by Maxime Ripard.

 - Remove earlyprintk from /chosen/bootargs. Suggested by Andrew Lunn.

 - Add aliases for uart[0-3]. Suggested by Andrew Lunn.

 - Add /chosen/stdout-path to Armada 398 DB DT. Suggested by Andrew
   Lunn.

 - Move pinctrl configurations at the SoC level. Suggested by Andrew
   Lunn.

 - Add several preparation/cleanup patches not related to Armada 39x
   directly, but whose topics were found while working on Armada 39x
   support:

     - Add __initconst to all dt_compat table in mach-mvebu.
     - Fixup usb@ unit address on Armada 38x
     - Add stdout-path to all armada-*.dts
     - Use GIC and IRQ macros in SDHCI definition of Armada 38x
     - Add missing UART alias on Armada 38x

This branch is based on mvebu/for-next, and is obviously 3.21
material. Such an early posting is done to gather early review and
feedback. I'll repost an updated version when 3.20-rc1 / 4.0-rc1
lands.

Best regards,

Thomas

Thomas Petazzoni (15):
  ARM: mvebu: add __initconst specifiers on DT_MACHINE_START dt_compat
    tables
  ARM: mvebu: fix usb@ unit address on Armada 38x to match register
    address
  ARM: mvebu: add missing UART alias on Armada 38x
  ARM: mvebu: use IRQ macros to define the SDHCI interrupt on Armada 38x
  ARM: mvebu: add stdout-path to all armada-*.dts
  devicetree: bindings: add DT binding for the Marvell Armada 39x SoC
    family
  devicetree: bindings: update DT bindings for Marvell EBU clock support
  devicetree: bindings: add Device Tree bindings for Armada 39x
    pin-muxing controller
  devicetree: bindings: add new SMP enable method for Marvell Armada 39x
  clk: mvebu: extend common code to allow an optional refclk
  clk: mvebu: add Marvell Armada 39x driver
  pinctrl: mvebu: add pinctrl driver for Marvell Armada 39x
  ARM: mvebu: add core support for Armada 39x
  ARM: mvebu: add Device Tree files for Armada 39x SoC and board
  Documentation: arm: update supported Marvell EBU processors

 Documentation/arm/Marvell/README                   |   5 +
 .../devicetree/bindings/arm/armada-39x.txt         |  20 +
 Documentation/devicetree/bindings/arm/cpus.txt     |   1 +
 .../devicetree/bindings/clock/mvebu-core-clock.txt |   9 +
 .../bindings/clock/mvebu-gated-clock.txt           |  15 +-
 .../pinctrl/marvell,armada-39x-pinctrl.txt         |  78 ++++
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/armada-370-db.dts                |   1 +
 arch/arm/boot/dts/armada-370-mirabox.dts           |   1 +
 arch/arm/boot/dts/armada-370-netgear-rn102.dts     |   1 +
 arch/arm/boot/dts/armada-370-netgear-rn104.dts     |   1 +
 arch/arm/boot/dts/armada-370-rd.dts                |   1 +
 arch/arm/boot/dts/armada-375-db.dts                |   1 +
 arch/arm/boot/dts/armada-388-db.dts                |   3 +-
 arch/arm/boot/dts/armada-388-gp.dts                |   2 +-
 arch/arm/boot/dts/armada-388-rd.dts                |   1 +
 arch/arm/boot/dts/armada-38x.dtsi                  |   6 +-
 .../dts/{armada-xp-matrix.dts => armada-390.dtsi}  |  71 +---
 .../dts/{armada-388-db.dts => armada-398-db.dts}   | 112 ++---
 .../dts/{armada-xp-matrix.dts => armada-398.dtsi}  |  70 +--
 .../boot/dts/{armada-38x.dtsi => armada-39x.dtsi}  | 472 +++++++++------------
 arch/arm/boot/dts/armada-xp-axpwifiap.dts          |   1 +
 arch/arm/boot/dts/armada-xp-db.dts                 |   1 +
 arch/arm/boot/dts/armada-xp-gp.dts                 |   1 +
 arch/arm/boot/dts/armada-xp-matrix.dts             |   1 +
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts     |   1 +
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts   |   1 +
 arch/arm/mach-mvebu/Kconfig                        |  14 +
 arch/arm/mach-mvebu/board-v7.c                     |  20 +-
 arch/arm/mach-mvebu/dove.c                         |   2 +-
 arch/arm/mach-mvebu/kirkwood.c                     |   2 +-
 arch/arm/mach-mvebu/platsmp-a9.c                   |   2 +
 drivers/clk/mvebu/Kconfig                          |   4 +
 drivers/clk/mvebu/Makefile                         |   1 +
 drivers/clk/mvebu/armada-39x.c                     | 156 +++++++
 drivers/clk/mvebu/common.c                         |  17 +
 drivers/clk/mvebu/common.h                         |   1 +
 drivers/pinctrl/mvebu/Kconfig                      |   4 +
 drivers/pinctrl/mvebu/Makefile                     |   1 +
 drivers/pinctrl/mvebu/pinctrl-armada-39x.c         | 432 +++++++++++++++++++
 40 files changed, 1045 insertions(+), 490 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/armada-39x.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,armada-39x-pinctrl.txt
 copy arch/arm/boot/dts/{armada-xp-matrix.dts => armada-390.dtsi} (61%)
 copy arch/arm/boot/dts/{armada-388-db.dts => armada-398-db.dts} (70%)
 copy arch/arm/boot/dts/{armada-xp-matrix.dts => armada-398.dtsi} (61%)
 copy arch/arm/boot/dts/{armada-38x.dtsi => armada-39x.dtsi} (53%)
 create mode 100644 drivers/clk/mvebu/armada-39x.c
 create mode 100644 drivers/pinctrl/mvebu/pinctrl-armada-39x.c

-- 
2.1.0
