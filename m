From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  6 Jul 2015 19:14:32 +0200
Subject: [PATCH v4] clk: change clk_ops' ->determine_rate() prototype
Message-ID: <1436202872-26533-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clock rates are stored in an unsigned long field, but ->determine_rate()
(which returns a rounded rate from a requested one) returns a long
value (errors are reported using negative error codes), which can lead
to long overflow if the clock rate exceed 2Ghz.

Change ->determine_rate() prototype to return 0 or an error code, and pass
a pointer to a clk_rate_request structure containing the expected target
rate and the rate constraints imposed by clk users.

The clk_rate_request structure might be extended in the future to contain
other kind of constraints like the rounding policy, the maximum clock
inaccuracy or other things that are not yet supported by the CCF
(power consumption constraints ?).

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

CC: Jonathan Corbet <corbet@lwn.net>
CC: Tony Lindgren <tony@atomide.com>
CC: Ralf Baechle <ralf@linux-mips.org>
CC: "Emilio L?pez" <emilio@elopez.com.ar>
CC: Maxime Ripard <maxime.ripard@free-electrons.com>
CC: Tero Kristo <t-kristo@ti.com>
CC: Peter De Schrijver <pdeschrijver@nvidia.com>
CC: Prashant Gaikwad <pgaikwad@nvidia.com>
CC: Stephen Warren <swarren@wwwdotorg.org>
CC: Thierry Reding <thierry.reding@gmail.com>
CC: Alexandre Courbot <gnurou@gmail.com>
CC: linux-doc at vger.kernel.org
CC: linux-kernel at vger.kernel.org
CC: linux-arm-kernel at lists.infradead.org
CC: linux-omap at vger.kernel.org
CC: linux-mips at linux-mips.org
CC: linux-tegra at vger.kernel.org

---

changes since v3:
- modify clk-emc driver to match the new prototype
- fix __clk_round_rate negative error code return
- remove unused variable in clk-hi3620.c
- rebased on 4.2-rc1

Changes since v2:
- drop the ->round_rate() prototype changes
- introduce a clk_rate_request struct to avoid any changes on the prototype
  in the future

Changes since v1:
- fix an 'uninitialized variable' bug reported by Heiko
- rebased on clk-next
---
 Documentation/clk.txt               |   8 +-
 arch/arm/mach-omap2/dpll3xxx.c      |  29 +++---
 arch/arm/mach-omap2/dpll44xx.c      |  30 +++---
 arch/mips/alchemy/common/clock.c    |  61 +++++--------
 drivers/clk/at91/clk-programmable.c |  25 ++---
 drivers/clk/at91/clk-usb.c          |  28 +++---
 drivers/clk/bcm/clk-kona.c          |  34 ++++---
 drivers/clk/clk-composite.c         |  48 +++++-----
 drivers/clk/clk.c                   | 176 ++++++++++++++++++++----------------
 drivers/clk/hisilicon/clk-hi3620.c  |  41 ++++-----
 drivers/clk/mmp/clk-mix.c           |  18 ++--
 drivers/clk/qcom/clk-pll.c          |  16 ++--
 drivers/clk/qcom/clk-rcg.c          |  44 ++++-----
 drivers/clk/qcom/clk-rcg2.c         |  78 ++++++++--------
 drivers/clk/sunxi/clk-factors.c     |  21 ++---
 drivers/clk/sunxi/clk-sun6i-ar100.c |  21 ++---
 drivers/clk/sunxi/clk-sunxi.c       |  20 ++--
 drivers/clk/tegra/clk-emc.c         |  28 +++---
 include/linux/clk-provider.h        |  49 ++++++----
 include/linux/clk/ti.h              |  16 +---
 20 files changed, 393 insertions(+), 398 deletions(-)

diff --git a/Documentation/clk.txt b/Documentation/clk.txt
index f463bdc..5c4bc4d 100644
--- a/Documentation/clk.txt
+++ b/Documentation/clk.txt
@@ -71,12 +71,8 @@ the operations defined in clk.h:
 		long		(*round_rate)(struct clk_hw *hw,
 						unsigned long rate,
 						unsigned long *parent_rate);
