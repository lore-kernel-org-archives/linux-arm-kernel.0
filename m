From: benoar@dolka.fr (Benjamin Cama)
Date: Tue, 14 Jul 2015 16:54:01 +0200
Subject: [PATCH v2] ARM: dts: Convert Linkstation Mini to Device Tree
Message-ID: <1436885641.7145.9.camel@dolka.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The name of the file better reflects the manufacturer's device name
(LS-WSGL) than the original (lsmini), which exists in a kirkwood version
too.

Signed-off-by: Benjamin Cama <benoar@dolka.fr>
---
Alexey, Thomas,

I need your approval to change the license, as Jason and Andrew
suggested using dual licensing. Do you agree with it?

The changes since the first version are:
* the license change;
* the more precise attribution to Alexey;
* gpio keys are now named, even if I find them not to be the good ones;
  at least they fit with the old numbers and the recently submitted
  LS-WSXL scheme;
* added "earlyprintk" to the command-line

I did not rename the leds to be like LS-WSXL, as they are a bit
different. I also did not take time to look at the NOR flash layout to
separate uboot from the config (that must be all there is in these
256KB).

Hope the patch is OK like that. Sorry for the long delay, I spent quite
some time on the IRQ0 fix, and did not have so much of it lately?

 arch/arm/boot/dts/Makefile           |   3 +-
 arch/arm/boot/dts/orion5x-lswsgl.dts | 276 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-orion5x/Kconfig        |   6 +-
 arch/arm/mach-orion5x/lsmini-setup.c | 280 -----------------------------------
 4 files changed, 281 insertions(+), 284 deletions(-)
 create mode 100644 arch/arm/boot/dts/orion5x-lswsgl.dts
 delete mode 100644 arch/arm/mach-orion5x/lsmini-setup.c

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 992736b..bd5ad2f 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -441,7 +441,8 @@ dtb-$(CONFIG_ARCH_ORION5X) += \
 	orion5x-lacie-d2-network.dtb \
 	orion5x-lacie-ethernet-disk-mini-v2.dtb \
 	orion5x-maxtor-shared-storage-2.dtb \
-	orion5x-rd88f5182-nas.dtb
+	orion5x-rd88f5182-nas.dtb \
+	orion5x-lswsgl.dtb
 dtb-$(CONFIG_ARCH_PRIMA2) += \
 	prima2-evb.dtb
 dtb-$(CONFIG_ARCH_QCOM) += \
