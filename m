From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 21 May 2013 12:14:12 +0200
Subject: [PATCH v4] clocksource: add Vybrid Family pit timer support
In-Reply-To: <1369121274-9371-1-git-send-email-b35083@freescale.com>
References: <1369121274-9371-1-git-send-email-b35083@freescale.com>
Message-ID: <519B48F4.8050005@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/21/2013 09:27 AM, Jingchang Lu wrote:
> Add Freescale Vybrid Family period interrupt timer support.
> 
> Signed-off-by: Jingchang Lu <b35083@freescale.com>
> ---
> v4:
>   use family name names driver and symbol instead of SoC name.
>   remove redundant code.
>   use BUG_ON instead of WARN_ON.
>   add necessory comment information.
> 
>  drivers/clocksource/Kconfig         |   5 +
>  drivers/clocksource/Makefile        |   1 +
>  drivers/clocksource/mvf_pit_timer.c | 187 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 193 insertions(+)
>  create mode 100644 drivers/clocksource/mvf_pit_timer.c

[ ... ]

> +
> +static int pit_set_next_event(unsigned long delta,
> +				struct clock_event_device *unused)
> +{
> +	/*
> +	 * set a new value to PITLDVAL register will not restart the timer,
> +	 * to abort the current cycle and start a timer period with the new
> +	 * value, the timer must be disabled and enabled again.
> +	 * and the PITLAVAL should be set to delta minus one.

Why delta "minus one" ?

> +	 */
> +	pit_timer_disable();
> +	__raw_writel(delta - 1, clkevt_base + PITLDVAL);
> +	pit_timer_enable();
> +
> +	return 0;
> +}
> +
> +static void pit_set_mode(enum clock_event_mode mode,
> +				struct clock_event_device *evt)
> +{
> +	switch (mode) {
> +	case CLOCK_EVT_MODE_PERIODIC:
> +		pit_timer_disable();
> +		__raw_writel(cycle_per_jiffy - 1, clkevt_base + PITLDVAL);
> +		pit_timer_enable();

You can call pit_set_next_event(cycle_per_jiffy, evt) instead of adding
redundant code, no ?

> +		break;
> +	default:
> +		break;
> +	}
> +}

[ ... ]

> +
> +static struct clock_event_device clockevent_pit = {
> +	.name		= "MVF pit timer",
> +	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
> +	.set_mode	= pit_set_mode,
> +	.set_next_event	= pit_set_next_event,
> +	.rating		= 300,
> +};
> +
> +static struct irqaction pit_timer_irq = {
> +	.name		= "MVF pit timer",
> +	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,

Did you take into account Thomas's comment ?

> +	.handler	= pit_timer_interrupt,
> +	.dev_id		= &clockevent_pit,
> +};
> +
> +static int __init pit_clockevent_init(struct clk *pit_clk, int irq)
> +{
> +	unsigned int c = clk_get_rate(pit_clk);
> +
> +	__raw_writel(0, clkevt_base + PITTCTRL);
> +	__raw_writel(PITTFLG_TIF, clkevt_base + PITTFLG);
> +
> +	clockevent_pit.cpumask = cpumask_of(0);

The irq initialization is missing.

	clockevent_pit.irq = irq;

> +	clockevents_config_and_register(&clockevent_pit, c, 2, 0xffffffff);

Is it possible to have a comment with the justification for these values ?

> +
> +	BUG_ON(setup_irq(irq, &pit_timer_irq));
> +	return 0;

Everything is ok if you can't setup your timer ?

> +}
> +
> +static void __init pit_timer_init(struct device_node *np)
> +{
> +	struct clk *pit_clk;
> +	void __iomem *timer_base;
> +	int irq;
> +
> +	timer_base = of_iomap(np, 0);
> +	BUG_ON(!timer_base);

You raise a bug and then you go ahead setting up the address with an
invalid value, leading to a random crash.

> +	/*
> +	 * PIT0 and PIT1 can be chained to build a 64-bit timer,
> +	 * so choose PIT2 as clocksource, PIT3 as clockevent device,
> +	 * and leave PIT0 and PIT1 unused for anyone else who needs them.
> +	 */
> +	clksrc_base = timer_base + PITn_OFFSET(2);
> +	clkevt_base = timer_base + PITn_OFFSET(3);
> +
> +	irq = irq_of_parse_and_map(np, 0);
> +
> +	pit_clk = of_clk_get(np, 0);
> +	BUG_ON(IS_ERR(pit_clk));
> +
> +	BUG_ON(clk_prepare_enable(pit_clk));

Same here.

> +	cycle_per_jiffy = clk_get_rate(pit_clk)/(HZ);
> +
> +	/* enable the pit module */
> +	__raw_writel(~PITMCR_MDIS, timer_base + PITMCR);
> +
> +	BUG_ON(pit_clocksource_init(pit_clk));
> +
> +	pit_clockevent_init(pit_clk, irq);

Please, remove these BUG_ON, this is inconsistent especially with a one
call init function. If pit_timer_init can't be initialized, just pr_err
+ BUG.

Thanks
  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
