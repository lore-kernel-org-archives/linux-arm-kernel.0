From: burman.yan@gmail.com (Yan Burman)
Date: Sun, 19 Aug 2012 23:00:44 +0300
Subject: [PATCH v2] ARM: ep93xx: clockevent support
Message-ID: <1345406444.20237.7.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: ep93xx: clockevent support
I have ported to 3.6-rc2 and slightly modified a previous patch for clockevent support for the ep93xx.
The porting mainly consists of sched_clock support + CLKSRC_MMIO usage.
Tested on 9302 based board.

Changes from v1:
* Number of cosmetic style fixes
* Use CLKSRC_MMIO

From: Ahmed Ammar <aammar <at> edge-techno.com>
Signed-off-by: Yan Burman <burman.yan@gmail.com>

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e91c7cd..b1d0b11 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -451,7 +451,8 @@ config ARCH_EP93XX
 	select CLKDEV_LOOKUP
 	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_HAS_HOLES_MEMORYMODEL
-	select ARCH_USES_GETTIMEOFFSET
+	select GENERIC_CLOCKEVENTS
+	select CLKSRC_MMIO
 	select NEED_MACH_MEMORY_H
 	help
 	  This enables support for the Cirrus EP93xx series of CPUs.
diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 4afe52a..f59a849 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -30,6 +30,8 @@
 #include <linux/amba/bus.h>
 #include <linux/amba/serial.h>
 #include <linux/mtd/physmap.h>
+#include <linux/clocksource.h>
+#include <linux/clockchips.h>
 #include <linux/i2c.h>
 #include <linux/i2c-gpio.h>
 #include <linux/spi/spi.h>
@@ -43,6 +45,7 @@
 
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
+#include <asm/sched_clock.h>
 
 #include <asm/hardware/vic.h>
 
@@ -114,63 +117,114 @@ void __init ep93xx_map_io(void)
 #define EP93XX_TIMER4_CLOCK		983040
 
 #define TIMER1_RELOAD			((EP93XX_TIMER123_CLOCK / HZ) - 1)
-#define TIMER4_TICKS_PER_JIFFY		DIV_ROUND_CLOSEST(CLOCK_TICK_RATE, HZ)
-
-static unsigned int last_jiffy_time;
 
 static irqreturn_t ep93xx_timer_interrupt(int irq, void *dev_id)
 {
+	struct clock_event_device *evt = dev_id;
+
 	/* Writing any value clears the timer interrupt */
 	__raw_writel(1, EP93XX_TIMER1_CLEAR);
-
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
 
+static int ep93xx_set_next_event(unsigned long evt,
+				struct clock_event_device *unused)
+{
+	u32 tmode = __raw_readl(EP93XX_TIMER1_CONTROL);
+
+	/* stop timer */
+	__raw_writel(tmode & ~EP93XX_TIMER123_CONTROL_ENABLE,
+			EP93XX_TIMER1_CONTROL);
+	/* program timer */
+	__raw_writel(evt, EP93XX_TIMER1_LOAD);
+	/* start timer */
+	__raw_writel(tmode | EP93XX_TIMER123_CONTROL_ENABLE,
+			EP93XX_TIMER1_CONTROL);
+
+	return 0;
+}
+
+static void ep93xx_set_mode(enum clock_event_mode mode,
+			    struct clock_event_device *evt)
+{
+	u32 tmode = EP93XX_TIMER123_CONTROL_CLKSEL;
+
+	/* Disable timer */
+	__raw_writel(tmode, EP93XX_TIMER1_CONTROL);
+
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		/* Set timer period  */
+		__raw_writel(TIMER1_RELOAD, EP93XX_TIMER1_LOAD);
+		tmode |= EP93XX_TIMER123_CONTROL_MODE;
+		/* fall through */
+
+	case CLOCK_EVT_MODE_ONESHOT:
+		tmode |= EP93XX_TIMER123_CONTROL_ENABLE;
+		__raw_writel(tmode, EP93XX_TIMER1_CONTROL);
+		break;
+
+	case CLOCK_EVT_MODE_SHUTDOWN:
+	case CLOCK_EVT_MODE_UNUSED:
+	case CLOCK_EVT_MODE_RESUME:
+		break;
+	}
+}
+
+static struct clock_event_device ep93xx_clockevent = {
+	.name		= "ep93xx-timer1",
+	.features	= CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC,
+	.shift		= 32,
+	.set_mode	= ep93xx_set_mode,
+	.set_next_event	= ep93xx_set_next_event,
+};
+
 static struct irqaction ep93xx_timer_irq = {
 	.name		= "ep93xx timer",
 	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
 	.handler	= ep93xx_timer_interrupt,
+	.dev_id		= &ep93xx_clockevent,
 };
 
-static void __init ep93xx_timer_init(void)
+static void __init ep93xx_clockevent_init(void)
 {
-	u32 tmode = EP93XX_TIMER123_CONTROL_MODE |
-		    EP93XX_TIMER123_CONTROL_CLKSEL;
+	struct clock_event_device *evt = &ep93xx_clockevent;
 
-	/* Enable periodic HZ timer.  */
-	__raw_writel(tmode, EP93XX_TIMER1_CONTROL);
-	__raw_writel(TIMER1_RELOAD, EP93XX_TIMER1_LOAD);
-	__raw_writel(tmode | EP93XX_TIMER123_CONTROL_ENABLE,
-			EP93XX_TIMER1_CONTROL);
-
-	/* Enable lost jiffy timer.  */
-	__raw_writel(EP93XX_TIMER4_VALUE_HIGH_ENABLE,
-			EP93XX_TIMER4_VALUE_HIGH);
+	evt->mult = div_sc(EP93XX_TIMER123_CLOCK, NSEC_PER_SEC, evt->shift);
+	evt->max_delta_ns = clockevent_delta2ns(0xfffffffe, evt);
+	evt->min_delta_ns = clockevent_delta2ns(0xf, evt);
+	evt->cpumask = cpumask_of(0);
 
 	setup_irq(IRQ_EP93XX_TIMER1, &ep93xx_timer_irq);
+
+	clockevents_register_device(evt);
 }
 
-static unsigned long ep93xx_gettimeoffset(void)
+static void __init ep93xx_clocksource_init(void)
 {
-	int offset;
+	/* Reset time-stamp counter */
+	__raw_writel(EP93XX_TIMER4_VALUE_HIGH_ENABLE, EP93XX_TIMER4_VALUE_HIGH);
+
+	clocksource_mmio_init(EP93XX_TIMER4_VALUE_LOW, "ep93xx-timer4",
+		CLOCK_TICK_RATE, 200, 32, clocksource_mmio_readl_up);
+}
 
-	offset = __raw_readl(EP93XX_TIMER4_VALUE_LOW) - last_jiffy_time;
+static u32 notrace ep93xx_sched_clock(void)
+{
+	return __raw_readl(EP93XX_TIMER4_VALUE_LOW);
+}
 
-	/* Calculate (1000000 / 983040) * offset.  */
-	return offset + (53 * offset / 3072);
+static void __init ep93xx_timer_init(void)
+{
+	ep93xx_clocksource_init();
+	ep93xx_clockevent_init();
+	setup_sched_clock(ep93xx_sched_clock, 32, CLOCK_TICK_RATE);
 }
 
 struct sys_timer ep93xx_timer = {
 	.init		= ep93xx_timer_init,
-	.offset		= ep93xx_gettimeoffset,
 };
 
 
