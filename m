From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 23 Feb 2016 14:15:03 +0000
Subject: [PATCH 11/12] ARM: dts: apq8064: add i2c6 device node.
In-Reply-To: <1456236639-1379-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1456236639-1379-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1456236903-2878-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds i2c6 device node and pinctrls required for IFC6410 on
MIPI-CSI connector.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-pins.dtsi | 25 +++++++++++++++++++++++++
 arch/arm/boot/dts/qcom-apq8064.dtsi      | 11 +++++++++++
 2 files changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-pins.dtsi b/arch/arm/boot/dts/qcom-apq8064-pins.dtsi
index 0cb22cf..b57c59d 100644
--- a/arch/arm/boot/dts/qcom-apq8064-pins.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064-pins.dtsi
@@ -153,6 +153,31 @@
 		};
 	};
 
+	i2c6_pins: i2c6 {
+		mux {
+			pins = "gpio16", "gpio17";
+			function = "gsbi6";
+		};
+
+		pinconf {
+			pins = "gpio16", "gpio17";
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
+
+	i2c6_pins_sleep: i2c6_pins_sleep {
+		mux {
+			pins = "gpio16", "gpio17";
+			function = "gpio";
+		};
+		pinconf {
+			pins = "gpio16", "gpio17";
+			drive-strength = <2>;
+			bias-disable = <0>;
+		};
+	};
+
 	gsbi6_uart_2pins: gsbi6_uart_2pins {
 		mux {
 			pins = "gpio14", "gpio15";
diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 445297c..5540b34 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -365,6 +365,17 @@
 				clock-names = "core", "iface";
 				status = "disabled";
 			};
+
+			gsbi6_i2c: i2c at 16580000 {
+				compatible = "qcom,i2c-qup-v1.1.1";
+				pinctrl-0 = <&i2c6_pins &i2c6_pins_sleep>;
+				pinctrl-names = "default", "sleep";
+				reg = <0x16580000 0x1000>;
+				interrupts = <GIC_SPI 157 IRQ_TYPE_NONE>;
+				clocks = <&gcc GSBI6_QUP_CLK>,
+					 <&gcc GSBI6_H_CLK>;
+				clock-names = "core", "iface";
+			};
 		};
 
 		gsbi7: gsbi at 16600000 {
-- 
1.9.1
