From: josh.coombs@gmail.com (Josh Coombs)
Date: Mon, 18 Jun 2012 20:35:27 -0400
Subject: [RFC PATCH] ARM: Initial DTS support for Kirkwood GoFlex Net
Message-ID: <CAMW5UfaUBROU4o+1jz9O0AxTAgN6e0bjOX=T7YwQvomCTec3aQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is an attempt to get the Seagate GoFlex Net booting using
Kirkwood DTS support based on Arch Linux ARM's non-DTS GFN patches.
Currently 3.5rc3 will load and begin initializing, but stops without
error before mounting a rootfs and starting init.  This patch is based
on 3.5rc3 with the printk fix already applied.  The only oddity I can
pick out from dmesg is the console attaching to ttyS0 twice.

I'm out of my element at this point, really hoped I could quickly
bodge this together based on the existing patch using the old board
files but I'm obviously missing something.

Joshua Coombs

diff -ruN a/arch/arm/boot/dts/kirkwood-goflexnet.dts
b/arch/arm/boot/dts/kirkwood-goflexnet.dts
--- a/arch/arm/boot/dts/kirkwood-goflexnet.dts	1969-12-31
19:00:00.000000000 -0500
+++ b/arch/arm/boot/dts/kirkwood-goflexnet.dts	2012-06-18
13:19:34.000000000 -0400
@@ -0,0 +1,24 @@
+/dts-v1/;
+
+/include/ "kirkwood.dtsi"
+
+/ {
+	model = "Seagate GoFlex Net";
+	compatible = "seagate,goflexnet", "mrvl,kirkwood-88f6281", "mrvl,kirkwood";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x8000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8 earlyprintk root=/dev/sda1 rootdelay=10";
+	};
+
+	ocp at f1000000 {
+		serial at 12000 {
+			clock-frequency = <200000000>;
+			status = "ok";
+		};
+	};
+};
diff -ruN a/arch/arm/mach-kirkwood/board-dt.c
b/arch/arm/mach-kirkwood/board-dt.c
--- a/arch/arm/mach-kirkwood/board-dt.c	2012-06-16 20:25:17.000000000 -0400
+++ b/arch/arm/mach-kirkwood/board-dt.c	2012-06-18 13:20:55.000000000 -0400
@@ -68,6 +68,9 @@
 	if (of_machine_is_compatible("raidsonic,ib-nas62x0"))
 		ib62x0_init();

+	if (of_machine_is_compatible("seagate,goflexnet"))
+		goflexnet_init();
+
 	of_platform_populate(NULL, kirkwood_dt_match_table, NULL, NULL);
 }

@@ -77,6 +80,7 @@
 	"dlink,dns-325",
 	"iom,iconnect",
 	"raidsonic,ib-nas62x0",
+	"seagate,goflexnet",
 	NULL
 };

