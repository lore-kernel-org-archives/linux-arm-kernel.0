From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 30 Jan 2017 08:44:59 -0800
Subject: [PATCH] arm64: dts: qcom: msm8916: Update hexagon node
Message-ID: <20170130164459.4051-1-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's necessary to reference the xo clock and cx supply, so specify these
in the node. Also move the Hexagon smd-edge into the hexagon node, to
enable SSR.

As cxo is not yet available we reference the fixed version of cxo for
now, which will work until proper power management is implemented.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 68a8e67cba29..35684cc1f308 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -833,8 +833,9 @@
 
 			clocks = <&gcc GCC_MSS_CFG_AHB_CLK>,
 				 <&gcc GCC_MSS_Q6_BIMC_AXI_CLK>,
-				 <&gcc GCC_BOOT_ROM_AHB_CLK>;
-			clock-names = "iface", "bus", "mem";
+				 <&gcc GCC_BOOT_ROM_AHB_CLK>,
+				 <&xo_board>;
+			clock-names = "iface", "bus", "mem", "xo";
 
 			qcom,smem-states = <&hexagon_smp2p_out 0>;
 			qcom,smem-state-names = "stop";
@@ -842,6 +843,7 @@
 			resets = <&scm 0>;
 			reset-names = "mss_restart";
 
+			cx-supply = <&pm8916_s1>;
 			mx-supply = <&pm8916_l3>;
 			pll-supply = <&pm8916_l7>;
 
@@ -856,6 +858,16 @@
 			mpss {
 				memory-region = <&mpss_mem>;
 			};
+
+			smd-edge {
+				interrupts = <0 25 IRQ_TYPE_EDGE_RISING>;
+
+				qcom,smd-edge = <0>;
+				qcom,ipc = <&apcs 8 12>;
+				qcom,remote-pid = <1>;
+
+				label = "hexagon";
+			};
 		};
 
 		pronto: wcnss at a21b000 {
@@ -1214,14 +1226,6 @@
 				};
 			};
 		};
-
-		hexagon {
-			interrupts = <0 25 IRQ_TYPE_EDGE_RISING>;
-
-			qcom,smd-edge = <0>;
-			qcom,ipc = <&apcs 8 12>;
-			qcom,remote-pid = <1>;
-		};
 	};
 
 	hexagon-smp2p {
-- 
2.11.0
