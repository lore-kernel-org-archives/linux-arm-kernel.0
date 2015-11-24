From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 24 Nov 2015 17:32:14 +0800
Subject: [PATCH v3 3/5] clk: sunxi: Add sun9i A80 cpus (cpu special) clock
 support
In-Reply-To: <1448357536-26613-1-git-send-email-wens@csie.org>
References: <1448357536-26613-1-git-send-email-wens@csie.org>
Message-ID: <1448357536-26613-4-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "cpus" clock is the clock for the embedded processor in the A80.
It is also part of the PRCM clock tree. This clock includes a pre-
divider on one of its inputs. For now we are using a custom clock
driver for it. In the future we may want to develop a generalized
driver for these types of clocks, which also includes the AHB clock
driver on sun[5678]i.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Hi Maxime,

I'll do the factors clock refactoring mentioned during the discussion
around v2 later on.

---
 Documentation/devicetree/bindings/clock/sunxi.txt |   1 +
 drivers/clk/sunxi/Makefile                        |   1 +
 drivers/clk/sunxi/clk-sun9i-cpus.c                | 240 ++++++++++++++++++++++
 3 files changed, 242 insertions(+)
 create mode 100644 drivers/clk/sunxi/clk-sun9i-cpus.c

diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
index b6859ed6913f..153ac72869e8 100644
--- a/Documentation/devicetree/bindings/clock/sunxi.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi.txt
@@ -27,6 +27,7 @@ Required properties:
 	"allwinner,sun5i-a10s-ahb-gates-clk" - for the AHB gates on A10s
 	"allwinner,sun7i-a20-ahb-gates-clk" - for the AHB gates on A20
 	"allwinner,sun6i-a31-ar100-clk" - for the AR100 on A31
+	"allwinner,sun9i-a80-cpus-clk" - for the CPUS on A80
 	"allwinner,sun6i-a31-ahb1-clk" - for the AHB1 clock on A31
 	"allwinner,sun6i-a31-ahb1-gates-clk" - for the AHB1 gates on A31
 	"allwinner,sun8i-a23-ahb1-gates-clk" - for the AHB1 gates on A23
diff --git a/drivers/clk/sunxi/Makefile b/drivers/clk/sunxi/Makefile
index 121333ce34ea..07d914c3f6d1 100644
--- a/drivers/clk/sunxi/Makefile
+++ b/drivers/clk/sunxi/Makefile
@@ -13,6 +13,7 @@ obj-y += clk-simple-gates.o
 obj-y += clk-sun8i-apb0.o
 obj-y += clk-sun8i-mbus.o
 obj-y += clk-sun9i-core.o
+obj-y += clk-sun9i-cpus.o
 obj-y += clk-sun9i-mmc.o
 obj-y += clk-usb.o
 