diff -ruN a/arch/arm/mach-kirkwood/board-goflexnet.c
b/arch/arm/mach-kirkwood/board-goflexnet.c
--- a/arch/arm/mach-kirkwood/board-goflexnet.c	1969-12-31
19:00:00.000000000 -0500
+++ b/arch/arm/mach-kirkwood/board-goflexnet.c	2012-06-18
13:55:49.000000000 -0400
@@ -0,0 +1,180 @@
+/*
+ * Copyright 2012 (C), Jason Cooper <jason@lakedaemon.net>
+ *
+ * arch/arm/mach-kirkwood/board-dreamplug.c
+ *
+ * Marvell DreamPlug Reference Board Init for drivers not converted to
+ * flattened device tree yet.
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ * Copied and modified for Seagate GoFlex Net support by
+ * Joshua Coombs <josh.coombs@gmail.com> based on ArchLinux ARM's
+ * GoFlex kernel patches.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/mtd/partitions.h>
+#include <linux/ata_platform.h>
+#include <linux/mv643xx_eth.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_fdt.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/gpio.h>
+#include <linux/leds.h>
+#include <linux/mtd/physmap.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <mach/kirkwood.h>
+#include <mach/bridge-regs.h>
+#include <plat/mvsdio.h>
+#include "common.h"
+#include "mpp.h"
+
+struct mtd_partition goflexnet_partitions[] = {
+	{
+		.name	= "u-boot",
+		.size	= SZ_1M,
+		.offset = 0,
+	},
+	{
+		.name	= "uImage",
+		.size	= SZ_4M,
+		.offset = MTDPART_OFS_NXTBLK,
+	},
+	{
+		.name	= "pogoplug",
+		.size	= SZ_32M,
+		.offset = MTDPART_OFS_NXTBLK,
+	},
+	{
+		.name	= "root",
+		.size	= MTDPART_SIZ_FULL,
+		.offset = MTDPART_OFS_NXTBLK,
+	},
+};
+
+static struct mv643xx_eth_platform_data goflexnet_ge00_data = {
+	.phy_addr	= MV643XX_ETH_PHY_ADDR(0),
+};
+
+static struct mv_sata_platform_data goflexnet_sata_data = {
+	.n_ports	= 2,
+};
+
+static struct gpio_led goflexnet_led_pins[] = {
+	{
+		.name			= "status:green:health",
+		.default_trigger	= "default-on",
+		.gpio			= 46, // 0x4000
+		.active_low		= 1,
+	},
+	{
+		.name			= "status:orange:fault",
+		.default_trigger	= "none",
+		.gpio			= 47, // 0x8000
+		.active_low		= 1,
+	},
+	{
+		.name			= "status:white:left0",
+		.default_trigger	= "none",
+		.gpio			= 42, // 0x0400
+		.active_low		= 0,
+	},
+	{
+		.name			= "status:white:left1",
+		.default_trigger	= "none",
+		.gpio			= 43, // 0x0800
+		.active_low		= 0,
+	},
+	{
+		.name			= "status:white:left2",
+		.default_trigger	= "none",
+		.gpio			= 44, // 0x1000
+		.active_low		= 0,
+	},
+	{
+		.name			= "status:white:left3",
+		.default_trigger	= "none",
+		.gpio			= 45, // 0x2000
+		.active_low		= 0,
+	},
+	{
+		.name			= "status:white:right0",
+		.default_trigger	= "none",
+		.gpio			= 38, // 0x0040
+		.active_low		= 0,
+	},
+	{
+		.name			= "status:white:right1",
+		.default_trigger	= "none",
+		.gpio			= 39, // 0x0080
+		.active_low		= 0,
+	},
+	{
+		.name			= "status:white:right2",
+		.default_trigger	= "none",
+		.gpio			= 40, // 0x0100
+		.active_low		= 0,
+	},
+	{
+		.name			= "status:white:right3",
+		.default_trigger	= "none",
+		.gpio			= 41, // 0x0200
+		.active_low		= 0,
+	},
+};
+
+static struct gpio_led_platform_data goflexnet_led_data = {
+	.leds		= goflexnet_led_pins,
+	.num_leds	= ARRAY_SIZE(goflexnet_led_pins),
+};
+
+static struct platform_device goflexnet_leds = {
+	.name	= "leds-gpio",
+	.id	= -1,
+	.dev	= {
+		.platform_data	= &goflexnet_led_data,
+	}
+};
+
+static unsigned int goflexnet_mpp_config[] __initdata = {
+	MPP29_GPIO,	/* USB Power Enable */
+	MPP47_GPIO,	/* LED Orange */
+	MPP46_GPIO,	/* LED Green */
+	MPP45_GPIO,	/* LED Left Capacity 3 */
+	MPP44_GPIO,	/* LED Left Capacity 2 */
+	MPP43_GPIO,	/* LED Left Capacity 1 */
+	MPP42_GPIO,	/* LED Left Capacity 0 */
+	MPP41_GPIO,	/* LED Right Capacity 3 */
+	MPP40_GPIO,	/* LED Right Capacity 2 */
+	MPP39_GPIO,	/* LED Right Capacity 1 */
+	MPP38_GPIO,	/* LED Right Capacity 0 */
+	0
+};
+
+void __init goflexnet_init(void)
+{
+	/*
+	 * Basic setup. Needs to be called early.
+	 */
+	kirkwood_mpp_conf(goflexnet_mpp_config);
+
+	if (gpio_request(29, "USB Power Enable") != 0 ||
+	    gpio_direction_output(29, 1) != 0)
+	        printk(KERN_ERR "can't setup GPIO 29 (USB Power Enable)\n");
+	kirkwood_ehci_init();
+
+	kirkwood_ge00_init(&goflexnet_ge00_data);
+	kirkwood_sata_init(&goflexnet_sata_data);
+
+	platform_device_register(&goflexnet_leds);
+}
diff -ruN a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
--- a/arch/arm/mach-kirkwood/common.h	2012-06-16 20:25:17.000000000 -0400
+++ b/arch/arm/mach-kirkwood/common.h	2012-06-18 13:35:54.000000000 -0400
@@ -77,6 +77,12 @@
 static inline void ib62x0_init(void) {};
 #endif

