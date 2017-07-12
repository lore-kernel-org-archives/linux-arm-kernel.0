From: marco.franchi@nxp.com (Marco Franchi)
Date: Wed, 12 Jul 2017 10:18:20 -0300
Subject: [PATCH 2/2] ARM: dts: imx7d-sdb: Pass 'enable-gpios' and
 'power-supply'
In-Reply-To: <1499865500-8857-1-git-send-email-marco.franchi@nxp.com>
References: <1499865500-8857-1-git-send-email-marco.franchi@nxp.com>
Message-ID: <1499865500-8857-2-git-send-email-marco.franchi@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the LCD is turned on thanks to the bootloader initialization.

In order to make the kernel to turn on the LCD on is own, pass the 
'enable-gpios' and 'power-supply' properties.

Also, the GPIO1_IO01 is not used as PWM functionality on this board. It is 
connected to the PWREN pin of connector J14 and has a GPIO function, so remove 
the PWM1 node and change the GPIO1_IO01 IOMUX to GPIO function.

Signed-off-by: Marco Franchi <marco.franchi@nxp.com>
---
 arch/arm/boot/dts/imx7d-sdb.dts | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index 22e106e..b7d0348 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -118,8 +118,19 @@
 		startup-delay-us = <200000>;
 	};
 
+	reg_lcd_3v3: regulator-lcd-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "lcd-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&extended_io 7 GPIO_ACTIVE_LOW>;
+	};
+
 	panel {
 		compatible = "innolux,at043tn24";
+		pinctrl-0 = <&pinctrl_backlight>;
+		enable-gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
+		power-supply = <&reg_lcd_3v3>;
 
 		port {
 			panel_in: endpoint {
@@ -347,12 +358,6 @@
 	status = "okay";
 };
 
-&pwm1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pwm1>;
-	status = "okay";
-};
-
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
@@ -692,9 +697,9 @@
 		>;
 	};
 
-	pinctrl_pwm1: pwm1grp {
+	pinctrl_backlight: backlightgrp {
 		fsl,pins = <
-			MX7D_PAD_LPSR_GPIO1_IO01__PWM1_OUT		0x110b0
+			MX7D_PAD_LPSR_GPIO1_IO01__GPIO1_IO1 	0x110b0
 		>;
 	};
 };
-- 
2.7.4
