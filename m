From: b-cousson@ti.com (Benoit Cousson)
Date: Thu, 9 Dec 2010 23:13:39 +0100
Subject: [PATCH v2 7/8] OMAP4: clock data: Export control to enable/disable
	CORE/PER M3 clocks
In-Reply-To: <1291932820-11163-1-git-send-email-b-cousson@ti.com>
References: <1291932820-11163-1-git-send-email-b-cousson@ti.com>
Message-ID: <1291932820-11163-8-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajendra Nayak <rnayak@ti.com>

The CORE and PER M3 post dividers are different from the rest of the
DPLL post dividers as in they go to SCRM, and are used
there to export clocks for instance used by external sensor.

There is no automatic HW dependency in PRCM to manage them. Hence these
two clocks (dpll post dividers) should be managed by SW and explicitly
enabled/disabled.

Add control in clock framework to handle that.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index fd7efe8..51f28a0 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -610,7 +610,9 @@ static struct clk dpll_core_m3x2_ck = {
 	.clksel		= dpll_core_m6x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M3_DPLL_CORE,
 	.clksel_mask	= OMAP4430_DPLL_CLKOUTHIF_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap2_dflt,
+	.enable_reg	= OMAP4430_CM_DIV_M3_DPLL_CORE,
+	.enable_bit	= OMAP4430_DPLL_CLKOUTHIF_GATE_CTRL_SHIFT,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -869,7 +871,9 @@ static struct clk dpll_per_m3x2_ck = {
 	.clksel		= dpll_per_m2x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M3_DPLL_PER,
 	.clksel_mask	= OMAP4430_DPLL_CLKOUTHIF_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap2_dflt,
+	.enable_reg	= OMAP4430_CM_DIV_M3_DPLL_PER,
+	.enable_bit	= OMAP4430_DPLL_CLKOUTHIF_GATE_CTRL_SHIFT,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
-- 
1.7.0.4
