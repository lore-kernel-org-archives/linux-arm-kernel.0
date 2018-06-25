From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Jun 2018 16:03:22 +0200
Subject: [PATCH 27/29] arm64: dts: renesas: r8a77980: add FCPVD/VSPD/DU/LVDS
 support
In-Reply-To: <cover.1529933747.git.horms+renesas@verge.net.au>
References: <cover.1529933747.git.horms+renesas@verge.net.au>
Message-ID: <a334e781e01afeb97634480ec0d9819287b79a68.1529933747.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Describe the interconnected FCPVD0, VSPD0, DU, and LVDS0 devices in the
R8A77980 device tree...

Based on the original (and large) patch by Vladimir Barinov.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77980.dtsi | 77 +++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77980.dtsi b/arch/arm64/boot/dts/renesas/r8a77980.dtsi
index 68cede26b01a..623ebe435417 100644
--- a/arch/arm64/boot/dts/renesas/r8a77980.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77980.dtsi
@@ -653,6 +653,83 @@
 			resets = <&cpg 408>;
 		};
 
+		vspd0: vsp at fea20000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xfea20000 0 0x5000>;
+			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 623>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
+			resets = <&cpg 623>;
+			renesas,fcp = <&fcpvd0>;
+		};
+
+		fcpvd0: fcp at fea27000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xfea27000 0 0x200>;
+			clocks = <&cpg CPG_MOD 603>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
+			resets = <&cpg 603>;
+		};
+
+		du: display at feb00000 {
+			compatible = "renesas,du-r8a77980",
+				     "renesas,du-r8a77970";
+			reg = <0 0xfeb00000 0 0x80000>;
+			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 724>;
+			clock-names = "du.0";
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
+			resets = <&cpg 724>;
+			vsps = <&vspd0>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 0 {
+					reg = <0>;
+					du_out_rgb: endpoint {
+					};
+				};
+
+				port at 1 {
+					reg = <1>;
+					du_out_lvds0: endpoint {
+						remote-endpoint = <&lvds0_in>;
+					};
+				};
+			};
+		};
+
+		lvds0: lvds-encoder at feb90000 {
+			compatible = "renesas,r8a77980-lvds";
+			reg = <0 0xfeb90000 0 0x14>;
+			clocks = <&cpg CPG_MOD 727>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
+			resets = <&cpg 727>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 0 {
+					reg = <0>;
+					lvds0_in: endpoint {
+						remote-endpoint =
+							<&du_out_lvds0>;
+					};
+				};
+
+				port at 1 {
+					reg = <1>;
+					lvds0_out: endpoint {
+					};
+				};
+			};
+		};
+
 		prr: chipid at fff00044 {
 			compatible = "renesas,prr";
 			reg = <0 0xfff00044 0 4>;
-- 
2.11.0
