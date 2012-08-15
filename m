From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 15 Aug 2012 16:43:34 -0700
Subject: [PATCH v2 4/4] [RFC] omap3+: clk: dpll: call clk_prepare directly
In-Reply-To: <1345074214-17531-1-git-send-email-mturquette@linaro.org>
References: <1345074214-17531-1-git-send-email-mturquette@linaro.org>
Message-ID: <1345074214-17531-5-git-send-email-mturquette@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the commit titled "clk: new locking scheme for reentrancy" it became
possible for nested calls to the clock api.  The OMAP3+ DPLL .set_rate
callback has been using the __clk_prepare and __clk_unprepare calls as a
way around this limitation, but these calls are no longer needed with
the aforementioned patch.  Convert the .set_rate callback to use
clk_prepare and clk_unprepare directly.

Signed-off-by: Mike Turquette <mturquette@linaro.org>
---
 arch/arm/mach-omap2/dpll3xxx.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index ee18d00..1cc3ec8 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -436,9 +436,9 @@ int omap3_noncore_dpll_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (!dd)
 		return -EINVAL;
 
-	__clk_prepare(dd->clk_bypass);
+	clk_prepare(dd->clk_bypass);
 	clk_enable(dd->clk_bypass);
-	__clk_prepare(dd->clk_ref);
+	clk_prepare(dd->clk_ref);
 	clk_enable(dd->clk_ref);
 
 	if (__clk_get_rate(dd->clk_bypass) == rate &&
@@ -483,9 +483,9 @@ int omap3_noncore_dpll_set_rate(struct clk_hw *hw, unsigned long rate,
 		__clk_reparent(hw->clk, new_parent);
 
 	clk_disable(dd->clk_ref);
-	__clk_unprepare(dd->clk_ref);
+	clk_unprepare(dd->clk_ref);
 	clk_disable(dd->clk_bypass);
-	__clk_unprepare(dd->clk_bypass);
+	clk_unprepare(dd->clk_bypass);
 
 	return 0;
 }
-- 
1.7.9.5
