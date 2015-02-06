From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Fri,  6 Feb 2015 19:27:45 +0530
Subject: [PATCH v2 2/3] clk: samsung: add cpu clock support for Exynos7
In-Reply-To: <1423231066-7341-1-git-send-email-a.kesavan@samsung.com>
References: <1423231066-7341-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1423231066-7341-3-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The divider and mux register offsets and bits are different on
Exynos7 from the older SoCs. Add new pre/post rate change callbacks
for Exynos7 to handle these differences. To do this:
	- Add a new exynos_cpuclk_soc_data structure that will hold
	the SoC-specific pre/post rate change call-backs
	- Modify exynos_register_cpu_clock() prototype to include a
	node pointer

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 drivers/clk/samsung/clk-cpu.c        |  147 +++++++++++++++++++++++++++++++++-
 drivers/clk/samsung/clk-cpu.h        |   33 +++++++-
 drivers/clk/samsung/clk-exynos4.c    |    2 +-
 drivers/clk/samsung/clk-exynos5250.c |    2 +-
 drivers/clk/samsung/clk-exynos5420.c |    4 +-
 5 files changed, 180 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/samsung/clk-cpu.c b/drivers/clk/samsung/clk-cpu.c
index 009a21b..7cccc43 100644
--- a/drivers/clk/samsung/clk-cpu.c
+++ b/drivers/clk/samsung/clk-cpu.c
@@ -51,6 +51,13 @@
 #define DIV_MASK_ALL		0xffffffff
 #define MUX_MASK		7
 
