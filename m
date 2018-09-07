From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 7 Sep 2018 12:00:41 +0200
Subject: Timer on i.MX28 moving backwards
In-Reply-To: <20180907090836.GV30658@n2100.armlinux.org.uk>
References: <20180906200202.et4whmzq22n4uajt@pengutronix.de>
 <20180906213925.GU30658@n2100.armlinux.org.uk>
 <20180907072105.m47r3rjf2dd3jlv6@pengutronix.de>
 <20180907083804.yo65kinfwvm4esdz@pengutronix.de>
 <20180907090836.GV30658@n2100.armlinux.org.uk>
Message-ID: <20180907100041.nkjvuvbob3i5my7h@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russel,

On Fri, Sep 07, 2018 at 10:08:36AM +0100, Russell King - ARM Linux wrote:
> On Fri, Sep 07, 2018 at 10:38:04AM +0200, Uwe Kleine-K?nig wrote:
> > On Fri, Sep 07, 2018 at 09:21:05AM +0200, Uwe Kleine-K?nig wrote:
> > > Good idea, this is a part of a trace I captured with this implemented:
> > > 
> > >        mrp62439d-224   [000] d..h2..   790.936689: mxs_clocksource_mmio_readl_down: time = 0x948e3d1a:0x948e3d14
> > >        mrp62439d-224   [000] .......   790.936689: mxs_clocksource_mmio_readl_down: time = 0x948e4d26:0x948e4d20
> > >        mrp62439d-224   [000] .......   790.936904: mxs_clocksource_mmio_readl_down: time = 0x948e3690:0x948e368a
> > > 
> > > hmm, I'm unsure what to think now.
> > 
> > To clearify my (obviously too short) mail:
> > 
> > Judging form a trace over 43s the two consecutive reads always correctly
> > yield a decrementing counter as expected. But there is not always the
> > expected monotonicity between consecutive calls to
> > clocksource_mmio_readl_down.
> 
> Hmm, there is another explanation - maybe the order of the trace
> entries are not strictly ordered.  What happens with this:
> 
> 	static atomic_t order;
> 	u32 one, two;
> 	int o;
> 
> 	one = readl_relaxed(to_mmio_clksrc(c)->reg);
> 	o = atomic_add_return(1, &order);
> 	two = readl_relaxed(to_mmio_clksrc(c)->reg);
> 	trace_printk("time=0x%08x:0x%08x:%u\n", one, two, o);
> 
> 	return ~(cycle_t)two & c->mask;

I choosed a slightly different approach and printed just one time entry
and o per line to simplify the awk script to check the output:

	cycle_t mxs_clocksource_mmio_readl_down(struct clocksource *c)
	{
		static atomic_t order;
		int o;
		u32 one;
	
		one = readl_relaxed(to_mmio_clksrc(c)->reg);
		o = atomic_add_return(1, &order);
		trace_printk("%d: time = 0x%08x, o=%d\n", __LINE__, one, o);
		one = readl_relaxed(to_mmio_clksrc(c)->reg);
		o = atomic_add_return(1, &order);
		trace_printk("%d: time = 0x%08x, o=%d\n", __LINE__, one, o);
	
		return ~(cycle_t)one & c->mask;
	}

And indeed I see:

       mrp62439d-219   [000] .......   126.832393: mxs_clocksource_mmio_readl_down: 36: time = 0x4a908d19, o=480635
       mrp62439d-219   [000] .......   126.832408: mxs_clocksource_mmio_readl_down: 39: time = 0x4a908afb, o=480636
       mrp62439d-219   [000] d..h2..   126.832883: mxs_clocksource_mmio_readl_down: 36: time = 0x4a905e4b, o=480638
       mrp62439d-219   [000] d..h2..   126.832890: mxs_clocksource_mmio_readl_down: 39: time = 0x4a905d9f, o=480639
       mrp62439d-219   [000] d..h1..   126.832908: mxs_clocksource_mmio_readl_down: 36: time = 0x4a905c05, o=480640
       mrp62439d-219   [000] d..h1..   126.832915: mxs_clocksource_mmio_readl_down: 39: time = 0x4a905b3a, o=480641
       mrp62439d-219   [000] d..h2..   126.832929: mxs_clocksource_mmio_readl_down: 36: time = 0x4a9059f6, o=480642
       mrp62439d-219   [000] d..h2..   126.832937: mxs_clocksource_mmio_readl_down: 39: time = 0x4a905927, o=480643
       mrp62439d-219   [000] d..h1..   126.833031: mxs_clocksource_mmio_readl_down: 36: time = 0x4a9050ee, o=480644
       mrp62439d-219   [000] d..h1..   126.833043: mxs_clocksource_mmio_readl_down: 39: time = 0x4a904f73, o=480645
       mrp62439d-219   [000] .......   126.833114: mxs_clocksource_mmio_readl_down: 36: time = 0x4a906479, o=480637
       mrp62439d-219   [000] .......   126.833124: mxs_clocksource_mmio_readl_down: 39: time = 0x4a9047ba, o=480646

But this can be explained by the hard irq interrupting between "o = .." and
"trace_printk(..." above. Will retry with irq disabling, i.e. twice

	raw_local_irq_save(flags);
	one = readl_relaxed(to_mmio_clksrc(c)->reg);
	o = atomic_add_return(1, &mxs_order);
	trace_printk("%d: time = 0x%08x, o=%d\n", __LINE__, one, o);
	raw_local_irq_restore(flags);

and report when I'm done.

Thanks for your very valuable input,
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
