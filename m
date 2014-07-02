From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 03 Jul 2014 01:59:10 +0200
Subject: [PATCH v5 05/14] clk: rockchip: add clock type for pll clocks and pll
 used on rk3066
In-Reply-To: <156042792.J76K6jxIGl@diego>
References: <156042792.J76K6jxIGl@diego>
Message-ID: <3232816.XNXBo93MGG@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All known Rockchip SoCs down to the RK28xx (ARM9) use a similar pattern to
handle their plls:
                       |--\
xin32k ----------------|mux\
xin24m -----| pll |----|pll|--- pll output
       \---------------|src/
                       |--/

The pll output is sourced from 1 of 3 sources, the actual pll being one of
them. To change the pll frequency it is imperative to remux it to another
source beforehand. This is done by adding a clock-listener to the pll that
handles the remuxing before and after the rate change.

The output mux is implemented as a separate clock to make use of already
existing common-clock features for disabling the pll if one of the other
two sources is used.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Acked-By: Max Schwarz <max.schwarz@online.de>
Tested-By: Max Schwarz <max.schwarz@online.de>
---
 drivers/clk/rockchip/Makefile  |   1 +
 drivers/clk/rockchip/clk-pll.c | 431 +++++++++++++++++++++++++++++++++++++++++
 drivers/clk/rockchip/clk.c     |  35 ++++
 drivers/clk/rockchip/clk.h     |  74 +++++++
 4 files changed, 541 insertions(+)
 create mode 100644 drivers/clk/rockchip/clk-pll.c

diff --git a/drivers/clk/rockchip/Makefile b/drivers/clk/rockchip/Makefile
index 0068a8b..2cb9164 100644
--- a/drivers/clk/rockchip/Makefile
+++ b/drivers/clk/rockchip/Makefile
@@ -4,3 +4,4 @@
 
 obj-y	+= clk-rockchip.o
 obj-y	+= clk.o
