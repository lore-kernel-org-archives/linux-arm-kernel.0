From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 27 Sep 2014 16:49:50 +0800
Subject: [PATCH v2 2/7] clk: sunxi: Implement A31 PLL6 as a divs clock for 2x
 output
In-Reply-To: <1411807795-6575-1-git-send-email-wens@csie.org>
References: <1411807795-6575-1-git-send-email-wens@csie.org>
Message-ID: <1411807795-6575-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some clock modules on the A31 use PLL6x2 as one of their inputs.
This patch changes the PLL6 implementation for A31 to a divs clock,
i.e. clock with multiple outputs that have different dividers.
The first output will be the normal PLL6 output, and the second
will be PLL6x2.

This patch fixes the PLL6 N factor in the clock driver, and removes
any /2 dividers in the PLL6 factors clock part. The N factor counts
from 1 to 32, mapping to values 0 to 31, as shown in the A31 manual.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/clock/sunxi.txt |  5 ++--
 drivers/clk/sunxi/clk-sunxi.c                     | 28 +++++++++++++----------
 2 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
index d3a5c3c..0d84f4b 100644
--- a/Documentation/devicetree/bindings/clock/sunxi.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi.txt
@@ -59,8 +59,9 @@ Required properties for all clocks:
 	multiplexed clocks, the list order must match the hardware
 	programming order.
 - #clock-cells : from common clock binding; shall be set to 0 except for
-	"allwinner,*-gates-clk", "allwinner,sun4i-pll5-clk" and
-	"allwinner,sun4i-pll6-clk" where it shall be set to 1
+	the following compatibles where it shall be set to 1:
+	"allwinner,*-gates-clk", "allwinner,sun4i-pll5-clk",
+	"allwinner,sun4i-pll6-clk", "allwinner, sun6i-a31-pll6-clk"
 - clock-output-names : shall be the corresponding names of the outputs.
 	If the clock module only has one output, the name shall be the
 	module name.
diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 05d9329..9caebff 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -244,9 +244,9 @@ static void sun4i_get_pll5_factors(u32 *freq, u32 parent_rate,
 }
 
 /**
- * sun6i_a31_get_pll6_factors() - calculates n, k factors for A31 PLL6
- * PLL6 rate is calculated as follows
- * rate = parent_rate * n * (k + 1) / 2
+ * sun6i_a31_get_pll6_factors() - calculates n, k factors for A31 PLL6x2
+ * PLL6x2 rate is calculated as follows
+ * rate = parent_rate * (n + 1) * (k + 1)
  * parent_rate is always 24Mhz
  */
 
@@ -255,13 +255,7 @@ static void sun6i_a31_get_pll6_factors(u32 *freq, u32 parent_rate,
 {
 	u8 div;
 
-	/*
-	 * We always have 24MHz / 2, so we can just say that our
-	 * parent clock is 12MHz.
-	 */
-	parent_rate = parent_rate / 2;
-
-	/* Normalize value to a parent_rate multiple (24M / 2) */
+	/* Normalize value to a parent_rate multiple (24M) */
 	div = *freq / parent_rate;
 	*freq = parent_rate * div;
 
@@ -273,7 +267,7 @@ static void sun6i_a31_get_pll6_factors(u32 *freq, u32 parent_rate,
 	if (*k > 3)
 		*k = 3;
 
-	*n = DIV_ROUND_UP(div, (*k+1));
+	*n = DIV_ROUND_UP(div, (*k+1)) - 1;
 }
 
 /**
@@ -494,6 +488,7 @@ static struct clk_factors_config sun6i_a31_pll6_config = {
 	.nwidth = 5,
 	.kshift = 4,
 	.kwidth = 2,
+	.n_start = 1,
 };
 
 static struct clk_factors_config sun4i_apb1_config = {
@@ -561,6 +556,7 @@ static const struct factors_data sun6i_a31_pll6_data __initconst = {
 	.enable = 31,
 	.table = &sun6i_a31_pll6_config,
 	.getter = sun6i_a31_get_pll6_factors,
+	.name = "pll6x2",
 };
 
 static const struct factors_data sun4i_apb1_data __initconst = {
@@ -1073,6 +1069,14 @@ static const struct divs_data pll6_divs_data __initconst = {
 	}
 };
 
+static const struct divs_data sun6i_a31_pll6_divs_data __initconst = {
+	.factors = &sun6i_a31_pll6_data,
+	.ndivs = 1,
+	.div = {
+		{ .fixed = 2 }, /* normal output */
+	}
+};
+
 /**
  * sunxi_divs_clk_setup() - Setup function for leaf divisors on clocks
  *
@@ -1213,7 +1217,6 @@ static const struct of_device_id clk_factors_match[] __initconst = {
 	{.compatible = "allwinner,sun6i-a31-pll1-clk", .data = &sun6i_a31_pll1_data,},
 	{.compatible = "allwinner,sun8i-a23-pll1-clk", .data = &sun8i_a23_pll1_data,},
 	{.compatible = "allwinner,sun7i-a20-pll4-clk", .data = &sun7i_a20_pll4_data,},
-	{.compatible = "allwinner,sun6i-a31-pll6-clk", .data = &sun6i_a31_pll6_data,},
 	{.compatible = "allwinner,sun4i-a10-apb1-clk", .data = &sun4i_apb1_data,},
 	{.compatible = "allwinner,sun4i-a10-mod0-clk", .data = &sun4i_mod0_data,},
 	{.compatible = "allwinner,sun7i-a20-out-clk", .data = &sun7i_a20_out_data,},
@@ -1234,6 +1237,7 @@ static const struct of_device_id clk_div_match[] __initconst = {
 static const struct of_device_id clk_divs_match[] __initconst = {
 	{.compatible = "allwinner,sun4i-a10-pll5-clk", .data = &pll5_divs_data,},
 	{.compatible = "allwinner,sun4i-a10-pll6-clk", .data = &pll6_divs_data,},
+	{.compatible = "allwinner,sun6i-a31-pll6-clk", .data = &sun6i_a31_pll6_divs_data,},
 	{}
 };
 
-- 
2.1.1
