From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Sep 2018 11:09:45 +0200
Subject: [PATCH 50/58] arm64: dts: renesas: r8a77990: Add BRG support to SCIF2
In-Reply-To: <cover.1536828567.git.horms+renesas@verge.net.au>
References: <cover.1536828567.git.horms+renesas@verge.net.au>
Message-ID: <103db9b539567073de2200a8a0a725646610865d.1536828567.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

Add the device node for the external SCIF_CLK, and describe the clock
inputs for the Baud Rate Generator for External Clock (BRG) for SCIF2,
which can increase serial clock accuracy.

The presence of the SCIF_CLK crystal and its clock frequency depend on
the actual board.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
[geert: Enhance patch description]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77990.dtsi | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77990.dtsi b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
index e2c2d1480a68..6198768264be 100644
--- a/arch/arm64/boot/dts/renesas/r8a77990.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
@@ -63,6 +63,13 @@
 		method = "smc";
 	};
 
+	/* External SCIF clock - to be overridden by boards that provide it */
+	scif_clk: scif {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
 	soc: soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&gic>;
@@ -412,8 +419,11 @@
 				     "renesas,rcar-gen3-scif", "renesas,scif";
 			reg = <0 0xe6e88000 0 64>;
 			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 310>;
-			clock-names = "fck";
+			clocks = <&cpg CPG_MOD 310>,
+				 <&cpg CPG_CORE R8A77990_CLK_S3D1C>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+
 			power-domains = <&sysc R8A77990_PD_ALWAYS_ON>;
 			resets = <&cpg 310>;
 			status = "disabled";
-- 
2.11.0
