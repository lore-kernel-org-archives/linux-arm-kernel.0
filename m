From: shc_work@mail.ru (Alexander Shiyan)
Date: Wed, 16 Apr 2014 11:24:51 +0400
Subject: [PATCH 2/8] ARM: dts: imx51-babbage: Move "hog" pins into
 corresponded pin groups
In-Reply-To: <1397633097-1640-1-git-send-email-shc_work@mail.ru>
References: <1397633097-1640-1-git-send-email-shc_work@mail.ru>
Message-ID: <1397633097-1640-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move "hog" pins into corresponded pin groups for eSDHC1, eSDHC2,
eCSPI1, gpio-keys, regulator-fixed and codec clock.
Additionally, this patch fixes GPIO active level definition for
USB regulator.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx51-babbage.dts | 49 +++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index 2dda06b..ad143eb 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -82,6 +82,8 @@
 
 	gpio-keys {
 		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_keys>;
 
 		power {
 			label = "Power Button";
@@ -137,11 +139,13 @@
 
 		reg_usb_vbus: regulator at 0 {
 			compatible = "regulator-fixed";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_usbreg>;
 			reg = <0>;
 			regulator-name = "usb_vbus";
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
-			gpio = <&gpio2 5 0>;
+			gpio = <&gpio2 5 GPIO_ACTIVE_HIGH>;
 			enable-active-high;
 		};
 	};
@@ -323,23 +327,7 @@
 };
 
 &iomuxc {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_hog>;
-
 	imx51-babbage {
-		pinctrl_hog: hoggrp {
-			fsl,pins = <
-				MX51_PAD_GPIO1_0__SD1_CD     0x20d5
-				MX51_PAD_GPIO1_1__SD1_WP     0x20d5
-				MX51_PAD_GPIO1_5__GPIO1_5    0x100
-				MX51_PAD_GPIO1_6__GPIO1_6    0x100
-				MX51_PAD_EIM_A27__GPIO2_21   0x5
-				MX51_PAD_CSPI1_SS0__GPIO4_24 0x85
-				MX51_PAD_CSPI1_SS1__GPIO4_25 0x85
-				MX51_PAD_CSPI1_RDY__GPIO4_26 0x80000000
-			>;
-		};
-
 		pinctrl_audmux: audmuxgrp {
 			fsl,pins = <
 				MX51_PAD_AUD3_BB_TXD__AUD3_TXD		0x80000000
@@ -349,11 +337,19 @@
 			>;
 		};
 
+		pinctrl_clkcodec: clkcodecgrp {
+			fsl,pins = <
+				MX51_PAD_CSPI1_RDY__GPIO4_26		0x80000000
+			>;
+		};
+
 		pinctrl_ecspi1: ecspi1grp {
 			fsl,pins = <
 				MX51_PAD_CSPI1_MISO__ECSPI1_MISO	0x185
 				MX51_PAD_CSPI1_MOSI__ECSPI1_MOSI	0x185
 				MX51_PAD_CSPI1_SCLK__ECSPI1_SCLK	0x185
+				MX51_PAD_CSPI1_SS0__GPIO4_24		0x85 /* CS0 */
+				MX51_PAD_CSPI1_SS1__GPIO4_25		0x85 /* CS1 */
 			>;
 		};
 
@@ -365,6 +361,8 @@
 				MX51_PAD_SD1_DATA1__SD1_DATA1		0x20d5
 				MX51_PAD_SD1_DATA2__SD1_DATA2		0x20d5
 				MX51_PAD_SD1_DATA3__SD1_DATA3		0x20d5
+				MX51_PAD_GPIO1_0__SD1_CD		0x20d5
+				MX51_PAD_GPIO1_1__SD1_WP		0x20d5
 			>;
 		};
 
@@ -376,6 +374,8 @@
 				MX51_PAD_SD2_DATA1__SD2_DATA1		0x20d5
 				MX51_PAD_SD2_DATA2__SD2_DATA2		0x20d5
 				MX51_PAD_SD2_DATA3__SD2_DATA3		0x20d5
+				MX51_PAD_GPIO1_5__GPIO1_5		0x100 /* WP */
+				MX51_PAD_GPIO1_6__GPIO1_6		0x100 /* CD */
 			>;
 		};
 
@@ -402,6 +402,12 @@
 			>;
 		};
 
+		pinctrl_gpio_keys: gpiokeysgrp {
+			fsl,pins = <
+				MX51_PAD_EIM_A27__GPIO2_21		0x5
+			>;
+		};
+
 		pinctrl_gpio_leds: gpioledsgrp {
 			fsl,pins = <
 				MX51_PAD_EIM_D22__GPIO2_6		0x80000000
@@ -522,7 +528,12 @@
 				MX51_PAD_USBH1_DATA5__USBH1_DATA5	0x80000000
 				MX51_PAD_USBH1_DATA6__USBH1_DATA6	0x80000000
 				MX51_PAD_USBH1_DATA7__USBH1_DATA7	0x80000000
-				MX51_PAD_EIM_D21__GPIO2_5		0x80000000
+			>;
+		};
+
+		pinctrl_usbreg: usbreggrp {
+			fsl,pins = <
+				MX51_PAD_EIM_D21__GPIO2_5		0x85
 			>;
 		};
 	};
@@ -548,6 +559,8 @@
 
 	sgtl5000: codec at 0a {
 		compatible = "fsl,sgtl5000";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_clkcodec>;
 		reg = <0x0a>;
 		clocks = <&clk_26M>;
 		VDDA-supply = <&vdig_reg>;
-- 
1.8.3.2
