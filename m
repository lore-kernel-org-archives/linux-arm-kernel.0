From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 15 Feb 2010 18:25:01 -0700
Subject: [PATCH 17/19] OMAP3 clock: introduce DPLL4 Jtype
In-Reply-To: <20100216011942.1101.14348.stgit@localhost.localdomain>
References: <20100216011942.1101.14348.stgit@localhost.localdomain>
Message-ID: <20100216012500.1101.64927.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Richard Woodruff <r-woodruff2@ti.com>

DPLL4 for 3630 introduces a changed block called j type dpll, requiring
special divisor bits and additional reg fields. To allow for silicons to
use this, this is introduced as a flag and is enabled for 3630 silicon.
OMAP4 also has j type dpll for usb.

Tested with 3630 ZOOM3 and OMAP3430 ZOOM2

Signed-off-by: Richard Woodruff <r-woodruff2@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Vishwanath BS <Vishwanath.bs@ti.com>
[paul at pwsan.com: added some comments; updated copyrights and credits; fixed
 some style issues]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock.h             |    4 ++
 arch/arm/mach-omap2/clock34xx_data.c    |   32 ++++++++++++++-
 arch/arm/mach-omap2/clock44xx_data.c    |    1 
 arch/arm/mach-omap2/cm-regbits-34xx.h   |    5 ++
 arch/arm/mach-omap2/dpll3xxx.c          |   67 +++++++++++++++++++++++++++++--
 arch/arm/plat-omap/include/plat/clock.h |    5 ++
 6 files changed, 109 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index c500a5f..f7e7100 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -47,6 +47,10 @@
 #define DPLL_LOW_POWER_BYPASS	0x5
 #define DPLL_LOCKED		0x7
 
+/* DPLL Type and DCO Selection Flags */
+#define DPLL_J_TYPE		0x1
+#define DPLL_NO_DCO_SEL		0x2
+
 int omap2_clk_enable(struct clk *clk);
 void omap2_clk_disable(struct clk *clk);
 long omap2_clk_round_rate(struct clk *clk, unsigned long rate);
diff --git a/arch/arm/mach-omap2/clock34xx_data.c b/arch/arm/mach-omap2/clock34xx_data.c
index caa6a41..8be3eda 100644
--- a/arch/arm/mach-omap2/clock34xx_data.c
+++ b/arch/arm/mach-omap2/clock34xx_data.c
@@ -38,6 +38,7 @@
 
 /* Maximum DPLL multiplier, divider values for OMAP3 */
 #define OMAP3_MAX_DPLL_MULT		2048
+#define OMAP3630_MAX_JTYPE_DPLL_MULT	4095
 #define OMAP3_MAX_DPLL_DIV		128
 
 /*
@@ -529,7 +530,8 @@ static struct clk emu_core_alwon_ck = {
 /* DPLL4 */
 /* Supplies 96MHz, 54Mhz TV DAC, DSS fclk, CAM sensor clock, emul trace clk */
 /* Type: DPLL */
