From: ottxor@gentoo.org (Christoph Junghans)
Date: Sun, 10 Feb 2013 16:53:38 -0700
Subject: [PATCH] Added support for pogoplug e02 (pink/gray)
Message-ID: <1360540418-14133-1-git-send-email-ottxor@gentoo.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pogoplug differs from the SheevaPlug only by a
few details, but especially in the led assignments.
This patch was tested under Gentoo Linux.
A version of this patch was included in Arch Linux
on Arm since Jan 2012:
   https://github.com/archlinuxarm/PKGBUILDs/pull/124
A similar patch is available for OpenWrt:
  http://patchwork.openwrt.org/patch/1412/

Signed-off-by: Christoph Junghans <ottxor@gentoo.org>
---
 arch/arm/configs/kirkwood_defconfig     |   1 +
 arch/arm/mach-kirkwood/Kconfig          |   8 +++
 arch/arm/mach-kirkwood/Makefile         |   1 +
 arch/arm/mach-kirkwood/pogo_e02-setup.c | 122 ++++++++++++++++++++++++++++++++
 4 files changed, 132 insertions(+)
 create mode 100644 arch/arm/mach-kirkwood/pogo_e02-setup.c

diff --git a/arch/arm/configs/kirkwood_defconfig b/arch/arm/configs/kirkwood_defconfig
index 93f3794..9a41bd7 100644
--- a/arch/arm/configs/kirkwood_defconfig
+++ b/arch/arm/configs/kirkwood_defconfig
@@ -38,6 +38,7 @@ CONFIG_MACH_TOPKICK_DT=y
 CONFIG_MACH_TS219=y
 CONFIG_MACH_TS41X=y
 CONFIG_MACH_DOCKSTAR=y
+CONFIG_MACH_POGO_E02=y
 CONFIG_MACH_OPENRD_BASE=y
 CONFIG_MACH_OPENRD_CLIENT=y
 CONFIG_MACH_OPENRD_ULTIMATE=y
diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index f91cdff..b17ee5c 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -214,6 +214,14 @@ config MACH_DOCKSTAR
 	  Say 'Y' here if you want your kernel to support the
 	  Seagate FreeAgent DockStar.
 
+config MACH_POGO_E02
+	bool "CE Pogoplug E02"
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  CloudEngines Pogoplug e02 (pink/gray). It differs from Marvell's
+	  SheevaPlug Reference Board by a few details, but
+	  especially in the led assignments.
+
 config MACH_OPENRD
         bool
 
diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
index 8d2e5a9..d982136 100644
--- a/arch/arm/mach-kirkwood/Makefile
+++ b/arch/arm/mach-kirkwood/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_MACH_SHEEVAPLUG)		+= sheevaplug-setup.o
 obj-$(CONFIG_MACH_ESATA_SHEEVAPLUG)	+= sheevaplug-setup.o
 obj-$(CONFIG_MACH_GURUPLUG)		+= guruplug-setup.o
 obj-$(CONFIG_MACH_DOCKSTAR)		+= dockstar-setup.o
+obj-$(CONFIG_MACH_POGO_E02)		+= pogo_e02-setup.o
 obj-$(CONFIG_MACH_TS219)		+= ts219-setup.o tsx1x-common.o
 obj-$(CONFIG_MACH_TS41X)		+= ts41x-setup.o tsx1x-common.o
 obj-$(CONFIG_MACH_OPENRD)		+= openrd-setup.o
diff --git a/arch/arm/mach-kirkwood/pogo_e02-setup.c b/arch/arm/mach-kirkwood/pogo_e02-setup.c
new file mode 100644
index 0000000..88a7710
--- /dev/null
+++ b/arch/arm/mach-kirkwood/pogo_e02-setup.c
@@ -0,0 +1,122 @@
+/*
+ * arch/arm/mach-kirkwood/pogo_e02-setup.c
+ *
+ * CloudEngines Pogoplug E02 support
+ *
+ * Copyright (C) 2013 Christoph Junghans <ottxor@gentoo.org>
+ * Based on a patch in Arch Linux for Arm by:
+ * Copyright (C) 2012 Kevin Mihelich <kevin@plugapps.com>
+ *                and  <pazos@lavabit.com>
+ *
+ * Based on the board file sheevaplug-setup.c
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
+#include "common.h"
+#include "mpp.h"
+
+static struct mtd_partition pogo_e02_nand_parts[] = {
+	{
+		.name = "u-boot",
+		.offset = 0,
+		.size = SZ_1M
+	}, {
+		.name = "uImage",
+		.offset = MTDPART_OFS_NXTBLK,
+		.size = SZ_4M
+	}, {
+		.name = "pogoplug",
+		.offset = MTDPART_OFS_NXTBLK,
+		.size = SZ_32M
+	}, {
+		.name = "root",
+		.offset = MTDPART_OFS_NXTBLK,
+		.size = MTDPART_SIZ_FULL
+	},
+};
+
+static struct mv643xx_eth_platform_data pogo_e02_ge00_data = {
+	.phy_addr	= MV643XX_ETH_PHY_ADDR(0),
+};
+
+static struct gpio_led pogo_e02_led_pins[] = {
+	{
+		.name			= "status:green:health",
+		.default_trigger	= "default-on",
+		.gpio			= 48,
+		.active_low		= 1,
+	},
+	{
+		.name			= "status:orange:fault",
+		.default_trigger	= "none",
+		.gpio			= 49,
+		.active_low		= 1,
+	}
+};
+
+static struct gpio_led_platform_data pogo_e02_led_data = {
+	.leds		= pogo_e02_led_pins,
+	.num_leds	= ARRAY_SIZE(pogo_e02_led_pins),
+};
+
+static struct platform_device pogo_e02_leds = {
+	.name	= "leds-gpio",
+	.id	= -1,
+	.dev	= {
+		.platform_data	= &pogo_e02_led_data,
+	}
+};
+
+static unsigned int pogo_e02_mpp_config[] __initdata = {
+	MPP29_GPIO,	/* USB Power Enable */
+	MPP48_GPIO,	/* LED Green */
+	MPP49_GPIO,	/* LED Orange */
+	0
+};
+
+static void __init pogo_e02_init(void)
+{
+	/*
+	 * Basic setup. Needs to be called early.
+	 */
+	kirkwood_init();
+
+	/* setup gpio pin select */
+	kirkwood_mpp_conf(pogo_e02_mpp_config);
+
+	kirkwood_uart0_init();
+	kirkwood_nand_init(ARRAY_AND_SIZE(pogo_e02_nand_parts), 25);
+
+	if (gpio_request(29, "USB Power Enable") != 0 ||
+	    gpio_direction_output(29, 1) != 0)
+		pr_err("can't set up GPIO 29 (USB Power Enable)\n");
+	kirkwood_ehci_init();
+
+	kirkwood_ge00_init(&pogo_e02_ge00_data);
+
+	platform_device_register(&pogo_e02_leds);
+}
+
+MACHINE_START(POGO_E02, "Pogoplug E02")
+	.atag_offset	= 0x100,
+	.init_machine	= pogo_e02_init,
+	.map_io		= kirkwood_map_io,
+	.init_early	= kirkwood_init_early,
+	.init_irq	= kirkwood_init_irq,
+	.timer		= &kirkwood_timer,
+	.restart	= kirkwood_restart,
+MACHINE_END
-- 
1.7.12.4
