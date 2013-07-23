From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Mon, 22 Jul 2013 22:01:09 -0300
Subject: [PATCH RFC 5/8] clk: sunxi: add PLL5 and PLL6 support
In-Reply-To: <1374541272-32173-1-git-send-email-emilio@elopez.com.ar>
References: <1374541272-32173-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1374541272-32173-6-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit implements PLL5 and PLL6 support on the sunxi clock driver.
These PLLs use a similar factor clock, but differ on their outputs.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---
 Documentation/devicetree/bindings/clock/sunxi.txt |   2 +
 drivers/clk/sunxi/clk-sunxi.c                     | 159 +++++++++++++++++++++-
 2 files changed, 159 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
index 9a28022..6634eac 100644
--- a/Documentation/devicetree/bindings/clock/sunxi.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi.txt
@@ -8,6 +8,8 @@ Required properties:
 - compatible : shall be one of the following:
 	"allwinner,sun4i-osc-clk" - for a gatable oscillator
 	"allwinner,sun4i-pll1-clk" - for the main PLL clock as well as PLL4
+	"allwinner,sun4i-pll5-clk" - for the PLL5 clock
+	"allwinner,sun4i-pll6-clk" - for the PLL6 clock
 	"allwinner,sun4i-cpu-clk" - for the CPU multiplexer clock
 	"allwinner,sun4i-axi-clk" - for the AXI clock
 	"allwinner,sun4i-axi-gates-clk" - for the AXI gates
diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 4dccdb9..743c2c2 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -127,6 +127,38 @@ static void sunxi_get_pll1_factors(u32 *freq, u32 parent_rate,
 
 
 /**
+ * sunxi_get_pll5_factors() - calculates n, k factors for PLL5
+ * PLL5 rate is calculated as follows
+ * rate = parent_rate * n * (k + 1)
+ * parent_rate is always 24Mhz
+ */
+
+static void sunxi_get_pll5_factors(u32 *freq, u32 parent_rate,
+				   u8 *n, u8 *k, u8 *m, u8 *p)
+{
+	u8 div;
+
+	/* Normalize value to a 24M multiple */
+	div = *freq / 24000000;
+	*freq = 24000000 * div;
+
+	/* we were called to round the frequency, we can now return */
+	if (n == NULL)
+		return;
+
+	if (*freq < 480000000)
+		*k = 0;
+	else if (*freq < 960000000)
+		*k = 1;
+	else
+		*k = 3;
+
+	*n = DIV_ROUND_UP(*freq, ((*k+1) * 24000000));
+}
+
+
+
+/**
  * sunxi_get_apb1_factors() - calculates m, p factors for APB1
  * APB1 rate is calculated as follows
  * rate = (parent_rate >> p) / (m + 1);
@@ -193,6 +225,13 @@ static struct clk_factors_config pll1_config = {
 	.pwidth = 2,
 };
 
+static struct clk_factors_config pll5_config = {
+	.nshift = 8,
+	.nwidth = 5,
+	.kshift = 4,
+	.kwidth = 2,
+};
+
 static struct clk_factors_config apb1_config = {
 	.mshift = 0,
 	.mwidth = 5,
@@ -206,6 +245,12 @@ static const __initconst struct factors_data pll1_data = {
 	.getter = sunxi_get_pll1_factors,
 };
 
+static const __initconst struct factors_data pll5_data = {
+	.enable = 31,
+	.table = &pll5_config,
+	.getter = sunxi_get_pll5_factors,
+};
+
 static const __initconst struct factors_data apb1_data = {
 	.table = &apb1_config,
 	.getter = sunxi_get_apb1_factors,
@@ -223,6 +268,7 @@ static void __init sunxi_factors_clk_setup(struct device_node *node,
 	const char *clk_name = node->name;
 	const char *parents[5];
 	void *reg;
+	unsigned long flags;
 	int i = 0;
 
 	reg = of_iomap(node, 0);
@@ -273,12 +319,14 @@ static void __init sunxi_factors_clk_setup(struct device_node *node,
 	factors->get_factors = data->getter;
 	factors->lock = &clk_lock;
 
+	/* We should not disable pll5, it powers the RAM */
+	flags = !strcmp("pll5", clk_name) ? CLK_IGNORE_UNUSED : 0;
+
 	clk = clk_register_composite(NULL, clk_name,
 			parents, i,
 			mux_hw, &clk_mux_ops,
 			&factors->hw, &clk_factors_ops,
-			gate_hw, &clk_gate_ops,
-			i ? 0 : CLK_IS_ROOT);
+			gate_hw, &clk_gate_ops, flags);
 
 	if (clk) {
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
@@ -469,6 +517,103 @@ static void __init sunxi_gates_clk_setup(struct device_node *node,
 	of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
 }
 
+
+
+/**
+ * sunxi_divs_clk_setup() - Setup function for leaf divisors on clocks
+ */
+
+#define SUNXI_DIVS_MAX_QTY	2
+
+struct divs_data {
+	const struct factors_data *factors; /* data for the factor clock */
+	struct {
+		u8 fixed; /* is it a fixed divisor? if not... */
+		struct clk_div_table *table; /* is it a table based divisor? */
+		u8 shift; /* otherwise it's a normal divisor with this shift */
+		u8 pow;   /* is it power-of-two based? */
+	} div[SUNXI_DIVS_MAX_QTY];
+};
+
+static struct clk_div_table pll6_sata_table[] = {
+	{ .val = 0, .div = 6, },
+	{ .val = 1, .div = 12, },
+	{ .val = 2, .div = 18, },
+	{ .val = 3, .div = 24, },
+	{ } /* sentinel */
+};
+
+static const __initconst struct divs_data pll5_divs_data = {
+	.factors = &pll5_data,
+	.div = {
+		{ .shift = 0, .pow = 0, }, /* M, DDR */
+		{ .shift = 16, .pow = 1, }, /* P, other */
+	}
+};
+
+static const __initconst struct divs_data pll6_divs_data = {
+	.factors = &pll5_data,
+	.div = {
+		{ .shift = 0, .table = pll6_sata_table }, /* M, SATA */
+		{ .fixed = 2 }, /* P, other */
+	}
+};
+
+static void __init sunxi_divs_clk_setup(struct device_node *node,
+					struct divs_data *data)
+{
+	struct clk_onecell_data *clk_data;
+	const char *parent  = node->name;
+	const char *clk_name;
+	struct clk **clks;
+	void *reg;
+	int i = 0;
+	int flags;
+
+	/* Set up factor clock that we will be dividing */
+	sunxi_factors_clk_setup(node, (struct factors_data *)data->factors);
+
+	reg = of_iomap(node, 0);
+
+	clk_data = kmalloc(sizeof(struct clk_onecell_data), GFP_KERNEL);
+	if (!clk_data)
+		return;
+	clks = kzalloc(SUNXI_DIVS_MAX_QTY * sizeof(struct clk *), GFP_KERNEL);
+	if (!clk_data->clks) {
+		kfree(clk_data);
+		return;
+	}
+	clk_data->clks = clks;
+
+	for (i = 0; i < SUNXI_DIVS_MAX_QTY; i++) {
+		if (of_property_read_string_index(node, "clock-output-names",
+						  i, &clk_name) != 0)
+			break;
+
+		if (data->div[i].fixed) {
+			clks[i] = clk_register_fixed_factor(NULL, clk_name,
+							    parent, 0, 1,
+							    data->div[i].fixed);
+		} else {
+			flags = data->div[i].pow ? CLK_DIVIDER_POWER_OF_TWO : 0;
+			clks[i] = clk_register_divider_table(NULL, clk_name,
+							     parent, 0, reg,
+							     data->div[i].shift,
+							     SUNXI_DIVISOR_WIDTH,
+							     flags,
+							     data->div[i].table,
+							     &clk_lock);
+		}
+
+		WARN_ON(IS_ERR(clk_data->clks[i]));
+	}
+
+	/* Adjust to the real max */
+	clk_data->clk_num = i;
+
+	of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+}
+
 /* Matches for of_clk_init */
 CLK_OF_DECLARE(sunxi_osc, "allwinner,sun4i-osc-clk", sunxi_osc_clk_setup);
 
@@ -487,6 +632,13 @@ static const __initconst struct of_device_id clk_div_match[] = {
 	{}
 };
 
+/* Matches for divided outputs */
+static const __initconst struct of_device_id clk_divs_match[] = {
+	{.compatible = "allwinner,sun4i-pll5-clk", .data = &pll5_divs_data,},
+	{.compatible = "allwinner,sun4i-pll6-clk", .data = &pll6_divs_data,},
+	{}
+};
+
 /* Matches for mux clocks */
 static const __initconst struct of_device_id clk_mux_match[] = {
 	{.compatible = "allwinner,sun4i-cpu-clk", .data = &cpu_mux_data,},
@@ -532,6 +684,9 @@ void __init sunxi_init_clocks(void)
 	/* Register divider clocks */
 	of_sunxi_table_clock_setup(clk_div_match, sunxi_divider_clk_setup);
 
+	/* Register divided output clocks */
+	of_sunxi_table_clock_setup(clk_divs_match, sunxi_divs_clk_setup);
+
 	/* Register mux clocks */
 	of_sunxi_table_clock_setup(clk_mux_match, sunxi_mux_clk_setup);
 
-- 
1.8.3.3
