From: florian@openwrt.org (Florian Fainelli)
Date: Mon, 23 Jul 2012 21:11:06 +0200
Subject: [PATCH 1/8] ARM: support for Moschip MCS814x SoCs
In-Reply-To: <20120716142941.666d928c@skate>
References: <1342363754-30808-1-git-send-email-florian@openwrt.org>
 <1342363754-30808-2-git-send-email-florian@openwrt.org>
 <20120716142941.666d928c@skate>
Message-ID: <6220407.M8CZZfZu0N@bender>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Thomas,

On Monday 16 July 2012 14:29:41 Thomas Petazzoni wrote:
> Hello Florian,
> 
[snip]
> > +static void __init mcs814x_of_timer_init(void)
> > +{
> > +	struct device_node *np;
> > +	const unsigned int *intspec;
> > +
> > +	np = of_find_matching_node(NULL, mcs814x_timer_ids);
> > +	if (!np)
> > +		panic("unable to find compatible timer node in dtb");
> > +
> > +	mcs814x_timer_base = of_iomap(np, 0);
> > +	if (!mcs814x_timer_base)
> > +		panic("unable to remap timer cpu registers");
> > +
> > +	intspec = of_get_property(np, "interrupts", NULL);
> > +	if (!intspec)
> > +		panic("no interrupts property for timer");
> > +
> > +	mcs814x_timer_irq.irq = be32_to_cpup(intspec);
> > +}
> > +
> > +static void __init mcs814x_timer_init(void)
> > +{
> > +	struct clk *clk;
> > +
> > +	clk = clk_get_sys("timer0", NULL);
> > +	if (IS_ERR_OR_NULL(clk))
> > +		panic("unable to get timer0 clock");
> > +
> > +	clock_rate = clk_get_rate(clk);
> > +	clk_put(clk);
> > +
> > +	mcs814x_of_timer_init();
> > +
> > +	pr_info("Timer frequency: %d (kHz)\n", clock_rate / 1000);
> > +
> > +	timer_reload_value = 0xffffffff - (clock_rate / HZ);
> > +
> > +	/* disable timer */
> > +	__raw_writel(0, mcs814x_timer_base + TIMER_CTL);
> > +	__raw_writel(timer_reload_value, mcs814x_timer_base + TIMER_VAL);
> > +	last_reload = timer_reload_value;
> > +
> > +	setup_irq(mcs814x_timer_irq.irq, &mcs814x_timer_irq);
> > +	/* enable timer, stop timer in debug mode */
> > +	__raw_writel(0x03, mcs814x_timer_base + TIMER_CTL);
> > +}
> > +
> > +struct sys_timer mcs814x_timer = {
> > +	.init	= mcs814x_timer_init,
> > +	.offset	= mcs814x_gettimeoffset,
> > +};
> 
> I am surprised that this doesn't use the clocksource and clockevents
> infrastructure. It probably should, and be implemented in
> drivers/clocksource/.

This may sound like a stupid question, but the big constraint with this SoC is 
that the timers do not reload themselves, and so far, I did not find out how I 
can handle this properly with a clocksource. I suppose that it should not be a 
big problem for the clockevent device however.

Has anyone any example of such particular case?
-- 
Florian
