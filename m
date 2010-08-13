From: tony@atomide.com (Tony Lindgren)
Date: Fri, 13 Aug 2010 11:01:56 +0300
Subject: [PATCH 2/6] OMAP3: Fix a cpu type check problem
In-Reply-To: <20100813080034.18750.15410.stgit@baageli.muru.com>
References: <20100813080034.18750.15410.stgit@baageli.muru.com>
Message-ID: <20100813080156.18750.74200.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: stanley.miao <stanley.miao@windriver.com>

cpu_is_omap3517() and cpu_is_omap3505() are the subgroups of cpu_is_omap34xx(),
so we should check cpu_is_omap3517() and cpu_is_omap3505() first, then check
cpu_is_omap34xx().

Otherwise, All AM35XX (Sitara) clocks do not get registered and device drivers
(ti_hecc, etc...) that depend on those clocks are failing to get the clock and
end up with non working device.

Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
Tested-by: Igor Grinberg <grinberg@compulab.co.il>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 138646d..dfdce2d 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3417,7 +3417,13 @@ int __init omap3xxx_clk_init(void)
 	struct omap_clk *c;
 	u32 cpu_clkflg = CK_3XXX;
 
-	if (cpu_is_omap34xx()) {
+	if (cpu_is_omap3517()) {
+		cpu_mask = RATE_IN_3XXX | RATE_IN_3430ES2PLUS;
+		cpu_clkflg |= CK_3517;
+	} else if (cpu_is_omap3505()) {
+		cpu_mask = RATE_IN_3XXX | RATE_IN_3430ES2PLUS;
+		cpu_clkflg |= CK_3505;
+	} else if (cpu_is_omap34xx()) {
 		cpu_mask = RATE_IN_3XXX;
 		cpu_clkflg |= CK_343X;
 
@@ -3432,12 +3438,6 @@ int __init omap3xxx_clk_init(void)
 			cpu_mask |= RATE_IN_3430ES2PLUS;
 			cpu_clkflg |= CK_3430ES2;
 		}
-	} else if (cpu_is_omap3517()) {
-		cpu_mask = RATE_IN_3XXX | RATE_IN_3430ES2PLUS;
-		cpu_clkflg |= CK_3517;
-	} else if (cpu_is_omap3505()) {
-		cpu_mask = RATE_IN_3XXX | RATE_IN_3430ES2PLUS;
-		cpu_clkflg |= CK_3505;
 	}
 
 	if (omap3_has_192mhz_clk())
