From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Wed, 12 Sep 2018 14:53:50 +0100
Subject: [PATCH v2 09/11] arm: dts: qcom: Update coresight bindings for
 hardware ports
In-Reply-To: <20180912135352.19722-1-suzuki.poulose@arm.com>
References: <20180912135352.19722-1-suzuki.poulose@arm.com>
Message-ID: <20180912135352.19722-10-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch to the new hardware port bindings for coresight

Cc: Andy Gross <andy.gross@linaro.org>
Cc: David Brown <david.brown@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi |  71 ++++++++++---------
 arch/arm/boot/dts/qcom-msm8974.dtsi | 104 +++++++++++++++-------------
 2 files changed, 96 insertions(+), 79 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 4a99c9255104..48c3cf427610 100644
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
 
@@ -1656,10 +1658,11 @@
 						remote-endpoint = <&tpiu_in>;
 					};
 				};
-				port at 2 {
-					reg = <0>;
+			};
+
+			in-ports {
+				port {
 					replicator_in: endpoint {
-						slave-mode;
 						remote-endpoint = <&funnel_out>;
 					};
 				};
@@ -1673,7 +1676,7 @@
 			clocks = <&rpmcc RPM_QDSS_CLK>;
 			clock-names = "apb_pclk";
 
-			ports {
+			in-ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -1687,33 +1690,31 @@
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
-					reg = <0>;
+			};
+
+			out-ports {
+				port {
 					funnel_out: endpoint {
 						remote-endpoint = <&replicator_in>;
 					};
@@ -1730,9 +1731,11 @@
 
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
@@ -1746,9 +1749,11 @@
 
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
@@ -1762,9 +1767,11 @@
 
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
@@ -1778,9 +1785,11 @@
 
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
index d9019a49b292..3a4fb513a088 100644
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
 
@@ -816,10 +818,11 @@
 						remote-endpoint = <&tpiu_in>;
 					};
 				};
-				port at 2 {
-					reg = <0>;
+			};
+
+			in-ports {
+				port {
 					replicator_in: endpoint {
-						slave-mode;
 						remote-endpoint = <&etf_out>;
 					};
 				};
@@ -833,20 +836,17 @@
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
 
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				port at 0 {
-					reg = <0>;
+			out-ports {
+				port {
 					etf_out: endpoint {
 						remote-endpoint = <&replicator_in>;
 					};
 				};
-				port at 1 {
-					reg = <0>;
+			};
+
+			in-ports {
+				port {
 					etf_in: endpoint {
-						slave-mode;
 						remote-endpoint = <&merger_out>;
 					};
 				};
@@ -860,7 +860,7 @@
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
 
-			ports {
+			in-ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -873,12 +873,13 @@
 				port at 1 {
 					reg = <1>;
 					merger_in1: endpoint {
-						slave-mode;
 						remote-endpoint = <&funnel1_out>;
 					};
 				};
-				port at 8 {
-					reg = <0>;
+			};
+
+			out-ports {
+				port {
 					merger_out: endpoint {
 						remote-endpoint = <&etf_in>;
 					};
@@ -893,7 +894,7 @@
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
 
-			ports {
+			in-ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -910,12 +911,13 @@
 				port at 5 {
 					reg = <5>;
 					funnel1_in5: endpoint {
-						slave-mode;
 						remote-endpoint = <&kpss_out>;
 					};
 				};
-				port at 8 {
-					reg = <0>;
+			};
+
+			out-ports {
+				port {
 					funnel1_out: endpoint {
 						remote-endpoint = <&merger_in1>;
 					};
@@ -930,40 +932,38 @@
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
-					reg = <0>;
+			};
+
+			out-ports {
+				port {
 					kpss_out: endpoint {
 						remote-endpoint = <&funnel1_in5>;
 					};
@@ -980,9 +980,11 @@
 
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
@@ -996,9 +998,11 @@
 
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
@@ -1012,9 +1016,11 @@
 
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
@@ -1028,9 +1034,11 @@
 
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
2.19.0
