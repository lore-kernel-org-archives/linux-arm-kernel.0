From: michael@walle.cc (Michael Walle)
Date: Mon, 16 Jul 2012 22:55:44 +0200
Subject: [PATCH] ARM: kirkwood: Add LS-XHL and LS-CHLv2 support
Message-ID: <1342472144-27703-1-git-send-email-michael@walle.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for Buffalo Linkstation LS-XHL and LS-CHLv2 using the device
tree where possible.

Signed-off-by: Michael Walle <michael@walle.cc>
---

This patch is based on Andrew Lunn's kirkwood devicetree branch at:
  git://github.com/lunn/linux.git v3.5-rc7-qnap-dt

 arch/arm/boot/dts/kirkwood-lschlv2.dts |   20 +++++
 arch/arm/boot/dts/kirkwood-lsxhl.dts   |   20 +++++
 arch/arm/boot/dts/kirkwood-lsxl.dtsi   |   95 ++++++++++++++++++++++
 arch/arm/mach-kirkwood/Kconfig         |    8 ++
 arch/arm/mach-kirkwood/Makefile        |    1 +
 arch/arm/mach-kirkwood/board-dt.c      |    4 +
 arch/arm/mach-kirkwood/board-lsxl.c    |  137 ++++++++++++++++++++++++++++++++
 arch/arm/mach-kirkwood/common.h        |    6 ++
 8 files changed, 291 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-lschlv2.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-lsxhl.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-lsxl.dtsi
 create mode 100644 arch/arm/mach-kirkwood/board-lsxl.c

