From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 18 Sep 2014 00:12:47 +0200
Subject: [PATCH v3 1/8] clk: rockchip: change pll rate without a clk-notifier
In-Reply-To: <1410991974-12235-1-git-send-email-heiko@sntech.de>
References: <1410991974-12235-1-git-send-email-heiko@sntech.de>
Message-ID: <1410991974-12235-2-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Doug Anderson <dianders@chromium.org>

The Rockchip PLL code switches into slow mode (AKA bypass more AKA
24MHz mode) before actually changing the PLL.  This keeps anyone from
using the PLL while it's changing.  However, in all known Rockchip
SoCs nobody should ever see the 24MHz when changing the PLL supplying
the armclk because we should reparent children to an alternate
(faster than 24MHz) PLL.

One problem is that the code to switch to an alternate parent was
running in PRE_RATE_CHANGE.  ...and the code to switch to slow mode
was _also_ running in PRE_RATE_CHANGE.  That meant there was no real
guarantee that we would switch to an alternate parent before switching
to 24MHz mode.

Let's move the switch to "slow mode" straight into
rockchip_rk3066_pll_set_rate().  That means we're guaranteed that the
24MHz is really a last-resort.

Note that without this change on real systems we were the code to
switch to an alternate parent at 24MHz.  In some older versions of
that code we'd appy a (temporary) / 5 to the 24MHz causing us to run
at 4.8MHz.  That wasn't enough to service USB interrupts in some cases
and could lead to a system hang.

Signed-off-by: Doug Anderson <dianders@chromium.org>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/rockchip/clk-pll.c | 63 +++++++++---------------------------------
 1 file changed, 13 insertions(+), 50 deletions(-)

diff --git a/drivers/clk/rockchip/clk-pll.c b/drivers/clk/rockchip/clk-pll.c
index f2a1c7a..a3e886a 100644
--- a/drivers/clk/rockchip/clk-pll.c
+++ b/drivers/clk/rockchip/clk-pll.c
@@ -34,7 +34,6 @@ struct rockchip_clk_pll {
 	const struct clk_ops	*pll_mux_ops;
 
 	struct notifier_block	clk_nb;
-	bool			rate_change_remuxed;
 
 	void __iomem		*reg_base;
 	int			lock_offset;
@@ -109,38 +108,6 @@ static int rockchip_pll_wait_lock(struct rockchip_clk_pll *pll)
 }
 
 /**
- * Set pll mux when changing the pll rate.
- * This makes sure to move the pll mux away from the actual pll before
- * changing its rate and back to the original parent after the change.
- */
-static int rockchip_pll_notifier_cb(struct notifier_block *nb,
-					unsigned long event, void *data)
-{
-	struct rockchip_clk_pll *pll = to_rockchip_clk_pll_nb(nb);
-	struct clk_mux *pll_mux = &pll->pll_mux;
-	const struct clk_ops *pll_mux_ops = pll->pll_mux_ops;
-	int cur_parent;
-
-	switch (event) {
-	case PRE_RATE_CHANGE:
-		cur_parent = pll_mux_ops->get_parent(&pll_mux->hw);
-		if (cur_parent == PLL_MODE_NORM) {
-			pll_mux_ops->set_parent(&pll_mux->hw, PLL_MODE_SLOW);
-			pll->rate_change_remuxed = 1;
-		}
-		break;
-	case POST_RATE_CHANGE:
-		if (pll->rate_change_remuxed) {
-			pll_mux_ops->set_parent(&pll_mux->hw, PLL_MODE_NORM);
-			pll->rate_change_remuxed = 0;
-		}
-		break;
-	}
-
-	return NOTIFY_OK;
-}
-
-/**
  * PLL used in RK3066, RK3188 and RK3288
  */
 
@@ -194,6 +161,10 @@ static int rockchip_rk3066_pll_set_rate(struct clk_hw *hw, unsigned long drate,
 	const struct rockchip_pll_rate_table *rate;
 	unsigned long old_rate = rockchip_rk3066_pll_recalc_rate(hw, prate);
 	struct regmap *grf = rockchip_clk_get_grf();
+	struct clk_mux *pll_mux = &pll->pll_mux;
+	const struct clk_ops *pll_mux_ops = pll->pll_mux_ops;
+	int rate_change_remuxed = 0;
+	int cur_parent;
 	int ret;
 
 	if (IS_ERR(grf)) {
@@ -216,6 +187,12 @@ static int rockchip_rk3066_pll_set_rate(struct clk_hw *hw, unsigned long drate,
 	pr_debug("%s: rate settings for %lu (nr, no, nf): (%d, %d, %d)\n",
 		 __func__, rate->rate, rate->nr, rate->no, rate->nf);
 
+	cur_parent = pll_mux_ops->get_parent(&pll_mux->hw);
+	if (cur_parent == PLL_MODE_NORM) {
+		pll_mux_ops->set_parent(&pll_mux->hw, PLL_MODE_SLOW);
+		rate_change_remuxed = 1;
+	}
+
 	/* enter reset mode */
 	writel(HIWORD_UPDATE(RK3066_PLLCON3_RESET, RK3066_PLLCON3_RESET, 0),
 	       pll->reg_base + RK3066_PLLCON(3));
@@ -247,6 +224,9 @@ static int rockchip_rk3066_pll_set_rate(struct clk_hw *hw, unsigned long drate,
 		rockchip_rk3066_pll_set_rate(hw, old_rate, prate);
 	}
 
+	if (rate_change_remuxed)
+		pll_mux_ops->set_parent(&pll_mux->hw, PLL_MODE_NORM);
+
 	return ret;
 }
 
@@ -310,7 +290,6 @@ struct clk *rockchip_clk_register_pll(enum rockchip_pll_type pll_type,
 	struct clk_mux *pll_mux;
 	struct clk *pll_clk, *mux_clk;
 	char pll_name[20];
-	int ret;
 
 	if (num_parents != 2) {
 		pr_err("%s: needs two parent clocks\n", __func__);
@@ -367,7 +346,6 @@ struct clk *rockchip_clk_register_pll(enum rockchip_pll_type pll_type,
 	pll->lock_offset = grf_lock_offset;
 	pll->lock_shift = lock_shift;
 	pll->lock = lock;
-	pll->clk_nb.notifier_call = rockchip_pll_notifier_cb;
 
 	pll_clk = clk_register(NULL, &pll->hw);
 	if (IS_ERR(pll_clk)) {
@@ -377,14 +355,6 @@ struct clk *rockchip_clk_register_pll(enum rockchip_pll_type pll_type,
 		goto err_pll;
 	}
 
-	ret = clk_notifier_register(pll_clk, &pll->clk_nb);
-	if (ret) {
-		pr_err("%s: failed to register clock notifier for %s : %d\n",
-				__func__, name, ret);
-		mux_clk = ERR_PTR(ret);
-		goto err_pll_notifier;
-	}
-
 	/* create the mux on top of the real pll */
 	pll->pll_mux_ops = &clk_mux_ops;
 	pll_mux = &pll->pll_mux;
@@ -417,13 +387,6 @@ struct clk *rockchip_clk_register_pll(enum rockchip_pll_type pll_type,
 	return mux_clk;
 
 err_mux:
-	ret = clk_notifier_unregister(pll_clk, &pll->clk_nb);
-	if (ret) {
-		pr_err("%s: could not unregister clock notifier in error path : %d\n",
-		       __func__, ret);
-		return mux_clk;
-	}
-err_pll_notifier:
 	clk_unregister(pll_clk);
 err_pll:
 	kfree(pll);
-- 
2.0.1
