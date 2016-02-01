From: moinejf@free.fr (Jean-Francois Moine)
Date: Mon, 1 Feb 2016 08:43:52 +0100
Subject: [PATCH v3 1/2] clk: sunxi: Add sun6i/8i video support
In-Reply-To: <cover.1454427223.git.moinejf@free.fr>
References: <cover.1454427223.git.moinejf@free.fr>
Message-ID: <8fdfe5fe7715f19416d654964e55721b30237b38.1454427224.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the clock types which are used by the sun6i/8i families for video.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
v3: (no change)
v2:
	- remarks from Chen-Yu Tsai
	- DT documentation added
---
 Documentation/devicetree/bindings/clock/sunxi.txt |   2 +
 drivers/clk/sunxi/clk-sun6i-display.c             | 106 +++++++++++++
 drivers/clk/sunxi/clk-sun6i-pll3.c                | 174 ++++++++++++++++++++++
 3 files changed, 282 insertions(+)
 create mode 100644 drivers/clk/sunxi/clk-sun6i-display.c
 create mode 100644 drivers/clk/sunxi/clk-sun6i-pll3.c

diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
index e59f57b..a22b92f 100644
--- a/Documentation/devicetree/bindings/clock/sunxi.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi.txt
@@ -11,6 +11,7 @@ Required properties:
 	"allwinner,sun6i-a31-pll1-clk" - for the main PLL clock on A31
 	"allwinner,sun8i-a23-pll1-clk" - for the main PLL clock on A23
 	"allwinner,sun9i-a80-pll4-clk" - for the peripheral PLLs on A80
+	"allwinner,sun6i-pll3-clk" - for the video PLLs clock
 	"allwinner,sun4i-a10-pll5-clk" - for the PLL5 clock
 	"allwinner,sun4i-a10-pll6-clk" - for the PLL6 clock
 	"allwinner,sun6i-a31-pll6-clk" - for the PLL6 clock on A31
@@ -77,6 +78,7 @@ Required properties:
 	"allwinner,sun9i-a80-usb-mod-clk" - for usb gates + resets on A80
 	"allwinner,sun9i-a80-usb-phy-clk" - for usb phy gates + resets on A80
 	"allwinner,sun4i-a10-ve-clk" - for the Video Engine clock
+	"allwinner,sun6i-display-clk" - for the display clocks
 
 Required properties for all clocks:
 - reg : shall be the control register address for the clock.
