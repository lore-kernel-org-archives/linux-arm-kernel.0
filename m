From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 23 Feb 2015 07:56:24 +0000
Subject: [PATCH 12/12] ARM: dts: apq8064 add i2c3 node for panel.
In-Reply-To: <424678035-12862-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <424678035-12862-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1424678184-13435-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds i2c3 node which is used for panel control on IFC6410.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts | 10 ++++++++++
 arch/arm/boot/dts/qcom-apq8064.dtsi        | 25 +++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
index ab7aee2..70fa747 100644
--- a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
@@ -20,6 +20,16 @@
 			};
 		};
 
+		gsbi3: gsbi at 16200000 {
+			status = "okay";
+			qcom,mode = <GSBI_PROT_I2C>;
+			i2c3: i2c at 16280000 {
+				status = "okay";
+				pinctrl-0 = <&i2c3_pins>;
+				pinctrl-names = "default";
+			};
+		};
+
 		gsbi at 12440000 {
 			status = "okay";
 			qcom,mode = <GSBI_PROT_I2C>;
diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 09077a0..890db8e 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -122,6 +122,13 @@
 					function = "gsbi1";
 				};
 			};
+
+			i2c3_pins: i2c3 {
+				mux {
+					pins = "gpio8", "gpio9";
+					function = "gsbi3";
+				};
+			};
 		};
 
 		intc: interrupt-controller at 2000000 {
@@ -208,6 +215,24 @@
 			};
 		};
 
+		gsbi3: gsbi at 16200000 {
+			status = "disabled";
+			compatible = "qcom,gsbi-v1.0.0";
+			reg = <0x16200000 0x100>;
+			clocks = <&gcc GSBI3_H_CLK>;
+			clock-names = "iface";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			i2c3: i2c at 16280000 {
+				compatible = "qcom,i2c-qup-v1.1.1";
+				reg = <0x16280000 0x1000>;
+				interrupts = <0 151 IRQ_TYPE_NONE>;
+				clocks = <&gcc GSBI3_QUP_CLK>, <&gcc GSBI3_H_CLK>;
+				clock-names = "core", "iface";
+			};
+		};
 
 		gsbi7: gsbi at 16600000 {
 			status = "disabled";
-- 
1.9.1
