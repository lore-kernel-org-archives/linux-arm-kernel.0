From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 17 May 2017 16:05:40 +0200
Subject: [PATCH 6/8] clocksource/drivers/fttmr010: Switch to use TIMER2 src
In-Reply-To: <20170517140542.20016-1-linus.walleij@linaro.org>
References: <20170517140542.20016-1-linus.walleij@linaro.org>
Message-ID: <20170517140542.20016-7-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This switches the clocksource to TIMER2 like the Moxart driver
does. Mainly to make it more similar to the Moxart/Aspeed driver
but also because it seems more neat to use the timers in order:
use timer 1, then timer 2.

Cc: Joel Stanley <joel@jms.id.au>
Cc: Jonas Jensen <jonas.jensen@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/clocksource/timer-fttmr010.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/clocksource/timer-fttmr010.c b/drivers/clocksource/timer-fttmr010.c
index 9df14cf13808..2d915d1455ab 100644
--- a/drivers/clocksource/timer-fttmr010.c
+++ b/drivers/clocksource/timer-fttmr010.c
@@ -49,9 +49,6 @@
 #define TIMER_1_CR_UPDOWN	BIT(9)
 #define TIMER_2_CR_UPDOWN	BIT(10)
 #define TIMER_3_CR_UPDOWN	BIT(11)
-#define TIMER_DEFAULT_FLAGS	(TIMER_1_CR_UPDOWN | \
-				 TIMER_3_CR_ENABLE | \
-				 TIMER_3_CR_UPDOWN)
 
 #define TIMER_1_INT_MATCH1	BIT(0)
 #define TIMER_1_INT_MATCH2	BIT(1)
@@ -80,7 +77,7 @@ static inline struct fttmr010 *to_fttmr010(struct clock_event_device *evt)
 
 static u64 notrace fttmr010_read_sched_clock(void)
 {
-	return readl(local_fttmr->base + TIMER3_COUNT);
+	return readl(local_fttmr->base + TIMER2_COUNT);
 }
 
 static int fttmr010_timer_set_next_event(unsigned long cycles,
@@ -230,19 +227,21 @@ static int __init fttmr010_timer_init(struct device_node *np)
 	 */
 	writel(TIMER_INT_ALL_MASK, fttmr010->base + TIMER_INTR_MASK);
 	writel(0, fttmr010->base + TIMER_INTR_STATE);
-	writel(TIMER_DEFAULT_FLAGS, fttmr010->base + TIMER_CR);
+	/* Enable timer 1 count up, timer 2 count up */
+	writel((TIMER_1_CR_UPDOWN | TIMER_2_CR_ENABLE | TIMER_2_CR_UPDOWN),
+	       fttmr010->base + TIMER_CR);
 
 	/*
 	 * Setup free-running clocksource timer (interrupts
 	 * disabled.)
 	 */
 	local_fttmr = fttmr010;
-	writel(0, fttmr010->base + TIMER3_COUNT);
-	writel(0, fttmr010->base + TIMER3_LOAD);
-	writel(0, fttmr010->base + TIMER3_MATCH1);
-	writel(0, fttmr010->base + TIMER3_MATCH2);
-	clocksource_mmio_init(fttmr010->base + TIMER3_COUNT,
-			      "FTTMR010-TIMER3",
+	writel(0, fttmr010->base + TIMER2_COUNT);
+	writel(0, fttmr010->base + TIMER2_LOAD);
+	writel(0, fttmr010->base + TIMER2_MATCH1);
+	writel(0, fttmr010->base + TIMER2_MATCH2);
+	clocksource_mmio_init(fttmr010->base + TIMER2_COUNT,
+			      "FTTMR010-TIMER2",
 			      fttmr010->tick_rate,
 			      300, 32, clocksource_mmio_readl_up);
 	sched_clock_register(fttmr010_read_sched_clock, 32,
-- 
2.9.3
