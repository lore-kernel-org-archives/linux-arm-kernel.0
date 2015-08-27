From: agross@codeaurora.org (Andy Gross)
Date: Wed, 26 Aug 2015 22:36:20 -0500
Subject: [PATCH] arm64: dts: qcom: Add 8x16 Serial UART1 node
Message-ID: <1440646580-28241-1-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the nodes required to support the UART1 node on the
MSM8916.

Signed-off-by: Andy Gross <agross@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi |    8 +++++++
 arch/arm64/boot/dts/qcom/msm8916.dtsi     |   35 ++++++++++++++++++++++++++++-
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
index 98abece..3cc53a7 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
@@ -19,6 +19,7 @@
 / {
 	aliases {
 		serial0 = &blsp1_uart2;
+		serial1 = &blsp1_uart1;
 	};
 
 	chosen {
@@ -26,6 +27,13 @@
 	};
 
 	soc {
+		serial at 78af000 {
+			status = "okay";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&blsp1_uart1_default>;
+			pinctrl-1 = <&blsp1_uart1_sleep>;
+		};
+
 		serial at 78b0000 {
 			status = "okay";
 			pinctrl-names = "default", "sleep";
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 0f49ebd..ba64447 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -91,6 +91,30 @@
 			interrupt-controller;
 			#interrupt-cells = <2>;
 
+			blsp1_uart1_default: blsp1_uart1_default {
+				pinmux {
+					function = "blsp_uart1";
+					pins = "gpio0", "gpio1";
+				};
+				pinconf {
+					pins = "gpio0", "gpio1";
+					drive-strength = <16>;
+					bias-disable;
+				};
+			};
+
+			blsp1_uart1_sleep: blsp1_uart1_sleep {
+				pinmux {
+					function = "gpio";
+					pins = "gpio0", "gpio1";
+				};
+				pinconf {
+					pins = "gpio0", "gpio1";
+					drive-strength = <2>;
+					bias-pull-down;
+				};
+			};
+
 			blsp1_uart2_default: blsp1_uart2_default {
 				pinmux {
 					function = "blsp_uart2";
@@ -105,7 +129,7 @@
 
 			blsp1_uart2_sleep: blsp1_uart2_sleep {
 				pinmux {
-					function = "blsp_uart2";
+					function = "gpio";
 					pins = "gpio4", "gpio5";
 				};
 				pinconf {
@@ -123,6 +147,15 @@
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
