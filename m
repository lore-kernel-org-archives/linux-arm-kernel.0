From: abhijitpagare@ti.com (Abhijit Pagare)
Date: Mon, 21 Dec 2009 16:05:47 +0530
Subject: [PATCH 1/1] ARM: OMAP4: PM: Remove the checks preventing OMAP4
	clockdomain validation
Message-ID: <1261391747-24066-1-git-send-email-abhijitpagare@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clockdomain related code beng in place it is now not necessary to have
some of the clock code commented out. This would help the validation of the
clockdomain functions using the clock level interfaces.

Signed-off-by: Abhijit Pagare <abhijitpagare@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 759c72a..a6d570a 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -181,7 +181,6 @@ static int _dpll_test_fint(struct clk *clk, u8 n)
  * clockdomain pointer, and save it into the struct clk.  Intended to be
  * called during clk_register().  No return value.
  */
-#ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once clkdm f/w is in place */
 void omap2_init_clk_clkdm(struct clk *clk)
 {
 	struct clockdomain *clkdm;
@@ -199,7 +198,6 @@ void omap2_init_clk_clkdm(struct clk *clk)
 			 "clkdm %s\n", clk->name, clk->clkdm_name);
 	}
 }
-#endif
 
 /**
  * omap2_init_clksel_parent - set a clksel clk's parent field from the hardware
@@ -476,10 +474,8 @@ void omap2_clk_disable(struct clk *clk)
 		_omap2_clk_disable(clk);
 		if (clk->parent)
 			omap2_clk_disable(clk->parent);
-#ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once clkdm f/w is in place */
 		if (clk->clkdm)
 			omap2_clkdm_clk_disable(clk->clkdm, clk);
-#endif
 
 	}
 }
@@ -489,10 +485,8 @@ int omap2_clk_enable(struct clk *clk)
 	int ret = 0;
 
 	if (clk->usecount++ == 0) {
-#ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once clkdm f/w is in place */
 		if (clk->clkdm)
 			omap2_clkdm_clk_enable(clk->clkdm, clk);
-#endif
 
 		if (clk->parent) {
 			ret = omap2_clk_enable(clk->parent);
@@ -511,10 +505,8 @@ int omap2_clk_enable(struct clk *clk)
 	return ret;
 
 err:
-#ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once clkdm f/w is in place */
 	if (clk->clkdm)
 		omap2_clkdm_clk_disable(clk->clkdm, clk);
-#endif
 	clk->usecount--;
 	return ret;
 }
-- 
1.5.4.7
