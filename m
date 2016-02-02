From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  2 Feb 2016 09:47:12 +0100
Subject: [PATCH 3/5] clk: sunxi: convert current clocks registration to
 CLK_OF_DECLARE
In-Reply-To: <1454402834-6385-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1454402834-6385-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1454402834-6385-4-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current clock registration and protection code has a few drawbacks, the
two main ones being that we create a lot of orphans clock in the
registration phase, which will be troublesome when we will start being less
relaxed about them.

The protection code also relies on clkdev, which we don't really use but
for this particular case.

Fix both at the same time by moving everyone to the CLK_OF_DECLARE that
will probe our clock tree in the right and thus avoid orphans, and by
protecting directly the clock returned by our registration function.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi/clk-sunxi.c | 150 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 133 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index a3d706f5b21c..da6c1bc763d1 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -585,6 +585,41 @@ static struct clk * __init sunxi_factors_clk_setup(struct device_node *node,
 	return sunxi_factors_register(node, data, &clk_lock, reg);
 }
 
+static void __init sun4i_pll1_clk_setup(struct device_node *node)
+{
+	sunxi_factors_clk_setup(node, &sun4i_pll1_data);
+}
+CLK_OF_DECLARE(sun4i_pll1, "allwinner,sun4i-a10-pll1-clk",
+	       sun4i_pll1_clk_setup);
+
+static void __init sun6i_pll1_clk_setup(struct device_node *node)
+{
+	sunxi_factors_clk_setup(node, &sun6i_a31_pll1_data);
+}
+CLK_OF_DECLARE(sun6i_pll1, "allwinner,sun6i-a31-pll1-clk",
+	       sun6i_pll1_clk_setup);
+
+static void __init sun8i_pll1_clk_setup(struct device_node *node)
+{
+	sunxi_factors_clk_setup(node, &sun8i_a23_pll1_data);
+}
+CLK_OF_DECLARE(sun8i_pll1, "allwinner,sun8i-a23-pll1-clk",
+	       sun8i_pll1_clk_setup);
+
+static void __init sun7i_pll4_clk_setup(struct device_node *node)
+{
+	sunxi_factors_clk_setup(node, &sun7i_a20_pll4_data);
+}
+CLK_OF_DECLARE(sun7i_pll4, "allwinner,sun7i-a20-pll4-clk",
+	       sun7i_pll4_clk_setup);
+
+static void __init sun5i_ahb_clk_setup(struct device_node *node)
+{
+	sunxi_factors_clk_setup(node, &sun5i_a13_ahb_data);
+}
+CLK_OF_DECLARE(sun5i_ahb, "allwinner,sun5i-a13-ahb-clk",
+	       sun5i_ahb_clk_setup);
+
 static void __init sun6i_ahb1_clk_setup(struct device_node *node)
 {
 	sunxi_factors_clk_setup(node, &sun6i_ahb1_data);
@@ -592,6 +627,20 @@ static void __init sun6i_ahb1_clk_setup(struct device_node *node)
 CLK_OF_DECLARE(sun6i_a31_ahb1, "allwinner,sun6i-a31-ahb1-clk",
 	       sun6i_ahb1_clk_setup);
 
+static void __init sun4i_apb1_clk_setup(struct device_node *node)
+{
+	sunxi_factors_clk_setup(node, &sun4i_apb1_data);
+}
+CLK_OF_DECLARE(sun4i_apb1, "allwinner,sun4i-a10-apb1-clk",
+	       sun4i_apb1_clk_setup);
+
+static void __init sun7i_out_clk_setup(struct device_node *node)
+{
+	sunxi_factors_clk_setup(node, &sun7i_a20_out_data);
+}
+CLK_OF_DECLARE(sun7i_out, "allwinner,sun7i-a20-out-clk",
+	       sun7i_out_clk_setup);
+
 
 /**
  * sunxi_mux_clk_setup() - Setup function for muxes
@@ -642,6 +691,34 @@ static struct clk * __init sunxi_mux_clk_setup(struct device_node *node,
 	return clk;
 }
 
+static void __init sun4i_cpu_clk_setup(struct device_node *node)
+{
+	struct clk *clk;
+
+	clk = sunxi_mux_clk_setup(node, &sun4i_cpu_mux_data);
+	if (!clk)
+		return;
+
+	/* Protect CPU clock */
+	__clk_get(clk);
+	clk_prepare_enable(clk);
+}
+CLK_OF_DECLARE(sun4i_cpu, "allwinner,sun4i-a10-cpu-clk",
+	       sun4i_cpu_clk_setup);
+
+static void __init sun6i_ahb1_mux_clk_setup(struct device_node *node)
+{
+	sunxi_mux_clk_setup(node, &sun6i_a31_ahb1_mux_data);
+}
+CLK_OF_DECLARE(sun6i_ahb1_mux, "allwinner,sun6i-a31-ahb1-mux-clk",
+	       sun6i_ahb1_mux_clk_setup);
+
+static void __init sun8i_ahb2_clk_setup(struct device_node *node)
+{
+	sunxi_mux_clk_setup(node, &sun8i_h3_ahb2_mux_data);
+}
+CLK_OF_DECLARE(sun8i_ahb2, "allwinner,sun8i-a31-ahb2-clk",
+	       sun8i_ahb2_clk_setup);
 
 
 /**
@@ -723,6 +800,34 @@ static void __init sunxi_divider_clk_setup(struct device_node *node,
 	}
 }
 
+static void __init sun4i_ahb_clk_setup(struct device_node *node)
+{
+	sunxi_divider_clk_setup(node, &sun4i_ahb_data);
+}
+CLK_OF_DECLARE(sun4i_ahb, "allwinner,sun4i-a10-ahb-clk",
+	       sun4i_ahb_clk_setup);
+
+static void __init sun4i_apb0_clk_setup(struct device_node *node)
+{
+	sunxi_divider_clk_setup(node, &sun4i_apb0_data);
+}
+CLK_OF_DECLARE(sun4i_apb0, "allwinner,sun4i-a10-apb0-clk",
+	       sun4i_apb0_clk_setup);
+
+static void __init sun4i_axi_clk_setup(struct device_node *node)
+{
+	sunxi_divider_clk_setup(node, &sun4i_axi_data);
+}
+CLK_OF_DECLARE(sun4i_axi, "allwinner,sun4i-a10-axi-clk",
+	       sun4i_axi_clk_setup);
+
+static void __init sun8i_axi_clk_setup(struct device_node *node)
+{
+	sunxi_divider_clk_setup(node, &sun8i_a23_axi_data);
+}
+CLK_OF_DECLARE(sun8i_axi, "allwinner,sun8i-a23-axi-clk",
+	       sun8i_axi_clk_setup);
+
 
 /**
  * sunxi_gates_clk_setup() - Setup function for leaf gates on clocks
@@ -934,42 +1039,53 @@ free_clkdata:
 	return NULL;
 }
 
+static void __init sun4i_pll5_clk_setup(struct device_node *node)
+{
+	struct clk **clks;
+
+	clks = sunxi_divs_clk_setup(node, &pll5_divs_data);
+	if (!clks)
+		return;
+
+	/* Protect PLL5_DDR */
+	__clk_get(clks[0]);
+	clk_prepare_enable(clks[0]);
+}
+CLK_OF_DECLARE(sun4i_pll5, "allwinner,sun4i-a10-pll5-clk",
+	       sun4i_pll5_clk_setup);
+
+static void __init sun4i_pll6_clk_setup(struct device_node *node)
+{
+	sunxi_divs_clk_setup(node, &pll6_divs_data);
+}
+CLK_OF_DECLARE(sun4i_pll6, "allwinner,sun4i-a10-pll6-clk",
+	       sun4i_pll6_clk_setup);
+
+static void __init sun6i_pll6_clk_setup(struct device_node *node)
+{
+	sunxi_divs_clk_setup(node, &sun6i_a31_pll6_divs_data);
+}
+CLK_OF_DECLARE(sun6i_pll6, "allwinner,sun6i-a31-pll6-clk",
+	       sun6i_pll6_clk_setup);
 
 
 /* Matches for factors clocks */
 static const struct of_device_id clk_factors_match[] __initconst = {
-	{.compatible = "allwinner,sun4i-a10-pll1-clk", .data = &sun4i_pll1_data,},
-	{.compatible = "allwinner,sun6i-a31-pll1-clk", .data = &sun6i_a31_pll1_data,},
-	{.compatible = "allwinner,sun8i-a23-pll1-clk", .data = &sun8i_a23_pll1_data,},
-	{.compatible = "allwinner,sun7i-a20-pll4-clk", .data = &sun7i_a20_pll4_data,},
-	{.compatible = "allwinner,sun5i-a13-ahb-clk", .data = &sun5i_a13_ahb_data,},
-	{.compatible = "allwinner,sun4i-a10-apb1-clk", .data = &sun4i_apb1_data,},
-	{.compatible = "allwinner,sun7i-a20-out-clk", .data = &sun7i_a20_out_data,},
 	{}
 };
 
 /* Matches for divider clocks */
 static const struct of_device_id clk_div_match[] __initconst = {
-	{.compatible = "allwinner,sun4i-a10-axi-clk", .data = &sun4i_axi_data,},
-	{.compatible = "allwinner,sun8i-a23-axi-clk", .data = &sun8i_a23_axi_data,},
-	{.compatible = "allwinner,sun4i-a10-ahb-clk", .data = &sun4i_ahb_data,},
-	{.compatible = "allwinner,sun4i-a10-apb0-clk", .data = &sun4i_apb0_data,},
 	{}
 };
 
 /* Matches for divided outputs */
 static const struct of_device_id clk_divs_match[] __initconst = {
-	{.compatible = "allwinner,sun4i-a10-pll5-clk", .data = &pll5_divs_data,},
-	{.compatible = "allwinner,sun4i-a10-pll6-clk", .data = &pll6_divs_data,},
-	{.compatible = "allwinner,sun6i-a31-pll6-clk", .data = &sun6i_a31_pll6_divs_data,},
 	{}
 };
 
 /* Matches for mux clocks */
 static const struct of_device_id clk_mux_match[] __initconst = {
-	{.compatible = "allwinner,sun4i-a10-cpu-clk", .data = &sun4i_cpu_mux_data,},
-	{.compatible = "allwinner,sun6i-a31-ahb1-mux-clk", .data = &sun6i_a31_ahb1_mux_data,},
-	{.compatible = "allwinner,sun8i-h3-ahb2-clk", .data = &sun8i_h3_ahb2_mux_data,},
 	{}
 };
 
-- 
2.6.4
