From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon,  4 Apr 2011 16:12:04 +0200
Subject: [PATCH] ARM: mxs/clock-mx28: fix up name##_set_rate
In-Reply-To: <20110225084950.GA13684@S2101-09.ap.freescale.net>
References: <20110225084950.GA13684@S2101-09.ap.freescale.net>
Message-ID: <1301926324-9659-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the lcdif clock get_rate looks as follows:

	read div from HW_CLKCTRL_DIS_LCDIF.DIV
	return clk_get_rate(clk->parent) / div

with clk->parent being ref_pix_clk on my system.

ref_pix_clk's rate depends on HW_CLKCTRL_FRAC1.PIXFRAC.

The set_rate function for lcdif does:

	parent_rate = clk_get_rate(clk->parent);
	based on that calculate frac and div such that
	  parent_rate * 18 / frac / div is near the requested rate.
	HW_CLKCTRL_FRAC1.PIXFRAC is updated with frac
	HW_CLKCTRL_DIS_LCDIF.DIV is updated with div

For this calculation to be correct parent_rate needs to be
initialized not with the clock rate of lcdif's parent (i.e. ref_pix) but
that of its grandparent (i.e. ref_pix' parent == pll0_clk).

The obvious downside of this patch is that now set_rate(lcdif) changes
its parent's rate, too.  Still this is better than a wrong rate.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mxs/clock-mx28.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
index 1ad97fe..5dcc59d 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -295,11 +295,11 @@ static int name##_set_rate(struct clk *clk, unsigned long rate)		\
 	unsigned long diff, parent_rate, calc_rate;			\
 	int i;								\
 									\
-	parent_rate = clk_get_rate(clk->parent);			\
 	div_max = BM_CLKCTRL_##dr##_DIV >> BP_CLKCTRL_##dr##_DIV;	\
 	bm_busy = BM_CLKCTRL_##dr##_BUSY;				\
 									\
 	if (clk->parent == &ref_xtal_clk) {				\
+		parent_rate = clk_get_rate(clk->parent);		\
 		div = DIV_ROUND_UP(parent_rate, rate);			\
 		if (clk == &cpu_clk) {					\
 			div_max = BM_CLKCTRL_CPU_DIV_XTAL >>		\
@@ -309,6 +309,11 @@ static int name##_set_rate(struct clk *clk, unsigned long rate)		\
 		if (div == 0 || div > div_max)				\
 			return -EINVAL;					\
 	} else {							\
+		/*							\
+		 * hack alert: this block modifies clk->parent, too,	\
+		 * so the base to use it the grand parent.		\
+		 */							\
+		parent_rate = clk_get_rate(clk->parent->parent);	\
 		rate >>= PARENT_RATE_SHIFT;				\
 		parent_rate >>= PARENT_RATE_SHIFT;			\
 		diff = parent_rate;					\
-- 
1.7.2.3
