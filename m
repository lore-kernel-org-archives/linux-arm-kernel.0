From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  1 Feb 2015 14:49:58 +0100
Subject: [PATCH 14/30] ARM: sun5i: a13: hsg h702: Convert to DT label based
 syntax
In-Reply-To: <1422798614-3581-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1422798614-3581-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1422798614-3581-15-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to lessen the amount of duplication of the DT tree, ease the
new and follow the trend that prefers to use label based references
when overriding DTSI nodes, convert the board to this syntax

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts | 136 +++++++++++++++----------------
 1 file changed, 67 insertions(+), 69 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts b/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
index 03aa04555630..b59255a445bc 100644
--- a/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
+++ b/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
@@ -59,82 +59,69 @@
 	aliases {
 		serial0 = &uart1;
 	};
+};
+
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
+&ehci0 {
+	status = "okay";
+};
 
-	soc at 01c00000 {
-		mmc0: mmc at 01c0f000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_h702>;
-			vmmc-supply = <&reg_vcc3v3>;
-			bus-width = <4>;
-			cd-gpios = <&pio 6 0 GPIO_ACTIVE_HIGH>; /* PG0 */
-			cd-inverted;
-			status = "okay";
-		};
-
-		usbphy: phy at 01c13400 {
-			usb1_vbus-supply = <&reg_ldo3>;
-			status = "okay";
-		};
-
-		ehci0: usb at 01c14000 {
-			status = "okay";
-		};
-
-		ohci0: usb at 01c14400 {
-			status = "okay";
-		};
-
-		pinctrl at 01c20800 {
-			mmc0_cd_pin_h702: mmc0_cd_pin at 0 {
-				allwinner,pins = "PG0";
-				allwinner,function = "gpio_in";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
-			};
-		};
-
-		uart1: serial at 01c28400 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&uart1_pins_b>;
-			status = "okay";
-		};
-
-		i2c0: i2c at 01c2ac00 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&i2c0_pins_a>;
-			status = "okay";
-
-			axp209: pmic at 34 {
-				reg = <0x34>;
-				interrupts = <0>;
-			};
-		};
-
-		i2c1: i2c at 01c2b000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&i2c1_pins_a>;
-			status = "okay";
-
-			pcf8563: rtc at 51 {
-				compatible = "nxp,pcf8563";
-				reg = <0x51>;
-			};
-		};
-
-		i2c2: i2c at 01c2b400 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&i2c2_pins_a>;
-			status = "okay";
-		};
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins_a>;
+	status = "okay";
+
+	axp209: pmic at 34 {
+		reg = <0x34>;
+		interrupts = <0>;
 	};
 };
 
-#include "axp209.dtsi"
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins_a>;
+	status = "okay";
 
-&cpu0 {
-	cpu-supply = <&reg_dcdc2>;
+	pcf8563: rtc at 51 {
+		compatible = "nxp,pcf8563";
+		reg = <0x51>;
+	};
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins_a>;
+	status = "okay";
 };
 
+&mmc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_h702>;
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <4>;
+	cd-gpios = <&pio 6 0 GPIO_ACTIVE_HIGH>; /* PG0 */
+	cd-inverted;
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&pio {
+	mmc0_cd_pin_h702: mmc0_cd_pin at 0 {
+		allwinner,pins = "PG0";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+	};
+};
+
+#include "axp209.dtsi"
+
 &reg_dcdc2 {
 	regulator-always-on;
 	regulator-min-microvolt = <1000000>;
@@ -165,3 +152,14 @@
 	regulator-max-microvolt = <3300000>;
 	regulator-name = "vcc-wifi";
 };
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins_b>;
+	status = "okay";
+};
+
+&usbphy {
+	usb1_vbus-supply = <&reg_ldo3>;
+	status = "okay";
+};
-- 
2.2.2
