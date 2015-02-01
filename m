From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  1 Feb 2015 14:50:02 +0100
Subject: [PATCH 18/30] ARM: sun6i: colombus: Convert to DT label based syntax
In-Reply-To: <1422798614-3581-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1422798614-3581-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1422798614-3581-19-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to lessen the amount of duplication of the DT tree, ease the
new and follow the trend that prefers to use label based references
when overriding DTSI nodes, convert the board to this syntax

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun6i-a31-colombus.dts | 120 +++++++++++++++----------------
 1 file changed, 59 insertions(+), 61 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31-colombus.dts b/arch/arm/boot/dts/sun6i-a31-colombus.dts
index 84630e56acd7..d6e925c381a3 100644
--- a/arch/arm/boot/dts/sun6i-a31-colombus.dts
+++ b/arch/arm/boot/dts/sun6i-a31-colombus.dts
@@ -61,76 +61,74 @@
 	chosen {
 		bootargs = "earlyprintk console=ttyS0,115200";
 	};
+};
 
-	soc at 01c00000 {
-		mmc0: mmc at 01c0f000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_colombus>;
-			vmmc-supply = <&reg_vcc3v0>;
-			bus-width = <4>;
-			cd-gpios = <&pio 0 8 GPIO_ACTIVE_HIGH>; /* PA8 */
-			cd-inverted;
-			status = "okay";
-		};
+&ehci1 {
+	status = "okay";
+};
 
-		usbphy: phy at 01c19400 {
-			usb2_vbus-supply = <&reg_usb2_vbus>;
-			status = "okay";
-		};
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins_a>;
+	status = "fail";
+};
 
-		ehci1: usb at 01c1b000 {
-			status = "okay";
-		};
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins_a>;
+	status = "okay";
+};
 
-		pio: pinctrl at 01c20800 {
-			mmc0_pins_a: mmc0 at 0 {
-				allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
-			};
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins_a>;
+	status = "okay";
+};
 
-			mmc0_cd_pin_colombus: mmc0_cd_pin at 0 {
-				allwinner,pins = "PA8";
-				allwinner,function = "gpio_in";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
-			};
+&mmc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_colombus>;
+	vmmc-supply = <&reg_vcc3v0>;
+	bus-width = <4>;
+	cd-gpios = <&pio 0 8 GPIO_ACTIVE_HIGH>; /* PA8 */
+	cd-inverted;
+	status = "okay";
+};
 
-			usb2_vbus_pin_colombus: usb2_vbus_pin at 0 {
-				allwinner,pins = "PH24";
-				allwinner,function = "gpio_out";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
-		};
+&mmc0_pins_a {
+	allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+};
 
-		uart0: serial at 01c28000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&uart0_pins_a>;
-			status = "okay";
-		};
+&pio {
+	mmc0_cd_pin_colombus: mmc0_cd_pin at 0 {
+		allwinner,pins = "PA8";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+	};
 
-		i2c0: i2c at 01c2ac00 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&i2c0_pins_a>;
-			status = "fail";
-		};
+	usb2_vbus_pin_colombus: usb2_vbus_pin at 0 {
+		allwinner,pins = "PH24";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+};
 
-		i2c1: i2c at 01c2b000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&i2c1_pins_a>;
-			status = "okay";
-		};
+&reg_usb2_vbus {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb2_vbus_pin_colombus>;
+	gpio = <&pio 7 24 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
 
-		i2c2: i2c at 01c2b400 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&i2c2_pins_a>;
-			status = "okay";
-		};
-	};
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins_a>;
+	status = "okay";
+};
 
-	reg_usb2_vbus: usb2-vbus {
-		pinctrl-names = "default";
-		pinctrl-0 = <&usb2_vbus_pin_colombus>;
-		gpio = <&pio 7 24 GPIO_ACTIVE_HIGH>;
-		status = "okay";
-	};
+&usbphy {
+	usb2_vbus-supply = <&reg_usb2_vbus>;
+	status = "okay";
 };
-- 
2.2.2
