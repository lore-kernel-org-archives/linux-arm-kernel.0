From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Thu, 27 Mar 2014 13:23:39 +0100
Subject: [PATCH v3] ata: fix Marvell SATA driver dependencies
Message-ID: <1668037.2oe7J2B7N4@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sata_mv host driver depend on PCI || ARCH_DOVE || ARCH_KIRKWOOD ||
ARCH_MV78XX0 || ARCH_MVEBU || ARCH_ORION5X config options as Marvell
SATA support covers both Marvell PCI devices and Marvell Dove, Kirkwood,
MV78xx0, Armada 370/XP and Orion5x SoCs (for non-PCI devices the driver
to work requires suitable device tree node to be defined).  Additionally
allow the driver build if COMPILE_TEST config option is set.

Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
v3:
- added dependencies for Marvel Dove and MV78xx0 
v2:
- resynced patch with libata/for-3.15 branch (previous patch was against
  libata/for-next branch and SATA_MV selects GENERIC_PHY in that branch)

 drivers/ata/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

Index: b/drivers/ata/Kconfig
===================================================================
--- a/drivers/ata/Kconfig	2014-03-26 17:59:35.000000000 +0100
+++ b/drivers/ata/Kconfig	2014-03-27 13:14:24.097787880 +0100
@@ -281,6 +281,8 @@ config SATA_HIGHBANK
 
 config SATA_MV
 	tristate "Marvell SATA support"
+	depends on PCI || ARCH_DOVE || ARCH_KIRKWOOD || ARCH_MV78XX0 || \
+		   ARCH_MVEBU || ARCH_ORION5X || COMPILE_TEST
 	help
 	  This option enables support for the Marvell Serial ATA family.
 	  Currently supports 88SX[56]0[48][01] PCI(-X) chips,
