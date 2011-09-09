From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 9 Sep 2011 16:19:09 +0200 (CEST)
Subject: [PATCH 10/24] C6X: time management
In-Reply-To: <1314826019-22330-11-git-send-email-msalter@redhat.com>
References: <1314826019-22330-1-git-send-email-msalter@redhat.com>
	<1314826019-22330-11-git-send-email-msalter@redhat.com>
Message-ID: <alpine.LFD.2.02.1109091612150.2723@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 31 Aug 2011, Mark Salter wrote:
> +static int next_event(unsigned long delta,
> +		      struct clock_event_device *evt)
> +{
> +	soc_writel(soc_readl(&timer->tcr) & ~TCR_ENAMODELO_MASK, &timer->tcr);
> +	soc_writel(delta - 1, &timer->prdlo);
> +	soc_writel(0, &timer->cntlo);
> +	soc_writel(soc_readl(&timer->tcr) | TCR_ENAMODELO_ONCE, &timer->tcr);
> +
> +	return 0;
> +}
> +
> +static void set_clock_mode(enum clock_event_mode mode,
> +			   struct clock_event_device *evt)
> +{
> +}
> +
> +static void event_handler(struct clock_event_device *dev)
> +{
> +}

You don't need a handler function. The core code sets one for you.

> +static irqreturn_t timer_interrupt(int irq, void *dev_id)
> +{
> +	struct clock_event_device *cd = &t64_clockevent_device;
> +
> +	cd->event_handler(cd);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +
> +void __init timer64_init(void)
> +{
> +	struct clock_event_device *cd = &t64_clockevent_device;
 ...
> +	cd->name	= "TIMER64_EVT32_TIMER";
> +	cd->features	= CLOCK_EVT_FEAT_ONESHOT;

Please move those into a static initializer of t64_clockevent_device.

> +	/* Calculate the min / max delta */
> +	/* Find a shift value */
> +	for (shift = 32; shift > 0; shift--) {
> +		temp = (u64)(c6x_core_freq / TIMER_DIVISOR);
> +		temp <<=  shift;
> +
> +		do_div(temp, NSEC_PER_SEC);
> +		if ((temp >> 32) == 0)
> +			break;
> +	}
> +	cd->shift = shift;
> +	cd->mult = (u32) temp;

  clockevents_calc_mult_shift() please

> +	cd->rating		= 200;
> +	cd->set_mode		= set_clock_mode;

  static initializer

> +	cd->event_handler	= event_handler;

  Please drop

> +	cd->set_next_event	= next_event;

  static initializer

> +	cd->cpumask		= cpumask_of(smp_processor_id());
> +
> +	clockevents_register_device(cd);
> +
> +	/* Set handler */
> +	if (cd->irq != NO_IRQ)

How does a timer device work w/o interrupt ?

> +		request_irq(cd->irq, timer_interrupt,
> +			    IRQF_DISABLED | IRQF_TIMER, "timer", NULL);

  Please drop IRQF_DISABLED it's about to vanish.

Thanks,

	tglx
