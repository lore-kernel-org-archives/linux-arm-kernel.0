From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 13 Apr 2014 16:40:04 +0200
Subject: [PATCH 27/29] ARM: orion5x: convert d2net to Device Tree
In-Reply-To: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1397400006-4315-28-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit converts the LaCie d2 Network platform to the Device Tree.

All devices except LEDs are converted, because the LED code needs a
non-LED GPIO to be set to a given value for the LEDs to work, and this
cannot yet be easily represented in DT.

Also, references to the LaCie Big Disk Network platform are lost,
because this platform apparently has exactly the same hardware support
as the LaCie d2 Network, so their Device Tree files would be
identical.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/Makefile                     |   3 +-
 arch/arm/boot/dts/orion5x-lacie-d2-network.dts | 234 ++++++++++++++++
 arch/arm/boot/dts/orion5x-rd88f5182-nas.dts    |   4 +-
 arch/arm/mach-orion5x/Kconfig                  |  13 +-
 arch/arm/mach-orion5x/Makefile                 |   3 +-
 arch/arm/mach-orion5x/board-d2net.c            | 109 ++++++++
 arch/arm/mach-orion5x/d2net-setup.c            | 365 -------------------------
 7 files changed, 352 insertions(+), 379 deletions(-)
 create mode 100644 arch/arm/boot/dts/orion5x-lacie-d2-network.dts
 create mode 100644 arch/arm/mach-orion5x/board-d2net.c
 delete mode 100644 arch/arm/mach-orion5x/d2net-setup.c

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index f7943a8..59397c2 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -289,7 +289,8 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
 	am43x-epos-evm.dtb \
 	am437x-gp-evm.dtb \
 	dra7-evm.dtb
-dtb-$(CONFIG_ARCH_ORION5X) += orion5x-lacie-ethernet-disk-mini-v2.dtb \
+dtb-$(CONFIG_ARCH_ORION5X) += orion5x-lacie-d2-network.dtb \
+	orion5x-lacie-ethernet-disk-mini-v2.dtb \
 	orion5x-rd88f5182-nas.dtb
 dtb-$(CONFIG_ARCH_PRIMA2) += prima2-evb.dtb
 dtb-$(CONFIG_ARCH_QCOM) += qcom-msm8660-surf.dtb \
