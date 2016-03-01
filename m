From: zhengxing@rock-chips.com (Xing Zheng)
Date: Tue,  1 Mar 2016 18:14:33 +0800
Subject: [RESEND PATCH v2 3/5] clk: rockchip: add new pll-type for rk3399 and
 similar socs
In-Reply-To: <1456827275-8035-1-git-send-email-zhengxing@rock-chips.com>
References: <1456827275-8035-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <1456827275-8035-4-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rk3399's pll and clock are similar with rk3036's, it different
with base on the rk3066(rk3188, rk3288, rk3368 use it), there are
different adjust foctors and control registers, so these should be
independent and separate from the series of rk3066s.

Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
---

Changes in v2: None

 drivers/clk/rockchip/clk-pll.c |  279 +++++++++++++++++++++++++++++++++++++++-
 drivers/clk/rockchip/clk.h     |   15 ++-
 2 files changed, 292 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/rockchip/clk-pll.c b/drivers/clk/rockchip/clk-pll.c
index 27be66a..c6996be 100644
--- a/drivers/clk/rockchip/clk-pll.c
+++ b/drivers/clk/rockchip/clk-pll.c
@@ -593,6 +593,275 @@ static const struct clk_ops rockchip_rk3066_pll_clk_ops = {
 	.init = rockchip_rk3066_pll_init,
 };
 
