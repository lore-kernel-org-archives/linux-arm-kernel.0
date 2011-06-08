From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Wed, 8 Jun 2011 10:25:46 +0800
Subject: [PATCH,RFC] mmp clockevent handling race
In-Reply-To: <20110607140456.GE11275@wantstofly.org>
References: <20110607140456.GE11275@wantstofly.org>
Message-ID: <1307499946.8890.3.camel@Lily>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-06-07 at 07:04 -0700, Lennert Buytenhek wrote:
> Hi!
> 
> The patch below has been sitting around in the OLPC XO-1.75 (MMP2-based
> XO) bringup kernel tree for some time now, and upon recent rebasing of
> this tree to 3.0, it was discovered that something like this patch is
> still needed.
> 
> Symptoms: e.g. as described here: http://dev.laptop.org/ticket/10945
> -- applications hang for a couple of minutes at a time, and sometimes
> there are several-minute hangs during the boot process.
> 
> From the ticket:
> 
> 	The problem in the current upstream mmp timer handling code
> 	that appears to be triggered here is that it handles clockevents
> 	by setting up a comparator on the free-running clocksource timer
> 	to match and trigger an interrupt at 'current_time + delta',
> 	which if delta is small enough can lead to 'current_time + delta'
> 	already being in the past when comparator setup has finished,
> 	and the requested event will not trigger. 
> 
> What this patch does is to rewrite the timer handling code to use
> two timers, one for the free-running clocksource, and one to trigger
> clockevents with, which is more or less the standard approach to this.
> It's kind of invasive, though (certainly more invasive than it strictly
> needs to be, as it reorganises time.c somewhat at the same time), and
> something like this is probably too invasive for 3.0 at this point.
> 
> A safer "fix" for 3.0 may be to disallow NO_HZ/HIGH_RES_TIMERS on mmp.
> 
> Any thoughts?
> 
> 
> thanks,
> Lennert
> 
> 
> Signed-off-by: Lennert Buytenhek <buytenh@laptop.org>
> 
> diff --git a/arch/arm/mach-mmp/time.c b/arch/arm/mach-mmp/time.c
> index 99833b9..853c9a6 100644
> --- a/arch/arm/mach-mmp/time.c
> +++ b/arch/arm/mach-mmp/time.c
> @@ -22,11 +22,9 @@
>  #include <linux/kernel.h>
>  #include <linux/interrupt.h>
>  #include <linux/clockchips.h>
> -
>  #include <linux/io.h>
>  #include <linux/irq.h>
>  #include <linux/sched.h>
> -
>  #include <asm/sched_clock.h>
>  #include <mach/addr-map.h>
>  #include <mach/regs-timers.h>
> @@ -34,156 +32,230 @@
>  #include <mach/irqs.h>
>  #include <mach/cputype.h>
>  #include <asm/mach/time.h>
> -
>  #include "clock.h"
>  
>  #define TIMERS_VIRT_BASE	TIMERS1_VIRT_BASE
>  
> -#define MAX_DELTA		(0xfffffffe)
> -#define MIN_DELTA		(16)
> -
> -static DEFINE_CLOCK_DATA(cd);
>  
>  /*
> - * FIXME: the timer needs some delay to stablize the counter capture
> + * MMP sched_clock implementation.
>   */
> -static inline uint32_t timer_read(void)
> +static DEFINE_CLOCK_DATA(cd);
> +
> +static inline uint32_t mmp_timer_read(void)
>  {
> -	int delay = 100;
> +	unsigned long flags;
> +	int delay;
> +	u32 val;
>  
> -	__raw_writel(1, TIMERS_VIRT_BASE + TMR_CVWR(0));
> +	raw_local_irq_save(flags);
>  
> +	__raw_writel(1, TIMERS_VIRT_BASE + TMR_CVWR(1));
> +
> +	delay = 100;
>  	while (delay--)
>  		cpu_relax();
>  
> -	return __raw_readl(TIMERS_VIRT_BASE + TMR_CVWR(0));
> +	val = __raw_readl(TIMERS_VIRT_BASE + TMR_CVWR(1));
> +
> +	raw_local_irq_restore(flags);
> +
> +	return val;
>  }
>  
>  unsigned long long notrace sched_clock(void)
>  {
> -	u32 cyc = timer_read();
> +	u32 cyc = mmp_timer_read();
>  	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
>  }
>  
>  static void notrace mmp_update_sched_clock(void)
>  {
> -	u32 cyc = timer_read();
> +	u32 cyc = mmp_timer_read();
>  	update_sched_clock(&cd, cyc, (u32)~0);
>  }
>  
> -static irqreturn_t timer_interrupt(int irq, void *dev_id)
> -{
> -	struct clock_event_device *c = dev_id;
>  
> -	/* disable and clear pending interrupt status */
> -	__raw_writel(0x0, TIMERS_VIRT_BASE + TMR_IER(0));
> -	__raw_writel(0x1, TIMERS_VIRT_BASE + TMR_ICR(0));
> -	c->event_handler(c);
> -	return IRQ_HANDLED;
> +/*
> + * MMP clocksource implementation.
> + */
> +static cycle_t mmp_clksrc_read(struct clocksource *cs)
> +{
> +	return mmp_timer_read();
>  }
>  
> -static int timer_set_next_event(unsigned long delta,
> -				struct clock_event_device *dev)
> +static struct clocksource mmp_cksrc = {
> +	.name		= "clocksource",
> +	.rating		= 200,
> +	.read		= mmp_clksrc_read,
> +	.mask		= CLOCKSOURCE_MASK(32),
> +	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
> +};
> +
> +
> +/*
> + * MMP clockevent implementation.
> + */
> +static u32 ticks_per_jiffy;
> +
> +static void mmp_arm_timer0(u32 value)
>  {
> -	unsigned long flags, next;
> +	unsigned long flags;
>  
>  	local_irq_save(flags);
>  
> -	/* clear pending interrupt status and enable */
> +	/*
> +	 * Disable timer 0.
> +	 */
> +	__raw_writel(0x02, TIMERS_VIRT_BASE + TMR_CER);
> +
> +	/*
> +	 * Clear and enable timer match 0 interrupt.
> +	 */
>  	__raw_writel(0x01, TIMERS_VIRT_BASE + TMR_ICR(0));
>  	__raw_writel(0x01, TIMERS_VIRT_BASE + TMR_IER(0));
>  
> -	next = timer_read() + delta;
> -	__raw_writel(next, TIMERS_VIRT_BASE + TMR_TN_MM(0, 0));
> +	/*
> +	 * Setup new clockevent timer value.
> +	 */
> +	__raw_writel(value, TIMERS_VIRT_BASE + TMR_TN_MM(0, 0));
> +
> +	/*
> +	 * Enable timer 0.
> +	 */
> +	__raw_writel(0x03, TIMERS_VIRT_BASE + TMR_CER);
>  
>  	local_irq_restore(flags);
> -	return 0;
>  }
>  
> -static void timer_set_mode(enum clock_event_mode mode,
> -			   struct clock_event_device *dev)
> +static int mmp_timer_set_next_event(unsigned long delta,
> +				    struct clock_event_device *dev)
>  {
> -	unsigned long flags;
> +	mmp_arm_timer0(delta);
>  
> -	local_irq_save(flags);
> -	switch (mode) {
> -	case CLOCK_EVT_MODE_ONESHOT:
> -	case CLOCK_EVT_MODE_UNUSED:
> -	case CLOCK_EVT_MODE_SHUTDOWN:
> -		/* disable the matching interrupt */
> -		__raw_writel(0x00, TIMERS_VIRT_BASE + TMR_IER(0));
> -		break;
> -	case CLOCK_EVT_MODE_RESUME:
> -	case CLOCK_EVT_MODE_PERIODIC:
> -		break;
> -	}
> -	local_irq_restore(flags);
> +	return 0;
>  }
>  
> -static struct clock_event_device ckevt = {
> -	.name		= "clockevent",
> -	.features	= CLOCK_EVT_FEAT_ONESHOT,
> -	.shift		= 32,
> -	.rating		= 200,
> -	.set_next_event	= timer_set_next_event,
> -	.set_mode	= timer_set_mode,
> -};
> -
> -static cycle_t clksrc_read(struct clocksource *cs)
> +static void
> +mmp_timer_set_mode(enum clock_event_mode mode, struct clock_event_device *dev)
>  {
> -	return timer_read();
> +	if (mode == CLOCK_EVT_MODE_PERIODIC) {
> +		printk(KERN_INFO "setting periodic mode\n");
> +		mmp_arm_timer0(ticks_per_jiffy - 1);
> +	} else {
> +		printk(KERN_INFO "setting oneshot mode\n");
> +
> +		/*
> +		 * Disable timer 0.
> +		 */
> +		__raw_writel(0x02, TIMERS_VIRT_BASE + TMR_CER);
> +
> +		/*
> +		 * Clear and disable timer 0 match interrupts.
> +		 */
> +		__raw_writel(0x01, TIMERS_VIRT_BASE + TMR_ICR(0));
> +		__raw_writel(0x00, TIMERS_VIRT_BASE + TMR_IER(0));
> +	}
>  }
>  
> -static struct clocksource cksrc = {
> -	.name		= "clocksource",
> -	.rating		= 200,
> -	.read		= clksrc_read,
> -	.mask		= CLOCKSOURCE_MASK(32),
> -	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
> +static struct clock_event_device mmp_ckevt = {
> +	.name		= "mmp_clockevent",
> +	.features	= CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC,
> +	.shift		= 32,
> +	.rating		= 300,
> +	.set_next_event	= mmp_timer_set_next_event,
> +	.set_mode	= mmp_timer_set_mode,
>  };
>  
> -static void __init timer_config(void)
> +static irqreturn_t timer_interrupt(int irq, void *dev_id)
>  {
> -	uint32_t ccr = __raw_readl(TIMERS_VIRT_BASE + TMR_CCR);
> -	uint32_t cer = __raw_readl(TIMERS_VIRT_BASE + TMR_CER);
> -	uint32_t cmr = __raw_readl(TIMERS_VIRT_BASE + TMR_CMR);
> -
> -	__raw_writel(cer & ~0x1, TIMERS_VIRT_BASE + TMR_CER); /* disable */
> -
> -	ccr &= (cpu_is_mmp2()) ? TMR_CCR_CS_0(0) : TMR_CCR_CS_0(3);
> -	__raw_writel(ccr, TIMERS_VIRT_BASE + TMR_CCR);
> +	/*
> +	 * Clear pending interrupt status.
> +	 */
> +	__raw_writel(0x01, TIMERS_VIRT_BASE + TMR_ICR(0));
>  
> -	/* free-running mode */
> -	__raw_writel(cmr | 0x01, TIMERS_VIRT_BASE + TMR_CMR);
> +	/*
> +	 * Disable timer 0 if we are in one-shot mode.
> +	 */
> +	if (mmp_ckevt.mode != CLOCK_EVT_MODE_PERIODIC)
> +		__raw_writel(0x02, TIMERS_VIRT_BASE + TMR_CER);
>  
> -	__raw_writel(0x0, TIMERS_VIRT_BASE + TMR_PLCR(0)); /* free-running */
> -	__raw_writel(0x7, TIMERS_VIRT_BASE + TMR_ICR(0));  /* clear status */
> -	__raw_writel(0x0, TIMERS_VIRT_BASE + TMR_IER(0));
> +	mmp_ckevt.event_handler(&mmp_ckevt);
>  
> -	/* enable timer counter */
> -	__raw_writel(cer | 0x01, TIMERS_VIRT_BASE + TMR_CER);
> +	return IRQ_HANDLED;
>  }
>  
>  static struct irqaction timer_irq = {
>  	.name		= "timer",
> -	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
> +	.flags		= IRQF_DISABLED | IRQF_TIMER,
>  	.handler	= timer_interrupt,
> -	.dev_id		= &ckevt,
>  };
>  
> +
> +static void __init configure_timers(void)
> +{
> +	/*
> +	 * Disable timers 0 and 1.
> +	 */
> +	__raw_writel(0, TIMERS_VIRT_BASE + TMR_CER);
> +
> +	/*
> +	 * Have timers 0 and 1 run off the configurable clock (6.5 MHz).
> +	 */
> +	__raw_writel(TMR_CCR_CS_0(0) | TMR_CCR_CS_1(0),
> +	             TIMERS_VIRT_BASE + TMR_CCR);
> +
> +	/*
> +	 * Set timer 0 to periodic mode, timer 1 to free-running mode.
> +	 */
> +	__raw_writel(0x02, TIMERS_VIRT_BASE + TMR_CMR);
> +
> +	/*
> +	 * Set timer 0 to preload from match register 0, timer 1
> +	 * to free-running mode.
> +	 */
> +	__raw_writel(0x01, TIMERS_VIRT_BASE + TMR_PLCR(0));
> +	__raw_writel(0x00, TIMERS_VIRT_BASE + TMR_PLCR(1));
> +
> +	/*
> +	 * Set preload values to zero.
> +	 */
> +	__raw_writel(0, TIMERS_VIRT_BASE + TMR_PLVR(0));
> +	__raw_writel(0, TIMERS_VIRT_BASE + TMR_PLVR(1));
> +
> +	/*
> +	 * Clear interrupt status.
> +	 */
> +	__raw_writel(0x07, TIMERS_VIRT_BASE + TMR_ICR(0));
> +	__raw_writel(0x07, TIMERS_VIRT_BASE + TMR_ICR(1));
> +
> +	/*
> +	 * Disable interrupt enables.
> +	 */
> +	__raw_writel(0x00, TIMERS_VIRT_BASE + TMR_IER(0));
> +	__raw_writel(0x00, TIMERS_VIRT_BASE + TMR_IER(1));
> +
> +	/*
> +	 * Enable timer 1.
> +	 */
> +	__raw_writel(0x02, TIMERS_VIRT_BASE + TMR_CER);
> +}
> +
>  void __init timer_init(int irq)
>  {
> -	timer_config();
> +	configure_timers();
>  
>  	init_sched_clock(&cd, mmp_update_sched_clock, 32, CLOCK_TICK_RATE);
>  
> -	ckevt.mult = div_sc(CLOCK_TICK_RATE, NSEC_PER_SEC, ckevt.shift);
> -	ckevt.max_delta_ns = clockevent_delta2ns(MAX_DELTA, &ckevt);
> -	ckevt.min_delta_ns = clockevent_delta2ns(MIN_DELTA, &ckevt);
> -	ckevt.cpumask = cpumask_of(0);
> +	clocksource_register_hz(&mmp_cksrc, CLOCK_TICK_RATE);
>  
> -	setup_irq(irq, &timer_irq);
> +	ticks_per_jiffy = (CLOCK_TICK_RATE + HZ/2) / HZ;
> +
> +	mmp_ckevt.mult = div_sc(CLOCK_TICK_RATE, NSEC_PER_SEC, mmp_ckevt.shift);
> +	mmp_ckevt.max_delta_ns = clockevent_delta2ns(0xfffffffe, &mmp_ckevt);
> +	mmp_ckevt.min_delta_ns = clockevent_delta2ns(16, &mmp_ckevt);
> +	mmp_ckevt.cpumask = cpumask_of(0);
> +	clockevents_register_device(&mmp_ckevt);
>  
> -	clocksource_register_hz(&cksrc, CLOCK_TICK_RATE);
> -	clockevents_register_device(&ckevt);
> +	setup_irq(irq, &timer_irq);
>  }
