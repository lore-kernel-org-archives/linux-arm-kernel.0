From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 16 Oct 2009 12:09:15 -0700
Subject: [PATCH 11/46] davinci: make clock rate re-calculation easy
In-Reply-To: <1255720190-7452-12-git-send-email-khilman@deeprootsystems.com>
References: <1255720190-7452-1-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-2-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-3-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-4-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-5-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-6-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-7-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-8-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-9-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-10-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-11-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-12-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1255720190-7452-13-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

Make clock rate recalculation easy by having a re-calculate
function for each clock.

The existing functions for calculation of output rates of PLL
and PLL-derived sysclks have been convered to the new
re-calculate API.

A new function is introduced to take care of rate
(re)calculation for leaf clocks.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/clock.c |   69 +++++++++++++++++++++++++++++------------
 arch/arm/mach-davinci/clock.h |    1 +
 2 files changed, 50 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-davinci/clock.c b/arch/arm/mach-davinci/clock.c
index f8c4ef0..6de1e34 100644
--- a/arch/arm/mach-davinci/clock.c
+++ b/arch/arm/mach-davinci/clock.c
@@ -135,8 +135,12 @@ int clk_register(struct clk *clk)
 	if (clk->rate)
 		return 0;
 
+	/* Else, see if there is a way to calculate it */
+	if (clk->recalc)
+		clk->rate = clk->recalc(clk);
+
 	/* Otherwise, default to parent rate */
-	if (clk->parent)
+	else if (clk->parent)
 		clk->rate = clk->parent->rate;
 
 	return 0;
@@ -184,50 +188,62 @@ static int __init clk_disable_unused(void)
 late_initcall(clk_disable_unused);
 #endif
 
-static void clk_sysclk_recalc(struct clk *clk)
+static unsigned long clk_sysclk_recalc(struct clk *clk)
 {
 	u32 v, plldiv;
 	struct pll_data *pll;
+	unsigned long rate = clk->rate;
 
 	/* If this is the PLL base clock, no more calculations needed */
 	if (clk->pll_data)
-		return;
+		return rate;
 
 	if (WARN_ON(!clk->parent))
-		return;
+		return rate;
 
-	clk->rate = clk->parent->rate;
+	rate = clk->parent->rate;
 
 	/* Otherwise, the parent must be a PLL */
 	if (WARN_ON(!clk->parent->pll_data))
-		return;
+		return rate;
 
 	pll = clk->parent->pll_data;
 
 	/* If pre-PLL, source clock is before the multiplier and divider(s) */
 	if (clk->flags & PRE_PLL)
-		clk->rate = pll->input_rate;
+		rate = pll->input_rate;
 
 	if (!clk->div_reg)
-		return;
+		return rate;
 
 	v = __raw_readl(pll->base + clk->div_reg);
 	if (v & PLLDIV_EN) {
 		plldiv = (v & PLLDIV_RATIO_MASK) + 1;
 		if (plldiv)
-			clk->rate /= plldiv;
+			rate /= plldiv;
 	}
+
+	return rate;
+}
+
+static unsigned long clk_leafclk_recalc(struct clk *clk)
+{
+	if (WARN_ON(!clk->parent))
+		return clk->rate;
+
+	return clk->parent->rate;
 }
 
-static void __init clk_pll_init(struct clk *clk)
+static unsigned long clk_pllclk_recalc(struct clk *clk)
 {
 	u32 ctrl, mult = 1, prediv = 1, postdiv = 1;
 	u8 bypass;
 	struct pll_data *pll = clk->pll_data;
+	unsigned long rate = clk->rate;
 
 	pll->base = IO_ADDRESS(pll->phys_base);
 	ctrl = __raw_readl(pll->base + PLLCTL);
-	clk->rate = pll->input_rate = clk->parent->rate;
+	rate = pll->input_rate = clk->parent->rate;
 
 	if (ctrl & PLLCTL_PLLEN) {
 		bypass = 0;
@@ -260,9 +276,9 @@ static void __init clk_pll_init(struct clk *clk)
 	}
 
 	if (!bypass) {
-		clk->rate /= prediv;
-		clk->rate *= mult;
-		clk->rate /= postdiv;
+		rate /= prediv;
+		rate *= mult;
+		rate /= postdiv;
 	}
 
 	pr_debug("PLL%d: input = %lu MHz [ ",
@@ -275,7 +291,9 @@ static void __init clk_pll_init(struct clk *clk)
 		pr_debug("* %d ", mult);
 	if (postdiv > 1)
 		pr_debug("/ %d ", postdiv);
-	pr_debug("] --> %lu MHz output.\n", clk->rate / 1000000);
+	pr_debug("] --> %lu MHz output.\n", rate / 1000000);
+
+	return rate;
 }
 
 int __init davinci_clk_init(struct davinci_clk *clocks)
@@ -286,12 +304,23 @@ int __init davinci_clk_init(struct davinci_clk *clocks)
 	for (c = clocks; c->lk.clk; c++) {
 		clk = c->lk.clk;
 
-		if (clk->pll_data)
-			clk_pll_init(clk);
+		if (!clk->recalc) {
+
+			/* Check if clock is a PLL */
+			if (clk->pll_data)
+				clk->recalc = clk_pllclk_recalc;
+
+			/* Else, if it is a PLL-derived clock */
+			else if (clk->flags & CLK_PLL)
+				clk->recalc = clk_sysclk_recalc;
+
+			/* Otherwise, it is a leaf clock (PSC clock) */
+			else if (clk->parent)
+				clk->recalc = clk_leafclk_recalc;
+		}
 
-		/* Calculate rates for PLL-derived clocks */
-		else if (clk->flags & CLK_PLL)
-			clk_sysclk_recalc(clk);
+		if (clk->recalc)
+			clk->rate = clk->recalc(clk);
 
 		if (clk->lpsc)
 			clk->flags |= CLK_PSC;
diff --git a/arch/arm/mach-davinci/clock.h b/arch/arm/mach-davinci/clock.h
index f88794d..202b9ff 100644
--- a/arch/arm/mach-davinci/clock.h
+++ b/arch/arm/mach-davinci/clock.h
@@ -73,6 +73,7 @@ struct clk {
 	struct list_head	childnode;	/* parent's child list node */
 	struct pll_data         *pll_data;
 	u32                     div_reg;
+	unsigned long (*recalc) (struct clk *);
 };
 
 /* Clock flags */
-- 
1.6.4.3
