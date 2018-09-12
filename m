From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Wed, 12 Sep 2018 14:53:48 +0100
Subject: [PATCH v2 07/11] arm: dts: imx7: Update coresight binding for
 hardware ports
In-Reply-To: <20180912135352.19722-1-suzuki.poulose@arm.com>
References: <20180912135352.19722-1-suzuki.poulose@arm.com>
Message-ID: <20180912135352.19722-8-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch to the updated coresight bindings.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm/boot/dts/imx7d.dtsi | 14 +++---
 arch/arm/boot/dts/imx7s.dtsi | 82 ++++++++++++++++--------------------
 2 files changed, 46 insertions(+), 50 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index 7cbc2ffa4b3a..a96d031ad46c 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -63,9 +63,11 @@
 			clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
 			clock-names = "apb_pclk";
 
-			port {
-				etm1_out_port: endpoint {
-					remote-endpoint = <&ca_funnel_in_port1>;
+			out-ports {
+				port {
+					etm1_out_port: endpoint {
+						remote-endpoint = <&ca_funnel_in_port1>;
+					};
 				};
 			};
 		};
@@ -148,11 +150,13 @@
 	};
 };
 
-&ca_funnel_ports {
+&ca_funnel_in_ports {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
 	port at 1 {
 		reg = <1>;
 		ca_funnel_in_port1: endpoint {
-			slave-mode;
 			remote-endpoint = <&etm1_out_port>;
 		};
 	};
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index a052198f6e96..b65cfc6a8841 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -106,7 +106,7 @@
 		 */
 		compatible = "arm,coresight-replicator";
 
-		ports {
+		out-ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
 				/* replicator output ports */
@@ -123,12 +123,11 @@
 					remote-endpoint = <&etr_in_port>;
 				};
 			};
+		};
 
-			/* replicator input port */
-			port at 2 {
-				reg = <0>;
+		in-ports {
+			port {
 				replicator_in_port0: endpoint {
-					slave-mode;
 					remote-endpoint = <&etf_out_port>;
 				};
 			};
@@ -168,28 +167,23 @@
 			clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
 			clock-names = "apb_pclk";
 
-			ca_funnel_ports: ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				/* funnel input ports */
-				port at 0 {
-					reg = <0>;
+			ca_funnel_in_ports: in-ports {
+				port {
 					ca_funnel_in_port0: endpoint {
-						slave-mode;
 						remote-endpoint = <&etm0_out_port>;
 					};
 				};
 
-				/* funnel output port */
-				port at 2 {
-					reg = <0>;
+				/* the other input ports are not connect to anything */
+			};
+
+			out-ports {
+				port {
 					ca_funnel_out_port0: endpoint {
 						remote-endpoint = <&hugo_funnel_in_port0>;
 					};
 				};
 
-				/* the other input ports are not connect to anything */
 			};
 		};
 
@@ -200,9 +194,11 @@
 			clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
 			clock-names = "apb_pclk";
 
-			port {
-				etm0_out_port: endpoint {
-					remote-endpoint = <&ca_funnel_in_port0>;
+			out-ports {
+				port {
+					etm0_out_port: endpoint {
+						remote-endpoint = <&ca_funnel_in_port0>;
+					};
 				};
 			};
 		};
@@ -213,15 +209,13 @@
 			clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
 			clock-names = "apb_pclk";
 
-			ports {
+			in-ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
-				/* funnel input ports */
 				port at 0 {
 					reg = <0>;
 					hugo_funnel_in_port0: endpoint {
-						slave-mode;
 						remote-endpoint = <&ca_funnel_out_port0>;
 					};
 				};
@@ -229,18 +223,18 @@
 				port at 1 {
 					reg = <1>;
 					hugo_funnel_in_port1: endpoint {
-						slave-mode; /* M4 input */
+						/* M4 input */
 					};
 				};
+				/* the other input ports are not connect to anything */
+			};
 
-				port at 2 {
-					reg = <0>;
+			out-ports {
+				port {
 					hugo_funnel_out_port0: endpoint {
 						remote-endpoint = <&etf_in_port>;
 					};
 				};
-
-				/* the other input ports are not connect to anything */
 			};
 		};
 
@@ -250,20 +244,16 @@
 			clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
 			clock-names = "apb_pclk";
 
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				port at 0 {
-					reg = <0>;
+			in-ports {
+				port {
 					etf_in_port: endpoint {
-						slave-mode;
 						remote-endpoint = <&hugo_funnel_out_port0>;
 					};
 				};
+			};
 
-				port at 1 {
-					reg = <0>;
+			out-ports {
+				port {
 					etf_out_port: endpoint {
 						remote-endpoint = <&replicator_in_port0>;
 					};
@@ -277,10 +267,11 @@
 			clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
 			clock-names = "apb_pclk";
 
-			port {
-				etr_in_port: endpoint {
-					slave-mode;
-					remote-endpoint = <&replicator_out_port1>;
+			in-ports {
+				port {
+					etr_in_port: endpoint {
+						remote-endpoint = <&replicator_out_port1>;
+					};
 				};
 			};
 		};
@@ -291,10 +282,11 @@
 			clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
 			clock-names = "apb_pclk";
 
-			port {
-				tpiu_in_port: endpoint {
-					slave-mode;
-					remote-endpoint = <&replicator_out_port0>;
+			in-ports {
+				port {
+					tpiu_in_port: endpoint {
+						remote-endpoint = <&replicator_out_port0>;
+					};
 				};
 			};
 		};
-- 
2.19.0