diff --git a/arch/arm/boot/dts/orion5x-lswsgl.dts b/arch/arm/boot/dts/orion5x-lswsgl.dts
new file mode 100644
index 0000000..34816a9
--- /dev/null
+++ b/arch/arm/boot/dts/orion5x-lswsgl.dts
@@ -0,0 +1,276 @@
+/*
+ * Copyright (C) 2015 Benjamin Cama <benoar@dolka.fr>
+ * Copyright (C) 2014 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ * Based on the board file arch/arm/mach-orion5x/lsmini-setup.c,
+ * Copyright (C) 2008 Alexey Kopytko <alexey@kopytko.ru>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
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
+	model = "Buffalo Linkstation Mini (LS-WSGL)";
+	compatible = "buffalo,lswsgl", "marvell,orion5x-88f5182", "marvell,orion5x";
+
+	memory {
+		reg = <0x00000000 0x8000000>; /* 128 MB */
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200 earlyprintk";
+		linux,stdout-path = &uart0;
+	};
+
+	soc {
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000>,
+			 <MBUS_ID(0x09, 0x00) 0 0xf2200000 0x800>,
+			 <MBUS_ID(0x01, 0x0f) 0 0xf4000000 0x40000>;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-0 = <&pmx_buttons>;
+		pinctrl-names = "default";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		func {
+			label = "Function Button";
+			linux,code = <KEY_OPTION>;
+			gpios = <&gpio0 15 GPIO_ACTIVE_LOW>;
+		};
+
+		power {
+			label = "Power-on Switch";
+			linux,input-type = <5>; /* EV_SW */
+			linux,code = <KEY_RESERVED>; /* LSMINI_SW_POWER */
+			gpios = <&gpio0 18 GPIO_ACTIVE_LOW>;
+		};
+
+		autopower {
+			label = "Power-auto Switch";
+			linux,input-type = <5>; /* EV_SW */
+			linux,code = <KEY_ESC>; /* LSMINI_SW_AUTOPOWER */
+			gpios = <&gpio0 17 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+		pinctrl-0 = <&pmx_led_alarm &pmx_led_info &pmx_led_func
+			     &pmx_led_power>;
+		pinctrl-names = "default";
+
+		alarm {
+			label = "lswsgl:alarm:red";
+			gpio = <&gpio0 2 GPIO_ACTIVE_LOW>;
+		};
+
+		info {
+			label = "lswsgl:info:amber";
+			gpio = <&gpio0 3 GPIO_ACTIVE_LOW>;
+		};
+
+		func {
+			label = "lswsgl:func:blue:top";
+			gpio = <&gpio0 9 GPIO_ACTIVE_LOW>;
+		};
+
+		power {
+			label = "lswsgl:power:blue:bottom";
+			gpio = <&gpio0 14 GPIO_ACTIVE_LOW>;
+			default-state = "on";
+		};
+	};
+
+	restart_poweroff {
+		compatible = "restart-poweroff";
+	};
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-0 = <&pmx_sata0_power &pmx_sata1_power &pmx_usb_power>;
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
+			gpio = <&gpio0 1 GPIO_ACTIVE_HIGH>;
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
+			gpio = <&gpio0 19 GPIO_ACTIVE_HIGH>;
+		};
+
+		usb_power: regulator at 2 {
+			compatible = "regulator-fixed";
+			reg = <2>;
+			regulator-name = "USB Power";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			enable-active-high;
+			regulator-always-on;
+			regulator-boot-on;
+			gpio = <&gpio0 16 GPIO_ACTIVE_HIGH>;
+		};
+	};
+};
+
+&devbus_bootcs {
+	status = "okay";
+
+	devbus,keep-config;
+
+	flash at 0 {
+		compatible = "cfi-flash";
+		reg = <0 0x40000>;
+		bank-width = <1>;
+                #address-cells = <1>;
+		#size-cells = <1>;
+
+		partition at 0 {
+			label = "Full256Kb";
+			reg = <0 0x40000>;
+			read-only;
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
+&ehci0 {
+	status = "okay";
+};
+
+&eth {
+	status = "okay";
+
+	ethernet-port at 0 {
+		phy-handle = <&ethphy>;
+	};
+};
+
+&i2c {
+	status = "okay";
+	clock-frequency = <100000>;
+	#address-cells = <1>;
+
+	rtc at 32 {
+		compatible = "ricoh,rs5c372a";
+		reg = <0x32>;
+	};
+};
+
+&pinctrl {
+	pmx_buttons: pmx-buttons {
+		marvell,pins = "mpp15", "mpp17", "mpp18";
+		marvell,function = "gpio";
+	};
+
+	pmx_led_alarm: pmx-leds {
+		marvell,pins = "mpp2";
+		marvell,function = "gpio";
+	};
+
+	pmx_led_info: pmx-leds {
+		marvell,pins = "mpp3";
+		marvell,function = "gpio";
+	};
+
+	pmx_led_func: pmx-leds {
+		marvell,pins = "mpp9";
+		marvell,function = "gpio";
+	};
+
+	pmx_led_power: pmx-leds {
+		marvell,pins = "mpp14";
+		marvell,function = "gpio";
+	};
+
+	pmx_sata0_power: pmx-sata0-power {
+		marvell,pins = "mpp1";
+		marvell,function = "gpio";
+	};
+
+	pmx_sata1_power: pmx-sata1-power {
+		marvell,pins = "mpp19";
+		marvell,function = "gpio";
+	};
+
+	pmx_usb_power: pmx-usb-power {
+		marvell,pins = "mpp16";
+		marvell,function = "gpio";
+	};
+};
+
+&sata {
+	status = "okay";
+	nr-ports = <2>;
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm/mach-orion5x/Kconfig b/arch/arm/mach-orion5x/Kconfig
index 2412efb..08d2be2 100644
--- a/arch/arm/mach-orion5x/Kconfig
+++ b/arch/arm/mach-orion5x/Kconfig
@@ -78,11 +78,11 @@ config MACH_LINKSTATION_LSCHL
 	  Buffalo Linkstation Live v3 (LS-CHL) platform.
 
 config MACH_LINKSTATION_MINI
-	bool "Buffalo Linkstation Mini"
-	select I2C_BOARDINFO
+	bool "Buffalo Linkstation Mini (Flattened Device Tree)"
+	select ARCH_ORION5X_DT
 	help
 	  Say 'Y' here if you want your kernel to support the
-	  Buffalo Linkstation Mini platform.
+	  Buffalo Linkstation Mini (LS-WSGL) platform.
 
 config MACH_LINKSTATION_LS_HGL
 	bool "Buffalo Linkstation LS-HGL"
diff --git a/arch/arm/mach-orion5x/lsmini-setup.c b/arch/arm/mach-orion5x/lsmini-setup.c
deleted file mode 100644
index a6493e7..0000000
--- a/arch/arm/mach-orion5x/lsmini-setup.c
+++ /dev/null
@@ -1,280 +0,0 @@
-/*
- * arch/arm/mach-orion5x/lsmini-setup.c
- *
- * Maintainer: Alexey Kopytko <alexey@kopytko.ru>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
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
-#include <mach/orion5x.h>
-#include "common.h"
-#include "mpp.h"
-
-/*****************************************************************************
- * Linkstation Mini Info
- ****************************************************************************/
-
-/*
- * 256K NOR flash Device bus boot chip select
- */
-
-#define LSMINI_NOR_BOOT_BASE	0xf4000000
-#define LSMINI_NOR_BOOT_SIZE	SZ_256K
-
-/*****************************************************************************
- * 256KB NOR Flash on BOOT Device
- ****************************************************************************/
-
-static struct physmap_flash_data lsmini_nor_flash_data = {
-	.width		= 1,
-};
-
-static struct resource lsmini_nor_flash_resource = {
-	.flags	= IORESOURCE_MEM,
-	.start	= LSMINI_NOR_BOOT_BASE,
-	.end	= LSMINI_NOR_BOOT_BASE + LSMINI_NOR_BOOT_SIZE - 1,
-};
-
-static struct platform_device lsmini_nor_flash = {
-	.name			= "physmap-flash",
-	.id			= 0,
-	.dev		= {
-		.platform_data	= &lsmini_nor_flash_data,
-	},
-	.num_resources		= 1,
-	.resource		= &lsmini_nor_flash_resource,
-};
-
-/*****************************************************************************
- * Ethernet
- ****************************************************************************/
-
-static struct mv643xx_eth_platform_data lsmini_eth_data = {
-	.phy_addr	= 8,
-};
-
-/*****************************************************************************
- * RTC 5C372a on I2C bus
- ****************************************************************************/
-
-static struct i2c_board_info __initdata lsmini_i2c_rtc = {
-	I2C_BOARD_INFO("rs5c372a", 0x32),
-};
-
-/*****************************************************************************
- * LEDs attached to GPIO
- ****************************************************************************/
-
-#define LSMINI_GPIO_LED_ALARM	2
-#define LSMINI_GPIO_LED_INFO	3
-#define LSMINI_GPIO_LED_FUNC	9
-#define LSMINI_GPIO_LED_PWR	14
-
-static struct gpio_led lsmini_led_pins[] = {
-	{
-		.name	   = "alarm:red",
-		.gpio	   = LSMINI_GPIO_LED_ALARM,
-		.active_low     = 1,
-	}, {
-		.name	   = "info:amber",
-		.gpio	   = LSMINI_GPIO_LED_INFO,
-		.active_low     = 1,
-	}, {
-		.name	   = "func:blue:top",
-		.gpio	   = LSMINI_GPIO_LED_FUNC,
-		.active_low     = 1,
-	}, {
-		.name	   = "power:blue:bottom",
-		.gpio	   = LSMINI_GPIO_LED_PWR,
-	},
-};
-
-static struct gpio_led_platform_data lsmini_led_data = {
-	.leds	   = lsmini_led_pins,
-	.num_leds       = ARRAY_SIZE(lsmini_led_pins),
-};
-
-static struct platform_device lsmini_leds = {
-	.name   = "leds-gpio",
-	.id     = -1,
-	.dev    = {
-		.platform_data  = &lsmini_led_data,
-	},
-};
-
-/****************************************************************************
- * GPIO Attached Keys
- ****************************************************************************/
-
-#define LSMINI_GPIO_KEY_FUNC       15
-#define LSMINI_GPIO_KEY_POWER	   18
-#define LSMINI_GPIO_KEY_AUTOPOWER 17
-
-#define LSMINI_SW_POWER		0x00
-#define LSMINI_SW_AUTOPOWER	0x01
-
-static struct gpio_keys_button lsmini_buttons[] = {
-	{
-		.code	   = KEY_OPTION,
-		.gpio	   = LSMINI_GPIO_KEY_FUNC,
-		.desc	   = "Function Button",
-		.active_low     = 1,
-	}, {
-		.type		= EV_SW,
-		.code	   = LSMINI_SW_POWER,
-		.gpio	   = LSMINI_GPIO_KEY_POWER,
-		.desc	   = "Power-on Switch",
-		.active_low     = 1,
-	}, {
-		.type		= EV_SW,
-		.code	   = LSMINI_SW_AUTOPOWER,
-		.gpio	   = LSMINI_GPIO_KEY_AUTOPOWER,
-		.desc	   = "Power-auto Switch",
-		.active_low     = 1,
-	},
-};
-
-static struct gpio_keys_platform_data lsmini_button_data = {
-	.buttons	= lsmini_buttons,
-	.nbuttons       = ARRAY_SIZE(lsmini_buttons),
-};
-
-static struct platform_device lsmini_button_device = {
-	.name	   = "gpio-keys",
-	.id	     = -1,
-	.num_resources  = 0,
-	.dev	    = {
-		.platform_data  = &lsmini_button_data,
-	},
-};
-
-
-/*****************************************************************************
- * SATA
- ****************************************************************************/
-static struct mv_sata_platform_data lsmini_sata_data = {
-	.n_ports	= 2,
-};
-
-
-/*****************************************************************************
- * Linkstation Mini specific power off method: reboot
- ****************************************************************************/
-/*
- * On the Linkstation Mini, the shutdown process is following:
- * - Userland monitors key events until the power switch goes to off position
- * - The board reboots
- * - U-boot starts and goes into an idle mode waiting for the user
- *   to move the switch to ON position
- */
-
-static void lsmini_power_off(void)
-{
-	orion5x_restart(REBOOT_HARD, NULL);
-}
-
-
-/*****************************************************************************
- * General Setup
- ****************************************************************************/
-
-#define LSMINI_GPIO_USB_POWER	16
-#define LSMINI_GPIO_AUTO_POWER	17
-#define LSMINI_GPIO_POWER	18
-
-#define LSMINI_GPIO_HDD_POWER0	1
-#define LSMINI_GPIO_HDD_POWER1	19
-
-static unsigned int lsmini_mpp_modes[] __initdata = {
-	MPP0_UNUSED, /* LED_RESERVE1 (unused) */
-	MPP1_GPIO, /* HDD_PWR */
-	MPP2_GPIO, /* LED_ALARM */
-	MPP3_GPIO, /* LED_INFO */
-	MPP4_UNUSED,
-	MPP5_UNUSED,
-	MPP6_UNUSED,
-	MPP7_UNUSED,
-	MPP8_UNUSED,
-	MPP9_GPIO, /* LED_FUNC */
-	MPP10_UNUSED,
-	MPP11_UNUSED, /* LED_ETH (dummy) */
-	MPP12_UNUSED,
-	MPP13_UNUSED,
-	MPP14_GPIO, /* LED_PWR */
-	MPP15_GPIO, /* FUNC */
-	MPP16_GPIO, /* USB_PWR */
-	MPP17_GPIO, /* AUTO_POWER */
-	MPP18_GPIO, /* POWER */
-	MPP19_GPIO, /* HDD_PWR1 */
-	0,
-};
-
-static void __init lsmini_init(void)
-{
-	/*
-	 * Setup basic Orion functions. Need to be called early.
-	 */
-	orion5x_init();
-
-	orion5x_mpp_conf(lsmini_mpp_modes);
-
-	/*
-	 * Configure peripherals.
-	 */
-	orion5x_ehci0_init();
-	orion5x_ehci1_init();
-	orion5x_eth_init(&lsmini_eth_data);
-	orion5x_i2c_init();
-	orion5x_sata_init(&lsmini_sata_data);
-	orion5x_uart0_init();
-	orion5x_xor_init();
-
-	mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_BOOT_TARGET,
-				    ORION_MBUS_DEVBUS_BOOT_ATTR,
-				    LSMINI_NOR_BOOT_BASE,
-				    LSMINI_NOR_BOOT_SIZE);
-	platform_device_register(&lsmini_nor_flash);
-
-	platform_device_register(&lsmini_button_device);
-
-	platform_device_register(&lsmini_leds);
-
-	i2c_register_board_info(0, &lsmini_i2c_rtc, 1);
-
-	/* enable USB power */
-	gpio_set_value(LSMINI_GPIO_USB_POWER, 1);
-
-	/* register power-off method */
-	pm_power_off = lsmini_power_off;
-
-	pr_info("%s: finished\n", __func__);
-}
-
-#ifdef CONFIG_MACH_LINKSTATION_MINI
-MACHINE_START(LINKSTATION_MINI, "Buffalo Linkstation Mini")
-	/* Maintainer: Alexey Kopytko <alexey@kopytko.ru> */
-	.atag_offset	= 0x100,
-	.init_machine	= lsmini_init,
-	.map_io		= orion5x_map_io,
-	.init_early	= orion5x_init_early,
-	.init_irq	= orion5x_init_irq,
-	.init_time	= orion5x_timer_init,
-	.fixup		= tag_fixup_mem32,
-	.restart	= orion5x_restart,
-MACHINE_END
-#endif
-- 
2.1.4
