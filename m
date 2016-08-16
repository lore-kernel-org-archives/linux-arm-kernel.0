From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 16 Aug 2016 10:46:30 -0700
Subject: [PATCH] ARM: dts: msm8974: honami: Add touchscreen
Message-ID: <1471369590-12978-1-git-send-email-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the i2c2 and rmi4 nodes to enable the Synaptics touchscreen found in
the Honami.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../boot/dts/qcom-msm8974-sony-xperia-honami.dts   | 59 ++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
index 3fb4dada6b0d..0d414ef9d3d0 100644
--- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
@@ -311,6 +311,45 @@
 		pinctrl-0 = <&blsp1_uart2_pin_a>;
 	};
 
+	i2c at f9924000 {
+		status = "ok";
+
+		clock-frequency = <355000>;
+		qcom,src-freq = <50000000>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c2_pins>;
+
+		synaptics at 2c {
+			compatible = "syna,rmi4-i2c";
+			reg = <0x2c>;
+
+			interrupts-extended = <&msmgpio 61 IRQ_TYPE_EDGE_FALLING>;
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			vdd-supply = <&pm8941_l22>;
+			vio-supply = <&pm8941_lvs3>;
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&ts_int_pin>;
+
+			syna,startup-delay-ms = <10>;
+
+			rmi4-f01 at 1 {
+				reg = <0x1>;
+				syna,nosleep-mode = <1>;
+			};
+
+			rmi4-f11 at 11 {
+				reg = <0x11>;
+				touchscreen-inverted-x;
+				syna,sensor-type = <1>;
+			};
+		};
+	};
+
 	pinctrl at fd510000 {
 		blsp1_uart2_pin_a: blsp1-uart2-pin-active {
 			rx {
@@ -330,6 +369,16 @@
 			};
 		};
 
+		i2c2_pins: i2c2 {
+			mux {
+				pins = "gpio6", "gpio7";
+				function = "blsp_i2c2";
+
+				drive-strength = <2>;
+				bias-disable;
+			};
+		};
+
 		sdhc1_pin_a: sdhc1-pin-active {
 			clk {
 				pins = "sdc1_clk";
@@ -366,6 +415,16 @@
 			};
 		};
 
+		ts_int_pin: touch-int {
+			pin {
+				pins = "gpio61";
+				function = "gpio";
+
+				drive-strength = <2>;
+				bias-disable;
+				input-enable;
+			};
+		};
 	};
 
 	dma-controller at f9944000 {
-- 
2.5.0
