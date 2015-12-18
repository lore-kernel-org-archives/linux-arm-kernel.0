From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Dec 2015 15:18:15 +0100
Subject: [PATCH 62/69] clocksource/drivers/pistachio: Fix wrong calculated
 clocksource read value
In-Reply-To: <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
References: <5672CB9E.7090707@linaro.org>
 <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1450448302-27429-62-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jisheng Zhang <jszhang@marvell.com>

Let's assume the counter value is 0xf0000000, the pistachio clocksource
read cycles function should return ~0x0fffffff but actually it returns
0xffffffff0fffffff.

That occurs because:

	~(cycle_t)value is different from (cycle_t)~value.

unsigned long val = ~(unsigned long)0xf0000000;
40049a:       48 b8 ff ff ff 0f ff    movabs $0xffffffff0fffffff,%rax

unsigned long val = (unsigned long)~0xf0000000;
40049a:       48 c7 45 f8 ff ff ff    movq   $0xfffffff,-0x8(%rbp)

We fix this issue by calculating bitwise-not counter, then cast to
cycle_t.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
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
1.9.1