+#define EXYNOS7_SRC_CPU		0x208
+#define EXYNOS7_STAT_CPU	0x408
+#define EXYNOS7_DIV_CPU0	0x600
+#define EXYNOS7_DIV_CPU1	0x604
+#define EXYNOS7_DIV_STAT_CPU0	0x700
+#define EXYNOS7_DIV_STAT_CPU1	0x704
+
 /*
  * Helper function to wait until divider(s) have stabilized after the divider
  * value has changed.
@@ -232,6 +239,105 @@ static int exynos_cpuclk_post_rate_change(struct clk_notifier_data *ndata,
 	return 0;
 }
 
+/* Exynos7 helper function to set the 'safe' dividers for the CPU clock. The
+ * parameters div and mask contain the divider value and the register bit mask
+ * of the dividers to be programmed.
+ */
+static void exynos7_set_safe_div(void __iomem *base, unsigned long div,
+					unsigned long mask)
+{
+	unsigned long div1;
+
+	div1 = readl(base + EXYNOS7_DIV_CPU1);
+	div1 = (div1 & ~mask) | (div & mask);
+	writel(div1, base + EXYNOS7_DIV_CPU1);
+	wait_until_divider_stable(base + EXYNOS7_DIV_STAT_CPU1, mask);
+}
+
+/* Exynos7 handler for pre-rate change notification from parent clock */
+static int exynos7_cpuclk_pre_rate_change(struct clk_notifier_data *ndata,
+			struct exynos_cpuclk *cpuclk, void __iomem *base)
+{
+	const struct exynos_cpuclk_cfg_data *cfg_data = cpuclk->cfg;
+	unsigned long alt_prate = clk_get_rate(cpuclk->alt_parent);
+	unsigned long alt_div = 0, alt_div_mask = DIV_MASK;
+	unsigned long div0, div1 = 0, mux_reg;
+
+	/* find out the divider values to use for clock data */
+	while ((cfg_data->prate * 1000) != ndata->new_rate) {
+		if (cfg_data->prate == 0)
+			return -EINVAL;
+		cfg_data++;
+	}
+
+	spin_lock(cpuclk->lock);
+
+	div0 = cfg_data->div0;
+	div1 = cfg_data->div1;
+
+	/*
+	 * If the new and old parent clock speed is less than the clock speed
+	 * of the alternate parent, then it should be ensured that at no point
+	 * the armclk speed is more than the old_prate until the dividers are
+	 * set.
+	 */
+	if (alt_prate > ndata->old_rate) {
+		alt_div =  DIV_ROUND_UP(alt_prate, ndata->old_rate) - 1;
+		WARN_ON(alt_div >= MAX_DIV);
+		alt_div |= E4210_DIV1_HPM_MASK;
+		alt_div_mask |= E4210_DIV1_HPM_MASK;
+
+		exynos7_set_safe_div(base, alt_div, alt_div_mask);
+		div1 |= alt_div;
+	}
+
+	/* select mout_bus0_pll_atlas as the alternate parent */
+	mux_reg = readl(base + EXYNOS7_SRC_CPU);
+	writel(mux_reg | (1 << 0), base + EXYNOS7_SRC_CPU);
+	wait_until_mux_stable(base + EXYNOS7_STAT_CPU, 0, 1);
+
+	/* alternate parent is active now. set the dividers */
+	writel(div0, base + EXYNOS7_DIV_CPU0);
+	wait_until_divider_stable(base + EXYNOS7_DIV_STAT_CPU0, DIV_MASK_ALL);
+
+	writel(div1, base + EXYNOS7_DIV_CPU1);
+	wait_until_divider_stable(base + EXYNOS7_DIV_STAT_CPU1,
+			DIV_MASK_ALL);
+
+	spin_unlock(cpuclk->lock);
+	return 0;
+}
+
+/* Exynos7 handler for post-rate change notification from parent clock */
+static int exynos7_cpuclk_post_rate_change(struct clk_notifier_data *ndata,
+			struct exynos_cpuclk *cpuclk, void __iomem *base)
+{
+	const struct exynos_cpuclk_cfg_data *cfg_data = cpuclk->cfg;
+	unsigned long div = 0, div_mask = DIV_MASK;
+	unsigned long mux_reg;
+
+	spin_lock(cpuclk->lock);
+
+	/* select mout_atlas_pll as the alternate parent */
+	mux_reg = readl(base + EXYNOS7_SRC_CPU);
+	writel(mux_reg & ~(1 << 0), base + EXYNOS7_SRC_CPU);
+	wait_until_mux_stable(base + EXYNOS7_STAT_CPU, 0, 0);
+
+	/* find out the divider values to use for clock data */
+	while ((cfg_data->prate * 1000) != ndata->new_rate) {
+		if (cfg_data->prate == 0)
+			return -EINVAL;
+		cfg_data++;
+	}
+
+	div |= (cfg_data->div1 & E4210_DIV1_HPM_MASK);
+	div_mask |= E4210_DIV1_HPM_MASK;
+
+	exynos7_set_safe_div(base, div, div_mask);
+	spin_unlock(cpuclk->lock);
+	return 0;
+}
+
 /*
  * This notifier function is called for the pre-rate and post-rate change
  * notifications of the parent clock of cpuclk.
@@ -248,25 +354,58 @@ static int exynos_cpuclk_notifier_cb(struct notifier_block *nb,
 	base = cpuclk->ctrl_base;
 
 	if (event == PRE_RATE_CHANGE)
-		err = exynos_cpuclk_pre_rate_change(ndata, cpuclk, base);
+		err = cpuclk->pre_rate_cb(ndata, cpuclk, base);
 	else if (event == POST_RATE_CHANGE)
-		err = exynos_cpuclk_post_rate_change(ndata, cpuclk, base);
+		err = cpuclk->post_rate_cb(ndata, cpuclk, base);
 
 	return notifier_from_errno(err);
 }
 
+static const struct exynos_cpuclk_soc_data e4210_clk_soc_data __initconst = {
+	.pre_rate_cb = exynos_cpuclk_pre_rate_change,
+	.post_rate_cb = exynos_cpuclk_post_rate_change,
+};
+
+static const struct exynos_cpuclk_soc_data e7_clk_soc_data __initconst = {
+	.pre_rate_cb = exynos7_cpuclk_pre_rate_change,
+	.post_rate_cb = exynos7_cpuclk_post_rate_change,
+};
+
+static const struct of_device_id exynos_cpuclk_ids[] __initconst = {
+	{ .compatible = "samsung,exynos4210-clock",
+			.data = &e4210_clk_soc_data, },
+	{ .compatible = "samsung,exynos5250-clock",
+			.data = &e4210_clk_soc_data, },
+	{ .compatible = "samsung,exynos5420-clock",
+			.data = &e4210_clk_soc_data, },
+	{ .compatible = "samsung,exynos7-clock-atlas",
+			.data = &e7_clk_soc_data, },
+	{ },
+};
+
 /* helper function to register a CPU clock */
 int __init exynos_register_cpu_clock(struct samsung_clk_provider *ctx,
 		unsigned int lookup_id, const char *name, const char *parent,
 		const char *alt_parent, unsigned long offset,
 		const struct exynos_cpuclk_cfg_data *cfg,
-		unsigned long num_cfgs, unsigned long flags)
+		unsigned long num_cfgs, unsigned long flags,
+		struct device_node *np)
 {
+	const struct of_device_id *match;
+	const struct exynos_cpuclk_soc_data *data = NULL;
 	struct exynos_cpuclk *cpuclk;
 	struct clk_init_data init;
 	struct clk *clk;
 	int ret = 0;
 
+	if (!np)
+		return -EINVAL;
+
+	match = of_match_node(exynos_cpuclk_ids, np);
+	if (!match)
+		return -EINVAL;
+	data = match->data;
+
 	cpuclk = kzalloc(sizeof(*cpuclk), GFP_KERNEL);
 	if (!cpuclk)
 		return -ENOMEM;
@@ -281,6 +420,8 @@ int __init exynos_register_cpu_clock(struct samsung_clk_provider *ctx,
 	cpuclk->ctrl_base = ctx->reg_base + offset;
 	cpuclk->lock = &ctx->lock;
 	cpuclk->flags = flags;
+	cpuclk->pre_rate_cb = data->pre_rate_cb;
+	cpuclk->post_rate_cb = data->post_rate_cb;
 	cpuclk->clk_nb.notifier_call = exynos_cpuclk_notifier_cb;
 
 	cpuclk->alt_parent = __clk_lookup(alt_parent);
diff --git a/drivers/clk/samsung/clk-cpu.h b/drivers/clk/samsung/clk-cpu.h
index 42e1905..24e844e 100644
--- a/drivers/clk/samsung/clk-cpu.h
+++ b/drivers/clk/samsung/clk-cpu.h
@@ -60,6 +60,10 @@ struct exynos_cpuclk_cfg_data {
  * @num_cfgs: number of array elements in @cfg array.
  * @clk_nb: clock notifier registered for changes in clock speed of the
  *	primary parent clock.
+ * @pre_rate_cb: callback function to handle PRE_RATE_CHANGE notification
+ *	of the primary parent clock.
+ * @post_rate_cb: callback function to handle POST_RATE_CHANGE notification
+ *	of the primary parent clock.
  * @flags: configuration flags for the CPU clock.
  *
  * This structure holds information required for programming the CPU clock for
@@ -73,6 +77,12 @@ struct exynos_cpuclk {
 	const struct exynos_cpuclk_cfg_data	*cfg;
 	const unsigned long			num_cfgs;
 	struct notifier_block			clk_nb;
+	int			(*pre_rate_cb)(struct clk_notifier_data *,
+					struct exynos_cpuclk *,
+					void __iomem *base);
+	int			(*post_rate_cb)(struct clk_notifier_data *,
+					struct exynos_cpuclk *,
+					void __iomem *base);
 	unsigned long				flags;
 
 /* The CPU clock registers has DIV1 configuration register */
@@ -81,11 +91,32 @@ struct exynos_cpuclk {
 #define CLK_CPU_NEEDS_DEBUG_ALT_DIV	(1 << 1)
 };
 
+/**
+ * struct exynos_cpuclk_soc_data: soc specific data for cpu clocks.
+ * @pre_rate_cb: callback function to handle PRE_RATE_CHANGE notification
+ *	of the primary parent clock.
+ * @post_rate_cb: callback function to handle POST_RATE_CHANGE notification
+ *	of the primary parent clock.
+ *
+ * This structure provides SoC specific data for CPU clocks. Based on
+ * the compatible value of the clock controller node, the value of the
+ * fields in this structure can be populated.
+ */
+struct exynos_cpuclk_soc_data {
+	int			(*pre_rate_cb)(struct clk_notifier_data *,
+					struct exynos_cpuclk *,
+					void __iomem *base);
+	int			(*post_rate_cb)(struct clk_notifier_data *,
+					struct exynos_cpuclk *,
+					void __iomem *base);
+};
+
 extern int __init exynos_register_cpu_clock(struct samsung_clk_provider *ctx,
 			unsigned int lookup_id, const char *name,
 			const char *parent, const char *alt_parent,
 			unsigned long offset,
 			const struct exynos_cpuclk_cfg_data *cfg,
-			unsigned long num_cfgs, unsigned long flags);
+			unsigned long num_cfgs, unsigned long flags,
+			struct device_node *np);
 
 #endif /* __SAMSUNG_CLK_CPU_H */
diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 5fb4ab1..29655a4 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -1473,7 +1473,7 @@ static void __init exynos4_clk_init(struct device_node *np,
 		exynos_register_cpu_clock(ctx, CLK_ARM_CLK, "armclk",
 			mout_core_p4210[0], mout_core_p4210[1], 0x14200,
 			e4210_armclk_d, ARRAY_SIZE(e4210_armclk_d),
-			CLK_CPU_NEEDS_DEBUG_ALT_DIV | CLK_CPU_HAS_DIV1);
+			CLK_CPU_NEEDS_DEBUG_ALT_DIV | CLK_CPU_HAS_DIV1, np);
 	} else {
 		samsung_clk_register_mux(ctx, exynos4x12_mux_clks,
 			ARRAY_SIZE(exynos4x12_mux_clks));
diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index 1d958f1..56b4147b 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -824,7 +824,7 @@ static void __init exynos5250_clk_init(struct device_node *np)
 	exynos_register_cpu_clock(ctx, CLK_ARM_CLK, "armclk",
 			mout_cpu_p[0], mout_cpu_p[1], 0x200,
 			exynos5250_armclk_d, ARRAY_SIZE(exynos5250_armclk_d),
-			CLK_CPU_HAS_DIV1);
+			CLK_CPU_HAS_DIV1, np);
 
 	/*
 	 * Enable arm clock down (in idle) and set arm divider
diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 44c1df8..c95be96 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -1359,10 +1359,10 @@ static void __init exynos5x_clk_init(struct device_node *np,
 
 	exynos_register_cpu_clock(ctx, CLK_ARM_CLK, "armclk",
 		mout_cpu_p[0], mout_cpu_p[1], 0x200,
-		exynos5420_eglclk_d, ARRAY_SIZE(exynos5420_eglclk_d), 0);
+		exynos5420_eglclk_d, ARRAY_SIZE(exynos5420_eglclk_d), 0, np);
 	exynos_register_cpu_clock(ctx, CLK_KFC_CLK, "kfcclk",
 		mout_kfc_p[0], mout_kfc_p[1], 0x28200,
-		exynos5420_kfcclk_d, ARRAY_SIZE(exynos5420_kfcclk_d), 0);
+		exynos5420_kfcclk_d, ARRAY_SIZE(exynos5420_kfcclk_d), 0, np);
 
 	exynos5420_clk_sleep_init();
 
-- 
1.7.9.5
