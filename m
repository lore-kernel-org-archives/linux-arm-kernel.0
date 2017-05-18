From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 18 May 2017 22:17:01 +0200
Subject: [PATCH 4/8 v2] clocksource/drivers/fttmr010: Use state container
In-Reply-To: <20170518201705.28790-1-linus.walleij@linaro.org>
References: <20170518201705.28790-1-linus.walleij@linaro.org>
Message-ID: <20170518201705.28790-4-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This converts the Faraday FTTMR010 to use the state container
design pattern. Take some care to handle the state container
and free:ing of resources as has been done in the Moxa driver.

Cc: Joel Stanley <joel@jms.id.au>
Tested-by: Jonas Jensen <jonas.jensen@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Added Jonas' Tested-by, no functional changes.
---
 drivers/clocksource/timer-fttmr010.c | 190 +++++++++++++++++++++--------------
 1 file changed, 116 insertions(+), 74 deletions(-)

diff --git a/drivers/clocksource/timer-fttmr010.c b/drivers/clocksource/timer-fttmr010.c
index db097db346e3..9ad31489bbef 100644
--- a/drivers/clocksource/timer-fttmr010.c
+++ b/drivers/clocksource/timer-fttmr010.c
@@ -15,6 +15,7 @@
 #include <linux/clocksource.h>
 #include <linux/sched_clock.h>
 #include <linux/clk.h>
