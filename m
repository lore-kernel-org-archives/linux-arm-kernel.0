From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu,  1 Aug 2013 10:45:33 +0200
Subject: [PATCH 4/9] ARM: kirkwood: remove support for legacy booting of
 Sheevaplug
In-Reply-To: <1375346738-21596-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1375346738-21596-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1375346738-21596-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Kirkwood Sheevaplug platform has already been converted to the
Device Tree, so we can remove the legacy booting option for this
platform.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-kirkwood/Kconfig            |  12 ---
 arch/arm/mach-kirkwood/Makefile           |   2 -
 arch/arm/mach-kirkwood/sheevaplug-setup.c | 161 ------------------------------
 3 files changed, 175 deletions(-)
 delete mode 100644 arch/arm/mach-kirkwood/sheevaplug-setup.c

diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index 9aad378..4f881b8 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -2,12 +2,6 @@ if ARCH_KIRKWOOD
 
 menu "Marvell Kirkwood Implementations"
 
-config MACH_ESATA_SHEEVAPLUG
-	bool "Marvell eSATA SheevaPlug Reference Board"
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  Marvell eSATA SheevaPlug Reference Board.
-
 config MACH_INETSPACE_V2
 	bool "LaCie Internet Space v2 NAS Board"
 	help
@@ -80,12 +74,6 @@ config MACH_RD88F6281
 	  Say 'Y' here if you want your kernel to support the
 	  Marvell RD-88F6281 Reference Board.
 
-config MACH_SHEEVAPLUG
-	bool "Marvell SheevaPlug Reference Board"
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  Marvell SheevaPlug Reference Board.
-
 config MACH_T5325
 	bool "HP t5325 Thin Client"
 	help
diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
index c3ccbf7..9b25ec3 100644
--- a/arch/arm/mach-kirkwood/Makefile
+++ b/arch/arm/mach-kirkwood/Makefile
@@ -1,6 +1,5 @@
 obj-y				+= common.o irq.o pcie.o mpp.o
 
-obj-$(CONFIG_MACH_ESATA_SHEEVAPLUG)	+= sheevaplug-setup.o
 obj-$(CONFIG_MACH_INETSPACE_V2)		+= netspace_v2-setup.o lacie_v2-common.o
 obj-$(CONFIG_MACH_MV88F6281GTW_GE)	+= mv88f6281gtw_ge-setup.o
 obj-$(CONFIG_MACH_NET2BIG_V2)		+= netxbig_v2-setup.o lacie_v2-common.o
@@ -10,7 +9,6 @@ obj-$(CONFIG_MACH_NETSPACE_V2)		+= netspace_v2-setup.o lacie_v2-common.o
 obj-$(CONFIG_MACH_OPENRD)		+= openrd-setup.o
 obj-$(CONFIG_MACH_RD88F6192_NAS)	+= rd88f6192-nas-setup.o
 obj-$(CONFIG_MACH_RD88F6281)		+= rd88f6281-setup.o
-obj-$(CONFIG_MACH_SHEEVAPLUG)		+= sheevaplug-setup.o
 obj-$(CONFIG_MACH_T5325)		+= t5325-setup.o
 obj-$(CONFIG_MACH_TS219)		+= ts219-setup.o tsx1x-common.o
 obj-$(CONFIG_MACH_TS41X)		+= ts41x-setup.o tsx1x-common.o
