From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 25 Nov 2015 23:42:49 +0800
Subject: [PATCH] clocksource/drivers/pistachio: Fix wrong calculated
 clocksource read value
Message-ID: <1448466169-5230-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let's assume the counter value is 0xf000000, the pistachio clocksource
read cycles function would return 0xffffffff0fffffff, but it should
return 0xfffffff.

We fix this issue by calculating bitwise-not counter, then cast to
cycle_t.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/clocksource/time-pistachio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/time-pistachio.c b/drivers/clocksource/time-pistachio.c
index bba6799..3269d9e 100644
--- a/drivers/clocksource/time-pistachio.c
+++ b/drivers/clocksource/time-pistachio.c
@@ -84,7 +84,7 @@ pistachio_clocksource_read_cycles(struct clocksource *cs)
 	counter = gpt_readl(pcs->base, TIMER_CURRENT_VALUE, 0);
 	raw_spin_unlock_irqrestore(&pcs->lock, flags);
 
-	return ~(cycle_t)counter;
+	return (cycle_t)~counter;
 }
 
 static u64 notrace pistachio_read_sched_clock(void)
-- 
2.6.2