+#ifdef CONFIG_MACH_GOFLEXNET_DT
+void goflexnet_init(void);
+#else
+static inline void goflexnet_init(void) {};
+#endif
+
 /* early init functions not converted to fdt yet */
 char *kirkwood_id(void);
 void kirkwood_l2_init(void);
diff -ruN a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
--- a/arch/arm/mach-kirkwood/Kconfig	2012-06-16 20:25:17.000000000 -0400
+++ b/arch/arm/mach-kirkwood/Kconfig	2012-06-18 13:37:22.000000000 -0400
@@ -80,6 +80,13 @@
 	  RaidSonic IB-NAS6210 & IB-NAS6220 devices, using
 	  Flattened Device Tree.

+config MACH_GOFLEXNET_DT
+	bool "Seagate GoFlex Net (Flattened Device Tree)"
+	select ARCH_KIRKWOOD_DT
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  Seagate GoFlex Net (Flattened Device Tree).
+
 config MACH_TS219
 	bool "QNAP TS-110, TS-119, TS-119P+, TS-210, TS-219, TS-219P and
TS-219P+ Turbo NAS"
 	help
diff -ruN a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
--- a/arch/arm/mach-kirkwood/Makefile	2012-06-16 20:25:17.000000000 -0400
+++ b/arch/arm/mach-kirkwood/Makefile	2012-06-18 13:38:04.000000000 -0400
@@ -25,3 +25,4 @@
 obj-$(CONFIG_MACH_ICONNECT_DT)		+= board-iconnect.o
 obj-$(CONFIG_MACH_DLINK_KIRKWOOD_DT)	+= board-dnskw.o
 obj-$(CONFIG_MACH_IB62X0_DT)		+= board-ib62x0.o
+obj-$(CONFIG_MACH_GOFLEXNET_DT)		+= board-goflexnet.o
diff -ruN a/arch/arm/mach-kirkwood/Makefile.boot
b/arch/arm/mach-kirkwood/Makefile.boot
--- a/arch/arm/mach-kirkwood/Makefile.boot	2012-06-16 20:25:17.000000000 -0400
+++ b/arch/arm/mach-kirkwood/Makefile.boot	2012-06-18 13:38:38.000000000 -0400
@@ -7,3 +7,4 @@
 dtb-$(CONFIG_MACH_DLINK_KIRKWOOD_DT) += kirkwood-dns325.dtb
 dtb-$(CONFIG_MACH_ICONNECT_DT) += kirkwood-iconnect.dtb
 dtb-$(CONFIG_MACH_IB62X0_DT) += kirkwood-ib62x0.dtb
+dtb-$(CONFIG_MACH_GOFLEXNET_DT) += kirkwood-goflexnet.dtb
