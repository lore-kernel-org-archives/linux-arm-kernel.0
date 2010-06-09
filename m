From: milinevskyy@gmail.com (Dmytro Milinevskyy)
Date: Wed, 09 Jun 2010 23:14:39 +0300
Subject: [PATCH] Marvell OpenRD-Ultimate machine support
Message-ID: <4c0ff6b2.0c3ddf0a.2185.2e09@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!
This patch adds support for the OpenRD Ultimate machine(could be found at http://www.arm.linux.org.uk/developer/machines/list.php?id=2884)

Besides adding machine description this patch adds correction for PHY address for Ultimate version.

Differences from the previous attempt:
 - Applied suggestion from Lennert Buytenhek to change PHY addresses in instances of mv643xx_eth_platform_data in case of ultimate version.

Regards,

-- Dmytro Milinevskyy


Signed-off-by: Dmytro Milinevskyy <milinevskyy@gmail.com>
---
 arch/arm/mach-kirkwood/Kconfig        |    7 +++++++
 arch/arm/mach-kirkwood/openrd-setup.c |   28 +++++++++++++++++++++++++---
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index 29b2163..110a3b8 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -75,6 +75,13 @@ config MACH_OPENRD_CLIENT
 	  Say 'Y' here if you want your kernel to support the
 	  Marvell OpenRD Client Board.
 
+config MACH_OPENRD_ULTIMATE
+	bool "Marvell OpenRD Ultimate Board"
+	select MACH_OPENRD
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  Marvell OpenRD Ultimate Board.
+
 config MACH_NETSPACE_V2
 	bool "LaCie Network Space v2 NAS Board"
 	help
diff --git a/arch/arm/mach-kirkwood/openrd-setup.c b/arch/arm/mach-kirkwood/openrd-setup.c
index ad3f1ec..81b330d 100644
--- a/arch/arm/mach-kirkwood/openrd-setup.c
+++ b/arch/arm/mach-kirkwood/openrd-setup.c
@@ -1,7 +1,7 @@
 /*
  * arch/arm/mach-kirkwood/openrd-setup.c
  *
- * Marvell OpenRD (Base|Client) Board Setup
+ * Marvell OpenRD (Base|Client|Ultimate) Board Setup
  *
  * This file is licensed under the terms of the GNU General Public
  * License version 2.  This program is licensed "as is" without any
@@ -73,9 +73,16 @@ static void __init openrd_init(void)
 
 	kirkwood_ehci_init();
 
+	if (machine_is_openrd_ultimate()) {
+		openrd_ge00_data.phy = 0;
+		openrd_ge01_data.phy = 1;
+	}
+
 	kirkwood_ge00_init(&openrd_ge00_data);
-	if (machine_is_openrd_client())
+	if (machine_is_openrd_client() ||
+		machine_is_openrd_ultimate())
 		kirkwood_ge01_init(&openrd_ge01_data);
+
 	kirkwood_sata_init(&openrd_sata_data);
 	kirkwood_sdio_init(&openrd_mvsdio_data);
 
@@ -84,7 +91,9 @@ static void __init openrd_init(void)
 
 static int __init openrd_pci_init(void)
 {
-	if (machine_is_openrd_base() || machine_is_openrd_client())
+	if (machine_is_openrd_base() ||
+		machine_is_openrd_client() ||
+		machine_is_openrd_ultimate())
 		kirkwood_pcie_init();
 
 	return 0;
@@ -116,3 +125,16 @@ MACHINE_START(OPENRD_CLIENT, "Marvell OpenRD Client Board")
 	.timer		= &kirkwood_timer,
 MACHINE_END
 #endif
+
+#ifdef CONFIG_MACH_OPENRD_ULTIMATE
+MACHINE_START(OPENRD_ULTIMATE, "Marvell OpenRD Ultimate Board")
+	/* Maintainer: Dhaval Vasa <dhaval.vasa@einfochips.com> */
+	.phys_io	= KIRKWOOD_REGS_PHYS_BASE,
+	.io_pg_offst	= ((KIRKWOOD_REGS_VIRT_BASE) >> 18) & 0xfffc,
+	.boot_params	= 0x00000100,
+	.init_machine	= openrd_init,
+	.map_io		= kirkwood_map_io,
+	.init_irq	= kirkwood_init_irq,
+	.timer		= &kirkwood_timer,
+MACHINE_END
+#endif
-- 
1.7.1
