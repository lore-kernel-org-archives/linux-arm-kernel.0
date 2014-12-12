From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 12 Dec 2014 15:22:00 +0200
Subject: [PATCH 1/2] ARM: OMAP2+: clock: fix DPLL code to use new determine
 rate APIs
In-Reply-To: <1418390521-7541-1-git-send-email-t-kristo@ti.com>
References: <1418390521-7541-1-git-send-email-t-kristo@ti.com>
Message-ID: <1418390521-7541-2-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While the change for determine_rate clock operation was merged,
the OMAP counterpart using these calls was overlooked for some reason,
and caused boot failures on at least OMAP4 platforms. Fixed by updating
the DPLL API calls to use the new parameters.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Fixes: 646cafc6aa ("clk: Change clk_ops->determine_rate")
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/dpll3xxx.c |    6 +++---
 arch/arm/mach-omap2/dpll44xx.c |    6 +++---
 include/linux/clk/ti.h         |    4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index 20e120d..c2da2a0 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -474,7 +474,7 @@ void omap3_noncore_dpll_disable(struct clk_hw *hw)
  */
 long omap3_noncore_dpll_determine_rate(struct clk_hw *hw, unsigned long rate,
 				       unsigned long *best_parent_rate,
-				       struct clk **best_parent_clk)
+				       struct clk_hw **best_parent_clk)
 {
 	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
 	struct dpll_data *dd;
@@ -488,10 +488,10 @@ long omap3_noncore_dpll_determine_rate(struct clk_hw *hw, unsigned long rate,
 
 	if (__clk_get_rate(dd->clk_bypass) == rate &&
 	    (dd->modes & (1 << DPLL_LOW_POWER_BYPASS))) {
-		*best_parent_clk = dd->clk_bypass;
+		*best_parent_clk = __clk_get_hw(dd->clk_bypass);
 	} else {
 		rate = omap2_dpll_round_rate(hw, rate, best_parent_rate);
-		*best_parent_clk = dd->clk_ref;
+		*best_parent_clk = __clk_get_hw(dd->clk_ref);
 	}
 
 	*best_parent_rate = rate;
diff --git a/arch/arm/mach-omap2/dpll44xx.c b/arch/arm/mach-omap2/dpll44xx.c
index 535822f..0e58e5a 100644
--- a/arch/arm/mach-omap2/dpll44xx.c
+++ b/arch/arm/mach-omap2/dpll44xx.c
@@ -223,7 +223,7 @@ out:
  */
 long omap4_dpll_regm4xen_determine_rate(struct clk_hw *hw, unsigned long rate,
 					unsigned long *best_parent_rate,
-					struct clk **best_parent_clk)
+					struct clk_hw **best_parent_clk)
 {
 	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
 	struct dpll_data *dd;
@@ -237,11 +237,11 @@ long omap4_dpll_regm4xen_determine_rate(struct clk_hw *hw, unsigned long rate,
 
 	if (__clk_get_rate(dd->clk_bypass) == rate &&
 	    (dd->modes & (1 << DPLL_LOW_POWER_BYPASS))) {
-		*best_parent_clk = dd->clk_bypass;
+		*best_parent_clk = __clk_get_hw(dd->clk_bypass);
 	} else {
 		rate = omap4_dpll_regm4xen_round_rate(hw, rate,
 						      best_parent_rate);
-		*best_parent_clk = dd->clk_ref;
+		*best_parent_clk = __clk_get_hw(dd->clk_ref);
 	}
 
 	*best_parent_rate = rate;
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 74e5341..55ef529 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -264,7 +264,7 @@ int omap3_noncore_dpll_set_rate_and_parent(struct clk_hw *hw,
 long omap3_noncore_dpll_determine_rate(struct clk_hw *hw,
 				       unsigned long rate,
 				       unsigned long *best_parent_rate,
-				       struct clk **best_parent_clk);
+				       struct clk_hw **best_parent_clk);
 unsigned long omap4_dpll_regm4xen_recalc(struct clk_hw *hw,
 					 unsigned long parent_rate);
 long omap4_dpll_regm4xen_round_rate(struct clk_hw *hw,
@@ -273,7 +273,7 @@ long omap4_dpll_regm4xen_round_rate(struct clk_hw *hw,
 long omap4_dpll_regm4xen_determine_rate(struct clk_hw *hw,
 					unsigned long rate,
 					unsigned long *best_parent_rate,
-					struct clk **best_parent_clk);
+					struct clk_hw **best_parent_clk);
 u8 omap2_init_dpll_parent(struct clk_hw *hw);
 unsigned long omap3_dpll_recalc(struct clk_hw *hw, unsigned long parent_rate);
 long omap2_dpll_round_rate(struct clk_hw *hw, unsigned long target_rate,
-- 
1.7.9.5
