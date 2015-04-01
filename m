From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed,  1 Apr 2015 11:26:54 +0200
Subject: [PATCH] ARM: dts: imx6qdl: move HDMI controller to right location in
 DT
Message-ID: <1427880414-18503-1-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the HDMI controller is a child device of the AIPS bus in the
DT which is clearly wrong. Move it to the right location.
This introduces no functional change it just aligns the DT representation
with reality.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 56 +++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index f74a8ded515f..0482a665125a 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -119,6 +119,34 @@
 			status = "disabled";
 		};
 
+		hdmi: hdmi at 0120000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x00120000 0x9000>;
+			interrupts = <0 115 0x04>;
+			gpr = <&gpr>;
+			clocks = <&clks IMX6QDL_CLK_HDMI_IAHB>,
+				 <&clks IMX6QDL_CLK_HDMI_ISFR>;
+			clock-names = "iahb", "isfr";
+			status = "disabled";
+
+			port at 0 {
+				reg = <0>;
+
+				hdmi_mux_0: endpoint {
+					remote-endpoint = <&ipu1_di0_hdmi>;
+				};
+			};
+
+			port at 1 {
+				reg = <1>;
+
+				hdmi_mux_1: endpoint {
+					remote-endpoint = <&ipu1_di1_hdmi>;
+				};
+			};
+		};
+
 		timer at 00a00600 {
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0x00a00600 0x20>;
@@ -778,34 +806,6 @@
 				};
 			};
 
-			hdmi: hdmi at 0120000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				reg = <0x00120000 0x9000>;
-				interrupts = <0 115 0x04>;
-				gpr = <&gpr>;
-				clocks = <&clks IMX6QDL_CLK_HDMI_IAHB>,
-					 <&clks IMX6QDL_CLK_HDMI_ISFR>;
-				clock-names = "iahb", "isfr";
-				status = "disabled";
-
-				port at 0 {
-					reg = <0>;
-
-					hdmi_mux_0: endpoint {
-						remote-endpoint = <&ipu1_di0_hdmi>;
-					};
-				};
-
-				port at 1 {
-					reg = <1>;
-
-					hdmi_mux_1: endpoint {
-						remote-endpoint = <&ipu1_di1_hdmi>;
-					};
-				};
-			};
-
 			dcic1: dcic at 020e4000 {
 				reg = <0x020e4000 0x4000>;
 				interrupts = <0 124 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.1.4
