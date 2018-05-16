From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 16 May 2018 11:34:22 +0100
Subject: [PATCH] arm64: dts: juno: fix graph node unit addresses for coresight
 components
Message-ID: <1526466862-19173-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the coresight components graph node unit addresses are
continuous for both input and output ports while the "reg" properties
are restarted for input and output ports separately. This results is
the following DTC warnings:

 (graph_port): /etf at 20010000/ports/port at 1: graph node unit address error, expected "0"
 (graph_port): /etf at 20140000/ports/port at 1: graph node unit address error, expected "0"
 (graph_port): /funnel at 20040000/ports/port at 1: graph node unit address error, expected "0"
 (graph_port): /funnel at 20040000/ports/port at 2: graph node unit address error, expected "1"
 (graph_port): /funnel at 20040000/ports/port at 3: graph node unit address error, expected "2"
 (graph_port): /funnel at 20130000/ports/port at 1: graph node unit address error, expected "0"
 (graph_port): /funnel at 20150000/ports/port at 1: graph node unit address error, expected "0"
 (graph_port): /funnel at 20150000/ports/port at 2: graph node unit address error, expected "1"
 (graph_port): /funnel at 220c0000/ports/port at 1: graph node unit address error, expected "0"
 (graph_port): /funnel at 220c0000/ports/port at 2: graph node unit address error, expected "1"
 (graph_port): /funnel at 230c0000/ports/port at 1: graph node unit address error, expected "0"
 (graph_port): /funnel at 230c0000/ports/port at 2: graph node unit address error, expected "1"
 (graph_port): /funnel at 230c0000/ports/port at 3: graph node unit address error, expected "2"
 (graph_port): /funnel at 230c0000/ports/port at 4: graph node unit address error, expected "3"
 (graph_port): /replicator at 20120000/ports/port at 2: graph node unit address error, expected "0"

This patch makes even the reg property to follow the continuous
numbering as in the graph node unit address.

Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/boot/dts/arm/juno-base.dtsi    | 20 ++++++++++----------
 arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi |  8 ++++----
 arch/arm64/boot/dts/arm/juno.dts          |  2 +-
 3 files changed, 15 insertions(+), 15 deletions(-)

Hi Suzuki/Mathieu,

I did a quick scan @ drivers/hwtracing/coresight/of_coresight.c to check
if reg field is being used or not and whether this change causes any
regression. I don't think so, but I may be wrong, let me know.

diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
index 708a15887af4..dbeca292a57c 100644
--- a/arch/arm64/boot/dts/arm/juno-base.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
@@ -131,7 +131,7 @@
 
 			/* output port */
 			port at 1 {
-				reg = <0>;
+				reg = <1>;
 				etf0_out_port: endpoint {
 				};
 			};
@@ -175,7 +175,7 @@
 
 			/* input ports */
 			port at 1 {
-				reg = <0>;
+				reg = <1>;
 				main_funnel_in_port0: endpoint {
 					slave-mode;
 					remote-endpoint = <&cluster0_funnel_out_port>;
@@ -183,7 +183,7 @@
 			};
 
 			port at 2 {
-				reg = <1>;
+				reg = <2>;
 				main_funnel_in_port1: endpoint {
 					slave-mode;
 					remote-endpoint = <&cluster1_funnel_out_port>;
@@ -265,7 +265,7 @@
 			};
 
 			port at 1 {
-				reg = <0>;
+				reg = <1>;
 				cluster0_funnel_in_port0: endpoint {
 					slave-mode;
 					remote-endpoint = <&cluster0_etm0_out_port>;
@@ -273,7 +273,7 @@
 			};
 
 			port at 2 {
-				reg = <1>;
+				reg = <2>;
 				cluster0_funnel_in_port1: endpoint {
 					slave-mode;
 					remote-endpoint = <&cluster0_etm1_out_port>;
@@ -347,7 +347,7 @@
 			};
 
 			port at 1 {
-				reg = <0>;
+				reg = <1>;
 				cluster1_funnel_in_port0: endpoint {
 					slave-mode;
 					remote-endpoint = <&cluster1_etm0_out_port>;
@@ -355,21 +355,21 @@
 			};
 
 			port at 2 {
-				reg = <1>;
+				reg = <2>;
 				cluster1_funnel_in_port1: endpoint {
 					slave-mode;
 					remote-endpoint = <&cluster1_etm1_out_port>;
 				};
 			};
 			port at 3 {
-				reg = <2>;
+				reg = <3>;
 				cluster1_funnel_in_port2: endpoint {
 					slave-mode;
 					remote-endpoint = <&cluster1_etm2_out_port>;
 				};
 			};
 			port at 4 {
-				reg = <3>;
+				reg = <4>;
 				cluster1_funnel_in_port3: endpoint {
 					slave-mode;
 					remote-endpoint = <&cluster1_etm3_out_port>;
@@ -476,7 +476,7 @@
 
 			/* replicator input port */
 			port at 2 {
-				reg = <0>;
+				reg = <2>;
 				replicator_in_port0: endpoint {
 					slave-mode;
 				};
diff --git a/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi b/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
index 21287f2d75d3..a99f311c8dcb 100644
--- a/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
@@ -21,7 +21,7 @@
 
 			/* input port */
 			port at 1 {
-				reg = <0>;
+				reg = <1>;
 				csys1_funnel_in_port0: endpoint {
 					slave-mode;
 				};
@@ -52,7 +52,7 @@
 
 			/* output port */
 			port at 1 {
-				reg = <0>;
+				reg = <1>;
 				etf1_out_port: endpoint {
 					remote-endpoint = <&csys2_funnel_in_port1>;
 				};
@@ -81,7 +81,7 @@
 
 			/* input ports */
 			port at 1 {
-				reg = <0>;
+				reg = <1>;
 				csys2_funnel_in_port0: endpoint {
 					slave-mode;
 					remote-endpoint = <&etf0_out_port>;
@@ -89,7 +89,7 @@
 			};
 
 			port at 2 {
-				reg = <1>;
+				reg = <2>;
 				csys2_funnel_in_port1: endpoint {
 					slave-mode;
 					remote-endpoint = <&etf1_out_port>;
diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
index aa3b341a7547..34e940e7465b 100644
--- a/arch/arm64/boot/dts/arm/juno.dts
+++ b/arch/arm64/boot/dts/arm/juno.dts
@@ -260,7 +260,7 @@
 &main_funnel {
 	ports {
 		port at 3 {
-			reg = <2>;
+			reg = <3>;
 			main_funnel_in_port2: endpoint {
 				slave-mode;
 				remote-endpoint = <&stm_out_port>;
-- 
2.7.4
