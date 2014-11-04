From: wens@csie.org (Chen-Yu Tsai)
Date: Tue,  4 Nov 2014 12:07:19 +0800
Subject: [PATCH 6/6] ARM: dts: sun9i: Enable USB support on A80 Optimus board
In-Reply-To: <1415074039-16590-1-git-send-email-wens@csie.org>
References: <1415074039-16590-1-git-send-email-wens@csie.org>
Message-ID: <1415074039-16590-7-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
This patch does not use sunxi-common-regulators.dtsi, but adds the
regulators directly. To use the common regulators file, we would
need to use phandles and switch to preprocessor includes to support
that.

---
 arch/arm/boot/dts/sun9i-a80-optimus.dts | 72 +++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80-optimus.dts b/arch/arm/boot/dts/sun9i-a80-optimus.dts
index 506948f..31010c1 100644
--- a/arch/arm/boot/dts/sun9i-a80-optimus.dts
+++ b/arch/arm/boot/dts/sun9i-a80-optimus.dts
@@ -59,6 +59,40 @@
 	};
 
 	soc {
+		ehci0: usb at 00a00000 {
+			status = "okay";
+		};
+
+		ohci0: usb at 00a00400 {
+			status = "okay";
+		};
+
+		usbphy0: phy at 00a00800 {
+			vbus-supply = <&reg_usb0_vbus>;
+			status = "okay";
+		};
+
+		ehci1: usb at 00a01000 {
+			status = "okay";
+		};
+
+		usbphy1: phy at 00a01800 {
+			status = "okay";
+		};
+
+		ehci2: usb at 00a02000 {
+			status = "okay";
+		};
+
+		ohci2: usb at 00a02400 {
+			status = "okay";
+		};
+
+		usbphy2: phy at 00a02800 {
+			vbus-supply = <&reg_usb2_vbus>;
+			status = "okay";
+		};
+
 		pio: pinctrl at 06000800 {
 			i2c3_pins_a: i2c3 at 0 {
 				/* Enable internal pull-up */
@@ -76,6 +110,20 @@
 				/* Enable internal pull-up */
 				allwinner,pull = <1>;
 			};
+
+			usb0_vbus_pin_optimus: usb0_vbus_pin at 1 {
+				allwinner,pins = "PH4";
+				allwinner,function = "gpio_out";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
+			usb2_vbus_pin_optimus: usb2_vbus_pin at 1 {
+				allwinner,pins = "PH5";
+				allwinner,function = "gpio_out";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
 		};
 
 		uart0: serial at 07000000 {
@@ -116,4 +164,28 @@
 			gpios = <&pio 7 0 0>;
 		};
 	};
+
+	reg_usb0_vbus: usb0-vbus {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb0_vbus_pin_optimus>;
+		regulator-name = "usb0-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		gpio = <&pio 7 4 0>; /* PH4 */
+		status = "okay";
+	};
+
+	reg_usb2_vbus: usb2-vbus {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb2_vbus_pin_optimus>;
+		regulator-name = "usb2-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		gpio = <&pio 7 5 0>; /* PH5 */
+		status = "okay";
+	};
 };
-- 
2.1.1
