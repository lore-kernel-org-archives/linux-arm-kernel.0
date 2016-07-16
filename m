From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Fri, 15 Jul 2016 17:42:16 -0700
Subject: [PATCH 6/6] arm64: dts: qcom: msm8916: Add Hexagon remoteproc node
In-Reply-To: <1468629736-7644-1-git-send-email-bjorn.andersson@linaro.org>
References: <1468629736-7644-1-git-send-email-bjorn.andersson@linaro.org>
Message-ID: <1468629736-7644-6-git-send-email-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the remoteproc node that allows us to control the life cycle
of the Hexagon core found in the msm8916 SoC.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 43 ++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 85ec5c932975..504e524b910e 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -77,7 +77,7 @@
 			no-map;
 		};
 
-		mpss at 86800000 {
+		mpss_mem: mpss at 86800000 {
 			reg = <0x0 0x86800000 0x0 0x2b00000>;
 			no-map;
 		};
@@ -620,6 +620,47 @@
 			clocks = <&gcc GCC_PRNG_AHB_CLK>;
 			clock-names = "core";
 		};
+
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
+			mba {
+				memory-region = <&mba_mem>;
+			};
+
+			mpss {
+				memory-region = <&mpss_mem>;
+			};
+		};
+
 	};
 
 	smd {
-- 
2.5.0
