From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 26 Oct 2016 11:23:14 +0200
Subject: [PATCH v3] ARM: dts: Add gyro and accel to APQ8060 Dragonboard
Message-ID: <1477473794-26030-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the MPU-3050 gyroscope and the KXSD9 accelerometer to
the Qualcomm APQ8060 Dragonboard. The KXSD9 is mounted beyond the
MPU-3050 and appear as a subdevice beyond it. We set up the
required GPIO and interrupt lines to make the devices work.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Should be fine to apply now: all bindings and requirements are
  merged.
ChangeLog v1->v2:
- Use the new I2C mux gate bindings from Peter Rosin (merged to
  the I2C subsystem)
---
 arch/arm/boot/dts/qcom-apq8060-dragonboard.dts | 53 ++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts b/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
index 6c0038398ef2..1d76b7415f08 100644
--- a/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
+++ b/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
@@ -167,6 +167,14 @@
 					bias-pull-up;
 				};
 			};
+
+			/* Interrupt line for the KXSD9 accelerometer */
+			dragon_kxsd9_gpios: kxsd9 {
+				irq {
+					pins = "gpio57"; /* IRQ line */
+					bias-pull-up;
+				};
+			};
 		};
 
 		qcom,ssbi at 500000 {
@@ -210,6 +218,15 @@
 							power-source = <PM8058_GPIO_S3>;
 						};
 					};
+					dragon_mpu3050_gpios: mpu3050-gpios {
+						pinconf {
+							pins = "gpio17";
+							function = "normal";
+							input-enable;
+							bias-disable;
+							power-source = <PM8058_GPIO_S3>;
+						};
+					};
 					dragon_sdcc3_gpios: sdcc3-gpios {
 						pinconf {
 							pins = "gpio22";
@@ -319,6 +336,42 @@
 					vddd-supply = <&pm8058_lvs0>; // 1.8V
 					vdda-supply = <&pm8058_l14>; // 2.85V
 				};
+				mpu3050 at 68 {
+					compatible = "invensense,mpu3050";
+					reg = <0x68>;
+					/*
+					 * GPIO17 has interrupt 208 on the
+					 * PM8058, it is pulled high by a 10k
+					 * resistor to VLOGIC so needs to be
+					 * active low/falling edge.
+					 */
+					interrupt-parent = <&pm8058_gpio>;
+					interrupts = <208 IRQ_TYPE_EDGE_FALLING>;
+					pinctrl-names = "default";
+					pinctrl-0 = <&dragon_mpu3050_gpios>;
+					vlogic-supply = <&pm8058_lvs0>; // 1.8V
+					vdd-supply = <&pm8058_l14>; // 2.85V
+
+					/*
+					 * The MPU-3050 acts as a hub for the
+					 * accelerometer.
+					 */
+					i2c-gate {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						kxsd9 at 18 {
+							compatible = "kionix,kxsd9";
+							reg = <0x18>;
+							interrupt-parent = <&tlmm>;
+							interrupts = <57 IRQ_TYPE_EDGE_FALLING>;
+							pinctrl-names = "default";
+							pinctrl-0 = <&dragon_kxsd9_gpios>;
+							iovdd-supply = <&pm8058_lvs0>; // 1.8V
+							vdd-supply = <&pm8058_l14>; // 2.85V
+						};
+					};
+				};
 			};
 		};
 
-- 
2.7.4
