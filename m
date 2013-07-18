From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 18 Jul 2013 16:21:21 -0700
Subject: [PATCH v4 08/17] ocksource: dbx500-prcmu: Switch to
 sched_clock_register()
In-Reply-To: <1374189690-10810-1-git-send-email-sboyd@codeaurora.org>
References: <1374189690-10810-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1374189690-10810-9-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 32 bit sched_clock interface now supports 64 bits. Upgrade to
the 64 bit function to allow us to remove the 32 bit registration
interface.

Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clocksource/clksrc-dbx500-prcmu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/clksrc-dbx500-prcmu.c b/drivers/clocksource/clksrc-dbx500-prcmu.c
index a9fd4ad..b375106 100644
--- a/drivers/clocksource/clksrc-dbx500-prcmu.c
+++ b/drivers/clocksource/clksrc-dbx500-prcmu.c
@@ -53,7 +53,7 @@ static struct clocksource clocksource_dbx500_prcmu = {
 
 #ifdef CONFIG_CLKSRC_DBX500_PRCMU_SCHED_CLOCK
 
-static u32 notrace dbx500_prcmu_sched_clock_read(void)
+static u64 notrace dbx500_prcmu_sched_clock_read(void)
 {
 	if (unlikely(!clksrc_dbx500_timer_base))
 		return 0;
@@ -81,8 +81,7 @@ void __init clksrc_dbx500_prcmu_init(void __iomem *base)
 		       clksrc_dbx500_timer_base + PRCMU_TIMER_REF);
 	}
 #ifdef CONFIG_CLKSRC_DBX500_PRCMU_SCHED_CLOCK
-	setup_sched_clock(dbx500_prcmu_sched_clock_read,
-			 32, RATE_32K);
+	sched_clock_register(dbx500_prcmu_sched_clock_read, 32, RATE_32K);
 #endif
 	clocksource_register_hz(&clocksource_dbx500_prcmu, RATE_32K);
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
