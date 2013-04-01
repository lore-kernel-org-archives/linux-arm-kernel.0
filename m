From: john.stultz@linaro.org (John Stultz)
Date: Mon, 01 Apr 2013 16:26:18 -0700
Subject: [PATCH v2 12/13] ARM: move sp804 and integrator timers to
 drivers/clocksource
In-Reply-To: <1364854883-5961-13-git-send-email-robherring2@gmail.com>
References: <1364854883-5961-1-git-send-email-robherring2@gmail.com>
 <1364854883-5961-13-git-send-email-robherring2@gmail.com>
Message-ID: <515A179A.8020800@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/01/2013 03:21 PM, Rob Herring wrote:
> diff --git a/drivers/clocksource/integrator_ap_timer.c b/drivers/clocksource/integrator_ap_timer.c
> new file mode 100644
> index 0000000..05e6204
> --- /dev/null
> +++ b/drivers/clocksource/integrator_ap_timer.c
[snip]
> +static void __iomem * clkevt_base;
> +
> +/*
> + * IRQ handler for the timer
> + */
> +static irqreturn_t integrator_timer_interrupt(int irq, void *dev_id)
> +{
> +	struct clock_event_device *evt = dev_id;
> +
> +	/* clear the interrupt */
> +	writel(1, clkevt_base + TIMER_INTCLR);
> +
> +	evt->event_handler(evt);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void clkevt_set_mode(enum clock_event_mode mode, struct clock_event_device *evt)
> +{
> +	u32 ctrl = readl(clkevt_base + TIMER_CTRL) & ~TIMER_CTRL_ENABLE;
> +
> +	/* Disable timer */
> +	writel(ctrl, clkevt_base + TIMER_CTRL);
> +
> +	switch (mode) {
> +	case CLOCK_EVT_MODE_PERIODIC:
> +		/* Enable the timer and start the periodic tick */
> +		writel(timer_reload, clkevt_base + TIMER_LOAD);
> +		ctrl |= TIMER_CTRL_PERIODIC | TIMER_CTRL_ENABLE;
> +		writel(ctrl, clkevt_base + TIMER_CTRL);
> +		break;
> +	case CLOCK_EVT_MODE_ONESHOT:
> +		/* Leave the timer disabled, .set_next_event will enable it */
> +		ctrl &= ~TIMER_CTRL_PERIODIC;
> +		writel(ctrl, clkevt_base + TIMER_CTRL);
> +		break;
> +	case CLOCK_EVT_MODE_UNUSED:
> +	case CLOCK_EVT_MODE_SHUTDOWN:
> +	case CLOCK_EVT_MODE_RESUME:
> +	default:
> +		/* Just leave in disabled state */
> +		break;
> +	}
> +
> +}
> +
> +static int clkevt_set_next_event(unsigned long next, struct clock_event_device *evt)
> +{
> +	unsigned long ctrl = readl(clkevt_base + TIMER_CTRL);
> +
> +	writel(ctrl & ~TIMER_CTRL_ENABLE, clkevt_base + TIMER_CTRL);
> +	writel(next, clkevt_base + TIMER_LOAD);
> +	writel(ctrl | TIMER_CTRL_ENABLE, clkevt_base + TIMER_CTRL);
> +
> +	return 0;
> +}
> +
> +static struct clock_event_device integrator_clockevent = {
> +	.name		= "timer1",
> +	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
> +	.set_mode	= clkevt_set_mode,
> +	.set_next_event	= clkevt_set_next_event,
> +	.rating		= 300,
> +};
> +
> +static struct irqaction integrator_timer_irq = {
> +	.name		= "timer",
> +	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
> +	.handler	= integrator_timer_interrupt,
> +	.dev_id		= &integrator_clockevent,
> +};
> +
> +void __init integrator_clockevent_init(unsigned long inrate,
> +				       void __iomem *base, int irq)
> +{
> +	unsigned long rate = inrate;
> +	unsigned int ctrl = 0;
> +
> +	clkevt_base = base;
> +	/* Calculate and program a divisor */
> +	if (rate > 0x100000 * HZ) {
> +		rate /= 256;
> +		ctrl |= TIMER_CTRL_DIV256;
> +	} else if (rate > 0x10000 * HZ) {
> +		rate /= 16;
> +		ctrl |= TIMER_CTRL_DIV16;
> +	}
> +	timer_reload = rate / HZ;
> +	writel(ctrl, clkevt_base + TIMER_CTRL);
> +
> +	setup_irq(irq, &integrator_timer_irq);
> +	clockevents_config_and_register(&integrator_clockevent,
> +					rate,
> +					1,
> +					0xffffU);
> +}
> +
> +static void __init ap_of_timer_init(struct device_node *node)
> +{
> +	void __iomem *base;
> +	int irq;
> +	struct clk *clk;
> +	unsigned long rate;
> +
> +	clk = clk_get_sys("ap_timer", NULL);
> +	BUG_ON(IS_ERR(clk));
> +	clk_prepare_enable(clk);
> +	rate = clk_get_rate(clk);
> +
> +	base = of_iomap(node, 0);
> +	if (WARN_ON(!base))
> +		return;
> +
> +	writel(0, base + TIMER_CTRL);
> +
> +	if ((clksrc_base && clkevt_base) || !of_device_is_available(node)) {
> +		iounmap(base);
> +		return;
> +	}
> +
> +	irq = irq_of_parse_and_map(node, 0);
> +	if (!clkevt_base && (irq > 0))
> +		integrator_clockevent_init(rate, base, irq);
> +	else
> +		integrator_clocksource_init(rate, base);
> +}
> +CLOCKSOURCE_OF_DECLARE(integrator_ap, "integrator-timer", ap_of_timer_init);

So, most of the code here is really clockevent code and not clocksource 
code. I realize they were combined in the mach directory you're copying 
them from, but if we're going to move all this code out of the arch 
directory and into drivers/, I'd like to propose we not dump it all into 
drivers/clocksource.

For more context here see:
http://www.spinics.net/lists/arm-kernel/msg234074.html

So unless Thomas objects, would you be willing to break this change up 
adding the relevant irq related bits to a new drivers/clockevents 
directory? You can leave the sched_clock bits to clocksource for now, 
since I think that logic should eventually be integrated with the 
clocksource core.

When you resubmit, please also add Daniel Lezcano 
<daniel.lezcano@linaro.org> to the cc.

thanks
-john
