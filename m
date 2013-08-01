From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu,  1 Aug 2013 17:07:28 +0200
Subject: [PATCHv2 2/9] ARM: kirkwood: remove support for legacy booting of
 Dockstar
In-Reply-To: <1375369655-1310-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1375369655-1310-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1375369655-1310-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Kirkwood Dockstar platform has already been converted to the
Device Tree, so we can remove the legacy booting option for this
platform.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-kirkwood/Kconfig          |   7 --
 arch/arm/mach-kirkwood/Makefile         |   1 -
 arch/arm/mach-kirkwood/dockstar-setup.c | 111 --------------------------------
 3 files changed, 119 deletions(-)
 delete mode 100644 arch/arm/mach-kirkwood/dockstar-setup.c

diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index 8bcd659..cf6c938 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -5,13 +5,6 @@ menu "Marvell Kirkwood Implementations"
 config KIRKWOOD_LEGACY
 	bool
 
-config MACH_DOCKSTAR
-	bool "Seagate FreeAgent DockStar"
-	select KIRKWOOD_LEGACY
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  Seagate FreeAgent DockStar.
-
 config MACH_ESATA_SHEEVAPLUG
 	bool "Marvell eSATA SheevaPlug Reference Board"
 	select KIRKWOOD_LEGACY
diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
index 805028a..5edba89 100644
--- a/arch/arm/mach-kirkwood/Makefile
+++ b/arch/arm/mach-kirkwood/Makefile
@@ -1,7 +1,6 @@
 obj-y				+= common.o pcie.o
 obj-$(CONFIG_KIRKWOOD_LEGACY)	+= irq.o mpp.o
 
-obj-$(CONFIG_MACH_DOCKSTAR)		+= dockstar-setup.o
 obj-$(CONFIG_MACH_ESATA_SHEEVAPLUG)	+= sheevaplug-setup.o
 obj-$(CONFIG_MACH_GURUPLUG)		+= guruplug-setup.o
 obj-$(CONFIG_MACH_INETSPACE_V2)		+= netspace_v2-setup.o lacie_v2-common.o
diff --git a/arch/arm/mach-kirkwood/dockstar-setup.c b/arch/arm/mach-kirkwood/dockstar-setup.c
deleted file mode 100644
index 060ccf9..0000000
--- a/arch/arm/mach-kirkwood/dockstar-setup.c
+++ /dev/null
@@ -1,111 +0,0 @@
-/*
- * arch/arm/mach-kirkwood/dockstar-setup.c
- *
- * Seagate FreeAgent DockStar Setup
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
-#include "common.h"
-#include "mpp.h"
-
-static struct mtd_partition dockstar_nand_parts[] = {
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
-static struct mv643xx_eth_platform_data dockstar_ge00_data = {
-	.phy_addr	= MV643XX_ETH_PHY_ADDR(0),
-};
-
-static struct gpio_led dockstar_led_pins[] = {
-	{
-		.name			= "dockstar:green:health",
-		.default_trigger	= "default-on",
-		.gpio			= 46,
-		.active_low		= 1,
-	},
-	{
-		.name			= "dockstar:orange:misc",
-		.default_trigger	= "none",
-		.gpio			= 47,
-		.active_low		= 1,
-	},
-};
-
-static struct gpio_led_platform_data dockstar_led_data = {
-	.leds		= dockstar_led_pins,
-	.num_leds	= ARRAY_SIZE(dockstar_led_pins),
-};
-
-static struct platform_device dockstar_leds = {
-	.name	= "leds-gpio",
-	.id	= -1,
-	.dev	= {
-		.platform_data	= &dockstar_led_data,
-	}
-};
-
-static unsigned int dockstar_mpp_config[] __initdata = {
-	MPP29_GPIO,	/* USB Power Enable */
-	MPP46_GPIO,	/* LED green */
-	MPP47_GPIO,	/* LED orange */
-	0
-};
-
-static void __init dockstar_init(void)
-{
-	/*
-	 * Basic setup. Needs to be called early.
-	 */
-	kirkwood_init();
-
-	/* setup gpio pin select */
-	kirkwood_mpp_conf(dockstar_mpp_config);
-
-	kirkwood_uart0_init();
-	kirkwood_nand_init(ARRAY_AND_SIZE(dockstar_nand_parts), 25);
-
-	if (gpio_request(29, "USB Power Enable") != 0 ||
-	    gpio_direction_output(29, 1) != 0)
-		pr_err("can't set up GPIO 29 (USB Power Enable)\n");
-	kirkwood_ehci_init();
-
-	kirkwood_ge00_init(&dockstar_ge00_data);
-
-	platform_device_register(&dockstar_leds);
-}
-
-MACHINE_START(DOCKSTAR, "Seagate FreeAgent DockStar")
-	.atag_offset	= 0x100,
-	.init_machine	= dockstar_init,
-	.map_io		= kirkwood_map_io,
-	.init_early	= kirkwood_init_early,
-	.init_irq	= kirkwood_init_irq,
-	.init_time	= kirkwood_timer_init,
-	.restart	= kirkwood_restart,
-MACHINE_END
-- 
1.8.1.2
