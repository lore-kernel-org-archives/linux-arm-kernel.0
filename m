From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 01 Oct 2015 01:32:19 +0200
Subject: [PATCH v2 4/9] clk: rockchip: add new clock type and controller
 for rk3036
In-Reply-To: <20150922231900.GL23081@codeaurora.org>
References: <1442478540-15068-1-git-send-email-zhengxing@rock-chips.com>
 <2850967.rjRj3AZerS@diego> <20150922231900.GL23081@codeaurora.org>
Message-ID: <4123121.bNYOPIrL2s@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

Am Dienstag, 22. September 2015, 16:19:00 schrieb Stephen Boyd:
> On 09/23, Heiko St?bner wrote:
> > Am Dienstag, 22. September 2015, 15:41:25 schrieb Stephen Boyd:
> > > On 09/17, Xing Zheng wrote:
> > > > +
> > > > +static void rockchip_rk3036_pll_init(struct clk_hw *hw)
> > > 
> > > init ops are "discouraged". Could we do this through assigned
> > > rates instead?
> > 
> > really? According to Mike that was a valid use-case when we looked for an
> > initial place for that on the rk3288 :-) .
> 
> A comment in clk.c indicates init ops are discouraged. Maybe this
> is a valid use-case on other platforms so it was allowed, but
> pretty much every time we see a new init op we have to think
> about it and justify it. Hooray!

for the rk3288-variant Mike said
"Looks good to me. I think rk3xxx might be the first user of the .init
callback!" [0]
so it looks like he was convinced of our reasoning at the time :-) .


[0] http://lists.infradead.org/pipermail/linux-rockchip/2014-November/001570.html


> > > > +{
> > > > +	struct rockchip_clk_pll *pll = to_rockchip_clk_pll(hw);
> > > > +	const struct rockchip_pll_rate_table *rate;
> > > > +	unsigned int fbdiv, postdiv1, refdiv, postdiv2, dsmpd, frac;
> > > > +	unsigned long drate;
> > > > +	u32 pllcon;
> > > > +
> > > > +	if (!(pll->flags & ROCKCHIP_PLL_SYNC_RATE))
> > > > +		return;
> > > 
> > > I don't understand what this one does though. This check isn't in
> > > the set rate ops.
> > 
> > And it shouldn't be :-)
> > 
> > The issue this whole thing is trying to solve is aligning the pll settings
> > which what we have in the rate table, not what the bootloader set.
> > 
> > For example the bootloader could set up a pll at 594MHz with one set of
> > parameters and after some time - when you don't want to exchange
> > bootloaders on shipping devices anymore - it comes to light that a
> > different set of parameters for the same frequency produces for example a
> > more stable hdmi signal [I think that was the main reason for the initial
> > change].
> > 
> > So we're not changing the frequency x -> y, which could be easily done
> > [and is done already] via assigned-rates, but instead
> > 
> > 	x {params a,b,c} -> x {params d,e,f}
> > 
> > so the rate itself stays the same, only the frequency generation is
> > adapted.
> Ok. It would be nice if this sort of information was made into a
> comment and put in the code. Or at least the commit text for the
> change.
> 
> And is there any reason that we need to get the parent clock and
> parent rate to align the PLL settings?
> It would be nice if we
> avoided using clk_* APIs in here, by extracting the pll set rate
> code into another function that we can call from init to make the
> values the same without all the fallback to old rates, etc.

I guess you want Xing Zheng to change his pll code somewhat like the
following, right? While starting off as proof-of-concept, that change
below actually does work quite nicely on rk3288 boards.

---------------- 8< --------------------
From: Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH] clk: rockchip: don't use clk_ APIs in the pll init-callback

Separate the update of pll registers from the actual set_rate function
so that the init callback does not need to access clk-API functions.

As we now have separated the getting and setting of the pll parameters
we can also directly use these new functions in other places too.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/rockchip/clk-pll.c | 135 ++++++++++++++++++++++-------------------
 1 file changed, 74 insertions(+), 61 deletions(-)

diff --git a/drivers/clk/rockchip/clk-pll.c b/drivers/clk/rockchip/clk-pll.c
index 7737a1d..4881eb8 100644
--- a/drivers/clk/rockchip/clk-pll.c
+++ b/drivers/clk/rockchip/clk-pll.c
@@ -126,11 +126,32 @@ static int rockchip_pll_wait_lock(struct rockchip_clk_pll *pll)
 #define RK3066_PLLCON3_PWRDOWN		(1 << 1)
 #define RK3066_PLLCON3_BYPASS		(1 << 0)
 
