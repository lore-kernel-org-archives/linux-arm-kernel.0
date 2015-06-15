From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 15 Jun 2015 15:50:20 +0200
Subject: [PATCH 3/5] ARM: ep93xx: use non-raw accessors for timer
In-Reply-To: <1434376222-4587-1-git-send-email-linus.walleij@linaro.org>
References: <1434376222-4587-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1434376222-4587-4-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The timer has no business using __raw accessors, in this case
the readl/writel makes perfect sense as the changes really need
to hit these registers before we continue.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ep93xx/timer-ep93xx.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-ep93xx/timer-ep93xx.c b/arch/arm/mach-ep93xx/timer-ep93xx.c
index 932236b348bc..95d54ec769f6 100644
--- a/arch/arm/mach-ep93xx/timer-ep93xx.c
+++ b/arch/arm/mach-ep93xx/timer-ep93xx.c
@@ -55,8 +55,8 @@ static u64 notrace ep93xx_read_sched_clock(void)
 {
 	u64 ret;
 
-	ret = __raw_readl(EP93XX_TIMER4_VALUE_LOW);
-	ret |= ((u64) (__raw_readl(EP93XX_TIMER4_VALUE_HIGH) & 0xff) << 32);
+	ret = readl(EP93XX_TIMER4_VALUE_LOW);
+	ret |= ((u64) (readl(EP93XX_TIMER4_VALUE_HIGH) & 0xff) << 32);
 	return ret;
 }
 
@@ -64,8 +64,8 @@ cycle_t ep93xx_clocksource_read(struct clocksource *c)
 {
 	u64 ret;
 
-	ret = __raw_readl(EP93XX_TIMER4_VALUE_LOW);
-	ret |= ((u64) (__raw_readl(EP93XX_TIMER4_VALUE_HIGH) & 0xff) << 32);
+	ret = readl(EP93XX_TIMER4_VALUE_LOW);
+	ret |= ((u64) (readl(EP93XX_TIMER4_VALUE_HIGH) & 0xff) << 32);
 	return (cycle_t) ret;
 }
 
@@ -77,12 +77,12 @@ static int ep93xx_clkevt_set_next_event(unsigned long next,
 		    EP93XX_TIMER123_CONTROL_CLKSEL;
 
 	/* Clear timer */
-	__raw_writel(tmode, EP93XX_TIMER1_CONTROL);
+	writel(tmode, EP93XX_TIMER1_CONTROL);
 
 	/* Set next event */
-	__raw_writel(next, EP93XX_TIMER1_LOAD);
-	__raw_writel(tmode | EP93XX_TIMER123_CONTROL_ENABLE,
-		     EP93XX_TIMER1_CONTROL);
+	writel(next, EP93XX_TIMER1_LOAD);
+	writel(tmode | EP93XX_TIMER123_CONTROL_ENABLE,
+	       EP93XX_TIMER1_CONTROL);
         return 0;
 }
 
@@ -91,7 +91,7 @@ static void ep93xx_clkevt_set_mode(enum clock_event_mode mode,
 				   struct clock_event_device *evt)
 {
 	/* Disable timer */
-	__raw_writel(0, EP93XX_TIMER1_CONTROL);
+	writel(0, EP93XX_TIMER1_CONTROL);
 }
 
 static struct clock_event_device ep93xx_clockevent = {
@@ -107,7 +107,7 @@ static irqreturn_t ep93xx_timer_interrupt(int irq, void *dev_id)
 	struct clock_event_device *evt = dev_id;
 
 	/* Writing any value clears the timer interrupt */
-	__raw_writel(1, EP93XX_TIMER1_CLEAR);
+	writel(1, EP93XX_TIMER1_CLEAR);
 
 	evt->event_handler(evt);
 
@@ -124,8 +124,8 @@ static struct irqaction ep93xx_timer_irq = {
 void __init ep93xx_timer_init(void)
 {
 	/* Enable and register clocksource and sched_clock on timer 4 */
-	__raw_writel(EP93XX_TIMER4_VALUE_HIGH_ENABLE,
-			EP93XX_TIMER4_VALUE_HIGH);
+	writel(EP93XX_TIMER4_VALUE_HIGH_ENABLE,
+	       EP93XX_TIMER4_VALUE_HIGH);
 	clocksource_mmio_init(NULL, "timer4",
 			      EP93XX_TIMER4_RATE, 200, 40,
 			      ep93xx_clocksource_read);
-- 
1.9.3
