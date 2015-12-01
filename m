From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue,  1 Dec 2015 14:48:51 +0100
Subject: [PATCH] ARM: ux500: configure the sensors on the TVK board correctly
Message-ID: <1448977731-7719-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The U8500 HREF TVK board actually has a large set of sensors, with
their interrupt lines connected using open drain electronics.
Configure the two accelerometers and two magnetometers so we get
all sensors to actually probe on boot.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-href-tvk1281618.dtsi | 50 +++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/ste-href-tvk1281618.dtsi b/arch/arm/boot/dts/ste-href-tvk1281618.dtsi
index 3228119f91d1..b7b4211c5353 100644
--- a/arch/arm/boot/dts/ste-href-tvk1281618.dtsi
+++ b/arch/arm/boot/dts/ste-href-tvk1281618.dtsi
@@ -104,13 +104,40 @@
 					     <19 IRQ_TYPE_EDGE_RISING>;
 			};
 			lsm303dlh at 1e {
-				/* Magnetometer */
+				/*
+				 * This magnetometer is packaged with
+				 * the accelerometer, and has a DRDY line,
+				 * however it is not connected on this
+				 * board so it can not generate interrupts.
+				 */
 				compatible = "st,lsm303dlh-magn";
 				reg = <0x1e>;
 				vdd-supply = <&ab8500_ldo_aux1_reg>;
 				vddio-supply = <&db8500_vsmps2_reg>;
+			};
+			lis331dl at 1c {
+				/* Accelerometer */
+				compatible = "st,lis331dl-accel";
+				st,drdy-int-pin = <1>;
+				reg = <0x1c>;
+				vdd-supply = <&ab8500_ldo_aux1_reg>;
+				vddio-supply = <&db8500_vsmps2_reg>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&accel_tvk_mode>;
+				interrupt-parent = <&gpio2>;
+				interrupts = <18 IRQ_TYPE_EDGE_RISING>,
+					     <19 IRQ_TYPE_EDGE_RISING>;
+			};
+			ak8974 at 0f {
+				/* Magnetometer */
+				compatible = "asahi-kasei,ak8974";
+				reg = <0x0f>;
+				vdd-supply = <&ab8500_ldo_aux1_reg>;
+				vddio-supply = <&db8500_vsmps2_reg>;
 				pinctrl-names = "default";
-				pinctrl-0 = <&magneto_tvk_mode>;
+				pinctrl-0 = <&gyro_magn_tvk_mode>;
+				interrupt-parent = <&gpio1>;
+				interrupts = <0 IRQ_TYPE_EDGE_RISING>;
 			};
 			l3g4200d at 68 {
 				/* Gyroscope */
@@ -119,6 +146,10 @@
 				reg = <0x68>;
 				vdd-supply = <&ab8500_ldo_aux1_reg>;
 				vddio-supply = <&db8500_vsmps2_reg>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&gyro_magn_tvk_mode>;
+				interrupt-parent = <&gpio1>;
+				interrupts = <0 IRQ_TYPE_EDGE_RISING>;
 			};
 			lsp001wm at 5c {
 				/* Barometer/pressure sensor */
@@ -159,17 +190,22 @@
 					/* Accelerometer interrupt lines 1 & 2 */
 					tvk_cfg {
 						pins = "GPIO82_C1", "GPIO83_D3";
-						ste,config = <&gpio_in_pu>;
+						ste,config = <&gpio_in_pd>;
 					};
 				};
 			};
-			magnetometer {
-				magneto_tvk_mode: magneto_tvk {
-					/* Magnetometer uses GPIO 31 and 32, pull these up/down respectively */
+			gyroscope {
+				/*
+				 * These lines are shared between Gyroscope l3g400dh
+				 * and AK8974 magnetometer.
+				 */
+				gyro_magn_tvk_mode: gyro_magn_tvk {
+					 /* GPIO 31 used for INT pull down the line */
 					tvk_cfg1 {
 						pins = "GPIO31_V3";
-						ste,config = <&gpio_in_pu>;
+						ste,config = <&gpio_in_pd>;
 					};
+					/* GPIO 32 used for DRDY, pull this down */
 					tvk_cfg2 {
 						pins = "GPIO32_V2";
 						ste,config = <&gpio_in_pd>;
-- 
2.4.3
