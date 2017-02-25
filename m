From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Sat, 25 Feb 2017 22:59:41 +0100
Subject: [PATCH v2 04/17] clocksource: Add Owl timer
In-Reply-To: <ab18d509-9fb2-1b4c-bdee-e2ce5d4273a3@suse.de>
References: <20170224034055.18807-1-afaerber@suse.de>
 <20170224034055.18807-5-afaerber@suse.de>
 <20170224222921.GA23152@mai>
 <ab18d509-9fb2-1b4c-bdee-e2ce5d4273a3@suse.de>
Message-ID: <20170225215941.GA30601@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 25, 2017 at 12:25:32AM +0100, Andreas F?rber wrote:
> Am 24.02.2017 um 23:29 schrieb Daniel Lezcano:
> > On Fri, Feb 24, 2017 at 04:40:42AM +0100, Andreas F?rber wrote:
> >> Implement clocksource and clockevents for Actions Semi S500.
> >>
> >> Based on LeMaker linux-actions tree.
> >>
> >> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> > 
> > As this is a new driver, please give some technical information about the
> > driver itself and a pointer to documentation if it is publicly available.
> 
> What technical information would that be? Which of the timers we use as
> clock source vs. clock events?

Have a look at commit 07862c1 and e4a6b37 as reference.
 
> The only public documentation beyond the source tree mentioned is here:
> 
> http://www.lemaker.org/product-guitar-download-29.html (section 3.4)
> 
> >> +#define OWL_Tx_CTL_INTEN	(1 << 1)
> >> +#define OWL_Tx_CTL_EN		(1 << 2)
> > 
> > s/(1 << 1)/BIT(1)/
> > s/(1 << 2)/BIT(2)/
> 
> OK
> 

[ ... ]

> >> +static struct clock_event_device owl_clockevent = {
> >> +	.name			= "owl_tick",
> >> +	.rating			= 200,
> >> +	.features		= CLOCK_EVT_FEAT_ONESHOT,
> > 
> > Did you consider adding CLOCK_EVT_FEAT_DYNIRQ ?
> 
> No, it was not present downstream. Got a good example?

https://lwn.net/Articles/541000/

> >> +	.set_state_shutdown	= owl_timer_set_state_shutdown,
> >> +	.set_state_oneshot	= owl_timer_set_state_oneshot,
> >> +	.tick_resume		= owl_timer_tick_resume,
> >> +	.set_next_event		= owl_timer_set_next_event,
> >> +};
> >> +
> >> +static irqreturn_t owl_timer_interrupt(int irq, void *dev_id)
> >> +{
> >> +	struct clock_event_device *evt = (struct clock_event_device *)dev_id;
> >> +
> >> +	evt->event_handler(evt);
> >> +
> >> +	return IRQ_HANDLED;
> >> +}
> >> +
> >> +static struct irqaction owl_timer_irq = {
> >> +	.name = "owl-timer",
> >> +	.flags = IRQF_TIMER,
> >> +	.handler = owl_timer_interrupt,
> >> +	.dev_id = &owl_clockevent,
> >> +};
> >> +
> >> +static int __init owl_timer_init(struct device_node *node)
> >> +{
> >> +	const unsigned long rate = 24000000;
> > 
> > Use DT, either use clock-frequency or a clock ref.
> 
> Are clk drivers really available at this point? clock-frequency sounds
> more promising.

Yes they are. Have a look at the other drivers.
 
> >> +	int irq1, ret;
> >> +
> >> +	owl_timer_base = of_io_request_and_map(node, 0, "owl-timer");
> >> +	if (IS_ERR(owl_timer_base)) {
> >> +		pr_err("Can't map timer registers");
> >> +		return -ENXIO;
> > 
> > Why not PTR_ERR(owl_timer_base) ?
> 
> Only one in-tree driver (sun5i) matches such an expression. Will change.

[ ... ]

> > Please factor out these calls into a function.
> 
> Do you have something in particular in mind? Maybe ..._reset() for the
> first three?

Yes.

> >> +
> >> +	sched_clock_register(owl_timer_sched_read, 32, rate);
> >> +	clocksource_mmio_init(owl_timer_base + OWL_T0_VAL, node->name,
> >> +			      rate, 200, 32, clocksource_mmio_readl_up);
> >> +
> >> +	writel(0, owl_timer_base + OWL_T1_CTL);
> >> +	writel(0, owl_timer_base + OWL_T1_VAL);
> >> +	writel(0, owl_timer_base + OWL_T1_CMP);
> >> +
> >> +	ret = setup_irq(irq1, &owl_timer_irq);
> >> +	if (ret) {
> >> +		pr_warn("failed to setup irq %d\n", irq1);
> >> +		return ret;
> >> +	}
> > 
> > s/setup_irq/request_irq/
> 
> Care to explain? setup_irq has 32 hits vs. 28 for request_irq.

The function setup_irq takes an irqaction as parameter. That forces all the
drivers to declare a structure, so for a multiple platforms support (aka single
kernel image), there are multiple structures declaration for nothing. The
function request_irq allocates the structure and then call setup_irq.

So now, request_irq is used in place of setup_irq.

> >> +
> >> +	owl_clockevent.cpumask = cpumask_of(0);
> >> +	owl_clockevent.irq = irq1;
> >> +
> >> +	clockevents_config_and_register(&owl_clockevent, rate,
> >> +					0xf, 0xffffffff);
> >> +
> >> +	return 0;
> >> +}
> >> +CLOCKSOURCE_OF_DECLARE(owl, "actions,owl-timer", owl_timer_init);
> 
> Do you spot anything functionally wrong in this driver? Despite adding
> this new driver, I am only getting the following additional earlycon output:
>
> [    0.000029] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps
> every 89478484971ns
> [    0.007888] clocksource: timer: mask: 0xffffffff max_cycles:
> 0xffffffff, max_idle_ns: 79635851949 ns
> [    0.017748] Console: colour dummy device 80x30
> [    0.022243] Calibrating delay loop...
> [    0.030895] random: fast init done
> [    0.231021] random: crng init done
> 
> For S900 I'm using the generic timer instead.

I don't get the issue, can you elaborate ?

Thanks

  -- Daniel


-- 

 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
