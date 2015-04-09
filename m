From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Thu,  9 Apr 2015 09:22:41 +0100
Subject: [PATCH 01/10] ARM: dts: apq8064: add RPM regulators support
In-Reply-To: <1428567674-10672-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1428567674-10672-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1428567761-10765-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds rpm node to apq8064 dt as rpm would be used by other
devices for regulator support. Also adds all the regulators in the rpm.

Most content of this patch was originally posted by Stephen Boyd on the
list.
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 272 ++++++++++++++++++++++++++++++++++++
 1 file changed, 272 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 6c15112..d9166eb 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -3,6 +3,7 @@
 #include "skeleton.dtsi"
 #include <dt-bindings/clock/qcom,gcc-msm8960.h>
 #include <dt-bindings/clock/qcom,mmcc-msm8960.h>
+#include <dt-bindings/mfd/qcom-rpm.h>
 #include <dt-bindings/soc/qcom,gsbi.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
@@ -276,6 +277,277 @@
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
+			interrupts	= <GIC_SPI 19 IRQ_TYPE_NONE>,
+					  <GIC_SPI 21 IRQ_TYPE_NONE>,
+					  <GIC_SPI 22 IRQ_TYPE_NONE>;
+			interrupt-names	= "ack", "err", "wakeup";
+
+			regulators {
+				compatible = "qcom,rpm-pm8921-regulators";
+				vdd_l1_l2_l12_l18-supply = <&pm8921_s4>;
+				vin_lvs1_3_6-supply = <&pm8921_s4>;
+				vin_lvs2-supply = <&pm8921_s4>;
+				vin_lvs4_5_7-supply = <&pm8921_s4>;
+				vdd_ncp-supply = <&pm8921_l6>;
+				vdd_l24-supply = <&pm8921_s1>;
+				vdd_l25-supply = <&pm8921_s1>;
+				vdd_l27-supply = <&pm8921_s7>;
+				vdd_l28-supply = <&pm8921_s7>;
+
+				/* Buck SMPS */
+				pm8921_s1: s1 {
+					regulator-always-on;
+					regulator-min-microvolt = <1225000>;
+					regulator-max-microvolt = <1225000>;
+					qcom,switch-mode-frequency = <3200000>;
+					bias-pull-down;
+				};
+
+				pm8921_s2: s2 {
+					regulator-min-microvolt = <1300000>;
+					regulator-max-microvolt = <1300000>;
+					qcom,switch-mode-frequency = <1600000>;
+					bias-pull-down;
+				};
+
+				pm8921_s3: s3 {
+					regulator-min-microvolt = <500000>;
+					regulator-max-microvolt = <1150000>;
+					qcom,switch-mode-frequency = <4800000>;
+					bias-pull-down;
+				};
+
+				pm8921_s4: s4 {
+					regulator-always-on;
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					qcom,switch-mode-frequency = <1600000>;
+					bias-pull-down;
+					qcom,force-mode =
+						<QCOM_RPM_FORCE_MODE_AUTO>;
+				};
+
+				pm8921_s7: s7 {
+					regulator-min-microvolt = <1300000>;
+					regulator-max-microvolt = <1300000>;
+					qcom,switch-mode-frequency = <3200000>;
+				};
+
+				pm8921_s8: s8 {
+					regulator-min-microvolt = <2200000>;
+					regulator-max-microvolt = <2200000>;
+					qcom,switch-mode-frequency = <1600000>;
+				};
+
+				/* PMOS LDO */
+				pm8921_l1: l1 {
+					regulator-always-on;
+					regulator-min-microvolt = <1100000>;
+					regulator-max-microvolt = <1100000>;
+					bias-pull-down;
+				};
+
+				pm8921_l2: l2 {
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1200000>;
+					bias-pull-down;
+				};
+
+				pm8921_l3: l3 {
+					regulator-min-microvolt = <3075000>;
+					regulator-max-microvolt = <3075000>;
+					bias-pull-down;
+				};
+
+				pm8921_l4: l4 {
+					regulator-always-on;
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					bias-pull-down;
+				};
+
+				pm8921_l5: l5 {
+					regulator-min-microvolt = <2950000>;
+					regulator-max-microvolt = <2950000>;
+					bias-pull-down;
+				};
+
+				pm8921_l6: l6 {
+					regulator-min-microvolt = <2950000>;
+					regulator-max-microvolt = <2950000>;
+					bias-pull-down;
+				};
+
+				pm8921_l7: l7 {
+					regulator-min-microvolt = <1850000>;
+					regulator-max-microvolt = <2950000>;
+					bias-pull-down;
+				};
+
+				pm8921_l8: l8 {
+					regulator-min-microvolt = <2800000>;
+					regulator-max-microvolt = <2800000>;
+					bias-pull-down;
+				};
+
+				pm8921_l9: l9 {
+					regulator-min-microvolt = <3000000>;
+					regulator-max-microvolt = <3000000>;
+					bias-pull-down;
+				};
+
+				pm8921_l10: l10 {
+					regulator-min-microvolt = <2900000>;
+					regulator-max-microvolt = <2900000>;
+					bias-pull-down;
+				};
+
+				pm8921_l11: l11 {
+					regulator-min-microvolt = <3000000>;
+					regulator-max-microvolt = <3000000>;
+					bias-pull-down;
+				};
+
+				pm8921_l12: l12 {
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1200000>;
+					bias-pull-down;
+				};
+
+				pm8921_l13: l13 {
+					regulator-min-microvolt = <2220000>;
+					regulator-max-microvolt = <2220000>;
+				};
+
+				pm8921_l14: l14 {
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					bias-pull-down;
+				};
+
+				pm8921_l15: l15 {
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <2950000>;
+					bias-pull-down;
+				};
+
+				pm8921_l16: l16 {
+					regulator-min-microvolt = <2800000>;
+					regulator-max-microvolt = <2800000>;
+					bias-pull-down;
+				};
+
+				pm8921_l17: l17 {
+					regulator-min-microvolt = <2000000>;
+					regulator-max-microvolt = <2000000>;
+					bias-pull-down;
+				};
+
+				pm8921_l18: l18 {
+					regulator-min-microvolt = <1300000>;
+					regulator-max-microvolt = <1800000>;
+					bias-pull-down;
+				};
+
+				pm8921_l21: l21 {
+					regulator-min-microvolt = <1050000>;
+					regulator-max-microvolt = <1050000>;
+					bias-pull-down;
+				};
+
+				pm8921_l22: l22 {
+					regulator-min-microvolt = <2600000>;
+					regulator-max-microvolt = <2600000>;
+					bias-pull-down;
+				};
+
+				pm8921_l23: l23 {
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					bias-pull-down;
+				};
+
+				pm8921_l24: l24 {
+					regulator-min-microvolt = <750000>;
+					regulator-max-microvolt = <1150000>;
+					bias-pull-down;
+				};
+
+				pm8921_l25: l25 {
+					regulator-always-on;
+					regulator-min-microvolt = <1250000>;
+					regulator-max-microvolt = <1250000>;
+					bias-pull-down;
+				};
+
+				pm8921_l27: l27 {
+					regulator-min-microvolt = <1100000>;
+					regulator-max-microvolt = <1100000>;
+				};
+
+				pm8921_l28: l28 {
+					regulator-min-microvolt = <1050000>;
+					regulator-max-microvolt = <1050000>;
+					bias-pull-down;
+				};
+
+				pm8921_l29: l29 {
+					regulator-min-microvolt = <2000000>;
+					regulator-max-microvolt = <2000000>;
+					bias-pull-down;
+				};
+
+				/* Low Voltage Switch */
+				pm8921_lvs1: lvs1 {
+					bias-pull-down;
+				};
+
+				pm8921_lvs2: lvs2 {
+					bias-pull-down;
+				};
+
+				pm8921_lvs3: lvs3 {
+					bias-pull-down;
+				};
+
+				pm8921_lvs4: lvs4 {
+					bias-pull-down;
+				};
+
+				pm8921_lvs5: lvs5 {
+					bias-pull-down;
+				};
+
+				pm8921_lvs6: lvs6 {
+					bias-pull-down;
+				};
+
+				pm8921_lvs7: lvs7 {
+					bias-pull-down;
+				};
+
+				pm8921_ncp: ncp {
+					regulator-min-microvolt = <2000000>;
+					regulator-max-microvolt = <2000000>;
+					qcom,switch-mode-frequency = <1600000>;
+				};
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
