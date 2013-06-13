From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 12 Jun 2013 18:49:07 -0700
Subject: [RFC/PATCH 11/13] ARM: dts: msm: Add MSM8960 GCC DT nodes
In-Reply-To: <1371088149-22562-1-git-send-email-sboyd@codeaurora.org>
References: <1371088149-22562-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1371088149-22562-12-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the necessary DT data to probe the global clock controller
on MSM8960 devices.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/boot/dts/msm8960-cdp.dts | 72 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm/boot/dts/msm8960-cdp.dts b/arch/arm/boot/dts/msm8960-cdp.dts
index fd2f3ec..01d03f1 100644
--- a/arch/arm/boot/dts/msm8960-cdp.dts
+++ b/arch/arm/boot/dts/msm8960-cdp.dts
@@ -42,6 +42,78 @@
 		cpu-offset = <0x80000>;
 	};
 
+	clock-controller at 900000 {
+		compatible = "qcom,gcc-8960", "qcom,gcc";
+		reg = <0x900000 0x4000>;
+
+		clocks {
+			cxo: cxo {
+				#clock-cells = <0>;
+				compatible = "fixed-clock";
+				clock-frequency = <19200000>;
+			};
+
+			pxo: pxo {
+				#clock-cells = <0>;
+				compatible = "fixed-clock";
+				clock-frequency = <27000000>;
+			};
+
+			pll8: pll8 {
+				#clock-cells = <0>;
+				compatible = "qcom,pll";
+				clocks = <&pxo>;
+			};
+
+			vpll8: vpll8 {
+				#clock-cells = <0>;
+				compatible = "qcom,pll-vote";
+				clocks = <&pll8>;
+			};
+
+			gsbi5_uart_rcg: gsbi5_uart_rcg {
+				#clock-cells = <0>;
+				compatible = "qcom,p2-mn16-clock";
+				clocks = <&pxo>, <&vpll8>;
+			};
+
+			gsbi5_uart_clk: gsbi5_uart_cxc {
+				#clock-cells = <0>;
+				compatible = "qcom,cxc-clock";
+				clocks = <&gsbi5_uart_rcg>;
+			};
+
+			gsbi6_uart_rcg: gsbi6_uart_rcg {
+				#clock-cells = <0>;
+				compatible = "qcom,p2-mn16-clock";
+				clocks = <&pxo>, <&vpll8>;
+			};
+
+			gsbi6_uart_clk: gsbi6_uart_cxc {
+				#clock-cells = <0>;
+				compatible = "qcom,cxc-clock";
+				clocks = <&gsbi6_uart_rcg>;
+			};
+
+			gsbi5_uart_ahb: gsbi5_uart_ahb {
+				#clock-cells = <0>;
+				compatible = "qcom,cxc-hg-clock";
+			};
+
+			gsbi5_qup_rcg: gsbi5_qup_rcg {
+				#clock-cells = <0>;
+				compatible = "qcom,p2-mn8-clock";
+				clocks = <&pxo>, <&vpll8>;
+			};
+
+			gsbi5_qup_clk: gsbi5_qup_cxc {
+				#clock-cells = <0>;
+				compatible = "qcom,cxc-clock";
+				clocks = <&gsbi5_qup_rcg>;
+			};
+		};
+	};
+
 	kpss at 2088000 {
 		compatible = "qcom,kpss";
 		reg = <0x02088000 0x1000
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
