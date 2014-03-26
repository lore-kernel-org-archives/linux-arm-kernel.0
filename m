From: linux@baker-net.org.uk (Adam Baker)
Date: Wed, 26 Mar 2014 23:07:09 +0000
Subject: mvebu: Kirkwood: Device Tree file for Zyxel NSA320
In-Reply-To: <20140326010658.GN28304@titan.lakedaemon.net>
References: <53112C83.9010700@baker-net.org.uk>
 <20140301103417.GK27832@lunn.ch> <5313C24A.9070306@baker-net.org.uk>
 <20140303094102.GA13805@lunn.ch>
 <20140326010658.GN28304@titan.lakedaemon.net>
Message-ID: <53335D9D.5070100@baker-net.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/03/14 01:06, Jason Cooper wrote:
> Adam,
> 
> Any progress on this?
> 
> thx,
> 
> Jason.

I think it's about ready, I'm just trying to find time to tidy it up to
post properly. My current thinking is that it should be split into 3 patches

1 - Move some things that are common to both nsa310, nsa310a and nsa320 into
    kirkwood-nsa310-common.dtsi
2 - add the dts for nsa320
3 - rename kirkwood-nsa310-common.dtsi to kirkwood-nsa3x0-common.dtsi (I suspect
    the nsa325 is sufficiently different to not share this file). I suggest
    making this change last as it can easily be dropped till later if it causes
    conflicts.

Current diff for changes 1 & 2 is below in case anyone wants to make any further
comments.

Other than splitting into separate patches I'm now happy with this so

Signed-off-by: Adam Baker <linux@baker-net.org.uk>

----