diff --git a/arch/arm/boot/dts/orion5x-lacie-d2-network.dts b/arch/arm/boot/dts/orion5x-lacie-d2-network.dts
new file mode 100644
index 0000000..bb67ddd
--- /dev/null
+++ b/arch/arm/boot/dts/orion5x-lacie-d2-network.dts
@@ -0,0 +1,234 @@
+/*
+ * Copyright (C) 2014 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ * Copyright (C) 2009 Simon Guinot <sguinot@lacie.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include "orion5x-mv88f5182.dtsi"
+
+/ {
+	model = "LaCie d2 Network";
+	compatible = "lacie,d2-network", "marvell,orion5x-88f5182", "marvell,orion5x";
+
+	soc {
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000>,
+			 <MBUS_ID(0x09, 0x00) 0 0xf2200000 0x800>,
+			 <MBUS_ID(0x01, 0x0f) 0 0xfff80000 0x80000>;
+
+		devbus-bootcs {
+			status = "okay";
+
+			devbus,keep-config;
+
+			/*
+			 * Currently the MTD code does not recognize
+			 * the MX29LV400CBCT as a bottom-type
+			 * device. This could cause risks of
+			 * accidentally erasing critical flash
+			 * sectors. We thus define a single,
+			 * write-protected partition covering the
+			 * whole flash.  TODO: once the flash part
+			 * TOP/BOTTOM detection issue is sorted out in
+			 * the MTD code, break this into at least
+			 * three partitions: 'u-boot code', 'u-boot
+			 * environment' and 'whatever is left'.
+			 */
+			nor at 0 {
+				compatible = "cfi-flash";
+				reg = <0 0x80000>;
+				bank-width = <1>;
+		                #address-cells = <1>;
+				#size-cells = <1>;
+
+				partition at 0 {
+					label = "Full512Kb";
+					reg = <0 0x80000>;
+					read-only;
+				};
+			};
+		};
+
+		internal-regs {
+			pinctrl at 10000 {
+				pinctrl-0 = <&pmx_leds &pmx_board_id &pmx_fan_fail>;
+				pinctrl-names = "default";
+
+				pmx_buttons: pmx-buttons {
+					marvell,pins = "mpp8", "mpp9", "mpp18";
+					marvell,function = "gpio";
+				};
+
+				/*
+				 * MPP6: Red front LED
+				 * MPP16: Blue front LED blink control
+				 */
+				pmx_leds: pmx-leds {
+					marvell,pins = "mpp6", "mpp16";
+					marvell,function = "gpio";
+				};
+
+				pmx_board_id: pmx-board-id {
+					marvell,pins = "mpp0", "mpp1", "mpp2";
+					marvell,function = "gpio";
+				};
+
+				pmx_sata0_power: pmx-sata0-power {
+					marvell,pins = "mpp3";
+					marvell,function = "gpio";
+				};
+
+				pmx_sata1_power: pmx-sata1-power {
+					marvell,pins = "mpp12";
+					marvell,function = "gpio";
+				};
+
+				pmx_sata0_led_active: pmx-sata0-led-active {
+					marvell,pins = "mpp14";
+					marvell,function = "sata0";
+				};
+
+				pmx_sata1_led_active: pmx-sata1-led-active {
+					marvell,pins = "mpp15";
+					marvell,function = "sata1";
+				};
+
+				pmx_fan_fail: pmx-fan-fail {
+					marvell,pins = "mpp5";
+					marvell,function = "gpio";
+				};
+
+				/*
+				 * Non MPP GPIOs:
+				 *  GPIO 22: USB port 1 fuse (0 = Fail, 1 = Ok)
+				 *  GPIO 23: Blue front LED off
+				 *  GPIO 24: Inhibit board power off (0 = Disabled, 1 = Enabled)
+				 */
+			};
+
+
+			i2c at 11000 {
+				status = "okay";
+				clock-frequency = <100000>;
+				#address-cells = <1>;
+
+				rtc at 32 {
+					compatible = "rs5c372b";
+					reg = <0x32>;
+				};
+
+				fan at 3e {
+					compatible = "gmt,g762";
+					reg = <0x3e>;
+
+					/* Not enough HW info */
+					status = "disabled";
+				};
+
+				eeprom at 50 {
+					compatible = "24c08";
+					reg = <0x50>;
+				};
+			};
+
+			serial at 12000 {
+				clock-frequency = <166666667>;
+				status = "okay";
+			};
+
+			ehci at 50000 {
+				status = "okay";
+			};
+
+			sata at 80000 {
+				pinctrl-0 = <&pmx_sata0_led_active
+					     &pmx_sata1_led_active>;
+				pinctrl-names = "default";
+				status = "okay";
+				nr-ports = <2>;
+			};
+		};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		pinctrl-0 = <&pmx_buttons>;
+		pinctrl-names = "default";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		front_button {
+			label = "Front Push Button";
+			linux,code = <KEY_POWER>;
+			gpios = <&gpio0 18 GPIO_ACTIVE_HIGH>;
+		};
+
+		power_rocker_sw_on {
+			label = "Power rocker switch (on|auto)";
+			linux,input-type = <5>; /* EV_SW */
+			linux,code = <1>; /* D2NET_SWITCH_POWER_ON */
+			gpios = <&gpio0 8 GPIO_ACTIVE_HIGH>;
+		};
+
+		power_rocker_sw_off {
+			label = "Power rocker switch (auto|off)";
+			linux,input-type = <5>; /* EV_SW */
+			linux,code = <2>; /* D2NET_SWITCH_POWER_OFF */
+			gpios = <&gpio0 9 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-0 = <&pmx_sata0_power &pmx_sata1_power>;
+		pinctrl-names = "default";
+
+		sata0_power: regulator at 0 {
+			compatible = "regulator-fixed";
+			reg = <0>;
+			regulator-name = "SATA0 Power";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			enable-active-high;
+			regulator-always-on;
+			regulator-boot-on;
+			gpio = <&gpio0 3 GPIO_ACTIVE_HIGH>;
+		};
+
+		sata1_power: regulator at 1 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "SATA1 Power";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			enable-active-high;
+			regulator-always-on;
+			regulator-boot-on;
+			gpio = <&gpio0 12 GPIO_ACTIVE_HIGH>;
+		};
+	};
+};
+
+&mdio {
+	status = "okay";
+
+	ethphy: ethernet-phy {
+		reg = <8>;
+	};
+};
+
+&eth {
+	status = "okay";
+
+	ethernet-port at 0 {
+		phy-handle = <&ethphy>;
+	};
+};
diff --git a/arch/arm/boot/dts/orion5x-rd88f5182-nas.dts b/arch/arm/boot/dts/orion5x-rd88f5182-nas.dts
index b5fd087..b1a8330 100644
--- a/arch/arm/boot/dts/orion5x-rd88f5182-nas.dts
+++ b/arch/arm/boot/dts/orion5x-rd88f5182-nas.dts
@@ -7,6 +7,8 @@
  */
 
 /dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
 #include "orion5x-mv88f5182.dtsi"
 
 / {
@@ -131,7 +133,7 @@
 		led at 0 {
 			label = "rd88f5182:cpu";
 			linux,default-trigger = "heartbeat";
-			gpios = <&gpio0 0 0>;
+			gpios = <&gpio0 0 GPIO_ACTIVE_HIGH>;
 		};
 	};
 };
