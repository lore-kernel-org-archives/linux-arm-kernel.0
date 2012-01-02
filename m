From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 2 Jan 2012 14:23:03 +0100
Subject: [PATCH] clocksource/ux500-prcmu: fix sched_clock breakage
Message-ID: <1325510583-4487-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 2f0778afac79bd8d226225556858a636931eeabc adding
runtime-selectable sched_clock() forgot to patch this
driver down in drivers/clocksource, this patch fixes
the problem.

Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/clocksource/clksrc-dbx500-prcmu.c |   16 +++-------------
 1 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/clocksource/clksrc-dbx500-prcmu.c b/drivers/clocksource/clksrc-dbx500-prcmu.c
index 59feefe..fb6b6d2 100644
--- a/drivers/clocksource/clksrc-dbx500-prcmu.c
+++ b/drivers/clocksource/clksrc-dbx500-prcmu.c
@@ -58,25 +58,15 @@ static struct clocksource clocksource_dbx500_prcmu = {
 };
 
 #ifdef CONFIG_CLKSRC_DBX500_PRCMU_SCHED_CLOCK
-static DEFINE_CLOCK_DATA(cd);
 
-unsigned long long notrace sched_clock(void)
+static u32 notrace dbx500_prcmu_sched_clock_read(void)
 {
-	u32 cyc;
-
 	if (unlikely(!clksrc_dbx500_timer_base))
 		return 0;
 
-	cyc = clksrc_dbx500_prcmu_read(&clocksource_dbx500_prcmu);
-
-	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
+	return clksrc_dbx500_prcmu_read(&clocksource_dbx500_prcmu);
 }
 
-static void notrace clksrc_dbx500_prcmu_update_sched_clock(void)
-{
-	u32 cyc = clksrc_dbx500_prcmu_read(&clocksource_dbx500_prcmu);
-	update_sched_clock(&cd, cyc, (u32)~0);
-}
 #endif
 
 void __init clksrc_dbx500_prcmu_init(void __iomem *base)
@@ -97,7 +87,7 @@ void __init clksrc_dbx500_prcmu_init(void __iomem *base)
 		       clksrc_dbx500_timer_base + PRCMU_TIMER_REF);
 	}
 #ifdef CONFIG_CLKSRC_DBX500_PRCMU_SCHED_CLOCK
-	init_sched_clock(&cd, clksrc_dbx500_prcmu_update_sched_clock,
+	setup_sched_clock(dbx500_prcmu_sched_clock_read,
 			 32, RATE_32K);
 #endif
 	clocksource_calc_mult_shift(&clocksource_dbx500_prcmu,
-- 
1.7.8
