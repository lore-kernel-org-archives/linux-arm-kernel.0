From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 17 Jul 2013 18:51:49 +0200
Subject: [PATCH 1/2] ARM: Kirkwood: Add support for another ZyXEL NSA310
 variant
In-Reply-To: <1374079910-24345-1-git-send-email-andrew@lunn.ch>
References: <1374079910-24345-1-git-send-email-andrew@lunn.ch>
Message-ID: <1374079910-24345-2-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are a number of variants of the ZyXEL NSA310, with slightly
different LEDs, buttons and i2c devices. Add a DTS file to support one
more of these variants.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/Makefile                    |    1 +
 arch/arm/boot/dts/kirkwood-nsa310-common.dtsi |  107 ++++++++++++++++
 arch/arm/boot/dts/kirkwood-nsa310.dts         |  100 +--------------
 arch/arm/boot/dts/kirkwood-nsa310a.dts        |  165 +++++++++++++++++++++++++
 4 files changed, 274 insertions(+), 99 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-nsa310-common.dtsi
 create mode 100644 arch/arm/boot/dts/kirkwood-nsa310a.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 641b3c9..d2ffa39 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -89,6 +89,7 @@ dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-cloudbox.dtb \
 	kirkwood-ns2max.dtb \
 	kirkwood-ns2mini.dtb \
 	kirkwood-nsa310.dtb \
+	kirkwood-nsa310a.dtb \
 	kirkwood-sheevaplug.dtb \
 	kirkwood-sheevaplug-esata.dtb \
 	kirkwood-topkick.dtb \
diff --git a/arch/arm/boot/dts/kirkwood-nsa310-common.dtsi b/arch/arm/boot/dts/kirkwood-nsa310-common.dtsi
new file mode 100644
index 0000000..8f739c8
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-nsa310-common.dtsi
@@ -0,0 +1,107 @@
+/include/ "kirkwood.dtsi"
+/include/ "kirkwood-6281.dtsi"
+
+/ {
+	model = "ZyXEL NSA310";
+
+	ocp at f1000000 {
+		pinctrl: pinctrl at 10000 {
+
+			pmx_usb_power_off: pmx-usb-power-off {
+				marvell,pins = "mpp21";
+				marvell,function = "gpio";
+			};
+			pmx_pwr_off: pmx-pwr-off {
+				marvell,pins = "mpp48";
+				marvell,function = "gpio";
+			};
+
+		};
+
+		serial at 12000 {
+			status = "ok";
+		};
+
+		sata at 80000 {
+			status = "okay";
+			nr-ports = <2>;
+		};
+
+		nand at 3000000 {
+			status = "okay";
+			chip-delay = <35>;
+
+			partition at 0 {
+				label = "uboot";
+				reg = <0x0000000 0x0100000>;
+				read-only;
+			};
+			partition at 100000 {
+				label = "uboot_env";
+				reg = <0x0100000 0x0080000>;
+			};
+			partition at 180000 {
+				label = "key_store";
+				reg = <0x0180000 0x0080000>;
+			};
+			partition at 200000 {
+				label = "info";
+				reg = <0x0200000 0x0080000>;
+			};
+			partition at 280000 {
+				label = "etc";
+				reg = <0x0280000 0x0a00000>;
+			};
+			partition at c80000 {
+				label = "kernel_1";
+				reg = <0x0c80000 0x0a00000>;
+			};
+			partition at 1680000 {
+				label = "rootfs1";
+				reg = <0x1680000 0x2fc0000>;
+			};
+			partition at 4640000 {
+				label = "kernel_2";
+				reg = <0x4640000 0x0a00000>;
+			};
+			partition at 5040000 {
+				label = "rootfs2";
+				reg = <0x5040000 0x2fc0000>;
+			};
+		};
+
+		pcie-controller {
+			status = "okay";
+
+			pcie at 1,0 {
+				status = "okay";
+			};
+		};
+	};
+
+	gpio_poweroff {
+		compatible = "gpio-poweroff";
+		pinctrl-0 = <&pmx_pwr_off>;
+		pinctrl-names = "default";
+		gpios = <&gpio1 16 0>;
+	};
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-0 = <&pmx_usb_power_off>;
+		pinctrl-names = "default";
+
+		usb0_power_off: regulator at 1 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "USB Power Off";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			regulator-always-on;
+			regulator-boot-on;
+			gpio = <&gpio0 21 0>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/kirkwood-nsa310.dts b/arch/arm/boot/dts/kirkwood-nsa310.dts
index 6900359..62fb0a9 100644
--- a/arch/arm/boot/dts/kirkwood-nsa310.dts
+++ b/arch/arm/boot/dts/kirkwood-nsa310.dts
@@ -1,10 +1,8 @@
 /dts-v1/;
 
-/include/ "kirkwood.dtsi"
-/include/ "kirkwood-6281.dtsi"
+/include/ "kirkwood-nsa310-common.dtsi"
 
 / {
-	model = "ZyXEL NSA310";
 	compatible = "zyxel,nsa310", "marvell,kirkwood-88f6281", "marvell,kirkwood";
 
 	memory {
@@ -41,11 +39,6 @@
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
@@ -95,20 +88,6 @@
 				marvell,pins = "mpp46";
 				marvell,function = "gpio";
 			};
-
-			pmx_pwr_off: pmx-pwr-off {
-				marvell,pins = "mpp48";
-				marvell,function = "gpio";
-			};
-		};
-
-		serial at 12000 {
-			status = "ok";
-		};
-
-		sata at 80000 {
-			status = "okay";
-			nr-ports = <2>;
 		};
 
 		i2c at 11000 {
@@ -119,57 +98,6 @@
 				reg = <0x2e>;
 			};
 		};
