From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu,  6 May 2010 16:24:11 -0700
Subject: [PATCH 20/34] Davinci: configurable pll divider mask
In-Reply-To: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
References: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1273188265-12782-21-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cyril Chemparathy <cyril@ti.com>

This patch allows socs to override the divider ratio mask by setting an
optional field (div_ratio_mask) in the pll_data structure.

Signed-off-by: Cyril Chemparathy <cyril@ti.com>
Tested-by: Sandeep Paulraj <s-paulraj@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/clock.c |    9 ++++++---
 arch/arm/mach-davinci/clock.h |    1 +
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-davinci/clock.c b/arch/arm/mach-davinci/clock.c
index 5de60ae..868cb76 100644
--- a/arch/arm/mach-davinci/clock.c
+++ b/arch/arm/mach-davinci/clock.c
@@ -279,7 +279,7 @@ static unsigned long clk_sysclk_recalc(struct clk *clk)
 
 	v = __raw_readl(pll->base + clk->div_reg);
 	if (v & PLLDIV_EN) {
-		plldiv = (v & PLLDIV_RATIO_MASK) + 1;
+		plldiv = (v & pll->div_ratio_mask) + 1;
 		if (plldiv)
 			rate /= plldiv;
 	}
@@ -319,7 +319,7 @@ static unsigned long clk_pllclk_recalc(struct clk *clk)
 	if (pll->flags & PLL_HAS_PREDIV) {
 		prediv = __raw_readl(pll->base + PREDIV);
 		if (prediv & PLLDIV_EN)
-			prediv = (prediv & PLLDIV_RATIO_MASK) + 1;
+			prediv = (prediv & pll->div_ratio_mask) + 1;
 		else
 			prediv = 1;
 	}
@@ -331,7 +331,7 @@ static unsigned long clk_pllclk_recalc(struct clk *clk)
 	if (pll->flags & PLL_HAS_POSTDIV) {
 		postdiv = __raw_readl(pll->base + POSTDIV);
 		if (postdiv & PLLDIV_EN)
-			postdiv = (postdiv & PLLDIV_RATIO_MASK) + 1;
+			postdiv = (postdiv & pll->div_ratio_mask) + 1;
 		else
 			postdiv = 1;
 	}
@@ -458,6 +458,9 @@ int __init davinci_clk_init(struct clk_lookup *clocks)
 				clk->recalc = clk_leafclk_recalc;
 		}
 
+		if (clk->pll_data && !clk->pll_data->div_ratio_mask)
+			clk->pll_data->div_ratio_mask = PLLDIV_RATIO_MASK;
+
 		if (clk->recalc)
 			clk->rate = clk->recalc(clk);
 
diff --git a/arch/arm/mach-davinci/clock.h b/arch/arm/mach-davinci/clock.h
index 53a0f7b..ce26015 100644
--- a/arch/arm/mach-davinci/clock.h
+++ b/arch/arm/mach-davinci/clock.h
@@ -76,6 +76,7 @@ struct pll_data {
 	u32 num;
 	u32 flags;
 	u32 input_rate;
+	u32 div_ratio_mask;
 };
 #define PLL_HAS_PREDIV          0x01
 #define PLL_HAS_POSTDIV         0x02
-- 
1.7.0.2
