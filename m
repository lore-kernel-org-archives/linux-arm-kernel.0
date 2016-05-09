From: joel@jms.id.au (Joel Stanley)
Date: Mon,  9 May 2016 22:02:48 +0930
Subject: [PATCH 3/4] drivers/clocksource/moxart: Use struct to hold state
In-Reply-To: <1462797169-14512-1-git-send-email-joel@jms.id.au>
References: <1462797169-14512-1-git-send-email-joel@jms.id.au>
Message-ID: <1462797169-14512-4-git-send-email-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a struct moxart_timer to hold the driver state, including the
irqaction and struct clock_event_device.

Most importantly this holds values for enabling and disabling the timer,
so future support can be added for devices that use different bits for
enable/disable.

In preparation for future hardware support we add a MOXART prefix to the
existing values.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/clocksource/moxart_timer.c | 143 ++++++++++++++++++++++---------------
 1 file changed, 84 insertions(+), 59 deletions(-)

diff --git a/drivers/clocksource/moxart_timer.c b/drivers/clocksource/moxart_timer.c
index b00b2b21e8b3..d17e3eface87 100644
--- a/drivers/clocksource/moxart_timer.c
+++ b/drivers/clocksource/moxart_timer.c
@@ -21,6 +21,7 @@
 #include <linux/io.h>
 #include <linux/clocksource.h>
 #include <linux/bitops.h>
+#include <linux/slab.h>
 
 #define TIMER1_BASE		0x00
 #define TIMER2_BASE		0x10
@@ -36,36 +37,51 @@
 #define TIMER_INTR_MASK		0x38
 
 /*
- * TIMER_CR flags:
+ * Moxart TIMER_CR flags:
  *
- * TIMEREG_CR_*_CLOCK	0: PCLK, 1: EXT1CLK
- * TIMEREG_CR_*_INT	overflow interrupt enable bit
+ * MOXART_CR_*_CLOCK	0: PCLK, 1: EXT1CLK
+ * MOXART_CR_*_INT	overflow interrupt enable bit
  */
-#define TIMEREG_CR_1_ENABLE	BIT(0)
-#define TIMEREG_CR_1_CLOCK	BIT(1)
-#define TIMEREG_CR_1_INT	BIT(2)
-#define TIMEREG_CR_2_ENABLE	BIT(3)
-#define TIMEREG_CR_2_CLOCK	BIT(4)
-#define TIMEREG_CR_2_INT	BIT(5)
-#define TIMEREG_CR_3_ENABLE	BIT(6)
-#define TIMEREG_CR_3_CLOCK	BIT(7)
-#define TIMEREG_CR_3_INT	BIT(8)
-#define TIMEREG_CR_COUNT_UP	BIT(9)
-
-#define TIMER1_ENABLE		(TIMEREG_CR_2_ENABLE | TIMEREG_CR_1_ENABLE)
-#define TIMER1_DISABLE		(TIMEREG_CR_2_ENABLE)
-
-static void __iomem *base;
-static unsigned int clock_count_per_tick;
+#define MOXART_CR_1_ENABLE	BIT(0)
+#define MOXART_CR_1_CLOCK	BIT(1)
+#define MOXART_CR_1_INT	BIT(2)
+#define MOXART_CR_2_ENABLE	BIT(3)
+#define MOXART_CR_2_CLOCK	BIT(4)
+#define MOXART_CR_2_INT	BIT(5)
+#define MOXART_CR_3_ENABLE	BIT(6)
+#define MOXART_CR_3_CLOCK	BIT(7)
+#define MOXART_CR_3_INT	BIT(8)
+#define MOXART_CR_COUNT_UP	BIT(9)
+
+#define MOXART_TIMER1_ENABLE	(MOXART_CR_2_ENABLE | MOXART_CR_1_ENABLE)
+#define MOXART_TIMER1_DISABLE	(MOXART_CR_2_ENABLE)
+
+struct moxart_timer {
+	void __iomem *base;
+	unsigned int t1_disable_val;
+	unsigned int t1_enable_val;
+	unsigned int count_per_tick;
+	struct clock_event_device clkevt;
+	struct irqaction act;
+};
+
+static inline struct moxart_timer *to_moxart(struct clock_event_device *evt)
+{
+	return container_of(evt, struct moxart_timer, clkevt);
+}
 
 static inline void moxart_disable(struct clock_event_device *evt)
 {
-	writel(TIMER1_DISABLE, base + TIMER_CR);
+	struct moxart_timer *timer = to_moxart(evt);
+
+	writel(timer->t1_disable_val, timer->base + TIMER_CR);
 }
 
 static inline void moxart_enable(struct clock_event_device *evt)
 {
-	writel(TIMER1_ENABLE, base + TIMER_CR);
+	struct moxart_timer *timer = to_moxart(evt);
+
+	writel(timer->t1_enable_val, timer->base + TIMER_CR);
 }
 
 static int moxart_shutdown(struct clock_event_device *evt)
