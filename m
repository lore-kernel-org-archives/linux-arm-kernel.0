From: svarbanov@mm-sol.com (Stanimir Varbanov)
Date: Thu, 24 Jul 2014 15:45:20 +0300
Subject: [PATCH v3 3/4] ARM: dts: qcom: add pm8941 and pm8841 PMICs device
 nodes
In-Reply-To: <1406205921-7452-1-git-send-email-svarbanov@mm-sol.com>
References: <1406205921-7452-1-git-send-email-svarbanov@mm-sol.com>
Message-ID: <1406205921-7452-4-git-send-email-svarbanov@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pm8941 and pm8841 spmi devicetree nodes are childrens of
spmi pmic arbiter. The msm8974 SoC uses two PMIC chips
pm8941 and pm8841. Every PMIC chip has two spmi bus slave id's.

Signed-off-by: Stanimir Varbanov <svarbanov@mm-sol.com>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi |   37 +++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 69dca2a..5e08d43 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -3,6 +3,7 @@
 #include "skeleton.dtsi"
 
 #include <dt-bindings/clock/qcom,gcc-msm8974.h>
+#include <dt-bindings/spmi/spmi.h>
 
 / {
 	model = "Qualcomm MSM8974";
@@ -236,5 +237,41 @@
 			#interrupt-cells = <2>;
 			interrupts = <0 208 0>;
 		};
+
+		spmi at fc4cf000 {
+			compatible = "qcom,spmi-pmic-arb";
+			reg-names = "core", "intr", "cnfg";
+			reg = <0xfc4cf000 0x1000>,
+			      <0xfc4cb000 0x1000>,
+			      <0xfc4ca000 0x1000>;
+			interrupt-names = "periph_irq";
+			interrupts = <0 190 0>;
+			qcom,ee = <0>;
+			qcom,channel = <0>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+			interrupt-controller;
+			#interrupt-cells = <4>;
+
+			pm8941 at 0 {
+				compatible = "qcom,pm8941";
+				reg = <0x0 SPMI_USID>;
+			};
+
+			pm8941 at 1 {
+				compatible = "qcom,pm8941";
+				reg = <0x1 SPMI_USID>;
+			};
+
+			pm8841 at 4 {
+				compatible = "qcom,pm8841";
+				reg = <0x4 SPMI_USID>;
+			};
+
+			pm8841 at 5 {
+				compatible = "qcom,pm8841";
+				reg = <0x5 SPMI_USID>;
+			};
+		};
 	};
 };
-- 
1.7.0.4
