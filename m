From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 23 Aug 2016 18:33:13 -0700
Subject: [PATCH 4/4] arm64: dts: qcom: msm8916: Add Hexagon PIL node
In-Reply-To: <1472002393-1875-1-git-send-email-bjorn.andersson@linaro.org>
References: <1472002393-1875-1-git-send-email-bjorn.andersson@linaro.org>
Message-ID: <1472002393-1875-4-git-send-email-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Hexagon core on the msm8916 provides services for audio control,
audio output, sensors and the Hexagon SDK. The Hexagon remoteproc node
allows us to boot this core.

Although its part of the core platform its left disabled as it will
crash without the rmtfs QMI service and we do not yet handle crashes
gracefully.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 49 ++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 6e599b75525a..bf0823e76f30 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -78,7 +78,7 @@
 			no-map;
 		};
 
-		mpss at 86800000 {
+		mpss_mem: mpss at 86800000 {
 			reg = <0x0 0x86800000 0x0 0x2b00000>;
 			no-map;
 		};
@@ -87,6 +87,11 @@
 			reg = <0x0 0x89300000 0x0 0x600000>;
 			no-map;
 		};
+
+		mba_mem: mba at 8ea00000 {
+			no-map;
+			reg = <0 0x8ea00000 0 0x100000>;
+		};
 	};
 
 	cpus {
@@ -616,6 +621,48 @@
 			reg = <0x1937000 0x30000>;
 		};
 
+		hexagon at 4080000 {
+			compatible = "qcom,q6v5-pil";
+			reg = <0x04080000 0x100>,
+			      <0x04020000 0x040>;
+
+			reg-names = "qdsp6", "rmb";
+
+			interrupts-extended = <&intc 0 24 1>,
+					      <&hexagon_smp2p_in 0 0>,
+					      <&hexagon_smp2p_in 1 0>,
+					      <&hexagon_smp2p_in 2 0>,
+					      <&hexagon_smp2p_in 3 0>;
+			interrupt-names = "wdog", "fatal", "ready",
+					  "handover", "stop-ack";
+
+			clocks = <&gcc GCC_MSS_CFG_AHB_CLK>,
+				 <&gcc GCC_MSS_Q6_BIMC_AXI_CLK>,
+				 <&gcc GCC_BOOT_ROM_AHB_CLK>;
+			clock-names = "iface", "bus", "mem";
+
+			qcom,smem-states = <&hexagon_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
+
+			resets = <&scm 0>;
+			reset-names = "mss_restart";
+
+			mx-supply = <&pm8916_l3>;
+			pll-supply = <&pm8916_l7>;
+
+			qcom,halt-regs = <&tcsr 0x18000 0x19000 0x1a000>;
+
+			status = "disabled";
+
+			mba {
+				memory-region = <&mba_mem>;
+			};
+
+			mpss {
+				memory-region = <&mpss_mem>;
+			};
+		};
+
 		wcnss at a21b000 {
 			compatible = "qcom,pronto-v2-pil";
 			reg = <0x0a21b000 0x3000>;
-- 
2.5.0