diff --git a/arch/arm/mach-orion5x/Kconfig b/arch/arm/mach-orion5x/Kconfig
index 11b0c7e..3c4ad83 100644
--- a/arch/arm/mach-orion5x/Kconfig
+++ b/arch/arm/mach-orion5x/Kconfig
@@ -115,20 +115,13 @@ config MACH_MV2120
 	  Say 'Y' here if you want your kernel to support the
 	  HP Media Vault mv2120 or mv5100.
 
-config MACH_D2NET
-	bool "LaCie d2 Network"
-	select I2C_BOARDINFO
+config MACH_D2NET_DT
+	bool "LaCie d2 Network / Big Disk Network (Flattened Device Tree)"
+	select ARCH_ORION5X_DT
 	help
 	  Say 'Y' here if you want your kernel to support the
 	  LaCie d2 Network NAS.
 
-config MACH_BIGDISK
-	bool "LaCie Big Disk Network"
-	select I2C_BOARDINFO
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  LaCie Big Disk Network NAS.
-
 config MACH_NET2BIG
 	bool "LaCie 2Big Network"
 	select I2C_BOARDINFO
diff --git a/arch/arm/mach-orion5x/Makefile b/arch/arm/mach-orion5x/Makefile
index f405894..787dcee 100644
--- a/arch/arm/mach-orion5x/Makefile
+++ b/arch/arm/mach-orion5x/Makefile
@@ -12,8 +12,6 @@ obj-$(CONFIG_MACH_TS409)	+= ts409-setup.o tsx09-common.o
 obj-$(CONFIG_MACH_WRT350N_V2)	+= wrt350n-v2-setup.o
 obj-$(CONFIG_MACH_TS78XX)	+= ts78xx-setup.o
 obj-$(CONFIG_MACH_MV2120)	+= mv2120-setup.o
-obj-$(CONFIG_MACH_D2NET)	+= d2net-setup.o
-obj-$(CONFIG_MACH_BIGDISK)	+= d2net-setup.o
 obj-$(CONFIG_MACH_NET2BIG)	+= net2big-setup.o
 obj-$(CONFIG_MACH_MSS2)		+= mss2-setup.o
 obj-$(CONFIG_MACH_WNR854T)	+= wnr854t-setup.o
@@ -23,4 +21,5 @@ obj-$(CONFIG_MACH_RD88F6183AP_GE)	+= rd88f6183ap-ge-setup.o
 obj-$(CONFIG_MACH_LINKSTATION_LSCHL)	+= ls-chl-setup.o
 
 obj-$(CONFIG_ARCH_ORION5X_DT)		+= board-dt.o
+obj-$(CONFIG_MACH_D2NET_DT)	+= board-d2net.o
 obj-$(CONFIG_MACH_RD88F5182_DT)	+= board-rd88f5182.o
