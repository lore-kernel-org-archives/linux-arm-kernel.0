From: mikpe@it.uu.se (Mikael Pettersson)
Date: Fri, 16 Oct 2009 23:59:53 +0200
Subject: [PATCH v3 2/4] iop: clockevent support
Message-ID: <19160.60633.681292.712731@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This updates the IOP platform to expose the interrupting
timer 0 as a clockevent object. The timer interrupt handler
is changed to call the clockevent ->event_handler() instead
of timer_tick(), and ->set_next_event() and ->set_mode()
operations are added to allow the mode of the timer to be
updated (required for ONESHOT/NOHZ mode).

Timer 0 must now be properly initialised, which requires
a new write_tcr0() function from the mach-specific code.

The mode of timer 0 must be read at the start of ->set_mode(),
which requires a new read_tmr0() function from the mach-
specific code.

Initial setup of timer 0 is also rewritten to be more robust.

Tested on n2100, compile-tested for all plat-iop machines.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
---
Changes v2 -> v3:
* rebased on 2.6.32-rc5

Changes v1 -> v2:
* rebased on 2.6.31 and v2 of the iop clocksource patch
* replaced static guess for the clockevent .shift value
  with code to compute it at runtime, based on similar
  code used in the mips kernel
* instead of computing &iop_clockevent in iop_timer_interrupt(),
  use the iop_timer_irq.dev_id field to pass &iop_clockevent to
  iop_timer_interrupt() via its dev_id parameter
* add read_tmr0() function to the mach-specific code, use it
  to make iop_set_mode() do a read-modify-write of TMR0 for
  every state change instead of making assumptions about TMR0
* minor cleanup in iop_set_next_event()

 arch/arm/Kconfig                          |    1 
 arch/arm/include/asm/hardware/iop3xx.h    |   12 +++
 arch/arm/mach-iop13xx/include/mach/time.h |   12 +++
 arch/arm/plat-iop/time.c                  |  101 ++++++++++++++++++++++++++----
 4 files changed, 115 insertions(+), 11 deletions(-)

diff -rupN linux-2.6.32-rc5.arm-iop-1-clocksource-v3/arch/arm/Kconfig linux-2.6.32-rc5.arm-iop-2-clockevents-v3/arch/arm/Kconfig
--- linux-2.6.32-rc5.arm-iop-1-clocksource-v3/arch/arm/Kconfig	2009-10-16 12:02:51.000000000 +0200
+++ linux-2.6.32-rc5.arm-iop-2-clockevents-v3/arch/arm/Kconfig	2009-10-16 21:35:42.000000000 +0200
@@ -810,6 +810,7 @@ config ARCH_ACORN
 
 config PLAT_IOP
 	bool
+	select GENERIC_CLOCKEVENTS
 
 config PLAT_ORION
 	bool
diff -rupN linux-2.6.32-rc5.arm-iop-1-clocksource-v3/arch/arm/include/asm/hardware/iop3xx.h linux-2.6.32-rc5.arm-iop-2-clockevents-v3/arch/arm/include/asm/hardware/iop3xx.h
--- linux-2.6.32-rc5.arm-iop-1-clocksource-v3/arch/arm/include/asm/hardware/iop3xx.h	2009-10-16 21:34:27.000000000 +0200
+++ linux-2.6.32-rc5.arm-iop-2-clockevents-v3/arch/arm/include/asm/hardware/iop3xx.h	2009-10-16 21:35:42.000000000 +0200
@@ -236,6 +236,13 @@ void iop_init_cp6_handler(void);
 void iop_init_time(unsigned long tickrate);
 unsigned long iop_gettimeoffset(void);
 
+static inline u32 read_tmr0(void)
+{
+	u32 val;
+	asm volatile("mrc p6, 0, %0, c0, c1, 0" : "=r" (val));
+	return val;
+}
+
 static inline void write_tmr0(u32 val)
 {
 	asm volatile("mcr p6, 0, %0, c0, c1, 0" : : "r" (val));
@@ -253,6 +260,11 @@ static inline u32 read_tcr0(void)
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
diff -rupN linux-2.6.32-rc5.arm-iop-1-clocksource-v3/arch/arm/mach-iop13xx/include/mach/time.h linux-2.6.32-rc5.arm-iop-2-clockevents-v3/arch/arm/mach-iop13xx/include/mach/time.h
--- linux-2.6.32-rc5.arm-iop-1-clocksource-v3/arch/arm/mach-iop13xx/include/mach/time.h	2009-10-16 21:34:27.000000000 +0200
+++ linux-2.6.32-rc5.arm-iop-2-clockevents-v3/arch/arm/mach-iop13xx/include/mach/time.h	2009-10-16 21:35:42.000000000 +0200
@@ -66,6 +66,13 @@ static inline unsigned long iop13xx_xsi_
 	return 2;
 }
 