diff --git a/arch/arm/mach-kirkwood/sheevaplug-setup.c b/arch/arm/mach-kirkwood/sheevaplug-setup.c
deleted file mode 100644
index 55b68fa..0000000
--- a/arch/arm/mach-kirkwood/sheevaplug-setup.c
+++ /dev/null
@@ -1,161 +0,0 @@
-/*
- * arch/arm/mach-kirkwood/sheevaplug-setup.c
- *
- * Marvell SheevaPlug Reference Board Setup
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/ata_platform.h>
-#include <linux/mtd/partitions.h>
-#include <linux/mv643xx_eth.h>
-#include <linux/gpio.h>
-#include <linux/leds.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <mach/kirkwood.h>
-#include <linux/platform_data/mmc-mvsdio.h>
-#include "common.h"
-#include "mpp.h"
-
-static struct mtd_partition sheevaplug_nand_parts[] = {
-	{
-		.name = "u-boot",
-		.offset = 0,
-		.size = SZ_1M
-	}, {
-		.name = "uImage",
-		.offset = MTDPART_OFS_NXTBLK,
-		.size = SZ_4M
-	}, {
-		.name = "root",
-		.offset = MTDPART_OFS_NXTBLK,
-		.size = MTDPART_SIZ_FULL
-	},
-};
-
-static struct mv643xx_eth_platform_data sheevaplug_ge00_data = {
-	.phy_addr	= MV643XX_ETH_PHY_ADDR(0),
-};
-
-static struct mv_sata_platform_data sheeva_esata_sata_data = {
-	.n_ports	= 2,
-};
-
-static struct mvsdio_platform_data sheevaplug_mvsdio_data = {
-	/* unfortunately the CD signal has not been connected */
-};
-
-static struct mvsdio_platform_data sheeva_esata_mvsdio_data = {
-	.gpio_write_protect = 44, /* MPP44 used as SD write protect */
-	.gpio_card_detect = 47,	  /* MPP47 used as SD card detect */
-};
-
-static struct gpio_led sheevaplug_led_pins[] = {
-	{
-		.name			= "plug:red:misc",
-		.default_trigger	= "none",
-		.gpio			= 46,
-		.active_low		= 1,
-	},
-	{
-		.name			= "plug:green:health",
-		.default_trigger	= "default-on",
-		.gpio			= 49,
-		.active_low		= 1,
-	},
-};
-
-static struct gpio_led_platform_data sheevaplug_led_data = {
-	.leds		= sheevaplug_led_pins,
-	.num_leds	= ARRAY_SIZE(sheevaplug_led_pins),
-};
-
-static struct platform_device sheevaplug_leds = {
-	.name	= "leds-gpio",
-	.id	= -1,
-	.dev	= {
-		.platform_data	= &sheevaplug_led_data,
-	}
-};
-
-static unsigned int sheevaplug_mpp_config[] __initdata = {
-	MPP29_GPIO,	/* USB Power Enable */
-	MPP46_GPIO,	/* LED Red */
-	MPP49_GPIO,	/* LED */
-	0
-};
-
-static unsigned int sheeva_esata_mpp_config[] __initdata = {
-	MPP29_GPIO,	/* USB Power Enable */
-	MPP44_GPIO,	/* SD Write Protect */
-	MPP47_GPIO,	/* SD Card Detect */
-	MPP49_GPIO,	/* LED Green */
-	0
-};
-
-static void __init sheevaplug_init(void)
-{
-	/*
-	 * Basic setup. Needs to be called early.
-	 */
-	kirkwood_init();
-
-	/* setup gpio pin select */
-	if (machine_is_esata_sheevaplug())
-		kirkwood_mpp_conf(sheeva_esata_mpp_config);
-	else
-		kirkwood_mpp_conf(sheevaplug_mpp_config);
-
-	kirkwood_uart0_init();
-	kirkwood_nand_init(ARRAY_AND_SIZE(sheevaplug_nand_parts), 25);
-
-	if (gpio_request(29, "USB Power Enable") != 0 ||
-	    gpio_direction_output(29, 1) != 0)
-		pr_err("can't set up GPIO 29 (USB Power Enable)\n");
-	kirkwood_ehci_init();
-
-	kirkwood_ge00_init(&sheevaplug_ge00_data);
-
-	/* honor lower power consumption for plugs with out eSATA */
-	if (machine_is_esata_sheevaplug())
-		kirkwood_sata_init(&sheeva_esata_sata_data);
-
-	/* enable sd wp and sd cd on plugs with esata */
-	if (machine_is_esata_sheevaplug())
-		kirkwood_sdio_init(&sheeva_esata_mvsdio_data);
-	else
-		kirkwood_sdio_init(&sheevaplug_mvsdio_data);
-
-	platform_device_register(&sheevaplug_leds);
-}
-
-#ifdef CONFIG_MACH_SHEEVAPLUG
-MACHINE_START(SHEEVAPLUG, "Marvell SheevaPlug Reference Board")
-	/* Maintainer: shadi Ammouri <shadi@marvell.com> */
-	.atag_offset	= 0x100,
-	.init_machine	= sheevaplug_init,
-	.map_io		= kirkwood_map_io,
-	.init_early	= kirkwood_init_early,
-	.init_irq	= kirkwood_init_irq,
-	.init_time	= kirkwood_timer_init,
-	.restart	= kirkwood_restart,
-MACHINE_END
-#endif
-
-#ifdef CONFIG_MACH_ESATA_SHEEVAPLUG
-MACHINE_START(ESATA_SHEEVAPLUG, "Marvell eSATA SheevaPlug Reference Board")
-	.atag_offset	= 0x100,
-	.init_machine	= sheevaplug_init,
-	.map_io		= kirkwood_map_io,
-	.init_early	= kirkwood_init_early,
-	.init_irq	= kirkwood_init_irq,
-	.init_time	= kirkwood_timer_init,
-	.restart	= kirkwood_restart,
-MACHINE_END
-#endif
-- 
1.8.1.2