diff --git a/drivers/clk/sunxi/clk-sun9i-cpus.c b/drivers/clk/sunxi/clk-sun9i-cpus.c
new file mode 100644
index 000000000000..7626d2194b96
--- /dev/null
+++ b/drivers/clk/sunxi/clk-sun9i-cpus.c
@@ -0,0 +1,240 @@
+/*
+ * Copyright (C) 2015 Chen-Yu Tsai
+ *
+ * Chen-Yu Tsai <wens@csie.org>
+ *
+ * Allwinner A80 CPUS clock driver
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+static DEFINE_SPINLOCK(sun9i_a80_cpus_lock);
+
+/**
+ * sun9i_a80_cpus_clk_setup() - Setup function for a80 cpus composite clk
+ */
+
+#define SUN9I_CPUS_MAX_PARENTS		4
+#define SUN9I_CPUS_MUX_PARENT_PLL4	3
+#define SUN9I_CPUS_MUX_SHIFT		16
+#define SUN9I_CPUS_MUX_MASK		GENMASK(17, 16)
+#define SUN9I_CPUS_MUX_GET_PARENT(reg)	((reg & SUN9I_CPUS_MUX_MASK) >> \
+						SUN9I_CPUS_MUX_SHIFT)
+
+#define SUN9I_CPUS_DIV_SHIFT		4
+#define SUN9I_CPUS_DIV_MASK		GENMASK(5, 4)
+#define SUN9I_CPUS_DIV_GET(reg)		((reg & SUN9I_CPUS_DIV_MASK) >> \
+						SUN9I_CPUS_DIV_SHIFT)
+#define SUN9I_CPUS_DIV_SET(reg, div)	((reg & ~SUN9I_CPUS_DIV_MASK) | \
+						(div << SUN9I_CPUS_DIV_SHIFT))
+#define SUN9I_CPUS_PLL4_DIV_SHIFT	8
+#define SUN9I_CPUS_PLL4_DIV_MASK	GENMASK(12, 8)
+#define SUN9I_CPUS_PLL4_DIV_GET(reg)	((reg & SUN9I_CPUS_PLL4_DIV_MASK) >> \
+						SUN9I_CPUS_PLL4_DIV_SHIFT)
+#define SUN9I_CPUS_PLL4_DIV_SET(reg, div) ((reg & ~SUN9I_CPUS_PLL4_DIV_MASK) | \
+						(div << SUN9I_CPUS_PLL4_DIV_SHIFT))
+
+struct sun9i_a80_cpus_clk {
+	struct clk_hw hw;
+	void __iomem *reg;
+};
+
+#define to_sun9i_a80_cpus_clk(_hw) container_of(_hw, struct sun9i_a80_cpus_clk, hw)
+
+static unsigned long sun9i_a80_cpus_clk_recalc_rate(struct clk_hw *hw,
+						    unsigned long parent_rate)
+{
+	struct sun9i_a80_cpus_clk *cpus = to_sun9i_a80_cpus_clk(hw);
+	unsigned long rate;
+	u32 reg;
+
+	/* Fetch the register value */
+	reg = readl(cpus->reg);
+
+	/* apply pre-divider first if parent is pll4 */
+	if (SUN9I_CPUS_MUX_GET_PARENT(reg) == SUN9I_CPUS_MUX_PARENT_PLL4)
+		parent_rate /= SUN9I_CPUS_PLL4_DIV_GET(reg) + 1;
+
+	/* clk divider */
+	rate = parent_rate / (SUN9I_CPUS_DIV_GET(reg) + 1);
+
+	return rate;
+}
+
+static long sun9i_a80_cpus_clk_round(unsigned long rate, u8 *divp, u8 *pre_divp,
+				     u8 parent, unsigned long parent_rate)
+{
+	u8 div, pre_div = 1;
+
+	/*
+	 * clock can only divide, so we will never be able to achieve
+	 * frequencies higher than the parent frequency
+	 */
+	if (parent_rate && rate > parent_rate)
+		rate = parent_rate;
+
+	div = DIV_ROUND_UP(parent_rate, rate);
+
+	/* calculate pre-divider if parent is pll4 */
+	if (parent == SUN9I_CPUS_MUX_PARENT_PLL4 && div > 4) {
+		/* pre-divider is 1 ~ 32 */
+		if (div < 32) {
+			pre_div = div;
+			div = 1;
+		} else if (div < 64) {
+			pre_div = DIV_ROUND_UP(div, 2);
+			div = 2;
+		} else if (div < 96) {
+			pre_div = DIV_ROUND_UP(div, 3);
+			div = 3;
+		} else {
+			pre_div = DIV_ROUND_UP(div, 4);
+			div = 4;
+		}
+	}
+
+	/* we were asked to pass back divider values */
+	if (divp) {
+		*divp = div - 1;
+		*pre_divp = pre_div - 1;
+	}
+
+	return parent_rate / pre_div / div;
+}
+
+static int sun9i_a80_cpus_clk_determine_rate(struct clk_hw *clk,
+					     struct clk_rate_request *req)
+{
+	struct clk_hw *parent, *best_parent = NULL;
+	int i, num_parents;
+	unsigned long parent_rate, best = 0, child_rate, best_child_rate = 0;
+	unsigned long rate = req->rate;
+
+	/* find the parent that can help provide the fastest rate <= rate */
+	num_parents = clk_hw_get_num_parents(clk);
+	for (i = 0; i < num_parents; i++) {
+		parent = clk_hw_get_parent_by_index(clk, i);
+		if (!parent)
+			continue;
+		if (clk_hw_get_flags(clk) & CLK_SET_RATE_PARENT)
+			parent_rate = clk_hw_round_rate(parent, rate);
+		else
+			parent_rate = clk_hw_get_rate(parent);
+
+		child_rate = sun9i_a80_cpus_clk_round(rate, NULL, NULL, i,
+						      parent_rate);
+
+		if (child_rate <= rate && child_rate > best_child_rate) {
+			best_parent = parent;
+			best = parent_rate;
+			best_child_rate = child_rate;
+		}
+	}
+
+	if (!best_parent)
+		return -EINVAL;
+
+	req->best_parent_hw = best_parent;
+	req->best_parent_rate = best;
+	req->rate = best_child_rate;
+
+	return 0;
+}
+
+static int sun9i_a80_cpus_clk_set_rate(struct clk_hw *hw, unsigned long rate,
+				       unsigned long parent_rate)
+{
+	struct sun9i_a80_cpus_clk *cpus = to_sun9i_a80_cpus_clk(hw);
+	unsigned long flags;
+	u8 div, pre_div, parent;
+	u32 reg;
+
+	spin_lock_irqsave(&sun9i_a80_cpus_lock, flags);
+
+	reg = readl(cpus->reg);
+
+	/* need to know which parent is used to apply pre-divider */
+	parent = SUN9I_CPUS_MUX_GET_PARENT(reg);
+	sun9i_a80_cpus_clk_round(rate, &div, &pre_div, parent, parent_rate);
+
+	reg = SUN9I_CPUS_DIV_SET(reg, div);
+	reg = SUN9I_CPUS_PLL4_DIV_SET(reg, pre_div);
+	writel(reg, cpus->reg);
+
+	spin_unlock_irqrestore(&sun9i_a80_cpus_lock, flags);
+
+	return 0;
+}
+
+static const struct clk_ops sun9i_a80_cpus_clk_ops = {
+	.determine_rate	= sun9i_a80_cpus_clk_determine_rate,
+	.recalc_rate	= sun9i_a80_cpus_clk_recalc_rate,
+	.set_rate	= sun9i_a80_cpus_clk_set_rate,
+};
+
+static void sun9i_a80_cpus_setup(struct device_node *node)
+{
+	const char *clk_name = node->name;
+	const char *parents[SUN9I_CPUS_MAX_PARENTS];
+	struct resource res;
+	struct sun9i_a80_cpus_clk *cpus;
+	struct clk_mux *mux;
+	struct clk *clk;
+	int ret;
+
+	cpus = kzalloc(sizeof(*cpus), GFP_KERNEL);
+	if (!cpus)
+		return;
+
+	cpus->reg = of_io_request_and_map(node, 0, of_node_full_name(node));
+	if (IS_ERR(cpus->reg))
+		goto err_free_cpus;
+
+	of_property_read_string(node, "clock-output-names", &clk_name);
+
+	/* we have a mux, we will have >1 parents */
+	ret = of_clk_parent_fill(node, parents, SUN9I_CPUS_MAX_PARENTS);
+
+	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
+	if (!mux)
+		goto err_unmap;
+
+	/* set up clock properties */
+	mux->reg = cpus->reg;
+	mux->shift = SUN9I_CPUS_MUX_SHIFT;
+	/* un-shifted mask is what mux_clk expects */
+	mux->mask = SUN9I_CPUS_MUX_MASK >> SUN9I_CPUS_MUX_SHIFT;
+	mux->lock = &sun9i_a80_cpus_lock;
+
+	clk = clk_register_composite(NULL, clk_name, parents, ret,
+				     &mux->hw, &clk_mux_ops,
+				     &cpus->hw, &sun9i_a80_cpus_clk_ops,
+				     NULL, NULL, 0);
+	if (IS_ERR(clk))
+		goto err_free_mux;
+
+	ret = of_clk_add_provider(node, of_clk_src_simple_get, clk);
+	if (ret)
+		goto err_unregister;
+
+	return;
+
+err_unregister:
+	clk_unregister(clk);
+err_free_mux:
+	kfree(mux);
+err_unmap:
+	iounmap(cpus->reg);
+	of_address_to_resource(node, 0, &res);
+	release_mem_region(res.start, resource_size(&res));
+err_free_cpus:
+	kfree(cpus);
+}
+CLK_OF_DECLARE(sun9i_a80_cpus, "allwinner,sun9i-a80-cpus-clk",
+	       sun9i_a80_cpus_setup);
-- 
2.6.2
