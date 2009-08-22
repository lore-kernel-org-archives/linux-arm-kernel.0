From: mikpe@it.uu.se (Mikael Pettersson)
Date: Sat, 22 Aug 2009 14:05:29 +0200 (MEST)
Subject: [RFC/RFT 2/3] iop: clockevent support
Message-ID: <200908221205.n7MC5Trg029367@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This updates the IOP platform to expose the interrupting
timer 0 as a clockevent object. The timer interrupt handler
is changed to call the clockevent ->event_handler() instead
of timer_tick(), and ->set_next_event() and ->set_mode()
operations are added to allow the mode of the timer to be
updated (required for ONESHOT/NOHZ mode).

Timer 0 must now be properly initialised, which requires a
new write_tcr0() function from the mach implementation code.

Initial setup of timer 0 is also rewritten to be more robust.

On concern I have is whether the clockevent .shift
value of 20 is appropriate for timer frequencies in the
200/266/333 MHz range which seem to be typical for IOP.

Another concern I have is what the exact state changes needed
for CLK_EVT_MODE_ONESHOT and ->set_next_event are. Right now I
disable the timer both for CLK_EVT_MODE_ONESHOT and at the start
of ->set_next_event. One of these may be redundant.

Tested on n2100, compile-tested for all plat-iop machines.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
---
 arch/arm/Kconfig                          |    1 
 arch/arm/include/asm/hardware/iop3xx.h    |    5 +
 arch/arm/mach-iop13xx/include/mach/time.h |    5 +
 arch/arm/plat-iop/time.c                  |   82 ++++++++++++++++++++++++++----
 4 files changed, 84 insertions(+), 9 deletions(-)

diff -rupN linux-2.6.31-rc7.arm-iop-1-clocksource/arch/arm/Kconfig linux-2.6.31-rc7.arm-iop-2-clockevents/arch/arm/Kconfig
--- linux-2.6.31-rc7.arm-iop-1-clocksource/arch/arm/Kconfig	2009-08-22 11:13:37.000000000 +0200
+++ linux-2.6.31-rc7.arm-iop-2-clockevents/arch/arm/Kconfig	2009-08-22 12:07:52.000000000 +0200
@@ -736,6 +736,7 @@ config ARCH_ACORN
 
 config PLAT_IOP
 	bool
+	select GENERIC_CLOCKEVENTS
 
 config PLAT_ORION
 	bool
diff -rupN linux-2.6.31-rc7.arm-iop-1-clocksource/arch/arm/include/asm/hardware/iop3xx.h linux-2.6.31-rc7.arm-iop-2-clockevents/arch/arm/include/asm/hardware/iop3xx.h
--- linux-2.6.31-rc7.arm-iop-1-clocksource/arch/arm/include/asm/hardware/iop3xx.h	2009-08-22 12:06:28.000000000 +0200
+++ linux-2.6.31-rc7.arm-iop-2-clockevents/arch/arm/include/asm/hardware/iop3xx.h	2009-08-22 12:07:52.000000000 +0200
@@ -252,6 +252,11 @@ static inline u32 read_tcr0(void)
 	return val;
 }
 
+static inline void write_tcr0(u32 val)
+{
+	asm volatile("mcr p6, 0, %0, c2, c1, 0" : : "r" (val));
+}
+
 static inline u32 read_tcr1(void)
 {
 	u32 val;
diff -rupN linux-2.6.31-rc7.arm-iop-1-clocksource/arch/arm/mach-iop13xx/include/mach/time.h linux-2.6.31-rc7.arm-iop-2-clockevents/arch/arm/mach-iop13xx/include/mach/time.h
--- linux-2.6.31-rc7.arm-iop-1-clocksource/arch/arm/mach-iop13xx/include/mach/time.h	2009-08-22 12:06:28.000000000 +0200
+++ linux-2.6.31-rc7.arm-iop-2-clockevents/arch/arm/mach-iop13xx/include/mach/time.h	2009-08-22 12:07:52.000000000 +0200
@@ -83,6 +83,11 @@ static inline u32 read_tcr0(void)
 	return val;
 }
 
