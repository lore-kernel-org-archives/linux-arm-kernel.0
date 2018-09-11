From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 11 Sep 2018 11:17:12 +0100
Subject: [PATCH 11/11] dts: tc2: Update coresight bindings for hardware ports
In-Reply-To: <1536661032-30481-1-git-send-email-suzuki.poulose@arm.com>
References: <1536661032-30481-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1536661032-30481-12-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch to the new coresight bindings

Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts | 90 +++++++++++++++++-------------
 1 file changed, 51 insertions(+), 39 deletions(-)

diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
index ac6b90e..3a50906 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
@@ -393,10 +393,11 @@
 
 		clocks = <&oscclk6a>;
 		clock-names = "apb_pclk";
-		port {
-			etb_in_port: endpoint {
-				slave-mode;
-				remote-endpoint = <&replicator_out_port0>;
+		in-ports {
+			port {
+				etb_in_port: endpoint {
+					remote-endpoint = <&replicator_out_port0>;
+				};
 			};
 		};
 	};
@@ -407,10 +408,11 @@
 
 		clocks = <&oscclk6a>;
 		clock-names = "apb_pclk";
-		port {
-			tpiu_in_port: endpoint {
-				slave-mode;
-				remote-endpoint = <&replicator_out_port1>;
+		in-ports {
+			port {
+				tpiu_in_port: endpoint {
+					remote-endpoint = <&replicator_out_port1>;
+				};
 			};
 		};
 	};
@@ -421,11 +423,10 @@
 		 */
 		compatible = "arm,coresight-replicator";
 
-		ports {
+		out-ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			/* replicator output ports */
 			port at 0 {
 				reg = <0>;
 				replicator_out_port0: endpoint {
@@ -439,12 +440,15 @@
 					remote-endpoint = <&tpiu_in_port>;
 				};
 			};
+		};
 
-			/* replicator input port */
-			port at 2 {
+		in-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
 				reg = <0>;
 				replicator_in_port0: endpoint {
-					slave-mode;
 					remote-endpoint = <&funnel_out_port0>;
 				};
 			};
@@ -457,11 +461,10 @@
 
 		clocks = <&oscclk6a>;
 		clock-names = "apb_pclk";
-		ports {
+		out-ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			/* funnel output port */
 			port at 0 {
 				reg = <0>;
 				funnel_out_port0: endpoint {
@@ -469,28 +472,29 @@
 						<&replicator_in_port0>;
 				};
 			};
+		};
 
-			/* funnel input ports */
-			port at 1 {
+		in-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
 				reg = <0>;
 				funnel_in_port0: endpoint {
-					slave-mode;
 					remote-endpoint = <&ptm0_out_port>;
 				};
 			};
 
-			port at 2 {
+			port at 1 {
 				reg = <1>;
 				funnel_in_port1: endpoint {
-					slave-mode;
 					remote-endpoint = <&ptm1_out_port>;
 				};
 			};
 
-			port at 3 {
+			port at 2 {
 				reg = <2>;
 				funnel_in_port2: endpoint {
-					slave-mode;
 					remote-endpoint = <&etm0_out_port>;
 				};
 			};
@@ -500,7 +504,6 @@
 			port at 4 {
 				reg = <4>;
 				funnel_in_port4: endpoint {
-					slave-mode;
 					remote-endpoint = <&etm1_out_port>;
 				};
 			};
@@ -508,7 +511,6 @@
 			port at 5 {
 				reg = <5>;
 				funnel_in_port5: endpoint {
-					slave-mode;
 					remote-endpoint = <&etm2_out_port>;
 				};
 			};
@@ -522,9 +524,11 @@
 		cpu = <&cpu0>;
 		clocks = <&oscclk6a>;
 		clock-names = "apb_pclk";
-		port {
-			ptm0_out_port: endpoint {
-				remote-endpoint = <&funnel_in_port0>;
+		out-ports {
+			port {
+				ptm0_out_port: endpoint {
+					remote-endpoint = <&funnel_in_port0>;
+				};
 			};
 		};
 	};
@@ -536,9 +540,11 @@
 		cpu = <&cpu1>;
 		clocks = <&oscclk6a>;
 		clock-names = "apb_pclk";
-		port {
-			ptm1_out_port: endpoint {
-				remote-endpoint = <&funnel_in_port1>;
+		out-ports {
+			port {
+				ptm1_out_port: endpoint {
+					remote-endpoint = <&funnel_in_port1>;
+				};
 			};
 		};
 	};
@@ -550,9 +556,11 @@
 		cpu = <&cpu2>;
 		clocks = <&oscclk6a>;
 		clock-names = "apb_pclk";
-		port {
-			etm0_out_port: endpoint {
-				remote-endpoint = <&funnel_in_port2>;
+		out-ports {
+			port {
+				etm0_out_port: endpoint {
+					remote-endpoint = <&funnel_in_port2>;
+				};
 			};
 		};
 	};
@@ -564,9 +572,11 @@
 		cpu = <&cpu3>;
 		clocks = <&oscclk6a>;
 		clock-names = "apb_pclk";
-		port {
-			etm1_out_port: endpoint {
-				remote-endpoint = <&funnel_in_port4>;
+		out-ports {
+			port {
+				etm1_out_port: endpoint {
+					remote-endpoint = <&funnel_in_port4>;
+				};
 			};
 		};
 	};
@@ -578,9 +588,11 @@
 		cpu = <&cpu4>;
 		clocks = <&oscclk6a>;
 		clock-names = "apb_pclk";
-		port {
-			etm2_out_port: endpoint {
-				remote-endpoint = <&funnel_in_port5>;
+		out-ports {
+			port {
+				etm2_out_port: endpoint {
+					remote-endpoint = <&funnel_in_port5>;
+				};
 			};
 		};
 	};
-- 
2.7.4
