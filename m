From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 7 Jul 2016 13:26:36 +0100
Subject: [PATCH v2] clkdev: add devm_of_clk_get()
In-Reply-To: <87ziptixv7.wl%kuninori.morimoto.gx@renesas.com>
References: <87wpl2yyuw.wl%kuninori.morimoto.gx@renesas.com>
 <146785219147.73491.2827268663638530377@resonance>
 <87ziptixv7.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <20160707122636.GP1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2016 at 09:54:03AM +0000, Kuninori Morimoto wrote:
> 
> Hi Michael
> 
> > > +struct clk *devm_of_clk_get(struct device *dev,
> > > +                           struct device_node *np, int index)
> > 
> > Any reason not to use devm_clk_get? Why do we need this helper?
> 
> Because of_clk_get() can parse "clocks", "#clock-cells" on DT.

clk_get() should also work just fine.  clk_get() uses
__of_clk_get_by_name() internally, which uses "clock-names" to
locate the index if a connection id is given.  of_clk_get() allows
lookup of a clock by index only, omitting the name, which means
you need to coordinate the order of clocks in DT with the order
that the driver wants... which sounds error prone to me.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