+static inline void write_tcr0(u32 val)
+{
+	asm volatile("mcr p6, 0, %0, c2, c9, 0" : : "r" (val));
+}
+
 static inline u32 read_tcr1(void)
 {
 	u32 val;
diff -rupN linux-2.6.31-rc7.arm-iop-1-clocksource/arch/arm/plat-iop/time.c linux-2.6.31-rc7.arm-iop-2-clockevents/arch/arm/plat-iop/time.c
--- linux-2.6.31-rc7.arm-iop-1-clocksource/arch/arm/plat-iop/time.c	2009-08-22 12:06:28.000000000 +0200
+++ linux-2.6.31-rc7.arm-iop-2-clockevents/arch/arm/plat-iop/time.c	2009-08-22 12:07:52.000000000 +0200
@@ -20,6 +20,7 @@
 #include <linux/timex.h>
 #include <linux/io.h>
 #include <linux/clocksource.h>
+#include <linux/clockchips.h>
 #include <mach/hardware.h>
 #include <asm/irq.h>
 #include <asm/uaccess.h>
@@ -44,7 +45,63 @@ static struct clocksource iop_clocksourc
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
+/*
+ * IOP clockevents (interrupting timer 0).
+ */
+static int iop_set_next_event(unsigned long delta,
+			      struct clock_event_device *unused)
+{
+	u32 tmr = IOP_TMR_EN | IOP_TMR_PRIVILEGED
+		| IOP_TMR_RELOAD | IOP_TMR_RATIO_1_1;
+
+	BUG_ON(delta == 0);
+	write_tmr0(tmr & ~(IOP_TMR_EN | IOP_TMR_RELOAD));
+	write_tcr0(delta);
+	write_tmr0((tmr & ~IOP_TMR_RELOAD) | IOP_TMR_EN);
+
+	return 0;
+}
+
 static unsigned long ticks_per_jiffy;
+
+static void iop_set_mode(enum clock_event_mode mode,
+			 struct clock_event_device *unused)
+{
+	u32 tmr = IOP_TMR_EN | IOP_TMR_PRIVILEGED
+		| IOP_TMR_RELOAD | IOP_TMR_RATIO_1_1;
+
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		write_tmr0(tmr & ~IOP_TMR_EN);
+		write_tcr0(ticks_per_jiffy - 1);
+		tmr |= (IOP_TMR_RELOAD | IOP_TMR_EN);
+		break;
+	case CLOCK_EVT_MODE_ONESHOT:
+		/* ->set_next_event sets period and enables timer */
+		tmr &= ~(IOP_TMR_RELOAD | IOP_TMR_EN);
+		break;
+	case CLOCK_EVT_MODE_RESUME:
+		tmr |= IOP_TMR_EN;
+		break;
+	case CLOCK_EVT_MODE_SHUTDOWN:
+	case CLOCK_EVT_MODE_UNUSED:
+	default:
+		tmr &= ~IOP_TMR_EN;
+		break;
+	}
+
+	write_tmr0(tmr);
+}
+
+static struct clock_event_device iop_clockevent = {
+	.name		= "iop_timer0",
+	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
+	.rating         = 300,
+	.shift		= 20,	/* ??? crude guesstimate */
+	.set_next_event	= iop_set_next_event,
+	.set_mode	= iop_set_mode,
+};
+
 static unsigned long ticks_per_usec;
 static unsigned long next_jiffy_time;
 
@@ -75,13 +132,12 @@ unsigned long iop_gettimeoffset(void)
 static irqreturn_t
 iop_timer_interrupt(int irq, void *dev_id)
 {
+	struct clock_event_device *evt;
+
 	write_tisr(1);
 
-	while ((signed long)(next_jiffy_time - read_tcr1())
-		>= ticks_per_jiffy) {
-		timer_tick();
-		next_jiffy_time -= ticks_per_jiffy;
-	}
+	evt = &iop_clockevent;
+	evt->event_handler(evt);
 
 	return IRQ_HANDLED;
 }
@@ -112,10 +168,20 @@ void __init iop_init_time(unsigned long 
 			IOP_TMR_RELOAD | IOP_TMR_RATIO_1_1;
 
 	/*
-	 * We use timer 0 for our timer interrupt, and timer 1 as
-	 * monotonic counter for tracking missed jiffies.
+	 * Set up interrupting clockevent timer 0.
 	 */
+	write_tmr0(timer_ctl & ~IOP_TMR_EN);
+	setup_irq(IRQ_IOP_TIMER0, &iop_timer_irq);
+	iop_clockevent.mult =
+		div_sc(tick_rate, NSEC_PER_SEC, iop_clockevent.shift);
+	iop_clockevent.max_delta_ns =
+		clockevent_delta2ns(0xfffffffe, &iop_clockevent);
+	iop_clockevent.min_delta_ns =
+		clockevent_delta2ns(0xf, &iop_clockevent);
+	iop_clockevent.cpumask = cpumask_of(0);
+	clockevents_register_device(&iop_clockevent);
 	write_trr0(ticks_per_jiffy - 1);
+	write_tcr0(ticks_per_jiffy - 1);
 	write_tmr0(timer_ctl);
 
 	/*
@@ -128,6 +194,4 @@ void __init iop_init_time(unsigned long 
 		clocksource_hz2mult(tick_rate,
 				    iop_clocksource.shift);
 	clocksource_register(&iop_clocksource);
-
-	setup_irq(IRQ_IOP_TIMER0, &iop_timer_irq);
 }
