From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 15 Jun 2015 15:50:19 +0200
Subject: [PATCH 2/5] ARM: ep93xx: switch to GENERIC_CLOCKEVENTS
In-Reply-To: <1434376222-4587-1-git-send-email-linus.walleij@linaro.org>
References: <1434376222-4587-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1434376222-4587-3-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This switches the EP93xx to use GENERIC_CLOCKEVENTS and
CLKSRC_MMIO. Also implements a sched_clock() hook.
Tested on the SIM.ONE. Use only oneshot events.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/Kconfig                    |   3 +-
 arch/arm/mach-ep93xx/timer-ep93xx.c | 110 +++++++++++++++++++++++-------------
 2 files changed, 72 insertions(+), 41 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 45df48ba0b12..3938ea082367 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -420,11 +420,12 @@ config ARCH_EP93XX
 	bool "EP93xx-based"
 	select ARCH_HAS_HOLES_MEMORYMODEL
 	select ARCH_REQUIRE_GPIOLIB
-	select ARCH_USES_GETTIMEOFFSET
 	select ARM_AMBA
 	select ARM_VIC
 	select CLKDEV_LOOKUP
+	select CLKSRC_MMIO
 	select CPU_ARM920T
+	select GENERIC_CLOCKEVENTS
 	help
 	  This enables support for the Cirrus EP93xx series of CPUs.
 
diff --git a/arch/arm/mach-ep93xx/timer-ep93xx.c b/arch/arm/mach-ep93xx/timer-ep93xx.c
index 978252c52661..932236b348bc 100644
--- a/arch/arm/mach-ep93xx/timer-ep93xx.c
+++ b/arch/arm/mach-ep93xx/timer-ep93xx.c
@@ -1,5 +1,8 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/clocksource.h>
+#include <linux/clockchips.h>
+#include <linux/sched_clock.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/io.h>
@@ -45,26 +48,68 @@
 #define EP93XX_TIMER3_CONTROL		EP93XX_TIMER_REG(0x88)
 #define EP93XX_TIMER3_CLEAR		EP93XX_TIMER_REG(0x8c)
 
-#define EP93XX_TIMER123_CLOCK		508469
-#define EP93XX_TIMER4_CLOCK		983040
+#define EP93XX_TIMER123_RATE		508469
+#define EP93XX_TIMER4_RATE		983040
 
-#define TIMER1_RELOAD			((EP93XX_TIMER123_CLOCK / HZ) - 1)
-#define TIMER4_TICKS_PER_JIFFY		DIV_ROUND_CLOSEST(EP93XX_TIMER4_CLOCK, HZ)
+static u64 notrace ep93xx_read_sched_clock(void)
+{
+	u64 ret;
+
+	ret = __raw_readl(EP93XX_TIMER4_VALUE_LOW);
+	ret |= ((u64) (__raw_readl(EP93XX_TIMER4_VALUE_HIGH) & 0xff) << 32);
+	return ret;
+}
+
+cycle_t ep93xx_clocksource_read(struct clocksource *c)
+{
+	u64 ret;
+
+	ret = __raw_readl(EP93XX_TIMER4_VALUE_LOW);
+	ret |= ((u64) (__raw_readl(EP93XX_TIMER4_VALUE_HIGH) & 0xff) << 32);
+	return (cycle_t) ret;
+}
+
+static int ep93xx_clkevt_set_next_event(unsigned long next,
+					struct clock_event_device *evt)
+{
+	/* Default mode: periodic, off, 508 kHz */
+	u32 tmode = EP93XX_TIMER123_CONTROL_MODE |
+		    EP93XX_TIMER123_CONTROL_CLKSEL;
+
+	/* Clear timer */
+	__raw_writel(tmode, EP93XX_TIMER1_CONTROL);
+
+	/* Set next event */
+	__raw_writel(next, EP93XX_TIMER1_LOAD);
+	__raw_writel(tmode | EP93XX_TIMER123_CONTROL_ENABLE,
+		     EP93XX_TIMER1_CONTROL);
+        return 0;
+}
 
