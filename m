From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 23 Feb 2016 14:14:33 +0000
Subject: [PATCH 05/12] ARM: dts: apq8064: add spi5 device node.
In-Reply-To: <1456236639-1379-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1456236639-1379-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1456236873-2649-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds spi5 device node, spi5 is used on ifc6410 on the
expansion connector.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-pins.dtsi | 38 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/qcom-apq8064.dtsi      | 14 ++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-pins.dtsi b/arch/arm/boot/dts/qcom-apq8064-pins.dtsi
index ce15c67..0b7b10e 100644
--- a/arch/arm/boot/dts/qcom-apq8064-pins.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064-pins.dtsi
@@ -64,6 +64,44 @@
 		};
 	};
 
+	spi5_default: spi5_default {
+		pinmux {
+			pins = "gpio51", "gpio52", "gpio54";
+			function = "gsbi5";
+		};
+
+		pinmux_cs {
+			function = "gpio";
+			pins = "gpio53";
+		};
+
+		pinconf {
+			pins = "gpio51", "gpio52", "gpio54";
+			drive-strength = <16>;
+			bias-disable;
+		};
+
+		pinconf_cs {
+			pins = "gpio53";
+			drive-strength = <16>;
+			bias-disable;
+			output-high;
+		};
+	};
+
+	spi5_sleep: spi5_sleep {
+		pinmux {
+			function = "gpio";
+			pins = "gpio51", "gpio52", "gpio53", "gpio54";
+		};
+
+		pinconf {
+			pins = "gpio51", "gpio52", "gpio53", "gpio54";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+	};
+
 	gsbi6_uart_2pins: gsbi6_uart_2pins {
 		mux {
 			pins = "gpio14", "gpio15";
diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 3fb66b9..3fefb2e 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -236,6 +236,7 @@
 				#address-cells = <1>;
 				#size-cells = <0>;
 			};
+
 		};
 
 		gsbi2: gsbi at 12480000 {
@@ -304,6 +305,19 @@
 				clock-names = "core", "iface";
 				status = "disabled";
 			};
+
+			gsbi5_spi: spi at 1a280000 {
+				compatible = "qcom,spi-qup-v1.1.1";
+				reg = <0x1a280000 0x1000>;
+				interrupts = <0 155 0>;
+				pinctrl-0 = <&spi5_default &spi5_sleep>;
+				pinctrl-names = "default", "sleep";
+				clocks = <&gcc GSBI5_QUP_CLK>, <&gcc GSBI5_H_CLK>;
+				clock-names = "core", "iface";
+				status = "disabled";
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
 		};
 
 		gsbi6: gsbi at 16500000 {
-- 
1.9.1
