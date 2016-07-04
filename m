From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  4 Jul 2016 15:10:57 +0200
Subject: [PATCH] ARM: dts: Ux500: fix up TVK sensor data
Message-ID: <1467637857-8205-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- Fix the I2C address and supply line names for the AK8974

- Sets up the interrupt lines to the different components as they
  actually are connected, I was confused for some time by the fact
  that several lines were connected with <NM> 0 Ohm resistors, which
  means NOT MOUNTED and is thus not 0 Ohm at all but infinite ohms,
  i.e. not connected at all.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Hi ARM SoC folks:
please apply this directly to the ARM SoC tree because I don't
think I will have more DT patches for Ux500 this merge window.
Your ux500/dt branch would be the best candidate to land this.
---
 arch/arm/boot/dts/ste-href-tvk1281618.dtsi | 62 +++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/ste-href-tvk1281618.dtsi b/arch/arm/boot/dts/ste-href-tvk1281618.dtsi
index fc5e8ce700c3..3c9f2f068c2f 100644
--- a/arch/arm/boot/dts/ste-href-tvk1281618.dtsi
+++ b/arch/arm/boot/dts/ste-href-tvk1281618.dtsi
@@ -99,46 +99,69 @@
 				vddio-supply = <&db8500_vsmps2_reg>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&accel_tvk_mode>;
-				interrupt-parent = <&gpio2>;
-				interrupts = <18 IRQ_TYPE_EDGE_FALLING>,
-					     <19 IRQ_TYPE_EDGE_FALLING>;
-			};
-			lsm303dlh at 1e {
 				/*
-				 * This magnetometer is packaged with
-				 * the accelerometer, and has a DRDY line,
-				 * however it is not connected on this
-				 * board so it can not generate interrupts.
+				 * These interrupts cannot be used: the other component
+				 * ST-Micro L3D4200D gyro that is connected to the same lines
+				 * cannot set its DRDY line to open drain, so it cannot be
+				 * shared with other peripherals. The should be defined for
+				 * the falling edge if they could be wired together.
+				 *
+				 * interrupts-extended =
+				 * <&gpio1 0 IRQ_TYPE_EDGE_FALLING>,
+				 * <&gpio2 19 IRQ_TYPE_EDGE_FALLING>;
 				 */
+			};
+			lsm303dlh at 1e {
+				/* Magnetometer */
 				compatible = "st,lsm303dlh-magn";
 				reg = <0x1e>;
 				vdd-supply = <&ab8500_ldo_aux1_reg>;
 				vddio-supply = <&db8500_vsmps2_reg>;
+				/*
+				 * These interrupts cannot be used: the other component
+				 * ST-Micro L3D4200D gyro that is connected to the same lines
+				 * cannot set its DRDY line to open drain, so it cannot be
+				 * shared with other peripherals. The should be defined for
+				 * the falling edge if they could be wired together.
+				 *
+				 * interrupts-extended =
+				 * <&gpio1 0 IRQ_TYPE_EDGE_FALLING>,
+				 * <&gpio2 19 IRQ_TYPE_EDGE_FALLING>;
+				 */
 			};
 			lis331dl at 1c {
 				/* Accelerometer */
 				compatible = "st,lis331dl-accel";
 				st,drdy-int-pin = <1>;
-				drive-open-drain;
 				reg = <0x1c>;
 				vdd-supply = <&ab8500_ldo_aux1_reg>;
 				vddio-supply = <&db8500_vsmps2_reg>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&accel_tvk_mode>;
 				interrupt-parent = <&gpio2>;
-				interrupts = <18 IRQ_TYPE_EDGE_FALLING>,
-					     <19 IRQ_TYPE_EDGE_FALLING>;
+				/* INT2 would need to be open drain */
+				interrupts = <18 IRQ_TYPE_EDGE_RISING>,
+					     <19 IRQ_TYPE_EDGE_RISING>;
 			};
 			ak8974 at 0f {
 				/* Magnetometer */
 				compatible = "asahi-kasei,ak8974";
 				reg = <0x0f>;
-				vdd-supply = <&ab8500_ldo_aux1_reg>;
-				vddio-supply = <&db8500_vsmps2_reg>;
+				avdd-supply = <&ab8500_ldo_aux1_reg>;
+				dvdd-supply = <&db8500_vsmps2_reg>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&gyro_magn_tvk_mode>;
-				interrupt-parent = <&gpio1>;
-				interrupts = <0 IRQ_TYPE_EDGE_RISING>;
+				/*
+				 * These interrupts cannot be used: the other component
+				 * ST-Micro L3D4200D gyro that is connected to the same lines
+				 * cannot set its DRDY line to open drain, so it cannot be
+				 * shared with other peripherals. The should be defined for
+				 * the falling edge if they could be wired together.
+				 *
+				 * interrupts-extended =
+				 * <&gpio1 0 IRQ_TYPE_EDGE_FALLING>,
+				 * <&gpio0 31 IRQ_TYPE_EDGE_FALLING>;
+				 */
 			};
 			l3g4200d at 68 {
 				/* Gyroscope */
@@ -149,8 +172,9 @@
 				vddio-supply = <&db8500_vsmps2_reg>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&gyro_magn_tvk_mode>;
-				interrupt-parent = <&gpio1>;
-				interrupts = <0 IRQ_TYPE_EDGE_RISING>;
+				interrupts-extended =
+				<&gpio1 0 IRQ_TYPE_EDGE_RISING>,
+				<&gpio0 31 IRQ_TYPE_EDGE_RISING>;
 			};
 			lsp001wm at 5c {
 				/* Barometer/pressure sensor */
@@ -218,7 +242,7 @@
 					/* Accelerometer interrupt lines 1 & 2 */
 					tvk_cfg {
 						pins = "GPIO82_C1", "GPIO83_D3";
-						ste,config = <&gpio_in_pu>;
+						ste,config = <&gpio_in_pd>;
 					};
 				};
 			};
-- 
2.4.11
