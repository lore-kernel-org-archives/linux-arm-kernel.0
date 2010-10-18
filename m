From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 18 Oct 2010 22:24:33 +0100
Subject: [PATCH 2/3] Add hardware timer support for Mindspeed Comcerto
	platflorm
In-Reply-To: <1287045489-1133-3-git-send-email-stanleymiao@gmail.com>
References: <1287045489-1133-1-git-send-email-stanleymiao@gmail.com>
	<1287045489-1133-2-git-send-email-stanleymiao@gmail.com>
	<1287045489-1133-3-git-send-email-stanleymiao@gmail.com>
Message-ID: <20101018212433.GD20376@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 14, 2010 at 04:38:08PM +0800, stanleymiao at gmail.com wrote:
> diff --git a/arch/arm/mach-comcerto/include/mach/system.h b/arch/arm/mach-comcerto/include/mach/system.h
> index 364cc7e..d24914d 100644
> --- a/arch/arm/mach-comcerto/include/mach/system.h
> +++ b/arch/arm/mach-comcerto/include/mach/system.h
> @@ -34,6 +34,9 @@ static inline void arch_idle(void)
>  
>  static inline void arch_reset(char mode, const char *cmd)
>  {
> +	/* use watch dog timer to reset the board */
> +	__raw_writel(0x1, COMCERTO_TIMER_WDT_CONTROL);
> +	__raw_writel(0x1, COMCERTO_TIMER_WDT_HIGH_BOUND);

Ah, so this is why it has an io.h include in the previous patch.

> diff --git a/arch/arm/mach-comcerto/time.c b/arch/arm/mach-comcerto/time.c
> new file mode 100644
> index 0000000..40e3515
> --- /dev/null
> +++ b/arch/arm/mach-comcerto/time.c
> @@ -0,0 +1,227 @@
> +/*
> + * linux/arch/arm/mach-comcerto/time.c
> + *
> + * Copyright (C) 2008 Mindspeed Technologies, Inc.
> + * Copyright (c) 2010 Wind River Systems, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + * See the GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/types.h>
> +#include <linux/interrupt.h>
> +#include <linux/clocksource.h>
> +#include <linux/clockchips.h>
> +#include <linux/io.h>
> +#include <linux/clk.h>
> +#include <linux/irq.h>
> +#include <linux/err.h>
> +
> +#include <mach/hardware.h>
> +#include <asm/mach/time.h>
> +
> +#define TID_CLOCKEVENT	1
> +#define TID_CLOCKSOURCE	3
> +
> +static DEFINE_SPINLOCK(timer_lock);
> +
> +struct comcerto_gptimer {
> +	char *name;

const?

> +	unsigned long id; /* maybe not needed */
> +	unsigned long mask;
> +	unsigned long hbound;
> +	unsigned long lbound;
> +	unsigned long count;
> +};
> +
> +static void gptimer_enable(struct comcerto_gptimer *gptimer)
> +{
> +	unsigned long flags;
> +	unsigned long irq_mask;
> +
> +	spin_lock_irqsave(&timer_lock, flags);
> +	irq_mask = __raw_readl(COMCERTO_TIMER_IRQ_MASK);
> +	irq_mask |= gptimer->mask;
> +	__raw_writel(irq_mask, COMCERTO_TIMER_IRQ_MASK);
> +	spin_unlock_irqrestore(&timer_lock, flags);
> +}
> +
> +static void gptimer_disable(struct comcerto_gptimer *gptimer)
> +{
> +	unsigned long flags;
> +	unsigned long irq_mask;
> +
> +	spin_lock_irqsave(&timer_lock, flags);
> +	irq_mask = __raw_readl(COMCERTO_TIMER_IRQ_MASK);
> +	irq_mask &= ~gptimer->mask;
> +	__raw_writel(irq_mask, COMCERTO_TIMER_IRQ_MASK);
> +	spin_unlock_irqrestore(&timer_lock, flags);
> +}
> +
> +static struct comcerto_gptimer timers[] = {
> +	[TID_CLOCKEVENT] = {
> +		.name	= "timer1",
> +		.id	= TID_CLOCKEVENT,
> +		.mask	= COMCERTO_TIMER1,
> +		.hbound	= COMCERTO_TIMER1_HIGH_BOUND,
> +		.lbound = COMCERTO_TIMER1_LOW_BOUND,
> +		.count = COMCERTO_TIMER1_CURRENT_COUNT,
> +	},
> +	[TID_CLOCKSOURCE] = {
> +		.name	= "timer3",
> +		.id	= TID_CLOCKSOURCE,
> +		.mask	= COMCERTO_TIMER3,
> +		.hbound	= COMCERTO_TIMER3_HIGH_BOUND,
> +		.lbound = COMCERTO_TIMER3_LOW_BOUND,
> +		.count = COMCERTO_TIMER3_CURRENT_COUNT,
> +	},
> +};
> +
> +static void gptimer_set_bound(struct comcerto_gptimer *gptimer,
> +					unsigned low, unsigned high)
> +{
> +	__raw_writel(high, gptimer->hbound);
> +	/* __raw_writel(low, gptimer->lbound); */
> +}
> +
> +static void gptimer_clear_status(struct comcerto_gptimer *gptimer)
> +{
> +	__raw_writel(gptimer->mask, COMCERTO_TIMER_STATUS_CLR);
> +}
> +
> +static unsigned long gptimer_get_current_count(struct comcerto_gptimer *timer)
> +{
> +	return __raw_readl(timer->count);
> +}
> +
> +static int comcerto_set_next_event(unsigned long cycles,
> +					struct clock_event_device *evt)
> +{
> +	struct comcerto_gptimer *t = &timers[TID_CLOCKEVENT];
> +
> +	if (evt->mode == CLOCK_EVT_MODE_ONESHOT)
> +		gptimer_enable(t);
> +	return 0;
> +}
> +
> +static void comcerto_set_mode(enum clock_event_mode mode,
> +				struct clock_event_device *evt)
> +{
> +	struct comcerto_gptimer *t = &timers[TID_CLOCKEVENT];
> +
> +	if (mode != CLOCK_EVT_MODE_PERIODIC)
> +		gptimer_disable(t);
> +	else
> +		gptimer_enable(t);
> +}
> +
> +static struct clock_event_device clockevent = {
> +	.name           = "clockevent",
> +	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
> +	.rating         = 200,
> +	.shift          = 24,
> +	.set_mode       = comcerto_set_mode,
> +	.set_next_event = comcerto_set_next_event,
> +};
> +
> +static cycle_t comcerto_timer3_read(struct clocksource *cs)
> +{
> +	return (cycle_t)gptimer_get_current_count(&timers[TID_CLOCKSOURCE]);
> +}
> +
> +static struct clocksource clocksource = {
> +	.name   = "clocksource",
> +	.rating = 200,
> +	.read   = comcerto_timer3_read,
> +	.mask   = CLOCKSOURCE_MASK(32),
> +	.shift  = 24,
> +	.flags  = CLOCK_SOURCE_IS_CONTINUOUS,
> +};
> +
> +static void __init comcerto_clocksource_init(void)
> +{
> +	struct comcerto_gptimer *t = &timers[TID_CLOCKSOURCE];
> +
> +	gptimer_set_bound(t, 0, 0xffffffff);
> +	clocksource.mult = clocksource_hz2mult(COMCERTO_DEFAULTAHBCLK, clocksource.shift);
> +	if (clocksource_register(&clocksource))
> +		printk(KERN_ERR "%s: can't register clocksource!\n", clocksource.name);
> +}
> +
> +static irqreturn_t comcerto_timer1_interrupt(int irq, void *dev_id)
> +{
> +	u32 status;
> +	struct comcerto_gptimer *t = &timers[TID_CLOCKEVENT];
> +	struct clock_event_device *dev = &clockevent;
> +
> +	status = __raw_readl(COMCERTO_TIMER_STATUS) & __raw_readl(COMCERTO_TIMER_IRQ_MASK);
> +
> +	/* timer1 expired */
> +	if (status & t->mask) {
> +		/* we need to disable interrupt to simulate ONESHOT mode,
> +		 * do it before clearing the interrupt to avoid race */
> +		if (dev->mode != CLOCK_EVT_MODE_PERIODIC)
> +			gptimer_disable(t);

Err, the one-shot mode emulation support looks buggy and completely
unnecessary.  Generally with clockevents, you tell it what the hardware
supports and clockevents deals with it.  You shouldn't emulate modes
that the hardware doesn't support - especially if you're going to ignore
the 'cycles' from set_next_event().

> +
> +		gptimer_clear_status(t);
> +		dev->event_handler(dev);
> +
> +		return IRQ_HANDLED;
> +	}
> +
> +	return IRQ_NONE;
> +}
> +
> +static struct irqaction comcerto_timer1_irq = {
> +	.name           = "timer1",
> +	.flags          = IRQF_DISABLED | IRQF_TIMER,
> +	.handler        = comcerto_timer1_interrupt,
> +};
> +
> +static void __init comcerto_clockevents_init(void)
> +{
> +	struct comcerto_gptimer *t = &timers[TID_CLOCKEVENT];
> +
> +	clockevent.mult = div_sc(COMCERTO_DEFAULTAHBCLK, NSEC_PER_SEC, clockevent.shift);
> +	clockevent.max_delta_ns = clockevent_delta2ns(0x3fffffff, &clockevent);
> +	clockevent.min_delta_ns = clockevent_delta2ns(1, &clockevent);
> +	clockevent.cpumask = cpumask_of(0);
> +	clockevents_register_device(&clockevent);
> +
> +	/* Clear all the timers except timer0  */
> +	__raw_writel(COMCERTO_TIMER_CSP, COMCERTO_TIMER_STATUS);
> +
> +	/* Register interrupt handler for interrupt on IRQ_TIMERB*/
> +	setup_irq(IRQ_TIMER1, &comcerto_timer1_irq);
> +
> +	/* Set and enable the system timer */
> +	gptimer_set_bound(t, 0, COMCERTO_DEFAULTAHBCLK * 1000000 / HZ);
> +}
> +
> +static void __init comcerto_timer_init(void)
> +{
> +	/*
> +	 * DO NOT MODIFY THE CONFIGURATION OF TIMER0
> +	 * It is used by the MSP
> +	 * For C1000 FPP will be using TIMER2
> +	 */
> +
> +	comcerto_clocksource_init();
> +	comcerto_clockevents_init();
> +}
> +
> +struct sys_timer comcerto_timer = {
> +	.init           = comcerto_timer_init,
> +};
> -- 
> 1.5.4.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