@@ -77,13 +93,17 @@ static int moxart_shutdown(struct clock_event_device *evt)
 static int moxart_set_oneshot(struct clock_event_device *evt)
 {
 	moxart_disable(evt);
-	writel(~0, base + TIMER1_BASE + REG_LOAD);
+	writel(~0, to_moxart(evt)->base + TIMER1_BASE + REG_LOAD);
 	return 0;
 }
 
 static int moxart_set_periodic(struct clock_event_device *evt)
 {
-	writel(clock_count_per_tick, base + TIMER1_BASE + REG_LOAD);
+	struct moxart_timer *timer = to_moxart(evt);
+
+	moxart_disable(evt);
+	writel(timer->count_per_tick, timer->base + TIMER1_BASE + REG_LOAD);
+	writel(0, timer->base + TIMER1_BASE + REG_MATCH1);
 	moxart_enable(evt);
 	return 0;
 }
@@ -91,30 +111,19 @@ static int moxart_set_periodic(struct clock_event_device *evt)
 static int moxart_clkevt_next_event(unsigned long cycles,
 				    struct clock_event_device *evt)
 {
+	struct moxart_timer *timer = to_moxart(evt);
 	u32 u;
 
 	moxart_disable(evt);
 
-	u = readl(base + TIMER1_BASE + REG_COUNT) - cycles;
-	writel(u, base + TIMER1_BASE + REG_MATCH1);
+	u = readl(timer->base + TIMER1_BASE + REG_COUNT) - cycles;
+	writel(u, timer->base + TIMER1_BASE + REG_MATCH1);
 
 	moxart_enable(evt);
 
 	return 0;
 }
 
