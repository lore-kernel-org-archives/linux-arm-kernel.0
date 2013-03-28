From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 28 Mar 2013 17:38:03 +0100
Subject: [PATCH v3 03/12] arm: zynq: Do not use xilinx specific function names
In-Reply-To: <1364488692-18709-1-git-send-email-michal.simek@xilinx.com>
References: <1364488692-18709-1-git-send-email-michal.simek@xilinx.com>
Message-ID: <743816c85f9f31b98e1efeff501a031b3415d6f6.1364488495.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove all xilinx specific names from the driver
because this is generic driver for cadence ttc.
xttc->ttc
ttcps->ttc
...

No functional changes in this driver.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
----
v3: The first version of this patch.
    Done based on discussion with Steffen to use proper naming
---
 arch/arm/mach-zynq/timer.c |  212 ++++++++++++++++++++++----------------------
 1 file changed, 106 insertions(+), 106 deletions(-)

diff --git a/arch/arm/mach-zynq/timer.c b/arch/arm/mach-zynq/timer.c
index ab5b839..685bc60 100644
--- a/arch/arm/mach-zynq/timer.c
+++ b/arch/arm/mach-zynq/timer.c
@@ -1,5 +1,5 @@
 /*
- * This file contains driver for the Xilinx PS Timer Counter IP.
+ * This file contains driver for the Cadence Triple Timer Counter Rev 06
  *
  *  Copyright (C) 2011-2013 Xilinx
  *
@@ -42,14 +42,14 @@
  * Timer Register Offset Definitions of Timer 1, Increment base address by 4
  * and use same offsets for Timer 2
  */
-#define XTTCPS_CLK_CNTRL_OFFSET		0x00 /* Clock Control Reg, RW */
-#define XTTCPS_CNT_CNTRL_OFFSET		0x0C /* Counter Control Reg, RW */
-#define XTTCPS_COUNT_VAL_OFFSET		0x18 /* Counter Value Reg, RO */
-#define XTTCPS_INTR_VAL_OFFSET		0x24 /* Interval Count Reg, RW */
-#define XTTCPS_ISR_OFFSET		0x54 /* Interrupt Status Reg, RO */
-#define XTTCPS_IER_OFFSET		0x60 /* Interrupt Enable Reg, RW */
+#define TTC_CLK_CNTRL_OFFSET		0x00 /* Clock Control Reg, RW */
+#define TTC_CNT_CNTRL_OFFSET		0x0C /* Counter Control Reg, RW */
+#define TTC_COUNT_VAL_OFFSET		0x18 /* Counter Value Reg, RO */
+#define TTC_INTR_VAL_OFFSET		0x24 /* Interval Count Reg, RW */
+#define TTC_ISR_OFFSET		0x54 /* Interrupt Status Reg, RO */
+#define TTC_IER_OFFSET		0x60 /* Interrupt Enable Reg, RW */
 
-#define XTTCPS_CNT_CNTRL_DISABLE_MASK	0x1
+#define TTC_CNT_CNTRL_DISABLE_MASK	0x1
 
 /*
  * Setup the timers to use pre-scaling, using a fixed value for now that will
@@ -62,161 +62,161 @@
 #define CNT_CNTRL_RESET		(1 << 4)
 
 /**
- * struct xttcps_timer - This definition defines local timer structure
+ * struct ttc_timer - This definition defines local timer structure
  *
  * @base_addr:	Base address of timer
  * @clk:	Associated clock source
  * @clk_rate_change_nb	Notifier block for clock rate changes
  */
