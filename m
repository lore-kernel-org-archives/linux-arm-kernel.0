From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 30 Sep 2018 23:16:08 +0200
Subject: [PATCH 3/3] clocksource/drivers/ep93xx: Create a state container
In-Reply-To: <20180930211608.5516-1-linus.walleij@linaro.org>
References: <20180930211608.5516-1-linus.walleij@linaro.org>
Message-ID: <20180930211608.5516-3-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Create a struct to hold the clocksource state, augment
everywhere to pass this around, cut a shortcut using a
singleton for the clocksource and sched_clock callbacks
that need to be fast.

Request the IRQ in a normal way and use offsets to
read/write registers.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Clocksource: please ACK this if OK so I can merge this
patch through the ARM SoC tree.
---
 drivers/clocksource/timer-ep93xx.c | 121 ++++++++++++++++-------------
 1 file changed, 69 insertions(+), 52 deletions(-)

diff --git a/drivers/clocksource/timer-ep93xx.c b/drivers/clocksource/timer-ep93xx.c
index 3dcc58de65ef..2b68dd62c03f 100644
--- a/drivers/clocksource/timer-ep93xx.c
+++ b/drivers/clocksource/timer-ep93xx.c
@@ -8,8 +8,6 @@
 #include <linux/platform_data/timer-ep93xx.h>
 #include <linux/slab.h>
 
-static void __iomem *ep93xx_base;
-
 /*************************************************************************
  * Timer handling for EP93xx
  *************************************************************************
@@ -28,109 +26,112 @@ static void __iomem *ep93xx_base;
  * a stable 40 bit time base.
  *************************************************************************
  */
-#define EP93XX_TIMER_REG(x)		(ep93xx_base + (x))
-#define EP93XX_TIMER1_LOAD		EP93XX_TIMER_REG(0x00)
-#define EP93XX_TIMER1_VALUE		EP93XX_TIMER_REG(0x04)
-#define EP93XX_TIMER1_CONTROL		EP93XX_TIMER_REG(0x08)
+#define EP93XX_TIMER1_LOAD		0x00
+#define EP93XX_TIMER1_VALUE		0x04
+#define EP93XX_TIMER1_CONTROL		0x08
 #define EP93XX_TIMER123_CONTROL_ENABLE	(1 << 7)
 #define EP93XX_TIMER123_CONTROL_MODE	(1 << 6)
 #define EP93XX_TIMER123_CONTROL_CLKSEL	(1 << 3)
-#define EP93XX_TIMER1_CLEAR		EP93XX_TIMER_REG(0x0c)
-#define EP93XX_TIMER2_LOAD		EP93XX_TIMER_REG(0x20)
-#define EP93XX_TIMER2_VALUE		EP93XX_TIMER_REG(0x24)
-#define EP93XX_TIMER2_CONTROL		EP93XX_TIMER_REG(0x28)
-#define EP93XX_TIMER2_CLEAR		EP93XX_TIMER_REG(0x2c)
-#define EP93XX_TIMER4_VALUE_LOW		EP93XX_TIMER_REG(0x60)
-#define EP93XX_TIMER4_VALUE_HIGH	EP93XX_TIMER_REG(0x64)
+#define EP93XX_TIMER1_CLEAR		0x0c
+#define EP93XX_TIMER2_LOAD		0x20
+#define EP93XX_TIMER2_VALUE		0x24
+#define EP93XX_TIMER2_CONTROL		0x28
+#define EP93XX_TIMER2_CLEAR		0x2c
+#define EP93XX_TIMER4_VALUE_LOW		0x60
+#define EP93XX_TIMER4_VALUE_HIGH	0x64
 #define EP93XX_TIMER4_VALUE_HIGH_ENABLE	(1 << 8)
-#define EP93XX_TIMER3_LOAD		EP93XX_TIMER_REG(0x80)
-#define EP93XX_TIMER3_VALUE		EP93XX_TIMER_REG(0x84)
-#define EP93XX_TIMER3_CONTROL		EP93XX_TIMER_REG(0x88)
-#define EP93XX_TIMER3_CLEAR		EP93XX_TIMER_REG(0x8c)
+#define EP93XX_TIMER3_LOAD		0x80
+#define EP93XX_TIMER3_VALUE		0x84
+#define EP93XX_TIMER3_CONTROL		0x88
+#define EP93XX_TIMER3_CLEAR		0x8c
 
 #define EP93XX_TIMER123_RATE		508469
 #define EP93XX_TIMER4_RATE		983040
 
