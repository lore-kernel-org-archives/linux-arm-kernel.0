From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 7 Sep 2018 10:08:36 +0100
Subject: Timer on i.MX28 moving backwards
In-Reply-To: <20180907083804.yo65kinfwvm4esdz@pengutronix.de>
References: <20180906200202.et4whmzq22n4uajt@pengutronix.de>
 <20180906213925.GU30658@n2100.armlinux.org.uk>
 <20180907072105.m47r3rjf2dd3jlv6@pengutronix.de>
 <20180907083804.yo65kinfwvm4esdz@pengutronix.de>
Message-ID: <20180907090836.GV30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 07, 2018 at 10:38:04AM +0200, Uwe Kleine-K?nig wrote:
> On Fri, Sep 07, 2018 at 09:21:05AM +0200, Uwe Kleine-K?nig wrote:
> > On Thu, Sep 06, 2018 at 10:39:25PM +0100, Russell King - ARM Linux wrote:
> > > On Thu, Sep 06, 2018 at 10:02:02PM +0200, Uwe Kleine-K?nig wrote:
> > > > +cycle_t mxs_clocksource_mmio_readl_down(struct clocksource *c)
> > > > +{
> > > > +	cycle_t ret = ~(cycle_t)readl_relaxed(to_mmio_clksrc(c)->reg) & c->mask;
> > > > +	trace_printk("time = %llx\n", ret);
> > > 
> > > I think it may be worth re-running your test with:
> > > 
> > > 	u32 one, two;
> > > 
> > > 	one = readl_relaxed(to_mmio_clksrc(c)->reg);
> > > 	two = readl_relaxed(to_mmio_clksrc(c)->reg);
> > > 	trace_printk("time=0x%08x:0x%08x\n", one, two);
> > > 
> > > 	return ~(cycle_t)two & c->mask;
> > > 
> > > and compare the values not only between each call but also between
> > > each read of the register.  It could be a synchronisation issue when
> > > reading the timer register, in which case you may find just one read
> > > is incorrect.
> > 
> > Good idea, this is a part of a trace I captured with this implemented:
> > 
> >        mrp62439d-224   [000] d..h2..   790.936689: mxs_clocksource_mmio_readl_down: time = 0x948e3d1a:0x948e3d14
> >        mrp62439d-224   [000] .......   790.936689: mxs_clocksource_mmio_readl_down: time = 0x948e4d26:0x948e4d20
> >        mrp62439d-224   [000] .......   790.936904: mxs_clocksource_mmio_readl_down: time = 0x948e3690:0x948e368a
> > 
> > hmm, I'm unsure what to think now.
> 
> To clearify my (obviously too short) mail:
> 
> Judging form a trace over 43s the two consecutive reads always correctly
> yield a decrementing counter as expected. But there is not always the
> expected monotonicity between consecutive calls to
> clocksource_mmio_readl_down.

Hmm, there is another explanation - maybe the order of the trace
entries are not strictly ordered.  What happens with this:

	static atomic_t order;
	u32 one, two;
	int o;

	one = readl_relaxed(to_mmio_clksrc(c)->reg);
	o = atomic_add_return(1, &order);
	two = readl_relaxed(to_mmio_clksrc(c)->reg);
	trace_printk("time=0x%08x:0x%08x:%u\n", one, two, o);

	return ~(cycle_t)two & c->mask;

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
