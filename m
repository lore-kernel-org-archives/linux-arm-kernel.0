From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 12 Apr 2016 10:33:52 +0100
Subject: [PATCH v2 03/13] ARM: dts: apq8064: add gsbi7 i2c support
In-Reply-To: <1460453642-5809-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1460453642-5809-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1460453642-5809-4-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support to gsbi7 i2c which is used in some of the new
boards.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-pins.dtsi | 25 +++++++++++++++++++++++++
 arch/arm/boot/dts/qcom-apq8064.dtsi      | 13 +++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-pins.dtsi b/arch/arm/boot/dts/qcom-apq8064-pins.dtsi
index 8bb5e5f..4102a98 100644
--- a/arch/arm/boot/dts/qcom-apq8064-pins.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064-pins.dtsi
@@ -219,4 +219,29 @@
 			function = "gsbi7";
 		};
 	};
+
+	i2c7_pins: i2c7 {
+		mux {
+			pins = "gpio84", "gpio85";
+			function = "gsbi7";
+		};
+
+		pinconf {
+			pins = "gpio84", "gpio85";
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
+
+	i2c7_pins_sleep: i2c7_pins_sleep {
+		mux {
+			pins = "gpio84", "gpio85";
+			function = "gpio";
+		};
+		pinconf {
+			pins = "gpio84", "gpio85";
+			drive-strength = <2>;
+			bias-disable = <0>;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 81b4290..f064f59 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -417,6 +417,19 @@
 				clock-names = "core", "iface";
 				status = "disabled";
 			};
+
+			gsbi7_i2c: i2c at 16680000 {
+				compatible = "qcom,i2c-qup-v1.1.1";
+				pinctrl-0 = <&i2c7_pins>;
+				pinctrl-1 = <&i2c7_pins_sleep>;
+				pinctrl-names = "default", "sleep";
+				reg = <0x16680000 0x1000>;
+				interrupts = <GIC_SPI 159 IRQ_TYPE_NONE>;
+				clocks = <&gcc GSBI7_QUP_CLK>,
+					 <&gcc GSBI7_H_CLK>;
+				clock-names = "core", "iface";
+				status = "disabled";
+			};
 		};
 
 		rng at 1a500000 {
-- 
2.5.0