-struct xttcps_timer {
+struct ttc_timer {
 	void __iomem *base_addr;
 	struct clk *clk;
 	struct notifier_block clk_rate_change_nb;
 };
 
-#define to_xttcps_timer(x) \
-		container_of(x, struct xttcps_timer, clk_rate_change_nb)
+#define to_ttc_timer(x) \
+		container_of(x, struct ttc_timer, clk_rate_change_nb)
 
-struct xttcps_timer_clocksource {
-	struct xttcps_timer	xttc;
+struct ttc_timer_clocksource {
+	struct ttc_timer	ttc;
 	struct clocksource	cs;
 };
 
-#define to_xttcps_timer_clksrc(x) \
-		container_of(x, struct xttcps_timer_clocksource, cs)
+#define to_ttc_timer_clksrc(x) \
+		container_of(x, struct ttc_timer_clocksource, cs)
 
-struct xttcps_timer_clockevent {
-	struct xttcps_timer		xttc;
+struct ttc_timer_clockevent {
+	struct ttc_timer		ttc;
 	struct clock_event_device	ce;
 };
 
-#define to_xttcps_timer_clkevent(x) \
-		container_of(x, struct xttcps_timer_clockevent, ce)
+#define to_ttc_timer_clkevent(x) \
+		container_of(x, struct ttc_timer_clockevent, ce)
 
 /**
- * xttcps_set_interval - Set the timer interval value
+ * ttc_set_interval - Set the timer interval value
  *
  * @timer:	Pointer to the timer instance
  * @cycles:	Timer interval ticks
  **/
-static void xttcps_set_interval(struct xttcps_timer *timer,
+static void ttc_set_interval(struct ttc_timer *timer,
 					unsigned long cycles)
 {
 	u32 ctrl_reg;
 
 	/* Disable the counter, set the counter value  and re-enable counter */
-	ctrl_reg = __raw_readl(timer->base_addr + XTTCPS_CNT_CNTRL_OFFSET);
-	ctrl_reg |= XTTCPS_CNT_CNTRL_DISABLE_MASK;
-	__raw_writel(ctrl_reg, timer->base_addr + XTTCPS_CNT_CNTRL_OFFSET);
+	ctrl_reg = __raw_readl(timer->base_addr + TTC_CNT_CNTRL_OFFSET);
+	ctrl_reg |= TTC_CNT_CNTRL_DISABLE_MASK;
+	__raw_writel(ctrl_reg, timer->base_addr + TTC_CNT_CNTRL_OFFSET);
 
-	__raw_writel(cycles, timer->base_addr + XTTCPS_INTR_VAL_OFFSET);
+	__raw_writel(cycles, timer->base_addr + TTC_INTR_VAL_OFFSET);
 
 	/*
 	 * Reset the counter (0x10) so that it starts from 0, one-shot
 	 * mode makes this needed for timing to be right.
 	 */
 	ctrl_reg |= CNT_CNTRL_RESET;
-	ctrl_reg &= ~XTTCPS_CNT_CNTRL_DISABLE_MASK;
-	__raw_writel(ctrl_reg, timer->base_addr + XTTCPS_CNT_CNTRL_OFFSET);
+	ctrl_reg &= ~TTC_CNT_CNTRL_DISABLE_MASK;
+	__raw_writel(ctrl_reg, timer->base_addr + TTC_CNT_CNTRL_OFFSET);
 }
 
 /**
- * xttcps_clock_event_interrupt - Clock event timer interrupt handler
+ * ttc_clock_event_interrupt - Clock event timer interrupt handler
  *
  * @irq:	IRQ number of the Timer
- * @dev_id:	void pointer to the xttcps_timer instance
+ * @dev_id:	void pointer to the ttc_timer instance
  *
  * returns: Always IRQ_HANDLED - success
  **/
-static irqreturn_t xttcps_clock_event_interrupt(int irq, void *dev_id)
+static irqreturn_t ttc_clock_event_interrupt(int irq, void *dev_id)
 {
-	struct xttcps_timer_clockevent *xttce = dev_id;
-	struct xttcps_timer *timer = &xttce->xttc;
+	struct ttc_timer_clockevent *ttce = dev_id;
+	struct ttc_timer *timer = &ttce->ttc;
 
 	/* Acknowledge the interrupt and call event handler */
-	__raw_readl(timer->base_addr + XTTCPS_ISR_OFFSET);
+	__raw_readl(timer->base_addr + TTC_ISR_OFFSET);
 
-	xttce->ce.event_handler(&xttce->ce);
+	ttce->ce.event_handler(&ttce->ce);
 
 	return IRQ_HANDLED;
 }
 
 /**
- * __xttc_clocksource_read - Reads the timer counter register
+ * __ttc_clocksource_read - Reads the timer counter register
  *
  * returns: Current timer counter register value
  **/
-static cycle_t __xttc_clocksource_read(struct clocksource *cs)
+static cycle_t __ttc_clocksource_read(struct clocksource *cs)
 {
-	struct xttcps_timer *timer = &to_xttcps_timer_clksrc(cs)->xttc;
+	struct ttc_timer *timer = &to_ttc_timer_clksrc(cs)->ttc;
 
 	return (cycle_t)__raw_readl(timer->base_addr +
-				XTTCPS_COUNT_VAL_OFFSET);
+				TTC_COUNT_VAL_OFFSET);
 }
 
 /**
- * xttcps_set_next_event - Sets the time interval for next event
+ * ttc_set_next_event - Sets the time interval for next event
  *
  * @cycles:	Timer interval ticks
  * @evt:	Address of clock event instance
  *
  * returns: Always 0 - success
  **/
-static int xttcps_set_next_event(unsigned long cycles,
+static int ttc_set_next_event(unsigned long cycles,
 					struct clock_event_device *evt)
 {
-	struct xttcps_timer_clockevent *xttce = to_xttcps_timer_clkevent(evt);
-	struct xttcps_timer *timer = &xttce->xttc;
+	struct ttc_timer_clockevent *ttce = to_ttc_timer_clkevent(evt);
+	struct ttc_timer *timer = &ttce->ttc;
 
-	xttcps_set_interval(timer, cycles);
+	ttc_set_interval(timer, cycles);
 	return 0;
 }
 
 /**
- * xttcps_set_mode - Sets the mode of timer
+ * ttc_set_mode - Sets the mode of timer
  *
  * @mode:	Mode to be set
  * @evt:	Address of clock event instance
  **/
-static void xttcps_set_mode(enum clock_event_mode mode,
+static void ttc_set_mode(enum clock_event_mode mode,
 					struct clock_event_device *evt)
 {
-	struct xttcps_timer_clockevent *xttce = to_xttcps_timer_clkevent(evt);
-	struct xttcps_timer *timer = &xttce->xttc;
+	struct ttc_timer_clockevent *ttce = to_ttc_timer_clkevent(evt);
+	struct ttc_timer *timer = &ttce->ttc;
 	u32 ctrl_reg;
 
 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
-		xttcps_set_interval(timer,
-				DIV_ROUND_CLOSEST(clk_get_rate(xttce->xttc.clk),
+		ttc_set_interval(timer,
+				DIV_ROUND_CLOSEST(clk_get_rate(ttce->ttc.clk),
 					PRESCALE * HZ));
 		break;
 	case CLOCK_EVT_MODE_ONESHOT:
 	case CLOCK_EVT_MODE_UNUSED:
 	case CLOCK_EVT_MODE_SHUTDOWN:
 		ctrl_reg = __raw_readl(timer->base_addr +
-					XTTCPS_CNT_CNTRL_OFFSET);
-		ctrl_reg |= XTTCPS_CNT_CNTRL_DISABLE_MASK;
+					TTC_CNT_CNTRL_OFFSET);
+		ctrl_reg |= TTC_CNT_CNTRL_DISABLE_MASK;
 		__raw_writel(ctrl_reg,
-				timer->base_addr + XTTCPS_CNT_CNTRL_OFFSET);
+				timer->base_addr + TTC_CNT_CNTRL_OFFSET);
 		break;
 	case CLOCK_EVT_MODE_RESUME:
 		ctrl_reg = __raw_readl(timer->base_addr +
-					XTTCPS_CNT_CNTRL_OFFSET);
-		ctrl_reg &= ~XTTCPS_CNT_CNTRL_DISABLE_MASK;
+					TTC_CNT_CNTRL_OFFSET);
+		ctrl_reg &= ~TTC_CNT_CNTRL_DISABLE_MASK;
 		__raw_writel(ctrl_reg,
-				timer->base_addr + XTTCPS_CNT_CNTRL_OFFSET);
+				timer->base_addr + TTC_CNT_CNTRL_OFFSET);
 		break;
 	}
 }
 
-static int xttcps_rate_change_clocksource_cb(struct notifier_block *nb,
+static int ttc_rate_change_clocksource_cb(struct notifier_block *nb,
 		unsigned long event, void *data)
 {
 	struct clk_notifier_data *ndata = data;
-	struct xttcps_timer *xttcps = to_xttcps_timer(nb);
-	struct xttcps_timer_clocksource *xttccs = container_of(xttcps,
-			struct xttcps_timer_clocksource, xttc);
+	struct ttc_timer *ttc = to_ttc_timer(nb);
+	struct ttc_timer_clocksource *ttccs = container_of(ttc,
+			struct ttc_timer_clocksource, ttc);
 
 	switch (event) {
 	case POST_RATE_CHANGE:
@@ -236,8 +236,8 @@ static int xttcps_rate_change_clocksource_cb(struct notifier_block *nb,
 		 * one unregister call, but only trigger one clocksource switch
 		 * for the cost of another HW timer used by the OS.
 		 */
-		clocksource_unregister(&xttccs->cs);
-		clocksource_register_hz(&xttccs->cs,
+		clocksource_unregister(&ttccs->cs);
+		clocksource_register_hz(&ttccs->cs,
 				ndata->new_rate / PRESCALE);
 		/* fall through */
 	case PRE_RATE_CHANGE:
@@ -247,34 +247,34 @@ static int xttcps_rate_change_clocksource_cb(struct notifier_block *nb,
 	}
 }
 
-static void __init xttc_setup_clocksource(struct clk *clk, void __iomem *base)
+static void __init ttc_setup_clocksource(struct clk *clk, void __iomem *base)
 {
-	struct xttcps_timer_clocksource *ttccs;
+	struct ttc_timer_clocksource *ttccs;
 	int err;
 
 	ttccs = kzalloc(sizeof(*ttccs), GFP_KERNEL);
 	if (WARN_ON(!ttccs))
 		return;
 
-	ttccs->xttc.clk = clk;
+	ttccs->ttc.clk = clk;
 
-	err = clk_prepare_enable(ttccs->xttc.clk);
+	err = clk_prepare_enable(ttccs->ttc.clk);
 	if (WARN_ON(err)) {
 		kfree(ttccs);
 		return;
 	}
 
-	ttccs->xttc.clk_rate_change_nb.notifier_call =
-		xttcps_rate_change_clocksource_cb;
-	ttccs->xttc.clk_rate_change_nb.next = NULL;
-	if (clk_notifier_register(ttccs->xttc.clk,
-				&ttccs->xttc.clk_rate_change_nb))
+	ttccs->ttc.clk_rate_change_nb.notifier_call =
+		ttc_rate_change_clocksource_cb;
+	ttccs->ttc.clk_rate_change_nb.next = NULL;
+	if (clk_notifier_register(ttccs->ttc.clk,
+				&ttccs->ttc.clk_rate_change_nb))
 		pr_warn("Unable to register clock notifier.\n");
 
-	ttccs->xttc.base_addr = base;
-	ttccs->cs.name = "xttcps_clocksource";
+	ttccs->ttc.base_addr = base;
+	ttccs->cs.name = "ttc_clocksource";
 	ttccs->cs.rating = 200;
-	ttccs->cs.read = __xttc_clocksource_read;
+	ttccs->cs.read = __ttc_clocksource_read;
 	ttccs->cs.mask = CLOCKSOURCE_MASK(16);
 	ttccs->cs.flags = CLOCK_SOURCE_IS_CONTINUOUS;
 
@@ -283,27 +283,27 @@ static void __init xttc_setup_clocksource(struct clk *clk, void __iomem *base)
 	 * with no interrupt and it rolls over at 0xFFFF. Pre-scale
 	 * it by 32 also. Let it start running now.
 	 */
-	__raw_writel(0x0,  ttccs->xttc.base_addr + XTTCPS_IER_OFFSET);
+	__raw_writel(0x0,  ttccs->ttc.base_addr + TTC_IER_OFFSET);
 	__raw_writel(CLK_CNTRL_PRESCALE | CLK_CNTRL_PRESCALE_EN,
-		     ttccs->xttc.base_addr + XTTCPS_CLK_CNTRL_OFFSET);
+		     ttccs->ttc.base_addr + TTC_CLK_CNTRL_OFFSET);
 	__raw_writel(CNT_CNTRL_RESET,
-		     ttccs->xttc.base_addr + XTTCPS_CNT_CNTRL_OFFSET);
+		     ttccs->ttc.base_addr + TTC_CNT_CNTRL_OFFSET);
 
 	err = clocksource_register_hz(&ttccs->cs,
-			clk_get_rate(ttccs->xttc.clk) / PRESCALE);
+			clk_get_rate(ttccs->ttc.clk) / PRESCALE);
 	if (WARN_ON(err)) {
 		kfree(ttccs);
 		return;
 	}
 }
 
-static int xttcps_rate_change_clockevent_cb(struct notifier_block *nb,
+static int ttc_rate_change_clockevent_cb(struct notifier_block *nb,
 		unsigned long event, void *data)
 {
 	struct clk_notifier_data *ndata = data;
-	struct xttcps_timer *xttcps = to_xttcps_timer(nb);
-	struct xttcps_timer_clockevent *xttcce = container_of(xttcps,
-			struct xttcps_timer_clockevent, xttc);
+	struct ttc_timer *ttc = to_ttc_timer(nb);
+	struct ttc_timer_clockevent *ttcce = container_of(ttc,
+			struct ttc_timer_clockevent, ttc);
 
 	switch (event) {
 	case POST_RATE_CHANGE:
@@ -317,7 +317,7 @@ static int xttcps_rate_change_clockevent_cb(struct notifier_block *nb,
 		 * cores.
 		 */
 		local_irq_save(flags);
-		clockevents_update_freq(&xttcce->ce,
+		clockevents_update_freq(&ttcce->ce,
 				ndata->new_rate / PRESCALE);
 		local_irq_restore(flags);
 
@@ -330,36 +330,36 @@ static int xttcps_rate_change_clockevent_cb(struct notifier_block *nb,
 	}
 }
 
-static void __init xttc_setup_clockevent(struct clk *clk,
+static void __init ttc_setup_clockevent(struct clk *clk,
 						void __iomem *base, u32 irq)
 {
-	struct xttcps_timer_clockevent *ttcce;
+	struct ttc_timer_clockevent *ttcce;
 	int err;
 
 	ttcce = kzalloc(sizeof(*ttcce), GFP_KERNEL);
 	if (WARN_ON(!ttcce))
 		return;
 
-	ttcce->xttc.clk = clk;
+	ttcce->ttc.clk = clk;
 
-	err = clk_prepare_enable(ttcce->xttc.clk);
+	err = clk_prepare_enable(ttcce->ttc.clk);
 	if (WARN_ON(err)) {
 		kfree(ttcce);
 		return;
 	}
 
-	ttcce->xttc.clk_rate_change_nb.notifier_call =
-		xttcps_rate_change_clockevent_cb;
-	ttcce->xttc.clk_rate_change_nb.next = NULL;
-	if (clk_notifier_register(ttcce->xttc.clk,
-				&ttcce->xttc.clk_rate_change_nb))
+	ttcce->ttc.clk_rate_change_nb.notifier_call =
+		ttc_rate_change_clockevent_cb;
+	ttcce->ttc.clk_rate_change_nb.next = NULL;
+	if (clk_notifier_register(ttcce->ttc.clk,
+				&ttcce->ttc.clk_rate_change_nb))
 		pr_warn("Unable to register clock notifier.\n");
 
-	ttcce->xttc.base_addr = base;
-	ttcce->ce.name = "xttcps_clockevent";
+	ttcce->ttc.base_addr = base;
+	ttcce->ce.name = "ttc_clockevent";
 	ttcce->ce.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
-	ttcce->ce.set_next_event = xttcps_set_next_event;
-	ttcce->ce.set_mode = xttcps_set_mode;
+	ttcce->ce.set_next_event = ttc_set_next_event;
+	ttcce->ce.set_mode = ttc_set_mode;
 	ttcce->ce.rating = 200;
 	ttcce->ce.irq = irq;
 	ttcce->ce.cpumask = cpu_possible_mask;
@@ -369,12 +369,12 @@ static void __init xttc_setup_clockevent(struct clk *clk,
 	 * is prescaled by 32 using the interval interrupt. Leave it
 	 * disabled for now.
 	 */
-	__raw_writel(0x23, ttcce->xttc.base_addr + XTTCPS_CNT_CNTRL_OFFSET);
+	__raw_writel(0x23, ttcce->ttc.base_addr + TTC_CNT_CNTRL_OFFSET);
 	__raw_writel(CLK_CNTRL_PRESCALE | CLK_CNTRL_PRESCALE_EN,
-		     ttcce->xttc.base_addr + XTTCPS_CLK_CNTRL_OFFSET);
-	__raw_writel(0x1,  ttcce->xttc.base_addr + XTTCPS_IER_OFFSET);
+		     ttcce->ttc.base_addr + TTC_CLK_CNTRL_OFFSET);
+	__raw_writel(0x1,  ttcce->ttc.base_addr + TTC_IER_OFFSET);
 
-	err = request_irq(irq, xttcps_clock_event_interrupt,
+	err = request_irq(irq, ttc_clock_event_interrupt,
 			  IRQF_DISABLED | IRQF_TIMER,
 			  ttcce->ce.name, ttcce);
 	if (WARN_ON(err)) {
@@ -383,16 +383,16 @@ static void __init xttc_setup_clockevent(struct clk *clk,
 	}
 
 	clockevents_config_and_register(&ttcce->ce,
-			clk_get_rate(ttcce->xttc.clk) / PRESCALE, 1, 0xfffe);
+			clk_get_rate(ttcce->ttc.clk) / PRESCALE, 1, 0xfffe);
 }
 
 /**
- * xttcps_timer_init - Initialize the timer
+ * ttc_timer_init - Initialize the timer
  *
  * Initializes the timer hardware and register the clock source and clock event
  * timers with Linux kernal timer framework
  */
-static void __init xttcps_timer_init(struct device_node *timer)
+static void __init ttc_timer_init(struct device_node *timer)
 {
 	unsigned int irq;
 	void __iomem *timer_baseaddr;
@@ -427,10 +427,10 @@ static void __init xttcps_timer_init(struct device_node *timer)
 		BUG();
 	}
 
-	xttc_setup_clocksource(clk, timer_baseaddr);
-	xttc_setup_clockevent(clk, timer_baseaddr + 4, irq);
+	ttc_setup_clocksource(clk, timer_baseaddr);
+	ttc_setup_clockevent(clk, timer_baseaddr + 4, irq);
 
 	pr_info("%s #0 at %p, irq=%d\n", timer->name, timer_baseaddr, irq);
 }
 
-CLOCKSOURCE_OF_DECLARE(ttc, "cdns,ttc", xttcps_timer_init);
+CLOCKSOURCE_OF_DECLARE(ttc, "cdns,ttc", ttc_timer_init);
-- 
1.7.9.7