diff --git a/drivers/clk/sunxi/clk-sun6i-display.c b/drivers/clk/sunxi/clk-sun6i-display.c
new file mode 100644
index 0000000..48356e3
--- /dev/null
+++ b/drivers/clk/sunxi/clk-sun6i-display.c
@@ -0,0 +1,106 @@
+/*
+ * Copyright 2016 Jean-Francois Moine <moinejf@free.fr>
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
+#include <linux/of_address.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/rational.h>
+#include <linux/delay.h>
+
+static DEFINE_SPINLOCK(sun6i_display_lock);
+
+#define SUN6I_DISPLAY_GATE_BIT	31
+#define SUN6I_DISPLAY_SEL_SHIFT	24
+#define SUN6I_DISPLAY_SEL_MASK	GENMASK(2, 0)
+#define SUN6I_DISPLAY_MSHIFT	0
+#define SUN6I_DISPLAY_MWIDTH	4
+
+static void __init sun6i_display_setup(struct device_node *node)
+{
+	const char *clk_name = node->name;
+	const char *parents[8];
+	struct clk_mux *mux = NULL;
+	struct clk_divider *div;
+	struct clk_gate *gate;
+	struct resource res;
+	void __iomem *mmio;
+	struct clk *clk;
+	int n;
+
+	of_property_read_string(node, "clock-output-names", &clk_name);
+
+	mmio = of_io_request_and_map(node, 0, of_node_full_name(node));
+	if (IS_ERR(mmio)) {
+		pr_err("%s: Could not map the clock registers\n", clk_name);
+		return;
+	}
+
+	n = of_clk_parent_fill(node, parents, ARRAY_SIZE(parents));
+
+	if (n > 1) {				/* many possible sources */
+		mux = kzalloc(sizeof(*mux), GFP_KERNEL);
+		if (!mux)
+			goto free_io;
+		mux->reg = mmio;
+		mux->shift = SUN6I_DISPLAY_SEL_SHIFT;
+		mux->mask = SUN6I_DISPLAY_SEL_MASK;
+		mux->lock = &sun6i_display_lock;
+	}
+
+	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+	if (!gate)
+		goto free_mux;
+
+	gate->reg = mmio;
+	gate->bit_idx = SUN6I_DISPLAY_GATE_BIT;
+	gate->lock = &sun6i_display_lock;
+
+	div = kzalloc(sizeof(*div), GFP_KERNEL);
+	if (!div)
+		goto free_gate;
+
+	div->reg = mmio;
+	div->shift = SUN6I_DISPLAY_MSHIFT;
+	div->width = SUN6I_DISPLAY_MWIDTH;
+	div->lock = &sun6i_display_lock;
+
+	clk = clk_register_composite(NULL, clk_name,
+				     parents, n,
+				     mux ? &mux->hw : NULL, &clk_mux_ops,
+				     &div->hw, &clk_divider_ops,
+				     &gate->hw, &clk_gate_ops,
+				     0);
+	if (IS_ERR(clk)) {
+		pr_err("%s: Couldn't register the clock\n", clk_name);
+		goto free_div;
+	}
+
+	of_clk_add_provider(node, of_clk_src_simple_get, clk);
+
+	return;
+
+free_div:
+	kfree(div);
+free_gate:
+	kfree(gate);
+free_mux:
+	kfree(mux);
+free_io:
+	iounmap(mmio);
+	of_address_to_resource(node, 0, &res);
+	release_mem_region(res.start, resource_size(&res));
+}
+
+CLK_OF_DECLARE(sun6i_display, "allwinner,sun6i-display-clk", sun6i_display_setup);
diff --git a/drivers/clk/sunxi/clk-sun6i-pll3.c b/drivers/clk/sunxi/clk-sun6i-pll3.c
new file mode 100644
index 0000000..3c128a4
--- /dev/null
+++ b/drivers/clk/sunxi/clk-sun6i-pll3.c
@@ -0,0 +1,174 @@
+/*
+ * Allwinner video PLL clocks
+ *
+ * Copyright 2016 Jean-Francois Moine <moinejf@free.fr>
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
+#include <linux/of_address.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/rational.h>
+#include <linux/iopoll.h>
+
+static DEFINE_SPINLOCK(sun6i_pll3_lock);
+
+struct clk_fact {
+	struct clk_hw hw;
+	void __iomem *reg;
+};
+#define to_clk_fact(_hw) container_of(_hw, struct clk_fact, hw)
+
+#define SUN6I_PLL3_MSHIFT	0
+#define SUN6I_PLL3_MMASK	GENMASK(3, 0)
+#define SUN6I_PLL3_NSHIFT	8
+#define SUN6I_PLL3_NMASK	GENMASK(7, 0)
+#define SUN6I_PLL3_MODE_SEL	BIT(24)
+#define SUN6I_PLL3_FRAC_CLK	BIT(25)
+#define SUN6I_PLL3_LOCK_BIT	28
+#define SUN6I_PLL3_GATE_BIT	31
+
+static u32 sun6i_pll3_get_fact(unsigned long rate,
+			unsigned long parent_rate,
+			unsigned long *n, unsigned long *m)
+{
+	if (rate == 297000000)
+		return SUN6I_PLL3_FRAC_CLK;
+	if (rate == 270000000)
+		return 0;
+	rational_best_approximation(rate, parent_rate,
+				SUN6I_PLL3_NMASK + 1, SUN6I_PLL3_MMASK + 1,
+				n, m);
+	return SUN6I_PLL3_MODE_SEL;
+}
+
+static unsigned long sun6i_pll3_recalc_rate(struct clk_hw *hw,
+					unsigned long parent_rate)
+{
+	struct clk_fact *fact = to_clk_fact(hw);
+	u32 reg;
+	u32 n, m;
+
+	reg = readl(fact->reg);
+	if (reg & SUN6I_PLL3_MODE_SEL) {
+		n = (reg >> SUN6I_PLL3_NSHIFT) & SUN6I_PLL3_NMASK;
+		m = (reg >> SUN6I_PLL3_MSHIFT) & SUN6I_PLL3_MMASK;
+		return parent_rate / (m + 1) * (n + 1);
+	}
+	if (reg & SUN6I_PLL3_FRAC_CLK)
+		return 297000000;
+	return 270000000;
+}
+
+static long sun6i_pll3_round_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long *parent_rate)
+{
+	u32 frac;
+	unsigned long n, m;
+
+	frac = sun6i_pll3_get_fact(rate, *parent_rate, &n, &m);
+	if (frac & SUN6I_PLL3_MODE_SEL)
+		return *parent_rate / m * n;
+	if (frac & SUN6I_PLL3_FRAC_CLK)
+		return 297000000;
+	return 270000000;
+}
+
+static int sun6i_pll3_set_rate(struct clk_hw *hw, unsigned long rate,
+			unsigned long parent_rate)
+{
+	struct clk_fact *fact = to_clk_fact(hw);
+	u32 reg;
+	unsigned long n, m;
+
+	reg = readl(fact->reg) &
+			~(SUN6I_PLL3_MODE_SEL |
+			  SUN6I_PLL3_FRAC_CLK |
+			  (SUN6I_PLL3_NMASK << SUN6I_PLL3_NSHIFT) |
+			  (SUN6I_PLL3_MMASK << SUN6I_PLL3_MSHIFT));
+
+	reg |= sun6i_pll3_get_fact(rate, parent_rate, &n, &m);
+	if (reg & SUN6I_PLL3_MODE_SEL)
+		reg |= ((n - 1) << SUN6I_PLL3_NSHIFT) |
+			((m - 1) << SUN6I_PLL3_MSHIFT);
+
+	writel(reg, fact->reg);
+
+	readl_poll_timeout(fact->reg, reg, reg & SUN6I_PLL3_LOCK_BIT, 10, 500);
+
+	return 0;
+}
+
+static const struct clk_ops clk_sun6i_pll3_fact_ops = {
+	.recalc_rate = sun6i_pll3_recalc_rate,
+	.round_rate = sun6i_pll3_round_rate,
+	.set_rate = sun6i_pll3_set_rate,
+};
+
+static void __init sun6i_pll3_setup(struct device_node *node)
+{
+	const char *clk_name, *parent;
+	void __iomem *mmio;
+	struct clk_fact *fact;
+	struct clk_gate *gate;
+	struct resource res;
+	struct clk *clk;
+
+	mmio = of_io_request_and_map(node, 0, of_node_full_name(node));
+	if (IS_ERR(mmio)) {
+		pr_err("%s: Could not map the clock registers\n", clk_name);
+		return;
+	}
+
+	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+	if (!gate)
+		goto free_mmio;
+	gate->reg = mmio;
+	gate->bit_idx = SUN6I_PLL3_GATE_BIT;
+	gate->lock = &sun6i_pll3_lock;
+
+	fact = kzalloc(sizeof(*fact), GFP_KERNEL);
+	if (!fact)
+		goto free_gate;
+	fact->reg = mmio;
+
+	parent = of_clk_get_parent_name(node, 0);
+
+	of_property_read_string(node, "clock-output-names", &clk_name);
+
+	clk = clk_register_composite(NULL, clk_name,
+				     &parent, 1,
+				     NULL, NULL,
+				     &fact->hw, &clk_sun6i_pll3_fact_ops,
+				     &gate->hw, &clk_gate_ops,
+				     0);
+	if (IS_ERR(clk)) {
+		pr_err("%s: Couldn't register the clock\n", clk_name);
+		goto free_fact;
+	}
+
+	of_clk_add_provider(node, of_clk_src_simple_get, clk);
+
+	return;
+
+free_fact:
+	kfree(fact);
+free_gate:
+	kfree(gate);
+free_mmio:
+	iounmap(mmio);
+	of_address_to_resource(node, 0, &res);
+	release_mem_region(res.start, resource_size(&res));
+}
+
+CLK_OF_DECLARE(sun6i_pll3, "allwinner,sun6i-pll3-clk", sun6i_pll3_setup);
-- 
2.7.0