-		long		(*determine_rate)(struct clk_hw *hw,
-						unsigned long rate,
-						unsigned long min_rate,
-						unsigned long max_rate,
-						unsigned long *best_parent_rate,
-						struct clk_hw **best_parent_clk);
+		int		(*determine_rate)(struct clk_hw *hw,
+						  struct clk_rate_request *req);
 		int		(*set_parent)(struct clk_hw *hw, u8 index);
 		u8		(*get_parent)(struct clk_hw *hw);
 		int		(*set_rate)(struct clk_hw *hw,
diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index 44e57ec..cd27457 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -462,43 +462,38 @@ void omap3_noncore_dpll_disable(struct clk_hw *hw)
 /**
  * omap3_noncore_dpll_determine_rate - determine rate for a DPLL
  * @hw: pointer to the clock to determine rate for
- * @rate: target rate for the DPLL
- * @best_parent_rate: pointer for returning best parent rate
- * @best_parent_clk: pointer for returning best parent clock
+ * @req: target rate request
  *
  * Determines which DPLL mode to use for reaching a desired target rate.
  * Checks whether the DPLL shall be in bypass or locked mode, and if
  * locked, calculates the M,N values for the DPLL via round-rate.
- * Returns a positive clock rate with success, negative error value
- * in failure.
+ * Returns a 0 on success, negative error value in failure.
  */
-long omap3_noncore_dpll_determine_rate(struct clk_hw *hw, unsigned long rate,
-				       unsigned long min_rate,
-				       unsigned long max_rate,
-				       unsigned long *best_parent_rate,
-				       struct clk_hw **best_parent_clk)
+int omap3_noncore_dpll_determine_rate(struct clk_hw *hw,
+				      struct clk_rate_request *req)
 {
 	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
 	struct dpll_data *dd;
 
-	if (!hw || !rate)
+	if (!hw || !req || !req->rate)
 		return -EINVAL;
 
 	dd = clk->dpll_data;
 	if (!dd)
 		return -EINVAL;
 
-	if (__clk_get_rate(dd->clk_bypass) == rate &&
+	if (__clk_get_rate(dd->clk_bypass) == req->rate &&
 	    (dd->modes & (1 << DPLL_LOW_POWER_BYPASS))) {
-		*best_parent_clk = __clk_get_hw(dd->clk_bypass);
+		req->best_parent_hw = __clk_get_hw(dd->clk_bypass);
 	} else {
-		rate = omap2_dpll_round_rate(hw, rate, best_parent_rate);
-		*best_parent_clk = __clk_get_hw(dd->clk_ref);
+		req->rate = omap2_dpll_round_rate(hw, req->rate,
+					  &req->best_parent_rate);
+		req->best_parent_hw = __clk_get_hw(dd->clk_ref);
 	}
 
-	*best_parent_rate = rate;
+	req->best_parent_rate = req->rate;
 
-	return rate;
+	return 0;
 }
 
 /**
diff --git a/arch/arm/mach-omap2/dpll44xx.c b/arch/arm/mach-omap2/dpll44xx.c
index f231be0..d615571 100644
--- a/arch/arm/mach-omap2/dpll44xx.c
+++ b/arch/arm/mach-omap2/dpll44xx.c
@@ -191,42 +191,36 @@ out:
 /**
  * omap4_dpll_regm4xen_determine_rate - determine rate for a DPLL
  * @hw: pointer to the clock to determine rate for
- * @rate: target rate for the DPLL
- * @best_parent_rate: pointer for returning best parent rate
- * @best_parent_clk: pointer for returning best parent clock
+ * @req: target rate request
  *
  * Determines which DPLL mode to use for reaching a desired rate.
  * Checks whether the DPLL shall be in bypass or locked mode, and if
  * locked, calculates the M,N values for the DPLL via round-rate.
- * Returns a positive clock rate with success, negative error value
- * in failure.
+ * Returns 0 on success and a negative error value otherwise.
  */
-long omap4_dpll_regm4xen_determine_rate(struct clk_hw *hw, unsigned long rate,
-					unsigned long min_rate,
-					unsigned long max_rate,
-					unsigned long *best_parent_rate,
-					struct clk_hw **best_parent_clk)
+int omap4_dpll_regm4xen_determine_rate(struct clk_hw *hw,
+				       struct clk_rate_request *req)
 {
 	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
 	struct dpll_data *dd;
 
-	if (!hw || !rate)
+	if (!hw || !req || !req->rate)
 		return -EINVAL;
 
 	dd = clk->dpll_data;
 	if (!dd)
 		return -EINVAL;
 
-	if (__clk_get_rate(dd->clk_bypass) == rate &&
+	if (__clk_get_rate(dd->clk_bypass) == req->rate &&
 	    (dd->modes & (1 << DPLL_LOW_POWER_BYPASS))) {
-		*best_parent_clk = __clk_get_hw(dd->clk_bypass);
+		req->best_parent_hw = __clk_get_hw(dd->clk_bypass);
 	} else {
-		rate = omap4_dpll_regm4xen_round_rate(hw, rate,
-						      best_parent_rate);
-		*best_parent_clk = __clk_get_hw(dd->clk_ref);
+		req->rate = omap4_dpll_regm4xen_round_rate(hw, req->rate,
+						&req->best_parent_rate);
+		req->best_parent_hw = __clk_get_hw(dd->clk_ref);
 	}
 
-	*best_parent_rate = rate;
+	req->best_parent_rate = req->rate;
 
-	return rate;
+	return 0;
 }
diff --git a/arch/mips/alchemy/common/clock.c b/arch/mips/alchemy/common/clock.c
index 6e46abe..0d77487 100644
--- a/arch/mips/alchemy/common/clock.c
+++ b/arch/mips/alchemy/common/clock.c
@@ -389,10 +389,9 @@ static long alchemy_calc_div(unsigned long rate, unsigned long prate,
 	return div1;
 }
 
-static long alchemy_clk_fgcs_detr(struct clk_hw *hw, unsigned long rate,
-					unsigned long *best_parent_rate,
-					struct clk_hw **best_parent_clk,
-					int scale, int maxdiv)
+static int alchemy_clk_fgcs_detr(struct clk_hw *hw,
+				 struct clk_rate_request *req,
+				 int scale, int maxdiv)
 {
 	struct clk *pc, *bpc, *free;
 	long tdv, tpr, pr, nr, br, bpr, diff, lastdiff;
@@ -422,14 +421,14 @@ static long alchemy_clk_fgcs_detr(struct clk_hw *hw, unsigned long rate,
 		}
 
 		pr = clk_get_rate(pc);
-		if (pr < rate)
+		if (pr < req->rate)
 			continue;
 
 		/* what can hardware actually provide */
-		tdv = alchemy_calc_div(rate, pr, scale, maxdiv, NULL);
+		tdv = alchemy_calc_div(req->rate, pr, scale, maxdiv, NULL);
 		nr = pr / tdv;
-		diff = rate - nr;
-		if (nr > rate)
+		diff = req->rate - nr;
+		if (nr > req->rate)
 			continue;
 
 		if (diff < lastdiff) {
@@ -448,15 +447,16 @@ static long alchemy_clk_fgcs_detr(struct clk_hw *hw, unsigned long rate,
 	 */
 	if (lastdiff && free) {
 		for (j = (maxdiv == 4) ? 1 : scale; j <= maxdiv; j += scale) {
-			tpr = rate * j;
+			tpr = req->rate * j;
 			if (tpr < 0)
 				break;
 			pr = clk_round_rate(free, tpr);
 
-			tdv = alchemy_calc_div(rate, pr, scale, maxdiv, NULL);
+			tdv = alchemy_calc_div(req->rate, pr, scale, maxdiv,
+					       NULL);
 			nr = pr / tdv;
-			diff = rate - nr;
-			if (nr > rate)
+			diff = req->rate - nr;
+			if (nr > req->rate)
 				continue;
 			if (diff < lastdiff) {
 				lastdiff = diff;
@@ -469,9 +469,10 @@ static long alchemy_clk_fgcs_detr(struct clk_hw *hw, unsigned long rate,
 		}
 	}
 
-	*best_parent_rate = bpr;
-	*best_parent_clk = __clk_get_hw(bpc);
-	return br;
+	req->best_parent_rate = bpr;
+	req->best_parent_clk = __clk_get_hw(bpc);
+	req->rate = br;
+	return 0;
 }
 
 static int alchemy_clk_fgv1_en(struct clk_hw *hw)
@@ -562,14 +563,10 @@ static unsigned long alchemy_clk_fgv1_recalc(struct clk_hw *hw,
 	return parent_rate / v;
 }
 
-static long alchemy_clk_fgv1_detr(struct clk_hw *hw, unsigned long rate,
-					unsigned long min_rate,
-					unsigned long max_rate,
-					unsigned long *best_parent_rate,
-					struct clk_hw **best_parent_clk)
+static long alchemy_clk_fgv1_detr(struct clk_hw *hw,
+				  struct clk_rate_request *req)
 {
-	return alchemy_clk_fgcs_detr(hw, rate, best_parent_rate,
-				     best_parent_clk, 2, 512);
+	return alchemy_clk_fgcs_detr(hw, req, 2, 512);
 }
 
 /* Au1000, Au1100, Au15x0, Au12x0 */
@@ -696,11 +693,8 @@ static unsigned long alchemy_clk_fgv2_recalc(struct clk_hw *hw,
 	return t;
 }
 
-static long alchemy_clk_fgv2_detr(struct clk_hw *hw, unsigned long rate,
-					unsigned long min_rate,
-					unsigned long max_rate,
-					unsigned long *best_parent_rate,
-					struct clk_hw **best_parent_clk)
+static long alchemy_clk_fgv2_detr(struct clk_hw *hw,
+				  struct clk_rate_request *req)
 {
 	struct alchemy_fgcs_clk *c = to_fgcs_clk(hw);
 	int scale, maxdiv;
@@ -713,8 +707,7 @@ static long alchemy_clk_fgv2_detr(struct clk_hw *hw, unsigned long rate,
 		maxdiv = 512;
 	}
 
-	return alchemy_clk_fgcs_detr(hw, rate, best_parent_rate,
-				     best_parent_clk, scale, maxdiv);
+	return alchemy_clk_fgcs_detr(hw, req, scale, maxdiv);
 }
 
 /* Au1300 larger input mux, no separate disable bit, flexible divider */
@@ -917,17 +910,13 @@ static int alchemy_clk_csrc_setr(struct clk_hw *hw, unsigned long rate,
 	return 0;
 }
 
-static long alchemy_clk_csrc_detr(struct clk_hw *hw, unsigned long rate,
-					unsigned long min_rate,
-					unsigned long max_rate,
-					unsigned long *best_parent_rate,
-					struct clk_hw **best_parent_clk)
+static long alchemy_clk_csrc_detr(struct clk_hw *hw,
+				  struct clk_rate_request *req)
 {
 	struct alchemy_fgcs_clk *c = to_fgcs_clk(hw);
 	int scale = c->dt[2] == 3 ? 1 : 2; /* au1300 check */
 
-	return alchemy_clk_fgcs_detr(hw, rate, best_parent_rate,
-				     best_parent_clk, scale, 4);
+	return alchemy_clk_fgcs_detr(hw, req, scale, 4);
 }
 
 static struct clk_ops alchemy_clkops_csrc = {
diff --git a/drivers/clk/at91/clk-programmable.c b/drivers/clk/at91/clk-programmable.c
index 8c86c0f..43dacad 100644
--- a/drivers/clk/at91/clk-programmable.c
+++ b/drivers/clk/at91/clk-programmable.c
@@ -54,12 +54,8 @@ static unsigned long clk_programmable_recalc_rate(struct clk_hw *hw,
 	return parent_rate >> pres;
 }
 
-static long clk_programmable_determine_rate(struct clk_hw *hw,
-					    unsigned long rate,
-					    unsigned long min_rate,
-					    unsigned long max_rate,
-					    unsigned long *best_parent_rate,
-					    struct clk_hw **best_parent_hw)
+static int clk_programmable_determine_rate(struct clk_hw *hw,
+					   struct clk_rate_request *req)
 {
 	struct clk *parent = NULL;
 	long best_rate = -EINVAL;
@@ -76,24 +72,29 @@ static long clk_programmable_determine_rate(struct clk_hw *hw,
 		parent_rate = __clk_get_rate(parent);
 		for (shift = 0; shift < PROG_PRES_MASK; shift++) {
 			tmp_rate = parent_rate >> shift;
-			if (tmp_rate <= rate)
+			if (tmp_rate <= req->rate)
 				break;
 		}
 
-		if (tmp_rate > rate)
+		if (tmp_rate > req->rate)
 			continue;
 
-		if (best_rate < 0 || (rate - tmp_rate) < (rate - best_rate)) {
+		if (best_rate < 0 ||
+		    (req->rate - tmp_rate) < (req->rate - best_rate)) {
 			best_rate = tmp_rate;
-			*best_parent_rate = parent_rate;
-			*best_parent_hw = __clk_get_hw(parent);
+			req->best_parent_rate = parent_rate;
+			req->best_parent_hw = __clk_get_hw(parent);
 		}
 
 		if (!best_rate)
 			break;
 	}
 
-	return best_rate;
+	if (best_rate < 0)
+		return best_rate;
+
+	req->rate = best_rate;
+	return 0;
 }
 
 static int clk_programmable_set_parent(struct clk_hw *hw, u8 index)
diff --git a/drivers/clk/at91/clk-usb.c b/drivers/clk/at91/clk-usb.c
index b0cbd2b..24747df 100644
--- a/drivers/clk/at91/clk-usb.c
+++ b/drivers/clk/at91/clk-usb.c
@@ -56,12 +56,8 @@ static unsigned long at91sam9x5_clk_usb_recalc_rate(struct clk_hw *hw,
 	return DIV_ROUND_CLOSEST(parent_rate, (usbdiv + 1));
 }
 
-static long at91sam9x5_clk_usb_determine_rate(struct clk_hw *hw,
-					      unsigned long rate,
-					      unsigned long min_rate,
-					      unsigned long max_rate,
-					      unsigned long *best_parent_rate,
-					      struct clk_hw **best_parent_hw)
+static int at91sam9x5_clk_usb_determine_rate(struct clk_hw *hw,
+					     struct clk_rate_request *req)
 {
 	struct clk *parent = NULL;
 	long best_rate = -EINVAL;
@@ -80,23 +76,23 @@ static long at91sam9x5_clk_usb_determine_rate(struct clk_hw *hw,
 		for (div = 1; div < SAM9X5_USB_MAX_DIV + 2; div++) {
 			unsigned long tmp_parent_rate;
 
-			tmp_parent_rate = rate * div;
+			tmp_parent_rate = req->rate * div;
 			tmp_parent_rate = __clk_round_rate(parent,
 							   tmp_parent_rate);
 			tmp_rate = DIV_ROUND_CLOSEST(tmp_parent_rate, div);
-			if (tmp_rate < rate)
-				tmp_diff = rate - tmp_rate;
+			if (tmp_rate < req->rate)
+				tmp_diff = req->rate - tmp_rate;
 			else
-				tmp_diff = tmp_rate - rate;
+				tmp_diff = tmp_rate - req->rate;
 
 			if (best_diff < 0 || best_diff > tmp_diff) {
 				best_rate = tmp_rate;
 				best_diff = tmp_diff;
-				*best_parent_rate = tmp_parent_rate;
-				*best_parent_hw = __clk_get_hw(parent);
+				req->best_parent_rate = tmp_parent_rate;
+				req->best_parent_hw = __clk_get_hw(parent);
 			}
 
-			if (!best_diff || tmp_rate < rate)
+			if (!best_diff || tmp_rate < req->rate)
 				break;
 		}
 
@@ -104,7 +100,11 @@ static long at91sam9x5_clk_usb_determine_rate(struct clk_hw *hw,
 			break;
 	}
 
-	return best_rate;
+	if (best_rate < 0)
+		return best_rate;
+
+	req->rate = best_rate;
+	return 0;
 }
 
 static int at91sam9x5_clk_usb_set_parent(struct clk_hw *hw, u8 index)
diff --git a/drivers/clk/bcm/clk-kona.c b/drivers/clk/bcm/clk-kona.c
index 79a9850..d9c039c 100644
--- a/drivers/clk/bcm/clk-kona.c
+++ b/drivers/clk/bcm/clk-kona.c
@@ -1017,10 +1017,8 @@ static long kona_peri_clk_round_rate(struct clk_hw *hw, unsigned long rate,
 				rate ? rate : 1, *parent_rate, NULL);
 }
 
-static long kona_peri_clk_determine_rate(struct clk_hw *hw, unsigned long rate,
-		unsigned long min_rate,
-		unsigned long max_rate,
-		unsigned long *best_parent_rate, struct clk_hw **best_parent)
+static int kona_peri_clk_determine_rate(struct clk_hw *hw,
+					struct clk_rate_request *req)
 {
 	struct kona_clk *bcm_clk = to_kona_clk(hw);
 	struct clk *clk = hw->clk;
@@ -1029,6 +1027,7 @@ static long kona_peri_clk_determine_rate(struct clk_hw *hw, unsigned long rate,
 	unsigned long best_delta;
 	unsigned long best_rate;
 	u32 parent_count;
+	long rate;
 	u32 which;
 
 	/*
@@ -1037,14 +1036,21 @@ static long kona_peri_clk_determine_rate(struct clk_hw *hw, unsigned long rate,
 	 */
 	WARN_ON_ONCE(bcm_clk->init_data.flags & CLK_SET_RATE_NO_REPARENT);
 	parent_count = (u32)bcm_clk->init_data.num_parents;
-	if (parent_count < 2)
-		return kona_peri_clk_round_rate(hw, rate, best_parent_rate);
+	if (parent_count < 2) {
+		rate = kona_peri_clk_round_rate(hw, req->rate,
+						&req->best_parent_rate);
+		if (rate < 0)
+			return rate;
+
+		req->rate = rate;
+		return 0;
+	}
 
 	/* Unless we can do better, stick with current parent */
 	current_parent = clk_get_parent(clk);
 	parent_rate = __clk_get_rate(current_parent);
-	best_rate = kona_peri_clk_round_rate(hw, rate, &parent_rate);
-	best_delta = abs(best_rate - rate);
+	best_rate = kona_peri_clk_round_rate(hw, req->rate, &parent_rate);
+	best_delta = abs(best_rate - req->rate);
 
 	/* Check whether any other parent clock can produce a better result */
 	for (which = 0; which < parent_count; which++) {
@@ -1058,17 +1064,19 @@ static long kona_peri_clk_determine_rate(struct clk_hw *hw, unsigned long rate,
 
 		/* We don't support CLK_SET_RATE_PARENT */
 		parent_rate = __clk_get_rate(parent);
-		other_rate = kona_peri_clk_round_rate(hw, rate, &parent_rate);
-		delta = abs(other_rate - rate);
+		other_rate = kona_peri_clk_round_rate(hw, req->rate,
+						      &parent_rate);
+		delta = abs(other_rate - req->rate);
 		if (delta < best_delta) {
 			best_delta = delta;
 			best_rate = other_rate;
-			*best_parent = __clk_get_hw(parent);
-			*best_parent_rate = parent_rate;
+			req->best_parent_hw = __clk_get_hw(parent);
+			req->best_parent_rate = parent_rate;
 		}
 	}
 
-	return best_rate;
+	req->rate = best_rate;
+	return 0;
 }
 
 static int kona_peri_clk_set_parent(struct clk_hw *hw, u8 index)
diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
index 616f5ae..9e69f34 100644
--- a/drivers/clk/clk-composite.c
+++ b/drivers/clk/clk-composite.c
@@ -55,11 +55,8 @@ static unsigned long clk_composite_recalc_rate(struct clk_hw *hw,
 	return rate_ops->recalc_rate(rate_hw, parent_rate);
 }
 
-static long clk_composite_determine_rate(struct clk_hw *hw, unsigned long rate,
-					unsigned long min_rate,
-					unsigned long max_rate,
-					unsigned long *best_parent_rate,
-					struct clk_hw **best_parent_p)
+static int clk_composite_determine_rate(struct clk_hw *hw,
+					struct clk_rate_request *req)
 {
 	struct clk_composite *composite = to_clk_composite(hw);
 	const struct clk_ops *rate_ops = composite->rate_ops;
@@ -71,25 +68,28 @@ static long clk_composite_determine_rate(struct clk_hw *hw, unsigned long rate,
 	long tmp_rate, best_rate = 0;
 	unsigned long rate_diff;
 	unsigned long best_rate_diff = ULONG_MAX;
+	long rate;
 	int i;
 
 	if (rate_hw && rate_ops && rate_ops->determine_rate) {
 		__clk_hw_set_clk(rate_hw, hw);
-		return rate_ops->determine_rate(rate_hw, rate, min_rate,
-						max_rate,
-						best_parent_rate,
-						best_parent_p);
+		return rate_ops->determine_rate(rate_hw, req);
 	} else if (rate_hw && rate_ops && rate_ops->round_rate &&
 		   mux_hw && mux_ops && mux_ops->set_parent) {
-		*best_parent_p = NULL;
+		req->best_parent_hw = NULL;
 
 		if (__clk_get_flags(hw->clk) & CLK_SET_RATE_NO_REPARENT) {
 			parent = clk_get_parent(mux_hw->clk);
-			*best_parent_p = __clk_get_hw(parent);
-			*best_parent_rate = __clk_get_rate(parent);
+			req->best_parent_hw = __clk_get_hw(parent);
+			req->best_parent_rate = __clk_get_rate(parent);
 
-			return rate_ops->round_rate(rate_hw, rate,
-						    best_parent_rate);
+			rate = rate_ops->round_rate(rate_hw, req->rate,
+						    &req->best_parent_rate);
+			if (rate < 0)
+				return rate;
+
+			req->rate = rate;
+			return 0;
 		}
 
 		for (i = 0; i < __clk_get_num_parents(mux_hw->clk); i++) {
@@ -99,33 +99,33 @@ static long clk_composite_determine_rate(struct clk_hw *hw, unsigned long rate,
 
 			parent_rate = __clk_get_rate(parent);
 
-			tmp_rate = rate_ops->round_rate(rate_hw, rate,
+			tmp_rate = rate_ops->round_rate(rate_hw, req->rate,
 							&parent_rate);
 			if (tmp_rate < 0)
 				continue;
 
-			rate_diff = abs(rate - tmp_rate);
+			rate_diff = abs(req->rate - tmp_rate);
 
-			if (!rate_diff || !*best_parent_p
+			if (!rate_diff || !req->best_parent_hw
 				       || best_rate_diff > rate_diff) {
-				*best_parent_p = __clk_get_hw(parent);
-				*best_parent_rate = parent_rate;
+				req->best_parent_hw = __clk_get_hw(parent);
+				req->best_parent_rate = parent_rate;
 				best_rate_diff = rate_diff;
 				best_rate = tmp_rate;
 			}
 
 			if (!rate_diff)
-				return rate;
+				return 0;
 		}
 
-		return best_rate;
+		req->rate = best_rate;
+		return 0;
 	} else if (mux_hw && mux_ops && mux_ops->determine_rate) {
 		__clk_hw_set_clk(mux_hw, hw);
-		return mux_ops->determine_rate(mux_hw, rate, min_rate,
-					       max_rate, best_parent_rate,
-					       best_parent_p);
+		return mux_ops->determine_rate(mux_hw, req);
 	} else {
 		pr_err("clk: clk_composite_determine_rate function called, but no mux or rate callback set!\n");
+		req->rate = 0;
 		return 0;
 	}
 }
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index ddb4b54..c182d8a 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -436,28 +436,37 @@ static bool mux_is_better_rate(unsigned long rate, unsigned long now,
 	return now <= rate && now > best;
 }
 
-static long
-clk_mux_determine_rate_flags(struct clk_hw *hw, unsigned long rate,
-			     unsigned long min_rate,
-			     unsigned long max_rate,
-			     unsigned long *best_parent_rate,
-			     struct clk_hw **best_parent_p,
+static int
+clk_mux_determine_rate_flags(struct clk_hw *hw, struct clk_rate_request *req,
 			     unsigned long flags)
 {
 	struct clk_core *core = hw->core, *parent, *best_parent = NULL;
-	int i, num_parents;
-	unsigned long parent_rate, best = 0;
+	int i, num_parents, ret;
+	unsigned long best = 0;
+	struct clk_rate_request parent_req = *req;
 
 	/* if NO_REPARENT flag set, pass through to current parent */
 	if (core->flags & CLK_SET_RATE_NO_REPARENT) {
 		parent = core->parent;
-		if (core->flags & CLK_SET_RATE_PARENT)
-			best = __clk_determine_rate(parent ? parent->hw : NULL,
-						    rate, min_rate, max_rate);
-		else if (parent)
+		if (core->flags & CLK_SET_RATE_PARENT) {
+			ret = __clk_determine_rate(parent ? parent->hw : NULL,
+						   &parent_req);
+			if (ret)
+				return ret;
+
+			best = parent_req.rate;
+			req->best_parent_hw = parent->hw;
+			req->best_parent_rate = best;
+		} else if (parent) {
 			best = clk_core_get_rate_nolock(parent);
-		else
+			req->best_parent_hw = parent->hw;
+			req->best_parent_rate = best;
+		} else {
 			best = clk_core_get_rate_nolock(core);
+			req->best_parent_hw = NULL;
+			req->best_parent_rate = 0;
+		}
+
 		goto out;
 	}
 
@@ -467,24 +476,30 @@ clk_mux_determine_rate_flags(struct clk_hw *hw, unsigned long rate,
 		parent = clk_core_get_parent_by_index(core, i);
 		if (!parent)
 			continue;
-		if (core->flags & CLK_SET_RATE_PARENT)
-			parent_rate = __clk_determine_rate(parent->hw, rate,
-							   min_rate,
-							   max_rate);
-		else
-			parent_rate = clk_core_get_rate_nolock(parent);
-		if (mux_is_better_rate(rate, parent_rate, best, flags)) {
+
+		if (core->flags & CLK_SET_RATE_PARENT) {
+			parent_req = *req;
+			ret = __clk_determine_rate(parent->hw, &parent_req);
+			if (ret)
+				continue;
+		} else {
+			parent_req.rate = clk_core_get_rate_nolock(parent);
+		}
+
+		if (mux_is_better_rate(req->rate, parent_req.rate,
+				       best, flags)) {
 			best_parent = parent;
-			best = parent_rate;
+			best = parent_req.rate;
 		}
 	}
 
 out:
 	if (best_parent)
-		*best_parent_p = best_parent->hw;
-	*best_parent_rate = best;
+		req->best_parent_hw = best_parent->hw;
+	req->best_parent_rate = best;
+	req->rate = best;
 
-	return best;
+	return 0;
 }
 
 struct clk *__clk_lookup(const char *name)
@@ -515,28 +530,17 @@ static void clk_core_get_boundaries(struct clk_core *core,
  * directly as a determine_rate callback (e.g. for a mux), or from a more
  * complex clock that may combine a mux with other operations.
  */
-long __clk_mux_determine_rate(struct clk_hw *hw, unsigned long rate,
-			      unsigned long min_rate,
-			      unsigned long max_rate,
-			      unsigned long *best_parent_rate,
-			      struct clk_hw **best_parent_p)
+int __clk_mux_determine_rate(struct clk_hw *hw,
+			     struct clk_rate_request *req)
 {
-	return clk_mux_determine_rate_flags(hw, rate, min_rate, max_rate,
-					    best_parent_rate,
-					    best_parent_p, 0);
+	return clk_mux_determine_rate_flags(hw, req, 0);
 }
 EXPORT_SYMBOL_GPL(__clk_mux_determine_rate);
 
-long __clk_mux_determine_rate_closest(struct clk_hw *hw, unsigned long rate,
-			      unsigned long min_rate,
-			      unsigned long max_rate,
-			      unsigned long *best_parent_rate,
-			      struct clk_hw **best_parent_p)
+int __clk_mux_determine_rate_closest(struct clk_hw *hw,
+				     struct clk_rate_request *req)
 {
-	return clk_mux_determine_rate_flags(hw, rate, min_rate, max_rate,
-					    best_parent_rate,
-					    best_parent_p,
-					    CLK_MUX_ROUND_CLOSEST);
+	return clk_mux_determine_rate_flags(hw, req, CLK_MUX_ROUND_CLOSEST);
 }
 EXPORT_SYMBOL_GPL(__clk_mux_determine_rate_closest);
 
@@ -759,14 +763,11 @@ int clk_enable(struct clk *clk)
 }
 EXPORT_SYMBOL_GPL(clk_enable);
 
-static unsigned long clk_core_round_rate_nolock(struct clk_core *core,
-						unsigned long rate,
-						unsigned long min_rate,
-						unsigned long max_rate)
+static int clk_core_round_rate_nolock(struct clk_core *core,
+				      struct clk_rate_request *req)
 {
-	unsigned long parent_rate = 0;
 	struct clk_core *parent;
-	struct clk_hw *parent_hw;
+	long rate;
 
 	lockdep_assert_held(&prepare_lock);
 
@@ -774,21 +775,28 @@ static unsigned long clk_core_round_rate_nolock(struct clk_core *core,
 		return 0;
 
 	parent = core->parent;
-	if (parent)
-		parent_rate = parent->rate;
+	if (parent) {
+		req->best_parent_hw = parent->hw;
+		req->best_parent_rate = parent->rate;
+	} else {
+		req->best_parent_hw = NULL;
+		req->best_parent_rate = 0;
+	}
 
 	if (core->ops->determine_rate) {
-		parent_hw = parent ? parent->hw : NULL;
-		return core->ops->determine_rate(core->hw, rate,
-						min_rate, max_rate,
-						&parent_rate, &parent_hw);
-	} else if (core->ops->round_rate)
-		return core->ops->round_rate(core->hw, rate, &parent_rate);
-	else if (core->flags & CLK_SET_RATE_PARENT)
-		return clk_core_round_rate_nolock(core->parent, rate, min_rate,
-						  max_rate);
-	else
-		return core->rate;
+		return core->ops->determine_rate(core->hw, req);
+	} else if (core->ops->round_rate) {
+		rate = core->ops->round_rate(core->hw, req->rate,
+					     &req->best_parent_rate);
+		if (rate < 0)
+			return rate;
+
+		req->rate = rate;
+	} else if (core->flags & CLK_SET_RATE_PARENT) {
+		return clk_core_round_rate_nolock(parent, req);
+	}
+
+	return 0;
 }
 
 /**
@@ -800,15 +808,12 @@ static unsigned long clk_core_round_rate_nolock(struct clk_core *core,
  *
  * Useful for clk_ops such as .set_rate and .determine_rate.
  */
-unsigned long __clk_determine_rate(struct clk_hw *hw,
-				   unsigned long rate,
-				   unsigned long min_rate,
-				   unsigned long max_rate)
+int __clk_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
 {
 	if (!hw)
 		return 0;
 
-	return clk_core_round_rate_nolock(hw->core, rate, min_rate, max_rate);
+	return clk_core_round_rate_nolock(hw->core, req);
 }
 EXPORT_SYMBOL_GPL(__clk_determine_rate);
 
@@ -821,15 +826,20 @@ EXPORT_SYMBOL_GPL(__clk_determine_rate);
  */
 unsigned long __clk_round_rate(struct clk *clk, unsigned long rate)
 {
-	unsigned long min_rate;
-	unsigned long max_rate;
+	struct clk_rate_request req;
+	int ret;
 
 	if (!clk)
 		return 0;
 
-	clk_core_get_boundaries(clk->core, &min_rate, &max_rate);
+	clk_core_get_boundaries(clk->core, &req.min_rate, &req.max_rate);
+	req.rate = rate;
+
+	ret = clk_core_round_rate_nolock(clk->core, &req);
+	if (ret)
+		return 0;
 
-	return clk_core_round_rate_nolock(clk->core, rate, min_rate, max_rate);
+	return req.rate;
 }
 EXPORT_SYMBOL_GPL(__clk_round_rate);
 
@@ -1249,7 +1259,6 @@ static struct clk_core *clk_calc_new_rates(struct clk_core *core,
 {
 	struct clk_core *top = core;
 	struct clk_core *old_parent, *parent;
-	struct clk_hw *parent_hw;
 	unsigned long best_parent_rate = 0;
 	unsigned long new_rate;
 	unsigned long min_rate;
@@ -1270,20 +1279,29 @@ static struct clk_core *clk_calc_new_rates(struct clk_core *core,
 
 	/* find the closest rate and parent clk/rate */
 	if (core->ops->determine_rate) {
-		parent_hw = parent ? parent->hw : NULL;
-		ret = core->ops->determine_rate(core->hw, rate,
-					       min_rate,
-					       max_rate,
-					       &best_parent_rate,
-					       &parent_hw);
+		struct clk_rate_request req;
+
+		req.rate = rate;
+		req.min_rate = min_rate;
+		req.max_rate = max_rate;
+		if (parent) {
+			req.best_parent_hw = parent->hw;
+			req.best_parent_rate = parent->rate;
+		} else {
+			req.best_parent_hw = NULL;
+			req.best_parent_rate = 0;
+		}
+
+		ret = core->ops->determine_rate(core->hw, &req);
 		if (ret < 0)
 			return NULL;
 
-		new_rate = ret;
-		parent = parent_hw ? parent_hw->core : NULL;
+		best_parent_rate = req.best_parent_rate;
+		new_rate = req.rate;
+		parent = req.best_parent_hw ? req.best_parent_hw->core : NULL;
 	} else if (core->ops->round_rate) {
 		ret = core->ops->round_rate(core->hw, rate,
-					   &best_parent_rate);
+					    &best_parent_rate);
 		if (ret < 0)
 			return NULL;
 
diff --git a/drivers/clk/hisilicon/clk-hi3620.c b/drivers/clk/hisilicon/clk-hi3620.c
index 715d34a..e1d72e6 100644
--- a/drivers/clk/hisilicon/clk-hi3620.c
+++ b/drivers/clk/hisilicon/clk-hi3620.c
@@ -294,34 +294,31 @@ static unsigned long mmc_clk_recalc_rate(struct clk_hw *hw,
 	}
 }
 
-static long mmc_clk_determine_rate(struct clk_hw *hw, unsigned long rate,
-			      unsigned long min_rate,
-			      unsigned long max_rate,
-			      unsigned long *best_parent_rate,
-			      struct clk_hw **best_parent_p)
+static int mmc_clk_determine_rate(struct clk_hw *hw,
+				  struct clk_rate_request *req)
 {
 	struct clk_mmc *mclk = to_mmc(hw);
-	unsigned long best = 0;
 
-	if ((rate <= 13000000) && (mclk->id == HI3620_MMC_CIUCLK1)) {
-		rate = 13000000;
-		best = 26000000;
-	} else if (rate <= 26000000) {
-		rate = 25000000;
-		best = 180000000;
-	} else if (rate <= 52000000) {
-		rate = 50000000;
-		best = 360000000;
-	} else if (rate <= 100000000) {
-		rate = 100000000;
-		best = 720000000;
+	req->best_parent_hw = __clk_get_hw(__clk_get_parent(hw->clk));
+
+	if ((req->rate <= 13000000) && (mclk->id == HI3620_MMC_CIUCLK1)) {
+		req->rate = 13000000;
+		req->best_parent_rate = 26000000;
+	} else if (req->rate <= 26000000) {
+		req->rate = 25000000;
+		req->best_parent_rate = 180000000;
+	} else if (req->rate <= 52000000) {
+		req->rate = 50000000;
+		req->best_parent_rate = 360000000;
+	} else if (req->rate <= 100000000) {
+		req->rate = 100000000;
+		req->best_parent_rate = 720000000;
 	} else {
 		/* max is 180M */
-		rate = 180000000;
-		best = 1440000000;
+		req->rate = 180000000;
+		req->best_parent_rate = 1440000000;
 	}
-	*best_parent_rate = best;
-	return rate;
+	return 0;
 }
 
 static u32 mmc_clk_delay(u32 val, u32 para, u32 off, u32 len)
diff --git a/drivers/clk/mmp/clk-mix.c b/drivers/clk/mmp/clk-mix.c
index de6a873..9ac3684 100644
--- a/drivers/clk/mmp/clk-mix.c
+++ b/drivers/clk/mmp/clk-mix.c
@@ -201,11 +201,8 @@ error:
 	return ret;
 }
 
-static long mmp_clk_mix_determine_rate(struct clk_hw *hw, unsigned long rate,
-					unsigned long min_rate,
-					unsigned long max_rate,
-					unsigned long *best_parent_rate,
-					struct clk_hw **best_parent_clk)
+static int mmp_clk_mix_determine_rate(struct clk_hw *hw,
+				      struct clk_rate_request *req)
 {
 	struct mmp_clk_mix *mix = to_clk_mix(hw);
 	struct mmp_clk_mix_clk_table *item;
@@ -233,7 +230,7 @@ static long mmp_clk_mix_determine_rate(struct clk_hw *hw, unsigned long rate,
 							item->parent_index);
 			parent_rate = __clk_get_rate(parent);
 			mix_rate = parent_rate / item->divisor;
-			gap = abs(mix_rate - rate);
+			gap = abs(mix_rate - req->rate);
 			if (parent_best == NULL || gap < gap_best) {
 				parent_best = parent;
 				parent_rate_best = parent_rate;
@@ -251,7 +248,7 @@ static long mmp_clk_mix_determine_rate(struct clk_hw *hw, unsigned long rate,
 			for (j = 0; j < div_val_max; j++) {
 				div = _get_div(mix, j);
 				mix_rate = parent_rate / div;
-				gap = abs(mix_rate - rate);
+				gap = abs(mix_rate - req->rate);
 				if (parent_best == NULL || gap < gap_best) {
 					parent_best = parent;
 					parent_rate_best = parent_rate;
@@ -265,10 +262,11 @@ static long mmp_clk_mix_determine_rate(struct clk_hw *hw, unsigned long rate,
 	}
 
 found:
-	*best_parent_rate = parent_rate_best;
-	*best_parent_clk = __clk_get_hw(parent_best);
+	req->best_parent_rate = parent_rate_best;
+	req->best_parent_hw = __clk_get_hw(parent_best);
+	req->rate = mix_rate_best;
 
-	return mix_rate_best;
+	return 0;
 }
 
 static int mmp_clk_mix_set_rate_and_parent(struct clk_hw *hw,
diff --git a/drivers/clk/qcom/clk-pll.c b/drivers/clk/qcom/clk-pll.c
index 245d506..f8f1d44 100644
--- a/drivers/clk/qcom/clk-pll.c
+++ b/drivers/clk/qcom/clk-pll.c
@@ -135,17 +135,21 @@ struct pll_freq_tbl *find_freq(const struct pll_freq_tbl *f, unsigned long rate)
 	return NULL;
 }
 
-static long
-clk_pll_determine_rate(struct clk_hw *hw, unsigned long rate,
-		       unsigned long min_rate, unsigned long max_rate,
-		       unsigned long *p_rate, struct clk_hw **p)
+static int
+clk_pll_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
 {
+	struct clk *parent = __clk_get_parent(hw->clk);
 	struct clk_pll *pll = to_clk_pll(hw);
 	const struct pll_freq_tbl *f;
 
-	f = find_freq(pll->freq_tbl, rate);
+	req->best_parent_hw = __clk_get_hw(parent);
+	req->best_parent_rate = __clk_get_rate(parent);
+
+	f = find_freq(pll->freq_tbl, req->rate);
 	if (!f)
-		return clk_pll_recalc_rate(hw, *p_rate);
+		req->rate = clk_pll_recalc_rate(hw, req->best_parent_rate);
+	else
+		req->rate = f->freq;
 
 	return f->freq;
 }
diff --git a/drivers/clk/qcom/clk-rcg.c b/drivers/clk/qcom/clk-rcg.c
index 7b3d626..2bc42bb 100644
--- a/drivers/clk/qcom/clk-rcg.c
+++ b/drivers/clk/qcom/clk-rcg.c
@@ -404,13 +404,11 @@ clk_dyn_rcg_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 	return calc_rate(parent_rate, m, n, mode, pre_div);
 }
 
-static long _freq_tbl_determine_rate(struct clk_hw *hw,
-		const struct freq_tbl *f, unsigned long rate,
-		unsigned long min_rate, unsigned long max_rate,
-		unsigned long *p_rate, struct clk_hw **p_hw,
+static int _freq_tbl_determine_rate(struct clk_hw *hw, const struct freq_tbl *f,
+		struct clk_rate_request *req,
 		const struct parent_map *parent_map)
 {
-	unsigned long clk_flags;
+	unsigned long clk_flags, rate = req->rate;
 	struct clk *p;
 	int index;
 
@@ -435,25 +433,24 @@ static long _freq_tbl_determine_rate(struct clk_hw *hw,
 	} else {
 		rate =  __clk_get_rate(p);
 	}
-	*p_hw = __clk_get_hw(p);
-	*p_rate = rate;
+	req->best_parent_hw = __clk_get_hw(p);
+	req->best_parent_rate = rate;
+	req->rate = f->freq;
 
-	return f->freq;
+	return 0;
 }
 
-static long clk_rcg_determine_rate(struct clk_hw *hw, unsigned long rate,
-		unsigned long min_rate, unsigned long max_rate,
-		unsigned long *p_rate, struct clk_hw **p)
+static int clk_rcg_determine_rate(struct clk_hw *hw,
+				  struct clk_rate_request *req)
 {
 	struct clk_rcg *rcg = to_clk_rcg(hw);
 
-	return _freq_tbl_determine_rate(hw, rcg->freq_tbl, rate, min_rate,
-			max_rate, p_rate, p, rcg->s.parent_map);
+	return _freq_tbl_determine_rate(hw, rcg->freq_tbl, req,
+					rcg->s.parent_map);
 }
 
-static long clk_dyn_rcg_determine_rate(struct clk_hw *hw, unsigned long rate,
-		unsigned long min_rate, unsigned long max_rate,
-		unsigned long *p_rate, struct clk_hw **p)
+static int clk_dyn_rcg_determine_rate(struct clk_hw *hw,
+				      struct clk_rate_request *req)
 {
 	struct clk_dyn_rcg *rcg = to_clk_dyn_rcg(hw);
 	u32 reg;
@@ -464,13 +461,11 @@ static long clk_dyn_rcg_determine_rate(struct clk_hw *hw, unsigned long rate,
 	bank = reg_to_bank(rcg, reg);
 	s = &rcg->s[bank];
 
-	return _freq_tbl_determine_rate(hw, rcg->freq_tbl, rate, min_rate,
-			max_rate, p_rate, p, s->parent_map);
+	return _freq_tbl_determine_rate(hw, rcg->freq_tbl, req, s->parent_map);
 }
 
-static long clk_rcg_bypass_determine_rate(struct clk_hw *hw, unsigned long rate,
-		unsigned long min_rate, unsigned long max_rate,
-		unsigned long *p_rate, struct clk_hw **p_hw)
+static int clk_rcg_bypass_determine_rate(struct clk_hw *hw,
+					 struct clk_rate_request *req)
 {
 	struct clk_rcg *rcg = to_clk_rcg(hw);
 	const struct freq_tbl *f = rcg->freq_tbl;
@@ -478,10 +473,11 @@ static long clk_rcg_bypass_determine_rate(struct clk_hw *hw, unsigned long rate,
 	int index = qcom_find_src_index(hw, rcg->s.parent_map, f->src);
 
 	p = clk_get_parent_by_index(hw->clk, index);
-	*p_hw = __clk_get_hw(p);
-	*p_rate = __clk_round_rate(p, rate);
+	req->best_parent_hw = __clk_get_hw(p);
+	req->best_parent_rate = __clk_round_rate(p, req->rate);
+	req->rate = req->best_parent_rate;
 
-	return *p_rate;
+	return 0;
 }
 
 static int __clk_rcg_set_rate(struct clk_rcg *rcg, const struct freq_tbl *f)
diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index b95d17f..aa6c3bd 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -176,11 +176,10 @@ clk_rcg2_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 	return calc_rate(parent_rate, m, n, mode, hid_div);
 }
 
-static long _freq_tbl_determine_rate(struct clk_hw *hw,
-		const struct freq_tbl *f, unsigned long rate,
-		unsigned long *p_rate, struct clk_hw **p_hw)
+static int _freq_tbl_determine_rate(struct clk_hw *hw,
+		const struct freq_tbl *f, struct clk_rate_request *req)
 {
-	unsigned long clk_flags;
+	unsigned long clk_flags, rate = req->rate;
 	struct clk *p;
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
 	int index;
@@ -210,19 +209,19 @@ static long _freq_tbl_determine_rate(struct clk_hw *hw,
 	} else {
 		rate =  __clk_get_rate(p);
 	}
-	*p_hw = __clk_get_hw(p);
-	*p_rate = rate;
+	req->best_parent_hw = __clk_get_hw(p);
+	req->best_parent_rate = rate;
+	req->rate = f->freq;
 
-	return f->freq;
+	return 0;
 }
 
-static long clk_rcg2_determine_rate(struct clk_hw *hw, unsigned long rate,
-		unsigned long min_rate, unsigned long max_rate,
-		unsigned long *p_rate, struct clk_hw **p)
+static int clk_rcg2_determine_rate(struct clk_hw *hw,
+				   struct clk_rate_request *req)
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
 
-	return _freq_tbl_determine_rate(hw, rcg->freq_tbl, rate, p_rate, p);
+	return _freq_tbl_determine_rate(hw, rcg->freq_tbl, req);
 }
 
 static int clk_rcg2_configure(struct clk_rcg2 *rcg, const struct freq_tbl *f)
@@ -374,35 +373,34 @@ static int clk_edp_pixel_set_rate_and_parent(struct clk_hw *hw,
 	return clk_edp_pixel_set_rate(hw, rate, parent_rate);
 }
 
-static long clk_edp_pixel_determine_rate(struct clk_hw *hw, unsigned long rate,
-				 unsigned long min_rate,
-				 unsigned long max_rate,
-				 unsigned long *p_rate, struct clk_hw **p)
+static int clk_edp_pixel_determine_rate(struct clk_hw *hw,
+					struct clk_rate_request *req)
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
 	const struct freq_tbl *f = rcg->freq_tbl;
 	const struct frac_entry *frac;
 	int delta = 100000;
-	s64 src_rate = *p_rate;
 	s64 request;
 	u32 mask = BIT(rcg->hid_width) - 1;
 	u32 hid_div;
 	int index = qcom_find_src_index(hw, rcg->parent_map, f->src);
+	struct clk *p = clk_get_parent_by_index(hw->clk, index);
 
 	/* Force the correct parent */
-	*p = __clk_get_hw(clk_get_parent_by_index(hw->clk, index));
+	req->best_parent_hw = __clk_get_hw(p);
+	req->best_parent_rate = __clk_get_rate(p);
 
-	if (src_rate == 810000000)
+	if (req->best_parent_rate == 810000000)
 		frac = frac_table_810m;
 	else
 		frac = frac_table_675m;
 
 	for (; frac->num; frac++) {
-		request = rate;
+		request = req->rate;
 		request *= frac->den;
 		request = div_s64(request, frac->num);
-		if ((src_rate < (request - delta)) ||
-		    (src_rate > (request + delta)))
+		if ((req->best_parent_rate < (request - delta)) ||
+		    (req->best_parent_rate > (request + delta)))
 			continue;
 
 		regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG,
@@ -410,8 +408,10 @@ static long clk_edp_pixel_determine_rate(struct clk_hw *hw, unsigned long rate,
 		hid_div >>= CFG_SRC_DIV_SHIFT;
 		hid_div &= mask;
 
-		return calc_rate(src_rate, frac->num, frac->den, !!frac->den,
-				 hid_div);
+		req->rate = calc_rate(req->best_parent_rate,
+				      frac->num, frac->den,
+				      !!frac->den, hid_div);
+		return 0;
 	}
 
 	return -EINVAL;
@@ -428,9 +428,8 @@ const struct clk_ops clk_edp_pixel_ops = {
 };
 EXPORT_SYMBOL_GPL(clk_edp_pixel_ops);
 
-static long clk_byte_determine_rate(struct clk_hw *hw, unsigned long rate,
-			 unsigned long min_rate, unsigned long max_rate,
-			 unsigned long *p_rate, struct clk_hw **p_hw)
+static int clk_byte_determine_rate(struct clk_hw *hw,
+				   struct clk_rate_request *req)
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
 	const struct freq_tbl *f = rcg->freq_tbl;
@@ -439,17 +438,19 @@ static long clk_byte_determine_rate(struct clk_hw *hw, unsigned long rate,
 	u32 mask = BIT(rcg->hid_width) - 1;
 	struct clk *p;
 
-	if (rate == 0)
+	if (req->rate == 0)
 		return -EINVAL;
 
 	p = clk_get_parent_by_index(hw->clk, index);
-	*p_hw = __clk_get_hw(p);
-	*p_rate = parent_rate = __clk_round_rate(p, rate);
+	req->best_parent_hw = __clk_get_hw(p);
+	req->best_parent_rate = parent_rate = __clk_round_rate(p, req->rate);
 
-	div = DIV_ROUND_UP((2 * parent_rate), rate) - 1;
+	div = DIV_ROUND_UP((2 * parent_rate), req->rate) - 1;
 	div = min_t(u32, div, mask);
 
-	return calc_rate(parent_rate, 0, 0, 0, div);
+	req->rate = calc_rate(parent_rate, 0, 0, 0, div);
+
+	return 0;
 }
 
 static int clk_byte_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -494,10 +495,8 @@ static const struct frac_entry frac_table_pixel[] = {
 	{ }
 };
 
-static long clk_pixel_determine_rate(struct clk_hw *hw, unsigned long rate,
-				 unsigned long min_rate,
-				 unsigned long max_rate,
-				 unsigned long *p_rate, struct clk_hw **p)
+static int clk_pixel_determine_rate(struct clk_hw *hw,
+				    struct clk_rate_request *req)
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
 	unsigned long request, src_rate;
@@ -507,18 +506,19 @@ static long clk_pixel_determine_rate(struct clk_hw *hw, unsigned long rate,
 	int index = qcom_find_src_index(hw, rcg->parent_map, f->src);
 	struct clk *parent = clk_get_parent_by_index(hw->clk, index);
 
-	*p = __clk_get_hw(parent);
+	req->best_parent_hw = __clk_get_hw(parent);
 
 	for (; frac->num; frac++) {
-		request = (rate * frac->den) / frac->num;
+		request = (req->rate * frac->den) / frac->num;
 
 		src_rate = __clk_round_rate(parent, request);
 		if ((src_rate < (request - delta)) ||
 			(src_rate > (request + delta)))
 			continue;
 
-		*p_rate = src_rate;
-		return (src_rate * frac->num) / frac->den;
+		req->best_parent_rate = src_rate;
+		req->rate = (src_rate * frac->num) / frac->den;
+		return 0;
 	}
 
 	return -EINVAL;
diff --git a/drivers/clk/sunxi/clk-factors.c b/drivers/clk/sunxi/clk-factors.c
index 8c20190..7a48587 100644
--- a/drivers/clk/sunxi/clk-factors.c
+++ b/drivers/clk/sunxi/clk-factors.c
@@ -79,11 +79,8 @@ static long clk_factors_round_rate(struct clk_hw *hw, unsigned long rate,
 	return rate;
 }
 
-static long clk_factors_determine_rate(struct clk_hw *hw, unsigned long rate,
-				       unsigned long min_rate,
-				       unsigned long max_rate,
-				       unsigned long *best_parent_rate,
-				       struct clk_hw **best_parent_p)
+static int clk_factors_determine_rate(struct clk_hw *hw,
+				      struct clk_rate_request *req)
 {
 	struct clk *clk = hw->clk, *parent, *best_parent = NULL;
 	int i, num_parents;
@@ -96,13 +93,14 @@ static long clk_factors_determine_rate(struct clk_hw *hw, unsigned long rate,
 		if (!parent)
 			continue;
 		if (__clk_get_flags(clk) & CLK_SET_RATE_PARENT)
-			parent_rate = __clk_round_rate(parent, rate);
+			parent_rate = __clk_round_rate(parent, req->rate);
 		else
 			parent_rate = __clk_get_rate(parent);
 
-		child_rate = clk_factors_round_rate(hw, rate, &parent_rate);
+		child_rate = clk_factors_round_rate(hw, req->rate,
+						    &parent_rate);
 
-		if (child_rate <= rate && child_rate > best_child_rate) {
+		if (child_rate <= req->rate && child_rate > best_child_rate) {
 			best_parent = parent;
 			best = parent_rate;
 			best_child_rate = child_rate;
@@ -110,10 +108,11 @@ static long clk_factors_determine_rate(struct clk_hw *hw, unsigned long rate,
 	}
 
 	if (best_parent)
-		*best_parent_p = __clk_get_hw(best_parent);
-	*best_parent_rate = best;
+		req->best_parent_hw = __clk_get_hw(best_parent);
+	req->best_parent_rate = best;
+	req->rate = best_child_rate;
 
-	return best_child_rate;
+	return 0;
 }
 
 static int clk_factors_set_rate(struct clk_hw *hw, unsigned long rate,
diff --git a/drivers/clk/sunxi/clk-sun6i-ar100.c b/drivers/clk/sunxi/clk-sun6i-ar100.c
index 63cf149..d70c1ea 100644
--- a/drivers/clk/sunxi/clk-sun6i-ar100.c
+++ b/drivers/clk/sunxi/clk-sun6i-ar100.c
@@ -44,17 +44,14 @@ static unsigned long ar100_recalc_rate(struct clk_hw *hw,
 	return (parent_rate >> shift) / (div + 1);
 }
 
-static long ar100_determine_rate(struct clk_hw *hw, unsigned long rate,
-				 unsigned long min_rate,
-				 unsigned long max_rate,
-				 unsigned long *best_parent_rate,
-				 struct clk_hw **best_parent_clk)
+static int ar100_determine_rate(struct clk_hw *hw,
+				struct clk_rate_request *req)
 {
 	int nparents = __clk_get_num_parents(hw->clk);
 	long best_rate = -EINVAL;
 	int i;
 
-	*best_parent_clk = NULL;
+	req->best_parent_hw = NULL;
 
 	for (i = 0; i < nparents; i++) {
 		unsigned long parent_rate;
@@ -65,7 +62,7 @@ static long ar100_determine_rate(struct clk_hw *hw, unsigned long rate,
 
 		parent = clk_get_parent_by_index(hw->clk, i);
 		parent_rate = __clk_get_rate(parent);
-		div = DIV_ROUND_UP(parent_rate, rate);
+		div = DIV_ROUND_UP(parent_rate, req->rate);
 
 		/*
 		 * The AR100 clk contains 2 divisors:
@@ -101,14 +98,16 @@ static long ar100_determine_rate(struct clk_hw *hw, unsigned long rate,
 			continue;
 
 		tmp_rate = (parent_rate >> shift) / div;
-		if (!*best_parent_clk || tmp_rate > best_rate) {
-			*best_parent_clk = __clk_get_hw(parent);
-			*best_parent_rate = parent_rate;
+		if (!req->best_parent_hw || tmp_rate > best_rate) {
+			req->best_parent_hw = __clk_get_hw(parent);
+			req->best_parent_rate = parent_rate;
 			best_rate = tmp_rate;
 		}
 	}
 
-	return best_rate;
+	req->rate = best_rate;
+
+	return 0;
 }
 
 static int ar100_set_parent(struct clk_hw *hw, u8 index)
diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 9a82f17..d0f72a1 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -118,11 +118,8 @@ static long sun6i_ahb1_clk_round(unsigned long rate, u8 *divp, u8 *pre_divp,
 	return (parent_rate / calcm) >> calcp;
 }
 
-static long sun6i_ahb1_clk_determine_rate(struct clk_hw *hw, unsigned long rate,
-					  unsigned long min_rate,
-					  unsigned long max_rate,
-					  unsigned long *best_parent_rate,
-					  struct clk_hw **best_parent_clk)
+static int sun6i_ahb1_clk_determine_rate(struct clk_hw *hw,
+					 struct clk_rate_request *req)
 {
 	struct clk *clk = hw->clk, *parent, *best_parent = NULL;
 	int i, num_parents;
@@ -135,14 +132,14 @@ static long sun6i_ahb1_clk_determine_rate(struct clk_hw *hw, unsigned long rate,
 		if (!parent)
 			continue;
 		if (__clk_get_flags(clk) & CLK_SET_RATE_PARENT)
-			parent_rate = __clk_round_rate(parent, rate);
+			parent_rate = __clk_round_rate(parent, req->rate);
 		else
 			parent_rate = __clk_get_rate(parent);
 
-		child_rate = sun6i_ahb1_clk_round(rate, NULL, NULL, i,
+		child_rate = sun6i_ahb1_clk_round(req->rate, NULL, NULL, i,
 						  parent_rate);
 
-		if (child_rate <= rate && child_rate > best_child_rate) {
+		if (child_rate <= req->rate && child_rate > best_child_rate) {
 			best_parent = parent;
 			best = parent_rate;
 			best_child_rate = child_rate;
@@ -150,10 +147,11 @@ static long sun6i_ahb1_clk_determine_rate(struct clk_hw *hw, unsigned long rate,
 	}
 
 	if (best_parent)
-		*best_parent_clk = __clk_get_hw(best_parent);
-	*best_parent_rate = best;
+		req->best_parent_hw = __clk_get_hw(best_parent);
+	req->best_parent_rate = best;
+	req->rate = best_child_rate;
 
-	return best_child_rate;
+	return 0;
 }
 
 static int sun6i_ahb1_clk_set_rate(struct clk_hw *hw, unsigned long rate,
diff --git a/drivers/clk/tegra/clk-emc.c b/drivers/clk/tegra/clk-emc.c
index 7649685..08ae518 100644
--- a/drivers/clk/tegra/clk-emc.c
+++ b/drivers/clk/tegra/clk-emc.c
@@ -116,11 +116,7 @@ static unsigned long emc_recalc_rate(struct clk_hw *hw,
  * safer since things have EMC rate floors. Also don't touch parent_rate
  * since we don't want the CCF to play with our parent clocks.
  */
-static long emc_determine_rate(struct clk_hw *hw, unsigned long rate,
-			       unsigned long min_rate,
-			       unsigned long max_rate,
-			       unsigned long *best_parent_rate,
-			       struct clk_hw **best_parent_hw)
+static int emc_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
 {
 	struct tegra_clk_emc *tegra;
 	u8 ram_code = tegra_read_ram_code();
@@ -135,22 +131,28 @@ static long emc_determine_rate(struct clk_hw *hw, unsigned long rate,
 
 		timing = tegra->timings + i;
 
-		if (timing->rate > max_rate) {
+		if (timing->rate > req->max_rate) {
 			i = min(i, 1);
-			return tegra->timings[i - 1].rate;
+			req->rate = tegra->timings[i - 1].rate;
+			return 0;
 		}
 
-		if (timing->rate < min_rate)
+		if (timing->rate < req->min_rate)
 			continue;
 
-		if (timing->rate >= rate)
-			return timing->rate;
+		if (timing->rate >= req->rate) {
+			req->rate = timing->rate;
+			return 0;
+		}
 	}
 
-	if (timing)
-		return timing->rate;
+	if (timing) {
+		req->rate = timing->rate;
+		return 0;
+	}
 
-	return __clk_get_rate(hw->clk);
+	req->rate = __clk_get_rate(hw->clk);
+	return 0;
 }
 
 static u8 emc_get_parent(struct clk_hw *hw)
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 78842f4..14998f0 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -38,6 +38,28 @@ struct clk_core;
 struct dentry;
 
 /**
+ * struct clk_rate_request - Structure encoding the clk constraints that
+ * a clock user might require.
+ *
+ * @rate:		Requested clock rate. This field will be adjusted by
+ *			clock drivers according to hardware capabilities.
+ * @min_rate:		Minimum rate imposed by clk users.
+ * @max_rate:		Maximum rate a imposed by clk users.
+ * @best_parent_rate:	The best parent rate a parent can provide to fulfill the
+ *			requested constraints.
+ * @best_parent_hw:	The most appropriate parent clock that fulfills the
+ *			requested constraints.
+ *
+ */
+struct clk_rate_request {
+	unsigned long rate;
+	unsigned long min_rate;
+	unsigned long max_rate;
+	unsigned long best_parent_rate;
+	struct clk_hw *best_parent_hw;
+};
+
+/**
  * struct clk_ops -  Callback operations for hardware clocks; these are to
  * be provided by the clock implementation, and will be called by drivers
  * through the clk_* api.
@@ -176,12 +198,8 @@ struct clk_ops {
 					unsigned long parent_rate);
 	long		(*round_rate)(struct clk_hw *hw, unsigned long rate,
 					unsigned long *parent_rate);
-	long		(*determine_rate)(struct clk_hw *hw,
-					  unsigned long rate,
-					  unsigned long min_rate,
-					  unsigned long max_rate,
-					  unsigned long *best_parent_rate,
-					  struct clk_hw **best_parent_hw);
+	int		(*determine_rate)(struct clk_hw *hw,
+					  struct clk_rate_request *req);
 	int		(*set_parent)(struct clk_hw *hw, u8 index);
 	u8		(*get_parent)(struct clk_hw *hw);
 	int		(*set_rate)(struct clk_hw *hw, unsigned long rate,
@@ -578,20 +596,11 @@ unsigned long __clk_get_flags(struct clk *clk);
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
-			      unsigned long min_rate,
-			      unsigned long max_rate,
-			      unsigned long *best_parent_rate,
-			      struct clk_hw **best_parent_p);
+int __clk_mux_determine_rate(struct clk_hw *hw,
+			     struct clk_rate_request *req);
+int __clk_determine_rate(struct clk_hw *core, struct clk_rate_request *req);
+int __clk_mux_determine_rate_closest(struct clk_hw *hw,
+				     struct clk_rate_request *req);
 void clk_hw_reparent(struct clk_hw *hw, struct clk_hw *new_parent);
 
 static inline void __clk_hw_set_clk(struct clk_hw *dst, struct clk_hw *src)
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 79b76e1..448b4f8 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -269,23 +269,15 @@ int omap3_noncore_dpll_set_rate_and_parent(struct clk_hw *hw,
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
+				      struct clk_rate_request *req);
 unsigned long omap4_dpll_regm4xen_recalc(struct clk_hw *hw,
 					 unsigned long parent_rate);
 long omap4_dpll_regm4xen_round_rate(struct clk_hw *hw,
 				    unsigned long target_rate,
 				    unsigned long *parent_rate);
-long omap4_dpll_regm4xen_determine_rate(struct clk_hw *hw,
-					unsigned long rate,
-					unsigned long min_rate,
-					unsigned long max_rate,
-					unsigned long *best_parent_rate,
-					struct clk_hw **best_parent_clk);
+int omap4_dpll_regm4xen_determine_rate(struct clk_hw *hw,
+				       struct clk_rate_request *req);
 u8 omap2_init_dpll_parent(struct clk_hw *hw);
 unsigned long omap3_dpll_recalc(struct clk_hw *hw, unsigned long parent_rate);
 long omap2_dpll_round_rate(struct clk_hw *hw, unsigned long target_rate,
-- 
1.9.1
