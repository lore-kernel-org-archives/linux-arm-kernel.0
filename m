From: gmbnomis@gmail.com (Simon Baatz)
Date: Mon, 30 Apr 2012 23:55:17 +0200
Subject: [PATCH 1/1] ARM: kirkwood: Add support for RaidSonic IB-NAS6210/6220
 using devicetree
In-Reply-To: <1335822917-16689-1-git-send-email-gmbnomis@gmail.com>
References: <1335822917-16689-1-git-send-email-gmbnomis@gmail.com>
Message-ID: <1335822917-16689-2-git-send-email-gmbnomis@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the IB-NAS6210 and IB-NAS 6220. Describe as much as
currently possible in the devicetree files, including the NAND partitions.
Use the partition scheme of the original firmware by default.

Create a board-ib62x0.c for everything else.

Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---
 arch/arm/boot/dts/kirkwood-ib62x0.dts |   44 ++++++++++
 arch/arm/mach-kirkwood/Kconfig        |    8 ++
 arch/arm/mach-kirkwood/Makefile       |    1 +
 arch/arm/mach-kirkwood/Makefile.boot  |    1 +
 arch/arm/mach-kirkwood/board-dt.c     |    4 +
 arch/arm/mach-kirkwood/board-ib62x0.c |  143 +++++++++++++++++++++++++++++++++
 arch/arm/mach-kirkwood/common.h       |    6 ++
 7 files changed, 207 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-ib62x0.dts
 create mode 100644 arch/arm/mach-kirkwood/board-ib62x0.c

diff --git a/arch/arm/boot/dts/kirkwood-ib62x0.dts b/arch/arm/boot/dts/kirkwood-ib62x0.dts
new file mode 100644
index 0000000..ada0f0c
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-ib62x0.dts
@@ -0,0 +1,44 @@
+/dts-v1/;
+
+/include/ "kirkwood.dtsi"
+
+/ {
+	model = "RaidSonic ICY BOX IB-NAS62x0 (Rev B)";
+	compatible = "raidsonic,ib-nas6210-b", "raidsonic,ib-nas6220-b", "raidsonic,ib-nas6210", "raidsonic,ib-nas6220", "raidsonic,ib-nas62x0",  "mrvl,kirkwood-88f6281", "mrvl,kirkwood";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x10000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8 earlyprintk";
+	};
+
+	ocp at f1000000 {
+		serial at 12000 {
+			clock-frequency = <200000000>;
+			status = "okay";
+		};
+
+		nand at 3000000 {
+			status = "okay";
+
+			partition at 0 {
+				label = "u-boot";
+				reg = <0x0000000 0x100000>;
+			};
+
+			partition at 100000 {
+				label = "uImage";
+				reg = <0x0100000 0x600000>;
+			};
+
+			partition at 700000 {
+				label = "root";
+				reg = <0x0700000 0xf900000>;
+			};
+
+		};
+	};
+};
diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index 636778e..4daf6ab 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -66,6 +66,14 @@ config MACH_DLINK_KIRKWOOD_DT
 	  Kirkwood-based D-Link NASes such as DNS-320 & DNS-325,
 	  using Flattened Device Tree.
 
+config MACH_IB62X0_DT
+	bool "RaidSonic IB-NAS6210, IB-NAS6220 (Flattened Device Tree)"
+	select ARCH_KIRKWOOD_DT
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  RaidSonic IB-NAS6210 & IB-NAS6220 devices, using
+	  Flattened Device Tree.
+
 config MACH_TS219
 	bool "QNAP TS-110, TS-119, TS-119P+, TS-210, TS-219, TS-219P and TS-219P+ Turbo NAS"
 	help
diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
index 36781b3..c372948 100644
--- a/arch/arm/mach-kirkwood/Makefile
+++ b/arch/arm/mach-kirkwood/Makefile
@@ -23,3 +23,4 @@ obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
 obj-$(CONFIG_ARCH_KIRKWOOD_DT)		+= board-dt.o
 obj-$(CONFIG_MACH_DREAMPLUG_DT)		+= board-dreamplug.o
 obj-$(CONFIG_MACH_DLINK_KIRKWOOD_DT)	+= board-dnskw.o
+obj-$(CONFIG_MACH_IB62X0_DT)		+= board-ib62x0.o
diff --git a/arch/arm/mach-kirkwood/Makefile.boot b/arch/arm/mach-kirkwood/Makefile.boot
index 8bbffbe..042fcad 100644
--- a/arch/arm/mach-kirkwood/Makefile.boot
+++ b/arch/arm/mach-kirkwood/Makefile.boot
@@ -5,3 +5,4 @@ initrd_phys-y	:= 0x00800000
 dtb-$(CONFIG_MACH_DREAMPLUG_DT) += kirkwood-dreamplug.dtb
 dtb-$(CONFIG_MACH_DLINK_KIRKWOOD_DT) += kirkwood-dns320.dtb
 dtb-$(CONFIG_MACH_DLINK_KIRKWOOD_DT) += kirkwood-dns325.dtb
+dtb-$(CONFIG_MACH_IB62X0_DT) += kirkwood-ib62x0.dtb
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index eadc4d7..ff1b545 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -58,6 +58,9 @@ static void __init kirkwood_dt_init(void)
 	if (of_machine_is_compatible("dlink,dns-kirkwood"))
 		dnskw_init();
 
+	if (of_machine_is_compatible("raidsonic,ib-nas62x0"))
+		ib62x0_init();
+
 	of_platform_populate(NULL, kirkwood_dt_match_table, NULL, NULL);
 }
 
