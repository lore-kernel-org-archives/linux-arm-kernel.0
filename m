From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 15 Nov 2018 14:32:02 +0100
Subject: [PATCH 1/2] clocksource: Demote dbx500 PRCMU clocksource
Message-ID: <20181115133203.28567-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Demote the DBx500 PRCMU clocksource to quality 100 and
mark it as NONSTOP so it will still be used for
timekeeping across suspend/resume.

The Nomadik MTU timer which has higher precision will
be used when the system is up and running, thanks to
the recent changes properly utilizing the suspend
clocksources.

This was discussed back in 2011 when the driver was
written, but the infrastructure was not available
upstream to use this timer properly. Now the
infrastructure is there, so let's finalize the work.

Cc: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/clocksource/clksrc-dbx500-prcmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/clksrc-dbx500-prcmu.c b/drivers/clocksource/clksrc-dbx500-prcmu.c
index c1b96dc5f444..4054539fe066 100644
--- a/drivers/clocksource/clksrc-dbx500-prcmu.c
+++ b/drivers/clocksource/clksrc-dbx500-prcmu.c
@@ -46,10 +46,10 @@ static u64 notrace clksrc_dbx500_prcmu_read(struct clocksource *cs)
 
 static struct clocksource clocksource_dbx500_prcmu = {
 	.name		= "dbx500-prcmu-timer",
-	.rating		= 300,
+	.rating		= 100,
 	.read		= clksrc_dbx500_prcmu_read,
 	.mask		= CLOCKSOURCE_MASK(32),
-	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_SUSPEND_NONSTOP,
 };
 
 #ifdef CONFIG_CLKSRC_DBX500_PRCMU_SCHED_CLOCK
-- 
2.17.2
