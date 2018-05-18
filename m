From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:15:19 +0200
Subject: [PATCH 057/102] arm64: dts: renesas: r8a77965: Add HDMI encoder
 instance
In-Reply-To: <cover.1526637994.git.horms+renesas@verge.net.au>
References: <cover.1526637994.git.horms+renesas@verge.net.au>
Message-ID: <5daa6f9f160bcc63664aeb6fd597a9e712bcd4d0.1526637994.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

Add the HDMI encoder to the R8A77965 DT in disabled state.

Based on a similar patch of the R8A7796 device tree
by Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
[Kieran: Rebase to top of tree]
Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index a35ea2f32da2..b46af2744135 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -8,7 +8,7 @@
  * Copyright (C) 2016 Renesas Electronics Corp.
  */
 
-#include <dt-bindings/clock/renesas-cpg-mssr.h>
+#include <dt-bindings/clock/r8a77965-cpg-mssr.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/r8a77965-sysc.h>
 
@@ -1105,6 +1105,33 @@
 			};
 		};
 
+		hdmi0: hdmi at fead0000 {
+			compatible = "renesas,r8a77965-hdmi",
+				     "renesas,rcar-gen3-hdmi";
+			reg = <0 0xfead0000 0 0x10000>;
+			interrupts = <GIC_SPI 389 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 729>,
+				 <&cpg CPG_CORE R8A77965_CLK_HDMI>;
+			clock-names = "iahb", "isfr";
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
+			resets = <&cpg 729>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				port at 0 {
+					reg = <0>;
+					dw_hdmi0_in: endpoint {
+						remote-endpoint = <&du_out_hdmi0>;
+					};
+				};
+				port at 1 {
+					reg = <1>;
+				};
+			};
+		};
+
 		du: display at feb00000 {
 			compatible = "renesas,du-r8a77965";
 			reg = <0 0xfeb00000 0 0x80000>;
@@ -1132,6 +1159,7 @@
 				port at 1 {
 					reg = <1>;
 					du_out_hdmi0: endpoint {
+						remote-endpoint = <&dw_hdmi0_in>;
 					};
 				};
 				port at 2 {
-- 
2.11.0
