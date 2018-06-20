From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Wed, 20 Jun 2018 13:41:16 +0300
Subject: [PATCH] ARM: dts: imx7d-sdb: Restore pwm backlight support
Message-ID: <c328d3e13702fa624febe08d7cd68df5b82b8c30.1529490998.git.leonard.crestez@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This was removed in commit 5eaeaccdaedb ("ARM: dts: imx7d-sdb: Pass
'enable-gpios' and 'power-supply' properties") with a note claiming that
GPIO1_IO01 is connected to a pin labeled as "PWREN" on the connector.

Despite that label this pin does actually work as a PWM controlling
brightness. So restore pwm functionality.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm/boot/dts/imx7d-sdb.dts | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

This was tested with the suggested LCD8000-43T, maybe there are other
display options which don't have PWM and require that pin to be always
enabled?

This same LCD is also supported on imx6ul-14x14-evk with a similar
backlight.

diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index 940849163104..bf6f21b984ca 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -114,14 +114,21 @@
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		gpio = <&gpio2 14 GPIO_ACTIVE_LOW>;
 	};
 
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm1 0 5000000 0>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <6>;
+		status = "okay";
+	};
+
 	panel {
 		compatible = "innolux,at043tn24";
-		pinctrl-0 = <&pinctrl_backlight>;
-		enable-gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
+		backlight = <&backlight>;
 		power-supply = <&reg_lcd_3v3>;
 
 		port {
 			panel_in: endpoint {
 				remote-endpoint = <&display_out>;
@@ -710,18 +717,24 @@
 			>;
 		};
 	};
 };
 
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm1>;
+	status = "okay";
+};
+
 &iomuxc_lpsr {
 	pinctrl_wdog: wdoggrp {
 		fsl,pins = <
 			MX7D_PAD_LPSR_GPIO1_IO00__WDOG1_WDOG_B		0x74
 		>;
 	};
 
-	pinctrl_backlight: backlightgrp {
+	pinctrl_pwm1: pwm1grp {
 		fsl,pins = <
-			MX7D_PAD_LPSR_GPIO1_IO01__GPIO1_IO1		0x110b0
+			MX7D_PAD_LPSR_GPIO1_IO01__PWM1_OUT		0x30
 		>;
 	};
 };
-- 
2.17.1
