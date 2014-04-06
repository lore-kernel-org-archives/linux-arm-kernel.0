From: linux@baker-net.org.uk (Adam Baker)
Date: Sun,  6 Apr 2014 22:42:47 +0100
Subject: [PATCH 1/3] ARM: kirkwood: Move NSA310 common parts to include file
In-Reply-To: <5341C91D.4060007@baker-net.org.uk>
References: <5341C91D.4060007@baker-net.org.uk>
Message-ID: <1396820569-3841-1-git-send-email-linux@baker-net.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Move definitions that are common to both nsa-310.dts and
 nsa310a.dts and that will also be used in nsa320 into
 kirkwood-nsa310-common.dtsi. Also rename the USB
 Regulator to remove the word off from its name as the
 state of a regulator shouldn't be part of its name.

Signed-off-by: Adam Baker <linux@baker-net.org.uk>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood-nsa310-common.dtsi |   58 +++++++++++++++++++++++--
 arch/arm/boot/dts/kirkwood-nsa310.dts         |   48 --------------------
 arch/arm/boot/dts/kirkwood-nsa310a.dts        |   52 ----------------------
 3 files changed, 54 insertions(+), 104 deletions(-)

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
 
-- 
1.7.10.4
