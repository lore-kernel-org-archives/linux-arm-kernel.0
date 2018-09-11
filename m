From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 11 Sep 2018 11:17:09 +0100
Subject: [PATCH 08/11] dts: arm: qcom: Update coresight bindings for hardware
 ports
In-Reply-To: <1536661032-30481-1-git-send-email-suzuki.poulose@arm.com>
References: <1536661032-30481-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1536661032-30481-9-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch to the new hardware port bindings for coresight

Cc: Andy Gross <andy.gross@linaro.org>
Cc: David Brown <david.brown@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi |  75 +++++++++++++++----------
 arch/arm/boot/dts/qcom-msm8974.dtsi | 108 +++++++++++++++++++++++-------------
 2 files changed, 116 insertions(+), 67 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 4a99c92..0a1c598 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -1611,10 +1611,11 @@
 			clocks = <&rpmcc RPM_QDSS_CLK>;
 			clock-names = "apb_pclk";
 
-			port {
-				etb_in: endpoint {
-					slave-mode;
-					remote-endpoint = <&replicator_out0>;
+			in-ports {
+				port {
+					etb_in: endpoint {
+						remote-endpoint = <&replicator_out0>;
+					};
 				};
 			};
 		};
@@ -1626,10 +1627,11 @@
 			clocks = <&rpmcc RPM_QDSS_CLK>;
 			clock-names = "apb_pclk";
 
-			port {
-				tpiu_in: endpoint {
-					slave-mode;
-					remote-endpoint = <&replicator_out1>;
+			in-ports {
+				port {
+					tpiu_in: endpoint {
+						remote-endpoint = <&replicator_out1>;
+					};
 				};
 			};
 		};
@@ -1640,7 +1642,7 @@
 			clocks = <&rpmcc RPM_QDSS_CLK>;
 			clock-names = "apb_pclk";
 
-			ports {
+			out-ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -1656,10 +1658,15 @@
 						remote-endpoint = <&tpiu_in>;
 					};
 				};
-				port at 2 {
+			};
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 0 {
 					reg = <0>;
 					replicator_in: endpoint {
-						slave-mode;
 						remote-endpoint = <&funnel_out>;
 					};
 				};
@@ -1673,7 +1680,7 @@
 			clocks = <&rpmcc RPM_QDSS_CLK>;
 			clock-names = "apb_pclk";
 
-			ports {
+			in-ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -1687,32 +1694,34 @@
 				port at 0 {
 					reg = <0>;
 					funnel_in0: endpoint {
-						slave-mode;
 						remote-endpoint = <&etm0_out>;
 					};
 				};
 				port at 1 {
 					reg = <1>;
 					funnel_in1: endpoint {
-						slave-mode;
 						remote-endpoint = <&etm1_out>;
 					};
 				};
 				port at 4 {
 					reg = <4>;
 					funnel_in4: endpoint {
-						slave-mode;
 						remote-endpoint = <&etm2_out>;
 					};
 				};
 				port at 5 {
 					reg = <5>;
 					funnel_in5: endpoint {
-						slave-mode;
 						remote-endpoint = <&etm3_out>;
 					};
 				};
-				port at 8 {
+			};
+
+			out-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 0 {
 					reg = <0>;
 					funnel_out: endpoint {
 						remote-endpoint = <&replicator_in>;
@@ -1730,9 +1739,11 @@
 
 			cpu = <&CPU0>;
 
-			port {
-				etm0_out: endpoint {
-					remote-endpoint = <&funnel_in0>;
+			out-ports {
+				port {
+					etm0_out: endpoint {
+						remote-endpoint = <&funnel_in0>;
+					};
 				};
 			};
 		};
@@ -1746,9 +1757,11 @@
 
 			cpu = <&CPU1>;
 
-			port {
-				etm1_out: endpoint {
-					remote-endpoint = <&funnel_in1>;
+			out-ports {
+				port {
+					etm1_out: endpoint {
+						remote-endpoint = <&funnel_in1>;
+					};
 				};
 			};
 		};
@@ -1762,9 +1775,11 @@
 
 			cpu = <&CPU2>;
 
-			port {
-				etm2_out: endpoint {
-					remote-endpoint = <&funnel_in4>;
+			out-ports {
+				port {
+					etm2_out: endpoint {
+						remote-endpoint = <&funnel_in4>;
+					};
 				};
 			};
 		};
@@ -1778,9 +1793,11 @@
 
 			cpu = <&CPU3>;
 
-			port {
-				etm3_out: endpoint {
-					remote-endpoint = <&funnel_in5>;
+			out-ports {
+				port {
+					etm3_out: endpoint {
+						remote-endpoint = <&funnel_in5>;
+					};
 				};
 			};
 		};
diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index d9019a4..37aac0b 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -770,10 +770,11 @@
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
 
-			port {
-				etr_in: endpoint {
-					slave-mode;
-					remote-endpoint = <&replicator_out0>;
+			in-ports {
+				port {
+					etr_in: endpoint {
+						remote-endpoint = <&replicator_out0>;
+					};
 				};
 			};
 		};
@@ -785,10 +786,11 @@
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
 
-			port {
-				tpiu_in: endpoint {
-					 slave-mode;
-					 remote-endpoint = <&replicator_out1>;
+			in-ports {
+				port {
+					tpiu_in: endpoint {
+						remote-endpoint = <&replicator_out1>;
+					};
 				 };
 			};
 		};
@@ -800,7 +802,7 @@
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
 
-			ports {
+			out-ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -816,10 +818,15 @@
 						remote-endpoint = <&tpiu_in>;
 					};
 				};
-				port at 2 {
+			};
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 0 {
 					reg = <0>;
 					replicator_in: endpoint {
-						slave-mode;
 						remote-endpoint = <&etf_out>;
 					};
 				};
@@ -833,7 +840,7 @@
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
 
-			ports {
+			out-ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -843,10 +850,15 @@
 						remote-endpoint = <&replicator_in>;
 					};
 				};
-				port at 1 {
+			};
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 0 {
 					reg = <0>;
 					etf_in: endpoint {
-						slave-mode;
 						remote-endpoint = <&merger_out>;
 					};
 				};
@@ -860,7 +872,7 @@
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
 
-			ports {
+			in-ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -873,11 +885,16 @@
 				port at 1 {
 					reg = <1>;
 					merger_in1: endpoint {
-						slave-mode;
 						remote-endpoint = <&funnel1_out>;
 					};
 				};
-				port at 8 {
+			};
+
+			out-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 0 {
 					reg = <0>;
 					merger_out: endpoint {
 						remote-endpoint = <&etf_in>;
@@ -893,7 +910,7 @@
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
 
-			ports {
+			in-ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -910,11 +927,16 @@
 				port at 5 {
 					reg = <5>;
 					funnel1_in5: endpoint {
-						slave-mode;
 						remote-endpoint = <&kpss_out>;
 					};
 				};
-				port at 8 {
+			};
+
+			out-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 0 {
 					reg = <0>;
 					funnel1_out: endpoint {
 						remote-endpoint = <&merger_in1>;
@@ -930,39 +952,41 @@
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
 
-			ports {
+			in-ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
 				port at 0 {
 					reg = <0>;
 					kpss_in0: endpoint {
-						slave-mode;
 						remote-endpoint = <&etm0_out>;
 					};
 				};
 				port at 1 {
 					reg = <1>;
 					kpss_in1: endpoint {
-						slave-mode;
 						remote-endpoint = <&etm1_out>;
 					};
 				};
 				port at 2 {
 					reg = <2>;
 					kpss_in2: endpoint {
-						slave-mode;
 						remote-endpoint = <&etm2_out>;
 					};
 				};
 				port at 3 {
 					reg = <3>;
 					kpss_in3: endpoint {
-						slave-mode;
 						remote-endpoint = <&etm3_out>;
 					};
 				};
-				port at 8 {
+			};
+
+			out-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 0 {
 					reg = <0>;
 					kpss_out: endpoint {
 						remote-endpoint = <&funnel1_in5>;
@@ -980,9 +1004,11 @@
 
 			cpu = <&CPU0>;
 
-			port {
-				etm0_out: endpoint {
-					remote-endpoint = <&kpss_in0>;
+			out-ports {
+				port {
+					etm0_out: endpoint {
+						remote-endpoint = <&kpss_in0>;
+					};
 				};
 			};
 		};
@@ -996,9 +1022,11 @@
 
 			cpu = <&CPU1>;
 
-			port {
-				etm1_out: endpoint {
-					remote-endpoint = <&kpss_in1>;
+			out-ports {
+				port {
+					etm1_out: endpoint {
+						remote-endpoint = <&kpss_in1>;
+					};
 				};
 			};
 		};
@@ -1012,9 +1040,11 @@
 
 			cpu = <&CPU2>;
 
-			port {
-				etm2_out: endpoint {
-					remote-endpoint = <&kpss_in2>;
+			out-ports {
+				port {
+					etm2_out: endpoint {
+						remote-endpoint = <&kpss_in2>;
+					};
 				};
 			};
 		};
@@ -1028,9 +1058,11 @@
 
 			cpu = <&CPU3>;
 
-			port {
-				etm3_out: endpoint {
-					remote-endpoint = <&kpss_in3>;
+			out-ports {
+				port {
+					etm3_out: endpoint {
+						remote-endpoint = <&kpss_in3>;
+					};
 				};
 			};
 		};
-- 
2.7.4