-static unsigned int last_jiffy_time;
+
+static void ep93xx_clkevt_set_mode(enum clock_event_mode mode,
+				   struct clock_event_device *evt)
+{
+	/* Disable timer */
+	__raw_writel(0, EP93XX_TIMER1_CONTROL);
+}
+
+static struct clock_event_device ep93xx_clockevent = {
+	.name		= "timer1",
+	.features	= CLOCK_EVT_FEAT_ONESHOT,
+	.set_mode	= ep93xx_clkevt_set_mode,
+	.set_next_event	= ep93xx_clkevt_set_next_event,
+	.rating		= 300,
+};
 
 static irqreturn_t ep93xx_timer_interrupt(int irq, void *dev_id)
 {
+	struct clock_event_device *evt = dev_id;
+
 	/* Writing any value clears the timer interrupt */
 	__raw_writel(1, EP93XX_TIMER1_CLEAR);
 
-	/* Recover lost jiffies */
-	while ((signed long)
-		(__raw_readl(EP93XX_TIMER4_VALUE_LOW) - last_jiffy_time)
-						>= TIMER4_TICKS_PER_JIFFY) {
-		last_jiffy_time += TIMER4_TICKS_PER_JIFFY;
-		timer_tick();
-	}
+	evt->event_handler(evt);
 
 	return IRQ_HANDLED;
 }
@@ -73,40 +118,25 @@ static struct irqaction ep93xx_timer_irq = {
 	.name		= "ep93xx timer",
 	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
 	.handler	= ep93xx_timer_interrupt,
+	.dev_id		= &ep93xx_clockevent,
 };
 
-static u32 ep93xx_gettimeoffset(void)
-{
-	int offset;
-
-	offset = __raw_readl(EP93XX_TIMER4_VALUE_LOW) - last_jiffy_time;
-
-	/*
-	 * Timer 4 is based on a 983.04 kHz reference clock,
-	 * so dividing by 983040 gives the fraction of a second,
-	 * so dividing by 0.983040 converts to uS.
-	 * Refactor the calculation to avoid overflow.
-	 * Finally, multiply by 1000 to give nS.
-	 */
-	return (offset + (53 * offset / 3072)) * 1000;
-}
-
 void __init ep93xx_timer_init(void)
 {
-	u32 tmode = EP93XX_TIMER123_CONTROL_MODE |
-		    EP93XX_TIMER123_CONTROL_CLKSEL;
-
-	arch_gettimeoffset = ep93xx_gettimeoffset;
-
-	/* Enable periodic HZ timer.  */
-	__raw_writel(tmode, EP93XX_TIMER1_CONTROL);
-	__raw_writel(TIMER1_RELOAD, EP93XX_TIMER1_LOAD);
-	__raw_writel(tmode | EP93XX_TIMER123_CONTROL_ENABLE,
-			EP93XX_TIMER1_CONTROL);
-
-	/* Enable lost jiffy timer.  */
+	/* Enable and register clocksource and sched_clock on timer 4 */
 	__raw_writel(EP93XX_TIMER4_VALUE_HIGH_ENABLE,
 			EP93XX_TIMER4_VALUE_HIGH);
+	clocksource_mmio_init(NULL, "timer4",
+			      EP93XX_TIMER4_RATE, 200, 40,
+			      ep93xx_clocksource_read);
+	sched_clock_register(ep93xx_read_sched_clock, 40,
+			     EP93XX_TIMER4_RATE);
 
+	/* Set up clockevent on timer 1 */
 	setup_irq(IRQ_EP93XX_TIMER1, &ep93xx_timer_irq);
+	// FIXME: timer one is 16 bits 1-ffff use timer 3 1-ffffffff */
+	clockevents_config_and_register(&ep93xx_clockevent,
+					EP93XX_TIMER123_RATE,
+					1,
+					0xffffU);
 }
-- 
1.9.3
