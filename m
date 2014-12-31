From: Ying.Liu@freescale.com (Liu Ying)
Date: Wed, 31 Dec 2014 16:23:27 +0800
Subject: [PATCH RFC v8 09/21] ARM: dts: imx6qdl: Move existing MIPI DSI ports
 into a new 'ports' node
In-Reply-To: <1420014219-915-1-git-send-email-Ying.Liu@freescale.com>
References: <1420014219-915-1-git-send-email-Ying.Liu@freescale.com>
Message-ID: <1420014219-915-10-git-send-email-Ying.Liu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MIPI DSI node contains some ports which represent possible DRM CRTCs
it can connect with.  Each port has a 'reg' property embedded.  This
property will be wrongly interpretted by the MIPI DSI bus driver, because
the driver will take each subnode which contains a 'reg' property as a
DSI peripheral device.  This patch moves the existing MIPI DSI ports into
a new 'ports' node so that the MIPI DSI bus driver may distinguish its
DSI peripheral device(s) from the existing ports.

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
---
v7->v8:
 * None.

v5->v6:
 * None.

v4->v5:
 * None.

v3->v4:
 * None.

v2->v3:
 * Add Philipp's Ack.

v1->v2:
 * Newly added, as suggested by Thierry Reding.

 arch/arm/boot/dts/imx6q.dtsi   | 20 +++++++++++---------
 arch/arm/boot/dts/imx6qdl.dtsi | 23 ++++++++++++++---------
 2 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index e9f3646..9c0990b 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -292,19 +292,21 @@
 };
 
 &mipi_dsi {
-	port at 2 {
-		reg = <2>;
+	ports {
+		port at 2 {
+			reg = <2>;
 
-		mipi_mux_2: endpoint {
-			remote-endpoint = <&ipu2_di0_mipi>;
+			mipi_mux_2: endpoint {
+				remote-endpoint = <&ipu2_di0_mipi>;
+			};
 		};
-	};
 
-	port at 3 {
-		reg = <3>;
+		port at 3 {
+			reg = <3>;
 
-		mipi_mux_3: endpoint {
-			remote-endpoint = <&ipu2_di1_mipi>;
+			mipi_mux_3: endpoint {
+				remote-endpoint = <&ipu2_di1_mipi>;
+			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 9596ed5..96bf2a0 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -1009,19 +1009,24 @@
 				reg = <0x021e0000 0x4000>;
 				status = "disabled";
 
-				port at 0 {
-					reg = <0>;
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port at 0 {
+						reg = <0>;
 
-					mipi_mux_0: endpoint {
-						remote-endpoint = <&ipu1_di0_mipi>;
+						mipi_mux_0: endpoint {
+							remote-endpoint = <&ipu1_di0_mipi>;
+						};
 					};
-				};
 
-				port at 1 {
-					reg = <1>;
+					port at 1 {
+						reg = <1>;
 
-					mipi_mux_1: endpoint {
-						remote-endpoint = <&ipu1_di1_mipi>;
+						mipi_mux_1: endpoint {
+							remote-endpoint = <&ipu1_di1_mipi>;
+						};
 					};
 				};
 			};
-- 
2.1.0
