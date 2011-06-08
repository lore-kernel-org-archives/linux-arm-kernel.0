From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Wed, 8 Jun 2011 09:01:14 +0200
Subject: [PATCH,RFC] mmp clockevent handling race
In-Reply-To: <BANLkTi=MhX97=pXTFfJfO8=E=2Q98YdC6A@mail.gmail.com>
References: <20110607140456.GE11275@wantstofly.org>
	<alpine.LFD.2.00.1106071416230.2142@xanadu.home>
	<1307499937.8890.2.camel@Lily>
	<BANLkTi=MhX97=pXTFfJfO8=E=2Q98YdC6A@mail.gmail.com>
Message-ID: <20110608070114.GG11275@wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2011 at 11:05:39AM +0800, Eric Miao wrote:

> >> > The patch below has been sitting around in the OLPC XO-1.75 (MMP2-based
> >> > XO) bringup kernel tree for some time now, and upon recent rebasing of
> >> > this tree to 3.0, it was discovered that something like this patch is
> >> > still needed.
> >> >
> >> > Symptoms: e.g. as described here: http://dev.laptop.org/ticket/10945
> >> > -- applications hang for a couple of minutes at a time, and sometimes
> >> > there are several-minute hangs during the boot process.
> >> >
> >> > >From the ticket:
> >> >
> >> > ? ? The problem in the current upstream mmp timer handling code
> >> > ? ? that appears to be triggered here is that it handles clockevents
> >> > ? ? by setting up a comparator on the free-running clocksource timer
> >> > ? ? to match and trigger an interrupt at 'current_time + delta',
> >> > ? ? which if delta is small enough can lead to 'current_time + delta'
> >> > ? ? already being in the past when comparator setup has finished,
> >> > ? ? and the requested event will not trigger.
> >>
> >> This is a classical issue that was solved on the SA1100 more than 10
> >> years ago.
> >>
> >> > What this patch does is to rewrite the timer handling code to use
> >> > two timers, one for the free-running clocksource, and one to trigger
> >> > clockevents with, which is more or less the standard approach to this.
> >> > It's kind of invasive, though (certainly more invasive than it strictly
> >> > needs to be, as it reorganises time.c somewhat at the same time), and
> >> > something like this is probably too invasive for 3.0 at this point.
> >> >
> >> > A safer "fix" for 3.0 may be to disallow NO_HZ/HIGH_RES_TIMERS on mmp.
> >> >
> >> > Any thoughts?
> >>
> >> What about simply this:
> >>
> >> diff --git a/arch/arm/mach-mmp/time.c b/arch/arm/mach-mmp/time.c
> >> index 99833b9..8b8f99a 100644
> >> --- a/arch/arm/mach-mmp/time.c
> >> +++ b/arch/arm/mach-mmp/time.c
> >> @@ -39,7 +39,7 @@
> >>
> >> ?#define TIMERS_VIRT_BASE ? ? TIMERS1_VIRT_BASE
> >>
> >> -#define MAX_DELTA ? ? ? ? ? ?(0xfffffffe)
> >> +#define MAX_DELTA ? ? ? ? ? ?(0xfffffffe - 16)
> >> ?#define MIN_DELTA ? ? ? ? ? ?(16)
> >>
> >> ?static DEFINE_CLOCK_DATA(cd);
> >> @@ -85,7 +85,7 @@ static irqreturn_t timer_interrupt(int irq, void *dev_id)
> >> ?static int timer_set_next_event(unsigned long delta,
> >> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct clock_event_device *dev)
> >> ?{
> >> - ? ? unsigned long flags, next;
> >> + ? ? unsigned long flags, next, now;
> >>
> >> ? ? ? local_irq_save(flags);
> >>
> >> @@ -95,9 +95,10 @@ static int timer_set_next_event(unsigned long delta,
> >>
> >> ? ? ? next = timer_read() + delta;
> >> ? ? ? __raw_writel(next, TIMERS_VIRT_BASE + TMR_TN_MM(0, 0));
> >> + ? ? now = timer_read();
> >>
> >> ? ? ? local_irq_restore(flags);
> >> - ? ? return 0;
> >> + ? ? return (signed)(next - now) <= MIN_DELTA ? -ETIME : 0;
> >> ?}
> >>
> >> ?static void timer_set_mode(enum clock_event_mode mode,
> >>
> >>
> >> Nicolas
> > It seems good. But we still need to use two different timer. Because
> > writing match register needs to stop counter register first. This is a
> > limitation in the silicon.
> 
> Well, the first thing is Lennert's RFC patch needs a bit cleanup :-)
> I tried very hard to figure out the actual changes.

The diff indeed looks somewhat confusing -- it makes more sense if
you look at the final thing (below).


> Using two timers isn't a bad idea. Yet if it has to disable timer0 when
> modifying timer1's next triggering event, it doesn't seem to solve the
> real problem with two timers.

This isn't needed -- timer A can keep running as clocksource timer while
timer B is used as a clockevent timer and stopped and restarted all the
time.  (In my version, timer 0 is used as clockevent timer and timer 1
as clocksource timer, but this can be done either way 'round of course.)

If there's consensus that this is the right way to go, I'll split the
patch up into logical bits.


thanks,
Lennert



/*
 * linux/arch/arm/mach-mmp/time.c
 *
 *   Support for clocksource and clockevents
 *
 * Copyright (C) 2008 Marvell International Ltd.
 * All rights reserved.
 *
 *   2008-04-11: Jason Chagas <Jason.chagas@marvell.com>
 *   2008-10-08: Bin Yang <bin.yang@marvell.com>
 *
 * The timers module actually includes three timers, each timer with up to
 * three match comparators. Timer #0 is used here in free-running mode as
 * the clock source, and match comparator #1 used as clock event device.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 */

#include <linux/init.h>
#include <linux/kernel.h>
#include <linux/interrupt.h>
#include <linux/clockchips.h>
#include <linux/io.h>
#include <linux/irq.h>
#include <linux/sched.h>
#include <asm/sched_clock.h>
#include <mach/addr-map.h>
#include <mach/regs-timers.h>
#include <mach/regs-apbc.h>
#include <mach/irqs.h>
#include <mach/cputype.h>
#include <asm/mach/time.h>
#include "clock.h"

#define TIMERS_VIRT_BASE	TIMERS1_VIRT_BASE


/*
 * MMP sched_clock implementation.
 */
static DEFINE_CLOCK_DATA(cd);

static inline uint32_t mmp_timer_read(void)
{
	unsigned long flags;
	int delay;
	u32 val;

	raw_local_irq_save(flags);

	__raw_writel(1, TIMERS_VIRT_BASE + TMR_CVWR(1));

	delay = 100;
	while (delay--)
		cpu_relax();

	val = __raw_readl(TIMERS_VIRT_BASE + TMR_CVWR(1));

	raw_local_irq_restore(flags);

	return val;
}

unsigned long long notrace sched_clock(void)
{
	u32 cyc = mmp_timer_read();
	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
}

static void notrace mmp_update_sched_clock(void)
{
	u32 cyc = mmp_timer_read();
	update_sched_clock(&cd, cyc, (u32)~0);
}


/*
 * MMP clocksource implementation.
 */
static cycle_t mmp_clksrc_read(struct clocksource *cs)
{
	return mmp_timer_read();
}

static struct clocksource mmp_cksrc = {
	.name		= "clocksource",
	.rating		= 200,
	.read		= mmp_clksrc_read,
	.mask		= CLOCKSOURCE_MASK(32),
	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
};


/*
 * MMP clockevent implementation.
 */
static u32 ticks_per_jiffy;

static void mmp_arm_timer0(u32 value)
{
	unsigned long flags;

	local_irq_save(flags);

	/*
	 * Disable timer 0.
	 */
	__raw_writel(0x02, TIMERS_VIRT_BASE + TMR_CER);

	/*
	 * Clear and enable timer match 0 interrupt.
	 */
	__raw_writel(0x01, TIMERS_VIRT_BASE + TMR_ICR(0));
	__raw_writel(0x01, TIMERS_VIRT_BASE + TMR_IER(0));

	/*
	 * Setup new clockevent timer value.
	 */
	__raw_writel(value, TIMERS_VIRT_BASE + TMR_TN_MM(0, 0));

	/*
	 * Enable timer 0.
	 */
	__raw_writel(0x03, TIMERS_VIRT_BASE + TMR_CER);

	local_irq_restore(flags);
}

static int mmp_timer_set_next_event(unsigned long delta,
				    struct clock_event_device *dev)
{
	mmp_arm_timer0(delta);

	return 0;
}

static void
mmp_timer_set_mode(enum clock_event_mode mode, struct clock_event_device *dev)
{
	if (mode == CLOCK_EVT_MODE_PERIODIC) {
		printk(KERN_INFO "setting periodic mode\n");
		mmp_arm_timer0(ticks_per_jiffy - 1);
	} else {
		printk(KERN_INFO "setting oneshot mode\n");

		/*
		 * Disable timer 0.
		 */
		__raw_writel(0x02, TIMERS_VIRT_BASE + TMR_CER);

		/*
		 * Clear and disable timer 0 match interrupts.
		 */
		__raw_writel(0x01, TIMERS_VIRT_BASE + TMR_ICR(0));
		__raw_writel(0x00, TIMERS_VIRT_BASE + TMR_IER(0));
	}
}

static struct clock_event_device mmp_ckevt = {
	.name		= "mmp_clockevent",
	.features	= CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC,
	.shift		= 32,
	.rating		= 300,
	.set_next_event	= mmp_timer_set_next_event,
	.set_mode	= mmp_timer_set_mode,
};

static irqreturn_t timer_interrupt(int irq, void *dev_id)
{
	/*
	 * Clear pending interrupt status.
	 */
	__raw_writel(0x01, TIMERS_VIRT_BASE + TMR_ICR(0));

	/*
	 * Disable timer 0 if we are in one-shot mode.
	 */
	if (mmp_ckevt.mode != CLOCK_EVT_MODE_PERIODIC)
		__raw_writel(0x02, TIMERS_VIRT_BASE + TMR_CER);

	mmp_ckevt.event_handler(&mmp_ckevt);

	return IRQ_HANDLED;
}

static struct irqaction timer_irq = {
	.name		= "timer",
	.flags		= IRQF_DISABLED | IRQF_TIMER,
	.handler	= timer_interrupt,
};


static void __init configure_timers(void)
{
	/*
	 * Disable timers 0 and 1.
	 */
	__raw_writel(0, TIMERS_VIRT_BASE + TMR_CER);

	/*
	 * Have timers 0 and 1 run off the configurable clock (6.5 MHz).
	 */
	__raw_writel(TMR_CCR_CS_0(0) | TMR_CCR_CS_1(0),
	             TIMERS_VIRT_BASE + TMR_CCR);

	/*
	 * Set timer 0 to periodic mode, timer 1 to free-running mode.
	 */
	__raw_writel(0x02, TIMERS_VIRT_BASE + TMR_CMR);

	/*
	 * Set timer 0 to preload from match register 0, timer 1
	 * to free-running mode.
	 */
	__raw_writel(0x01, TIMERS_VIRT_BASE + TMR_PLCR(0));
	__raw_writel(0x00, TIMERS_VIRT_BASE + TMR_PLCR(1));

	/*
	 * Set preload values to zero.
	 */
	__raw_writel(0, TIMERS_VIRT_BASE + TMR_PLVR(0));
	__raw_writel(0, TIMERS_VIRT_BASE + TMR_PLVR(1));

	/*
	 * Clear interrupt status.
	 */
	__raw_writel(0x07, TIMERS_VIRT_BASE + TMR_ICR(0));
	__raw_writel(0x07, TIMERS_VIRT_BASE + TMR_ICR(1));

	/*
	 * Disable interrupt enables.
	 */
	__raw_writel(0x00, TIMERS_VIRT_BASE + TMR_IER(0));
	__raw_writel(0x00, TIMERS_VIRT_BASE + TMR_IER(1));

	/*
	 * Enable timer 1.
	 */
	__raw_writel(0x02, TIMERS_VIRT_BASE + TMR_CER);
}

void __init timer_init(int irq)
{
	configure_timers();

	init_sched_clock(&cd, mmp_update_sched_clock, 32, CLOCK_TICK_RATE);

	clocksource_register_hz(&mmp_cksrc, CLOCK_TICK_RATE);

	ticks_per_jiffy = (CLOCK_TICK_RATE + HZ/2) / HZ;

	mmp_ckevt.mult = div_sc(CLOCK_TICK_RATE, NSEC_PER_SEC, mmp_ckevt.shift);
	mmp_ckevt.max_delta_ns = clockevent_delta2ns(0xfffffffe, &mmp_ckevt);
	mmp_ckevt.min_delta_ns = clockevent_delta2ns(16, &mmp_ckevt);
	mmp_ckevt.cpumask = cpumask_of(0);
	clockevents_register_device(&mmp_ckevt);

	setup_irq(irq, &timer_irq);
}