-static struct clock_event_device moxart_clockevent = {
-	.name			= "moxart_timer",
-	.rating			= 200,
-	.features		= CLOCK_EVT_FEAT_PERIODIC |
-				  CLOCK_EVT_FEAT_ONESHOT,
-	.set_state_shutdown	= moxart_shutdown,
-	.set_state_periodic	= moxart_set_periodic,
-	.set_state_oneshot	= moxart_set_oneshot,
-	.tick_resume		= moxart_set_oneshot,
-	.set_next_event		= moxart_clkevt_next_event,
-};
-
 static irqreturn_t moxart_timer_interrupt(int irq, void *dev_id)
 {
 	struct clock_event_device *evt = dev_id;
@@ -122,49 +131,66 @@ static irqreturn_t moxart_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction moxart_timer_irq = {
-	.name		= "moxart-timer",
-	.flags		= IRQF_TIMER,
-	.handler	= moxart_timer_interrupt,
-	.dev_id		= &moxart_clockevent,
-};
-
 static void __init moxart_timer_init(struct device_node *node)
 {
 	int ret, irq;
 	unsigned long pclk;
 	struct clk *clk;
+	struct moxart_timer *timer;
+
+	timer = kzalloc(sizeof(*timer), GFP_KERNEL);
+	if (!timer)
+		panic("Can't allocate timer struct\n");
 
-	base = of_iomap(node, 0);
-	if (!base)
+	timer->base = of_iomap(node, 0);
+	if (!timer->base)
 		panic("%s: of_iomap failed\n", node->full_name);
 
 	irq = irq_of_parse_and_map(node, 0);
 	if (irq <= 0)
 		panic("%s: irq_of_parse_and_map failed\n", node->full_name);
 
-	ret = setup_irq(irq, &moxart_timer_irq);
-	if (ret)
-		panic("%s: setup_irq failed\n", node->full_name);
-
 	clk = of_clk_get(node, 0);
 	if (IS_ERR(clk))
 		panic("%s: of_clk_get failed\n", node->full_name);
 
 	pclk = clk_get_rate(clk);
 
-	if (clocksource_mmio_init(base + TIMER2_BASE + REG_COUNT,
+	if (of_device_is_compatible(node, "moxa,moxart-timer")) {
+		timer->t1_enable_val = MOXART_TIMER1_ENABLE;
+		timer->t1_disable_val = MOXART_TIMER1_DISABLE;
+	} else
+		panic("%s: unknown platform\n", node->full_name);
+
+	timer->count_per_tick = DIV_ROUND_CLOSEST(pclk, HZ);
+
+	timer->clkevt.name = node->name;
+	timer->clkevt.rating = 200;
+	timer->clkevt.features = CLOCK_EVT_FEAT_PERIODIC |
+					CLOCK_EVT_FEAT_ONESHOT;
+	timer->clkevt.set_state_shutdown = moxart_shutdown;
+	timer->clkevt.set_state_periodic = moxart_set_periodic;
+	timer->clkevt.set_state_oneshot = moxart_set_oneshot;
+	timer->clkevt.tick_resume = moxart_set_oneshot;
+	timer->clkevt.set_next_event = moxart_clkevt_next_event;
+	timer->clkevt.cpumask = cpumask_of(0);
+	timer->clkevt.irq = irq;
+	timer->act.name = node->name;
+	timer->act.flags = IRQF_TIMER;
+	timer->act.handler = moxart_timer_interrupt;
+	timer->act.dev_id = &timer->clkevt;
+
+	if (clocksource_mmio_init(timer->base + TIMER2_BASE + REG_COUNT,
 				  "moxart_timer", pclk, 200, 32,
 				  clocksource_mmio_readl_down))
 		panic("%s: clocksource_mmio_init failed\n", node->full_name);
 
-	clock_count_per_tick = DIV_ROUND_CLOSEST(pclk, HZ);
-
-	writel(~0, base + TIMER2_BASE + REG_LOAD);
-	writel(TIMEREG_CR_2_ENABLE, base + TIMER_CR);
+	ret = setup_irq(irq, &timer->act);
+	if (ret)
+		panic("%s: setup_irq failed\n", node->full_name);
 
-	moxart_clockevent.cpumask = cpumask_of(0);
-	moxart_clockevent.irq = irq;
+	writel(~0, timer->base + TIMER2_BASE + REG_LOAD);
+	writel(timer->t1_disable_val, timer->base + TIMER_CR);
 
 	/*
 	 * documentation is not publicly available:
@@ -172,7 +198,6 @@ static void __init moxart_timer_init(struct device_node *node)
 	 * max_delta 0xfffffffe should be ok because count
 	 * register size is u32
 	 */
-	clockevents_config_and_register(&moxart_clockevent, pclk,
-					0x4, 0xfffffffe);
+	clockevents_config_and_register(&timer->clkevt, pclk, 0x4, 0xfffffffe);
 }
 CLOCKSOURCE_OF_DECLARE(moxart, "moxa,moxart-timer", moxart_timer_init);
-- 
2.8.1
