From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Thu, 25 Jan 2018 22:02:16 +0530
Subject: [PATCH 2/2] arm64: dts: sdm845: Add serial console support
In-Reply-To: <20180125163216.29018-1-rnayak@codeaurora.org>
References: <20180125163216.29018-1-rnayak@codeaurora.org>
Message-ID: <20180125163216.29018-3-rnayak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the qup uart node and geni se instance needed to
support the serial console on the MTP.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
This patch is based on the current proposed DT bindings for
the geni based serial driver [1] and also depends on the GCC
driver [2] which adds dt-bindings/clock/qcom,gcc-sdm845.h header.
This can only be merged once the dependent patches do.
[1] https://patchwork.ozlabs.org/cover/860251/
[2] https://lkml.org/lkml/2018/1/22/78

 arch/arm64/boot/dts/qcom/sdm845-mtp.dtsi  |  3 +++
 arch/arm64/boot/dts/qcom/sdm845-pins.dtsi | 32 +++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi      | 22 +++++++++++++++++++++
 3 files changed, 57 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-pins.dtsi

diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dtsi b/arch/arm64/boot/dts/qcom/sdm845-mtp.dtsi
index 5b1022c20bad..640a48cd628b 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dtsi
@@ -7,5 +7,8 @@
 
 / {
 	soc {
+		serial at a84000 {
+			status = "okay";
+		};
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sdm845-pins.dtsi b/arch/arm64/boot/dts/qcom/sdm845-pins.dtsi
new file mode 100644
index 000000000000..b97f99e6f4b4
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sdm845-pins.dtsi
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ */
+
+&tlmm {
+	qup_uart2_default: qup_uart2_default {
+		pinmux {
+			function = "qup9";
+			pins = "gpio4", "gpio5";
+		};
+
+		pinconf {
+			pins = "gpio4", "gpio5";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+
+	qup_uart2_sleep: qup_uart2_sleep {
+		pinmux {
+			function = "gpio";
+			pins = "gpio4", "gpio5";
+		};
+
+		pinconf {
+			pins = "gpio4", "gpio5";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index a21f4912b3e2..529f4ba3a1db 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/qcom,gcc-sdm845.h>
 
 / {
 	model = "Qualcomm Technologies, Inc. SDM845";
@@ -304,5 +305,26 @@
 			cell-index = <0>;
 		};
 
+		qup_1: qcom,geni_se at ac0000 {
+			compatible = "qcom,geni-se-qup";
+			reg = <0xac0000 0x6000>;
+		};
+
+		qup_uart2: serial at a84000 {
+			compatible = "qcom,geni-console", "qcom,geni-uart";
+			reg = <0xa84000 0x4000>;
+			reg-names = "se_phys";
+			clock-names = "se-clk", "m-ahb", "s-ahb";
+			clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>,
+				 <&gcc GCC_QUPV3_WRAP_1_M_AHB_CLK>,
+				 <&gcc GCC_QUPV3_WRAP_1_S_AHB_CLK>;
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&qup_uart2_default>;
+			pinctrl-1 = <&qup_uart2_sleep>;
+			interrupts = <GIC_SPI 354 IRQ_TYPE_NONE>;
+			qcom,wrapper-core = <&qup_1>;
+			status = "disabled";
+		};
 	};
 };
+#include "sdm845-pins.dtsi"
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
