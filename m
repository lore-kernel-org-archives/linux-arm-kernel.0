From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Tue, 12 Mar 2013 01:44:50 +0100
Subject: [PATCH 5/7] DO_NOT_APPLY: add clock driver for Samsung pwm clocks
In-Reply-To: <201303120141.31262.heiko@sntech.de>
References: <201303120141.31262.heiko@sntech.de>
Message-ID: <201303120144.50354.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This ports the pwm-clock code from plat-samsung to the common clock
framework to make available the pwm clocks used by samsung-time and
the samsung pwm driver.

This is needed to enable the usage of the samsung-time clocksource
when using the common clock framework on s3c arches but the correct
solution will be in the upcoming time/pwm driver which will handle
the pwm clocks itself.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/samsung/Makefile  |    2 +-
 drivers/clk/samsung/clk-pwm.c |  554 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 555 insertions(+), 1 deletions(-)
 create mode 100644 drivers/clk/samsung/clk-pwm.c

diff --git a/drivers/clk/samsung/Makefile b/drivers/clk/samsung/Makefile
index 7462ec5..0f227c3 100644
--- a/drivers/clk/samsung/Makefile
+++ b/drivers/clk/samsung/Makefile
@@ -6,4 +6,4 @@ obj-$(CONFIG_COMMON_CLK)	+= clk.o clk-pll.o
 obj-$(CONFIG_ARCH_EXYNOS4)	+= clk-exynos4.o
 obj-$(CONFIG_SOC_EXYNOS5250)	+= clk-exynos5250.o
 obj-$(CONFIG_SOC_EXYNOS5440)	+= clk-exynos5440.o
