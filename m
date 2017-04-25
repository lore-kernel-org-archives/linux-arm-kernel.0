From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 25 Apr 2017 10:03:32 +0200
Subject: [PATCH 2/2 v5] ARM: dts: Qualcomm APQ8060 DragonBoard ALS sensor
Message-ID: <20170425080332.3923-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the Capella CM3605 ambient light and proximity sensor
to the APQ8060 DragonBoard device tree. Notice that we also set
up pin config for the AOUT line and GPIO lines, and that we set
the default trigger on the infrared LED to associate with the
"cm3605" trigger so the IR LED is controlled by this the CM3605
driver.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v5:
- Switch to the twocell addressing scheme specified in the new
  bindings.
- The bindings and IIO driver are both queued for v4.12 in the
  IIO tree and pending in linux-next
---
 arch/arm/boot/dts/qcom-apq8060-dragonboard.dts | 80 ++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts b/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
index 39d9e6ddefed..355b3b9c31bc 100644
--- a/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
+++ b/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
@@ -23,6 +23,7 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+#include <dt-bindings/pinctrl/qcom,pmic-mpp.h>
 #include "qcom-msm8660.dtsi"
 
 / {
@@ -83,6 +84,25 @@
 		};
 	};
 
+	/*
+	 * Capella CM3605 light and proximity sensor mounted directly
+	 * on the sensor board.
+	 */
+	cm3605 {
+		compatible = "capella,cm3605";
+		vdd-supply = <&pm8058_l14>; // 2.85V
+		aset-gpios = <&pm8058_gpio 35 GPIO_ACTIVE_LOW>;
+		capella,aset-resistance-ohms = <100000>;
+		/* GPIO34 has interrupt 225 on the PM8058 */
+		/* Trig on both edges - getting close or far away */
+		interrupts-extended = <&pm8058 225 IRQ_TYPE_EDGE_BOTH>;
+		/* MPP05 analog input to the XOADC */
+		io-channels = <&xoadc 0x00 0x05>;
+		io-channel-names = "aout";
+		pinctrl-names = "default";
+		pinctrl-0 = <&dragon_cm3605_gpios>, <&dragon_cm3605_mpps>;
+	};
+
 	soc {
 		pinctrl at 800000 {
 			/* eMMMC pins, all 8 data lines connected */
@@ -317,6 +337,24 @@
 							power-source = <PM8058_GPIO_S3>;
 						};
 					};
+					dragon_cm3605_gpios: cm3605-gpios {
+						/* Pin 34 connected to the proxy IRQ */
+						pinconf_gpio34 {
+							pins = "gpio34";
+							function = "normal";
+							input-enable;
+							bias-disable;
+							power-source = <PM8058_GPIO_S3>;
+						};
+						/* Pin 35 connected to ASET */
+						pinconf_gpio35 {
+							pins = "gpio35";
+							function = "normal";
+							output-high;
+							bias-disable;
+							power-source = <PM8058_GPIO_S3>;
+						};
+					};
 					dragon_veth_gpios: veth-gpios {
 						pinconf {
 							pins = "gpio40";
@@ -327,6 +365,47 @@
 					};
 				};
 
+				mpps at 50 {
+					dragon_cm3605_mpps: cm3605-mpps {
+						pinconf {
+							pins = "mpp5";
+							function = "analog";
+							input-enable;
+							bias-high-impedance;
+							/* Let's use channel 5 */
+							qcom,amux-route = <PMIC_MPP_AMUX_ROUTE_CH5>;
+							power-source = <PM8058_GPIO_S3>;
+						};
+					};
+				};
+
+				xoadc at 197 {
+					/* Reference voltage 2.2 V */
+					xoadc-ref-supply = <&pm8058_l18>;
+
+					/* Board-specific channels */
+					mpp5 at 05 {
+						/* Connected to AOUT of ALS sensor */
+						reg = <0x00 0x05>;
+					};
+					mpp6 at 06 {
+						/* Connected to test point TP43 */
+						reg = <0x00 0x06>;
+					};
+					mpp7 at 07 {
+						/* Connected to battery thermistor */
+						reg = <0x00 0x07>;
+					};
+					mpp8 at 08 {
+						/* Connected to battery ID detector */
+						reg = <0x00 0x08>;
+					};
+					mpp9 at 09 {
+						/* Connected to XO thermistor */
+						reg = <0x00 0x09>;
+					};
+				};
+
 				led at 48 {
 					/*
 					 * The keypad LED @0x48 is routed to
@@ -340,6 +419,7 @@
 					reg = <0x48>;
 					label = "pm8058:infrared:proximitysensor";
 					default-state = "off";
+					linux,default-trigger = "cm3605";
 				};
 				led at 131 {
 					compatible = "qcom,pm8058-led";
-- 
2.9.3
