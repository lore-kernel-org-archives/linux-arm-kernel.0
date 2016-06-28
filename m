From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Tue, 28 Jun 2016 18:13:21 +0800
Subject: [RFC PATCH 1/5] clk: sunxi: Add a driver for the PLL2 on A31/23/33
Message-ID: <20160628101325.2522-1-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is based on the PLL2 driver for A10/20.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 drivers/clk/sunxi/Makefile       |   1 +
 drivers/clk/sunxi/clk-a31-pll2.c | 194 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 195 insertions(+)
 create mode 100644 drivers/clk/sunxi/clk-a31-pll2.c

diff --git a/drivers/clk/sunxi/Makefile b/drivers/clk/sunxi/Makefile
index 39d2044..951992e 100644
--- a/drivers/clk/sunxi/Makefile
+++ b/drivers/clk/sunxi/Makefile
@@ -9,6 +9,7 @@ obj-y += clk-a10-mod1.o
 obj-y += clk-a10-pll2.o
 obj-y += clk-a10-ve.o
 obj-y += clk-a20-gmac.o
+obj-y += clk-a31-pll2.o
 obj-y += clk-mod0.o
 obj-y += clk-simple-gates.o
 obj-y += clk-sun4i-display.o
diff --git a/drivers/clk/sunxi/clk-a31-pll2.c b/drivers/clk/sunxi/clk-a31-pll2.c
new file mode 100644
index 0000000..3fdd98b
--- /dev/null
+++ b/drivers/clk/sunxi/clk-a31-pll2.c
@@ -0,0 +1,194 @@
+/*
+ * Copyright 2013 Emilio L?pez
+ * Emilio L?pez <emilio@elopez.com.ar>
+ *
+ * Copyright 2015 Maxime Ripard
+ * Maxime Ripard <maxime.ripard@free-electrons.com>
+ *
+ * Copyright 2016 Icenowy Zheng
+ * Icenowy Zheng <icenowy@aosc.xyz>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+
+#include <dt-bindings/clock/sun4i-a10-pll2.h>
+
+#define SUN6I_A31_PLL2_ENABLE		31
+
+#define SUN6I_A31_PLL2_PRE_DIV_SHIFT	0
+#define SUN6I_A31_PLL2_PRE_DIV_WIDTH	5
+#define SUN6I_A31_PLL2_PRE_DIV_MASK	GENMASK(SUN6I_A31_PLL2_PRE_DIV_WIDTH - 1, 0)
+
+#define SUN6I_A31_PLL2_N_SHIFT		8
+#define SUN6I_A31_PLL2_N_WIDTH		7
+#define SUN6I_A31_PLL2_N_MASK		GENMASK(SUN6I_A31_PLL2_N_WIDTH - 1, 0)
+
+#define SUN6I_A31_PLL2_POST_DIV_SHIFT	16
+#define SUN6I_A31_PLL2_POST_DIV_WIDTH	4
+#define SUN6I_A31_PLL2_POST_DIV_MASK	GENMASK(SUN6I_A31_PLL2_POST_DIV_WIDTH - 1, 0)
+
+#define SUN6I_A31_PLL2_POST_DIV_VALUE	4
+
+#define SUN6I_A31_PLL2_OUTPUTS		4
+
+static DEFINE_SPINLOCK(sun6i_a31_pll2_lock);
+
+static void __init sun6i_a31_pll2_setup(struct device_node *node)
+{
+	const char *clk_name = node->name, *parent;
+	struct clk **clks, *base_clk, *prediv_clk;
+	struct clk_onecell_data *clk_data;
+	struct clk_multiplier *mult;
+	struct clk_gate *gate;
+	void __iomem *reg;
+	u32 val;
+
+	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
+	if (IS_ERR(reg))
+		return;
+
+	clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);
+	if (!clk_data)
+		goto err_unmap;
+
+	clks = kcalloc(SUN6I_A31_PLL2_OUTPUTS, sizeof(struct clk *), GFP_KERNEL);
+	if (!clks)
+		goto err_free_data;
+
+	parent = of_clk_get_parent_name(node, 0);
+	prediv_clk = clk_register_divider(NULL, "pll2-prediv",
+					  parent, 0, reg,
+					  SUN6I_A31_PLL2_PRE_DIV_SHIFT,
+					  SUN6I_A31_PLL2_PRE_DIV_WIDTH,
+					  CLK_DIVIDER_ONE_BASED |
+					  CLK_DIVIDER_ALLOW_ZERO,
+					  &sun6i_a31_pll2_lock);
+	if (!prediv_clk) {
+		pr_err("Couldn't register the prediv clock\n");
+		goto err_free_array;
+	}
+
+	/* Setup the gate part of the PLL2 */
+	gate = kzalloc(sizeof(struct clk_gate), GFP_KERNEL);
+	if (!gate)
+		goto err_unregister_prediv;
+
+	gate->reg = reg;
+	gate->bit_idx = SUN6I_A31_PLL2_ENABLE;
+	gate->lock = &sun6i_a31_pll2_lock;
+
+	/* Setup the multiplier part of the PLL2 */
+	mult = kzalloc(sizeof(struct clk_multiplier), GFP_KERNEL);
+	if (!mult)
+		goto err_free_gate;
+
+	mult->reg = reg;
+	mult->shift = SUN6I_A31_PLL2_N_SHIFT;
+	mult->width = 7;
+	mult->flags = CLK_MULTIPLIER_ZERO_BYPASS |
+			CLK_MULTIPLIER_ROUND_CLOSEST;
+	mult->lock = &sun6i_a31_pll2_lock;
+
+	parent = __clk_get_name(prediv_clk);
+	base_clk = clk_register_composite(NULL, "pll2-base",
+					  &parent, 1,
+					  NULL, NULL,
+					  &mult->hw, &clk_multiplier_ops,
+					  &gate->hw, &clk_gate_ops,
+					  CLK_SET_RATE_PARENT);
+	if (!base_clk) {
+		pr_err("Couldn't register the base multiplier clock\n");
+		goto err_free_multiplier;
+	}
+
+	parent = __clk_get_name(base_clk);
+
+	/*
+	 * PLL2-1x
+	 *
+	 * This is supposed to have a post divider, but we won't need
+	 * to use it, we just need to initialise it to 4, and use a
+	 * fixed divider.
+	 */
+	val = readl(reg);
+	val &= ~(SUN6I_A31_PLL2_POST_DIV_MASK << SUN6I_A31_PLL2_POST_DIV_SHIFT);
+	val |= (SUN6I_A31_PLL2_POST_DIV_VALUE - 1)
+	       << SUN6I_A31_PLL2_POST_DIV_SHIFT;
+	writel(val, reg);
+
+	of_property_read_string_index(node, "clock-output-names",
+				      SUN4I_A10_PLL2_1X, &clk_name);
+	clks[SUN4I_A10_PLL2_1X] = clk_register_fixed_factor(NULL, clk_name,
+							    parent,
+							    CLK_SET_RATE_PARENT,
+							    1,
+							    SUN6I_A31_PLL2_POST_DIV_VALUE);
+	WARN_ON(IS_ERR(clks[SUN4I_A10_PLL2_1X]));
+
+	/*
+	 * PLL2-2x
+	 *
+	 * This clock doesn't use the post divider, and really is just
+	 * a fixed divider from the PLL2 base clock.
+	 */
+	of_property_read_string_index(node, "clock-output-names",
+				      SUN4I_A10_PLL2_2X, &clk_name);
+	clks[SUN4I_A10_PLL2_2X] = clk_register_fixed_factor(NULL, clk_name,
+							    parent,
+							    CLK_SET_RATE_PARENT,
+							    1, 2);
+	WARN_ON(IS_ERR(clks[SUN4I_A10_PLL2_2X]));
+
+	/* PLL2-4x */
+	of_property_read_string_index(node, "clock-output-names",
+				      SUN4I_A10_PLL2_4X, &clk_name);
+	clks[SUN4I_A10_PLL2_4X] = clk_register_fixed_factor(NULL, clk_name,
+							    parent,
+							    CLK_SET_RATE_PARENT,
+							    1, 1);
+	WARN_ON(IS_ERR(clks[SUN4I_A10_PLL2_4X]));
+
+	/* PLL2-8x */
+	of_property_read_string_index(node, "clock-output-names",
+				      SUN4I_A10_PLL2_8X, &clk_name);
+	clks[SUN4I_A10_PLL2_8X] = clk_register_fixed_factor(NULL, clk_name,
+							    parent,
+							    CLK_SET_RATE_PARENT,
+							    2, 1);
+	WARN_ON(IS_ERR(clks[SUN4I_A10_PLL2_8X]));
+
+	clk_data->clks = clks;
+	clk_data->clk_num = SUN6I_A31_PLL2_OUTPUTS;
+	of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+
+	return;
+
+err_free_multiplier:
+	kfree(mult);
+err_free_gate:
+	kfree(gate);
+err_unregister_prediv:
+	clk_unregister_divider(prediv_clk);
+err_free_array:
+	kfree(clks);
+err_free_data:
+	kfree(clk_data);
+err_unmap:
+	iounmap(reg);
+}
+
+CLK_OF_DECLARE(sun6i_a31_pll2, "allwinner,sun6i-a31-pll2-clk",
+	       sun6i_a31_pll2_setup);
-- 
2.9.0
