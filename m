From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 24 Feb 2017 23:29:22 +0100
Subject: [PATCH v2 04/17] clocksource: Add Owl timer
In-Reply-To: <20170224034055.18807-5-afaerber@suse.de>
References: <20170224034055.18807-1-afaerber@suse.de>
 <20170224034055.18807-5-afaerber@suse.de>
Message-ID: <20170224222921.GA23152@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 24, 2017 at 04:40:42AM +0100, Andreas F?rber wrote:
> Implement clocksource and clockevents for Actions Semi S500.
> 
> Based on LeMaker linux-actions tree.
> 
> Signed-off-by: Andreas F?rber <afaerber@suse.de>

As this is a new driver, please give some technical information about the
driver itself and a pointer to documentation if it is publicly available.

[ ... ]

> +#define OWL_T0_CMP		0x0c
> +#define OWL_T0_VAL		0x10
> +#define OWL_T1_CTL		0x14
> +#define OWL_T1_CMP		0x18
> +#define OWL_T1_VAL		0x1c
> +
> +#define OWL_Tx_CTL_INTEN	(1 << 1)
> +#define OWL_Tx_CTL_EN		(1 << 2)

s/(1 << 1)/BIT(1)/
s/(1 << 2)/BIT(2)/

> +
> +static void __iomem *owl_timer_base;
> +
> +static u64 notrace owl_timer_sched_read(void)
> +{
> +	return (u64)readl(owl_timer_base + OWL_T0_VAL);
> +}
> +
> +static int owl_timer_set_state_shutdown(struct clock_event_device *evt)
> +{
> +	writel(0, owl_timer_base + OWL_T1_CTL);
> +
> +	return 0;
> +}
> +
> +static int owl_timer_set_state_oneshot(struct clock_event_device *evt)
> +{
> +	writel(0, owl_timer_base + OWL_T1_CTL);
> +	writel(0, owl_timer_base + OWL_T1_VAL);
> +	writel(0, owl_timer_base + OWL_T1_CMP);
> +
> +	return 0;
> +}
> +
> +static int owl_timer_tick_resume(struct clock_event_device *evt)
> +{
> +	return 0;
> +}
> +
> +static int owl_timer_set_next_event(unsigned long evt,
> +				    struct clock_event_device *ev)
> +{
> +	writel(0, owl_timer_base + OWL_T1_CTL);
> +
> +	writel(0, owl_timer_base + OWL_T1_VAL);
> +	writel(evt, owl_timer_base + OWL_T1_CMP);
> +
> +	writel(OWL_Tx_CTL_EN | OWL_Tx_CTL_INTEN, owl_timer_base + OWL_T1_CTL);
> +
> +	return 0;
> +}
> +
> +static struct clock_event_device owl_clockevent = {
> +	.name			= "owl_tick",
> +	.rating			= 200,
> +	.features		= CLOCK_EVT_FEAT_ONESHOT,

Did you consider adding CLOCK_EVT_FEAT_DYNIRQ ?

> +	.set_state_shutdown	= owl_timer_set_state_shutdown,
> +	.set_state_oneshot	= owl_timer_set_state_oneshot,
> +	.tick_resume		= owl_timer_tick_resume,
> +	.set_next_event		= owl_timer_set_next_event,
> +};
> +
> +static irqreturn_t owl_timer_interrupt(int irq, void *dev_id)
> +{
> +	struct clock_event_device *evt = (struct clock_event_device *)dev_id;
> +
> +	evt->event_handler(evt);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static struct irqaction owl_timer_irq = {
> +	.name = "owl-timer",
> +	.flags = IRQF_TIMER,
> +	.handler = owl_timer_interrupt,
> +	.dev_id = &owl_clockevent,
> +};
> +
> +static int __init owl_timer_init(struct device_node *node)
> +{
> +	const unsigned long rate = 24000000;

Use DT, either use clock-frequency or a clock ref.

> +	int irq1, ret;
> +
> +	owl_timer_base = of_io_request_and_map(node, 0, "owl-timer");
> +	if (IS_ERR(owl_timer_base)) {
> +		pr_err("Can't map timer registers");
> +		return -ENXIO;

Why not PTR_ERR(owl_timer_base) ?

> +	}
> +
> +	irq1 = irq_of_parse_and_map(node, 1);
> +	if (irq1 <= 0) {
> +		pr_err("Can't parse timer1 IRQ");
> +		return -EINVAL;
> +	}
> +
> +	writel(0, owl_timer_base + OWL_T0_CTL);
> +	writel(0, owl_timer_base + OWL_T0_VAL);
> +	writel(0, owl_timer_base + OWL_T0_CMP);
> +	writel(OWL_Tx_CTL_EN, owl_timer_base + OWL_T0_CTL);

Please factor out these calls into a function.

> +
> +	sched_clock_register(owl_timer_sched_read, 32, rate);
> +	clocksource_mmio_init(owl_timer_base + OWL_T0_VAL, node->name,
> +			      rate, 200, 32, clocksource_mmio_readl_up);
> +
> +	writel(0, owl_timer_base + OWL_T1_CTL);
> +	writel(0, owl_timer_base + OWL_T1_VAL);
> +	writel(0, owl_timer_base + OWL_T1_CMP);
> +
> +	ret = setup_irq(irq1, &owl_timer_irq);
> +	if (ret) {
> +		pr_warn("failed to setup irq %d\n", irq1);
> +		return ret;
> +	}

s/setup_irq/request_irq/

> +
> +	owl_clockevent.cpumask = cpumask_of(0);
> +	owl_clockevent.irq = irq1;
> +
> +	clockevents_config_and_register(&owl_clockevent, rate,
> +					0xf, 0xffffffff);
> +
> +	return 0;
> +}
> +CLOCKSOURCE_OF_DECLARE(owl, "actions,owl-timer", owl_timer_init);

Thanks !

  -- Daniel 

-- 

 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
