From: zhengxing@rock-chips.com (Xing Zheng)
Date: Tue, 29 Sep 2015 10:13:50 +0800
Subject: [PATCH v3 5/8] clk: rockchip: add new clock type and controller for
 rk3036
In-Reply-To: <1443492833-15630-1-git-send-email-zhengxing@rock-chips.com>
References: <1443492833-15630-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <1443492833-15630-6-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rk3036's pll and clock are different with base on the rk3066(rk3188,
rk3288, rk3368 use it), there are different adjust foctors and control
registers, so these should be independent and separate from the series
of rk3066s.

Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---

Changes in v3: None

 drivers/clk/rockchip/clk-pll.c |  243 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 242 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-pll.c b/drivers/clk/rockchip/clk-pll.c
index 7737a1d..fbd6cc8 100644
--- a/drivers/clk/rockchip/clk-pll.c
+++ b/drivers/clk/rockchip/clk-pll.c
@@ -2,6 +2,9 @@
  * Copyright (c) 2014 MundoReader S.L.
  * Author: Heiko Stuebner <heiko@sntech.de>
  *
+ * Copyright (c) 2015 Rockchip Electronics Co. Ltd.
+ * Author: Xing Zheng <zhengxing@rock-chips.com>
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -19,6 +22,7 @@
 #include <linux/delay.h>
 #include <linux/clk-provider.h>
 #include <linux/regmap.h>
+#include <linux/clk.h>
 #include "clk.h"
 
 #define PLL_MODE_MASK		0x3