+#include <linux/slab.h>
 
 /*
  * Register definitions for the timers
@@ -62,23 +63,35 @@
 #define TIMER_3_INT_OVERFLOW	(1 << 8)
 #define TIMER_INT_ALL_MASK	0x1ff
 
-static unsigned int tick_rate;
-static void __iomem *base;
+struct fttmr010 {
+	void __iomem *base;
+	unsigned int tick_rate;
+	struct clock_event_device clkevt;
+};
+
+/* A local singleton used by sched_clock, which is stateless */
+static struct fttmr010 *local_fttmr;
+
+static inline struct fttmr010 *to_fttmr010(struct clock_event_device *evt)
+{
+	return container_of(evt, struct fttmr010, clkevt);
+}
 
 static u64 notrace fttmr010_read_sched_clock(void)
 {
-	return readl(base + TIMER3_COUNT);
+	return readl(local_fttmr->base + TIMER3_COUNT);
 }
 
 static int fttmr010_timer_set_next_event(unsigned long cycles,
 				       struct clock_event_device *evt)
 {
+	struct fttmr010 *fttmr010 = to_fttmr010(evt);
 	u32 cr;
 
 	/* Setup the match register */
-	cr = readl(base + TIMER1_COUNT);
-	writel(cr + cycles, base + TIMER1_MATCH1);
-	if (readl(base + TIMER1_COUNT) - cr > cycles)
+	cr = readl(fttmr010->base + TIMER1_COUNT);
+	writel(cr + cycles, fttmr010->base + TIMER1_MATCH1);
+	if (readl(fttmr010->base + TIMER1_COUNT) - cr > cycles)
 		return -ETIME;
 
 	return 0;
@@ -86,99 +99,90 @@ static int fttmr010_timer_set_next_event(unsigned long cycles,
 
 static int fttmr010_timer_shutdown(struct clock_event_device *evt)
 {
+	struct fttmr010 *fttmr010 = to_fttmr010(evt);
+	u32 cr;
+
+	/* Stop timer and interrupt. */
+	cr = readl(fttmr010->base + TIMER_CR);
+	cr &= ~(TIMER_1_CR_ENABLE | TIMER_1_CR_INT);
+	writel(cr, fttmr010->base + TIMER_CR);
+
+	return 0;
+}
+
+static int fttmr010_timer_set_oneshot(struct clock_event_device *evt)
+{
+	struct fttmr010 *fttmr010 = to_fttmr010(evt);
 	u32 cr;
 
-	/*
-	 * Disable also for oneshot: the set_next() call will arm the timer
-	 * instead.
-	 */
 	/* Stop timer and interrupt. */
-	cr = readl(base + TIMER_CR);
+	cr = readl(fttmr010->base + TIMER_CR);
 	cr &= ~(TIMER_1_CR_ENABLE | TIMER_1_CR_INT);
-	writel(cr, base + TIMER_CR);
+	writel(cr, fttmr010->base + TIMER_CR);
 
 	/* Setup counter start from 0 */
-	writel(0, base + TIMER1_COUNT);
-	writel(0, base + TIMER1_LOAD);
+	writel(0, fttmr010->base + TIMER1_COUNT);
+	writel(0, fttmr010->base + TIMER1_LOAD);
 
-	/* enable interrupt */
-	cr = readl(base + TIMER_INTR_MASK);
+	/* Enable interrupt */
+	cr = readl(fttmr010->base + TIMER_INTR_MASK);
 	cr &= ~(TIMER_1_INT_OVERFLOW | TIMER_1_INT_MATCH2);
 	cr |= TIMER_1_INT_MATCH1;
-	writel(cr, base + TIMER_INTR_MASK);
+	writel(cr, fttmr010->base + TIMER_INTR_MASK);
 
-	/* start the timer */
-	cr = readl(base + TIMER_CR);
+	/* Start the timer */
+	cr = readl(fttmr010->base + TIMER_CR);
 	cr |= TIMER_1_CR_ENABLE;
-	writel(cr, base + TIMER_CR);
+	writel(cr, fttmr010->base + TIMER_CR);
 
 	return 0;
 }
 
 static int fttmr010_timer_set_periodic(struct clock_event_device *evt)
 {
-	u32 period = DIV_ROUND_CLOSEST(tick_rate, HZ);
+	struct fttmr010 *fttmr010 = to_fttmr010(evt);
+	u32 period = DIV_ROUND_CLOSEST(fttmr010->tick_rate, HZ);
 	u32 cr;
 
 	/* Stop timer and interrupt */
-	cr = readl(base + TIMER_CR);
+	cr = readl(fttmr010->base + TIMER_CR);
 	cr &= ~(TIMER_1_CR_ENABLE | TIMER_1_CR_INT);
-	writel(cr, base + TIMER_CR);
+	writel(cr, fttmr010->base + TIMER_CR);
 
 	/* Setup timer to fire at 1/HT intervals. */
 	cr = 0xffffffff - (period - 1);
-	writel(cr, base + TIMER1_COUNT);
-	writel(cr, base + TIMER1_LOAD);
+	writel(cr, fttmr010->base + TIMER1_COUNT);
+	writel(cr, fttmr010->base + TIMER1_LOAD);
 
 	/* enable interrupt on overflow */
-	cr = readl(base + TIMER_INTR_MASK);
+	cr = readl(fttmr010->base + TIMER_INTR_MASK);
 	cr &= ~(TIMER_1_INT_MATCH1 | TIMER_1_INT_MATCH2);
 	cr |= TIMER_1_INT_OVERFLOW;
-	writel(cr, base + TIMER_INTR_MASK);
+	writel(cr, fttmr010->base + TIMER_INTR_MASK);
 
 	/* Start the timer */
-	cr = readl(base + TIMER_CR);
+	cr = readl(fttmr010->base + TIMER_CR);
 	cr |= TIMER_1_CR_ENABLE;
 	cr |= TIMER_1_CR_INT;
-	writel(cr, base + TIMER_CR);
+	writel(cr, fttmr010->base + TIMER_CR);
 
 	return 0;
 }
 
-/* Use TIMER1 as clock event */
-static struct clock_event_device fttmr010_clockevent = {
-	.name			= "TIMER1",
-	/* Reasonably fast and accurate clock event */
-	.rating			= 300,
-	.shift                  = 32,
-	.features		= CLOCK_EVT_FEAT_PERIODIC |
-				  CLOCK_EVT_FEAT_ONESHOT,
-	.set_next_event		= fttmr010_timer_set_next_event,
-	.set_state_shutdown	= fttmr010_timer_shutdown,
-	.set_state_periodic	= fttmr010_timer_set_periodic,
-	.set_state_oneshot	= fttmr010_timer_shutdown,
-	.tick_resume		= fttmr010_timer_shutdown,
-};
-
 /*
  * IRQ handler for the timer
  */
 static irqreturn_t fttmr010_timer_interrupt(int irq, void *dev_id)
 {
-	struct clock_event_device *evt = &fttmr010_clockevent;
+	struct clock_event_device *evt = dev_id;
 
 	evt->event_handler(evt);
 	return IRQ_HANDLED;
 }
 
-static struct irqaction fttmr010_timer_irq = {
-	.name		= "Faraday FTTMR010 Timer Tick",
-	.flags		= IRQF_TIMER,
-	.handler	= fttmr010_timer_interrupt,
-};
-
 static int __init fttmr010_timer_init(struct device_node *np)
 {
+	struct fttmr010 *fttmr010;
 	int irq;
 	struct clk *clk;
 	int ret;
@@ -198,53 +202,91 @@ static int __init fttmr010_timer_init(struct device_node *np)
 		pr_err("failed to enable PCLK\n");
 		return ret;
 	}
-	tick_rate = clk_get_rate(clk);
 
-	base = of_iomap(np, 0);
-	if (!base) {
+	fttmr010 = kzalloc(sizeof(*fttmr010), GFP_KERNEL);
+	if (!fttmr010) {
+		ret = -ENOMEM;
+		goto out_disable_clock;
+	}
+	fttmr010->tick_rate = clk_get_rate(clk);
+
+	fttmr010->base = of_iomap(np, 0);
+	if (!fttmr010->base) {
 		pr_err("Can't remap registers");
-		return -ENXIO;
+		ret = -ENXIO;
+		goto out_free;
 	}
 	/* IRQ for timer 1 */
 	irq = irq_of_parse_and_map(np, 0);
 	if (irq <= 0) {
 		pr_err("Can't parse IRQ");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out_unmap;
 	}
 
 	/*
 	 * Reset the interrupt mask and status
 	 */
-	writel(TIMER_INT_ALL_MASK, base + TIMER_INTR_MASK);
-	writel(0, base + TIMER_INTR_STATE);
-	writel(TIMER_DEFAULT_FLAGS, base + TIMER_CR);
+	writel(TIMER_INT_ALL_MASK, fttmr010->base + TIMER_INTR_MASK);
+	writel(0, fttmr010->base + TIMER_INTR_STATE);
+	writel(TIMER_DEFAULT_FLAGS, fttmr010->base + TIMER_CR);
 
 	/*
 	 * Setup free-running clocksource timer (interrupts
 	 * disabled.)
 	 */
-	writel(0, base + TIMER3_COUNT);
-	writel(0, base + TIMER3_LOAD);
-	writel(0, base + TIMER3_MATCH1);
-	writel(0, base + TIMER3_MATCH2);
-	clocksource_mmio_init(base + TIMER3_COUNT,
-			      "fttmr010_clocksource", tick_rate,
+	local_fttmr = fttmr010;
+	writel(0, fttmr010->base + TIMER3_COUNT);
+	writel(0, fttmr010->base + TIMER3_LOAD);
+	writel(0, fttmr010->base + TIMER3_MATCH1);
+	writel(0, fttmr010->base + TIMER3_MATCH2);
+	clocksource_mmio_init(fttmr010->base + TIMER3_COUNT,
+			      "FTTMR010-TIMER3",
+			      fttmr010->tick_rate,
 			      300, 32, clocksource_mmio_readl_up);
-	sched_clock_register(fttmr010_read_sched_clock, 32, tick_rate);
+	sched_clock_register(fttmr010_read_sched_clock, 32,
+			     fttmr010->tick_rate);
 
 	/*
-	 * Setup clockevent timer (interrupt-driven.)
+	 * Setup clockevent timer (interrupt-driven) on timer 1.
 	 */
-	writel(0, base + TIMER1_COUNT);
-	writel(0, base + TIMER1_LOAD);
-	writel(0, base + TIMER1_MATCH1);
-	writel(0, base + TIMER1_MATCH2);
-	setup_irq(irq, &fttmr010_timer_irq);
-	fttmr010_clockevent.cpumask = cpumask_of(0);
-	clockevents_config_and_register(&fttmr010_clockevent, tick_rate,
+	writel(0, fttmr010->base + TIMER1_COUNT);
+	writel(0, fttmr010->base + TIMER1_LOAD);
+	writel(0, fttmr010->base + TIMER1_MATCH1);
+	writel(0, fttmr010->base + TIMER1_MATCH2);
+	ret = request_irq(irq, fttmr010_timer_interrupt, IRQF_TIMER,
+			  "FTTMR010-TIMER1", &fttmr010->clkevt);
+	if (ret) {
+		pr_err("FTTMR010-TIMER1 no IRQ\n");
+		goto out_unmap;
+	}
+
+	fttmr010->clkevt.name = "FTTMR010-TIMER1";
+	/* Reasonably fast and accurate clock event */
+	fttmr010->clkevt.rating = 300;
+	fttmr010->clkevt.features = CLOCK_EVT_FEAT_PERIODIC |
+		CLOCK_EVT_FEAT_ONESHOT;
+	fttmr010->clkevt.set_next_event = fttmr010_timer_set_next_event;
+	fttmr010->clkevt.set_state_shutdown = fttmr010_timer_shutdown;
+	fttmr010->clkevt.set_state_periodic = fttmr010_timer_set_periodic;
+	fttmr010->clkevt.set_state_oneshot = fttmr010_timer_set_oneshot;
+	fttmr010->clkevt.tick_resume = fttmr010_timer_shutdown;
+	fttmr010->clkevt.cpumask = cpumask_of(0);
+	fttmr010->clkevt.irq = irq;
+	clockevents_config_and_register(&fttmr010->clkevt,
+					fttmr010->tick_rate,
 					1, 0xffffffff);
 
 	return 0;
+
+out_unmap:
+	iounmap(fttmr010->base);
+out_free:
+	kfree(fttmr010);
+out_disable_clock:
+	clk_disable_unprepare(clk);
+
+	return ret;
 }
 CLOCKSOURCE_OF_DECLARE(fttmr010, "faraday,fttmr010", fttmr010_timer_init);
 CLOCKSOURCE_OF_DECLARE(gemini, "cortina,gemini-timer", fttmr010_timer_init);
-- 
2.9.3
