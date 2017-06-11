From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 11 Jun 2017 23:26:16 +0200
Subject: [PATCH 1/2] drivers/clocksource/fttmr010: Optimize sched_clock()
Message-ID: <20170611212617.6906-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sched_clock() call should be really fast so we want to
avoid an extra if() clause on the read path if possible.

Implement two sched_clock_read() functions, one if the timer
counts up and one if it counts down. Incidentally this also
mirrors how clocksource_mmio_init() works and make things
simple and easy to understand.

Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Andrew Jeffery <andrew@aj.id.au>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Jonas Jensen <jonas.jensen@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/clocksource/timer-fttmr010.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/timer-fttmr010.c b/drivers/clocksource/timer-fttmr010.c
index f8801507a687..5e82469995cb 100644
--- a/drivers/clocksource/timer-fttmr010.c
+++ b/drivers/clocksource/timer-fttmr010.c
@@ -91,13 +91,16 @@ static inline struct fttmr010 *to_fttmr010(struct clock_event_device *evt)
 	return container_of(evt, struct fttmr010, clkevt);
 }
 
-static u64 notrace fttmr010_read_sched_clock(void)
+static u64 notrace fttmr010_read_sched_clock_up(void)
 {
-	if (local_fttmr->count_down)
-		return ~readl(local_fttmr->base + TIMER2_COUNT);
 	return readl(local_fttmr->base + TIMER2_COUNT);
 }
 
+static u64 notrace fttmr010_read_sched_clock_down(void)
+{
+	return ~readl(local_fttmr->base + TIMER2_COUNT);
+}
+
 static int fttmr010_timer_set_next_event(unsigned long cycles,
 				       struct clock_event_device *evt)
 {
@@ -304,15 +307,17 @@ static int __init fttmr010_timer_init(struct device_node *np)
 				      "FTTMR010-TIMER2",
 				      fttmr010->tick_rate,
 				      300, 32, clocksource_mmio_readl_down);
+		sched_clock_register(fttmr010_read_sched_clock_down, 32,
+				     fttmr010->tick_rate);
 	} else {
 		writel(0, fttmr010->base + TIMER2_LOAD);
 		clocksource_mmio_init(fttmr010->base + TIMER2_COUNT,
 				      "FTTMR010-TIMER2",
 				      fttmr010->tick_rate,
 				      300, 32, clocksource_mmio_readl_up);
+		sched_clock_register(fttmr010_read_sched_clock_up, 32,
+				     fttmr010->tick_rate);
 	}
-	sched_clock_register(fttmr010_read_sched_clock, 32,
-			     fttmr010->tick_rate);
 
 	/*
 	 * Setup clockevent timer (interrupt-driven) on timer 1.
-- 
2.9.4
