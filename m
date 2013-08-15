From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 14 Aug 2013 17:30:38 -0700
Subject: [PATCH v3 3/5] ARM: bcm4760: Add system timer
In-Reply-To: <20130814221237.695587612@gmail.com>
References: <20130814221043.528864175@gmail.com>
 <20130814221237.695587612@gmail.com>
Message-ID: <20130815003038.GB27999@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/15, Domenico Andreoli wrote:
> +
> +static inline void __iomem *to_load(struct bcm4760_timer *timer)
> +{
> +	return timer->base + TIMER_LOAD_OFFSET;
> +}
> +
> +static inline void __iomem *to_control(struct bcm4760_timer *timer)
> +{
> +	return timer->base + TIMER_CONTROL_OFFSET;
> +}
> +
> +static inline void __iomem *to_intclr(struct bcm4760_timer *timer)
> +{
> +	return timer->base + TIMER_INTCLR_OFFSET;
> +}
> +
> +static inline void __iomem *to_ris(struct bcm4760_timer *timer)
> +{
> +	return timer->base + TIMER_RIS_OFFSET;
> +}
> +
> +static inline void __iomem *to_mis(struct bcm4760_timer *timer)
> +{
> +	return timer->base + TIMER_MIS_OFFSET;
> +}

Style Nit: This is new. Usually people either make a
<my_driver>_{readl,writel}() function that takes the struct and
an offset or they just add the offset directly in their
readl/writel calls. Can you do that? Probably save some lines of
code.

> +static irqreturn_t bcm4760_timer_interrupt(int irq, void *dev_id)
> +{
> +	struct bcm4760_timer *timer = dev_id;
> +	void (*event_handler)(struct clock_event_device *);
> +
> +	/* check the (masked) interrupt status */
> +	if (!readl_relaxed(to_mis(timer)))
> +		return IRQ_NONE;
> +
> +	/* clear the timer interrupt */
> +	writel_relaxed(1, to_intclr(timer));
> +
> +	event_handler = ACCESS_ONCE(timer->evt.event_handler);
> +	if (event_handler)
> +		event_handler(&timer->evt);

This is unfortunate. Do you have a pending timer interrupt left
by the bootloader?

> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void __init bcm4760_init_time(struct device_node *node)
> +{
> +	void __iomem *base;
> +	u32 freq = 24000000;

Why have freq in the DT binding at all then?

> +	int irq;
> +	struct bcm4760_timer *timer;
> +
> +	base = of_iomap(node, 0);
> +	if (!base)
> +		panic("Can't remap timer registers");
> +
> +	timer = kzalloc(sizeof(*timer), GFP_KERNEL);
> +	if (!timer)
> +		panic("Can't allocate timer struct\n");
> +
> +	irq = irq_of_parse_and_map(node, 0);
> +	if (irq <= 0)
> +		panic("Can't parse timer IRQ");
> +
> +	timer->base = base;
> +	timer->evt.name = node->name;
> +	timer->evt.rating = 300;
> +	timer->evt.features = CLOCK_EVT_FEAT_ONESHOT;
> +	timer->evt.set_mode = bcm4760_timer_set_mode;
> +	timer->evt.set_next_event = bcm4760_timer_set_next_event;
> +	timer->evt.cpumask = cpumask_of(0);
> +	timer->act.name = node->name;
> +	timer->act.flags = IRQF_TIMER | IRQF_SHARED;
> +	timer->act.dev_id = timer;
> +	timer->act.handler = bcm4760_timer_interrupt;
> +
> +	if (setup_irq(irq, &timer->act))
> +		panic("Can't set up timer IRQ\n");
> +
> +	clockevents_config_and_register(&timer->evt, freq, 0xf, 0xffffffff);

If you switch this registration and the setup_irq() call you
shouldn't need the ACCESS_ONCE() and that check in the irq handler.
Please switch the order and or clear the interrupt before
registering the clockevent and remove the checks in the interrupt
handler.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
