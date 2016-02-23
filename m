From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 23 Feb 2016 14:14:50 +0000
Subject: [PATCH 09/12] ARM: dts: apq8064: add gsbi4 with i2c node.
In-Reply-To: <1456236639-1379-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1456236639-1379-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1456236890-2783-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds gsbi4 and i2c node.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-pins.dtsi | 25 +++++++++++++++++++++++++
 arch/arm/boot/dts/qcom-apq8064.dtsi      | 23 +++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-pins.dtsi b/arch/arm/boot/dts/qcom-apq8064-pins.dtsi
index 0a342d3..0cb22cf 100644
--- a/arch/arm/boot/dts/qcom-apq8064-pins.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064-pins.dtsi
@@ -90,6 +90,31 @@
 		};
 	};
 
+	i2c4_pins: i2c4 {
+		mux {
+			pins = "gpio12", "gpio13";
+			function = "gsbi4";
+		};
+
+		pinconf {
+			pins = "gpio12", "gpio13";
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
+
+	i2c4_pins_sleep: i2c4_pins_sleep {
+		mux {
+			pins = "gpio12", "gpio13";
+			function = "gpio";
+		};
+		pinconf {
+			pins = "gpio12", "gpio13";
+			drive-strength = <2>;
+			bias-disable = <0>;
+		};
+	};
+
 	spi5_default: spi5_default {
 		pinmux {
 			pins = "gpio51", "gpio52", "gpio54";
diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 2367adc..445297c 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -287,6 +287,29 @@
 			};
 		};
 
+		gsbi4: gsbi at 16300000 {
+			status = "disabled";
+			compatible = "qcom,gsbi-v1.0.0";
+			cell-index = <4>;
+			reg = <0x16300000 0x03>;
+			clocks = <&gcc GSBI4_H_CLK>;
+			clock-names = "iface";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			gsbi4_i2c: i2c at 16380000 {
+				compatible = "qcom,i2c-qup-v1.1.1";
+				pinctrl-0 = <&i2c4_pins &i2c4_pins_sleep>;
+				pinctrl-names = "default", "sleep";
+				reg = <0x16380000 0x1000>;
+				interrupts = <GIC_SPI 153 IRQ_TYPE_NONE>;
+				clocks = <&gcc GSBI4_QUP_CLK>,
+					 <&gcc GSBI4_H_CLK>;
+				clock-names = "core", "iface";
+			};
+		};
+
 		gsbi5: gsbi at 1a200000 {
 			status = "disabled";
 			compatible = "qcom,gsbi-v1.0.0";
-- 
1.9.1