-static struct dpll_data dpll4_dd = {
+static struct dpll_data dpll4_dd;
+static struct dpll_data dpll4_dd_34xx __initdata = {
 	.mult_div1_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL2),
 	.mult_mask	= OMAP3430_PERIPH_DPLL_MULT_MASK,
 	.div1_mask	= OMAP3430_PERIPH_DPLL_DIV_MASK,
@@ -552,6 +554,29 @@ static struct dpll_data dpll4_dd = {
 	.rate_tolerance = DEFAULT_DPLL_RATE_TOLERANCE
 };
 
+static struct dpll_data dpll4_dd_3630 __initdata = {
+	.mult_div1_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL2),
+	.mult_mask	= OMAP3630_PERIPH_DPLL_MULT_MASK,
+	.div1_mask	= OMAP3430_PERIPH_DPLL_DIV_MASK,
+	.clk_bypass	= &sys_ck,
+	.clk_ref	= &sys_ck,
+	.control_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
+	.enable_mask	= OMAP3430_EN_PERIPH_DPLL_MASK,
+	.modes		= (1 << DPLL_LOW_POWER_STOP) | (1 << DPLL_LOCKED),
+	.auto_recal_bit	= OMAP3430_EN_PERIPH_DPLL_DRIFTGUARD_SHIFT,
+	.recal_en_bit	= OMAP3430_PERIPH_DPLL_RECAL_EN_SHIFT,
+	.recal_st_bit	= OMAP3430_PERIPH_DPLL_ST_SHIFT,
+	.autoidle_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_AUTOIDLE),
+	.autoidle_mask	= OMAP3430_AUTO_PERIPH_DPLL_MASK,
+	.idlest_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
+	.idlest_mask	= OMAP3430_ST_PERIPH_CLK_MASK,
+	.max_multiplier = OMAP3630_MAX_JTYPE_DPLL_MULT,
+	.min_divider	= 1,
+	.max_divider	= OMAP3_MAX_DPLL_DIV,
+	.rate_tolerance = DEFAULT_DPLL_RATE_TOLERANCE,
+	.flags		= DPLL_J_TYPE
+};
+
 static struct clk dpll4_ck = {
 	.name		= "dpll4_ck",
 	.ops		= &clkops_noncore_dpll_ops,
@@ -3377,6 +3402,11 @@ int __init omap3xxx_clk_init(void)
 				&clkops_omap36xx_pwrdn_with_hsdiv_wait_restore;
 	}
 
+	if (cpu_is_omap3630())
+		dpll4_dd = dpll4_dd_3630;
+	else
+		dpll4_dd = dpll4_dd_34xx;
+
 	clk_init(&omap2_clk_functions);
 
 	for (c = omap3xxx_clks; c < omap3xxx_clks + ARRAY_SIZE(omap3xxx_clks); c++)
diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 35ffe63..3165f53 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -980,6 +980,7 @@ static struct dpll_data dpll_usb_dd = {
 	.max_multiplier	= OMAP4430_MAX_DPLL_MULT,
 	.max_divider	= OMAP4430_MAX_DPLL_DIV,
 	.min_divider	= 1,
+	.flags		= DPLL_J_TYPE | DPLL_NO_DCO_SEL
 };
 
 
diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-regbits-34xx.h
index c04c7c6..29cd13b 100644
--- a/arch/arm/mach-omap2/cm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
@@ -531,8 +531,13 @@
 /* CM_CLKSEL2_PLL */
 #define OMAP3430_PERIPH_DPLL_MULT_SHIFT			8
 #define OMAP3430_PERIPH_DPLL_MULT_MASK			(0x7ff << 8)
+#define OMAP3630_PERIPH_DPLL_MULT_MASK			(0xfff << 8)
 #define OMAP3430_PERIPH_DPLL_DIV_SHIFT			0
 #define OMAP3430_PERIPH_DPLL_DIV_MASK			(0x7f << 0)
+#define OMAP3630_PERIPH_DPLL_DCO_SEL_SHIFT		21
+#define OMAP3630_PERIPH_DPLL_DCO_SEL_MASK		(0x7 << 21)
+#define OMAP3630_PERIPH_DPLL_SD_DIV_SHIFT		24
+#define OMAP3630_PERIPH_DPLL_SD_DIV_MASK		(0xff << 24)
 
 /* CM_CLKSEL3_PLL */
 #define OMAP3430_DIV_96M_SHIFT				0
diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index 84be81c..781f750 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -1,11 +1,14 @@
 /*
  * OMAP3/4 - specific DPLL control functions
  *
- * Copyright (C) 2009 Texas Instruments, Inc.
- * Copyright (C) 2009 Nokia Corporation
+ * Copyright (C) 2009-2010 Texas Instruments, Inc.
+ * Copyright (C) 2009-2010 Nokia Corporation
  *
  * Written by Paul Walmsley
- * Testing and integration fixes by Jouni H??gander
+ * Testing and integration fixes by Jouni H?gander
+ *
+ * 36xx support added by Vishwanath BS, Richard Woodruff, and Nishanth
+ * Menon
  *
  * Parts of this code are based on code written by
  * Richard Woodruff, Tony Lindgren, Tuukka Tikkanen, Karthik Dasu
@@ -225,6 +228,47 @@ static int _omap3_noncore_dpll_stop(struct clk *clk)
 	return 0;
 }
 
+/**
+ * lookup_dco_sddiv -  Set j-type DPLL4 compensation variables
+ * @clk: pointer to a DPLL struct clk
+ * @dco: digital control oscillator selector
+ * @sd_div: target sigma-delta divider
+ * @m: DPLL multiplier to set
+ * @n: DPLL divider to set
+ *
+ * See 36xx TRM section 3.5.3.3.3.2 "Type B DPLL (Low-Jitter)"
+ *
+ * XXX This code is not needed for 3430/AM35xx; can it be optimized
+ * out in non-multi-OMAP builds for those chips?
+ */
+static void lookup_dco_sddiv(struct clk *clk, u8 *dco, u8 *sd_div, u16 m,
+			     u8 n)
+{
+	unsigned long fint, clkinp, sd; /* watch out for overflow */
+	int mod1, mod2;
+
+	clkinp = clk->parent->rate;
+	fint = (clkinp / n) * m;
+
+	if (fint < 1000000000)
+		*dco = 2;
+	else
+		*dco = 4;
+	/*
+	 * target sigma-delta to near 250MHz
+	 * sd = ceil[(m/(n+1)) * (clkinp_MHz / 250)]
+	 */
+	clkinp /= 100000; /* shift from MHz to 10*Hz for 38.4 and 19.2 */
+	mod1 = (clkinp * m) % (250 * n);
+	sd = (clkinp * m) / (250 * n);
+	mod2 = sd % 10;
+	sd /= 10;
+
+	if (mod1 || mod2)
+		sd++;
+	*sd_div = sd;
+}
+
 /*
  * _omap3_noncore_dpll_program - set non-core DPLL M,N values directly
  * @clk: struct clk * of DPLL to set
@@ -259,6 +303,21 @@ static int omap3_noncore_dpll_program(struct clk *clk, u16 m, u8 n, u16 freqsel)
 	v &= ~(dd->mult_mask | dd->div1_mask);
 	v |= m << __ffs(dd->mult_mask);
 	v |= (n - 1) << __ffs(dd->div1_mask);
+
+	/*
+	 * XXX This code is not needed for 3430/AM35XX; can it be optimized
+	 * out in non-multi-OMAP builds for those chips?
+	 */
+	if ((dd->flags & DPLL_J_TYPE) && !(dd->flags & DPLL_NO_DCO_SEL)) {
+		u8 dco, sd_div;
+		lookup_dco_sddiv(clk, &dco, &sd_div, m, n);
+		/* XXX This probably will need revision for OMAP4 */
+		v &= ~(OMAP3630_PERIPH_DPLL_DCO_SEL_MASK
+			| OMAP3630_PERIPH_DPLL_SD_DIV_MASK);
+		v |= dco << __ffs(OMAP3630_PERIPH_DPLL_DCO_SEL_MASK);
+		v |= sd_div << __ffs(OMAP3630_PERIPH_DPLL_SD_DIV_MASK);
+	}
+
 	__raw_writel(v, dd->mult_div1_reg);
 
 	/* We let the clock framework set the other output dividers later */
@@ -536,7 +595,7 @@ unsigned long omap3_clkoutx2_recalc(struct clk *clk)
 
 	v = __raw_readl(dd->control_reg) & dd->enable_mask;
 	v >>= __ffs(dd->enable_mask);
-	if (v != OMAP3XXX_EN_DPLL_LOCKED)
+	if ((v != OMAP3XXX_EN_DPLL_LOCKED) || (dd->flags & DPLL_J_TYPE))
 		rate = clk->parent->rate;
 	else
 		rate = clk->parent->rate * 2;
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index 9042dab..66ebb08 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -42,6 +42,10 @@ struct clksel {
 	const struct clksel_rate *rates;
 };
 
+/*
+ * A new flag called flag has been added which indicates what is the
+ * type of dpll (like j_type, no_dco_sel)
+ */
 struct dpll_data {
 	void __iomem		*mult_div1_reg;
 	u32			mult_mask;
@@ -68,6 +72,7 @@ struct dpll_data {
 	u8			auto_recal_bit;
 	u8			recal_en_bit;
 	u8			recal_st_bit;
+	u8			flags;
 #  endif
 };
 
