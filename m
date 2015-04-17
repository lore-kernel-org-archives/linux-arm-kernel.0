From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 17 Apr 2015 09:29:29 +0200
Subject: [PATCH 2/2] clk: change clk_ops' ->determine_rate() prototype
In-Reply-To: <1429255769-13639-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1429255769-13639-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1429255769-13639-3-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clock rates are stored in an unsigned long field, but ->determine_rate()
(which returns a rounded rate from a requested one) returns a long
value (errors are reported using negative error codes), which can lead
to long overflow if the clock rate exceed 2Ghz.

Change ->determine_rate() prototype to return 0 or an error code, and pass
the requested rate as a pointer so that it can be adjusted depending on
hardware capabilities.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
CC: Jonathan Corbet <corbet@lwn.net>
CC: Tony Lindgren <tony@atomide.com>
CC: Ralf Baechle <ralf@linux-mips.org>
CC: "Emilio L?pez" <emilio@elopez.com.ar>
CC: Maxime Ripard <maxime.ripard@free-electrons.com>
CC: Tero Kristo <t-kristo@ti.com>
CC: linux-doc at vger.kernel.org
CC: linux-kernel at vger.kernel.org
CC: linux-arm-kernel at lists.infradead.org
CC: linux-omap at vger.kernel.org
CC: linux-mips at linux-mips.org

 Documentation/clk.txt               |  4 +--
 arch/arm/mach-omap2/dpll3xxx.c      | 20 +++++------
 arch/arm/mach-omap2/dpll44xx.c      | 20 +++++------
 arch/mips/alchemy/common/clock.c    | 63 +++++++++++++++++++++-----------
 drivers/clk/at91/clk-programmable.c | 28 +++++++++------
 drivers/clk/bcm/clk-kona.c          | 24 ++++++++-----
 drivers/clk/clk-composite.c         | 22 ++++++------
 drivers/clk/clk.c                   | 72 +++++++++++++++++++++----------------
 drivers/clk/hisilicon/clk-hi3620.c  | 22 ++++++------
 drivers/clk/mmp/clk-mix.c           | 17 ++++-----
 drivers/clk/qcom/clk-pll.c          | 12 ++++---
 drivers/clk/qcom/clk-rcg.c          | 32 +++++++++--------
 drivers/clk/qcom/clk-rcg2.c         | 55 +++++++++++++++-------------
 drivers/clk/sunxi/clk-factors.c     | 19 +++++-----
 drivers/clk/sunxi/clk-sun6i-ar100.c | 18 ++++++----
 drivers/clk/sunxi/clk-sunxi.c       | 19 +++++-----
 include/linux/clk-provider.h        | 24 ++++++-------
 include/linux/clk/ti.h              | 24 ++++++-------
 18 files changed, 278 insertions(+), 217 deletions(-)

diff --git a/Documentation/clk.txt b/Documentation/clk.txt
index fca8b7a..f5cae13 100644
--- a/Documentation/clk.txt
+++ b/Documentation/clk.txt
@@ -71,8 +71,8 @@ the operations defined in clk.h:
 		int		(*round_rate)(struct clk_hw *hw,
 						unsigned long *rate,
 						unsigned long *parent_rate);
