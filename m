From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 15 May 2013 15:36:53 +0200
Subject: [PATCHv4 0/9] Use the mvebu PCIe driver on Kirkwood
Message-ID: <1368625022-25243-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Here is a set of patches that migrates adds support for Kirkwood
platforms to use the mvebu PCIe driver. All the Kirkwood platforms
that have already been converted to the Device Tree are converted to
use the new driver, and the DB-88F6281/DB-88F6282 evaluation board
from Marvell is also converted to the Device Tree and the usage of the
new PCIe driver.

Only non-DT platforms continue to use the legacy code in
arch/arm/mach-kirkwood/pcie.c.

This branch depends on the mvebu-pcie driver. I have pushed this
branch to the following Git repository for easier testing:

  https://github.com/MISL-EBU-System-SW/mainline-public/tree/kirkwood-pcie-dt-v4

# /usr/sbin/lspci
00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 7846
00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 7846
01:00.0 SCSI storage controller: Marvell Technology Group Ltd. 88SX7042 PCI-e 4-port SATA-II (rev 02)
02:00.0 Ethernet controller: Intel Corporation 82572EI Gigabit Ethernet Controller (Copper) (rev 06)

I've tested both the e1000e NIC card and the SATA 4 ports card and
they work fine.

Changes between v3 and v4:

 * Rebase on top of 3.10-rc1.

 * Change the name of the file and Kconfig options related to the
   DB-88F6281/DB-88F6282 board to use DB-88F628x, since it handles in
   fact two different boards using two slightly different SoCs.

Changes between v2 and v3:

 * Integrate a replacement patch from Andrew Lunn for the QNAP changes
   after he tested on his platforms.

 * Add Andrew Lunn Tested-by tags on the appropriate patches.

Changes between v1 and v2:

 * Remove the 'needs_pcie_win' logic, and instead move the static
   initialization of PCIe windows into the legacy PCIe code, for the
   platforms that will still be using it. Platforms that will use the
   new PCIe driver benefit directly from dynamic allocation of PCIe
   windows.

 * Move the PCIe interface definitions from kirkwood.dtsi to
   kirkwood-6281.dtsi and kirkwood-6282.dtsi to take into account the
   fact that the 6281 has one PCIe interface, and the 6282 has two of
   them.

 * Convert all DT-platforms that were initializing PCIe using the
   legacy driver to use the DT to initialize the PCIe interface. This
   includes the Iomega Iconnect, the MPL CEC4, the ZyXEL NSA310and the
   QNAP TS219.

 * Fix the conversion to the Device Tree of the DB-88F6181/6282
   board. We now have two Device Trees, one for the 6281 variant of
   the board (one PCIe interface) and another for the 6282 variant of
   the board (two PCIe interfaces).

 * Update the defconfig with PCIe driver enabled and some board
   updates.

Best regards,

Thomas

Thomas Petazzoni (9):
  pci: mvebu: enable driver usage on Kirkwood
  arm: kirkwood: move PCIe window init to legacy driver
  arm: kirkwood: add SoC-level Device Tree data for PCIe interfaces
  arm: kirkwood: convert Iomega Iconnect to use DT for the PCIe
    interface
  arm: kirkwood: convert MPL CEC4 to use DT for the PCIe interface
  arm: kirkwood: convert ZyXEL NSA310 to use DT for the PCIe interface
  arm: kirkwood: convert QNAP TS219 to use DT for the PCIe interface
  arm: kirkwood: convert db-88f6281/db-88f6282 to the Device Tree
  arm: kirkwood: update defconfig with PCIe driver and board updates

 .../devicetree/bindings/pci/mvebu-pci.txt          |    1 +
 arch/arm/boot/dts/Makefile                         |    2 +
 arch/arm/boot/dts/kirkwood-6281.dtsi               |   31 ++++++
 arch/arm/boot/dts/kirkwood-6282.dtsi               |   48 +++++++++
 arch/arm/boot/dts/kirkwood-db-88f6281.dts          |   30 ++++++
 arch/arm/boot/dts/kirkwood-db-88f6282.dts          |   34 ++++++
 arch/arm/boot/dts/kirkwood-db.dtsi                 |   89 ++++++++++++++++
 arch/arm/boot/dts/kirkwood-iconnect.dts            |    8 ++
 arch/arm/boot/dts/kirkwood-mplcec4.dts             |    8 ++
 arch/arm/boot/dts/kirkwood-nsa310.dts              |    8 ++
 arch/arm/boot/dts/kirkwood-ts219-6281.dts          |    3 +-
 arch/arm/boot/dts/kirkwood-ts219-6282.dts          |    3 +-
 arch/arm/boot/dts/kirkwood-ts219.dtsi              |    9 +-
 arch/arm/boot/dts/kirkwood.dtsi                    |    1 +
 arch/arm/configs/kirkwood_defconfig                |    2 +
 arch/arm/mach-kirkwood/Kconfig                     |   21 ++--
 arch/arm/mach-kirkwood/Makefile                    |    3 +-
 arch/arm/mach-kirkwood/board-db88f628x-bp.c        |   24 +++++
 arch/arm/mach-kirkwood/board-dt.c                  |    6 ++
 arch/arm/mach-kirkwood/board-iconnect.c            |    8 --
 arch/arm/mach-kirkwood/board-mplcec4.c             |    1 -
 arch/arm/mach-kirkwood/board-nsa310.c              |   25 -----
 arch/arm/mach-kirkwood/board-ts219.c               |   10 --
 arch/arm/mach-kirkwood/common.c                    |   24 -----
 arch/arm/mach-kirkwood/common.h                    |    6 ++
 arch/arm/mach-kirkwood/db88f6281-bp-setup.c        |  108 --------------------
 arch/arm/mach-kirkwood/pcie.c                      |   22 ++++
 drivers/pci/host/Kconfig                           |    2 +-
 drivers/pci/host/pci-mvebu.c                       |    1 +
 29 files changed, 341 insertions(+), 197 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-db-88f6281.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-db-88f6282.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-db.dtsi
 create mode 100644 arch/arm/mach-kirkwood/board-db88f628x-bp.c
 delete mode 100644 arch/arm/mach-kirkwood/board-nsa310.c
 delete mode 100644 arch/arm/mach-kirkwood/db88f6281-bp-setup.c

-- 
1.7.9.5