-static u64 notrace ep93xx_read_sched_clock(void)
-{
-	u64 ret;
+struct ep93tmr {
+	void __iomem *base;
+	struct clock_event_device clkevt;
+};
 
-	ret = readl(EP93XX_TIMER4_VALUE_LOW);
-	ret |= ((u64) (readl(EP93XX_TIMER4_VALUE_HIGH) & 0xff) << 32);
-	return ret;
+static struct ep93tmr *local_ep93tmr;
+
+static inline struct ep93tmr *to_ep93tmr(struct clock_event_device *evt)
+{
+	return container_of(evt, struct ep93tmr, clkevt);
 }
 
-u64 ep93xx_clocksource_read(struct clocksource *c)
+static u64 ep93xx_clocksource_read(struct clocksource *c)
 {
 	u64 ret;
 
-	ret = readl(EP93XX_TIMER4_VALUE_LOW);
-	ret |= ((u64) (readl(EP93XX_TIMER4_VALUE_HIGH) & 0xff) << 32);
+	ret = readl(local_ep93tmr->base + EP93XX_TIMER4_VALUE_LOW);
+	ret |= ((u64) (readl(local_ep93tmr->base + EP93XX_TIMER4_VALUE_HIGH)
+		       & 0xff) << 32);
 	return (u64) ret;
 }
 
+static u64 notrace ep93xx_read_sched_clock(void)
+{
+	return ep93xx_clocksource_read(NULL);
+}
+
 static int ep93xx_clkevt_set_next_event(unsigned long next,
 					struct clock_event_device *evt)
 {
+	struct ep93tmr *ep93tmr = to_ep93tmr(evt);
+
 	/* Default mode: periodic, off, 508 kHz */
 	u32 tmode = EP93XX_TIMER123_CONTROL_MODE |
 		    EP93XX_TIMER123_CONTROL_CLKSEL;
 
 	/* Clear timer */
-	writel(tmode, EP93XX_TIMER3_CONTROL);
+	writel(tmode, ep93tmr->base + EP93XX_TIMER3_CONTROL);
 
 	/* Set next event */
-	writel(next, EP93XX_TIMER3_LOAD);
+	writel(next, ep93tmr->base + EP93XX_TIMER3_LOAD);
 	writel(tmode | EP93XX_TIMER123_CONTROL_ENABLE,
-	       EP93XX_TIMER3_CONTROL);
+	       ep93tmr->base + EP93XX_TIMER3_CONTROL);
         return 0;
 }
 
 
 static int ep93xx_clkevt_shutdown(struct clock_event_device *evt)
 {
+	struct ep93tmr *ep93tmr = to_ep93tmr(evt);
+
 	/* Disable timer */
-	writel(0, EP93XX_TIMER3_CONTROL);
+	writel(0, ep93tmr->base + EP93XX_TIMER3_CONTROL);
 
 	return 0;
 }
 
-static struct clock_event_device ep93xx_clockevent = {
-	.name			= "timer1",
-	.features		= CLOCK_EVT_FEAT_ONESHOT,
-	.set_state_shutdown	= ep93xx_clkevt_shutdown,
-	.set_state_oneshot	= ep93xx_clkevt_shutdown,
-	.tick_resume		= ep93xx_clkevt_shutdown,
-	.set_next_event		= ep93xx_clkevt_set_next_event,
-	.rating			= 300,
-};
-
 static irqreturn_t ep93xx_timer_interrupt(int irq, void *dev_id)
 {
 	struct clock_event_device *evt = dev_id;
+	struct ep93tmr *ep93tmr = to_ep93tmr(evt);
 
 	/* Writing any value clears the timer interrupt */
-	writel(1, EP93XX_TIMER3_CLEAR);
+	writel(1, ep93tmr->base + EP93XX_TIMER3_CLEAR);
 
 	evt->event_handler(evt);
 
 	return IRQ_HANDLED;
 }
 
-static struct irqaction ep93xx_timer_irq = {
-	.name		= "ep93xx timer",
-	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
-	.handler	= ep93xx_timer_interrupt,
-	.dev_id		= &ep93xx_clockevent,
-};
-
 int __init ep93xx_timer_init_common(void __iomem *base, int irq)
 {
-	ep93xx_base = base;
+	struct ep93tmr *tmr;
+	int ret;
+
+	tmr = kzalloc(sizeof(*tmr), GFP_KERNEL);
+	if (!tmr)
+		return -ENOMEM;
+	tmr->base = base;
+	local_ep93tmr = tmr;
 
 	/* Enable and register clocksource and sched_clock on timer 4 */
 	writel(EP93XX_TIMER4_VALUE_HIGH_ENABLE,
-	       EP93XX_TIMER4_VALUE_HIGH);
+	       tmr->base + EP93XX_TIMER4_VALUE_HIGH);
 	clocksource_mmio_init(NULL, "timer4",
 			      EP93XX_TIMER4_RATE, 200, 40,
 			      ep93xx_clocksource_read);
@@ -138,8 +139,24 @@ int __init ep93xx_timer_init_common(void __iomem *base, int irq)
 			     EP93XX_TIMER4_RATE);
 
 	/* Set up clockevent on timer 3 */
-	setup_irq(irq, &ep93xx_timer_irq);
-	clockevents_config_and_register(&ep93xx_clockevent,
+	ret = request_irq(irq, ep93xx_timer_interrupt,
+			  IRQF_TIMER | IRQF_IRQPOLL,
+			  "EP93XX-TIMER3", &tmr->clkevt);
+	if (ret) {
+		pr_err("EP93XX-TIMER3 no IRQ\n");
+		return ret;
+	}
+
+	tmr->clkevt.name = "EP93XX-TIMER3";
+	tmr->clkevt.features = CLOCK_EVT_FEAT_ONESHOT;
+	tmr->clkevt.set_state_shutdown = ep93xx_clkevt_shutdown;
+	tmr->clkevt.set_state_oneshot = ep93xx_clkevt_shutdown;
+	tmr->clkevt.tick_resume = ep93xx_clkevt_shutdown;
+	tmr->clkevt.set_next_event = ep93xx_clkevt_set_next_event;
+	tmr->clkevt.cpumask = cpumask_of(0);
+	tmr->clkevt.rating = 300;
+	tmr->clkevt.irq = irq;
+	clockevents_config_and_register(&tmr->clkevt,
 					EP93XX_TIMER123_RATE,
 					1,
 					0xffffffffU);
-- 
2.17.1
