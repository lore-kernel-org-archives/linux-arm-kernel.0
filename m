From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 10 Apr 2015 21:42:44 +0100
Subject: [PATCH v3 01/11] ARM: dts: apq8064: add RPM regulators support
In-Reply-To: <1428698491-11881-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1428698491-11881-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1428698564-11938-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds rpm node to apq8064 dt as rpm would be used by other
devices for regulator support.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 6c15112..19629c9 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -276,6 +276,30 @@
 			#reset-cells = <1>;
 		};
 
+		l2cc: clock-controller at 2011000 {
+			compatible	= "syscon";
+			reg		= <0x2011000 0x1000>;
+		};
+
+		rpm at 108000 {
+			compatible	= "qcom,rpm-apq8064";
+			reg		= <0x108000 0x1000>;
+			qcom,ipc	= <&l2cc 0x8 2>;
+
+			interrupts	= <GIC_SPI 19 IRQ_TYPE_EDGE_RISING>,
+					  <GIC_SPI 21 IRQ_TYPE_EDGE_RISING>,
+					  <GIC_SPI 22 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names	= "ack", "err", "wakeup";
+
+			regulators {
+				compatible = "qcom,rpm-pm8921-regulators";
+
+				pm8921_hdmi_switch: hdmi-switch {
+					bias-pull-down;
+				};
+			};
+		};
+
 		/* Temporary fixed regulator */
 		vsdcc_fixed: vsdcc-regulator {
 			compatible = "regulator-fixed";
-- 
1.9.1
