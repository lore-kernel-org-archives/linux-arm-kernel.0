From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 May 2011 18:31:56 +0100
Subject: [PATCH 19/19] ARM: bcmring: convert to use sp804 clockevents
In-Reply-To: <20110516172334.GD13659@n2100.arm.linux.org.uk>
References: <20110516172334.GD13659@n2100.arm.linux.org.uk>
Message-ID: <E1QM1e8-0003ET-HK@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

bcmring has a set of four sp804 timers incorporated, yet it has its
own copy of the sp804 code.  Convert its clockevent implementation
to the standard sp804 support code.

Cc: Jiandong Zheng <jdzheng@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-bcmring/core.c |  118 +++---------------------------------------
 1 files changed, 8 insertions(+), 110 deletions(-)

diff --git a/arch/arm/mach-bcmring/core.c b/arch/arm/mach-bcmring/core.c
index 0ea33ff..c323ae9 100644
--- a/arch/arm/mach-bcmring/core.c
+++ b/arch/arm/mach-bcmring/core.c
@@ -28,8 +28,6 @@
 #include <linux/sysdev.h>
 #include <linux/interrupt.h>
 #include <linux/amba/bus.h>
-#include <linux/clocksource.h>
-#include <linux/clockchips.h>
 #include <linux/clkdev.h>
 
 #include <mach/csp/mm_addr.h>
@@ -113,8 +111,8 @@ static struct clk dummy_apb_pclk = {
 #define TIMER3_FREQUENCY_KHZ  (tmrHw_HIGH_FREQUENCY_HZ / 1000)
 #endif
 
-static struct clk sp804_timer1_clk = {
-	.name = "sp804-timer-1",
+static struct clk sp804_timer012_clk = {
+	.name = "sp804-timer-0,1,2",
 	.type = CLK_TYPE_PRIMARY,
 	.mode = CLK_MODE_XTAL,
 	.rate_hz = TIMER1_FREQUENCY_MHZ * 1000000,
@@ -137,10 +135,14 @@ static struct clk_lookup lookups[] = {
 	}, {			/* UART1 */
 		.dev_id = "uartb",
 		.clk = &uart_clk,
+	}, {			/* SP804 timer 0 */
+		.dev_id = "sp804",
+		.con_id = "timer0",
+		.clk = &sp804_timer012_clk,
 	}, {			/* SP804 timer 1 */
 		.dev_id = "sp804",
 		.con_id = "timer1",
-		.clk = &sp804_timer1_clk,
+		.clk = &sp804_timer012_clk,
 	}, {			/* SP804 timer 3 */
 		.dev_id = "sp804",
 		.con_id = "timer3",
@@ -205,100 +207,6 @@ void __init bcmring_amba_init(void)
 #define TIMER2_VA_BASE		((void __iomem *)(MM_IO_BASE_TMR + 0x40))
 #define TIMER3_VA_BASE          ((void __iomem *)(MM_IO_BASE_TMR + 0x60))
 
-#define TICKS_PER_uSEC     TIMER0_FREQUENCY_MHZ
-
-/*
- *  These are useconds NOT ticks.
- *
- */
-#define mSEC_1                          1000
-#define mSEC_10                         (mSEC_1 * 10)
-
-/*
- * How long is the timer interval?
- */
-#define TIMER_INTERVAL	(TICKS_PER_uSEC * mSEC_10)
-#if TIMER_INTERVAL >= 0x100000
-#define TIMER_RELOAD	(TIMER_INTERVAL >> 8)
-#define TIMER_DIVISOR	(TIMER_CTRL_DIV256)
-#define TICKS2USECS(x)	(256 * (x) / TICKS_PER_uSEC)
-#elif TIMER_INTERVAL >= 0x10000
-#define TIMER_RELOAD	(TIMER_INTERVAL >> 4)	/* Divide by 16 */
-#define TIMER_DIVISOR	(TIMER_CTRL_DIV16)
-#define TICKS2USECS(x)	(16 * (x) / TICKS_PER_uSEC)
-#else
-#define TIMER_RELOAD	(TIMER_INTERVAL)
-#define TIMER_DIVISOR	(TIMER_CTRL_DIV1)
-#define TICKS2USECS(x)	((x) / TICKS_PER_uSEC)
-#endif
-
-static void timer_set_mode(enum clock_event_mode mode,
-			   struct clock_event_device *clk)
-{
-	unsigned long ctrl;
-
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		writel(TIMER_RELOAD, TIMER0_VA_BASE + TIMER_LOAD);
-
-		ctrl = TIMER_CTRL_PERIODIC;
-		ctrl |=
-		    TIMER_DIVISOR | TIMER_CTRL_32BIT | TIMER_CTRL_IE |
-		    TIMER_CTRL_ENABLE;
-		break;
-	case CLOCK_EVT_MODE_ONESHOT:
-		/* period set, and timer enabled in 'next_event' hook */
-		ctrl = TIMER_CTRL_ONESHOT;
-		ctrl |= TIMER_DIVISOR | TIMER_CTRL_32BIT | TIMER_CTRL_IE;
-		break;
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_SHUTDOWN:
-	default:
-		ctrl = 0;
-	}
-
-	writel(ctrl, TIMER0_VA_BASE + TIMER_CTRL);
-}
-
-static int timer_set_next_event(unsigned long evt,
-				struct clock_event_device *unused)
-{
-	unsigned long ctrl = readl(TIMER0_VA_BASE + TIMER_CTRL);
-
-	writel(evt, TIMER0_VA_BASE + TIMER_LOAD);
-	writel(ctrl | TIMER_CTRL_ENABLE, TIMER0_VA_BASE + TIMER_CTRL);
-
-	return 0;
-}
-
-static struct clock_event_device timer0_clockevent = {
-	.name = "timer0",
-	.shift = 32,
-	.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
-	.set_mode = timer_set_mode,
-	.set_next_event = timer_set_next_event,
-};
-
-/*
- * IRQ handler for the timer
- */
-static irqreturn_t bcmring_timer_interrupt(int irq, void *dev_id)
-{
-	struct clock_event_device *evt = &timer0_clockevent;
-
-	writel(1, TIMER0_VA_BASE + TIMER_INTCLR);
-
-	evt->event_handler(evt);
-
-	return IRQ_HANDLED;
-}
-
-static struct irqaction bcmring_timer_irq = {
-	.name = "bcmring Timer Tick",
-	.flags = IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
-	.handler = bcmring_timer_interrupt,
-};
-
 static int __init bcmring_clocksource_init(void)
 {
 	/* setup timer1 as free-running clocksource */
@@ -327,19 +235,9 @@ void __init bcmring_init_timer(void)
 	/*
 	 * Make irqs happen for the system timer
 	 */
-	setup_irq(IRQ_TIMER0, &bcmring_timer_irq);
-
 	bcmring_clocksource_init();
 
-	timer0_clockevent.mult =
-	    div_sc(1000000, NSEC_PER_SEC, timer0_clockevent.shift);
-	timer0_clockevent.max_delta_ns =
-	    clockevent_delta2ns(0xffffffff, &timer0_clockevent);
-	timer0_clockevent.min_delta_ns =
-	    clockevent_delta2ns(0xf, &timer0_clockevent);
-
-	timer0_clockevent.cpumask = cpumask_of(0);
-	clockevents_register_device(&timer0_clockevent);
+	sp804_clockevents_register(TIMER0_VA_BASE, IRQ_TIMER0, "timer0");
 }
 
 struct sys_timer bcmring_timer = {
-- 
1.7.4.4
