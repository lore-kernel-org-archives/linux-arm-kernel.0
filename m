From: wens@csie.org (Chen-Yu Tsai)
Date: Fri,  1 May 2015 00:10:03 +0800
Subject: [PATCH v2 2/5] clk: sunxi: support the cpus (cpu special) clock on
 the Allwinner A80
In-Reply-To: <1430410206-4410-1-git-send-email-wens@csie.org>
References: <1430410206-4410-1-git-send-email-wens@csie.org>
Message-ID: <1430410206-4410-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "cpus" clock is the clock for the embedded processor in the A80.
It is also part of the PRCM clock tree.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/clock/sunxi.txt |   1 +
 drivers/clk/sunxi/Makefile                        |   2 +-
 drivers/clk/sunxi/clk-sun9i-cpus.c                | 243 ++++++++++++++++++++++
 3 files changed, 245 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/sunxi/clk-sun9i-cpus.c

diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
index 2015b2beb957..c52735b0b924 100644
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
index 058f273d6154..f0f33131b048 100644
--- a/drivers/clk/sunxi/Makefile
+++ b/drivers/clk/sunxi/Makefile
@@ -13,4 +13,4 @@ obj-y += clk-usb.o
 
 obj-$(CONFIG_MFD_SUN6I_PRCM) += \
 	clk-sun6i-ar100.o clk-sun6i-apb0.o clk-sun6i-apb0-gates.o \
-	clk-sun8i-apb0.o
+	clk-sun8i-apb0.o clk-sun9i-cpus.o
diff --git a/drivers/clk/sunxi/clk-sun9i-cpus.c b/drivers/clk/sunxi/clk-sun9i-cpus.c
new file mode 100644
index 000000000000..1ec61ccf8cbf
--- /dev/null
+++ b/drivers/clk/sunxi/clk-sun9i-cpus.c
@@ -0,0 +1,243 @@
+/*
+ * Copyright (C) 2015 Chen-Yu Tsai
+ *
+ * Chen-Yu Tsai <wens@csie.org>
+ *
+ * Allwinner A80 CPUS clock driver
+ *
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
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
+/* un-shifted mask is what mux_clk expects */
+#define SUN9I_CPUS_MUX_MASK		0x3
+#define SUN9I_CPUS_MUX_GET_PARENT(reg)	((reg >> SUN9I_CPUS_MUX_SHIFT) & \
+					 SUN9I_CPUS_MUX_MASK)
+
+#define SUN9I_CPUS_DIV_SHIFT		4
+#define SUN9I_CPUS_DIV_MASK		(0x3 << SUN9I_CPUS_DIV_SHIFT)
+#define SUN9I_CPUS_DIV_GET(reg)		((reg & SUN9I_CPUS_DIV_MASK) >> \
+						SUN9I_CPUS_DIV_SHIFT)
+#define SUN9I_CPUS_DIV_SET(reg, div)	((reg & ~SUN9I_CPUS_DIV_MASK) | \
+						(div << SUN9I_CPUS_DIV_SHIFT))
+#define SUN9I_CPUS_PLL4_DIV_SHIFT	8
+#define SUN9I_CPUS_PLL4_DIV_MASK	(0x1f << SUN9I_CPUS_PLL4_DIV_SHIFT)
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
+						unsigned long parent_rate)
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
+				 u8 parent, unsigned long parent_rate)
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
+static long sun9i_a80_cpus_clk_determine_rate(struct clk_hw *hw,
+					      unsigned long rate,
+					      unsigned long min_rate,
+					      unsigned long max_rate,
+					      unsigned long *best_parent_rate,
+					      struct clk_hw **best_parent_clk)
+{
+	struct clk *clk = hw->clk, *parent, *best_parent = NULL;
+	int i, num_parents;
+	unsigned long parent_rate, best = 0, child_rate, best_child_rate = 0;
+
+	/* find the parent that can help provide the fastest rate <= rate */
+	num_parents = __clk_get_num_parents(clk);
+	for (i = 0; i < num_parents; i++) {
+		parent = clk_get_parent_by_index(clk, i);
+		if (!parent)
+			continue;
+		if (__clk_get_flags(clk) & CLK_SET_RATE_PARENT)
+			parent_rate = __clk_round_rate(parent, rate);
+		else
+			parent_rate = __clk_get_rate(parent);
+
+		child_rate = sun9i_a80_cpus_clk_round(rate, NULL, NULL, i,
+						  parent_rate);
+
+		if (child_rate <= rate && child_rate > best_child_rate) {
+			best_parent = parent;
+			best = parent_rate;
+			best_child_rate = child_rate;
+		}
+	}
+
+	if (best_parent)
+		*best_parent_clk = __clk_get_hw(best_parent);
+	*best_parent_rate = best;
+
+	return best_child_rate;
+}
+
+static int sun9i_a80_cpus_clk_set_rate(struct clk_hw *hw, unsigned long rate,
+				   unsigned long parent_rate)
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
+static int sun9i_a80_cpus_clk_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	const char *clk_name = np->name;
+	const char *parents[SUN9I_CPUS_MAX_PARENTS];
+	struct resource *r;
+	struct sun9i_a80_cpus_clk *cpus;
+	struct clk_mux *mux;
+	struct clk *clk;
+	int i = 0;
+
+	cpus = devm_kzalloc(&pdev->dev, sizeof(*cpus), GFP_KERNEL);
+	if (!cpus)
+		return -ENOMEM;
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	cpus->reg = devm_ioremap_resource(&pdev->dev, r);
+	if (IS_ERR(cpus->reg))
+		return PTR_ERR(cpus->reg);
+
+	/* we have a mux, we will have >1 parents */
+	while (i < SUN9I_CPUS_MAX_PARENTS &&
+	       (parents[i] = of_clk_get_parent_name(np, i)) != NULL)
+		i++;
+
+	of_property_read_string(np, "clock-output-names", &clk_name);
+
+	mux = devm_kzalloc(&pdev->dev, sizeof(*mux), GFP_KERNEL);
+	if (!mux)
+		return -ENOMEM;
+
+	/* set up clock properties */
+	mux->reg = cpus->reg;
+	mux->shift = SUN9I_CPUS_MUX_SHIFT;
+	mux->mask = SUN9I_CPUS_MUX_MASK;
+	mux->lock = &sun9i_a80_cpus_lock;
+
+	clk = clk_register_composite(NULL, clk_name, parents, i,
+				     &mux->hw, &clk_mux_ops,
+				     &cpus->hw, &sun9i_a80_cpus_clk_ops,
+				     NULL, NULL, 0);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	return of_clk_add_provider(np, of_clk_src_simple_get, clk);
+}
+
+static const struct of_device_id sun9i_a80_cpus_clk_dt_ids[] = {
+	{ .compatible = "allwinner,sun9i-a80-cpus-clk" },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver sun9i_a80_cpus_clk_driver = {
+	.driver = {
+		.name = "sun9i-a80-cpus-clk",
+		.of_match_table = sun9i_a80_cpus_clk_dt_ids,
+	},
+	.probe = sun9i_a80_cpus_clk_probe,
+};
+module_platform_driver(sun9i_a80_cpus_clk_driver);
+
+MODULE_AUTHOR("Chen-Yu Tsai <wens@csie.org>");
+MODULE_DESCRIPTION("Allwinner A80 CPUS Clock Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.1.4
