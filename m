From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu,  1 Aug 2013 10:45:32 +0200
Subject: [PATCH 3/9] ARM: kirkwood: remove support for legacy booting of
 Guruplug
In-Reply-To: <1375346738-21596-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1375346738-21596-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1375346738-21596-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Kirkwood Guruplug platform has already been converted to the
Device Tree, so we can remove the legacy booting option for this
platform.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-kirkwood/Kconfig          |   6 --
 arch/arm/mach-kirkwood/Makefile         |   1 -
 arch/arm/mach-kirkwood/guruplug-setup.c | 133 --------------------------------
 3 files changed, 140 deletions(-)
 delete mode 100644 arch/arm/mach-kirkwood/guruplug-setup.c

diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index 9d056cd..9aad378 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -8,12 +8,6 @@ config MACH_ESATA_SHEEVAPLUG
 	  Say 'Y' here if you want your kernel to support the
 	  Marvell eSATA SheevaPlug Reference Board.
 
-config MACH_GURUPLUG
-	bool "Marvell GuruPlug Reference Board"
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  Marvell GuruPlug Reference Board.
-
 config MACH_INETSPACE_V2
 	bool "LaCie Internet Space v2 NAS Board"
 	help
diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
index 13f7ab1..c3ccbf7 100644
--- a/arch/arm/mach-kirkwood/Makefile
+++ b/arch/arm/mach-kirkwood/Makefile
@@ -1,7 +1,6 @@
 obj-y				+= common.o irq.o pcie.o mpp.o
 
 obj-$(CONFIG_MACH_ESATA_SHEEVAPLUG)	+= sheevaplug-setup.o
-obj-$(CONFIG_MACH_GURUPLUG)		+= guruplug-setup.o
 obj-$(CONFIG_MACH_INETSPACE_V2)		+= netspace_v2-setup.o lacie_v2-common.o
 obj-$(CONFIG_MACH_MV88F6281GTW_GE)	+= mv88f6281gtw_ge-setup.o
 obj-$(CONFIG_MACH_NET2BIG_V2)		+= netxbig_v2-setup.o lacie_v2-common.o
diff --git a/arch/arm/mach-kirkwood/guruplug-setup.c b/arch/arm/mach-kirkwood/guruplug-setup.c
deleted file mode 100644
index 08dd739..0000000
--- a/arch/arm/mach-kirkwood/guruplug-setup.c
+++ /dev/null
@@ -1,133 +0,0 @@
-/*
- * arch/arm/mach-kirkwood/guruplug-setup.c
- *
- * Marvell GuruPlug Reference Board Setup
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/mtd/partitions.h>
-#include <linux/ata_platform.h>
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
-static struct mtd_partition guruplug_nand_parts[] = {
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
-static struct mv643xx_eth_platform_data guruplug_ge00_data = {
-	.phy_addr	= MV643XX_ETH_PHY_ADDR(0),
-};
-
-static struct mv643xx_eth_platform_data guruplug_ge01_data = {
-	.phy_addr	= MV643XX_ETH_PHY_ADDR(1),
-};
-
-static struct mv_sata_platform_data guruplug_sata_data = {
-	.n_ports	= 1,
-};
-
-static struct mvsdio_platform_data guruplug_mvsdio_data = {
-	/* unfortunately the CD signal has not been connected */
-	.gpio_card_detect = -1,
-	.gpio_write_protect = -1,
-};
-
-static struct gpio_led guruplug_led_pins[] = {
-	{
-		.name			= "guruplug:red:health",
-		.gpio			= 46,
-		.active_low		= 1,
-	},
-	{
-		.name			= "guruplug:green:health",
-		.gpio			= 47,
-		.active_low		= 1,
-	},
-	{
-		.name			= "guruplug:red:wmode",
-		.gpio			= 48,
-		.active_low		= 1,
-	},
-	{
-		.name			= "guruplug:green:wmode",
-		.gpio			= 49,
-		.active_low		= 1,
-	},
-};
-
-static struct gpio_led_platform_data guruplug_led_data = {
-	.leds		= guruplug_led_pins,
-	.num_leds	= ARRAY_SIZE(guruplug_led_pins),
-};
-
-static struct platform_device guruplug_leds = {
-	.name	= "leds-gpio",
-	.id	= -1,
-	.dev	= {
-		.platform_data	= &guruplug_led_data,
-	}
-};
-
-static unsigned int guruplug_mpp_config[] __initdata = {
-	MPP46_GPIO,	/* M_RLED */
-	MPP47_GPIO,	/* M_GLED */
-	MPP48_GPIO,	/* B_RLED */
-	MPP49_GPIO,	/* B_GLED */
-	0
-};
-
-static void __init guruplug_init(void)
-{
-	/*
-	 * Basic setup. Needs to be called early.
-	 */
-	kirkwood_init();
-	kirkwood_mpp_conf(guruplug_mpp_config);
-
-	kirkwood_uart0_init();
-	kirkwood_nand_init(ARRAY_AND_SIZE(guruplug_nand_parts), 25);
-
-	kirkwood_ehci_init();
-	kirkwood_ge00_init(&guruplug_ge00_data);
-	kirkwood_ge01_init(&guruplug_ge01_data);
-	kirkwood_sata_init(&guruplug_sata_data);
-	kirkwood_sdio_init(&guruplug_mvsdio_data);
-
-	platform_device_register(&guruplug_leds);
-}
-
-MACHINE_START(GURUPLUG, "Marvell GuruPlug Reference Board")
-	/* Maintainer: Siddarth Gore <gores@marvell.com> */
-	.atag_offset	= 0x100,
-	.init_machine	= guruplug_init,
-	.map_io		= kirkwood_map_io,
-	.init_early	= kirkwood_init_early,
-	.init_irq	= kirkwood_init_irq,
-	.init_time	= kirkwood_timer_init,
-	.restart	= kirkwood_restart,
-MACHINE_END
-- 
1.8.1.2
