From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 6 Sep 2018 22:39:25 +0100
Subject: Timer on i.MX28 moving backwards
In-Reply-To: <20180906200202.et4whmzq22n4uajt@pengutronix.de>
References: <20180906200202.et4whmzq22n4uajt@pengutronix.de>
Message-ID: <20180906213925.GU30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 06, 2018 at 10:02:02PM +0200, Uwe Kleine-K?nig wrote:
> +cycle_t mxs_clocksource_mmio_readl_down(struct clocksource *c)
> +{
> +	cycle_t ret = ~(cycle_t)readl_relaxed(to_mmio_clksrc(c)->reg) & c->mask;
> +	trace_printk("time = %llx\n", ret);

I think it may be worth re-running your test with:

	u32 one, two;

	one = readl_relaxed(to_mmio_clksrc(c)->reg);
	two = readl_relaxed(to_mmio_clksrc(c)->reg);
	trace_printk("time=0x%08x:0x%08x\n", one, two);

	return ~(cycle_t)two & c->mask;

and compare the values not only between each call but also between
each read of the register.  It could be a synchronisation issue when
reading the timer register, in which case you may find just one read
is incorrect.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
