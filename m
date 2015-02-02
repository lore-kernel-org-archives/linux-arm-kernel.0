From: wens@csie.org (Chen-Yu Tsai)
Date: Tue,  3 Feb 2015 06:22:03 +0800
Subject: [PATCH v4 3/5] ARM: dts: sun9i: Enable USB support on A80 Optimus
 board
In-Reply-To: <1422915725-26492-1-git-send-email-wens@csie.org>
References: <1422915725-26492-1-git-send-email-wens@csie.org>
Message-ID: <1422915725-26492-4-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the Optimus board, all three USB hosts can be used.
HCI0 and HCI2 are available through the USB connector.
HCI1 is available with HSIC through 2 pins on the GPIO
expansion header.

This patch also adds a regulator for HCI2/USB3's VBUS.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80-optimus.dts | 65 +++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80-optimus.dts b/arch/arm/boot/dts/sun9i-a80-optimus.dts
index c4de9cb9a5f6..af6ac07ca5f6 100644
--- a/arch/arm/boot/dts/sun9i-a80-optimus.dts
+++ b/arch/arm/boot/dts/sun9i-a80-optimus.dts
@@ -81,6 +81,29 @@
 			gpios = <&pio 7 0 GPIO_ACTIVE_HIGH>;
 		};
 	};
+
+	reg_usb3_vbus: usb3-vbus {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb3_vbus_pin_optimus>;
+		regulator-name = "usb3-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		gpio = <&pio 7 5 GPIO_ACTIVE_HIGH>; /* PH5 */
+	};
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&ehci2 {
+	status = "okay";
 };
 
 &i2c3 {
@@ -94,6 +117,14 @@
 	allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
 };
 
+&ohci0 {
+	status = "okay";
+};
+
+&ohci2 {
+	status = "okay";
+};
+
 &pio {
 	led_pins_optimus: led-pins at 0 {
 		allwinner,pins = "PH0", "PH1";
@@ -108,6 +139,20 @@
 		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
 	};
+
+	usb1_vbus_pin_optimus: usb1_vbus_pin at 1 {
+		allwinner,pins = "PH4";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
+	usb3_vbus_pin_optimus: usb3_vbus_pin at 1 {
+		allwinner,pins = "PH5";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
 };
 
 &mmc0 {
@@ -129,6 +174,12 @@
 	status = "okay";
 };
 
+&reg_usb1_vbus {
+	pinctrl-0 = <&usb1_vbus_pin_optimus>;
+	gpio = <&pio 7 4 GPIO_ACTIVE_HIGH>; /* PH4 */
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
@@ -145,3 +196,17 @@
 	/* Enable internal pull-up */
 	allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
 };
+
+&usbphy1 {
+	vbus-supply = <&reg_usb1_vbus>;
+	status = "okay";
+};
+
+&usbphy2 {
+	status = "okay";
+};
+
+&usbphy3 {
+	vbus-supply = <&reg_usb3_vbus>;
+	status = "okay";
+};
-- 
2.1.4
