From: agross@codeaurora.org (Andy Gross)
Date: Thu, 27 Aug 2015 15:39:14 -0500
Subject: [PATCH v2] arm64: dts: qcom: Add 8x16 Serial UART1 node
Message-ID: <1440707954-18490-1-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the nodes required to support the UART1 node on the
MSM8916 and also fixes the sleep pins function for UART2.

Signed-off-by: Andy Gross <agross@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi  |    1 +
 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi |   26 +++++++++++++++++++++++++-
 arch/arm64/boot/dts/qcom/msm8916.dtsi      |    9 +++++++++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
index 66804ff..3fc3be4 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
@@ -19,6 +19,7 @@
 / {
 	aliases {
 		serial0 = &blsp1_uart2;
+		serial1 = &blsp1_uart1;
 	};
 
 	chosen {
diff --git a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
index 5689568..42941b9 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
@@ -13,6 +13,30 @@
 
 &msmgpio {
 
+	blsp1_uart1_default: blsp1_uart1_default {
+		pinmux {
+			function = "blsp_uart1";
+			pins = "gpio0", "gpio1";
+		};
+		pinconf {
+			pins = "gpio0", "gpio1";
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
+
+	blsp1_uart1_sleep: blsp1_uart1_sleep {
+		pinmux {
+			function = "gpio";
+			pins = "gpio0", "gpio1";
+		};
+		pinconf {
+			pins = "gpio0", "gpio1";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+	};
+
 	blsp1_uart2_default: blsp1_uart2_default {
 		pinmux {
 			function = "blsp_uart2";
@@ -27,7 +51,7 @@
 
 	blsp1_uart2_sleep: blsp1_uart2_sleep {
 		pinmux {
-			function = "blsp_uart2";
+			function = "gpio";
 			pins = "gpio4", "gpio5";
 		};
 		pinconf {
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 5911de0..9a49dff 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -102,6 +102,15 @@
 			reg = <0x1800000 0x80000>;
 		};
 
+		blsp1_uart1: serial at 78af000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0x78af000 0x200>;
+			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_UART1_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			status = "disabled";
+		};
+
 		blsp1_uart2: serial at 78b0000 {
 			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
 			reg = <0x78b0000 0x200>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