+static void rockchip_rk3066_pll_get_params(struct rockchip_clk_pll *pll,
+					struct rockchip_pll_rate_table *rate)
+{
+	u32 pllcon;
+
+	pllcon = readl_relaxed(pll->reg_base + RK3066_PLLCON(0));
+	rate->nr = ((pllcon >> RK3066_PLLCON0_NR_SHIFT)
+				& RK3066_PLLCON0_NR_MASK) + 1;
+	rate->no = ((pllcon >> RK3066_PLLCON0_OD_SHIFT)
+				& RK3066_PLLCON0_OD_MASK) + 1;
+
+	pllcon = readl_relaxed(pll->reg_base + RK3066_PLLCON(1));
+	rate->nf = ((pllcon >> RK3066_PLLCON1_NF_SHIFT)
+				& RK3066_PLLCON1_NF_MASK) + 1;
+
+	pllcon = readl_relaxed(pll->reg_base + RK3066_PLLCON(2));
+	rate->nb = ((pllcon >> RK3066_PLLCON2_NB_SHIFT)
+				& RK3066_PLLCON2_NB_MASK) + 1;
+}
+
 static unsigned long rockchip_rk3066_pll_recalc_rate(struct clk_hw *hw,
 						     unsigned long prate)
 {
 	struct rockchip_clk_pll *pll = to_rockchip_clk_pll(hw);
-	u64 nf, nr, no, rate64 = prate;
+	struct rockchip_pll_rate_table cur;
+	u64 rate64 = prate;
 	u32 pllcon;
 
 	pllcon = readl_relaxed(pll->reg_base + RK3066_PLLCON(3));
@@ -140,53 +161,31 @@ static unsigned long rockchip_rk3066_pll_recalc_rate(struct clk_hw *hw,
 		return prate;
 	}
 
-	pllcon = readl_relaxed(pll->reg_base + RK3066_PLLCON(1));
-	nf = (pllcon >> RK3066_PLLCON1_NF_SHIFT) & RK3066_PLLCON1_NF_MASK;
-
-	pllcon = readl_relaxed(pll->reg_base + RK3066_PLLCON(0));
-	nr = (pllcon >> RK3066_PLLCON0_NR_SHIFT) & RK3066_PLLCON0_NR_MASK;
-	no = (pllcon >> RK3066_PLLCON0_OD_SHIFT) & RK3066_PLLCON0_OD_MASK;
+	rockchip_rk3066_pll_get_params(pll, &cur);
 
-	rate64 *= (nf + 1);
-	do_div(rate64, nr + 1);
-	do_div(rate64, no + 1);
+	rate64 *= cur.nf;
+	do_div(rate64, cur.nr);
+	do_div(rate64, cur.no);
 
 	return (unsigned long)rate64;
 }
 
