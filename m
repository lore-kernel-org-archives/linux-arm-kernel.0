From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  4 Nov 2014 10:50:26 +0900
Subject: [PATCH 03/10] ARM: shmobile: r8a7790: Add DU node to device tree
In-Reply-To: <cover.1415058552.git.horms+renesas@verge.net.au>
References: <cover.1415058552.git.horms+renesas@verge.net.au>
Message-ID: <3ac6a83c09cbb74ebb3d3e7e6e40e1ead3ff9d01.1415058552.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Add the DU device with a disabled state. Boards that want to enable the
DU need to specify the output topology.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
[horms+renesas at verge.net.au: resolved minor conflict]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 90 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index d0e1773..b7c59b7 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -600,6 +600,96 @@
 		status = "disabled";
 	};
 
+	vsp1 at fe920000 {
+		compatible = "renesas,vsp1";
+		reg = <0 0xfe920000 0 0x8000>;
+		interrupts = <0 266 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp1_clks R8A7790_CLK_VSP1_R>;
+
+		renesas,has-sru;
+		renesas,#rpf = <5>;
+		renesas,#uds = <1>;
+		renesas,#wpf = <4>;
+	};
+
+	vsp1 at fe928000 {
+		compatible = "renesas,vsp1";
+		reg = <0 0xfe928000 0 0x8000>;
+		interrupts = <0 267 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp1_clks R8A7790_CLK_VSP1_S>;
+
+		renesas,has-lut;
+		renesas,has-sru;
+		renesas,#rpf = <5>;
+		renesas,#uds = <3>;
+		renesas,#wpf = <4>;
+	};
+
+	vsp1 at fe930000 {
+		compatible = "renesas,vsp1";
+		reg = <0 0xfe930000 0 0x8000>;
+		interrupts = <0 246 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp1_clks R8A7790_CLK_VSP1_DU0>;
+
+		renesas,has-lif;
+		renesas,has-lut;
+		renesas,#rpf = <4>;
+		renesas,#uds = <1>;
+		renesas,#wpf = <4>;
+	};
+
+	vsp1 at fe938000 {
+		compatible = "renesas,vsp1";
+		reg = <0 0xfe938000 0 0x8000>;
+		interrupts = <0 247 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp1_clks R8A7790_CLK_VSP1_DU1>;
+
+		renesas,has-lif;
+		renesas,has-lut;
+		renesas,#rpf = <4>;
+		renesas,#uds = <1>;
+		renesas,#wpf = <4>;
+	};
+
+	du: display at feb00000 {
+		compatible = "renesas,du-r8a7790";
+		reg = <0 0xfeb00000 0 0x70000>,
+		      <0 0xfeb90000 0 0x1c>,
+		      <0 0xfeb94000 0 0x1c>;
+		reg-names = "du", "lvds.0", "lvds.1";
+		interrupts = <0 256 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 268 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 269 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7790_CLK_DU0>,
+			 <&mstp7_clks R8A7790_CLK_DU1>,
+			 <&mstp7_clks R8A7790_CLK_DU2>,
+			 <&mstp7_clks R8A7790_CLK_LVDS0>,
+			 <&mstp7_clks R8A7790_CLK_LVDS1>;
+		clock-names = "du.0", "du.1", "du.2", "lvds.0", "lvds.1";
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
+				reg = <0>;
+				du_out_rgb: endpoint {
+				};
+			};
+			port at 1 {
+				reg = <1>;
+				du_out_lvds0: endpoint {
+				};
+			};
+			port at 2 {
+				reg = <2>;
+				du_out_lvds1: endpoint {
+				};
+			};
+		};
+	};
+
 	clocks {
 		#address-cells = <2>;
 		#size-cells = <2>;
-- 
2.1.1
