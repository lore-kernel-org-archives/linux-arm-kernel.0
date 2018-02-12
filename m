From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Mon, 12 Feb 2018 11:58:32 +0530
Subject: [PATCH v3 3/3] arm64: dts: sdm845: Add serial console support
In-Reply-To: <20180212062832.2791-1-rnayak@codeaurora.org>
References: <20180212062832.2791-1-rnayak@codeaurora.org>
Message-ID: <20180212062832.2791-4-rnayak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the qup uart node and geni se instance needed to
support the serial console on the MTP.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 34 ++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi    | 39 +++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index 617c7bb25fb1..9eab2b815e0d 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -10,4 +10,38 @@
 / {
 	model = "Qualcomm Technologies, Inc. SDM845 MTP";
 	compatible = "qcom,sdm845-mtp";
+
+	aliases {
+		serial0 = &qup_uart2;
+	};
+
+	chosen {
+		stdout-path = "serial0";
+	};
+};
+
+&soc {
+	geni-se at ac0000 {
+		serial at a84000 {
+			status = "okay";
+		};
+	};
+
+	pinctrl at 3400000 {
+		qup-uart2-default {
+			pinconf {
+				pins = "gpio4", "gpio5";
+				drive-strength = <2>;
+				bias-disable;
+			};
+		};
+
+		qup-uart2-sleep {
+			pinconf {
+				pins = "gpio4", "gpio5";
+				drive-strength = <2>;
+				bias-disable;
+			};
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 55a7e0b454e1..8cf8df25b06d 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/qcom,gcc-sdm845.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -193,6 +194,20 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+
+			qup_uart2_default: qup-uart2-default {
+				pinmux {
+					function = "qup9";
+					pins = "gpio4", "gpio5";
+				};
+			};
+
+			qup_uart2_sleep: qup-uart2-sleep {
+				pinmux {
+					function = "gpio";
+					pins = "gpio4", "gpio5";
+				};
+			};
 		};
 
 		timer at 17c90000 {
@@ -271,5 +286,29 @@
 			#interrupt-cells = <4>;
 			cell-index = <0>;
 		};
+
+		qup_1: geni-se at ac0000 {
+			compatible = "qcom,geni-se-qup";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			reg = <0xac0000 0x6000>;
+			clocks = <&gcc GCC_QUPV3_WRAP_1_M_AHB_CLK>,
+				 <&gcc GCC_QUPV3_WRAP_1_S_AHB_CLK>;
+			clock-names = "m-ahb", "s-ahb";
+
+			qup_uart2: serial at a84000 {
+				compatible = "qcom,geni-debug-uart";
+				reg = <0xa84000 0x4000>;
+				reg-names = "se-phys";
+				clock-names = "se-clk";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
+				pinctrl-names = "default", "sleep";
+				pinctrl-0 = <&qup_uart2_default>;
+				pinctrl-1 = <&qup_uart2_sleep>;
+				interrupts = <GIC_SPI 354 IRQ_TYPE_NONE>;
+				status = "disabled";
+			};
+		};
 	};
 };
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
