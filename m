From: hjk@linutronix.de (Hans J. Koch)
Date: Sat, 27 Mar 2010 17:49:20 +0100
Subject: [PATCH 4/7 v2] Add TCC8xxx system timer
In-Reply-To: <20100325203515.GE24984@n2100.arm.linux.org.uk>
References: <20100325200427.GC2047@bluebox.local>
	<20100325201247.GG2047@bluebox.local>
	<20100325203515.GE24984@n2100.arm.linux.org.uk>
Message-ID: <20100327164920.GE2035@bluebox.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 25, 2010 at 08:35:15PM +0000, Russell King - ARM Linux wrote:
> On Thu, Mar 25, 2010 at 09:12:48PM +0100, Hans J. Koch wrote:
> > diff --git a/arch/arm/mach-tcc8k/time.c b/arch/arm/mach-tcc8k/time.c
> > new file mode 100644
> > index 0000000..db0a6da
> > --- /dev/null
> > +++ b/arch/arm/mach-tcc8k/time.c
> > @@ -0,0 +1,150 @@
> > +/*
> > + * TCC8000 system timer setup
> > + *
> > + * (C) 2009 Hans J. Koch <hjk@linutronix.de>
> > + *
> > + * Licensed under the terms of the GPL version 2.
> > + *
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/init.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/irq.h>
> > +#include <linux/clk.h>
> > +#include <linux/clockchips.h>
> > +
> > +#include <asm/io.h>
> 
> linux/io.h

OK.

> 
> > +#include <asm/mach/time.h>
> > +
> > +#include <mach/tcc8k-regs.h>
> > +#include <mach/irqs.h>
> > +
> > +static void __iomem *timer_base;
> > +static struct clock_event_device clockevent_tcc;
> 
> You don't need this.

OK.

> 
> > +static enum clock_event_mode clockevent_mode = CLOCK_EVT_MODE_UNUSED;
> 
> Do you need to keep this state around?

Not really. Removed.

> 
> > +
> > +static cycle_t tcc_get_cycles(struct clocksource *cs)
> > +{
> > +	return __raw_readl(timer_base + TC32MCNT_OFFS);
> > +}
> > +
> > +static struct clocksource clocksource_tcc = {
> > +	.name		= "tcc_tc32",
> > +	.rating		= 200,
> > +	.read		= tcc_get_cycles,
> > +	.mask		= CLOCKSOURCE_MASK(32),
> > +	.shift		= 28,
> > +	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
> > +};
> > +
> > +static int tcc_set_next_event(unsigned long evt,
> > +			      struct clock_event_device *unused)
> > +{
> > +	unsigned long reg = __raw_readl(timer_base + TC32MCNT_OFFS);
> > +
> > +	__raw_writel(reg + evt, timer_base + TC32CMP0_OFFS);
> > +	return 0;
> > +}
> > +
> > +static void tcc_set_mode(enum clock_event_mode mode,
> > +				struct clock_event_device *evt)
> > +{
> > +	unsigned long tc32irq;
> > +
> > +	clockevent_mode = mode;
> > +
> > +	switch (mode) {
> > +	case CLOCK_EVT_MODE_ONESHOT:
> > +		tc32irq = __raw_readl(timer_base + TC32IRQ_OFFS);
> > +		tc32irq |= TC32IRQ_IRQEN0;
> > +		__raw_writel(tc32irq, timer_base + TC32IRQ_OFFS);
> > +		break;
> > +	case CLOCK_EVT_MODE_SHUTDOWN:
> > +	case CLOCK_EVT_MODE_UNUSED:
> > +		tc32irq = __raw_readl(timer_base + TC32IRQ_OFFS);
> > +		tc32irq &= ~TC32IRQ_IRQEN0;
> > +		__raw_writel(tc32irq, timer_base + TC32IRQ_OFFS);
> > +		break;
> > +	case CLOCK_EVT_MODE_PERIODIC:
> > +	case CLOCK_EVT_MODE_RESUME:
> > +		break;
> > +	}
> > +}
> > +
> > +static irqreturn_t tcc8k_timer_interrupt(int irq, void *dev_id)
> > +{
> > +	struct clock_event_device *evt = &clockevent_tcc;
> 
> Change this to:
> 	struct clock_event_device *evt = dev_id;

Done.

> 
> > +
> > +	/* Acknowledge TC32 interrupt by reading TC32IRQ */
> > +	__raw_readl(timer_base + TC32IRQ_OFFS);
> > +
> > +	evt->event_handler(evt);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static struct irqaction tcc8k_timer_irq = {
> > +	.name		= "TC32_timer",
> > +	.flags		= IRQF_DISABLED | IRQF_TIMER,
> > +	.handler	= tcc8k_timer_interrupt,
> > +};
> > +
> > +static struct clock_event_device clockevent_tcc = {
> > +	.name		= "tcc_timer1",
> > +	.features	= CLOCK_EVT_FEAT_ONESHOT,
> > +	.shift		= 32,
> > +	.set_mode	= tcc_set_mode,
> > +	.set_next_event	= tcc_set_next_event,
> > +	.rating		= 200,
> > +};
> 
> And add:
>  static struct irqaction tcc8k_timer_irq = {
>  	.name		= "TC32_timer",
>  	.flags		= IRQF_DISABLED | IRQF_TIMER,
>  	.handler	= tcc8k_timer_interrupt,
> +	.dev_id		= &clockevent_tcc,
>  };

OK, done.

Thanks,
Hans
