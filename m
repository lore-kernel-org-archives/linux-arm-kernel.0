From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 6 Mar 2015 14:28:40 +0200
Subject: [PATCH 05/24] ARM: OMAP3: dpll3-m2: get rid of obsolete
 omap2_clksel_round_rate_div call
In-Reply-To: <1425644939-3232-1-git-send-email-t-kristo@ti.com>
References: <1425644939-3232-1-git-send-email-t-kristo@ti.com>
Message-ID: <1425644939-3232-6-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Core DVFS support code is currently referencing clksel functionality, which
is wrong. The m2 divisor has been implemented as a divider clock for a long
time already, so replace the validrate check call with proper functionality.
Core DVFS is currently not supported in the kernel so verifying this patch
can be rather tricky, this should probably be fixed at some point.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clkt34xx_dpll3m2.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c b/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
index eb69acf..825e3da 100644
--- a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
+++ b/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
@@ -60,7 +60,9 @@ int omap3_core_dpll_m2_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (!clk || !rate)
 		return -EINVAL;
 
-	validrate = omap2_clksel_round_rate_div(clk, rate, &new_div);
+	new_div = DIV_ROUND_UP(parent_rate, rate);
+	validrate = parent_rate / new_div;
+
 	if (validrate != rate)
 		return -EINVAL;
 
-- 
1.7.9.5