@@ -108,6 +112,237 @@ static int rockchip_pll_wait_lock(struct rockchip_clk_pll *pll)
 }
 
 /**
+ * PLL used in RK3036
+ */
+
+#define RK3036_PLLCON(i)			(i * 0x4)
+#define RK3036_PLLCON0_FBDIV_MASK		0xfff
+#define RK3036_PLLCON0_FBDIV_SHIFT		0
+#define RK3036_PLLCON0_POSTDIV1_MASK		0x7
+#define RK3036_PLLCON0_POSTDIV1_SHIFT		12
+#define RK3036_PLLCON1_REFDIV_MASK		0x3f
+#define RK3036_PLLCON1_REFDIV_SHIFT		0
+#define RK3036_PLLCON1_POSTDIV2_MASK		0x7
+#define RK3036_PLLCON1_POSTDIV2_SHIFT		6
+#define RK3036_PLLCON1_DSMPD_MASK		0x1
+#define RK3036_PLLCON1_DSMPD_SHIFT		12
+#define RK3036_PLLCON2_FRAC_MASK		0xffffff
+#define RK3036_PLLCON2_FRAC_SHIFT		0
+
+#define RK3036_PLLCON1_PWRDOWN			(1 << 13)
+
+static unsigned long rockchip_rk3036_pll_recalc_rate(struct clk_hw *hw,
+						     unsigned long prate)
+{
+	struct rockchip_clk_pll *pll = to_rockchip_clk_pll(hw);
+	unsigned int fbdiv, postdiv1, refdiv, postdiv2, dsmpd, frac;
+	u64 rate64 = prate;
+	u32 pllcon;
+
+	pllcon = readl_relaxed(pll->reg_base + RK3036_PLLCON(0));
+	fbdiv = ((pllcon >> RK3036_PLLCON0_FBDIV_SHIFT) & RK3036_PLLCON0_FBDIV_MASK);
+	postdiv1 = ((pllcon >> RK3036_PLLCON0_POSTDIV1_SHIFT) & RK3036_PLLCON0_POSTDIV1_MASK);
+
+	pllcon = readl_relaxed(pll->reg_base + RK3036_PLLCON(1));
+	refdiv = ((pllcon >> RK3036_PLLCON1_REFDIV_SHIFT) & RK3036_PLLCON1_REFDIV_MASK);
+	postdiv2 = ((pllcon >> RK3036_PLLCON1_POSTDIV2_SHIFT) & RK3036_PLLCON1_POSTDIV2_MASK);
+	dsmpd = ((pllcon >> RK3036_PLLCON1_DSMPD_SHIFT) & RK3036_PLLCON1_DSMPD_MASK);
+
+	pllcon = readl_relaxed(pll->reg_base + RK3036_PLLCON(2));
+	frac = ((pllcon >> RK3036_PLLCON2_FRAC_SHIFT) & RK3036_PLLCON2_FRAC_MASK);
+
+	rate64 *= fbdiv;
+	do_div(rate64, refdiv);
+
+	if (dsmpd == 0) {
+		/* fractional mode */
+		u64 frac_rate64 = prate * frac;
+
+		do_div(frac_rate64, refdiv);
+		rate64 += frac_rate64 >> 24;
+	}
+
+	do_div(rate64, postdiv1);
+	do_div(rate64, postdiv2);
+
+	return (unsigned long)rate64;
+}
+
+static int rockchip_rk3036_pll_set_rate(struct clk_hw *hw, unsigned long drate,
+					unsigned long prate)
+{
+	struct rockchip_clk_pll *pll = to_rockchip_clk_pll(hw);
+	const struct rockchip_pll_rate_table *rate;
+	unsigned long old_rate = rockchip_rk3036_pll_recalc_rate(hw, prate);
+	struct regmap *grf = rockchip_clk_get_grf();
+	struct clk_mux *pll_mux = &pll->pll_mux;
+	const struct clk_ops *pll_mux_ops = pll->pll_mux_ops;
+	u32 pllcon;
+	int rate_change_remuxed = 0;
+	int cur_parent;
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
+	pr_debug("%s: rate settings for %lu fbdiv: %d, postdiv1: %d, refdiv: %d, postdiv2: %d, dsmpd: %d, frac: %d\n",
+		__func__, rate->rate,
+		rate->fbdiv, rate->postdiv1, rate->refdiv, rate->postdiv2, rate->dsmpd, rate->frac);
+
+	cur_parent = pll_mux_ops->get_parent(&pll_mux->hw);
+	if (cur_parent == PLL_MODE_NORM) {
+		pll_mux_ops->set_parent(&pll_mux->hw, PLL_MODE_SLOW);
+		rate_change_remuxed = 1;
+	}
+
+	/* update pll values */
+	writel_relaxed(HIWORD_UPDATE(rate->fbdiv, RK3036_PLLCON0_FBDIV_MASK,
+					  RK3036_PLLCON0_FBDIV_SHIFT) |
+		       HIWORD_UPDATE(rate->postdiv1, RK3036_PLLCON0_POSTDIV1_MASK,
+					     RK3036_PLLCON0_POSTDIV1_SHIFT),
+		       pll->reg_base + RK3036_PLLCON(0));
+
+	writel_relaxed(HIWORD_UPDATE(rate->refdiv, RK3036_PLLCON1_REFDIV_MASK,
+						   RK3036_PLLCON1_REFDIV_SHIFT) |
+		       HIWORD_UPDATE(rate->postdiv2, RK3036_PLLCON1_POSTDIV2_MASK,
+						     RK3036_PLLCON1_POSTDIV2_SHIFT) |
+		       HIWORD_UPDATE(rate->dsmpd, RK3036_PLLCON1_DSMPD_MASK,
+						  RK3036_PLLCON1_DSMPD_SHIFT),
+		       pll->reg_base + RK3036_PLLCON(1));
+
+	/* GPLL CON2 is not HIWORD_MASK */
+	pllcon = readl_relaxed(pll->reg_base + RK3036_PLLCON(2));
+	pllcon &= ~(RK3036_PLLCON2_FRAC_MASK << RK3036_PLLCON2_FRAC_SHIFT);
+	pllcon |= rate->frac << RK3036_PLLCON2_FRAC_SHIFT;
+	writel_relaxed(pllcon, pll->reg_base + RK3036_PLLCON(2));
+
+	/* wait for the pll to lock */
+	ret = rockchip_pll_wait_lock(pll);
+	if (ret) {
+		pr_warn("%s: pll did not lock, trying to restore old rate %lu\n",
+			__func__, old_rate);
+		rockchip_rk3036_pll_set_rate(hw, old_rate, prate);
+	}
+
+	if (rate_change_remuxed)
+		pll_mux_ops->set_parent(&pll_mux->hw, PLL_MODE_NORM);
+
+	return ret;
+}
+
+static int rockchip_rk3036_pll_enable(struct clk_hw *hw)
+{
+	struct rockchip_clk_pll *pll = to_rockchip_clk_pll(hw);
+
+	writel(HIWORD_UPDATE(0, RK3036_PLLCON1_PWRDOWN, 0),
+	       pll->reg_base + RK3036_PLLCON(1));
+
+	return 0;
+}
+
+static void rockchip_rk3036_pll_disable(struct clk_hw *hw)
+{
+	struct rockchip_clk_pll *pll = to_rockchip_clk_pll(hw);
+
+	writel(HIWORD_UPDATE(RK3036_PLLCON1_PWRDOWN,
+			     RK3036_PLLCON1_PWRDOWN, 0),
+	       pll->reg_base + RK3036_PLLCON(1));
+}
+
+static int rockchip_rk3036_pll_is_enabled(struct clk_hw *hw)
+{
+	struct rockchip_clk_pll *pll = to_rockchip_clk_pll(hw);
+	u32 pllcon = readl(pll->reg_base + RK3036_PLLCON(1));
+
+	return !(pllcon & RK3036_PLLCON1_PWRDOWN);
+}
+
+static void rockchip_rk3036_pll_init(struct clk_hw *hw)
+{
+	struct rockchip_clk_pll *pll = to_rockchip_clk_pll(hw);
+	const struct rockchip_pll_rate_table *rate;
+	unsigned int fbdiv, postdiv1, refdiv, postdiv2, dsmpd, frac;
+	unsigned long drate;
+	u32 pllcon;
+
+	if (!(pll->flags & ROCKCHIP_PLL_SYNC_RATE))
+		return;
+
+	drate = clk_hw_get_rate(hw);
+	rate = rockchip_get_pll_settings(pll, drate);
+
+	/* when no rate setting for the current rate, rely on clk_set_rate */
+	if (!rate)
+		return;
+
+	pllcon = readl_relaxed(pll->reg_base + RK3036_PLLCON(0));
+	fbdiv = ((pllcon >> RK3036_PLLCON0_FBDIV_SHIFT) & RK3036_PLLCON0_FBDIV_MASK);
+	postdiv1 = ((pllcon >> RK3036_PLLCON0_POSTDIV1_SHIFT) & RK3036_PLLCON0_POSTDIV1_MASK);
+
+	pllcon = readl_relaxed(pll->reg_base + RK3036_PLLCON(1));
+	refdiv = ((pllcon >> RK3036_PLLCON1_REFDIV_SHIFT) & RK3036_PLLCON1_REFDIV_MASK);
+	postdiv2 = ((pllcon >> RK3036_PLLCON1_POSTDIV2_SHIFT) & RK3036_PLLCON1_POSTDIV2_MASK);
+	dsmpd = ((pllcon >> RK3036_PLLCON1_DSMPD_SHIFT) & RK3036_PLLCON1_DSMPD_MASK);
+
+	pllcon = readl_relaxed(pll->reg_base + RK3036_PLLCON(2));
+	frac = ((pllcon >> RK3036_PLLCON2_FRAC_SHIFT) & RK3036_PLLCON2_FRAC_MASK);
+
+	pr_debug("%s: pll %s@%lu: Hz\n", __func__, __clk_get_name(hw->clk), drate);
+	pr_debug("old - fbdiv: %d, postdiv1: %d, refdiv: %d, postdiv2: %d, dsmpd: %d, frac: %d\n",
+		fbdiv, postdiv1, refdiv, postdiv2, dsmpd, frac);
+	pr_debug("new - fbdiv: %d, postdiv1: %d, refdiv: %d, postdiv2: %d, dsmpd: %d, frac: %d\n",
+		rate->fbdiv, rate->postdiv1, rate->refdiv, rate->postdiv2, rate->dsmpd, rate->frac);
+
+	if (rate->fbdiv != fbdiv || rate->postdiv1 != postdiv1 || rate->refdiv != refdiv ||
+		rate->postdiv2 != postdiv2 || rate->dsmpd != dsmpd || rate->frac != frac) {
+		struct clk *parent = clk_get_parent(hw->clk);
+		unsigned long prate;
+
+		if (!parent) {
+			pr_warn("%s: parent of %s not available\n",
+				__func__, __clk_get_name(hw->clk));
+			return;
+		}
+
+		pr_debug("%s: pll %s: rate params do not match rate table, adjusting\n",
+			 __func__, __clk_get_name(hw->clk));
+		prate = clk_get_rate(parent);
+		rockchip_rk3036_pll_set_rate(hw, drate, prate);
+	}
+}
+
+static const struct clk_ops rockchip_rk3036_pll_clk_norate_ops = {
+	.recalc_rate = rockchip_rk3036_pll_recalc_rate,
+	.enable = rockchip_rk3036_pll_enable,
+	.disable = rockchip_rk3036_pll_disable,
+	.is_enabled = rockchip_rk3036_pll_is_enabled,
+};
+
+static const struct clk_ops rockchip_rk3036_pll_clk_ops = {
+	.recalc_rate = rockchip_rk3036_pll_recalc_rate,
+	.round_rate = rockchip_pll_round_rate,
+	.set_rate = rockchip_rk3036_pll_set_rate,
+	.enable = rockchip_rk3036_pll_enable,
+	.disable = rockchip_rk3036_pll_disable,
+	.is_enabled = rockchip_rk3036_pll_is_enabled,
+	.init = rockchip_rk3036_pll_init,
+};
+
+/**
  * PLL used in RK3066, RK3188 and RK3288
  */
 
@@ -363,7 +598,7 @@ struct clk *rockchip_clk_register_pll(enum rockchip_pll_type pll_type,
 	pll_mux->lock = lock;
 	pll_mux->hw.init = &init;
 
-	if (pll_type == pll_rk3066)
+	if (pll_type == pll_rk3036 || pll_type == pll_rk3066)
 		pll_mux->flags |= CLK_MUX_HIWORD_MASK;
 
 	/* the actual muxing is xin24m, pll-output, xin32k */
@@ -408,6 +643,12 @@ struct clk *rockchip_clk_register_pll(enum rockchip_pll_type pll_type,
 	}
 
 	switch (pll_type) {
+	case pll_rk3036:
+		if (!pll->rate_table)
+			init.ops = &rockchip_rk3036_pll_clk_norate_ops;
+		else
+			init.ops = &rockchip_rk3036_pll_clk_ops;
+		break;
 	case pll_rk3066:
 		if (!pll->rate_table)
 			init.ops = &rockchip_rk3066_pll_clk_norate_ops;
-- 
1.7.9.5
