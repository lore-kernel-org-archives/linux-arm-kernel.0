From: wens@csie.org (Chen-Yu Tsai)
Date: Mon,  3 Feb 2014 09:51:38 +0800
Subject: [PATCH v4 2/8] clk: sunxi: update clock-output-names dt binding
 documentation
In-Reply-To: <1391392304-4660-1-git-send-email-wens@csie.org>
References: <1391392304-4660-1-git-send-email-wens@csie.org>
Message-ID: <1391392304-4660-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clock-output-names is now required for most of sunxi clock nodes, to
provide the name of the corresponding clock. Add the new requirements,
exceptions, as well as examples.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/clock/sunxi.txt | 32 ++++++++++++++++++-----
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
index c2cb762..0cf679b 100644
--- a/Documentation/devicetree/bindings/clock/sunxi.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi.txt
@@ -44,10 +44,11 @@ Required properties for all clocks:
 	multiplexed clocks, the list order must match the hardware
 	programming order.
 - #clock-cells : from common clock binding; shall be set to 0 except for
-	"allwinner,*-gates-clk" where it shall be set to 1
-
-Additionally, "allwinner,*-gates-clk" clocks require:
-- clock-output-names : the corresponding gate names that the clock controls
+	"allwinner,*-gates-clk", "allwinner,sun4i-pll5-clk" and
+	"allwinner,sun4i-pll6-clk" where it shall be set to 1
+- clock-output-names : shall be the corresponding names of the outputs.
+	If the clock module only has one output, the name shall be the
+	module name.
 
 Clock consumers should specify the desired clocks they use with a
 "clocks" phandle cell. Consumers that are using a gated clock should
@@ -56,18 +57,28 @@ offset of the bit controlling this particular gate in the register.
 
 For example:
 
-osc24M: osc24M at 01c20050 {
+osc24M: clk at 01c20050 {
 	#clock-cells = <0>;
 	compatible = "allwinner,sun4i-osc-clk";
 	reg = <0x01c20050 0x4>;
 	clocks = <&osc24M_fixed>;
+	clock-output-names = "osc24M";
 };
 
-pll1: pll1 at 01c20000 {
+pll1: clk at 01c20000 {
 	#clock-cells = <0>;
 	compatible = "allwinner,sun4i-pll1-clk";
 	reg = <0x01c20000 0x4>;
 	clocks = <&osc24M>;
+	clock-output-names = "pll1";
+};
+
+pll5: clk at 01c20020 {
+	#clock-cells = <1>;
+	compatible = "allwinner,sun4i-pll5-clk";
+	reg = <0x01c20020 0x4>;
+	clocks = <&osc24M>;
+	clock-output-names = "pll5_ddr", "pll5_other";
 };
 
 cpu: cpu at 01c20054 {
@@ -75,4 +86,13 @@ cpu: cpu at 01c20054 {
 	compatible = "allwinner,sun4i-cpu-clk";
 	reg = <0x01c20054 0x4>;
 	clocks = <&osc32k>, <&osc24M>, <&pll1>;
+	clock-output-names = "cpu";
+};
+
+mmc0_clk: clk at 01c20088 {
+	#clock-cells = <0>;
+	compatible = "allwinner,sun4i-mod0-clk";
+	reg = <0x01c20088 0x4>;
+	clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
+	clock-output-names = "mmc0";
 };
-- 
1.9.rc1
