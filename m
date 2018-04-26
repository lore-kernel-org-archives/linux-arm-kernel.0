From: kieran.bingham+renesas@ideasonboard.com (Kieran Bingham)
Date: Thu, 26 Apr 2018 17:53:42 +0100
Subject: [PATCH 13/17] arm64: dts: r8a77965: Add HDMI encoder instance
In-Reply-To: <20180426165346.494-1-kieran.bingham+renesas@ideasonboard.com>
References: <20180426165346.494-1-kieran.bingham+renesas@ideasonboard.com>
Message-ID: <20180426165346.494-14-kieran.bingham+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the HDMI encoder to the R8A77965 DT in disabled state.

Based on a similar patch of the R8A7796 device tree
by Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
[Kieran: Rebase to top of tree]
Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 28 +++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index 8a40bba53027..972be1460a32 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
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
 			reg = <0 0xfeb00000 0 0x80000>,
@@ -1134,6 +1161,7 @@
 				port at 1 {
 					reg = <1>;
 					du_out_hdmi0: endpoint {
+						remote-endpoint = <&dw_hdmi0_in>;
 					};
 				};
 				port at 2 {
-- 
2.17.0