diff --git a/arch/arm/boot/dts/kirkwood-nsa310-common.dtsi b/arch/arm/boot/dts/kirkwood-nsa310-common.dtsi
index aa78c2d..843b8b5 100644
--- a/arch/arm/boot/dts/kirkwood-nsa310-common.dtsi
+++ b/arch/arm/boot/dts/kirkwood-nsa310-common.dtsi
@@ -7,15 +7,40 @@
 	ocp at f1000000 {
 		pinctrl: pinctrl at 10000 {
 
-			pmx_usb_power_off: pmx-usb-power-off {
+			pmx_usb_power: pmx-usb-power {
 				marvell,pins = "mpp21";
 				marvell,function = "gpio";
 			};
+
 			pmx_pwr_off: pmx-pwr-off {
 				marvell,pins = "mpp48";
 				marvell,function = "gpio";
 			};
 
+			pmx_btn_reset: pmx-btn-reset {
+				marvell,pins = "mpp36";
+				marvell,function = "gpio";
+			};
+
+			pmx_btn_copy: pmx-btn-copy {
+				marvell,pins = "mpp37";
+				marvell,function = "gpio";
+			};
+
+			pmx_btn_power: pmx-btn-power {
+				marvell,pins = "mpp46";
+				marvell,function = "gpio";
+			};
+
+			pmx_led_copy_green: pmx-led-copy-green {
+				marvell,pins = "mpp39";
+				marvell,function = "gpio";
+			};
+
+			pmx_led_copy_red: pmx-led-copy-red {
+				marvell,pins = "mpp40";
+				marvell,function = "gpio";
+			};
 		};
 
 		serial at 12000 {
@@ -43,17 +68,42 @@
 		gpios = <&gpio1 16 GPIO_ACTIVE_HIGH>;
 	};
 
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-0 = <&pmx_btn_reset &pmx_btn_copy &pmx_btn_power>;
+		pinctrl-names = "default";
+
+		button at 1 {
+			label = "Power Button";
+			linux,code = <KEY_POWER>;
+			gpios = <&gpio1 14 GPIO_ACTIVE_HIGH>;
+		};
+		button at 2 {
+			label = "Copy Button";
+			linux,code = <KEY_COPY>;
+			gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;
+		};
+		button at 3 {
+			label = "Reset Button";
+			linux,code = <KEY_RESTART>;
+			gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <0>;
-		pinctrl-0 = <&pmx_usb_power_off>;
+		pinctrl-0 = <&pmx_usb_power>;
 		pinctrl-names = "default";
 
-		usb0_power_off: regulator at 1 {
+		usb0_power: regulator at 1 {
 			compatible = "regulator-fixed";
 			reg = <1>;
-			regulator-name = "USB Power Off";
+			regulator-name = "USB Power";
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
 			regulator-always-on;
diff --git a/arch/arm/boot/dts/kirkwood-nsa310.dts b/arch/arm/boot/dts/kirkwood-nsa310.dts
index 03fa24c..372f701 100644
--- a/arch/arm/boot/dts/kirkwood-nsa310.dts
+++ b/arch/arm/boot/dts/kirkwood-nsa310.dts
@@ -59,26 +59,6 @@
 				marvell,function = "gpio";
 			};
 
-			pmx_btn_reset: pmx-btn-reset {
-				marvell,pins = "mpp36";
-				marvell,function = "gpio";
-			};
-
-			pmx_btn_copy: pmx-btn-copy {
-				marvell,pins = "mpp37";
-				marvell,function = "gpio";
-			};
-
-			pmx_led_copy_green: pmx-led-copy-green {
-				marvell,pins = "mpp39";
-				marvell,function = "gpio";
-			};
-
-			pmx_led_copy_red: pmx-led-copy-red {
-				marvell,pins = "mpp40";
-				marvell,function = "gpio";
-			};
-
 			pmx_led_hdd_green: pmx-led-hdd-green {
 				marvell,pins = "mpp41";
 				marvell,function = "gpio";
@@ -94,10 +74,6 @@
 				marvell,function = "gpio";
 			};
 
-			pmx_btn_power: pmx-btn-power {
-				marvell,pins = "mpp46";
-				marvell,function = "gpio";
-			};
 		};
 
 		i2c at 11000 {
@@ -110,30 +86,6 @@
 		};
 	};
 
-	gpio_keys {
-		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		pinctrl-0 = <&pmx_btn_reset &pmx_btn_copy &pmx_btn_power>;
-		pinctrl-names = "default";
-
-		button at 1 {
-			label = "Power Button";
-			linux,code = <KEY_POWER>;
-			gpios = <&gpio1 14 GPIO_ACTIVE_HIGH>;
-		};
-		button at 2 {
-			label = "Copy Button";
-			linux,code = <KEY_COPY>;
-			gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;
-		};
-		button at 3 {
-			label = "Reset Button";
-			linux,code = <KEY_RESTART>;
-			gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
-		};
-	};
-
 	gpio-leds {
 		compatible = "gpio-leds";
 		pinctrl-0 = <&pmx_led_esata_green &pmx_led_esata_red
diff --git a/arch/arm/boot/dts/kirkwood-nsa310a.dts b/arch/arm/boot/dts/kirkwood-nsa310a.dts
index a5e7794..ead7a36 100644
--- a/arch/arm/boot/dts/kirkwood-nsa310a.dts
+++ b/arch/arm/boot/dts/kirkwood-nsa310a.dts
@@ -38,11 +38,6 @@
 				marvell,function = "gpio";
 			};
 
-			pmx_usb_power_off: pmx-usb-power-off {
-				marvell,pins = "mpp21";
-				marvell,function = "gpio";
-			};
-
 			pmx_led_sys_green: pmx-led-sys-green {
 				marvell,pins = "mpp28";
 				marvell,function = "gpio";
@@ -53,26 +48,6 @@
 				marvell,function = "gpio";
 			};
 
-			pmx_btn_reset: pmx-btn-reset {
-				marvell,pins = "mpp36";
-				marvell,function = "gpio";
-			};
-
-			pmx_btn_copy: pmx-btn-copy {
-				marvell,pins = "mpp37";
-				marvell,function = "gpio";
-			};
-
-			pmx_led_copy_green: pmx-led-copy-green {
-				marvell,pins = "mpp39";
-				marvell,function = "gpio";
-			};
-
-			pmx_led_copy_red: pmx-led-copy-red {
-				marvell,pins = "mpp40";
-				marvell,function = "gpio";
-			};
-
 			pmx_led_hdd_green: pmx-led-hdd-green {
 				marvell,pins = "mpp41";
 				marvell,function = "gpio";
@@ -83,11 +58,6 @@
 				marvell,function = "gpio";
 			};
 
-			pmx_btn_power: pmx-btn-power {
-				marvell,pins = "mpp46";
-				marvell,function = "gpio";
-			};
-
 		};
 
 		i2c@11000 {
@@ -100,28 +70,6 @@
 		};
 	};
 