-		long		(*determine_rate)(struct clk_hw *hw,
-						unsigned long rate,
+		int		(*determine_rate)(struct clk_hw *hw,
+						unsigned long *rate,
 						unsigned long min_rate,
 						unsigned long max_rate,
 						unsigned long *best_parent_rate,
diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index 7a6fb45..cfa24fd 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -472,37 +472,37 @@ void omap3_noncore_dpll_disable(struct clk_hw *hw)
  * Returns a positive clock rate with success, negative error value
  * in failure.
  */
-long omap3_noncore_dpll_determine_rate(struct clk_hw *hw, unsigned long rate,
-				       unsigned long min_rate,
-				       unsigned long max_rate,
-				       unsigned long *best_parent_rate,
-				       struct clk_hw **best_parent_clk)
+int omap3_noncore_dpll_determine_rate(struct clk_hw *hw, unsigned long *rate,
+				      unsigned long min_rate,
+				      unsigned long max_rate,
+				      unsigned long *best_parent_rate,
+				      struct clk_hw **best_parent_clk)
 {
 	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
 	struct dpll_data *dd;
 	int ret;
 
-	if (!hw || !rate)
+	if (!hw || !*rate)
 		return -EINVAL;
 
 	dd = clk->dpll_data;
 	if (!dd)
 		return -EINVAL;
 
-	if (__clk_get_rate(dd->clk_bypass) == rate &&
+	if (__clk_get_rate(dd->clk_bypass) == *rate &&
 	    (dd->modes & (1 << DPLL_LOW_POWER_BYPASS))) {
 		*best_parent_clk = __clk_get_hw(dd->clk_bypass);
 	} else {
-		ret = omap2_dpll_round_rate(hw, &rate, best_parent_rate);
+		ret = omap2_dpll_round_rate(hw, rate, best_parent_rate);
 		if (ret)
 			return ret;
 
 		*best_parent_clk = __clk_get_hw(dd->clk_ref);
 	}
 
-	*best_parent_rate = rate;
+	*best_parent_rate = *rate;
 
-	return rate;
+	return 0;
 }
 
 /**
diff --git a/arch/arm/mach-omap2/dpll44xx.c b/arch/arm/mach-omap2/dpll44xx.c
index afd3284..1571d41 100644
--- a/arch/arm/mach-omap2/dpll44xx.c
+++ b/arch/arm/mach-omap2/dpll44xx.c
@@ -203,28 +203,28 @@ out:
  * Returns a positive clock rate with success, negative error value
  * in failure.
  */
-long omap4_dpll_regm4xen_determine_rate(struct clk_hw *hw, unsigned long rate,
-					unsigned long min_rate,
-					unsigned long max_rate,
-					unsigned long *best_parent_rate,
-					struct clk_hw **best_parent_clk)
+int omap4_dpll_regm4xen_determine_rate(struct clk_hw *hw, unsigned long *rate,
+				       unsigned long min_rate,
+				       unsigned long max_rate,
+				       unsigned long *best_parent_rate,
+				       struct clk_hw **best_parent_clk)
 {
 	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
 	struct dpll_data *dd;
 	int ret;
 
-	if (!hw || !rate)
+	if (!hw || !*rate)
 		return -EINVAL;
 
 	dd = clk->dpll_data;
 	if (!dd)
 		return -EINVAL;
 
-	if (__clk_get_rate(dd->clk_bypass) == rate &&
+	if (__clk_get_rate(dd->clk_bypass) == *rate &&
 	    (dd->modes & (1 << DPLL_LOW_POWER_BYPASS))) {
 		*best_parent_clk = __clk_get_hw(dd->clk_bypass);
 	} else {
-		ret = omap4_dpll_regm4xen_round_rate(hw, &rate,
+		ret = omap4_dpll_regm4xen_round_rate(hw, rate,
 						     best_parent_rate);
 		if (ret)
 			return ret;
@@ -232,7 +232,7 @@ long omap4_dpll_regm4xen_determine_rate(struct clk_hw *hw, unsigned long rate,
 		*best_parent_clk = __clk_get_hw(dd->clk_ref);
 	}
 
-	*best_parent_rate = rate;
+	*best_parent_rate = *rate;
 
-	return rate;
+	return 0;
 }
diff --git a/arch/mips/alchemy/common/clock.c b/arch/mips/alchemy/common/clock.c
index d697d8f..0abcfc6 100644
--- a/arch/mips/alchemy/common/clock.c
+++ b/arch/mips/alchemy/common/clock.c
@@ -565,14 +565,22 @@ static unsigned long alchemy_clk_fgv1_recalc(struct clk_hw *hw,
 	return parent_rate / v;
 }
 
-static long alchemy_clk_fgv1_detr(struct clk_hw *hw, unsigned long rate,
-					unsigned long min_rate,
-					unsigned long max_rate,
-					unsigned long *best_parent_rate,
-					struct clk_hw **best_parent_clk)
+static int alchemy_clk_fgv1_detr(struct clk_hw *hw, unsigned long *rate,
+				 unsigned long min_rate,
+				 unsigned long max_rate,
+				 unsigned long *best_parent_rate,
+				 struct clk_hw **best_parent_clk)
 {
-	return alchemy_clk_fgcs_detr(hw, rate, best_parent_rate,
-				     best_parent_clk, 2, 512);
+	long ret;
+
+	ret = alchemy_clk_fgcs_detr(hw, *rate, best_parent_rate,
+				    best_parent_clk, 2, 512);
+	if (ret < 0)
+		return ret;
+
+	*rate = ret;
+
+	return 0;
 }
 
 /* Au1000, Au1100, Au15x0, Au12x0 */
@@ -699,14 +707,15 @@ static unsigned long alchemy_clk_fgv2_recalc(struct clk_hw *hw,
 	return t;
 }
 
-static long alchemy_clk_fgv2_detr(struct clk_hw *hw, unsigned long rate,
-					unsigned long min_rate,
-					unsigned long max_rate,
-					unsigned long *best_parent_rate,
-					struct clk_hw **best_parent_clk)
+static int alchemy_clk_fgv2_detr(struct clk_hw *hw, unsigned long *rate,
+				 unsigned long min_rate,
+				 unsigned long max_rate,
+				 unsigned long *best_parent_rate,
+				 struct clk_hw **best_parent_clk)
 {
 	struct alchemy_fgcs_clk *c = to_fgcs_clk(hw);
 	int scale, maxdiv;
+	long ret;
 
 	if (alchemy_rdsys(c->reg) & (1 << 30)) {
 		scale = 1;
@@ -716,8 +725,13 @@ static long alchemy_clk_fgv2_detr(struct clk_hw *hw, unsigned long rate,
 		maxdiv = 512;
 	}
 
-	return alchemy_clk_fgcs_detr(hw, rate, best_parent_rate,
-				     best_parent_clk, scale, maxdiv);
+	ret = alchemy_clk_fgcs_detr(hw, *rate, best_parent_rate,
+				    best_parent_clk, scale, maxdiv);
+	if (ret < 0)
+		return ret;
+
+	*rate = ret;
+	return 0;
 }
 
 /* Au1300 larger input mux, no separate disable bit, flexible divider */
@@ -920,17 +934,24 @@ static int alchemy_clk_csrc_setr(struct clk_hw *hw, unsigned long rate,
 	return 0;
 }
 
-static long alchemy_clk_csrc_detr(struct clk_hw *hw, unsigned long rate,
-					unsigned long min_rate,
-					unsigned long max_rate,
-					unsigned long *best_parent_rate,
-					struct clk_hw **best_parent_clk)
+static int alchemy_clk_csrc_detr(struct clk_hw *hw, unsigned long *rate,
+				 unsigned long min_rate,
+				 unsigned long max_rate,
+				 unsigned long *best_parent_rate,
+				 struct clk_hw **best_parent_clk)
 {
 	struct alchemy_fgcs_clk *c = to_fgcs_clk(hw);
 	int scale = c->dt[2] == 3 ? 1 : 2; /* au1300 check */
+	long ret;
 
-	return alchemy_clk_fgcs_detr(hw, rate, best_parent_rate,
-				     best_parent_clk, scale, 4);
+	ret = alchemy_clk_fgcs_detr(hw, *rate, best_parent_rate,
+				    best_parent_clk, scale, 4);
+	if (ret < 0)
+		return ret;
+
+	*rate = ret;
+
+	return 0;
 }
 
 static struct clk_ops alchemy_clkops_csrc = {
diff --git a/drivers/clk/at91/clk-programmable.c b/drivers/clk/at91/clk-programmable.c
index 86c8a07..5f9570d 100644
--- a/drivers/clk/at91/clk-programmable.c
+++ b/drivers/clk/at91/clk-programmable.c
@@ -54,17 +54,18 @@ static unsigned long clk_programmable_recalc_rate(struct clk_hw *hw,
 	return parent_rate >> pres;
 }
 
-static long clk_programmable_determine_rate(struct clk_hw *hw,
-					    unsigned long rate,
-					    unsigned long min_rate,
-					    unsigned long max_rate,
-					    unsigned long *best_parent_rate,
-					    struct clk_hw **best_parent_hw)
+static int clk_programmable_determine_rate(struct clk_hw *hw,
+					   unsigned long *rate,
+					   unsigned long min_rate,
+					   unsigned long max_rate,
+					   unsigned long *best_parent_rate,
+					   struct clk_hw **best_parent_hw)
 {
 	struct clk *parent = NULL;
-	long best_rate = -EINVAL;
 	unsigned long parent_rate;
+	unsigned long best_rate;
 	unsigned long tmp_rate;
+	int ret = -EINVAL;
 	int shift;
 	int i;
 
@@ -76,24 +77,29 @@ static long clk_programmable_determine_rate(struct clk_hw *hw,
 		parent_rate = __clk_get_rate(parent);
 		for (shift = 0; shift < PROG_PRES_MASK; shift++) {
 			tmp_rate = parent_rate >> shift;
-			if (tmp_rate <= rate)
+			if (tmp_rate <= *rate)
 				break;
 		}
 
-		if (tmp_rate > rate)
+		if (tmp_rate > *rate)
 			continue;
 
-		if (best_rate < 0 || (rate - tmp_rate) < (rate - best_rate)) {
+		if (best_rate < 0 || (*rate - tmp_rate) < (*rate - best_rate)) {
 			best_rate = tmp_rate;
 			*best_parent_rate = parent_rate;
 			*best_parent_hw = __clk_get_hw(parent);
+			ret = 0;
 		}
 
 		if (!best_rate)
 			break;
 	}
 
-	return best_rate;
+	if (ret)
+		return ret;
+
+	*rate = best_rate;
+	return 0;
 }
 
 static int clk_programmable_set_parent(struct clk_hw *hw, u8 index)
diff --git a/drivers/clk/bcm/clk-kona.c b/drivers/clk/bcm/clk-kona.c
index 05abae8..4a2a66b 100644
--- a/drivers/clk/bcm/clk-kona.c
+++ b/drivers/clk/bcm/clk-kona.c
@@ -1031,7 +1031,7 @@ static long kona_peri_clk_round_rate(struct clk_hw *hw, unsigned long rate,
 				rate ? rate : 1, *parent_rate, NULL);
 }
 
-static long kona_peri_clk_determine_rate(struct clk_hw *hw, unsigned long rate,
+static int kona_peri_clk_determine_rate(struct clk_hw *hw, unsigned long *rate,
 		unsigned long min_rate,
 		unsigned long max_rate,
 		unsigned long *best_parent_rate, struct clk_hw **best_parent)
@@ -1044,6 +1044,7 @@ static long kona_peri_clk_determine_rate(struct clk_hw *hw, unsigned long rate,
 	unsigned long best_rate;
 	u32 parent_count;
 	u32 which;
+	long ret;
 
 	/*
 	 * If there is no other parent to choose, use the current one.
@@ -1051,14 +1052,20 @@ static long kona_peri_clk_determine_rate(struct clk_hw *hw, unsigned long rate,
 	 */
 	WARN_ON_ONCE(bcm_clk->init_data.flags & CLK_SET_RATE_NO_REPARENT);
 	parent_count = (u32)bcm_clk->init_data.num_parents;
-	if (parent_count < 2)
-		return kona_peri_clk_round_rate(hw, rate, best_parent_rate);
+	if (parent_count < 2) {
+		ret = kona_peri_clk_round_rate(hw, *rate, best_parent_rate);
+		if (ret < 0)
+			return ret;
+
+		*rate = ret;
+		return 0;
+	}
 
 	/* Unless we can do better, stick with current parent */
 	current_parent = clk_get_parent(clk);
 	parent_rate = __clk_get_rate(current_parent);
-	best_rate = kona_peri_clk_round_rate(hw, rate, &parent_rate);
-	best_delta = abs(best_rate - rate);
+	best_rate = kona_peri_clk_round_rate(hw, *rate, &parent_rate);
+	best_delta = abs(best_rate - *rate);
 
 	/* Check whether any other parent clock can produce a better result */
 	for (which = 0; which < parent_count; which++) {
@@ -1072,8 +1079,8 @@ static long kona_peri_clk_determine_rate(struct clk_hw *hw, unsigned long rate,
 
 		/* We don't support CLK_SET_RATE_PARENT */
 		parent_rate = __clk_get_rate(parent);
-		other_rate = kona_peri_clk_round_rate(hw, rate, &parent_rate);
-		delta = abs(other_rate - rate);
+		other_rate = kona_peri_clk_round_rate(hw, *rate, &parent_rate);
+		delta = abs(other_rate - *rate);
 		if (delta < best_delta) {
 			best_delta = delta;
 			best_rate = other_rate;
@@ -1082,7 +1089,8 @@ static long kona_peri_clk_determine_rate(struct clk_hw *hw, unsigned long rate,
 		}
 	}
 
-	return best_rate;
+	*rate = best_rate;
+	return 0;
 }
 
 static int kona_peri_clk_set_parent(struct clk_hw *hw, u8 index)
diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
index f56a71d..45c2b51 100644
--- a/drivers/clk/clk-composite.c
+++ b/drivers/clk/clk-composite.c
@@ -55,7 +55,7 @@ static unsigned long clk_composite_recalc_rate(struct clk_hw *hw,
 	return rate_ops->recalc_rate(rate_hw, parent_rate);
 }
 
-static long clk_composite_determine_rate(struct clk_hw *hw, unsigned long rate,
+static int clk_composite_determine_rate(struct clk_hw *hw, unsigned long *rate,
 					unsigned long min_rate,
 					unsigned long max_rate,
 					unsigned long *best_parent_rate,
@@ -88,12 +88,8 @@ static long clk_composite_determine_rate(struct clk_hw *hw, unsigned long rate,
 			*best_parent_p = __clk_get_hw(parent);
 			*best_parent_rate = __clk_get_rate(parent);
 
-			ret = rate_ops->round_rate(rate_hw, &rate,
-						   best_parent_rate);
-			if (ret)
-				return ret;
-
-			return rate;
+			return rate_ops->round_rate(rate_hw, rate,
+						    best_parent_rate);
 		}
 
 		for (i = 0; i < __clk_get_num_parents(mux_hw->clk); i++) {
@@ -103,13 +99,13 @@ static long clk_composite_determine_rate(struct clk_hw *hw, unsigned long rate,
 
 			parent_rate = __clk_get_rate(parent);
 
-			tmp_rate = rate;
+			tmp_rate = *rate;
 			ret = rate_ops->round_rate(rate_hw, &tmp_rate,
 						   &parent_rate);
 			if (ret < 0)
 				continue;
 
-			rate_diff = abs(rate - tmp_rate);
+			rate_diff = abs(*rate - tmp_rate);
 
 			if (!rate_diff || !*best_parent_p
 				       || best_rate_diff > rate_diff) {
@@ -120,10 +116,10 @@ static long clk_composite_determine_rate(struct clk_hw *hw, unsigned long rate,
 			}
 
 			if (!rate_diff)
-				return rate;
+				break;
 		}
 
-		return best_rate;
+		*rate = best_rate;
 	} else if (mux_hw && mux_ops && mux_ops->determine_rate) {
 		__clk_hw_set_clk(mux_hw, hw);
 		return mux_ops->determine_rate(mux_hw, rate, min_rate,
@@ -131,8 +127,10 @@ static long clk_composite_determine_rate(struct clk_hw *hw, unsigned long rate,
 					       best_parent_p);
 	} else {
 		pr_err("clk: clk_composite_determine_rate function called, but no mux or rate callback set!\n");
-		return 0;
+		*rate = 0;
 	}
+
+	return 0;
 }
 
 static int clk_composite_round_rate(struct clk_hw *hw, unsigned long *rate,
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 1462ddc..f42a639 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -795,8 +795,8 @@ static bool mux_is_better_rate(unsigned long rate, unsigned long now,
 	return now <= rate && now > best;
 }
 
-static long
-clk_mux_determine_rate_flags(struct clk_hw *hw, unsigned long rate,
+static int
+clk_mux_determine_rate_flags(struct clk_hw *hw, unsigned long *rate,
 			     unsigned long min_rate,
 			     unsigned long max_rate,
 			     unsigned long *best_parent_rate,
@@ -804,15 +804,15 @@ clk_mux_determine_rate_flags(struct clk_hw *hw, unsigned long rate,
 			     unsigned long flags)
 {
 	struct clk_core *core = hw->core, *parent, *best_parent = NULL;
-	int i, num_parents;
-	unsigned long parent_rate, best = 0;
+	int i, num_parents, ret = 0;
+	unsigned long parent_rate = *rate, best = *rate;
 
 	/* if NO_REPARENT flag set, pass through to current parent */
 	if (core->flags & CLK_SET_RATE_NO_REPARENT) {
 		parent = core->parent;
 		if (core->flags & CLK_SET_RATE_PARENT)
-			best = __clk_determine_rate(parent ? parent->hw : NULL,
-						    rate, min_rate, max_rate);
+			ret = __clk_determine_rate(parent ? parent->hw : NULL,
+						   &best, min_rate, max_rate);
 		else if (parent)
 			best = clk_core_get_rate_nolock(parent);
 		else
@@ -827,23 +827,28 @@ clk_mux_determine_rate_flags(struct clk_hw *hw, unsigned long rate,
 		if (!parent)
 			continue;
 		if (core->flags & CLK_SET_RATE_PARENT)
-			parent_rate = __clk_determine_rate(parent->hw, rate,
-							   min_rate,
-							   max_rate);
+			ret = __clk_determine_rate(parent->hw, &parent_rate,
+						   min_rate,
+						   max_rate);
 		else
 			parent_rate = clk_core_get_rate_nolock(parent);
-		if (mux_is_better_rate(rate, parent_rate, best, flags)) {
+		if (!ret &&
+		    mux_is_better_rate(*rate, parent_rate, best, flags)) {
 			best_parent = parent;
 			best = parent_rate;
 		}
 	}
 
 out:
+	if (ret)
+		return ret;
+
 	if (best_parent)
 		*best_parent_p = best_parent->hw;
 	*best_parent_rate = best;
+	*rate = best;
 
-	return best;
+	return 0;
 }
 
 struct clk *__clk_lookup(const char *name)
@@ -874,11 +879,11 @@ static void clk_core_get_boundaries(struct clk_core *clk,
  * directly as a determine_rate callback (e.g. for a mux), or from a more
  * complex clock that may combine a mux with other operations.
  */
-long __clk_mux_determine_rate(struct clk_hw *hw, unsigned long rate,
-			      unsigned long min_rate,
-			      unsigned long max_rate,
-			      unsigned long *best_parent_rate,
-			      struct clk_hw **best_parent_p)
+int __clk_mux_determine_rate(struct clk_hw *hw, unsigned long *rate,
+			     unsigned long min_rate,
+			     unsigned long max_rate,
+			     unsigned long *best_parent_rate,
+			     struct clk_hw **best_parent_p)
 {
 	return clk_mux_determine_rate_flags(hw, rate, min_rate, max_rate,
 					    best_parent_rate,
@@ -886,7 +891,7 @@ long __clk_mux_determine_rate(struct clk_hw *hw, unsigned long rate,
 }
 EXPORT_SYMBOL_GPL(__clk_mux_determine_rate);
 
-long __clk_mux_determine_rate_closest(struct clk_hw *hw, unsigned long rate,
+int __clk_mux_determine_rate_closest(struct clk_hw *hw, unsigned long *rate,
 			      unsigned long min_rate,
 			      unsigned long max_rate,
 			      unsigned long *best_parent_rate,
@@ -1143,9 +1148,12 @@ static unsigned long clk_core_round_rate_nolock(struct clk_core *clk,
 
 	if (clk->ops->determine_rate) {
 		parent_hw = parent ? parent->hw : NULL;
-		return clk->ops->determine_rate(clk->hw, rate,
-						min_rate, max_rate,
-						&parent_rate, &parent_hw);
+		if (clk->ops->determine_rate(clk->hw, &rate,
+					     min_rate, max_rate,
+					     &parent_rate, &parent_hw))
+			return 0;
+
+		return rate;
 	} else if (clk->ops->round_rate) {
 		if (clk->ops->round_rate(clk->hw, &rate, &parent_rate))
 			return 0;
@@ -1168,15 +1176,13 @@ static unsigned long clk_core_round_rate_nolock(struct clk_core *clk,
  * Caller must hold prepare_lock.  Useful for clk_ops such as .set_rate and
  * .determine_rate.
  */
-unsigned long __clk_determine_rate(struct clk_hw *hw,
-				   unsigned long rate,
-				   unsigned long min_rate,
-				   unsigned long max_rate)
+int __clk_determine_rate(struct clk_hw *hw, unsigned long *rate,
+			 unsigned long min_rate, unsigned long max_rate)
 {
 	if (!hw)
 		return 0;
 
-	return clk_core_round_rate_nolock(hw->core, rate, min_rate, max_rate);
+	return clk_core_round_rate_nolock(hw->core, *rate, min_rate, max_rate);
 }
 EXPORT_SYMBOL_GPL(__clk_determine_rate);
 
@@ -1617,10 +1623,11 @@ static struct clk_core *clk_calc_new_rates(struct clk_core *clk,
 	struct clk_core *old_parent, *parent;
 	struct clk_hw *parent_hw;
 	unsigned long best_parent_rate = 0;
-	unsigned long new_rate;
+	unsigned long new_rate = rate;
 	unsigned long min_rate;
 	unsigned long max_rate;
 	int p_index = 0;
+	int ret;
 
 	/* sanity */
 	if (IS_ERR_OR_NULL(clk))
@@ -1636,11 +1643,14 @@ static struct clk_core *clk_calc_new_rates(struct clk_core *clk,
 	/* find the closest rate and parent clk/rate */
 	if (clk->ops->determine_rate) {
 		parent_hw = parent ? parent->hw : NULL;
-		new_rate = clk->ops->determine_rate(clk->hw, rate,
-						    min_rate,
-						    max_rate,
-						    &best_parent_rate,
-						    &parent_hw);
+		ret = clk->ops->determine_rate(clk->hw, &new_rate,
+					       min_rate,
+					       max_rate,
+					       &best_parent_rate,
+					       &parent_hw);
+		if (ret)
+			return NULL;
+
 		parent = parent_hw ? parent_hw->core : NULL;
 	} else if (clk->ops->round_rate) {
 		if (clk->ops->round_rate(clk->hw, &new_rate,
diff --git a/drivers/clk/hisilicon/clk-hi3620.c b/drivers/clk/hisilicon/clk-hi3620.c
index 2e4f6d4..f22885a 100644
--- a/drivers/clk/hisilicon/clk-hi3620.c
+++ b/drivers/clk/hisilicon/clk-hi3620.c
@@ -294,7 +294,7 @@ static unsigned long mmc_clk_recalc_rate(struct clk_hw *hw,
 	}
 }
 
-static long mmc_clk_determine_rate(struct clk_hw *hw, unsigned long rate,
+static int mmc_clk_determine_rate(struct clk_hw *hw, unsigned long *rate,
 			      unsigned long min_rate,
 			      unsigned long max_rate,
 			      unsigned long *best_parent_rate,
@@ -303,25 +303,25 @@ static long mmc_clk_determine_rate(struct clk_hw *hw, unsigned long rate,
 	struct clk_mmc *mclk = to_mmc(hw);
 	unsigned long best = 0;
 
-	if ((rate <= 13000000) && (mclk->id == HI3620_MMC_CIUCLK1)) {
-		rate = 13000000;
+	if ((*rate <= 13000000) && (mclk->id == HI3620_MMC_CIUCLK1)) {
+		*rate = 13000000;
 		best = 26000000;
-	} else if (rate <= 26000000) {
-		rate = 25000000;
+	} else if (*rate <= 26000000) {
+		*rate = 25000000;
 		best = 180000000;
-	} else if (rate <= 52000000) {
-		rate = 50000000;
+	} else if (*rate <= 52000000) {
+		*rate = 50000000;
 		best = 360000000;
-	} else if (rate <= 100000000) {
-		rate = 100000000;
+	} else if (*rate <= 100000000) {
+		*rate = 100000000;
 		best = 720000000;
 	} else {
 		/* max is 180M */
-		rate = 180000000;
+		*rate = 180000000;
 		best = 1440000000;
 	}
 	*best_parent_rate = best;
-	return rate;
+	return 0;
 }
 
 static u32 mmc_clk_delay(u32 val, u32 para, u32 off, u32 len)
diff --git a/drivers/clk/mmp/clk-mix.c b/drivers/clk/mmp/clk-mix.c
index de6a873..e15bb57 100644
--- a/drivers/clk/mmp/clk-mix.c
+++ b/drivers/clk/mmp/clk-mix.c
@@ -201,11 +201,11 @@ error:
 	return ret;
 }
 
-static long mmp_clk_mix_determine_rate(struct clk_hw *hw, unsigned long rate,
-					unsigned long min_rate,
-					unsigned long max_rate,
-					unsigned long *best_parent_rate,
-					struct clk_hw **best_parent_clk)
+static int mmp_clk_mix_determine_rate(struct clk_hw *hw, unsigned long *rate,
+				      unsigned long min_rate,
+				      unsigned long max_rate,
+				      unsigned long *best_parent_rate,
+				      struct clk_hw **best_parent_clk)
 {
 	struct mmp_clk_mix *mix = to_clk_mix(hw);
 	struct mmp_clk_mix_clk_table *item;
@@ -233,7 +233,7 @@ static long mmp_clk_mix_determine_rate(struct clk_hw *hw, unsigned long rate,
 							item->parent_index);
 			parent_rate = __clk_get_rate(parent);
 			mix_rate = parent_rate / item->divisor;
-			gap = abs(mix_rate - rate);
+			gap = abs(mix_rate - *rate);
 			if (parent_best == NULL || gap < gap_best) {
 				parent_best = parent;
 				parent_rate_best = parent_rate;
@@ -251,7 +251,7 @@ static long mmp_clk_mix_determine_rate(struct clk_hw *hw, unsigned long rate,
 			for (j = 0; j < div_val_max; j++) {
 				div = _get_div(mix, j);
 				mix_rate = parent_rate / div;
-				gap = abs(mix_rate - rate);
+				gap = abs(mix_rate - *rate);
 				if (parent_best == NULL || gap < gap_best) {
 					parent_best = parent;
 					parent_rate_best = parent_rate;
@@ -267,8 +267,9 @@ static long mmp_clk_mix_determine_rate(struct clk_hw *hw, unsigned long rate,
 found:
 	*best_parent_rate = parent_rate_best;
 	*best_parent_clk = __clk_get_hw(parent_best);
+	*rate = mix_rate_best;
 
-	return mix_rate_best;
+	return 0;
 }
 
 static int mmp_clk_mix_set_rate_and_parent(struct clk_hw *hw,
diff --git a/drivers/clk/qcom/clk-pll.c b/drivers/clk/qcom/clk-pll.c
index b4325f6..2588952 100644
--- a/drivers/clk/qcom/clk-pll.c
+++ b/drivers/clk/qcom/clk-pll.c
@@ -139,19 +139,21 @@ struct pll_freq_tbl *find_freq(const struct pll_freq_tbl *f, unsigned long rate)
 	return NULL;
 }
 
-static long
-clk_pll_determine_rate(struct clk_hw *hw, unsigned long rate,
+static int
+clk_pll_determine_rate(struct clk_hw *hw, unsigned long *rate,
 		       unsigned long min_rate, unsigned long max_rate,
 		       unsigned long *p_rate, struct clk_hw **p)
 {
 	struct clk_pll *pll = to_clk_pll(hw);
 	const struct pll_freq_tbl *f;
 
-	f = find_freq(pll->freq_tbl, rate);
+	f = find_freq(pll->freq_tbl, *rate);
 	if (!f)
-		return clk_pll_recalc_rate(hw, *p_rate);
+		*rate = clk_pll_recalc_rate(hw, *p_rate);
+	else
+		*rate = f->freq;
 
-	return f->freq;
+	return 0;
 }
 
 static int
diff --git a/drivers/clk/qcom/clk-rcg.c b/drivers/clk/qcom/clk-rcg.c
index 8f2f480..727012f 100644
--- a/drivers/clk/qcom/clk-rcg.c
+++ b/drivers/clk/qcom/clk-rcg.c
@@ -404,38 +404,39 @@ clk_dyn_rcg_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 	return calc_rate(parent_rate, m, n, mode, pre_div);
 }
 
-static long _freq_tbl_determine_rate(struct clk_hw *hw,
-		const struct freq_tbl *f, unsigned long rate,
+static int _freq_tbl_determine_rate(struct clk_hw *hw,
+		const struct freq_tbl *f, unsigned long *rate,
 		unsigned long min_rate, unsigned long max_rate,
 		unsigned long *p_rate, struct clk_hw **p_hw)
 {
-	unsigned long clk_flags;
+	unsigned long clk_flags, parent_rate;
 	struct clk *p;
 
-	f = qcom_find_freq(f, rate);
+	f = qcom_find_freq(f, *rate);
 	if (!f)
 		return -EINVAL;
 
 	clk_flags = __clk_get_flags(hw->clk);
 	p = clk_get_parent_by_index(hw->clk, f->src);
 	if (clk_flags & CLK_SET_RATE_PARENT) {
-		rate = rate * f->pre_div;
+		parent_rate = *rate * f->pre_div;
 		if (f->n) {
-			u64 tmp = rate;
+			u64 tmp = parent_rate;
 			tmp = tmp * f->n;
 			do_div(tmp, f->m);
-			rate = tmp;
+			parent_rate = tmp;
 		}
 	} else {
-		rate =  __clk_get_rate(p);
+		parent_rate =  __clk_get_rate(p);
 	}
 	*p_hw = __clk_get_hw(p);
-	*p_rate = rate;
+	*p_rate = parent_rate;
+	*rate = f->freq;
 
-	return f->freq;
+	return 0;
 }
 
-static long clk_rcg_determine_rate(struct clk_hw *hw, unsigned long rate,
+static int clk_rcg_determine_rate(struct clk_hw *hw, unsigned long *rate,
 		unsigned long min_rate, unsigned long max_rate,
 		unsigned long *p_rate, struct clk_hw **p)
 {
@@ -445,7 +446,7 @@ static long clk_rcg_determine_rate(struct clk_hw *hw, unsigned long rate,
 			max_rate, p_rate, p);
 }
 
-static long clk_dyn_rcg_determine_rate(struct clk_hw *hw, unsigned long rate,
+static int clk_dyn_rcg_determine_rate(struct clk_hw *hw, unsigned long *rate,
 		unsigned long min_rate, unsigned long max_rate,
 		unsigned long *p_rate, struct clk_hw **p)
 {
@@ -455,7 +456,7 @@ static long clk_dyn_rcg_determine_rate(struct clk_hw *hw, unsigned long rate,
 			max_rate, p_rate, p);
 }
 
-static long clk_rcg_bypass_determine_rate(struct clk_hw *hw, unsigned long rate,
+static int clk_rcg_bypass_determine_rate(struct clk_hw *hw, unsigned long *rate,
 		unsigned long min_rate, unsigned long max_rate,
 		unsigned long *p_rate, struct clk_hw **p_hw)
 {
@@ -465,9 +466,10 @@ static long clk_rcg_bypass_determine_rate(struct clk_hw *hw, unsigned long rate,
 
 	p = clk_get_parent_by_index(hw->clk, f->src);
 	*p_hw = __clk_get_hw(p);
-	*p_rate = __clk_round_rate(p, rate);
+	*p_rate = __clk_round_rate(p, *rate);
+	*rate = *p_rate;
 
-	return *p_rate;
+	return 0;
 }
 
 static int __clk_rcg_set_rate(struct clk_rcg *rcg, const struct freq_tbl *f)
diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index 416becc..38ef3f2 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -176,14 +176,14 @@ clk_rcg2_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 	return calc_rate(parent_rate, m, n, mode, hid_div);
 }
 
-static long _freq_tbl_determine_rate(struct clk_hw *hw,
-		const struct freq_tbl *f, unsigned long rate,
+static int _freq_tbl_determine_rate(struct clk_hw *hw,
+		const struct freq_tbl *f, unsigned long *rate,
 		unsigned long *p_rate, struct clk_hw **p_hw)
 {
-	unsigned long clk_flags;
+	unsigned long clk_flags, parent_rate = *rate;
 	struct clk *p;
 
-	f = qcom_find_freq(f, rate);
+	f = qcom_find_freq(f, *rate);
 	if (!f)
 		return -EINVAL;
 
@@ -191,26 +191,27 @@ static long _freq_tbl_determine_rate(struct clk_hw *hw,
 	p = clk_get_parent_by_index(hw->clk, f->src);
 	if (clk_flags & CLK_SET_RATE_PARENT) {
 		if (f->pre_div) {
-			rate /= 2;
-			rate *= f->pre_div + 1;
+			parent_rate /= 2;
+			parent_rate *= f->pre_div + 1;
 		}
 
 		if (f->n) {
-			u64 tmp = rate;
+			u64 tmp = parent_rate;
 			tmp = tmp * f->n;
 			do_div(tmp, f->m);
-			rate = tmp;
+			parent_rate = tmp;
 		}
 	} else {
-		rate =  __clk_get_rate(p);
+		parent_rate =  __clk_get_rate(p);
 	}
 	*p_hw = __clk_get_hw(p);
-	*p_rate = rate;
+	*p_rate = parent_rate;
+	*rate = f->freq;
 
-	return f->freq;
+	return 0;
 }
 
-static long clk_rcg2_determine_rate(struct clk_hw *hw, unsigned long rate,
+static int clk_rcg2_determine_rate(struct clk_hw *hw, unsigned long *rate,
 		unsigned long min_rate, unsigned long max_rate,
 		unsigned long *p_rate, struct clk_hw **p)
 {
@@ -368,7 +369,7 @@ static int clk_edp_pixel_set_rate_and_parent(struct clk_hw *hw,
 	return clk_edp_pixel_set_rate(hw, rate, parent_rate);
 }
 
-static long clk_edp_pixel_determine_rate(struct clk_hw *hw, unsigned long rate,
+static int clk_edp_pixel_determine_rate(struct clk_hw *hw, unsigned long *rate,
 				 unsigned long min_rate,
 				 unsigned long max_rate,
 				 unsigned long *p_rate, struct clk_hw **p)
@@ -391,7 +392,7 @@ static long clk_edp_pixel_determine_rate(struct clk_hw *hw, unsigned long rate,
 		frac = frac_table_675m;
 
 	for (; frac->num; frac++) {
-		request = rate;
+		request = *rate;
 		request *= frac->den;
 		request = div_s64(request, frac->num);
 		if ((src_rate < (request - delta)) ||
@@ -403,8 +404,10 @@ static long clk_edp_pixel_determine_rate(struct clk_hw *hw, unsigned long rate,
 		hid_div >>= CFG_SRC_DIV_SHIFT;
 		hid_div &= mask;
 
-		return calc_rate(src_rate, frac->num, frac->den, !!frac->den,
-				 hid_div);
+		*rate = calc_rate(src_rate, frac->num, frac->den, !!frac->den,
+				  hid_div);
+
+		return 0;
 	}
 
 	return -EINVAL;
@@ -421,7 +424,7 @@ const struct clk_ops clk_edp_pixel_ops = {
 };
 EXPORT_SYMBOL_GPL(clk_edp_pixel_ops);
 
-static long clk_byte_determine_rate(struct clk_hw *hw, unsigned long rate,
+static int clk_byte_determine_rate(struct clk_hw *hw, unsigned long *rate,
 			 unsigned long min_rate, unsigned long max_rate,
 			 unsigned long *p_rate, struct clk_hw **p_hw)
 {
@@ -431,17 +434,19 @@ static long clk_byte_determine_rate(struct clk_hw *hw, unsigned long rate,
 	u32 mask = BIT(rcg->hid_width) - 1;
 	struct clk *p;
 
-	if (rate == 0)
+	if (*rate == 0)
 		return -EINVAL;
 
 	p = clk_get_parent_by_index(hw->clk, f->src);
 	*p_hw = __clk_get_hw(p);
-	*p_rate = parent_rate = __clk_round_rate(p, rate);
+	*p_rate = parent_rate = __clk_round_rate(p, *rate);
 
-	div = DIV_ROUND_UP((2 * parent_rate), rate) - 1;
+	div = DIV_ROUND_UP((2 * parent_rate), *rate) - 1;
 	div = min_t(u32, div, mask);
 
-	return calc_rate(parent_rate, 0, 0, 0, div);
+	*rate = calc_rate(parent_rate, 0, 0, 0, div);
+
+	return 0;
 }
 
 static int clk_byte_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -486,7 +491,7 @@ static const struct frac_entry frac_table_pixel[] = {
 	{ }
 };
 
-static long clk_pixel_determine_rate(struct clk_hw *hw, unsigned long rate,
+static int clk_pixel_determine_rate(struct clk_hw *hw, unsigned long *rate,
 				 unsigned long min_rate,
 				 unsigned long max_rate,
 				 unsigned long *p_rate, struct clk_hw **p)
@@ -501,7 +506,7 @@ static long clk_pixel_determine_rate(struct clk_hw *hw, unsigned long rate,
 	*p = __clk_get_hw(parent);
 
 	for (; frac->num; frac++) {
-		request = (rate * frac->den) / frac->num;
+		request = (*rate * frac->den) / frac->num;
 
 		src_rate = __clk_round_rate(parent, request);
 		if ((src_rate < (request - delta)) ||
@@ -509,7 +514,9 @@ static long clk_pixel_determine_rate(struct clk_hw *hw, unsigned long rate,
 			continue;
 
 		*p_rate = src_rate;
-		return (src_rate * frac->num) / frac->den;
+		*rate = (src_rate * frac->num) / frac->den;
+
+		return 0;
 	}
 
 	return -EINVAL;
diff --git a/drivers/clk/sunxi/clk-factors.c b/drivers/clk/sunxi/clk-factors.c
index 5865300..1cef6a5 100644
--- a/drivers/clk/sunxi/clk-factors.c
+++ b/drivers/clk/sunxi/clk-factors.c
@@ -82,11 +82,11 @@ static int clk_factors_round_rate(struct clk_hw *hw, unsigned long *rate,
 	return 0;
 }
 
-static long clk_factors_determine_rate(struct clk_hw *hw, unsigned long rate,
-				       unsigned long min_rate,
-				       unsigned long max_rate,
-				       unsigned long *best_parent_rate,
-				       struct clk_hw **best_parent_p)
+static int clk_factors_determine_rate(struct clk_hw *hw, unsigned long *rate,
+				      unsigned long min_rate,
+				      unsigned long max_rate,
+				      unsigned long *best_parent_rate,
+				      struct clk_hw **best_parent_p)
 {
 	struct clk *clk = hw->clk, *parent, *best_parent = NULL;
 	int i, num_parents;
@@ -99,14 +99,14 @@ static long clk_factors_determine_rate(struct clk_hw *hw, unsigned long rate,
 		if (!parent)
 			continue;
 		if (__clk_get_flags(clk) & CLK_SET_RATE_PARENT)
-			parent_rate = __clk_round_rate(parent, rate);
+			parent_rate = __clk_round_rate(parent, *rate);
 		else
 			parent_rate = __clk_get_rate(parent);
 
-		child_rate = rate;
+		child_rate = *rate;
 		clk_factors_round_rate(hw, &child_rate, &parent_rate);
 
-		if (child_rate <= rate && child_rate > best_child_rate) {
+		if (child_rate <= *rate && child_rate > best_child_rate) {
 			best_parent = parent;
 			best = parent_rate;
 			best_child_rate = child_rate;
@@ -116,8 +116,9 @@ static long clk_factors_determine_rate(struct clk_hw *hw, unsigned long rate,
 	if (best_parent)
 		*best_parent_p = __clk_get_hw(best_parent);
 	*best_parent_rate = best;
+	*rate = best_child_rate;
 
-	return best_child_rate;
+	return 0;
 }
 
 static int clk_factors_set_rate(struct clk_hw *hw, unsigned long rate,
diff --git a/drivers/clk/sunxi/clk-sun6i-ar100.c b/drivers/clk/sunxi/clk-sun6i-ar100.c
index 63cf149..f398190 100644
--- a/drivers/clk/sunxi/clk-sun6i-ar100.c
+++ b/drivers/clk/sunxi/clk-sun6i-ar100.c
@@ -44,11 +44,11 @@ static unsigned long ar100_recalc_rate(struct clk_hw *hw,
 	return (parent_rate >> shift) / (div + 1);
 }
 
-static long ar100_determine_rate(struct clk_hw *hw, unsigned long rate,
-				 unsigned long min_rate,
-				 unsigned long max_rate,
-				 unsigned long *best_parent_rate,
-				 struct clk_hw **best_parent_clk)
+static int ar100_determine_rate(struct clk_hw *hw, unsigned long *rate,
+				unsigned long min_rate,
+				unsigned long max_rate,
+				unsigned long *best_parent_rate,
+				struct clk_hw **best_parent_clk)
 {
 	int nparents = __clk_get_num_parents(hw->clk);
 	long best_rate = -EINVAL;
@@ -65,7 +65,7 @@ static long ar100_determine_rate(struct clk_hw *hw, unsigned long rate,
 
 		parent = clk_get_parent_by_index(hw->clk, i);
 		parent_rate = __clk_get_rate(parent);
-		div = DIV_ROUND_UP(parent_rate, rate);
+		div = DIV_ROUND_UP(parent_rate, *rate);
 
 		/*
 		 * The AR100 clk contains 2 divisors:
@@ -108,7 +108,11 @@ static long ar100_determine_rate(struct clk_hw *hw, unsigned long rate,
 		}
 	}
 
-	return best_rate;
+	if (best_rate < 0)
+		return best_rate;
+
+	*rate = best_rate;
+	return 0;
 }
 
 static int ar100_set_parent(struct clk_hw *hw, u8 index)
diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 7e1e2bd..3f2420f 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -118,11 +118,11 @@ static long sun6i_ahb1_clk_round(unsigned long rate, u8 *divp, u8 *pre_divp,
 	return (parent_rate / calcm) >> calcp;
 }
 
-static long sun6i_ahb1_clk_determine_rate(struct clk_hw *hw, unsigned long rate,
-					  unsigned long min_rate,
-					  unsigned long max_rate,
-					  unsigned long *best_parent_rate,
-					  struct clk_hw **best_parent_clk)
+static int sun6i_ahb1_clk_determine_rate(struct clk_hw *hw, unsigned long *rate,
+					 unsigned long min_rate,
+					 unsigned long max_rate,
+					 unsigned long *best_parent_rate,
+					 struct clk_hw **best_parent_clk)
 {
 	struct clk *clk = hw->clk, *parent, *best_parent = NULL;
 	int i, num_parents;
@@ -135,14 +135,14 @@ static long sun6i_ahb1_clk_determine_rate(struct clk_hw *hw, unsigned long rate,
 		if (!parent)
 			continue;
 		if (__clk_get_flags(clk) & CLK_SET_RATE_PARENT)
-			parent_rate = __clk_round_rate(parent, rate);
+			parent_rate = __clk_round_rate(parent, *rate);
 		else
 			parent_rate = __clk_get_rate(parent);
 
-		child_rate = sun6i_ahb1_clk_round(rate, NULL, NULL, i,
+		child_rate = sun6i_ahb1_clk_round(*rate, NULL, NULL, i,
 						  parent_rate);
 
-		if (child_rate <= rate && child_rate > best_child_rate) {
+		if (child_rate <= *rate && child_rate > best_child_rate) {
 			best_parent = parent;
 			best = parent_rate;
 			best_child_rate = child_rate;
@@ -152,8 +152,9 @@ static long sun6i_ahb1_clk_determine_rate(struct clk_hw *hw, unsigned long rate,
 	if (best_parent)
 		*best_parent_clk = __clk_get_hw(best_parent);
 	*best_parent_rate = best;
+	*rate = best_child_rate;
 
-	return best_child_rate;
+	return 0;
 }
 
 static int sun6i_ahb1_clk_set_rate(struct clk_hw *hw, unsigned long rate,
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 1213b0b..51d67de 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -175,8 +175,8 @@ struct clk_ops {
 					unsigned long parent_rate);
 	int		(*round_rate)(struct clk_hw *hw, unsigned long *rate,
 				      unsigned long *parent_rate);
-	long		(*determine_rate)(struct clk_hw *hw,
-					  unsigned long rate,
+	int		(*determine_rate)(struct clk_hw *hw,
+					  unsigned long *rate,
 					  unsigned long min_rate,
 					  unsigned long max_rate,
 					  unsigned long *best_parent_rate,
@@ -575,16 +575,16 @@ unsigned long __clk_get_flags(struct clk *clk);
 bool __clk_is_prepared(struct clk *clk);
 bool __clk_is_enabled(struct clk *clk);
 struct clk *__clk_lookup(const char *name);
-long __clk_mux_determine_rate(struct clk_hw *hw, unsigned long rate,
-			      unsigned long min_rate,
-			      unsigned long max_rate,
-			      unsigned long *best_parent_rate,
-			      struct clk_hw **best_parent_p);
-unsigned long __clk_determine_rate(struct clk_hw *core,
-				   unsigned long rate,
-				   unsigned long min_rate,
-				   unsigned long max_rate);
-long __clk_mux_determine_rate_closest(struct clk_hw *hw, unsigned long rate,
+int __clk_mux_determine_rate(struct clk_hw *hw, unsigned long *rate,
+			     unsigned long min_rate,
+			     unsigned long max_rate,
+			     unsigned long *best_parent_rate,
+			     struct clk_hw **best_parent_p);
+int __clk_determine_rate(struct clk_hw *core,
+			 unsigned long *rate,
+			 unsigned long min_rate,
+			 unsigned long max_rate);
+int __clk_mux_determine_rate_closest(struct clk_hw *hw, unsigned long *rate,
 			      unsigned long min_rate,
 			      unsigned long max_rate,
 			      unsigned long *best_parent_rate,
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 3b2406c..1df140f 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -269,23 +269,23 @@ int omap3_noncore_dpll_set_rate_and_parent(struct clk_hw *hw,
 					   unsigned long rate,
 					   unsigned long parent_rate,
 					   u8 index);
-long omap3_noncore_dpll_determine_rate(struct clk_hw *hw,
-				       unsigned long rate,
-				       unsigned long min_rate,
-				       unsigned long max_rate,
-				       unsigned long *best_parent_rate,
-				       struct clk_hw **best_parent_clk);
+int omap3_noncore_dpll_determine_rate(struct clk_hw *hw,
+				      unsigned long *rate,
+				      unsigned long min_rate,
+				      unsigned long max_rate,
+				      unsigned long *best_parent_rate,
+				      struct clk_hw **best_parent_clk);
 unsigned long omap4_dpll_regm4xen_recalc(struct clk_hw *hw,
 					 unsigned long parent_rate);
 int omap4_dpll_regm4xen_round_rate(struct clk_hw *hw,
 				   unsigned long *target_rate,
 				   unsigned long *parent_rate);
-long omap4_dpll_regm4xen_determine_rate(struct clk_hw *hw,
-					unsigned long rate,
-					unsigned long min_rate,
-					unsigned long max_rate,
-					unsigned long *best_parent_rate,
-					struct clk_hw **best_parent_clk);
+int omap4_dpll_regm4xen_determine_rate(struct clk_hw *hw,
+				       unsigned long *rate,
+				       unsigned long min_rate,
+				       unsigned long max_rate,
+				       unsigned long *best_parent_rate,
+				       struct clk_hw **best_parent_clk);
 u8 omap2_init_dpll_parent(struct clk_hw *hw);
 unsigned long omap3_dpll_recalc(struct clk_hw *hw, unsigned long parent_rate);
 int omap2_dpll_round_rate(struct clk_hw *hw, unsigned long *target_rate,
-- 
1.9.1
