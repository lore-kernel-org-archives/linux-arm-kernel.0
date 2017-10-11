From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Wed, 11 Oct 2017 13:07:40 +0200
Subject: [PATCH 6/7] ARM: dts: imx53-tx53: add support for I2C bus recovery
In-Reply-To: <1507720061-27666-1-git-send-email-LW@KARO-electronics.de>
References: <1507720061-27666-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1507720061-27666-7-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The imx-i2c driver supports automatic bus recovery via the GPIO
function of the I2C pins. Enable this functionality for the Ka-Ro
electronics TX53 modules.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx53-tx53-x13x.dts |  5 ++++-
 arch/arm/boot/dts/imx53-tx53.dtsi     | 19 ++++++++++++++++++-
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-tx53-x13x.dts b/arch/arm/boot/dts/imx53-tx53-x13x.dts
index e21bc91..a87a10b 100644
--- a/arch/arm/boot/dts/imx53-tx53-x13x.dts
+++ b/arch/arm/boot/dts/imx53-tx53-x13x.dts
@@ -121,8 +121,11 @@
 };
 
 &i2c3 {
-	pinctrl-names = "default";
+	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c3>;
+	pinctrl-1 = <&pinctrl_i2c3_gpio>;
+	scl-gpios = <&gpio3 21 GPIO_ACTIVE_HIGH>;
+	sda-gpios = <&gpio3 28 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 
 	sgtl5000: codec at 0a {
diff --git a/arch/arm/boot/dts/imx53-tx53.dtsi b/arch/arm/boot/dts/imx53-tx53.dtsi
index 33934e5..8e10c47 100644
--- a/arch/arm/boot/dts/imx53-tx53.dtsi
+++ b/arch/arm/boot/dts/imx53-tx53.dtsi
@@ -233,8 +233,11 @@
 };
 
 &i2c1 {
-	pinctrl-names = "default";
+	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c1>;
+	pinctrl-0 = <&pinctrl_i2c1_gpio>;
+	scl-gpios = <&gpio3 21 GPIO_ACTIVE_HIGH>;
+	sda-gpios = <&gpio3 28 GPIO_ACTIVE_HIGH>;
 	clock-frequency = <400000>;
 	status = "okay";
 
@@ -394,6 +397,13 @@
 			>;
 		};
 
+		pinctrl_i2c1_gpio: i2c1-gpiogrp {
+			fsl,pins = <
+				MX53_PAD_EIM_D21__GPIO3_21		0x400001e6
+				MX53_PAD_EIM_D28__GPIO3_28		0x400001e6
+			>;
+		};
+
 		pinctrl_i2c3: i2c3grp {
 			fsl,pins = <
 				MX53_PAD_GPIO_3__I2C3_SCL		0x400001e4
@@ -401,6 +411,13 @@
 			>;
 		};
 
+		pinctrl_i2c3_gpio: i2c3-gpiogrp {
+			fsl,pins = <
+				MX53_PAD_GPIO_3__GPIO1_3		0x400001e6
+				MX53_PAD_GPIO_6__GPIO1_6		0x400001e6
+			>;
+		};
+
 		pinctrl_nand: nandgrp {
 			fsl,pins = <
 				MX53_PAD_NANDF_WE_B__EMI_NANDF_WE_B	0x4
-- 
2.1.4
