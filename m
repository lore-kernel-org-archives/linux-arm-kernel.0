From: ivan.ivanov@linaro.org (Ivan T. Ivanov)
Date: Mon, 20 Apr 2015 10:45:35 +0300
Subject: [PATCH v2 1/7] ARM: dts: qcom: Add PM8841 functions device nodes
In-Reply-To: <1429515941-15334-1-git-send-email-ivan.ivanov@linaro.org>
References: <1429515941-15334-1-git-send-email-ivan.ivanov@linaro.org>
Message-ID: <1429515941-15334-2-git-send-email-ivan.ivanov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add configuration nodes for multi purpose pins and
thermal sensor devices. Thermal sensor will report
PMIC die temperature.

Signed-off-by: Ivan T. Ivanov <ivan.ivanov@linaro.org>
---
 arch/arm/boot/dts/qcom-pm8841.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-pm8841.dtsi b/arch/arm/boot/dts/qcom-pm8841.dtsi
index 73813cc..8f1a0b1 100644
--- a/arch/arm/boot/dts/qcom-pm8841.dtsi
+++ b/arch/arm/boot/dts/qcom-pm8841.dtsi
@@ -1,3 +1,4 @@
+#include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>

 &spmi_bus {
@@ -7,6 +8,23 @@
 		reg = <0x4 SPMI_USID>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+
+		pm8841_mpps: mpps at a000 {
+			compatible = "qcom,pm8841-mpp";
+			reg = <0xa000 0x400>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupts = <4 0xa0 0 IRQ_TYPE_NONE>,
+				     <4 0xa1 0 IRQ_TYPE_NONE>,
+				     <4 0xa2 0 IRQ_TYPE_NONE>,
+				     <4 0xa3 0 IRQ_TYPE_NONE>;
+		};
+
+		temp-alarm at 2400 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0x2400 0x100>;
+			interrupts = <4 0x24 0 IRQ_TYPE_EDGE_RISING>;
+		};
 	};

 	usid5: pm8841 at 5 {
--
1.9.1