diff --git a/arch/arm/mach-orion5x/board-d2net.c b/arch/arm/mach-orion5x/board-d2net.c
new file mode 100644
index 0000000..8a72841
--- /dev/null
+++ b/arch/arm/mach-orion5x/board-d2net.c
@@ -0,0 +1,109 @@
+/*
+ * arch/arm/mach-orion5x/board-d2net.c
+ *
+ * LaCie d2Network and Big Disk Network NAS setup
+ *
+ * Copyright (C) 2009 Simon Guinot <sguinot@lacie.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/pci.h>
+#include <linux/irq.h>
+#include <linux/leds.h>
+#include <linux/gpio.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/pci.h>
+#include <mach/orion5x.h>
+#include <plat/orion-gpio.h>
+#include "common.h"
+
+/*****************************************************************************
+ * LaCie d2 Network Info
+ ****************************************************************************/
+
+/*****************************************************************************
+ * GPIO LED's
+ ****************************************************************************/
+
+/*
+ * The blue front LED is wired to the CPLD and can blink in relation with the
+ * SATA activity.
+ *
+ * The following array detail the different LED registers and the combination
+ * of their possible values:
+ *
+ * led_off   | blink_ctrl | SATA active | LED state
+ *           |            |             |
+ *    1      |     x      |      x      |  off
+ *    0      |     0      |      0      |  off
+ *    0      |     1      |      0      |  blink (rate 300ms)
+ *    0      |     x      |      1      |  on
+ *
+ * Notes: The blue and the red front LED's can't be on at the same time.
+ *        Red LED have priority.
+ */
+
+#define D2NET_GPIO_RED_LED		6
+#define D2NET_GPIO_BLUE_LED_BLINK_CTRL	16
+#define D2NET_GPIO_BLUE_LED_OFF		23
+
+static struct gpio_led d2net_leds[] = {
+	{
+		.name = "d2net:blue:sata",
+		.default_trigger = "default-on",
+		.gpio = D2NET_GPIO_BLUE_LED_OFF,
+		.active_low = 1,
+	},
+	{
+		.name = "d2net:red:fail",
+		.gpio = D2NET_GPIO_RED_LED,
+	},
+};
+
+static struct gpio_led_platform_data d2net_led_data = {
+	.num_leds = ARRAY_SIZE(d2net_leds),
+	.leds = d2net_leds,
+};
+
+static struct platform_device d2net_gpio_leds = {
+	.name           = "leds-gpio",
+	.id             = -1,
+	.dev            = {
+		.platform_data  = &d2net_led_data,
+	},
+};
+
+static void __init d2net_gpio_leds_init(void)
+{
+	int err;
+
+	/* Configure register blink_ctrl to allow SATA activity LED blinking. */
+	err = gpio_request(D2NET_GPIO_BLUE_LED_BLINK_CTRL, "blue LED blink");
+	if (err == 0) {
+		err = gpio_direction_output(D2NET_GPIO_BLUE_LED_BLINK_CTRL, 1);
+		if (err)
+			gpio_free(D2NET_GPIO_BLUE_LED_BLINK_CTRL);
+	}
+	if (err)
+		pr_err("d2net: failed to configure blue LED blink GPIO\n");
+
+	platform_device_register(&d2net_gpio_leds);
+}
+
+/*****************************************************************************
+ * General Setup
+ ****************************************************************************/
+
+void __init d2net_init(void)
+{
+	d2net_gpio_leds_init();
+
+	pr_notice("d2net: Flash write are not yet supported.\n");
+}
diff --git a/arch/arm/mach-orion5x/d2net-setup.c b/arch/arm/mach-orion5x/d2net-setup.c
deleted file mode 100644
index 8f68b74..0000000
--- a/arch/arm/mach-orion5x/d2net-setup.c
+++ /dev/null
@@ -1,365 +0,0 @@
-/*
- * arch/arm/mach-orion5x/d2net-setup.c
- *
- * LaCie d2Network and Big Disk Network NAS setup
- *
- * Copyright (C) 2009 Simon Guinot <sguinot@lacie.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/pci.h>
-#include <linux/irq.h>
-#include <linux/mtd/physmap.h>
-#include <linux/mv643xx_eth.h>
-#include <linux/leds.h>
-#include <linux/gpio_keys.h>
-#include <linux/input.h>
-#include <linux/i2c.h>
-#include <linux/ata_platform.h>
-#include <linux/gpio.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/pci.h>
-#include <mach/orion5x.h>
-#include <plat/orion-gpio.h>
-#include "common.h"
-#include "mpp.h"
-
-/*****************************************************************************
- * LaCie d2 Network Info
- ****************************************************************************/
-
-/*
- * 512KB NOR flash Device bus boot chip select
- */
-
-#define D2NET_NOR_BOOT_BASE		0xfff80000
-#define D2NET_NOR_BOOT_SIZE		SZ_512K
-
-/*****************************************************************************
- * 512KB NOR Flash on Boot Device
- ****************************************************************************/
-
-/*
- * TODO: Check write support on flash MX29LV400CBTC-70G
- */
-
-static struct mtd_partition d2net_partitions[] = {
-	{
-		.name		= "Full512kb",
-		.size		= MTDPART_SIZ_FULL,
-		.offset		= 0,
-		.mask_flags	= MTD_WRITEABLE,
-	},
-};
-
-static struct physmap_flash_data d2net_nor_flash_data = {
-	.width		= 1,
-	.parts		= d2net_partitions,
-	.nr_parts	= ARRAY_SIZE(d2net_partitions),
-};
-
-static struct resource d2net_nor_flash_resource = {
-	.flags			= IORESOURCE_MEM,
-	.start			= D2NET_NOR_BOOT_BASE,
-	.end			= D2NET_NOR_BOOT_BASE
-					+ D2NET_NOR_BOOT_SIZE - 1,
-};
-
-static struct platform_device d2net_nor_flash = {
-	.name			= "physmap-flash",
-	.id			= 0,
-	.dev		= {
-		.platform_data	= &d2net_nor_flash_data,
-	},
-	.num_resources		= 1,
-	.resource		= &d2net_nor_flash_resource,
-};
-
-/*****************************************************************************
- * Ethernet
- ****************************************************************************/
-
-static struct mv643xx_eth_platform_data d2net_eth_data = {
-	.phy_addr	= MV643XX_ETH_PHY_ADDR(8),
-};
-
-/*****************************************************************************
- * I2C devices
- ****************************************************************************/
-
-/*
- * i2c addr | chip         | description
- * 0x32     | Ricoh 5C372b | RTC
- * 0x3e     | GMT G762     | PWM fan controller
- * 0x50     | HT24LC08     | eeprom (1kB)
- *
- * TODO: Add G762 support to the g760a driver.
- */
-static struct i2c_board_info __initdata d2net_i2c_devices[] = {
-	{
-		I2C_BOARD_INFO("rs5c372b", 0x32),
-	}, {
-		I2C_BOARD_INFO("24c08", 0x50),
-	},
-};
-
-/*****************************************************************************
- * SATA
- ****************************************************************************/
-
-static struct mv_sata_platform_data d2net_sata_data = {
-	.n_ports	= 2,
-};
-
-#define D2NET_GPIO_SATA0_POWER	3
-#define D2NET_GPIO_SATA1_POWER	12
-
-static void __init d2net_sata_power_init(void)
-{
-	int err;
-
-	err = gpio_request(D2NET_GPIO_SATA0_POWER, "SATA0 power");
-	if (err == 0) {
-		err = gpio_direction_output(D2NET_GPIO_SATA0_POWER, 1);
-		if (err)
-			gpio_free(D2NET_GPIO_SATA0_POWER);
-	}
-	if (err)
-		pr_err("d2net: failed to configure SATA0 power GPIO\n");
-
-	err = gpio_request(D2NET_GPIO_SATA1_POWER, "SATA1 power");
-	if (err == 0) {
-		err = gpio_direction_output(D2NET_GPIO_SATA1_POWER, 1);
-		if (err)
-			gpio_free(D2NET_GPIO_SATA1_POWER);
-	}
-	if (err)
-		pr_err("d2net: failed to configure SATA1 power GPIO\n");
-}
-
-/*****************************************************************************
- * GPIO LED's
- ****************************************************************************/
-
-/*
- * The blue front LED is wired to the CPLD and can blink in relation with the
- * SATA activity.
- *
- * The following array detail the different LED registers and the combination
- * of their possible values:
- *
- * led_off   | blink_ctrl | SATA active | LED state
- *           |            |             |
- *    1      |     x      |      x      |  off
- *    0      |     0      |      0      |  off
- *    0      |     1      |      0      |  blink (rate 300ms)
- *    0      |     x      |      1      |  on
- *
- * Notes: The blue and the red front LED's can't be on at the same time.
- *        Red LED have priority.
- */
-
-#define D2NET_GPIO_RED_LED		6
-#define D2NET_GPIO_BLUE_LED_BLINK_CTRL	16
-#define D2NET_GPIO_BLUE_LED_OFF		23
-
-static struct gpio_led d2net_leds[] = {
-	{
-		.name = "d2net:blue:sata",
-		.default_trigger = "default-on",
-		.gpio = D2NET_GPIO_BLUE_LED_OFF,
-		.active_low = 1,
-	},
-	{
-		.name = "d2net:red:fail",
-		.gpio = D2NET_GPIO_RED_LED,
-	},
-};
-
-static struct gpio_led_platform_data d2net_led_data = {
-	.num_leds = ARRAY_SIZE(d2net_leds),
-	.leds = d2net_leds,
-};
-
-static struct platform_device d2net_gpio_leds = {
-	.name           = "leds-gpio",
-	.id             = -1,
-	.dev            = {
-		.platform_data  = &d2net_led_data,
-	},
-};
-
-static void __init d2net_gpio_leds_init(void)
-{
-	int err;
-
-	/* Configure GPIO over MPP max number. */
-	orion_gpio_set_valid(D2NET_GPIO_BLUE_LED_OFF, 1);
-
-	/* Configure register blink_ctrl to allow SATA activity LED blinking. */
-	err = gpio_request(D2NET_GPIO_BLUE_LED_BLINK_CTRL, "blue LED blink");
-	if (err == 0) {
-		err = gpio_direction_output(D2NET_GPIO_BLUE_LED_BLINK_CTRL, 1);
-		if (err)
-			gpio_free(D2NET_GPIO_BLUE_LED_BLINK_CTRL);
-	}
-	if (err)
-		pr_err("d2net: failed to configure blue LED blink GPIO\n");
-
-	platform_device_register(&d2net_gpio_leds);
-}
-
-/****************************************************************************
- * GPIO keys
- ****************************************************************************/
-
-#define D2NET_GPIO_PUSH_BUTTON		18
-#define D2NET_GPIO_POWER_SWITCH_ON	8
-#define D2NET_GPIO_POWER_SWITCH_OFF	9
-
-#define D2NET_SWITCH_POWER_ON		0x1
-#define D2NET_SWITCH_POWER_OFF		0x2
-
-static struct gpio_keys_button d2net_buttons[] = {
-	{
-		.type		= EV_SW,
-		.code		= D2NET_SWITCH_POWER_OFF,
-		.gpio		= D2NET_GPIO_POWER_SWITCH_OFF,
-		.desc		= "Power rocker switch (auto|off)",
-		.active_low	= 0,
-	},
-	{
-		.type		= EV_SW,
-		.code		= D2NET_SWITCH_POWER_ON,
-		.gpio		= D2NET_GPIO_POWER_SWITCH_ON,
-		.desc		= "Power rocker switch (on|auto)",
-		.active_low	= 0,
-	},
-	{
-		.type		= EV_KEY,
-		.code		= KEY_POWER,
-		.gpio		= D2NET_GPIO_PUSH_BUTTON,
-		.desc		= "Front Push Button",
-		.active_low	= 0,
-	},
-};
-
-static struct gpio_keys_platform_data d2net_button_data = {
-	.buttons	= d2net_buttons,
-	.nbuttons	= ARRAY_SIZE(d2net_buttons),
-};
-
-static struct platform_device d2net_gpio_buttons = {
-	.name		= "gpio-keys",
-	.id		= -1,
-	.dev		= {
-		.platform_data	= &d2net_button_data,
-	},
-};
-
-/*****************************************************************************
- * General Setup
- ****************************************************************************/
-
-static unsigned int d2net_mpp_modes[] __initdata = {
-	MPP0_GPIO,	/* Board ID (bit 0) */
-	MPP1_GPIO,	/* Board ID (bit 1) */
-	MPP2_GPIO,	/* Board ID (bit 2) */
-	MPP3_GPIO,	/* SATA 0 power */
-	MPP4_UNUSED,
-	MPP5_GPIO,	/* Fan fail detection */
-	MPP6_GPIO,	/* Red front LED */
-	MPP7_UNUSED,
-	MPP8_GPIO,	/* Rear power switch (on|auto) */
-	MPP9_GPIO,	/* Rear power switch (auto|off) */
-	MPP10_UNUSED,
-	MPP11_UNUSED,
-	MPP12_GPIO,	/* SATA 1 power */
-	MPP13_UNUSED,
-	MPP14_SATA_LED,	/* SATA 0 active */
-	MPP15_SATA_LED,	/* SATA 1 active */
-	MPP16_GPIO,	/* Blue front LED blink control */
-	MPP17_UNUSED,
-	MPP18_GPIO,	/* Front button (0 = Released, 1 = Pushed ) */
-	MPP19_UNUSED,
-	0,
-	/* 22: USB port 1 fuse (0 = Fail, 1 = Ok) */
-	/* 23: Blue front LED off */
-	/* 24: Inhibit board power off (0 = Disabled, 1 = Enabled) */
-};
-
-#define D2NET_GPIO_INHIBIT_POWER_OFF    24
-
-static void __init d2net_init(void)
-{
-	/*
-	 * Setup basic Orion functions. Need to be called early.
-	 */
-	orion5x_init();
-
-	orion5x_mpp_conf(d2net_mpp_modes);
-
-	/*
-	 * Configure peripherals.
-	 */
-	orion5x_ehci0_init();
-	orion5x_eth_init(&d2net_eth_data);
-	orion5x_i2c_init();
-	orion5x_uart0_init();
-
-	d2net_sata_power_init();
-	orion5x_sata_init(&d2net_sata_data);
-
-	mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_BOOT_TARGET,
-				    ORION_MBUS_DEVBUS_BOOT_ATTR,
-				    D2NET_NOR_BOOT_BASE,
-				    D2NET_NOR_BOOT_SIZE);
-	platform_device_register(&d2net_nor_flash);
-
-	platform_device_register(&d2net_gpio_buttons);
-
-	d2net_gpio_leds_init();
-
-	pr_notice("d2net: Flash write are not yet supported.\n");
-
-	i2c_register_board_info(0, d2net_i2c_devices,
-				ARRAY_SIZE(d2net_i2c_devices));
-
-	orion_gpio_set_valid(D2NET_GPIO_INHIBIT_POWER_OFF, 1);
-}
-
-/* Warning: LaCie use a wrong mach-type (0x20e=526) in their bootloader. */
-
-#ifdef CONFIG_MACH_D2NET
-MACHINE_START(D2NET, "LaCie d2 Network")
-	.atag_offset	= 0x100,
-	.init_machine	= d2net_init,
-	.map_io		= orion5x_map_io,
-	.init_early	= orion5x_init_early,
-	.init_irq	= orion5x_init_irq,
-	.init_time	= orion5x_timer_init,
-	.fixup		= tag_fixup_mem32,
-	.restart	= orion5x_restart,
-MACHINE_END
-#endif
-
-#ifdef CONFIG_MACH_BIGDISK
-MACHINE_START(BIGDISK, "LaCie Big Disk Network")
-	.atag_offset	= 0x100,
-	.init_machine	= d2net_init,
-	.map_io		= orion5x_map_io,
-	.init_early	= orion5x_init_early,
-	.init_irq	= orion5x_init_irq,
-	.init_time	= orion5x_timer_init,
-	.fixup		= tag_fixup_mem32,
-	.restart	= orion5x_restart,
-MACHINE_END
-#endif
-
-- 
1.8.3.2