-
-		nand at 3000000 {
-			status = "okay";
-			chip-delay = <35>;
-
-			partition at 0 {
-				label = "uboot";
-				reg = <0x0000000 0x0100000>;
-				read-only;
-			};
-			partition at 100000 {
-				label = "uboot_env";
-				reg = <0x0100000 0x0080000>;
-			};
-			partition at 180000 {
-				label = "key_store";
-				reg = <0x0180000 0x0080000>;
-			};
-			partition at 200000 {
-				label = "info";
-				reg = <0x0200000 0x0080000>;
-			};
-			partition at 280000 {
-				label = "etc";
-				reg = <0x0280000 0x0a00000>;
-			};
-			partition at c80000 {
-				label = "kernel_1";
-				reg = <0x0c80000 0x0a00000>;
-			};
-			partition at 1680000 {
-				label = "rootfs1";
-				reg = <0x1680000 0x2fc0000>;
-			};
-			partition at 4640000 {
-				label = "kernel_2";
-				reg = <0x4640000 0x0a00000>;
-			};
-			partition at 5040000 {
-				label = "rootfs2";
-				reg = <0x5040000 0x2fc0000>;
-			};
-		};
-
-		pcie-controller {
-			status = "okay";
-
-			pcie at 1,0 {
-				status = "okay";
-			};
-		};
 	};
 
 	gpio_keys {
@@ -246,30 +174,4 @@
 			gpios = <&gpio1 8 0>;
 		};
 	};
-
-	gpio_poweroff {
-		compatible = "gpio-poweroff";
-		pinctrl-0 = <&pmx_pwr_off>;
-		pinctrl-names = "default";
-		gpios = <&gpio1 16 0>;
-	};
-
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		pinctrl-0 = <&pmx_usb_power_off>;
-		pinctrl-names = "default";
-
-		usb0_power_off: regulator at 1 {
-			compatible = "regulator-fixed";
-			reg = <1>;
-			regulator-name = "USB Power Off";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			regulator-always-on;
-			regulator-boot-on;
-			gpio = <&gpio0 21 0>;
-		};
-	};
 };
