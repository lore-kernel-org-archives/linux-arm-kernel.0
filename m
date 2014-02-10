From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 10 Feb 2014 18:23:11 +0100
Subject: [PATCH 00/11] Core support for Marvell Armada 375 and 38x
Message-ID: <1392053002-19831-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason, Andrew, Sebastian, Gregory,

Here is a set of 11 patches that add minimal support for the new
Marvell Armada 375 and 38x SoCs. The Armada 375 has already been
announced a few months ago by Marvell, and a product brief is
available at
http://www.marvell.com/embedded-processors/armada-375/. As far as I
know, the Armada 380 and 385 have not yet been announced, but we
already have working kernel support for them.

Essentially, the Armada 375 is a dual-core Cortex-A9, which re-uses
most of the IP blocks of the Armada XP, except for the network unit
and core parts of the SoC, such as the interrupt controller or cache
controller (GIC and PL310 are used). They also added an XHCI USB 3.0
controller.

The Armada 380 and 385 also use Cortex-A9 CPU cores (single core for
the 380 and dual-core for the 385), but move a little further away
than 375 in terms of peripherals: an AHCI-compatible SATA interface, a
different MMC/SDIO interface, etc.

This set of patches only add minimal support for these SOCs, as well
as support for the peripherals for which no driver changes are
needed. We therefore have support for:

 * Device Bus
 * Clocks
 * Interrupt controllers: GIC and MPIC
 * GPIO controllers
 * I2C buses
 * SPI buses
 * L2 cache
 * MBus controller
 * SDIO (for Armada 375 only)
 * Pinctrl
 * SATA (for Armada 375 only)
 * Serial
 * System controller
 * XOR engines
 * PCIe controllers
 * Network (for Armada 38x only)

Some of these features require patches to other subsystems, and the
patches are being sent to the respective maintainers currently: clock
driver patches, pinctrl driver patches, irqchip driver patches, mbus
driver patches, etc. There is however no build dependency between the
arch/arm/mach-mvebu/ code and those other patches.

We aim at getting this minimal support merged for 3.15.

We have already working code for many more features, such as SMP,
coherency support, NAND, SATA and SDIO for Armada 380, etc. We will be
sending those additional features once the basic support has been
merged.

It is worth noting that contrary to the Marvell 370 and XP support,
which has been pushed mainline fairly late in the development cycle of
the SOCs, the support for Armada 375 and 38x is now being pushed quite
early in the development cycle of the SOCs. We are having mainline
support pretty much at the same time as the SOCs are being made
available to customers, which is really great!

Best regards,

Thomas

Gregory CLEMENT (2):
  ARM: mvebu: add initial support for the Armada 375 SOCs
  ARM: mvebu: add Device Tree description of the Armada 375 SoC

Thomas Petazzoni (9):
  ARM: mvebu: add Armada 375 support to the system-controller driver
  ARM: mvebu: add workaround for data abort issue on Armada 375
  ARM: mvebu: add Device Tree for the Armada 375 DB board
  ARM: mvebu: add Armada 380/385 support to the system-controller driver
  ARM: mvebu: add initial support for the Armada 380/385 SOCs
  ARM: mvebu: add Device Tree description of the Armada 380/385 SoCs
  ARM: mvebu: add Device Tree for the Armada 385 DB board
  ARM: mvebu: update defconfigs for Armada 375 and 38x
  Documentation: arm: update Marvell documentation about Armada 375/38x

 Documentation/arm/Marvell/README                   |  12 +-
 .../devicetree/bindings/arm/armada-375.txt         |   9 +
 .../devicetree/bindings/arm/armada-38x.txt         |  10 +
 .../bindings/arm/mvebu-system-controller.txt       |   4 +-
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/armada-375-db.dts                | 106 +++++
 arch/arm/boot/dts/armada-375.dtsi                  | 439 +++++++++++++++++++++
 arch/arm/boot/dts/armada-380.dtsi                  | 117 ++++++
 arch/arm/boot/dts/armada-385-db.dts                | 101 +++++
 arch/arm/boot/dts/armada-385.dtsi                  | 149 +++++++
 arch/arm/boot/dts/armada-38x.dtsi                  | 339 ++++++++++++++++
 arch/arm/configs/multi_v7_defconfig                |   2 +
 arch/arm/configs/mvebu_defconfig                   |   2 +
 arch/arm/mach-mvebu/Kconfig                        |  30 ++
 arch/arm/mach-mvebu/Makefile                       |   2 +
 arch/arm/mach-mvebu/armada-375.c                   |  67 ++++
 arch/arm/mach-mvebu/armada-38x.c                   |  42 ++
 arch/arm/mach-mvebu/system-controller.c            |  22 +-
 18 files changed, 1451 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/armada-375.txt
 create mode 100644 Documentation/devicetree/bindings/arm/armada-38x.txt
 create mode 100644 arch/arm/boot/dts/armada-375-db.dts
 create mode 100644 arch/arm/boot/dts/armada-375.dtsi
 create mode 100644 arch/arm/boot/dts/armada-380.dtsi
 create mode 100644 arch/arm/boot/dts/armada-385-db.dts
 create mode 100644 arch/arm/boot/dts/armada-385.dtsi
 create mode 100644 arch/arm/boot/dts/armada-38x.dtsi
 create mode 100644 arch/arm/mach-mvebu/armada-375.c
 create mode 100644 arch/arm/mach-mvebu/armada-38x.c

-- 
1.8.3.2
