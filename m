From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 28 Mar 2016 20:37:01 -0700
Subject: [PATCH v2 5/9] ARM: dts: qcom: msm8974: Introduce the wcnss
 remoteproc node
In-Reply-To: <1459222625-11440-1-git-send-email-bjorn.andersson@linaro.org>
References: <1459222625-11440-1-git-send-email-bjorn.andersson@linaro.org>
Message-ID: <1459222625-11440-6-git-send-email-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bjorn Andersson <bjorn.andersson@sonymobile.com>

Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Added dts patches

 .../boot/dts/qcom-msm8974-sony-xperia-honami.dts   | 32 +++++++++++++++++++
 arch/arm/boot/dts/qcom-msm8974.dtsi                | 36 +++++++++++++++++++++-
 2 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
index a0398b69f4f2..74faa291d213 100644
--- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
@@ -311,6 +311,13 @@
 		pinctrl-0 = <&blsp1_uart2_pin_a>;
 	};
 
+	wcnss-rproc at fb21b000 {
+		status = "ok";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&wcnss_pin_a>;
+	};
+
 	pinctrl at fd510000 {
 		blsp1_uart2_pin_a: blsp1-uart2-pin-active {
 			rx {
@@ -366,6 +373,31 @@
 			};
 		};
 
+		wcnss_pin_a: wcnss-pin-active {
+			wlan {
+				pins =  "gpio36", "gpio37", "gpio38", "gpio39", "gpio40";
+				function = "wlan";
+
+				drive-strength = <6>;
+				bias-pull-down;
+			};
+
+			bt {
+				pins = "gpio35", "gpio43", "gpio44";
+				function = "bt";
+
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
+			fm {
+				pins = "gpio41", "gpio42";
+				function = "fm";
+
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index ef5330578431..5c0d1a46baeb 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -2,6 +2,7 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-msm8974.h>
+#include <dt-bindings/clock/qcom,rpmcc.h>
 #include "skeleton.dtsi"
 
 / {
@@ -24,7 +25,7 @@
 			no-map;
 		};
 
-		reserved at 0d200000 {
+		wcnss_region: wcnss at 0d200000 {
 			reg = <0x0d200000 0xa00000>;
 			no-map;
 		};
@@ -430,6 +431,39 @@
 			clock-names = "core";
 		};
 
+		wcnss-rproc at fb21b000 {
+			compatible = "qcom,pronto-v2-pil";
+			reg = <0xfb21b000 0x3000>;
+
+			memory-region = <&wcnss_region>;
+
+			interrupts-extended = <&intc 0 149 IRQ_TYPE_EDGE_RISING>,
+					      <&wcnss_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&wcnss_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&wcnss_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&wcnss_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready", "handover", "stop-ack";
+
+			vddpx-supply = <&pm8941_s3>;
+
+			qcom,state = <&wcnss_smp2p_out 0>;
+			qcom,state-names = "stop";
+
+			status = "disabled";
+
+			iris {
+				compatible = "qcom,wcn3680";
+
+				clocks = <&rpmcc RPM_CXO_A2>;
+				clock-names = "xo";
+
+				vddxo-supply = <&pm8941_l6>;
+				vddrfa-supply = <&pm8941_l11>;
+				vddpa-supply = <&pm8941_l19>;
+				vdddig-supply = <&pm8941_s3>;
+			};
+		};
+
 		msmgpio: pinctrl at fd510000 {
 			compatible = "qcom,msm8974-pinctrl";
 			reg = <0xfd510000 0x4000>;
-- 
2.5.0
