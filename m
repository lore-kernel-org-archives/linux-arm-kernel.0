From: rogershimizu@gmail.com (Roger Shimizu)
Date: Tue, 14 Jul 2015 22:00:01 +0900
Subject: [PATCH 1/2] ARM: dts: add buffalo linkstation ls-wtgl
In-Reply-To: <1436878802-25712-1-git-send-email-rogershimizu@gmail.com>
References: <1436878802-25712-1-git-send-email-rogershimizu@gmail.com>
Message-ID: <1436878802-25712-2-git-send-email-rogershimizu@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add dts file to support Buffalo Linkstation LS-WTGL,
which is marvell orion5x based 2-bay 3.5" HDD NAS.
Product info:
 - (JPN) http://buffalo.jp/products/catalog/storage/ls-wtgl_r1/
 - (ENG) http://www.buffalotech.com/support-and-downloads/download/LinkStation_Pro_Duo_Manual_web.pdf

Signed-off-by: Roger Shimizu <rogershimizu@gmail.com>
---
 arch/arm/boot/dts/Makefile                       |   1 +
 arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts | 242 +++++++++++++++++++++++
 2 files changed, 243 insertions(+)
 create mode 100644 arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index a8bf702..f3ddfa0 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -464,6 +464,7 @@ dtb-$(CONFIG_SOC_DRA7XX) += \
 dtb-$(CONFIG_ARCH_ORION5X) += \
 	orion5x-lacie-d2-network.dtb \
 	orion5x-lacie-ethernet-disk-mini-v2.dtb \
+	orion5x-linkstation-lswtgl.dtb \
 	orion5x-maxtor-shared-storage-2.dtb \
 	orion5x-rd88f5182-nas.dtb
 dtb-$(CONFIG_ARCH_PRIMA2) += \
diff --git a/arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts b/arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts
new file mode 100644
index 0000000..6d021bd
--- /dev/null
+++ b/arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts
@@ -0,0 +1,242 @@
+/*
+ * Device Tree file for Buffalo Linkstation LS-WTGL
+ *
+ * Copyright (C) 2015, Roger Shimizu <rogershimizu@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include "orion5x-mv88f5182.dtsi"
+
+/ {
+	model = "Buffalo Linkstation LS-WTGL";
+	compatible = "buffalo,lswtgl", "marvell,orion5x-88f5182", "marvell,orion5x";
+
+	memory { /* 64 MB */
+		device_type = "memory";
+		reg = <0x00000000 0x4000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8 earlyprintk";
+		linux,stdout-path = &uart0;
+	};
+
+	soc {
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000>,
+		         <MBUS_ID(0x09, 0x00) 0 0xf2200000 0x800>,
+			 <MBUS_ID(0x01, 0x0f) 0 0xf4000000 0x40000>;
+
+		internal-regs {
+			pinctrl: pinctrl at 10000 {
+				pinctrl-0 = <&pmx_usb_power &pmx_power_hdd
+					&pmx_fan_low &pmx_fan_high &pmx_fan_lock>;
+				pinctrl-names = "default";
+
+				pmx_led_power: pmx-leds {
+					marvell,pins = "mpp0";
+					marvell,function = "gpio";
+				};
+
+				pmx_led_alarm: pmx-leds {
+					marvell,pins = "mpp2";
+					marvell,function = "gpio";
+				};
+
+				pmx_led_info: pmx-leds {
+					marvell,pins = "mpp3";
+					marvell,function = "gpio";
+				};
+
+				pmx_power_hdd: pmx-power-hdd {
+					marvell,pins = "mpp1";
+					marvell,function = "gpio";
+				};
+
+				pmx_usb_power: pmx-usb-power {
+					marvell,pins = "mpp9";
+					marvell,function = "gpio";
+				};
+
+				pmx_sata0: pmx-sata0 {
+					marvell,pins = "mpp12";
+					//marvell,function = "gpio";
+					marvell,function = "sata0";
+				};
+
+				pmx_sata1: pmx-sata1 {
+					marvell,pins = "mpp13";
+					//marvell,function = "gpio";
+					marvell,function = "sata1";
+				};
+
+				pmx_fan_high: pmx-fan-high {
+					marvell,pins = "mpp14";
+					marvell,function = "gpio";
+				};
+
+				pmx_fan_low: pmx-fan-low {
+					marvell,pins = "mpp17";
+					marvell,function = "gpio";
+				};
+
+				pmx_fan_lock: pmx-fan-lock {
+					marvell,pins = "mpp6";
+					marvell,function = "gpio";
+				};
+
+				pmx_power_switch: pmx-power-switch {
+					marvell,pins = "mpp8", "mpp10";
+					marvell,function = "gpio";
+				};
+			};
+		};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-0 = <&pmx_power_switch>;
+		pinctrl-names = "default";
+
+		button at 1 {
+			label = "Power-on Switch";
+			linux,code = <KEY_RESERVED>;
+			linux,input-type = <5>;
+			gpios = <&gpio0 8 GPIO_ACTIVE_LOW>;
+		};
+
+		button at 2 {
+			label = "Power-auto Switch";
+			linux,code = <KEY_ESC>;
+			linux,input-type = <5>;
+			gpios = <&gpio0 10 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	gpio_leds {
+		compatible = "gpio-leds";
+		pinctrl-0 = <&pmx_led_power &pmx_led_alarm
+			     &pmx_led_info>;
+		pinctrl-names = "default";
+
+		led at 1 {
+			label = "lswtgl:blue:power";
+			gpios = <&gpio0 0 GPIO_ACTIVE_LOW>;
+		};
+
+		led at 2 {
+			label = "lswtgl:red:alarm";
+			gpios = <&gpio0 2 GPIO_ACTIVE_LOW>;
+		};
+
+		led at 3 {
+			label = "lswtgl:amber:info";
+			gpios = <&gpio0 3 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	gpio_fan {
+		compatible = "gpio-fan";
+		pinctrl-0 = <&pmx_fan_low &pmx_fan_high &pmx_fan_lock>;
+		pinctrl-names = "default";
+
+		gpios = <&gpio0 14 GPIO_ACTIVE_LOW
+			 &gpio0 17 GPIO_ACTIVE_LOW>;
+
+		gpio-fan,speed-map = <0 3
+				1500 2
+				3250 1
+				5000 0>;
+
+		alarm-gpios = <&gpio0 2 GPIO_ACTIVE_HIGH>;
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
+		pinctrl-0 = <&pmx_power_hdd &pmx_usb_power>;
+		pinctrl-names = "default";
+
+		usb_power: regulator at 1 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "USB Power";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			enable-active-high;
+			regulator-always-on;
+			regulator-boot-on;
+			gpios = <&gpio0 9 GPIO_ACTIVE_HIGH>;
+		};
+
+		hdd_power: regulator at 2 {
+			compatible = "regulator-fixed";
+			reg = <2>;
+			regulator-name = "HDD Power";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			enable-active-high;
+			regulator-always-on;
+			regulator-boot-on;
+			gpios = <&gpio0 1 GPIO_ACTIVE_HIGH>;
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
+
+&ehci0 {
+	status = "okay";
+};
+
+&i2c {
+	status = "okay";
+
+	rtc {
+		compatible = "ricoh,rs5c372a";
+		reg = <0x32>;
+	};
+};
+
+&wdt {
+	status = "disabled";
+};
+
+&sata {
+	pinctrl-0 = <&pmx_sata0 &pmx_sata1>;
+	pinctrl-names = "default";
+	status = "okay";
+	nr-ports = <2>;
+};
+
+&uart0 {
+	status = "okay";
+};
-- 
1.9.1