+static inline u32 read_tmr0(void)
+{
+	u32 val;
+	asm volatile("mrc p6, 0, %0, c0, c9, 0" : "=r" (val));
+	return val;
+}
+
 static inline void write_tmr0(u32 val)
 {
 	asm volatile("mcr p6, 0, %0, c0, c9, 0" : : "r" (val));
@@ -83,6 +90,11 @@ static inline u32 read_tcr0(void)
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
diff -rupN linux-2.6.32-rc5.arm-iop-1-clocksource-v3/arch/arm/plat-iop/time.c linux-2.6.32-rc5.arm-iop-2-clockevents-v3/arch/arm/plat-iop/time.c
--- linux-2.6.32-rc5.arm-iop-1-clocksource-v3/arch/arm/plat-iop/time.c	2009-10-16 21:34:27.000000000 +0200
+++ linux-2.6.32-rc5.arm-iop-2-clockevents-v3/arch/arm/plat-iop/time.c	2009-10-16 21:35:42.000000000 +0200
@@ -20,6 +20,7 @@
 #include <linux/timex.h>
 #include <linux/io.h>
 #include <linux/clocksource.h>
+#include <linux/clockchips.h>
 #include <mach/hardware.h>
 #include <asm/irq.h>
 #include <asm/uaccess.h>
@@ -64,7 +65,81 @@ static void __init iop_clocksource_set_h
 	       cs->name, cs->shift, cs->mult);
 }
 
+/*
+ * IOP clockevents (interrupting timer 0).
+ */
+static int iop_set_next_event(unsigned long delta,
+			      struct clock_event_device *unused)
+{
+	u32 tmr = IOP_TMR_PRIVILEGED | IOP_TMR_RATIO_1_1;
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
+	u32 tmr = read_tmr0();
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
+	.set_next_event	= iop_set_next_event,
+	.set_mode	= iop_set_mode,
+};
+
+static void __init iop_clockevent_set_hz(struct clock_event_device *ce, unsigned int hz)
+{
+	u64 temp;
+	u32 shift;
+
+	/* Find shift and mult values for hz. */
+	shift = 32;
+	do {
+		temp = (u64) hz << shift;
+		do_div(temp, NSEC_PER_SEC);
+		if ((temp >> 32) == 0)
+			break;
+	} while (--shift != 0);
+
+	ce->shift = shift;
+	ce->mult = (u32) temp;
+
+	printk(KERN_INFO "clockevent: %s uses shift %u mult %#lx\n",
+	       ce->name, ce->shift, ce->mult);
+}
+
 static unsigned long ticks_per_usec;
 static unsigned long next_jiffy_time;
 
@@ -95,14 +170,10 @@ unsigned long iop_gettimeoffset(void)
 static irqreturn_t
 iop_timer_interrupt(int irq, void *dev_id)
 {
-	write_tisr(1);
-
-	while ((signed long)(next_jiffy_time - read_tcr1())
-		>= ticks_per_jiffy) {
-		timer_tick();
-		next_jiffy_time -= ticks_per_jiffy;
-	}
+	struct clock_event_device *evt = dev_id;
 
+	write_tisr(1);
+	evt->event_handler(evt);
 	return IRQ_HANDLED;
 }
 
@@ -110,6 +181,7 @@ static struct irqaction iop_timer_irq = 
 	.name		= "IOP Timer Tick",
 	.handler	= iop_timer_interrupt,
 	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.dev_id		= &iop_clockevent,
 };
 
 static unsigned long iop_tick_rate;
@@ -132,10 +204,19 @@ void __init iop_init_time(unsigned long 
 			IOP_TMR_RELOAD | IOP_TMR_RATIO_1_1;
 
 	/*
-	 * We use timer 0 for our timer interrupt, and timer 1 as
-	 * monotonic counter for tracking missed jiffies.
+	 * Set up interrupting clockevent timer 0.
 	 */
+	write_tmr0(timer_ctl & ~IOP_TMR_EN);
+	setup_irq(IRQ_IOP_TIMER0, &iop_timer_irq);
+	iop_clockevent_set_hz(&iop_clockevent, tick_rate);
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
@@ -146,6 +227,4 @@ void __init iop_init_time(unsigned long 
 	write_tmr1(timer_ctl);
 	iop_clocksource_set_hz(&iop_clocksource, tick_rate);
 	clocksource_register(&iop_clocksource);
-
-	setup_irq(IRQ_IOP_TIMER0, &iop_timer_irq);
 }
