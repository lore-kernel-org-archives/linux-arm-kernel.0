From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 15 Jun 2015 15:50:21 +0200
Subject: [PATCH 4/5] ARM: ep93xx: switch clockevent to timer 3
In-Reply-To: <1434376222-4587-1-git-send-email-linus.walleij@linaro.org>
References: <1434376222-4587-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1434376222-4587-5-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we switch clock events to timer 3 we will have more bits to
use and can sleep longer when using NO_HZ.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ep93xx/timer-ep93xx.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-ep93xx/timer-ep93xx.c b/arch/arm/mach-ep93xx/timer-ep93xx.c
index 95d54ec769f6..9edaa754b689 100644
--- a/arch/arm/mach-ep93xx/timer-ep93xx.c
+++ b/arch/arm/mach-ep93xx/timer-ep93xx.c
@@ -77,12 +77,12 @@ static int ep93xx_clkevt_set_next_event(unsigned long next,
 		    EP93XX_TIMER123_CONTROL_CLKSEL;
 
 	/* Clear timer */
-	writel(tmode, EP93XX_TIMER1_CONTROL);
+	writel(tmode, EP93XX_TIMER3_CONTROL);
 
 	/* Set next event */
-	writel(next, EP93XX_TIMER1_LOAD);
+	writel(next, EP93XX_TIMER3_LOAD);
 	writel(tmode | EP93XX_TIMER123_CONTROL_ENABLE,
-	       EP93XX_TIMER1_CONTROL);
+	       EP93XX_TIMER3_CONTROL);
         return 0;
 }
 
@@ -91,7 +91,7 @@ static void ep93xx_clkevt_set_mode(enum clock_event_mode mode,
 				   struct clock_event_device *evt)
 {
 	/* Disable timer */
-	writel(0, EP93XX_TIMER1_CONTROL);
+	writel(0, EP93XX_TIMER3_CONTROL);
 }
 
 static struct clock_event_device ep93xx_clockevent = {
@@ -107,7 +107,7 @@ static irqreturn_t ep93xx_timer_interrupt(int irq, void *dev_id)
 	struct clock_event_device *evt = dev_id;
 
 	/* Writing any value clears the timer interrupt */
-	writel(1, EP93XX_TIMER1_CLEAR);
+	writel(1, EP93XX_TIMER3_CLEAR);
 
 	evt->event_handler(evt);
 
@@ -132,11 +132,10 @@ void __init ep93xx_timer_init(void)
 	sched_clock_register(ep93xx_read_sched_clock, 40,
 			     EP93XX_TIMER4_RATE);
 
-	/* Set up clockevent on timer 1 */
-	setup_irq(IRQ_EP93XX_TIMER1, &ep93xx_timer_irq);
-	// FIXME: timer one is 16 bits 1-ffff use timer 3 1-ffffffff */
+	/* Set up clockevent on timer 3 */
+	setup_irq(IRQ_EP93XX_TIMER3, &ep93xx_timer_irq);
 	clockevents_config_and_register(&ep93xx_clockevent,
 					EP93XX_TIMER123_RATE,
 					1,
-					0xffffU);
+					0xffffffffU);
 }
-- 
1.9.3
