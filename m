From: mturquette@ti.com (Mike Turquette)
Date: Thu, 29 Sep 2011 17:51:28 -0700
Subject: [PATCH] OMAP2+: clock: use clock's recalc in DPLL handling
In-Reply-To: <CAJOA=zPq__48SbsKeFHaQ_+J0YQYLLXBP67g2JGXknhWj7PNOA@mail.gmail.com>
References: <CAJOA=zPq__48SbsKeFHaQ_+J0YQYLLXBP67g2JGXknhWj7PNOA@mail.gmail.com>
Message-ID: <1317343888-30892-1-git-send-email-mturquette@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Not all DPLLs are identical; some require special consideration such as
OMAP4's ABE DPLL, which can have an additional 4x multiplier added to
it's clock rate based on programming the REGM4XEN bit in it's CLKMODE
register.

Unfortunately the clock framework makes a few assumptions that all DPLLs
can have their rates calculated the same way which has led to incorrect
rates for OMAP4's DPLL_ABE in some cases.  This patch fixes the same by
replacing explicit calls to omap2_dpll_get_rate with clk->recalc if
.recalc is populated for a clock.  If .recalc is NULL then fall back to
omap2_dpll_get_rate.

Reported-by: Misael Lopez Cruz <misael.lopez@ti.com>
Signed-off-by: Mike Turquette <mturquette@ti.com>
---
 arch/arm/mach-omap2/dpll3xxx.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index f77022b..193868d 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -390,7 +390,8 @@ int omap3_noncore_dpll_enable(struct clk *clk)
 	 * propagating?
 	 */
 	if (!r)
-		clk->rate = omap2_get_dpll_rate(clk);
+		clk->rate = (clk->recalc) ? clk->recalc(clk) :
+			omap2_get_dpll_rate(clk);
 
 	return r;
 }
@@ -435,7 +436,8 @@ int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
 	if (!dd)
 		return -EINVAL;
 
-	if (rate == omap2_get_dpll_rate(clk))
+	if (rate == ((clk->recalc) ? clk->recalc(clk) :
+				omap2_get_dpll_rate(clk)))
 		return 0;
 
 	/*
-- 
1.7.4.1