-static int rockchip_rk3066_pll_set_rate(struct clk_hw *hw, unsigned long drate,
-					unsigned long prate)
+static int rockchip_rk3066_pll_set_params(struct rockchip_clk_pll *pll,
+				const struct rockchip_pll_rate_table *rate)
 {
-	struct rockchip_clk_pll *pll = to_rockchip_clk_pll(hw);
-	const struct rockchip_pll_rate_table *rate;
-	unsigned long old_rate = rockchip_rk3066_pll_recalc_rate(hw, prate);
-	struct regmap *grf = rockchip_clk_get_grf();
-	struct clk_mux *pll_mux = &pll->pll_mux;
 	const struct clk_ops *pll_mux_ops = pll->pll_mux_ops;
+	struct clk_mux *pll_mux = &pll->pll_mux;
+	struct rockchip_pll_rate_table cur;
 	int rate_change_remuxed = 0;
 	int cur_parent;
 	int ret;
 
-	if (IS_ERR(grf)) {
-		pr_debug("%s: grf regmap not available, aborting rate change\n",
-			 __func__);
-		return PTR_ERR(grf);
-	}
-
-	pr_debug("%s: changing %s from %lu to %lu with a parent rate of %lu\n",
-		 __func__, clk_hw_get_name(hw), old_rate, drate, prate);
-
-	/* Get required rate settings from table */
-	rate = rockchip_get_pll_settings(pll, drate);
-	if (!rate) {
-		pr_err("%s: Invalid rate : %lu for pll clk %s\n", __func__,
-			drate, clk_hw_get_name(hw));
-		return -EINVAL;
-	}
-
 	pr_debug("%s: rate settings for %lu (nr, no, nf): (%d, %d, %d)\n",
 		 __func__, rate->rate, rate->nr, rate->no, rate->nf);
 
+	rockchip_rk3066_pll_get_params(pll, &cur);
+	cur.rate = 0;
+
 	cur_parent = pll_mux_ops->get_parent(&pll_mux->hw);
 	if (cur_parent == PLL_MODE_NORM) {
 		pll_mux_ops->set_parent(&pll_mux->hw, PLL_MODE_SLOW);
@@ -219,9 +218,9 @@ static int rockchip_rk3066_pll_set_rate(struct clk_hw *hw, unsigned long drate,
 	/* wait for the pll to lock */
 	ret = rockchip_pll_wait_lock(pll);
 	if (ret) {
-		pr_warn("%s: pll did not lock, trying to restore old rate %lu\n",
-			__func__, old_rate);
-		rockchip_rk3066_pll_set_rate(hw, old_rate, prate);
+		pr_warn("%s: pll update unsucessful, trying to restore old params\n",
+			__func__);
+		rockchip_rk3066_pll_set_params(pll, &cur);
 	}
 
 	if (rate_change_remuxed)
@@ -230,6 +229,34 @@ static int rockchip_rk3066_pll_set_rate(struct clk_hw *hw, unsigned long drate,
 	return ret;
 }
 
+static int rockchip_rk3066_pll_set_rate(struct clk_hw *hw, unsigned long drate,
+					unsigned long prate)
+{
+	struct rockchip_clk_pll *pll = to_rockchip_clk_pll(hw);
+	const struct rockchip_pll_rate_table *rate;
+	unsigned long old_rate = rockchip_rk3066_pll_recalc_rate(hw, prate);
+	struct regmap *grf = rockchip_clk_get_grf();
+
+	if (IS_ERR(grf)) {
+		pr_debug("%s: grf regmap not available, aborting rate change\n",
+			 __func__);
+		return PTR_ERR(grf);
+	}
+
+	pr_debug("%s: changing %s from %lu to %lu with a parent rate of %lu\n",
+		 __func__, clk_hw_get_name(hw), old_rate, drate, prate);
+
+	/* Get required rate settings from table */
+	rate = rockchip_get_pll_settings(pll, drate);
+	if (!rate) {
+		pr_err("%s: Invalid rate : %lu for pll clk %s\n", __func__,
+			drate, clk_hw_get_name(hw));
+		return -EINVAL;
+	}
+
+	return rockchip_rk3066_pll_set_params(pll, rate);
+}
+
 static int rockchip_rk3066_pll_enable(struct clk_hw *hw)
 {
 	struct rockchip_clk_pll *pll = to_rockchip_clk_pll(hw);
@@ -261,9 +288,8 @@ static void rockchip_rk3066_pll_init(struct clk_hw *hw)
 {
 	struct rockchip_clk_pll *pll = to_rockchip_clk_pll(hw);
 	const struct rockchip_pll_rate_table *rate;
-	unsigned int nf, nr, no, nb;
+	struct rockchip_pll_rate_table cur;
 	unsigned long drate;
-	u32 pllcon;
 
 	if (!(pll->flags & ROCKCHIP_PLL_SYNC_RATE))
 		return;
@@ -275,34 +301,21 @@ static void rockchip_rk3066_pll_init(struct clk_hw *hw)
 	if (!rate)
 		return;
 
-	pllcon = readl_relaxed(pll->reg_base + RK3066_PLLCON(0));
-	nr = ((pllcon >> RK3066_PLLCON0_NR_SHIFT) & RK3066_PLLCON0_NR_MASK) + 1;
-	no = ((pllcon >> RK3066_PLLCON0_OD_SHIFT) & RK3066_PLLCON0_OD_MASK) + 1;
-
-	pllcon = readl_relaxed(pll->reg_base + RK3066_PLLCON(1));
-	nf = ((pllcon >> RK3066_PLLCON1_NF_SHIFT) & RK3066_PLLCON1_NF_MASK) + 1;
-
-	pllcon = readl_relaxed(pll->reg_base + RK3066_PLLCON(2));
-	nb = ((pllcon >> RK3066_PLLCON2_NB_SHIFT) & RK3066_PLLCON2_NB_MASK) + 1;
+	rockchip_rk3066_pll_get_params(pll, &cur);
 
 	pr_debug("%s: pll %s@%lu: nr (%d:%d); no (%d:%d); nf(%d:%d), nb(%d:%d)\n",
-		 __func__, clk_hw_get_name(hw), drate, rate->nr, nr,
-		rate->no, no, rate->nf, nf, rate->nb, nb);
-	if (rate->nr != nr || rate->no != no || rate->nf != nf
-					     || rate->nb != nb) {
-		struct clk_hw *parent = clk_hw_get_parent(hw);
-		unsigned long prate;
-
-		if (!parent) {
-			pr_warn("%s: parent of %s not available\n",
-				__func__, clk_hw_get_name(hw));
+		 __func__, clk_hw_get_name(hw), drate, rate->nr, cur.nr,
+		 rate->no, cur.no, rate->nf, cur.nf, rate->nb, cur.nb);
+	if (rate->nr != cur.nr || rate->no != cur.no || rate->nf != cur.nf
+						     || rate->nb != cur.nb) {
+		struct regmap *grf = rockchip_clk_get_grf();
+
+		if (IS_ERR(grf))
 			return;
-		}
 
 		pr_debug("%s: pll %s: rate params do not match rate table, adjusting\n",
 			 __func__, clk_hw_get_name(hw));
-		prate = clk_hw_get_rate(parent);
-		rockchip_rk3066_pll_set_rate(hw, drate, prate);
+		rockchip_rk3066_pll_set_params(pll, rate);
 	}
 }
 
-- 
2.5.3
---------------- 8< --------------------

Heiko
