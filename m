From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 20 Mar 2017 09:57:54 +0100
Subject: [PATCH 15/31] ARM: dts: r8a73a4: Add INTC-SYS clock to device tree
In-Reply-To: <cover.1489999062.git.horms+renesas@verge.net.au>
References: <cover.1489999062.git.horms+renesas@verge.net.au>
Message-ID: <c11333cc2e7ebe41e2aa4fa353abafa1f21a0662.1489999062.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Link the ARM GIC to the INTC-SYS module clock and the C4 power domain,
so it can be power managed using that clock in the future.

Note that currently the GIC-400 driver doesn't support module clocks nor
Runtime PM, so this must be handled as a critical clock.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4.dtsi            | 13 +++++++++----
 include/dt-bindings/clock/r8a73a4-clock.h |  1 +
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index 6fb7eaba9126..1f5c9f6dddba 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -467,6 +467,9 @@
 			<0 0xf1004000 0 0x2000>,
 			<0 0xf1006000 0 0x2000>;
 		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		clocks = <&mstp4_clks R8A73A4_CLK_INTC_SYS>;
+		clock-names = "clk";
+		power-domains = <&pd_c4>;
 	};
 
 	bsc: bus at fec10000 {
@@ -725,16 +728,18 @@
 		mstp4_clks: mstp4_clks at e6150140 {
 			compatible = "renesas,r8a73a4-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150140 0 4>, <0 0xe615004c 0 4>;
-			clocks = <&main_div2_clk>, <&main_div2_clk>,
+			clocks = <&main_div2_clk>, <&cpg_clocks R8A73A4_CLK_ZS>,
+				 <&main_div2_clk>,
 				 <&cpg_clocks R8A73A4_CLK_HP>,
 				 <&cpg_clocks R8A73A4_CLK_HP>;
 			#clock-cells = <1>;
 			clock-indices = <
-				R8A73A4_CLK_IRQC R8A73A4_CLK_IIC5
-				R8A73A4_CLK_IIC4 R8A73A4_CLK_IIC3
+				R8A73A4_CLK_IRQC R8A73A4_CLK_INTC_SYS
+				R8A73A4_CLK_IIC5 R8A73A4_CLK_IIC4
+				R8A73A4_CLK_IIC3
 			>;
 			clock-output-names =
-				"irqc", "iic5", "iic4", "iic3";
+				"irqc", "intc-sys", "iic5", "iic4", "iic3";
 		};
 		mstp5_clks: mstp5_clks at e6150144 {
 			compatible = "renesas,r8a73a4-mstp-clocks", "renesas,cpg-mstp-clocks";
diff --git a/include/dt-bindings/clock/r8a73a4-clock.h b/include/dt-bindings/clock/r8a73a4-clock.h
index dd11ecdf837e..4b3668157257 100644
--- a/include/dt-bindings/clock/r8a73a4-clock.h
+++ b/include/dt-bindings/clock/r8a73a4-clock.h
@@ -54,6 +54,7 @@
 #define R8A73A4_CLK_IIC3	11
 #define R8A73A4_CLK_IIC4	10
 #define R8A73A4_CLK_IIC5	9
+#define R8A73A4_CLK_INTC_SYS	8
 #define R8A73A4_CLK_IRQC	7
 
 /* MSTP5 */
-- 
2.7.0.rc3.207.g0ac5344