diff --git a/arch/arm/boot/dts/kirkwood-lschlv2.dts b/arch/arm/boot/dts/kirkwood-lschlv2.dts
new file mode 100644
index 0000000..37649b5
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-lschlv2.dts
@@ -0,0 +1,20 @@
+/dts-v1/;
+
+/include/ "kirkwood-lsxl.dtsi"
+
+/ {
+	model = "Buffalo Linkstation LS-CHLv2";
+	compatible = "buffalo,lschlv2", "buffalo,lsxl", "mrvl,kirkwood-88f6281", "mrvl,kirkwood";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x4000000>;
+	};
+
+	ocp at f1000000 {
+		serial at 12000 {
+			clock-frequency = <166666667>;
+			status = "okay";
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/kirkwood-lsxhl.dts b/arch/arm/boot/dts/kirkwood-lsxhl.dts
new file mode 100644
index 0000000..eb3c071
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-lsxhl.dts
@@ -0,0 +1,20 @@
+/dts-v1/;
+
+/include/ "kirkwood-lsxl.dtsi"
+
+/ {
+	model = "Buffalo Linkstation LS-XHL";
+	compatible = "buffalo,lsxhl", "buffalo,lsxl", "mrvl,kirkwood-88f6281", "mrvl,kirkwood";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x10000000>;
+	};
+
+	ocp at f1000000 {
+		serial at 12000 {
+			clock-frequency = <200000000>;
+			status = "okay";
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/kirkwood-lsxl.dtsi b/arch/arm/boot/dts/kirkwood-lsxl.dtsi
new file mode 100644
index 0000000..5961d85
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-lsxl.dtsi
@@ -0,0 +1,95 @@
+/include/ "kirkwood.dtsi"
+
+/ {
+	chosen {
+		bootargs = "console=ttyS0,115200n8 earlyprintk";
+	};
+
+	ocp at f1000000 {
+		sata at 80000 {
+			status = "okay";
+			nr-ports = <1>;
+		};
+
+		spi at 10600 {
+			status = "okay";
+
+			m25p40 at 0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "m25p40";
+				reg = <0>;
+				spi-max-frequency = <25000000>;
+				mode = <0>;
+
+				partition at 0 {
+					reg = <0x0 0x60000>;
+					label = "uboot";
+					read-only;
+				};
+
+				partition at 60000 {
+					reg = <0x60000 0x10000>;
+					label = "dtb";
+					read-only;
+				};
+
+				partition at 70000 {
+					reg = <0x70000 0x10000>;
+					label = "uboot_env";
+				};
+			};
+		};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		button at 1 {
+			label = "Function Button";
+			linux,code = <1>;
+			gpios = <&gpio1 9 1>;
+		};
+		button at 2 {
+			label = "Power-on Switch";
+			linux,code = <2>;
+			gpios = <&gpio1 10 1>;
+		};
+		button at 3 {
+			label = "Power-auto Switch";
+			linux,code = <3>;
+			gpios = <&gpio1 11 1>;
+		};
+	};
+
+	gpio_leds {
+		compatible = "gpio-leds";
+
+		led at 1 {
+			label = "lschlv2:blue:func";
+			gpios = <&gpio1 4 1>;
+		};
+
+		led at 2 {
+			label = "lschlv2:red:alarm";
+			gpios = <&gpio1 5 1>;
+		};
+
+		led at 3 {
+			label = "lschlv2:amber:info";
+			gpios = <&gpio1 6 1>;
+		};
+
+		led at 4 {
+			label = "lschlv2:blue:power";
+			gpios = <&gpio1 7 1>;
+			linux,default-trigger = "default-on";
+		};
+
+		led at 5 {
+			label = "lschlv2:red:func";
+			gpios = <&gpio1 16 1>;
+		};
+	};
+};
diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index 8e62fa7..77c0f0f 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -94,6 +94,14 @@ config MACH_TS219_DT
 	  or MV6282. If you have the wrong one, the buttons will not
 	  work.
 
+config MACH_LSXL_DT
+	bool "Buffalo Linkstation LS-XHL, LS-CHLv2 (Flattened Device Tree)"
+	select ARCH_KIRKWOOD_DT
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  Buffalo Linkstation LS-XHL & LS-CHLv2 devices, using
+	  Flattened Device Tree.
+
 config MACH_TS219
 	bool "QNAP TS-110, TS-119, TS-119P+, TS-210, TS-219, TS-219P and TS-219P+ Turbo NAS"
 	help
diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
index 0468b23..8def9fe 100644
--- a/arch/arm/mach-kirkwood/Makefile
+++ b/arch/arm/mach-kirkwood/Makefile
@@ -26,3 +26,4 @@ obj-$(CONFIG_MACH_ICONNECT_DT)		+= board-iconnect.o
 obj-$(CONFIG_MACH_DLINK_KIRKWOOD_DT)	+= board-dnskw.o
 obj-$(CONFIG_MACH_IB62X0_DT)		+= board-ib62x0.o
 obj-$(CONFIG_MACH_TS219_DT)		+= board-ts219.o
+obj-$(CONFIG_MACH_LSXL_DT)		+= board-lsxl.o
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index d0ad250..da1bda8 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -80,6 +80,9 @@ static void __init kirkwood_dt_init(void)
 	if (of_machine_is_compatible("qnap,ts219"))
 		qnap_dt_ts219_init();
 
+	if (of_machine_is_compatible("buffalo,lsxl"))
+		lsxl_init();
+
 	of_platform_populate(NULL, kirkwood_dt_match_table,
 			     kirkwood_auxdata_lookup, NULL);
 }
@@ -91,6 +94,7 @@ static const char *kirkwood_dt_board_compat[] = {
 	"iom,iconnect",
 	"raidsonic,ib-nas62x0",
 	"qnap,ts219",
+	"buffalo,lsxl",
 	NULL
 };
 
diff --git a/arch/arm/mach-kirkwood/board-lsxl.c b/arch/arm/mach-kirkwood/board-lsxl.c
new file mode 100644
index 0000000..a06ed79
--- /dev/null
+++ b/arch/arm/mach-kirkwood/board-lsxl.c
@@ -0,0 +1,137 @@
+/*
+ * Copyright 2012 (C), Michael Walle <michael@walle.cc>
+ *
+ * arch/arm/mach-kirkwood/board-lsxl.c
+ *
+ * Buffalo Linkstation LS-XHL and LS-CHLv2 init for drivers not
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
+#include <linux/spi/flash.h>
+#include <linux/spi/spi.h>
+#include <linux/mv643xx_eth.h>
+#include <linux/gpio.h>
+#include <linux/gpio_keys.h>
+#include <linux/gpio-fan.h>
+#include <linux/input.h>
+#include <linux/leds.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <mach/kirkwood.h>
+#include "common.h"
+#include "mpp.h"
+
+static struct mv643xx_eth_platform_data lsxl_ge00_data = {
+	.phy_addr	= MV643XX_ETH_PHY_ADDR(0),
+};
+
+static struct mv643xx_eth_platform_data lsxl_ge01_data = {
+	.phy_addr	= MV643XX_ETH_PHY_ADDR(8),
+};
+
+static unsigned int lsxl_mpp_config[] __initdata = {
+	MPP10_GPO,	/* HDD Power Enable */
+	MPP11_GPIO,	/* USB Vbus Enable */
+	MPP18_GPO,	/* FAN High Enable# */
+	MPP19_GPO,	/* FAN Low Enable# */
+	MPP36_GPIO,	/* Function Blue LED */
+	MPP37_GPIO,	/* Alarm LED */
+	MPP38_GPIO,	/* Info LED */
+	MPP39_GPIO,	/* Power LED */
+	MPP40_GPIO,	/* Fan Lock */
+	MPP41_GPIO,	/* Function Button */
+	MPP42_GPIO,	/* Power Switch */
+	MPP43_GPIO,	/* Power Auto Switch */
+	MPP48_GPIO,	/* Function Red LED */
+	0
+};
+
+#define LSXL_GPIO_FAN_HIGH	18
+#define LSXL_GPIO_FAN_LOW	19
+#define LSXL_GPIO_FAN_LOCK	40
+
+static struct gpio_fan_alarm lsxl_alarm = {
+	.gpio = LSXL_GPIO_FAN_LOCK,
+};
+
+static struct gpio_fan_speed lsxl_speeds[] = {
+	{
+		.rpm = 0,
+		.ctrl_val = 3,
+	}, {
+		.rpm = 1500,
+		.ctrl_val = 1,
+	}, {
+		.rpm = 3250,
+		.ctrl_val = 2,
+	}, {
+		.rpm = 5000,
+		.ctrl_val = 0,
+	}
+};
+
+static int lsxl_gpio_list[] = {
+	LSXL_GPIO_FAN_HIGH, LSXL_GPIO_FAN_LOW,
+};
+
+static struct gpio_fan_platform_data lsxl_fan_data = {
+	.num_ctrl = ARRAY_SIZE(lsxl_gpio_list),
+	.ctrl = lsxl_gpio_list,
+	.alarm = &lsxl_alarm,
+	.num_speed = ARRAY_SIZE(lsxl_speeds),
+	.speed = lsxl_speeds,
+};
+
+static struct platform_device lsxl_fan_device = {
+	.name = "gpio-fan",
+	.id = -1,
+	.num_resources = 0,
+	.dev = {
+		.platform_data = &lsxl_fan_data,
+	},
+};
+
+/*
+ * On the LS-XHL/LS-CHLv2, the shutdown process is following:
+ * - Userland monitors key events until the power switch goes to off position
+ * - The board reboots
+ * - U-boot starts and goes into an idle mode waiting for the user
+ *   to move the switch to ON position
+ *
+ */
+static void lsxl_power_off(void)
+{
+	kirkwood_restart('h', NULL);
+}
+
+#define LSXL_GPIO_HDD_POWER 10
+#define LSXL_GPIO_USB_POWER 11
+
+void __init lsxl_init(void)
+{
+	/*
+	 * Basic setup. Needs to be called early.
+	 */
+	kirkwood_mpp_conf(lsxl_mpp_config);
+
+	/* usb and sata power on */
+	gpio_set_value(LSXL_GPIO_USB_POWER, 1);
+	gpio_set_value(LSXL_GPIO_HDD_POWER, 1);
+
+	kirkwood_ehci_init();
+	kirkwood_ge00_init(&lsxl_ge00_data);
+	kirkwood_ge01_init(&lsxl_ge01_data);
+	platform_device_register(&lsxl_fan_device);
+
+	/* register power-off method */
+	pm_power_off = lsxl_power_off;
+}
diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
index e0c2324..2ef6d19 100644
--- a/arch/arm/mach-kirkwood/common.h
+++ b/arch/arm/mach-kirkwood/common.h
@@ -82,6 +82,12 @@ void ib62x0_init(void);
 static inline void ib62x0_init(void) {};
 #endif
 
+#ifdef CONFIG_MACH_LSXL_DT
+void lsxl_init(void);
+#else
+static inline void lsxl_init(void) {};
+#endif
+
 /* early init functions not converted to fdt yet */
 char *kirkwood_id(void);
 void kirkwood_l2_init(void);
-- 
1.7.2.5