@@ -65,6 +68,7 @@ static const char *kirkwood_dt_board_compat[] = {
 	"globalscale,dreamplug",
 	"dlink,dns-320",
 	"dlink,dns-325",
+	"raidsonic,ib-nas62x0",
 	NULL
 };
 
diff --git a/arch/arm/mach-kirkwood/board-ib62x0.c b/arch/arm/mach-kirkwood/board-ib62x0.c
new file mode 100644
index 0000000..eddf1df
--- /dev/null
+++ b/arch/arm/mach-kirkwood/board-ib62x0.c
@@ -0,0 +1,143 @@
+/*
+ * Copyright 2012 (C), Simon Baatz <gmbnomis@gmail.com>
+ *
+ * arch/arm/mach-kirkwood/board-ib62x0.c
+ *
+ * RaidSonic ICY BOX IB-NAS6210 & IB-NAS6220 init for drivers not
+ * converted to flattened device tree yet.
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/mtd/partitions.h>
+#include <linux/ata_platform.h>
+#include <linux/mv643xx_eth.h>
+#include <linux/gpio.h>
+#include <linux/gpio_keys.h>
+#include <linux/input.h>
+#include <linux/leds.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <mach/kirkwood.h>
+#include "common.h"
+#include "mpp.h"
+
+#define IB62X0_GPIO_POWER_OFF	24
+
+static struct mv643xx_eth_platform_data ib62x0_ge00_data = {
+	.phy_addr	= MV643XX_ETH_PHY_ADDR(8),
+};
+
+static struct mv_sata_platform_data ib62x0_sata_data = {
+	.n_ports	= 2,
+};
+
+static unsigned int ib62x0_mpp_config[] __initdata = {
+	MPP0_NF_IO2,
+	MPP1_NF_IO3,
+	MPP2_NF_IO4,
+	MPP3_NF_IO5,
+	MPP4_NF_IO6,
+	MPP5_NF_IO7,
+	MPP18_NF_IO0,
+	MPP19_NF_IO1,
+	MPP22_GPIO,	/* OS LED red */
+	MPP24_GPIO,	/* Power off device */
+	MPP25_GPIO,	/* OS LED green */
+	MPP27_GPIO,	/* USB transfer LED */
+	MPP28_GPIO,	/* Reset button */
+	MPP29_GPIO,	/* USB Copy button */
+	0
+};
+
+static struct gpio_led ib62x0_led_pins[] = {
+	{
+		.name			= "ib62x0:green:os",
+		.default_trigger	= "default-on",
+		.gpio			= 25,
+		.active_low		= 0,
+	},
+	{
+		.name			= "ib62x0:red:os",
+		.default_trigger	= "none",
+		.gpio			= 22,
+		.active_low		= 0,
+	},
+	{
+		.name			= "ib62x0:red:usb_copy",
+		.default_trigger	= "none",
+		.gpio			= 27,
+		.active_low		= 0,
+	},
+};
+
+static struct gpio_led_platform_data ib62x0_led_data = {
+	.leds		= ib62x0_led_pins,
+	.num_leds	= ARRAY_SIZE(ib62x0_led_pins),
+};
+
+static struct platform_device ib62x0_led_device = {
+	.name	= "leds-gpio",
+	.id	= -1,
+	.dev	= {
+		.platform_data	= &ib62x0_led_data,
+	}
+};
+
+static struct gpio_keys_button ib62x0_button_pins[] = {
+	{
+		.code		= KEY_COPY,
+		.gpio		= 29,
+		.desc		= "USB Copy",
+		.active_low	= 1,
+	},
+	{
+		.code		= KEY_RESTART,
+		.gpio		= 28,
+		.desc		= "Reset",
+		.active_low	= 1,
+	},
+};
+
+static struct gpio_keys_platform_data ib62x0_button_data = {
+	.buttons	= ib62x0_button_pins,
+	.nbuttons	= ARRAY_SIZE(ib62x0_button_pins),
+};
+
+static struct platform_device ib62x0_button_device = {
+	.name		= "gpio-keys",
+	.id		= -1,
+	.num_resources	= 0,
+	.dev		= {
+		.platform_data	= &ib62x0_button_data,
+	}
+};
+
+static void ib62x0_power_off(void)
+{
+	gpio_set_value(IB62X0_GPIO_POWER_OFF, 1);
+}
+
+void __init ib62x0_init(void)
+{
+	/*
+	 * Basic setup. Needs to be called early.
+	 */
+	kirkwood_mpp_conf(ib62x0_mpp_config);
+
+	kirkwood_ehci_init();
+	kirkwood_ge00_init(&ib62x0_ge00_data);
+	kirkwood_sata_init(&ib62x0_sata_data);
+	platform_device_register(&ib62x0_led_device);
+	platform_device_register(&ib62x0_button_device);
+	if (gpio_request(IB62X0_GPIO_POWER_OFF, "ib62x0:power:off") == 0 &&
+	    gpio_direction_output(IB62X0_GPIO_POWER_OFF, 0) == 0)
+		pm_power_off = ib62x0_power_off;
+	else
+		pr_err("board-ib62x0: failed to configure power-off GPIO\n");
+}
diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
index 6195a37..9fb301a 100644
--- a/arch/arm/mach-kirkwood/common.h
+++ b/arch/arm/mach-kirkwood/common.h
@@ -64,6 +64,12 @@ void dnskw_init(void);
 static inline void dnskw_init(void) {};
 #endif
 
+#ifdef CONFIG_MACH_IB62X0_DT
+void ib62x0_init(void);
+#else
+static inline void ib62x0_init(void) {};
+#endif
+
 /* early init functions not converted to fdt yet */
 char *kirkwood_id(void);
 void kirkwood_l2_init(void);
-- 
1.7.5.4
