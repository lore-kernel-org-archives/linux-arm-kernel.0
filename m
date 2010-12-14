From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 13 Dec 2010 23:34:50 -0700
Subject: [PATCH 07/12] OMAP4: clock data: Export control to enable/disable
	CORE/PER M3 clocks
In-Reply-To: <20101214063308.21555.76050.stgit@twilight.localdomain>
References: <20101214063308.21555.76050.stgit@twilight.localdomain>
Message-ID: <20101214063449.21555.29647.stgit@twilight.localdomain>
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
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 80a1898..4c77613 100644
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
