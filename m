From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 15 May 2017 09:50:12 +0200
Subject: [PATCH 1/2] ARM: dts: add GSBI8 defines to the MSM8660 family
Message-ID: <20170515075012.3696-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This defines the memory location and interrupt used by the GSBI8
I2C adapter on the MSM8660 SoCs. We add it as "disabled" by
default so that boards using this I2C can enable it.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/qcom-msm8660.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
index 747669a62aa8..a53c0f9970bd 100644
--- a/arch/arm/boot/dts/qcom-msm8660.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
@@ -107,6 +107,31 @@
 			reg = <0x900000 0x4000>;
 		};
 
+
+		gsbi8: gsbi at 19800000 {
+			compatible = "qcom,gsbi-v1.0.0";
+			cell-index = <12>;
+			reg = <0x19800000 0x100>;
+			clocks = <&gcc GSBI8_H_CLK>;
+			clock-names = "iface";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			syscon-tcsr = <&tcsr>;
+
+			gsbi8_i2c: i2c at 19880000 {
+				compatible = "qcom,i2c-qup-v1.1.1";
+				reg = <0x19880000 0x1000>;
+				interrupts = <0 161 IRQ_TYPE_NONE>;
+				clocks = <&gcc GSBI8_QUP_CLK>, <&gcc GSBI8_H_CLK>;
+				clock-names = "core", "iface";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+		};
+
 		gsbi12: gsbi at 19c00000 {
 			compatible = "qcom,gsbi-v1.0.0";
 			cell-index = <12>;
-- 
2.9.3