diff --git a/arch/arm/boot/dts/kirkwood-nsa310a.dts b/arch/arm/boot/dts/kirkwood-nsa310a.dts
new file mode 100644
index 0000000..1070e9d
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-nsa310a.dts
@@ -0,0 +1,165 @@
+/dts-v1/;
+
+/include/ "kirkwood-nsa310-common.dtsi"
+
+/*
+ * There are at least two different NSA310 designs. This variant does
+ * not have the red USB Led.
+ */
+
+/ {
+	compatible = "zyxel,nsa310a", "zyxel,nsa310", "marvell,kirkwood-88f6281", "marvell,kirkwood";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x10000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200";
+	};
+
+	ocp at f1000000 {
+		pinctrl: pinctrl at 10000 {
+			pinctrl-names = "default";
+
+			pmx_led_esata_green: pmx-led-esata-green {
+				marvell,pins = "mpp12";
+				marvell,function = "gpio";
+			};
+
+			pmx_led_esata_red: pmx-led-esata-red {
+				marvell,pins = "mpp13";
+				marvell,function = "gpio";
+			};
+
+			pmx_led_usb_green: pmx-led-usb-green {
+				marvell,pins = "mpp15";
+				marvell,function = "gpio";
+			};
+
+			pmx_usb_power_off: pmx-usb-power-off {
+				marvell,pins = "mpp21";
+				marvell,function = "gpio";
+			};
+
+			pmx_led_sys_green: pmx-led-sys-green {
+				marvell,pins = "mpp28";
+				marvell,function = "gpio";
+			};
+
+			pmx_led_sys_red: pmx-led-sys-red {
+				marvell,pins = "mpp29";
+				marvell,function = "gpio";
+			};
+
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
+			pmx_led_copy_green: pmx-led-copy-green {
+				marvell,pins = "mpp39";
+				marvell,function = "gpio";
+			};
+
+			pmx_led_copy_red: pmx-led-copy-red {
+				marvell,pins = "mpp40";
+				marvell,function = "gpio";
+			};
+
+			pmx_led_hdd_green: pmx-led-hdd-green {
+				marvell,pins = "mpp41";
+				marvell,function = "gpio";
+			};
+
+			pmx_led_hdd_red: pmx-led-hdd-red {
+				marvell,pins = "mpp42";
+				marvell,function = "gpio";
+			};
+
+			pmx_btn_power: pmx-btn-power {
+				marvell,pins = "mpp46";
+				marvell,function = "gpio";
+			};
+
+		};
+
+		i2c at 11000 {
+			status = "okay";
+
+			lm85: lm85 at 2e {
+				compatible = "lm85";
+				reg = <0x2e>;
+			};
+		};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		button at 1 {
+			label = "Power Button";
+			linux,code = <116>;
+			gpios = <&gpio1 14 0>;
+		};
+		button at 2 {
+			label = "Copy Button";
+			linux,code = <133>;
+			gpios = <&gpio1 5 1>;
+		};
+		button at 3 {
+			label = "Reset Button";
+			linux,code = <0x198>;
+			gpios = <&gpio1 4 1>;
+		};
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+
+		green-sys {
+			label = "nsa310:green:sys";
+			gpios = <&gpio0 28 0>;
+		};
+		red-sys {
+			label = "nsa310:red:sys";
+			gpios = <&gpio0 29 0>;
+		};
+		green-hdd {
+			label = "nsa310:green:hdd";
+			gpios = <&gpio1 9 0>;
+		};
+		red-hdd {
+			label = "nsa310:red:hdd";
+			gpios = <&gpio1 10 0>;
+		};
+		green-esata {
+			label = "nsa310:green:esata";
+			gpios = <&gpio0 12 0>;
+		};
+		red-esata {
+			label = "nsa310:red:esata";
+			gpios = <&gpio0 13 0>;
+		};
+		green-usb {
+			label = "nsa310:green:usb";
+			gpios = <&gpio0 15 0>;
+		};
+		green-copy {
+			label = "nsa310:green:copy";
+			gpios = <&gpio1 7 0>;
+		};
+		red-copy {
+			label = "nsa310:red:copy";
+			gpios = <&gpio1 8 0>;
+		};
+	};
+};
-- 
1.7.10.4
