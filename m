From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 24 Feb 2011 17:57:00 +0100
Subject: mxs: name##_set_rate broken
Message-ID: <20110224165700.GY22310@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn,

for the lcdif clock get_rate looks as follows:

	read div from HW_CLKCTRL_DIS_LCDIF.DIV
	return clk_get_rate(clk->parent) / div

with clk->parent being ref_pix_clk on our system.

ref_pix_clk's rate depends on HW_CLKCTRL_FRAC1.PIXFRAC.

The set_rate function for lcdif does:

	parent_rate = clk_get_rate(clk->parent);
	based on that calculate frac and div such that 
	  parent_rate * 18 / frac / div is near the requested rate.
        HW_CLKCTRL_FRAC1.PIXFRAC is updated with frac
	HW_CLKCTRL_DIS_LCDIF.DIV is updated with div

For this calculation to be correct the parent_rate needs to be
initialized not with the clock rate of lcdif's parent (i.e. ref_pix) but
that of its grandparent (i.e. ref_pix' parent == pll0_clk)

I think the else branch to if (clk->parent == &ref_xtal_clk) of
name##_set_rate is broken for all clocks, but Sascha and I didn't
verified that.  Our local fix is:

diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
index febd787..7a26edd 100644
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
@@ -309,6 +309,7 @@ static int name##_set_rate(struct clk *clk, unsigned long rate)		\
 		if (div == 0 || div > div_max)				\
 			return -EINVAL;					\
 	} else {							\
+		parent_rate = clk_get_rate(&pll0_clk);			\
 		rate >>= PARENT_RATE_SHIFT;				\
 		parent_rate >>= PARENT_RATE_SHIFT;			\
 		diff = parent_rate;					\

that seems to work.  (Actually using the grandparent instead of a hard
coded &pll0_clk would be better.)

Can you please have a look, too and maybe even come up with a better
fix?

IMHO it's time that Jeremy's clk patches get merged to resolve the
uglinesses here.  (One thing that comes to mind is that the result of
if (clk->parent == &ref_xtal_clk) doesn't change during runtime, so
it would be better to use two different implementations.  (That
statement still needs a careful verification though.))

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
