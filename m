From: mikpe@it.uu.se (Mikael Pettersson)
Date: Fri, 11 Sep 2009 11:38:35 +0200
Subject: [PATCH RESEND 2.6.31] ixp4xx: timer and clocks cleanups
Message-ID: <19114.6811.800442.888146@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[2nd attempt to send this, we seem to be having major issues
with outgoing email, my apologies if you see this twice]

This patch does a few simple cleanups of the ixp4xx timer
and clocksource/clockevent code in mach-ixp4xx/common.c:

- ixp4xx_clocksource_init() is static and always returns 0,
  which is ignored by its only caller: make it return void
- ixp4xx_clockevent_init(): ditto
- ixp4xx_get_cycles() is only referenced locally: make it static
- use the ixp4xx_timer_irq.dev_id field to pass &clockevent_ixp4xx
  to ixp4xx_timer_interrupt() via its dev_id parameter, allowing
  the code in ixp4xx_timer_interrupt() to be smaller and faster

Tested on an ixp420 machine (ds101).

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
---
 arch/arm/mach-ixp4xx/common.c |   16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff -rupN linux-2.6.31/arch/arm/mach-ixp4xx/common.c linux-2.6.31.arm-ixp4xx-timer-cleanups/arch/arm/mach-ixp4xx/common.c
--- linux-2.6.31/arch/arm/mach-ixp4xx/common.c	2009-06-10 12:00:43.000000000 +0200
+++ linux-2.6.31.arm-ixp4xx-timer-cleanups/arch/arm/mach-ixp4xx/common.c	2009-09-10 23:25:06.000000000 +0200
@@ -41,8 +41,8 @@
 #include <asm/mach/irq.h>
 #include <asm/mach/time.h>
 
-static int __init ixp4xx_clocksource_init(void);
-static int __init ixp4xx_clockevent_init(void);
+static void __init ixp4xx_clocksource_init(void);
+static void __init ixp4xx_clockevent_init(void);
 static struct clock_event_device clockevent_ixp4xx;
 
 /*************************************************************************
@@ -267,7 +267,7 @@ void __init ixp4xx_init_irq(void)
 
 static irqreturn_t ixp4xx_timer_interrupt(int irq, void *dev_id)
 {
-	struct clock_event_device *evt = &clockevent_ixp4xx;
+	struct clock_event_device *evt = dev_id;
 
 	/* Clear Pending Interrupt by writing '1' to it */
 	*IXP4XX_OSST = IXP4XX_OSST_TIMER_1_PEND;
@@ -281,6 +281,7 @@ static struct irqaction ixp4xx_timer_irq
 	.name		= "timer1",
 	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
 	.handler	= ixp4xx_timer_interrupt,
+	.dev_id		= &clockevent_ixp4xx,
 };
 
 void __init ixp4xx_timer_init(void)
@@ -401,7 +402,7 @@ void __init ixp4xx_sys_init(void)
 /*
  * clocksource
  */
-cycle_t ixp4xx_get_cycles(struct clocksource *cs)
+static cycle_t ixp4xx_get_cycles(struct clocksource *cs)
 {
 	return *IXP4XX_OSTS;
 }
@@ -416,14 +417,12 @@ static struct clocksource clocksource_ix
 };
 
 unsigned long ixp4xx_timer_freq = FREQ;
-static int __init ixp4xx_clocksource_init(void)
+static void __init ixp4xx_clocksource_init(void)
 {
 	clocksource_ixp4xx.mult =
 		clocksource_hz2mult(ixp4xx_timer_freq,
 				    clocksource_ixp4xx.shift);
 	clocksource_register(&clocksource_ixp4xx);
-
-	return 0;
 }
 
 /*
@@ -479,7 +478,7 @@ static struct clock_event_device clockev
 	.set_next_event	= ixp4xx_set_next_event,
 };
 
-static int __init ixp4xx_clockevent_init(void)
+static void __init ixp4xx_clockevent_init(void)
 {
 	clockevent_ixp4xx.mult = div_sc(FREQ, NSEC_PER_SEC,
 					clockevent_ixp4xx.shift);
@@ -490,5 +489,4 @@ static int __init ixp4xx_clockevent_init
 	clockevent_ixp4xx.cpumask = cpumask_of(0);
 
 	clockevents_register_device(&clockevent_ixp4xx);
-	return 0;
 }