-	gpio_keys {
-		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		button at 1 {
-			label = "Power Button";
-			linux,code = <KEY_POWER>;
-			gpios = <&gpio1 14 GPIO_ACTIVE_HIGH>;
-		};
-		button at 2 {
-			label = "Copy Button";
-			linux,code = <KEY_COPY>;
-			gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;
-		};
-		button at 3 {
-			label = "Reset Button";
-			linux,code = <KEY_RESTART>;
-			gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
-		};
-	};
-
 	gpio-leds {
 		compatible = "gpio-leds";
 
diff --git a/arch/arm/boot/dts/kirkwood-nsa320.dts b/arch/arm/boot/dts/kirkwood-nsa320.dts
new file mode 100644
index 0000000..6c8f692
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-nsa320.dts
@@ -0,0 +1,214 @@
+/* Device tree file for the Zyxel NSA 320 NAS box.
+ *
+ * Copyright (c) 2014, Adam Baker <linux@baker-net.org.uk>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ * Based upon the board setup file created by Peter Schildmann */
+
+/dts-v1/;
+
+#include "kirkwood-nsa310-common.dtsi"
+
+/ {
+	model = "Zyxel NSA320";
+	compatible = "zyxel,nsa320", "marvell,kirkwood-88f6281", "marvell,kirkwood";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x20000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200";
+	};
+
+	mbus {
+		pcie-controller {
+			status = "okay";
+
+			pcie at 1,0 {
+				status = "okay";
+			};
+		};
+	};
+
+	ocp at f1000000 {
+		pinctrl: pinctrl at 10000 {
+			pinctrl-names = "default";
+
+			/* SATA Activity and Present pins are not connected */
+			pmx_sata0: pmx-sata0 {
+				marvell,pins ;
+				marvell,function = "sata0";
+			};
+
+			pmx_sata1: pmx-sata1 {
+				marvell,pins ;
+				marvell,function = "sata1";
+			};
+
+			pmx_led_hdd2_green: pmx-led-hdd2-green {
+				marvell,pins = "mpp12";
+				marvell,function = "gpio";
+			};
+
+			pmx_led_hdd2_red: pmx-led-hdd2-red {
+				marvell,pins = "mpp13";
+				marvell,function = "gpio";
+			};
+
+			pmx_mcu_data: pmx-mcu-data {
+				marvell,pins = "mpp14";
+				marvell,function = "gpio";
+			};
+
+			pmx_led_usb_green: pmx-led-usb-green {
+				marvell,pins = "mpp15";
+				marvell,function = "gpio";
+			};
+
+			pmx_mcu_clk: pmx-mcu-clk {
+				marvell,pins = "mpp16";
+				marvell,function = "gpio";
+			};
+
+			pmx_mcu_act: pmx-mcu-act {
+				marvell,pins = "mpp17";
+				marvell,function = "gpio";
+			};
+
+			pmx_led_sys_green: pmx-led-sys-green {
+				marvell,pins = "mpp28";
+				marvell,function = "gpio";
+			};
+
+			pmx_led_sys_orange: pmx-led-sys-orange {
+				marvell,pins = "mpp29";
+				marvell,function = "gpio";
+			};
+
+			pmx_led_hdd1_green: pmx-led-hdd1-green {
+				marvell,pins = "mpp41";
+				marvell,function = "gpio";
+			};
+
+			pmx_led_hdd1_red: pmx-led-hdd1-red {
+				marvell,pins = "mpp42";
+				marvell,function = "gpio";
+			};
+
+			pmx_htp: pmx-htp {
+				marvell,pins = "mpp43";
+				marvell,function = "gpio";
+			};
+
+			/* Buzzer needs to be switched at around 1kHz so is
+			   not compatible with the gpio-beeper driver. */
+			pmx_buzzer: pmx-buzzer {
+				marvell,pins = "mpp44";
+				marvell,function = "gpio";
+			};
+
+			pmx_vid_b1: pmx-vid-b1 {
+				marvell,pins = "mpp45";
+				marvell,function = "gpio";
+			};
+
+			pmx_power_resume_data: pmx-power-resume-data {
+				marvell,pins = "mpp47";
+				marvell,function = "gpio";
+			};
+
+			pmx_power_resume_clk: pmx-power-resume-clk {
+				marvell,pins = "mpp49";
+				marvell,function = "gpio";
+			};
+		};
+
+		i2c at 11000 {
+			status = "okay";
+
+			pcf8563: pcf8563 at 51 {
+				compatible = "nxp,pcf8563";
+				reg = <0x51>;
+			};
+		};
+	};
+
+	regulators {
+		usb0_power: regulator at 1 {
+			enable-active-high;
+		};
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+		pinctrl-0 = <&pmx_led_hdd2_green &pmx_led_hdd2_red
+			     &pmx_led_usb_green
+			     &pmx_led_sys_green &pmx_led_sys_orange
+			     &pmx_led_copy_green &pmx_led_copy_red
+			     &pmx_led_hdd1_green &pmx_led_hdd1_red>;
+		pinctrl-names = "default";
+
+		green-sys {
+			label = "nsa320:green:sys";
+			gpios = <&gpio0 28 GPIO_ACTIVE_HIGH>;
+		};
+		orange-sys {
+			label = "nsa320:orange:sys";
+			gpios = <&gpio0 29 GPIO_ACTIVE_HIGH>;
+		};
+		green-hdd1 {
+			label = "nsa320:green:hdd1";
+			gpios = <&gpio1 9 GPIO_ACTIVE_HIGH>;
+		};
+		red-hdd1 {
+			label = "nsa320:red:hdd1";
+			gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>;
+		};
+		green-hdd2 {
+			label = "nsa320:green:hdd2";
+			gpios = <&gpio0 12 GPIO_ACTIVE_HIGH>;
+		};
+		red-hdd2 {
+			label = "nsa320:red:hdd2";
+			gpios = <&gpio0 13 GPIO_ACTIVE_HIGH>;
+		};
+		green-usb {
+			label = "nsa320:green:usb";
+			gpios = <&gpio0 15 GPIO_ACTIVE_HIGH>;
+		};
+		green-copy {
+			label = "nsa320:green:copy";
+			gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
+		};
+		red-copy {
+			label = "nsa320:red:copy";
+			gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	/* The following pins are currently not assigned to a driver,
+	   some of them should be configured as inputs.
+	pinctrl-0 = <&pmx_mcu_data &pmx_mcu_clk &pmx_mcu_act
+		     &pmx_htp &pmx_vid_b1
+		     &pmx_power_resume_data &pmx_power_resume_clk>; */
+};
+
+&mdio {
+	status = "okay";
+	ethphy0: ethernet-phy at 1 {
+		reg = <1>;
+	};
+};
+
+&eth0 {
+	status = "okay";
+	ethernet0-port at 0 {
+		phy-handle = <&ethphy0>;
+	};
+};
