From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 13 Jun 2017 23:48:13 +0200
Subject: [PATCH] drivers/clocksource/fttmr010: Factor clock read code
Message-ID: <20170613214813.11406-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sched_clock() and delay timer callbacks can just call
each other and we can save an #ifdef.

Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Andrew Jeffery <andrew@aj.id.au>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Jonas Jensen <jonas.jensen@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Daniel: feel free to apply as-is or squash into the other
patch as you like.
---
 drivers/clocksource/timer-fttmr010.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/clocksource/timer-fttmr010.c b/drivers/clocksource/timer-fttmr010.c
index 0074d89cd2ce..bb07787229b6 100644
--- a/drivers/clocksource/timer-fttmr010.c
+++ b/drivers/clocksource/timer-fttmr010.c
@@ -98,30 +98,26 @@ static inline struct fttmr010 *to_fttmr010(struct clock_event_device *evt)
 	return container_of(evt, struct fttmr010, clkevt);
 }
 
-static u64 notrace fttmr010_read_sched_clock_up(void)
+static unsigned long fttmr010_read_current_timer_up(void)
 {
 	return readl(local_fttmr->base + TIMER2_COUNT);
 }
 
-static u64 notrace fttmr010_read_sched_clock_down(void)
+static unsigned long fttmr010_read_current_timer_down(void)
 {
 	return ~readl(local_fttmr->base + TIMER2_COUNT);
 }
 
-#ifdef CONFIG_ARM
-
-static unsigned long fttmr010_read_current_timer_up(void)
+static u64 notrace fttmr010_read_sched_clock_up(void)
 {
-	return readl(local_fttmr->base + TIMER2_COUNT);
+	return fttmr010_read_current_timer_up();
 }
 
-static unsigned long fttmr010_read_current_timer_down(void)
+static u64 notrace fttmr010_read_sched_clock_down(void)
 {
-	return ~readl(local_fttmr->base + TIMER2_COUNT);
+	return fttmr010_read_current_timer_down();
 }
 
-#endif
-
 static int fttmr010_timer_set_next_event(unsigned long cycles,
 				       struct clock_event_device *evt)
 {
-- 
2.9.4
