From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  9 Jan 2014 16:52:39 +0800
Subject: [PATCH v3 2/8] clk: sunxi: update clock-output-names dt binding
 documentation
In-Reply-To: <1389257565-19797-1-git-send-email-wens@csie.org>
References: <1389257565-19797-1-git-send-email-wens@csie.org>
Message-ID: <1389257565-19797-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clock-output-names is now required for most of sunxi clock nodes, to
provide the name of the corresponding clock. Add the new requirements,
exceptions, as well as examples.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/clock/sunxi.txt | 36 +++++++++++++++++++----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
index 0c127cd..8a9147d 100644
--- a/Documentation/devicetree/bindings/clock/sunxi.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi.txt
@@ -44,10 +44,18 @@ Required properties for all clocks:
 	multiplexed clocks, the list order must match the hardware
 	programming order.
 - #clock-cells : from common clock binding; shall be set to 0 except for
-	"allwinner,*-gates-clk" where it shall be set to 1
+	"allwinner,*-gates-clk", "allwinner,sun4i-pll5-clk" and
+	"allwinner,sun4i-pll6-clk" where it shall be set to 1
 
-Additionally, "allwinner,*-gates-clk" clocks require:
-- clock-output-names : the corresponding gate names that the clock controls
+Additionally, most clocks require "clock-output-names":
+- "allwinner,*-gates-clk" : the corresponding gate names that the clock controls
+- "allwinner,sun4i-pll5-clk" : "pll5_ddr", "pll5_mbus"
+- "allwinner,sun4i-pll6-clk" : "pll6_sata", "pll6_other"
+- "allwinner,sun4i-cpu-clk", "allwinner,sun4i-axi-clk",
+  "allwinner,sun4i-ahb-clk", "allwinner,sun4i-ahb-clk",
+  "allwinner,sun4i-apb1-mux-clk", "allwinner,sun4i-apb1-clk"
+  do not need "clock-output-names"
+- all others clocks : the corresponding module name of that clock
 
 Clock consumers should specify the desired clocks they use with a
 "clocks" phandle cell. Consumers that are using a gated clock should
@@ -56,18 +64,28 @@ offset of the bit controlling this particular gate in the register.
 
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
@@ -76,3 +94,11 @@ cpu: cpu at 01c20054 {
 	reg = <0x01c20054 0x4>;
 	clocks = <&osc32k>, <&osc24M>, <&pll1>;
 };
+
+mmc0_clk: clk at 01c20088 {
+	#clock-cells = <0>;
+	compatible = "allwinner,sun4i-mod0-clk";
+	reg = <0x01c20088 0x4>;
+	clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
+	clock-output-names = "mmc0";
+};
-- 
1.8.5.2
