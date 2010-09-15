From: ecc@cmu.edu (Eric Cooper)
Date: Wed, 15 Sep 2010 10:49:41 -0400
Subject: [PATCH v2] support for Seagate DockStar
In-Reply-To: <4C9070AC.3000601@gmail.com>
References: <1281044326-15058-1-git-send-email-ecc@cmu.edu>
	<4C9070AC.3000601@gmail.com>
Message-ID: <20100915144941.GB12069@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the Seagate FreeAgent DockStar,
a Marvell SheevaPlug variant.

Signed-off-by: Eric Cooper <ecc@cmu.edu>
---
 arch/arm/configs/kirkwood_defconfig     |    1 +
 arch/arm/mach-kirkwood/Kconfig          |    6 ++
 arch/arm/mach-kirkwood/Makefile         |    1 +
 arch/arm/mach-kirkwood/dockstar-setup.c |  112 +++++++++++++++++++++++++++++++
 4 files changed, 120 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-kirkwood/dockstar-setup.c

diff --git a/arch/arm/configs/kirkwood_defconfig b/arch/arm/configs/kirkwood_defconfig
index ccc9c99..2f70428 100644
--- a/arch/arm/configs/kirkwood_defconfig
+++ b/arch/arm/configs/kirkwood_defconfig
@@ -15,6 +15,7 @@ CONFIG_MACH_MV88F6281GTW_GE=y
 CONFIG_MACH_SHEEVAPLUG=y
 CONFIG_MACH_ESATA_SHEEVAPLUG=y
 CONFIG_MACH_GURUPLUG=y
+CONFIG_MACH_DOCKSTAR=y
 CONFIG_MACH_TS219=y
 CONFIG_MACH_TS41X=y
 CONFIG_MACH_OPENRD_BASE=y
diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index cc25501..3d5d66e 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -58,6 +58,12 @@ config MACH_TS41X
 	  QNAP TS-410, TS-410U, TS-419P and TS-419U Turbo NAS
 	  devices.
 
+config MACH_DOCKSTAR
+	bool "Seagate FreeAgent DockStar"
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  Seagate FreeAgent DockStar.
+
 config MACH_OPENRD
         bool
 
diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
index 295d7ba..9e43e95 100644
--- a/arch/arm/mach-kirkwood/Makefile
+++ b/arch/arm/mach-kirkwood/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_MACH_MV88F6281GTW_GE)	+= mv88f6281gtw_ge-setup.o
 obj-$(CONFIG_MACH_SHEEVAPLUG)		+= sheevaplug-setup.o
 obj-$(CONFIG_MACH_ESATA_SHEEVAPLUG)	+= sheevaplug-setup.o
 obj-$(CONFIG_MACH_GURUPLUG)		+= guruplug-setup.o
+obj-$(CONFIG_MACH_DOCKSTAR)		+= dockstar-setup.o
 obj-$(CONFIG_MACH_TS219)		+= ts219-setup.o tsx1x-common.o
 obj-$(CONFIG_MACH_TS41X)		+= ts41x-setup.o tsx1x-common.o
 obj-$(CONFIG_MACH_OPENRD)		+= openrd-setup.o
diff --git a/arch/arm/mach-kirkwood/dockstar-setup.c b/arch/arm/mach-kirkwood/dockstar-setup.c
new file mode 100644
index 0000000..a90475d
--- /dev/null
+++ b/arch/arm/mach-kirkwood/dockstar-setup.c
@@ -0,0 +1,112 @@
+/*
+ * arch/arm/mach-kirkwood/dockstar-setup.c
+ *
+ * Seagate FreeAgent DockStar Setup
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/ata_platform.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mv643xx_eth.h>
+#include <linux/gpio.h>
+#include <linux/leds.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <mach/kirkwood.h>
+#include <plat/mvsdio.h>
+#include "common.h"
+#include "mpp.h"
+
+static struct mtd_partition dockstar_nand_parts[] = {
+	{
+		.name = "u-boot",
+		.offset = 0,
+		.size = SZ_1M
+	}, {
+		.name = "uImage",
+		.offset = MTDPART_OFS_NXTBLK,
+		.size = SZ_4M
+	}, {
+		.name = "root",
+		.offset = MTDPART_OFS_NXTBLK,
+		.size = MTDPART_SIZ_FULL
+	},
+};
+
+static struct mv643xx_eth_platform_data dockstar_ge00_data = {
+	.phy_addr	= MV643XX_ETH_PHY_ADDR(0),
+};
+
+static struct gpio_led dockstar_led_pins[] = {
+	{
+		.name			= "dockstar:green:health",
+		.default_trigger	= "default-on",
+		.gpio			= 46,
+		.active_low		= 1,
+	},
+	{
+		.name			= "dockstar:orange:misc",
+		.default_trigger	= "none",
+		.gpio			= 47,
+		.active_low		= 1,
+	},
+};
+
+static struct gpio_led_platform_data dockstar_led_data = {
+	.leds		= dockstar_led_pins,
+	.num_leds	= ARRAY_SIZE(dockstar_led_pins),
+};
+
+static struct platform_device dockstar_leds = {
+	.name	= "leds-gpio",
+	.id	= -1,
+	.dev	= {
+		.platform_data	= &dockstar_led_data,
+	}
+};
+
+static unsigned int dockstar_mpp_config[] __initdata = {
+	MPP29_GPIO,	/* USB Power Enable */
+	MPP46_GPIO,	/* LED green */
+	MPP47_GPIO,	/* LED orange */
+	0
+};
+
+static void __init dockstar_init(void)
+{
+	/*
+	 * Basic setup. Needs to be called early.
+	 */
+	kirkwood_init();
+
+	/* setup gpio pin select */
+	kirkwood_mpp_conf(dockstar_mpp_config);
+
+	kirkwood_uart0_init();
+	kirkwood_nand_init(ARRAY_AND_SIZE(dockstar_nand_parts), 25);
+
+	if (gpio_request(29, "USB Power Enable") != 0 ||
+	    gpio_direction_output(29, 1) != 0)
+		printk(KERN_ERR "can't set up GPIO 29 (USB Power Enable)\n");
+	kirkwood_ehci_init();
+
+	kirkwood_ge00_init(&dockstar_ge00_data);
+
+	platform_device_register(&dockstar_leds);
+}
+
+MACHINE_START(DOCKSTAR, "Seagate FreeAgent DockStar")
+	.phys_io	= KIRKWOOD_REGS_PHYS_BASE,
+	.io_pg_offst	= ((KIRKWOOD_REGS_VIRT_BASE) >> 18) & 0xfffc,
+	.boot_params	= 0x00000100,
+	.init_machine	= dockstar_init,
+	.map_io		= kirkwood_map_io,
+	.init_irq	= kirkwood_init_irq,
+	.timer		= &kirkwood_timer,
+MACHINE_END
-- 
1.7.1