+obj-y	+= clk-pll.o
diff --git a/drivers/clk/rockchip/clk-pll.c b/drivers/clk/rockchip/clk-pll.c
new file mode 100644
index 0000000..f2a1c7a
--- /dev/null
+++ b/drivers/clk/rockchip/clk-pll.c
@@ -0,0 +1,431 @@
+/*
+ * Copyright (c) 2014 MundoReader S.L.
+ * Author: Heiko Stuebner <heiko@sntech.de>
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
+#include <asm/div64.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/regmap.h>
+#include "clk.h"
+
+#define PLL_MODE_MASK		0x3
+#define PLL_MODE_SLOW		0x0
+#define PLL_MODE_NORM		0x1
+#define PLL_MODE_DEEP		0x2
+
+struct rockchip_clk_pll {
+	struct clk_hw		hw;
+
+	struct clk_mux		pll_mux;
+	const struct clk_ops	*pll_mux_ops;
+
+	struct notifier_block	clk_nb;
+	bool			rate_change_remuxed;
+
+	void __iomem		*reg_base;
+	int			lock_offset;
+	unsigned int		lock_shift;
+	enum rockchip_pll_type	type;
+	const struct rockchip_pll_rate_table *rate_table;
+	unsigned int		rate_count;
+	spinlock_t		*lock;
+};
+
+#define to_rockchip_clk_pll(_hw) container_of(_hw, struct rockchip_clk_pll, hw)
+#define to_rockchip_clk_pll_nb(nb) \
+			container_of(nb, struct rockchip_clk_pll, clk_nb)
+
+static const struct rockchip_pll_rate_table *rockchip_get_pll_settings(
+			    struct rockchip_clk_pll *pll, unsigned long rate)
+{
+	const struct rockchip_pll_rate_table  *rate_table = pll->rate_table;
+	int i;
+
+	for (i = 0; i < pll->rate_count; i++) {
+		if (rate == rate_table[i].rate)
+			return &rate_table[i];
+	}
+
+	return NULL;
+}
+
+static long rockchip_pll_round_rate(struct clk_hw *hw,
+			    unsigned long drate, unsigned long *prate)
+{
+	struct rockchip_clk_pll *pll = to_rockchip_clk_pll(hw);
+	const struct rockchip_pll_rate_table *rate_table = pll->rate_table;
+	int i;
+
+	/* Assumming rate_table is in descending order */
+	for (i = 0; i < pll->rate_count; i++) {
+		if (drate >= rate_table[i].rate)
+			return rate_table[i].rate;
+	}
+
+	/* return minimum supported value */
+	return rate_table[i - 1].rate;
+}
+
+/*
+ * Wait for the pll to reach the locked state.
+ * The calling set_rate function is responsible for making sure the
+ * grf regmap is available.
+ */
+static int rockchip_pll_wait_lock(struct rockchip_clk_pll *pll)
+{
+	struct regmap *grf = rockchip_clk_get_grf();
+	unsigned int val;
+	int delay = 24000000, ret;
+
+	while (delay > 0) {
+		ret = regmap_read(grf, pll->lock_offset, &val);
+		if (ret) {
+			pr_err("%s: failed to read pll lock status: %d\n",
+			       __func__, ret);
+			return ret;
+		}
+
+		if (val & BIT(pll->lock_shift))
+			return 0;
+		delay--;
+	}
+
+	pr_err("%s: timeout waiting for pll to lock\n", __func__);
+	return -ETIMEDOUT;
+}
+
+/**
+ * Set pll mux when changing the pll rate.
+ * This makes sure to move the pll mux away from the actual pll before
+ * changing its rate and back to the original parent after the change.
+ */
+static int rockchip_pll_notifier_cb(struct notifier_block *nb,
+					unsigned long event, void *data)
+{
+	struct rockchip_clk_pll *pll = to_rockchip_clk_pll_nb(nb);
+	struct clk_mux *pll_mux = &pll->pll_mux;
+	const struct clk_ops *pll_mux_ops = pll->pll_mux_ops;
+	int cur_parent;
+
+	switch (event) {
+	case PRE_RATE_CHANGE:
+		cur_parent = pll_mux_ops->get_parent(&pll_mux->hw);
+		if (cur_parent == PLL_MODE_NORM) {
+			pll_mux_ops->set_parent(&pll_mux->hw, PLL_MODE_SLOW);
+			pll->rate_change_remuxed = 1;
+		}
+		break;
+	case POST_RATE_CHANGE:
+		if (pll->rate_change_remuxed) {
+			pll_mux_ops->set_parent(&pll_mux->hw, PLL_MODE_NORM);
+			pll->rate_change_remuxed = 0;
+		}
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+/**
+ * PLL used in RK3066, RK3188 and RK3288
+ */
+
+#define RK3066_PLL_RESET_DELAY(nr)	((nr * 500) / 24 + 1)
+
+#define RK3066_PLLCON(i)		(i * 0x4)
+#define RK3066_PLLCON0_OD_MASK		0xf
+#define RK3066_PLLCON0_OD_SHIFT		0
+#define RK3066_PLLCON0_NR_MASK		0x3f
+#define RK3066_PLLCON0_NR_SHIFT		8
+#define RK3066_PLLCON1_NF_MASK		0x1fff
+#define RK3066_PLLCON1_NF_SHIFT		0
+#define RK3066_PLLCON2_BWADJ_MASK	0xfff
+#define RK3066_PLLCON2_BWADJ_SHIFT	0
+#define RK3066_PLLCON3_RESET		(1 << 5)
+#define RK3066_PLLCON3_PWRDOWN		(1 << 1)
+#define RK3066_PLLCON3_BYPASS		(1 << 0)
+
+static unsigned long rockchip_rk3066_pll_recalc_rate(struct clk_hw *hw,
+						     unsigned long prate)
+{
+	struct rockchip_clk_pll *pll = to_rockchip_clk_pll(hw);
+	u64 nf, nr, no, rate64 = prate;
+	u32 pllcon;
+
+	pllcon = readl_relaxed(pll->reg_base + RK3066_PLLCON(3));
+	if (pllcon & RK3066_PLLCON3_BYPASS) {
+		pr_debug("%s: pll %s is bypassed\n", __func__,
+			__clk_get_name(hw->clk));
+		return prate;
+	}
+
+	pllcon = readl_relaxed(pll->reg_base + RK3066_PLLCON(1));
+	nf = (pllcon >> RK3066_PLLCON1_NF_SHIFT) & RK3066_PLLCON1_NF_MASK;
+
+	pllcon = readl_relaxed(pll->reg_base + RK3066_PLLCON(0));
+	nr = (pllcon >> RK3066_PLLCON0_NR_SHIFT) & RK3066_PLLCON0_NR_MASK;
+	no = (pllcon >> RK3066_PLLCON0_OD_SHIFT) & RK3066_PLLCON0_OD_MASK;
+
+	rate64 *= (nf + 1);
+	do_div(rate64, nr + 1);
+	do_div(rate64, no + 1);
+
+	return (unsigned long)rate64;
+}
+
+static int rockchip_rk3066_pll_set_rate(struct clk_hw *hw, unsigned long drate,
+					unsigned long prate)
+{
+	struct rockchip_clk_pll *pll = to_rockchip_clk_pll(hw);
+	const struct rockchip_pll_rate_table *rate;
+	unsigned long old_rate = rockchip_rk3066_pll_recalc_rate(hw, prate);
+	struct regmap *grf = rockchip_clk_get_grf();
+	int ret;
+
+	if (IS_ERR(grf)) {
+		pr_debug("%s: grf regmap not available, aborting rate change\n",
+			 __func__);
+		return PTR_ERR(grf);
+	}
+
+	pr_debug("%s: changing %s from %lu to %lu with a parent rate of %lu\n",
+		 __func__, __clk_get_name(hw->clk), old_rate, drate, prate);
+
+	/* Get required rate settings from table */
+	rate = rockchip_get_pll_settings(pll, drate);
+	if (!rate) {
+		pr_err("%s: Invalid rate : %lu for pll clk %s\n", __func__,
+			drate, __clk_get_name(hw->clk));
+		return -EINVAL;
+	}
+
+	pr_debug("%s: rate settings for %lu (nr, no, nf): (%d, %d, %d)\n",
+		 __func__, rate->rate, rate->nr, rate->no, rate->nf);
+
+	/* enter reset mode */
+	writel(HIWORD_UPDATE(RK3066_PLLCON3_RESET, RK3066_PLLCON3_RESET, 0),
+	       pll->reg_base + RK3066_PLLCON(3));
+
+	/* update pll values */
+	writel(HIWORD_UPDATE(rate->nr - 1, RK3066_PLLCON0_NR_MASK,
+					   RK3066_PLLCON0_NR_SHIFT) |
+	       HIWORD_UPDATE(rate->no - 1, RK3066_PLLCON0_OD_MASK,
+					   RK3066_PLLCON0_OD_SHIFT),
+	       pll->reg_base + RK3066_PLLCON(0));
+
+	writel_relaxed(HIWORD_UPDATE(rate->nf - 1, RK3066_PLLCON1_NF_MASK,
+						   RK3066_PLLCON1_NF_SHIFT),
+		       pll->reg_base + RK3066_PLLCON(1));
+	writel_relaxed(HIWORD_UPDATE(rate->bwadj, RK3066_PLLCON2_BWADJ_MASK,
+						  RK3066_PLLCON2_BWADJ_SHIFT),
+		       pll->reg_base + RK3066_PLLCON(2));
+
+	/* leave reset and wait the reset_delay */
+	writel(HIWORD_UPDATE(0, RK3066_PLLCON3_RESET, 0),
+	       pll->reg_base + RK3066_PLLCON(3));
+	udelay(RK3066_PLL_RESET_DELAY(rate->nr));
+
+	/* wait for the pll to lock */
+	ret = rockchip_pll_wait_lock(pll);
+	if (ret) {
+		pr_warn("%s: pll did not lock, trying to restore old rate %lu\n",
+			__func__, old_rate);
+		rockchip_rk3066_pll_set_rate(hw, old_rate, prate);
+	}
+
+	return ret;
+}
+
+static int rockchip_rk3066_pll_enable(struct clk_hw *hw)
+{
+	struct rockchip_clk_pll *pll = to_rockchip_clk_pll(hw);
+
+	writel(HIWORD_UPDATE(0, RK3066_PLLCON3_PWRDOWN, 0),
+	       pll->reg_base + RK3066_PLLCON(3));
+
+	return 0;
+}
+
+static void rockchip_rk3066_pll_disable(struct clk_hw *hw)
+{
+	struct rockchip_clk_pll *pll = to_rockchip_clk_pll(hw);
+
+	writel(HIWORD_UPDATE(RK3066_PLLCON3_PWRDOWN,
+			     RK3066_PLLCON3_PWRDOWN, 0),
+	       pll->reg_base + RK3066_PLLCON(3));
+}
+
+static int rockchip_rk3066_pll_is_enabled(struct clk_hw *hw)
+{
+	struct rockchip_clk_pll *pll = to_rockchip_clk_pll(hw);
+	u32 pllcon = readl(pll->reg_base + RK3066_PLLCON(3));
+
+	return !(pllcon & RK3066_PLLCON3_PWRDOWN);
+}
+
+static const struct clk_ops rockchip_rk3066_pll_clk_norate_ops = {
+	.recalc_rate = rockchip_rk3066_pll_recalc_rate,
+	.enable = rockchip_rk3066_pll_enable,
+	.disable = rockchip_rk3066_pll_disable,
+	.is_enabled = rockchip_rk3066_pll_is_enabled,
+};
+
+static const struct clk_ops rockchip_rk3066_pll_clk_ops = {
+	.recalc_rate = rockchip_rk3066_pll_recalc_rate,
+	.round_rate = rockchip_pll_round_rate,
+	.set_rate = rockchip_rk3066_pll_set_rate,
+	.enable = rockchip_rk3066_pll_enable,
+	.disable = rockchip_rk3066_pll_disable,
+	.is_enabled = rockchip_rk3066_pll_is_enabled,
+};
+
+/*
+ * Common registering of pll clocks
+ */
+
+struct clk *rockchip_clk_register_pll(enum rockchip_pll_type pll_type,
+		const char *name, const char **parent_names, u8 num_parents,
+		void __iomem *base, int con_offset, int grf_lock_offset,
+		int lock_shift, int mode_offset, int mode_shift,
+		struct rockchip_pll_rate_table *rate_table,
+		spinlock_t *lock)
+{
+	const char *pll_parents[3];
+	struct clk_init_data init;
+	struct rockchip_clk_pll *pll;
+	struct clk_mux *pll_mux;
+	struct clk *pll_clk, *mux_clk;
+	char pll_name[20];
+	int ret;
+
+	if (num_parents != 2) {
+		pr_err("%s: needs two parent clocks\n", __func__);
+		return ERR_PTR(-EINVAL);
+	}
+
+	/* name the actual pll */
+	snprintf(pll_name, sizeof(pll_name), "pll_%s", name);
+
+	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = pll_name;
+
+	/* keep all plls untouched for now */
+	init.flags = CLK_IGNORE_UNUSED;
+
+	init.parent_names = &parent_names[0];
+	init.num_parents = 1;
+
+	if (rate_table) {
+		int len;
+
+		/* find count of rates in rate_table */
+		for (len = 0; rate_table[len].rate != 0; )
+			len++;
+
+		pll->rate_count = len;
+		pll->rate_table = kmemdup(rate_table,
+					pll->rate_count *
+					sizeof(struct rockchip_pll_rate_table),
+					GFP_KERNEL);
+		WARN(!pll->rate_table,
+			"%s: could not allocate rate table for %s\n",
+			__func__, name);
+	}
+
+	switch (pll_type) {
+	case pll_rk3066:
+		if (!pll->rate_table)
+			init.ops = &rockchip_rk3066_pll_clk_norate_ops;
+		else
+			init.ops = &rockchip_rk3066_pll_clk_ops;
+		break;
+	default:
+		pr_warn("%s: Unknown pll type for pll clk %s\n",
+			__func__, name);
+	}
+
+	pll->hw.init = &init;
+	pll->type = pll_type;
+	pll->reg_base = base + con_offset;
+	pll->lock_offset = grf_lock_offset;
+	pll->lock_shift = lock_shift;
+	pll->lock = lock;
+	pll->clk_nb.notifier_call = rockchip_pll_notifier_cb;
+
+	pll_clk = clk_register(NULL, &pll->hw);
+	if (IS_ERR(pll_clk)) {
+		pr_err("%s: failed to register pll clock %s : %ld\n",
+			__func__, name, PTR_ERR(pll_clk));
+		mux_clk = pll_clk;
+		goto err_pll;
+	}
+
+	ret = clk_notifier_register(pll_clk, &pll->clk_nb);
+	if (ret) {
+		pr_err("%s: failed to register clock notifier for %s : %d\n",
+				__func__, name, ret);
+		mux_clk = ERR_PTR(ret);
+		goto err_pll_notifier;
+	}
+
+	/* create the mux on top of the real pll */
+	pll->pll_mux_ops = &clk_mux_ops;
+	pll_mux = &pll->pll_mux;
+
+	/* the actual muxing is xin24m, pll-output, xin32k */
+	pll_parents[0] = parent_names[0];
+	pll_parents[1] = pll_name;
+	pll_parents[2] = parent_names[1];
+
+	init.name = name;
+	init.flags = CLK_SET_RATE_PARENT;
+	init.ops = pll->pll_mux_ops;
+	init.parent_names = pll_parents;
+	init.num_parents = ARRAY_SIZE(pll_parents);
+
+	pll_mux->reg = base + mode_offset;
+	pll_mux->shift = mode_shift;
+	pll_mux->mask = PLL_MODE_MASK;
+	pll_mux->flags = 0;
+	pll_mux->lock = lock;
+	pll_mux->hw.init = &init;
+
+	if (pll_type == pll_rk3066)
+		pll_mux->flags |= CLK_MUX_HIWORD_MASK;
+
+	mux_clk = clk_register(NULL, &pll_mux->hw);
+	if (IS_ERR(mux_clk))
+		goto err_mux;
+
+	return mux_clk;
+
+err_mux:
+	ret = clk_notifier_unregister(pll_clk, &pll->clk_nb);
+	if (ret) {
+		pr_err("%s: could not unregister clock notifier in error path : %d\n",
+		       __func__, ret);
+		return mux_clk;
+	}
+err_pll_notifier:
+	clk_unregister(pll_clk);
+err_pll:
+	kfree(pll);
+	return mux_clk;
+}
diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
index aa15d5a..278cf9d 100644
--- a/drivers/clk/rockchip/clk.c
+++ b/drivers/clk/rockchip/clk.c
@@ -23,6 +23,8 @@
 #include <linux/slab.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
 #include "clk.h"
 
 /**
@@ -105,11 +107,15 @@ static DEFINE_SPINLOCK(clk_lock);
 static struct clk **clk_table;
 static void __iomem *reg_base;
 static struct clk_onecell_data clk_data;
+static struct device_node *cru_node;
+static struct regmap *grf;
 
 void __init rockchip_clk_init(struct device_node *np, void __iomem *base,
 			      unsigned long nr_clks)
 {
 	reg_base = base;
+	cru_node = np;
+	grf = ERR_PTR(-EPROBE_DEFER);
 
 	clk_table = kcalloc(nr_clks, sizeof(struct clk *), GFP_KERNEL);
 	if (!clk_table)
@@ -120,12 +126,41 @@ void __init rockchip_clk_init(struct device_node *np, void __iomem *base,
 	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
 }
 
+struct regmap *rockchip_clk_get_grf(void)
+{
+	if (IS_ERR(grf))
+		grf = syscon_regmap_lookup_by_phandle(cru_node, "rockchip,grf");
+	return grf;
+}
+
 void rockchip_clk_add_lookup(struct clk *clk, unsigned int id)
 {
 	if (clk_table && id)
 		clk_table[id] = clk;
 }
 
+void __init rockchip_clk_register_plls(struct rockchip_pll_clock *list,
+				unsigned int nr_pll, int grf_lock_offset)
+{
+	struct clk *clk;
+	int idx;
+
+	for (idx = 0; idx < nr_pll; idx++, list++) {
+		clk = rockchip_clk_register_pll(list->type, list->name,
+				list->parent_names, list->num_parents,
+				reg_base, list->con_offset, grf_lock_offset,
+				list->lock_shift, list->mode_offset,
+				list->mode_shift, list->rate_table, &clk_lock);
+		if (IS_ERR(clk)) {
+			pr_err("%s: failed to register clock %s\n", __func__,
+				list->name);
+			continue;
+		}
+
+		rockchip_clk_add_lookup(clk, list->id);
+	}
+}
+
 void __init rockchip_clk_register_branches(
 				      struct rockchip_clk_branch *list,
 				      unsigned int nr_clk)
diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
index 5b051b0..fb7ce85 100644
--- a/drivers/clk/rockchip/clk.h
+++ b/drivers/clk/rockchip/clk.h
@@ -40,6 +40,77 @@
 #define RK2928_SOFTRST_CON(x)	(x * 0x4 + 0x110)
 #define RK2928_MISC_CON		0x134
 
+enum rockchip_pll_type {
+	pll_rk3066,
+};
+
+#define RK3066_PLL_RATE(_rate, _nr, _nf, _no)	\
+{						\
+	.rate	= _rate##U,			\
+	.nr = _nr,				\
+	.nf = _nf,				\
+	.no = _no,				\
+	.bwadj = (_nf >> 1),			\
+}
+
+struct rockchip_pll_rate_table {
+	unsigned long rate;
+	unsigned int nr;
+	unsigned int nf;
+	unsigned int no;
+	unsigned int bwadj;
+};
+
+/**
+ * struct rockchip_pll_clock: information about pll clock
+ * @id: platform specific id of the clock.
+ * @name: name of this pll clock.
+ * @parent_name: name of the parent clock.
+ * @flags: optional flags for basic clock.
+ * @con_offset: offset of the register for configuring the PLL.
+ * @mode_offset: offset of the register for configuring the PLL-mode.
+ * @mode_shift: offset inside the mode-register for the mode of this pll.
+ * @lock_shift: offset inside the lock register for the lock status.
+ * @type: Type of PLL to be registered.
+ * @rate_table: Table of usable pll rates
+ */
+struct rockchip_pll_clock {
+	unsigned int		id;
+	const char		*name;
+	const char		**parent_names;
+	u8			num_parents;
+	unsigned long		flags;
+	int			con_offset;
+	int			mode_offset;
+	int			mode_shift;
+	int			lock_shift;
+	enum rockchip_pll_type	type;
+	struct rockchip_pll_rate_table *rate_table;
+};
+
+#define PLL(_type, _id, _name, _pnames, _flags, _con, _mode, _mshift,	\
+		_lshift, _rtable)					\
+	{								\
+		.id		= _id,					\
+		.type		= _type,				\
+		.name		= _name,				\
+		.parent_names	= _pnames,				\
+		.num_parents	= ARRAY_SIZE(_pnames),			\
+		.flags		= CLK_GET_RATE_NOCACHE | _flags,	\
+		.con_offset	= _con,					\
+		.mode_offset	= _mode,				\
+		.mode_shift	= _mshift,				\
+		.lock_shift	= _lshift,				\
+		.rate_table	= _rtable,				\
+	}
+
+struct clk *rockchip_clk_register_pll(enum rockchip_pll_type pll_type,
+		const char *name, const char **parent_names, u8 num_parents,
+		void __iomem *base, int con_offset, int grf_lock_offset,
+		int lock_shift, int reg_mode, int mode_shift,
+		struct rockchip_pll_rate_table *rate_table,
+		spinlock_t *lock);
+
 #define PNAME(x) static const char *x[] __initconst
 
 enum rockchip_clk_branch_type {
@@ -243,8 +314,11 @@ struct rockchip_clk_branch {
 
 void rockchip_clk_init(struct device_node *np, void __iomem *base,
 		       unsigned long nr_clks);
+struct regmap *rockchip_clk_get_grf(void);
 void rockchip_clk_add_lookup(struct clk *clk, unsigned int id);
 void rockchip_clk_register_branches(struct rockchip_clk_branch *clk_list,
 				    unsigned int nr_clk);
+void rockchip_clk_register_plls(struct rockchip_pll_clock *pll_list,
+				unsigned int nr_pll, int grf_lock_offset);
 
 #endif
-- 
1.9.0