+/**
+ * PLL used in RK3399
+ */
+
+#define RK3399_PLLCON(i)			(i * 0x4)
+#define RK3399_PLLCON0_FBDIV_MASK		0xfff
+#define RK3399_PLLCON0_FBDIV_SHIFT		0
+#define RK3399_PLLCON1_REFDIV_MASK		0x3f
+#define RK3399_PLLCON1_REFDIV_SHIFT		0
+#define RK3399_PLLCON1_POSTDIV1_MASK		0x7
+#define RK3399_PLLCON1_POSTDIV1_SHIFT		8
+#define RK3399_PLLCON1_POSTDIV2_MASK		0x7
+#define RK3399_PLLCON1_POSTDIV2_SHIFT		12
+#define RK3399_PLLCON2_FRAC_MASK		0xffffff
+#define RK3399_PLLCON2_FRAC_SHIFT		0
+#define RK3399_PLLCON3_DSMPD_MASK		0x1
+#define RK3399_PLLCON3_DSMPD_SHIFT		12
+
+#define RK3399_PLLCON2_LOCK_STATUS		(31 << 0)
+#define RK3399_PLLCON3_PWRDOWN			(1 << 0)
+
+static int rockchip_rk3399_pll_wait_lock(struct rockchip_clk_pll *pll)
+{
+	u32 pllcon;
+	int delay = 24000000;
+
+	/* poll check the lock status in rk3399 xPLLCON2 */
+	while (delay > 0) {
+		pllcon = readl_relaxed(pll->reg_base + RK3399_PLLCON(2));
+		if (pllcon & RK3399_PLLCON2_LOCK_STATUS)
+			return 0;
+
+		delay--;
+	}
+
+	pr_err("%s: timeout waiting for pll to lock\n", __func__);
+	return -ETIMEDOUT;
+}
+
+static void rockchip_rk3399_pll_get_params(struct rockchip_clk_pll *pll,
+					struct rockchip_pll_rate_table *rate)
+{
+	u32 pllcon;
+
+	pllcon = readl_relaxed(pll->reg_base + RK3399_PLLCON(0));
+	rate->fbdiv = ((pllcon >> RK3399_PLLCON0_FBDIV_SHIFT)
+				& RK3399_PLLCON0_FBDIV_MASK);
+
+	pllcon = readl_relaxed(pll->reg_base + RK3399_PLLCON(1));
+	rate->refdiv = ((pllcon >> RK3399_PLLCON1_REFDIV_SHIFT)
+				& RK3399_PLLCON1_REFDIV_MASK);
+	rate->postdiv1 = ((pllcon >> RK3399_PLLCON1_POSTDIV1_SHIFT)
+				& RK3399_PLLCON1_POSTDIV1_MASK);
+	rate->postdiv2 = ((pllcon >> RK3399_PLLCON1_POSTDIV2_SHIFT)
+				& RK3399_PLLCON1_POSTDIV2_MASK);
+
+	pllcon = readl_relaxed(pll->reg_base + RK3399_PLLCON(2));
+	rate->frac = ((pllcon >> RK3399_PLLCON2_FRAC_SHIFT)
+				& RK3399_PLLCON2_FRAC_MASK);
+
+	pllcon = readl_relaxed(pll->reg_base + RK3399_PLLCON(3));
+	rate->dsmpd = ((pllcon >> RK3399_PLLCON3_DSMPD_SHIFT)
+				& RK3399_PLLCON3_DSMPD_MASK);
+}
+
+static unsigned long rockchip_rk3399_pll_recalc_rate(struct clk_hw *hw,
+						     unsigned long prate)
+{
+	struct rockchip_clk_pll *pll = to_rockchip_clk_pll(hw);
+	struct rockchip_pll_rate_table cur;
+	u64 rate64 = prate;
+
+	rockchip_rk3399_pll_get_params(pll, &cur);
+
+	rate64 *= cur.fbdiv;
+	do_div(rate64, cur.refdiv);
+
+	if (cur.dsmpd == 0) {
+		/* fractional mode */
+		u64 frac_rate64 = prate * cur.frac;
+
+		do_div(frac_rate64, cur.refdiv);
+		rate64 += frac_rate64 >> 24;
+	}
+
+	do_div(rate64, cur.postdiv1);
+	do_div(rate64, cur.postdiv2);
+
+	return (unsigned long)rate64;
+}
+
+static int rockchip_rk3399_pll_set_params(struct rockchip_clk_pll *pll,
+				const struct rockchip_pll_rate_table *rate)
+{
+	const struct clk_ops *pll_mux_ops = pll->pll_mux_ops;
+	struct clk_mux *pll_mux = &pll->pll_mux;
+	struct rockchip_pll_rate_table cur;
+	u32 pllcon;
+	int rate_change_remuxed = 0;
+	int cur_parent;
+	int ret;
+
+	pr_debug("%s: rate settings for %lu fbdiv: %d, postdiv1: %d, refdiv: %d, postdiv2: %d, dsmpd: %d, frac: %d\n",
+		__func__, rate->rate, rate->fbdiv, rate->postdiv1, rate->refdiv,
+		rate->postdiv2, rate->dsmpd, rate->frac);
+
+	rockchip_rk3399_pll_get_params(pll, &cur);
+	cur.rate = 0;
+
+	cur_parent = pll_mux_ops->get_parent(&pll_mux->hw);
+	if (cur_parent == PLL_MODE_NORM) {
+		pll_mux_ops->set_parent(&pll_mux->hw, PLL_MODE_SLOW);
+		rate_change_remuxed = 1;
+	}
+
+	/* update pll values */
+	writel_relaxed(HIWORD_UPDATE(rate->fbdiv, RK3399_PLLCON0_FBDIV_MASK,
+					  RK3399_PLLCON0_FBDIV_SHIFT),
+		       pll->reg_base + RK3399_PLLCON(0));
+
+	writel_relaxed(HIWORD_UPDATE(rate->refdiv, RK3399_PLLCON1_REFDIV_MASK,
+						   RK3399_PLLCON1_REFDIV_SHIFT) |
+		       HIWORD_UPDATE(rate->postdiv1, RK3399_PLLCON1_POSTDIV1_MASK,
+					     RK3399_PLLCON1_POSTDIV1_SHIFT) |
+		       HIWORD_UPDATE(rate->postdiv2, RK3399_PLLCON1_POSTDIV2_MASK,
+						     RK3399_PLLCON1_POSTDIV2_SHIFT),
+		       pll->reg_base + RK3399_PLLCON(1));
+
+	/* GPLL CON2 is not HIWORD_MASK */
+	pllcon = readl_relaxed(pll->reg_base + RK3399_PLLCON(2));
+	pllcon &= ~(RK3399_PLLCON2_FRAC_MASK << RK3399_PLLCON2_FRAC_SHIFT);
+	pllcon |= rate->frac << RK3399_PLLCON2_FRAC_SHIFT;
+	writel_relaxed(pllcon, pll->reg_base + RK3399_PLLCON(2));
+
+	writel_relaxed(HIWORD_UPDATE(rate->dsmpd, RK3399_PLLCON3_DSMPD_MASK,
+					    RK3399_PLLCON3_DSMPD_SHIFT),
+		       pll->reg_base + RK3399_PLLCON(3));
+
+	/* wait for the pll to lock */
+	ret = rockchip_rk3399_pll_wait_lock(pll);
+	if (ret) {
+		pr_warn("%s: pll update unsucessful, trying to restore old params\n",
+			__func__);
+		rockchip_rk3399_pll_set_params(pll, &cur);
+	}
+
+	if (rate_change_remuxed)
+		pll_mux_ops->set_parent(&pll_mux->hw, PLL_MODE_NORM);
+
+	return ret;
+}
+
+static int rockchip_rk3399_pll_set_rate(struct clk_hw *hw, unsigned long drate,
+					unsigned long prate)
+{
+	struct rockchip_clk_pll *pll = to_rockchip_clk_pll(hw);
+	const struct rockchip_pll_rate_table *rate;
+	unsigned long old_rate = rockchip_rk3399_pll_recalc_rate(hw, prate);
+	struct regmap *grf = rockchip_clk_get_grf(pll->ctx);
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
+	return rockchip_rk3399_pll_set_params(pll, rate);
+}
+
+static int rockchip_rk3399_pll_enable(struct clk_hw *hw)
+{
+	struct rockchip_clk_pll *pll = to_rockchip_clk_pll(hw);
+
+	writel(HIWORD_UPDATE(0, RK3399_PLLCON3_PWRDOWN, 0),
+	       pll->reg_base + RK3399_PLLCON(3));
+
+	return 0;
+}
+
+static void rockchip_rk3399_pll_disable(struct clk_hw *hw)
+{
+	struct rockchip_clk_pll *pll = to_rockchip_clk_pll(hw);
+
+	writel(HIWORD_UPDATE(RK3399_PLLCON3_PWRDOWN,
+			     RK3399_PLLCON3_PWRDOWN, 0),
+	       pll->reg_base + RK3399_PLLCON(3));
+}
+
+static int rockchip_rk3399_pll_is_enabled(struct clk_hw *hw)
+{
+	struct rockchip_clk_pll *pll = to_rockchip_clk_pll(hw);
+	u32 pllcon = readl(pll->reg_base + RK3399_PLLCON(3));
+
+	return !(pllcon & RK3399_PLLCON3_PWRDOWN);
+}
+
+static void rockchip_rk3399_pll_init(struct clk_hw *hw)
+{
+	struct rockchip_clk_pll *pll = to_rockchip_clk_pll(hw);
+	const struct rockchip_pll_rate_table *rate;
+	struct rockchip_pll_rate_table cur;
+	unsigned long drate;
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
+	rockchip_rk3399_pll_get_params(pll, &cur);
+
+	pr_debug("%s: pll %s@%lu: Hz\n", __func__, __clk_get_name(hw->clk),
+		 drate);
+	pr_debug("old - fbdiv: %d, postdiv1: %d, refdiv: %d, postdiv2: %d, dsmpd: %d, frac: %d\n",
+		 cur.fbdiv, cur.postdiv1, cur.refdiv, cur.postdiv2,
+		 cur.dsmpd, cur.frac);
+	pr_debug("new - fbdiv: %d, postdiv1: %d, refdiv: %d, postdiv2: %d, dsmpd: %d, frac: %d\n",
+		 rate->fbdiv, rate->postdiv1, rate->refdiv, rate->postdiv2,
+		 rate->dsmpd, rate->frac);
+
+	if (rate->fbdiv != cur.fbdiv || rate->postdiv1 != cur.postdiv1 ||
+		rate->refdiv != cur.refdiv || rate->postdiv2 != cur.postdiv2 ||
+		rate->dsmpd != cur.dsmpd || rate->frac != cur.frac) {
+		struct clk *parent = clk_get_parent(hw->clk);
+
+		if (!parent) {
+			pr_warn("%s: parent of %s not available\n",
+				__func__, __clk_get_name(hw->clk));
+			return;
+		}
+
+		pr_debug("%s: pll %s: rate params do not match rate table, adjusting\n",
+			 __func__, __clk_get_name(hw->clk));
+		rockchip_rk3399_pll_set_params(pll, rate);
+	}
+}
+
+static const struct clk_ops rockchip_rk3399_pll_clk_norate_ops = {
+	.recalc_rate = rockchip_rk3399_pll_recalc_rate,
+	.enable = rockchip_rk3399_pll_enable,
+	.disable = rockchip_rk3399_pll_disable,
+	.is_enabled = rockchip_rk3399_pll_is_enabled,
+};
+
+static const struct clk_ops rockchip_rk3399_pll_clk_ops = {
+	.recalc_rate = rockchip_rk3399_pll_recalc_rate,
+	.round_rate = rockchip_pll_round_rate,
+	.set_rate = rockchip_rk3399_pll_set_rate,
+	.enable = rockchip_rk3399_pll_enable,
+	.disable = rockchip_rk3399_pll_disable,
+	.is_enabled = rockchip_rk3399_pll_is_enabled,
+	.init = rockchip_rk3399_pll_init,
+};
+
 /*
  * Common registering of pll clocks
  */
