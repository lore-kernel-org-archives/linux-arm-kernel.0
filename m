From: andrew@lunn.ch (Andrew Lunn)
Date: Fri,  7 Feb 2014 00:41:59 +0100
Subject: [PATCH 03/21] ARM: Kirkwood: Convert mv88f6281gtw_ge switch setup to
 DT
In-Reply-To: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
References: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
Message-ID: <1391730137-14814-4-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mv88f6281gtw_ge has a ethernet switch connected to the ethernet
port of the SoC. Convert the platform device instantiationn to a DT
instantiation.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/mach-kirkwood/Kconfig                 |  7 ----
 arch/arm/mach-kirkwood/Makefile                |  1 -
 arch/arm/mach-kirkwood/Module.symvers          |  0
 arch/arm/mach-kirkwood/board-dt.c              |  3 --
 arch/arm/mach-kirkwood/board-mv88f6281gtw_ge.c | 50 --------------------------
 arch/arm/mach-kirkwood/common.h                |  7 ----
 6 files changed, 68 deletions(-)
 create mode 100644 arch/arm/mach-kirkwood/Module.symvers
 delete mode 100644 arch/arm/mach-kirkwood/board-mv88f6281gtw_ge.c

diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index fe8319ad3158..df4b26340ae4 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -106,13 +106,6 @@ config ARCH_KIRKWOOD_DT
 	  Say 'Y' here if you want your kernel to support the
 	  Marvell Kirkwood using flattened device tree.
 
-config MACH_MV88F6281GTW_GE_DT
-	bool "Marvell 88F6281 GTW GE Board (Flattened Device Tree)"
-	depends on ARCH_KIRKWOOD_DT
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  Marvell 88F6281 GTW GE Board (Flattened Device Tree).
-
 endmenu
 
 endif
diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
index 144b51102939..dc22bf5b21ed 100644
--- a/arch/arm/mach-kirkwood/Makefile
+++ b/arch/arm/mach-kirkwood/Makefile
@@ -13,4 +13,3 @@ obj-$(CONFIG_MACH_TS219)		+= ts219-setup.o tsx1x-common.o
 obj-$(CONFIG_MACH_TS41X)		+= ts41x-setup.o tsx1x-common.o
 
 obj-$(CONFIG_ARCH_KIRKWOOD_DT)		+= board-dt.o
-obj-$(CONFIG_MACH_MV88F6281GTW_GE_DT)	+= board-mv88f6281gtw_ge.o
diff --git a/arch/arm/mach-kirkwood/Module.symvers b/arch/arm/mach-kirkwood/Module.symvers
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index ceffdc8ffbbd..e74b31aa9736 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -131,9 +131,6 @@ static void __init kirkwood_dt_init(void)
 	kexec_reinit = kirkwood_enable_pcie;
 #endif
 
-	if (of_machine_is_compatible("marvell,mv88f6281gtw-ge"))
-		mv88f6281gtw_ge_init();
-
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
diff --git a/arch/arm/mach-kirkwood/board-mv88f6281gtw_ge.c b/arch/arm/mach-kirkwood/board-mv88f6281gtw_ge.c
deleted file mode 100644
index ee5eea678c11..000000000000
--- a/arch/arm/mach-kirkwood/board-mv88f6281gtw_ge.c
+++ /dev/null
@@ -1,50 +0,0 @@
-/*
- * arch/arm/mach-kirkwood/board-mv88f6281gtw_ge.c
- *
- * Marvell 88F6281 GTW GE Board Setup
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/irq.h>
-#include <linux/timer.h>
-#include <linux/mv643xx_eth.h>
-#include <linux/ethtool.h>
-#include <linux/gpio.h>
-#include <net/dsa.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/pci.h>
-#include <mach/kirkwood.h>
-#include "common.h"
-
-static struct mv643xx_eth_platform_data mv88f6281gtw_ge_ge00_data = {
-	.phy_addr	= MV643XX_ETH_PHY_NONE,
-	.speed		= SPEED_1000,
-	.duplex		= DUPLEX_FULL,
-};
-
-static struct dsa_chip_data mv88f6281gtw_ge_switch_chip_data = {
-	.port_names[0]	= "lan1",
-	.port_names[1]	= "lan2",
-	.port_names[2]	= "lan3",
-	.port_names[3]	= "lan4",
-	.port_names[4]	= "wan",
-	.port_names[5]	= "cpu",
-};
-
-static struct dsa_platform_data mv88f6281gtw_ge_switch_plat_data = {
-	.nr_chips	= 1,
-	.chip		= &mv88f6281gtw_ge_switch_chip_data,
-};
-
-void __init mv88f6281gtw_ge_init(void)
-{
-	kirkwood_ge00_init(&mv88f6281gtw_ge_ge00_data);
-	kirkwood_ge00_switch_init(&mv88f6281gtw_ge_switch_plat_data, NO_IRQ);
-}
diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
index 1296de94febf..832a4e2ab8d7 100644
--- a/arch/arm/mach-kirkwood/common.h
+++ b/arch/arm/mach-kirkwood/common.h
@@ -58,13 +58,6 @@ void kirkwood_cpufreq_init(void);
 void kirkwood_restart(enum reboot_mode, const char *);
 void kirkwood_clk_init(void);
 
-/* board init functions for boards not fully converted to fdt */
-#ifdef CONFIG_MACH_MV88F6281GTW_GE_DT
-void mv88f6281gtw_ge_init(void);
-#else
-static inline void mv88f6281gtw_ge_init(void) {};
-#endif
-
 /* early init functions not converted to fdt yet */
 char *kirkwood_id(void);
 void kirkwood_l2_init(void);
-- 
1.8.5.3