-obj-$(CONFIG_S3C2443_COMMON)	+= clk-s3c2443.o
+obj-$(CONFIG_S3C2443_COMMON)	+= clk-s3c2443.o clk-pwm.o
diff --git a/drivers/clk/samsung/clk-pwm.c b/drivers/clk/samsung/clk-pwm.c
new file mode 100644
index 0000000..19142e8
--- /dev/null
+++ b/drivers/clk/samsung/clk-pwm.c
@@ -0,0 +1,554 @@
+/*
+ * Copyright (c) 2007 Simtec Electronics
+ * Copyright (c) 2007, 2008 Ben Dooks
+ *	Ben Dooks <ben-linux@fluff.org>
+ * Copyright (c) 2013 Heiko Stuebner <heiko@sntech.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License.
+ *
+ * Common Clock Framework support for Samsung pwm clocks
+*/
+
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/syscore_ops.h>
+#include <linux/io.h>
+
+#include <plat/cpu.h>
+#include <mach/map.h>
+
+#include "clk.h"
+
+/* Each of the timers 0 through 5 go through the following
+ * clock tree, with the inputs depending on the timers.
+ *
+ * pclk ---- [ prescaler 0 ] -+---> timer 0
+ *			      +---> timer 1
+ *
+ * pclk ---- [ prescaler 1 ] -+---> timer 2
+ *			      +---> timer 3
+ *			      \---> timer 4
+ *
+ * Which are fed into the timers as so:
+ *
+ * prescaled 0 ---- [ div 2,4,8,16 ] ---\
+ *				       [mux] -> timer 0
+ * tclk 0 ------------------------------/
+ *
+ * prescaled 0 ---- [ div 2,4,8,16 ] ---\
+ *				       [mux] -> timer 1
+ * tclk 0 ------------------------------/
+ *
+ *
+ * prescaled 1 ---- [ div 2,4,8,16 ] ---\
+ *				       [mux] -> timer 2
+ * tclk 1 ------------------------------/
+ *
+ * prescaled 1 ---- [ div 2,4,8,16 ] ---\
+ *				       [mux] -> timer 3
+ * tclk 1 ------------------------------/
+ *
+ * prescaled 1 ---- [ div 2,4,8, 16 ] --\
+ *				       [mux] -> timer 4
+ * tclk 1 ------------------------------/
+ *
+ * Since the mux and the divider are tied together in the
+ * same register space, it is impossible to set the parent
+ * and the rate at the same time. To avoid this, we add an
+ * intermediate 'prescaled-and-divided' clock to select
+ * as the parent for the timer input clock called tdiv.
+ *
+ * prescaled clk --> pwm-tdiv ---\
+ *                             [ mux ] --> timer X
+ * tclk -------------------------/
+*/
+
+enum pwm_clks {
+	none,
+
+	tclk0, tclk1, tdiv0, tdiv1, tdiv2, tdiv3, tdiv4,
+	tin0, tin1, tin2, tin3, tin4,
+
+	nr_clks,
+};
+
+/* the soc types */
+enum supported_socs {
+	S3C24XX,
+	S3C64XX, /* also S5PC100 */
+	S5P64XX,
+};
+
+/* clock controller register offsets */
+#define TCFG0	0
+#define TCFG1	0x4
+
+static DEFINE_SPINLOCK(lock);
+static int current_soc;
+static void __iomem *reg_base;
+static struct clk **clk_table;
+#ifdef CONFIG_OF
+static struct clk_onecell_data clk_data;
+#endif
+
+#ifdef CONFIG_PM_SLEEP
+static struct samsung_clk_reg_dump reg_dump[2] = {
+	{ .offset = TCFG0 },
+	{ .offset = TCFG1 },
+};
+
+static int samsung_clk_pwm_suspend(void)
+{
+	reg_dump[0].value = readl_relaxed(reg_base + reg_dump[0].offset);
+	reg_dump[1].value = readl_relaxed(reg_base + reg_dump[1].offset);
+	return 0;
+}
+
+static void samsung_clk_pwm_resume(void)
+{
+	writel_relaxed(reg_dump[0].value, reg_base + reg_dump[0].offset);
+	writel_relaxed(reg_dump[1].value, reg_base + reg_dump[1].offset);
+}
+
+static struct syscore_ops samsung_clk_pwm_syscore_ops = {
+	.suspend	= samsung_clk_pwm_suspend,
+	.resume		= samsung_clk_pwm_resume,
+};
+#endif /* CONFIG_PM_SLEEP */
+
+#define S3C2410_TCFG1_MUX_TCLK    (4 << 0)
+#define S3C64XX_TCFG1_MUX_TCLK    (5 << 0)
+
+/**
+ * pwm_cfg_src_is_tclk() - return whether the given mux config is a tclk
+ * @tcfg: The timer TCFG1 register bits shifted down to 0.
+ *
+ * Return true if the given configuration from TCFG1 is a TCLK instead
+ * any of the TDIV clocks.
+ */
+static inline int pwm_cfg_src_is_tclk(unsigned long tcfg)
+{
+	if (current_soc == S3C24XX)
+		return tcfg == S3C2410_TCFG1_MUX_TCLK;
+	else if (current_soc == S3C64XX)
+		return tcfg >= S3C64XX_TCFG1_MUX_TCLK;
+	else if (current_soc == S5P64XX)
+		return 0;
+	else
+		return tcfg == S3C64XX_TCFG1_MUX_TCLK;
+}
+
+struct clk_tdiv {
+	struct clk_divider	divider;
+	const struct clk_ops	*ops;
+	void __iomem		*reg;
+	unsigned int		divisor;
+};
+
+static inline struct clk_tdiv *to_clk_tdiv(struct clk_hw *hw)
+{
+	struct clk_divider *divider = container_of(hw, struct clk_divider, hw);
+
+	return container_of(divider, struct clk_tdiv, divider);
+}
+
+static unsigned long clk_tdiv_recalc_rate(struct clk_hw *hw,
+					 unsigned long parent_rate)
+{
+	struct clk_tdiv *tdiv = to_clk_tdiv(hw);
+	unsigned long tcfg1 = readl_relaxed(tdiv->reg);
+
+	tcfg1 >>= tdiv->divider.shift;
+	tcfg1 &= ((1 << (tdiv->divider.width)) - 1);
+
+	if (pwm_cfg_src_is_tclk(tcfg1))
+		return parent_rate / tdiv->divisor;
+	else
+		return tdiv->ops->recalc_rate(&tdiv->divider.hw, parent_rate);
+
+}
+
+static long clk_tdiv_round_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long *parent_rate)
+{
+	struct clk_tdiv *tdiv = to_clk_tdiv(hw);
+
+	return tdiv->ops->round_rate(&tdiv->divider.hw, rate, parent_rate);
+}
+
+static int clk_tdiv_set_rate(struct clk_hw *hw, unsigned long rate,
+			    unsigned long parent_rate)
+{
+	struct clk_tdiv *tdiv = to_clk_tdiv(hw);
+	unsigned long tcfg1 = readl_relaxed(tdiv->reg);
+	unsigned long divisor;
+	int ret = 0;
+
+	tcfg1 >>= tdiv->divider.shift;
+	tcfg1 &= ((1 << (tdiv->divider.width)) - 1);
+
+	rate = tdiv->ops->round_rate(&tdiv->divider.hw, rate, &parent_rate);
+	divisor = parent_rate / rate;
+
+	if (divisor > 16)
+		return -EINVAL;
+
+	tdiv->divisor = divisor;
+
+	/* Update the current MUX settings if we are currently
+	 * selected as the clock source for this clock. */
+
+	if (!pwm_cfg_src_is_tclk(tcfg1))
+		ret = tdiv->ops->set_rate(&tdiv->divider.hw, rate, parent_rate);
+
+	return ret;
+}
+
+static struct clk_ops clk_tdiv_ops = {
+	.recalc_rate = clk_tdiv_recalc_rate,
+	.round_rate = clk_tdiv_round_rate,
+	.set_rate = clk_tdiv_set_rate,
+};
+
+static struct clk *samsung_clk_register_tdiv(const char *name,
+		const char *parent_name, unsigned long flags,
+		void __iomem *reg, u8 shift,
+		u8 clk_divider_flags, const struct clk_div_table *table)
+{
+	unsigned long tcfg1;
+	const struct clk_div_table *clkt;
+	struct clk_tdiv *tdiv;
+	struct clk *clk;
+	struct clk_init_data init;
+
+	tdiv = kzalloc(sizeof(struct clk_tdiv), GFP_KERNEL);
+	if (!tdiv)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &clk_tdiv_ops;
+	init.flags = flags;
+	init.parent_names = (parent_name ? &parent_name : NULL);
+	init.num_parents = (parent_name ? 1 : 0);
+
+	/* struct clk_divider assignments */
+	tdiv->divider.reg = reg;
+	tdiv->divider.shift = shift;
+	tdiv->divider.width = 4;
+	tdiv->divider.flags = clk_divider_flags;
+	tdiv->divider.lock = &lock;
+	tdiv->divider.hw.init = &init;
+	tdiv->divider.table = table;
+	tdiv->ops = &clk_divider_ops;
+
+	tcfg1 = readl_relaxed(reg);
+	tcfg1 >>= tdiv->divider.shift;
+	tcfg1 &= ((1 << (tdiv->divider.width)) - 1);
+
+	tdiv->reg = reg;
+
+	tdiv->divisor = 1;
+	for (clkt = table; clkt->div; clkt++)
+		if (clkt->val == tcfg1)
+			tdiv->divisor = clkt->div;
+
+	clk = clk_register(NULL, &tdiv->divider.hw);
+	if (IS_ERR(clk))
+		kfree(tdiv);
+
+	return clk;
+}
+
+struct clk_tin {
+	struct clk_hw	hw;
+	void __iomem	*reg;
+	u8		shift;
+	u8		width;
+	spinlock_t	*lock;
+};
+
+#define to_clk_tin(_hw) container_of(_hw, struct clk_tin, hw)
+
+static u8 clk_tin_get_parent(struct clk_hw *hw)
+{
+	struct clk_tin *tin = to_clk_tin(hw);
+	unsigned long tcfg1 = readl_relaxed(tin->reg);
+
+	tcfg1 >>= tin->shift;
+	tcfg1 &= ((1 << (tin->width)) - 1);
+
+	/* assume tclk is parent 0 and tdiv is parent 1 */
+	return pwm_cfg_src_is_tclk(tcfg1) ? 0 : 1;
+}
+
+static int clk_tin_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct clk_tin *tin = to_clk_tin(hw);
+	struct clk *tdiv;
+	struct clk *prescaler;
+	unsigned long tcfg1;
+	unsigned long flags = 0;
+	unsigned long div;
+	int bits;
+
+	switch (index) {
+	case 0:
+		if (current_soc == S3C24XX)
+			bits = S3C2410_TCFG1_MUX_TCLK << tin->shift;
+		else if (current_soc == S5P64XX)
+			bits = 0;
+		else
+			bits = S3C64XX_TCFG1_MUX_TCLK << tin->shift;
+		break;
+	case 1:
+		tdiv = clk_get(NULL, hw->init->parent_names[0]);
+
+		prescaler = clk_get_parent(tdiv);
+		div = clk_get_rate(prescaler) / clk_get_rate(tdiv);
+
+		bits = (current_soc == S3C24XX) ? (ilog2(div) - 1) : ilog2(div);
+		bits &= ((1 << (tin->width)) - 1);
+		bits <<= tin->shift;
+
+		clk_put(tdiv);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(tin->lock, flags);
+
+	tcfg1 = readl_relaxed(tin->reg);
+	tcfg1 &= ~(((1 << tin->width) - 1) << tin->shift);
+	tcfg1 |= bits;
+	writel_relaxed(tcfg1, tin->reg);
+
+	spin_unlock_irqrestore(tin->lock, flags);
+
+	return 0;
+}
+
+static const struct clk_ops clk_tin_ops = {
+	.get_parent = clk_tin_get_parent,
+	.set_parent = clk_tin_set_parent,
+};
+
+static struct clk *samsung_clk_register_tin(const char *name,
+		const char **parent_names, u8 num_parents,
+		void __iomem *reg, u8 shift, u8 width)
+{
+	struct clk_tin *tin;
+	struct clk *clk;
+	struct clk_init_data init;
+
+	/* allocate the mux */
+	tin = kzalloc(sizeof(struct clk_tin), GFP_KERNEL);
+	if (!tin) {
+		pr_err("%s: could not allocate tin clk\n", __func__);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	init.name = name;
+	init.ops = &clk_tin_ops;
+	init.parent_names = parent_names;
+	init.num_parents = num_parents;
+
+	/* struct clk_mux assignments */
+	tin->reg = reg;
+	tin->shift = shift;
+	tin->width = width;
+	tin->lock = &lock;
+	tin->hw.init = &init;
+
+	clk = clk_register(NULL, &tin->hw);
+
+	if (IS_ERR(clk))
+		kfree(tin);
+
+	return clk;
+}
+
+
+PNAME(tin0_p) = { "pwm-tclk0", "pwm-tdiv0" };
+PNAME(tin1_p) = { "pwm-tclk0", "pwm-tdiv1" };
+PNAME(tin2_p) = { "pwm-tclk1", "pwm-tdiv2" };
+PNAME(tin3_p) = { "pwm-tclk1", "pwm-tdiv3" };
+PNAME(tin4_p) = { "pwm-tclk1", "pwm-tdiv4" };
+
+static struct clk_div_table tdiv_s3c24xx_d[] = {
+	{ .val = 0, .div = 2 },
+	{ .val = 1, .div = 4 },
+	{ .val = 2, .div = 8 },
+	{ .val = 3, .div = 16 },
+	{ .div = 0 },
+};
+struct samsung_div_clock pwm_s3c24xx_tdiv_dividers[] __initdata = {
+	DIV_T(tdiv0, "pwm-tdiv0", "pwm-scaler0", TCFG1, 0, 4, tdiv_s3c24xx_d),
+	DIV_T(tdiv1, "pwm-tdiv1", "pwm-scaler0", TCFG1, 4, 4, tdiv_s3c24xx_d),
+	DIV_T(tdiv2, "pwm-tdiv2", "pwm-scaler1", TCFG1, 8, 4, tdiv_s3c24xx_d),
+	DIV_T(tdiv3, "pwm-tdiv3", "pwm-scaler1", TCFG1, 12, 4, tdiv_s3c24xx_d),
+	DIV_T(tdiv4, "pwm-tdiv4", "pwm-scaler1", TCFG1, 16, 4, tdiv_s3c24xx_d),
+};
+
+static struct clk_div_table tdiv_s3c64xx_d[] = {
+	{ .val = 0, .div = 1 },
+	{ .val = 1, .div = 2 },
+	{ .val = 2, .div = 4 },
+	{ .val = 3, .div = 8 },
+	{ .val = 4, .div = 16 },
+	{ .div = 0 },
+};
+struct samsung_div_clock pwm_s3c64xx_tdiv_dividers[] __initdata = {
+	DIV_T(tdiv0, "pwm-tdiv0", "pwm-scaler0", TCFG1, 0, 4, tdiv_s3c64xx_d),
+	DIV_T(tdiv1, "pwm-tdiv1", "pwm-scaler0", TCFG1, 4, 4, tdiv_s3c64xx_d),
+	DIV_T(tdiv2, "pwm-tdiv2", "pwm-scaler1", TCFG1, 8, 4, tdiv_s3c64xx_d),
+	DIV_T(tdiv3, "pwm-tdiv3", "pwm-scaler1", TCFG1, 12, 4, tdiv_s3c64xx_d),
+	DIV_T(tdiv4, "pwm-tdiv4", "pwm-scaler1", TCFG1, 16, 4, tdiv_s3c64xx_d),
+};
+
+struct samsung_mux_clock pwm_tin[] __initdata = {
+	MUX(tin0, "pwm-tin0", tin0_p, TCFG1, 0, 4),
+	MUX(tin1, "pwm-tin1", tin1_p, TCFG1, 4, 4),
+	MUX(tin2, "pwm-tin2", tin2_p, TCFG1, 8, 4),
+	MUX(tin3, "pwm-tin3", tin3_p, TCFG1, 12, 4),
+	MUX(tin4, "pwm-tin4", tin4_p, TCFG1, 16, 4),
+};
+
+struct samsung_clock_alias pwm_aliases[] __initdata = {
+	ALIAS(tdiv0, "s3c24xx-pwm.0", "pwm-tdiv"),
+	ALIAS(tdiv1, "s3c24xx-pwm.1", "pwm-tdiv"),
+	ALIAS(tdiv2, "s3c24xx-pwm.2", "pwm-tdiv"),
+	ALIAS(tdiv3, "s3c24xx-pwm.3", "pwm-tdiv"),
+	ALIAS(tdiv4, "s3c24xx-pwm.4", "pwm-tdiv"),
+	ALIAS(tin0, "s3c24xx-pwm.0", "pwm-tin"),
+	ALIAS(tin1, "s3c24xx-pwm.1", "pwm-tin"),
+	ALIAS(tin2, "s3c24xx-pwm.2", "pwm-tin"),
+	ALIAS(tin3, "s3c24xx-pwm.3", "pwm-tin"),
+	ALIAS(tin4, "s3c24xx-pwm.4", "pwm-tin"),
+};
+
+
+#ifdef CONFIG_OF
+static struct of_device_id pwm_clk_ids[] __initdata = {
+	{ .compatible = "samsung,s3c24xx-clock-pwm",
+			.data = (void *)S3C24XX, },
+	{ .compatible = "samsung,s3c64xx-clock-pwm",
+			.data = (void *)S3C64XX, },
+	{ .compatible = "samsung,s5p64xx-clock-pwm",
+			.data = (void *)S5P64XX, },
+	{ },
+};
+#endif
+
+
+void __init samsung_pwm_clk_init(struct device_node *np)
+{
+	struct clk *clk;
+	struct samsung_div_clock *tdiv_list;
+	struct samsung_mux_clock *tin_list;
+	struct samsung_clock_alias *alias_list;
+	unsigned int idx;
+	int ret;
+
+	if (np) {
+		const struct of_device_id *match;
+		match = of_match_node(pwm_clk_ids, np);
+		current_soc = (u32)match->data;
+
+		reg_base = of_iomap(np, 0);
+		if (!reg_base)
+			panic("%s: failed to map registers\n", __func__);
+	} else {
+		reg_base = S3C_VA_TIMER;
+		if (soc_is_s3c24xx())
+			current_soc = S3C24XX;
+		else if (soc_is_s3c64xx() || soc_is_s5pc100())
+			current_soc = S3C64XX;
+		else if (soc_is_s5p6440() || soc_is_s5p6450())
+			current_soc = S5P64XX;
+		else
+			panic("%s: unable to determine soc\n", __func__);
+	}
+
+	clk_table = kzalloc(sizeof(struct clk *) * nr_clks, GFP_KERNEL);
+	if (!clk_table)
+		panic("could not allocate clock lookup table\n");
+
+#ifdef CONFIG_OF
+	clk_data.clks = clk_table;
+	clk_data.clk_num = nr_clks;
+	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
+#endif
+
+#ifdef CONFIG_PM_SLEEP
+	register_syscore_ops(&samsung_clk_pwm_syscore_ops);
+#endif
+
+
+	clk = clk_register_fixed_rate(NULL, "pwm-tclk0", NULL, CLK_IS_ROOT, 0);
+	clk = clk_register_fixed_rate(NULL, "pwm-tclk1", NULL, CLK_IS_ROOT, 0);
+
+	clk = clk_register_divider(NULL, "pwm-scaler0", "pwm", 0, reg_base + TCFG0, 0, 8, 0, &lock);
+	clk = clk_register_divider(NULL, "pwm-scaler1", "pwm", 0, reg_base + TCFG0, 8, 8, 0, &lock);
+
+	tdiv_list = (current_soc == S3C24XX) ? pwm_s3c24xx_tdiv_dividers
+					      : pwm_s3c64xx_tdiv_dividers;
+
+	for (idx = 0; idx < 5; idx++, tdiv_list++) {
+		clk = samsung_clk_register_tdiv(tdiv_list->name, tdiv_list->parent_name,
+				tdiv_list->flags, reg_base + tdiv_list->offset,
+				tdiv_list->shift, tdiv_list->div_flags, tdiv_list->table);
+		if (IS_ERR(clk)) {
+			pr_err("%s: failed to register clock %s\n", __func__,
+				tdiv_list->name);
+			continue;
+		}
+
+		if (clk_table && tdiv_list->id)
+			clk_table[tdiv_list->id] = clk;
+	}
+
+	tin_list = pwm_tin;
+	for (idx = 0; idx < 5; idx++, tin_list++) {
+		clk = samsung_clk_register_tin(tin_list->name,
+				tin_list->parent_names, tin_list->num_parents,
+				reg_base + tin_list->offset, tin_list->shift,
+				tin_list->width);
+
+		if (IS_ERR(clk)) {
+			pr_err("%s: failed to register clock %s\n", __func__,
+				tin_list->name);
+			continue;
+		}
+
+		if (clk_table && tin_list->id)
+			clk_table[tin_list->id] = clk;
+	}
+
+	alias_list = pwm_aliases;
+	for (idx = 0; idx < ARRAY_SIZE(pwm_aliases); idx++, alias_list++) {
+		if (!alias_list->id) {
+			pr_err("%s: clock id missing for index %d\n", __func__,
+				idx);
+			continue;
+		}
+
+		clk = clk_table[alias_list->id];
+		if (!clk) {
+			pr_err("%s: failed to find clock %d\n", __func__,
+				alias_list->id);
+			continue;
+		}
+
+		ret = clk_register_clkdev(clk, alias_list->alias,
+					  alias_list->dev_name);
+		if (ret)
+			pr_err("%s: failed to register lookup %s\n",
+						__func__, alias_list->alias);
+	}
+}
-- 
1.7.2.3
