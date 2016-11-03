From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu,  3 Nov 2016 10:13:10 +0100
Subject: [PATCH 3/3] ARM: dts: Add gyro and accel to APQ8060 Dragonboard
In-Reply-To: <1478164390-21613-1-git-send-email-linus.walleij@linaro.org>
References: <1478164390-21613-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1478164390-21613-3-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the MPU-3050 gyroscope and the KXSD9 accelerometer to
the Qualcomm APQ8060 Dragonboard. The KXSD9 is mounted beyond the
MPU-3050 and appear as a subdevice beyond it. We set up the
required GPIO and interrupt lines to make the devices work.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Move the interrupt to the pm8058 alias to reflect the two patches
  properly specifying the PMIC as interrupt parent.
ChangeLog v1->v2:
- Use the new I2C mux gate bindings from Peter Rosin (merged to
  the I2C subsystem)
---
 arch/arm/boot/dts/qcom-apq8060-dragonboard.dts | 53 ++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts b/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
index ea660ffa03ea..c1b99c9cb318 100644
--- a/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
+++ b/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
@@ -220,6 +220,14 @@
 					function = "ebi2";
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
@@ -272,6 +280,15 @@
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
@@ -389,6 +406,42 @@
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
+					interrupt-parent = <&pm8058>;
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
