From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  1 Feb 2015 14:50:03 +0100
Subject: [PATCH 19/30] ARM: sun6i: m9: Convert to DT label based syntax
In-Reply-To: <1422798614-3581-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1422798614-3581-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1422798614-3581-20-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to lessen the amount of duplication of the DT tree, ease the
new and follow the trend that prefers to use label based references
when overriding DTSI nodes, convert the board to this syntax

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun6i-a31-m9.dts | 148 ++++++++++++++++++-------------------
 1 file changed, 73 insertions(+), 75 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31-m9.dts b/arch/arm/boot/dts/sun6i-a31-m9.dts
index 139a21e6b695..5cbbbd696b00 100644
--- a/arch/arm/boot/dts/sun6i-a31-m9.dts
+++ b/arch/arm/boot/dts/sun6i-a31-m9.dts
@@ -60,93 +60,91 @@
 		bootargs = "earlyprintk console=ttyS0,115200";
 	};
 
-	soc at 01c00000 {
-		mmc0: mmc at 01c0f000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_m9>;
-			vmmc-supply = <&reg_vcc3v3>;
-			bus-width = <4>;
-			cd-gpios = <&pio 7 22 GPIO_ACTIVE_HIGH>; /* PH22 */
-			cd-inverted;
-			status = "okay";
-		};
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pins_m9>;
 
-		usbphy: phy at 01c19400 {
-			usb1_vbus-supply = <&reg_usb1_vbus>;
-			status = "okay";
+		blue {
+			label = "m9:blue:usr";
+			gpios = <&pio 7 13 GPIO_ACTIVE_HIGH>;
 		};
+	};
+};
 
-		ehci0: usb at 01c1a000 {
-			status = "okay";
-		};
+&ehci0 {
+	status = "okay";
+};
 
-		ehci1: usb at 01c1b000 {
-			status = "okay";
-		};
+&ehci1 {
+	status = "okay";
+};
 
-		pio: pinctrl at 01c20800 {
-			led_pins_m9: led_pins at 0 {
-				allwinner,pins = "PH13";
-				allwinner,function = "gpio_out";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
-
-			mmc0_cd_pin_m9: mmc0_cd_pin at 0 {
-				allwinner,pins = "PH22";
-				allwinner,function = "gpio_in";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
-			};
-
-			usb1_vbus_pin_m9: usb1_vbus_pin at 0 {
-				allwinner,pins = "PC27";
-				allwinner,function = "gpio_out";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
-		};
+&gmac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac_pins_mii_a>;
+	phy = <&phy1>;
+	phy-mode = "mii";
+	status = "okay";
 
-		uart0: serial at 01c28000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&uart0_pins_a>;
-			status = "okay";
-		};
+	phy1: ethernet-phy at 1 {
+		reg = <1>;
+	};
+};
 
-		gmac: ethernet at 01c30000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&gmac_pins_mii_a>;
-			phy = <&phy1>;
-			phy-mode = "mii";
-			status = "okay";
+&ir {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ir_pins_a>;
+	status = "okay";
+};
 
-			phy1: ethernet-phy at 1 {
-				reg = <1>;
-			};
-		};
+&mmc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_m9>;
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <4>;
+	cd-gpios = <&pio 7 22 GPIO_ACTIVE_HIGH>; /* PH22 */
+	cd-inverted;
+	status = "okay";
+};
 
-		ir at 01f02000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&ir_pins_a>;
-			status = "okay";
-		};
+&pio {
+	led_pins_m9: led_pins at 0 {
+		allwinner,pins = "PH13";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
-	leds {
-		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&led_pins_m9>;
-
-		blue {
-			label = "m9:blue:usr";
-			gpios = <&pio 7 13 GPIO_ACTIVE_HIGH>;
-		};
+	mmc0_cd_pin_m9: mmc0_cd_pin at 0 {
+		allwinner,pins = "PH22";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
 	};
 
-	reg_usb1_vbus: usb1-vbus {
-		pinctrl-names = "default";
-		pinctrl-0 = <&usb1_vbus_pin_m9>;
-		gpio = <&pio 2 27 GPIO_ACTIVE_HIGH>;
-		status = "okay";
+	usb1_vbus_pin_m9: usb1_vbus_pin at 0 {
+		allwinner,pins = "PC27";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
+
+&reg_usb1_vbus {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb1_vbus_pin_m9>;
+	gpio = <&pio 2 27 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins_a>;
+	status = "okay";
+};
+
+&usbphy {
+	usb1_vbus-supply = <&reg_usb1_vbus>;
+	status = "okay";
+};
-- 
2.2.2