@@ -634,7 +903,9 @@ struct clk *rockchip_clk_register_pll(struct rockchip_clk_provider *ctx,
 	pll_mux->lock = &ctx->lock;
 	pll_mux->hw.init = &init;
 
-	if (pll_type == pll_rk3036 || pll_type == pll_rk3066)
+	if (pll_type == pll_rk3036 ||
+	    pll_type == pll_rk3066 ||
+	    pll_type == pll_rk3399)
 		pll_mux->flags |= CLK_MUX_HIWORD_MASK;
 
 	/* the actual muxing is xin24m, pll-output, xin32k */
@@ -691,6 +962,12 @@ struct clk *rockchip_clk_register_pll(struct rockchip_clk_provider *ctx,
 		else
 			init.ops = &rockchip_rk3066_pll_clk_ops;
 		break;
+	case pll_rk3399:
+		if (!pll->rate_table)
+			init.ops = &rockchip_rk3399_pll_clk_norate_ops;
+		else
+			init.ops = &rockchip_rk3399_pll_clk_ops;
+		break;
 	default:
 		pr_warn("%s: Unknown pll type for pll clk %s\n",
 			__func__, name);
diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
index b7affb6..36b4938 100644
--- a/drivers/clk/rockchip/clk.h
+++ b/drivers/clk/rockchip/clk.h
@@ -96,6 +96,7 @@ struct clk;
 enum rockchip_pll_type {
 	pll_rk3036,
 	pll_rk3066,
+	pll_rk3399,
 };
 
 #define RK3036_PLL_RATE(_rate, _refdiv, _fbdiv, _postdiv1,	\
@@ -128,6 +129,18 @@ enum rockchip_pll_type {
 	.nb = _nb,						\
 }
 
+#define RK3399_PLL_RATE(_rate, _refdiv, _fbdiv, _postdiv1,	\
+			_postdiv2, _dsmpd, _frac)		\
+{								\
+	.rate	= _rate##U,					\
+	.fbdiv = _fbdiv,					\
+	.postdiv1 = _postdiv1,					\
+	.refdiv = _refdiv,					\
+	.postdiv2 = _postdiv2,					\
+	.dsmpd = _dsmpd,					\
+	.frac = _frac,						\
+}
+
 /**
  * struct rockchip_clk_provider: information about clock provider
  * @reg_base: virtual address for the register base.
@@ -148,7 +161,7 @@ struct rockchip_pll_rate_table {
 	unsigned int nf;
 	unsigned int no;
 	unsigned int nb;
-	/* for RK3036 */
+	/* for RK3036/RK3399 */
 	unsigned int fbdiv;
 	unsigned int postdiv1;
 	unsigned int refdiv;
-- 
1.7.9.5
