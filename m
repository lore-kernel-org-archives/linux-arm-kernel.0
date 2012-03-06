From: jason@lakedaemon.net (Jason)
Date: Tue, 6 Mar 2012 12:23:42 -0500
Subject: [RFC 00/14] Generic clk for Orion platforms.
In-Reply-To: <20120306161743.GI24858@lunn.ch>
References: <1331015471-28872-1-git-send-email-andrew@lunn.ch>
 <20120306155840.GS5050@titan.lakedaemon.net>
 <20120306161743.GI24858@lunn.ch>
Message-ID: <20120306172341.GU5050@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 06, 2012 at 05:17:43PM +0100, Andrew Lunn wrote:
> On Tue, Mar 06, 2012 at 10:58:40AM -0500, Jason wrote:
> > On Tue, Mar 06, 2012 at 07:30:56AM +0100, Andrew Lunn wrote:
> > > This patch set starts the process of changing Orion based platforms to
> > > use the generic clk framework. The first patch fixes compile problems
> > > with the framework, and is expected to be dropped once fixed upstream.
> > > Then clks are added. This is a fixed rate clk for tclk and for
> > > kirkwood, most of the gated clocks also get a clk. The following
> > > patches then modified the drivers to make use of these clocks,
> > > getting, prepareing, enabling at probe time, and disableing,
> > > unprepareing, and putting at remove time. Rather than pass the clock
> > > frequency as platform_data, the driver now uses clk_get_rate(). This
> > > results in some platform_data structures becoming redundant, and so
> > > are removed.
> > 
> > Awesome, thanks for posting!
> > 
> > > TODO:
> > > 
> > >  0) Cleanup the white space changes, and hunks in the wrong patches.
> > 
> > It would be helpful to break out code cleanup as well.  eg spi_clock_fix
> > removal, sound platform data removal, and anything else I didn't see on
> > initial read through.
> 
> I could move these out, but they actually help you. It means there is
> less for you to add DT support for. If they are left in, you need to
> add a DT property for spi_clock_fix, etc.

Oops, #4 and #8 are what I wanted to pull in separately.  I could've
sworn I saw something else that went in the same catagory as those
two...

> > >  1) PCIe needs adopting to use clks.
> > >  2) Strip out all references to kirkwood_clk_ctrl
> > >  3) Find a solution for turning off unused clks - Probably needs
> > >     framework support, which Mike has already suggested.
> > 
> > I'm assuming the driver(s) will increment a reference, so when it
> > reaches zero, the framework would call a clk_gate hook.
> 
> You missed an important point. No driver has claimed these, but u-boot
> has turned them on.

This sounds like a bug in u-boot.

> So we want linux to turn off all clocks for which
> there is no driver using them, in order to save power.
> kirkwood_clk_ctrl is dual purpose. It turns on needed clocks, but it
> also turns off unneeded clocks.

This is creating a lot of complexity where the real answer seems to be
to get u-boot to shutoff all peripheral clocks before handing over
control to linux.

Until that happens, could we walk across kirkwood_clks[] in
kirkwood_clock_gate() to determine what is in use?  eg:

#########
curr = readl(CLOCK_GATING_CTRL);
...
used = CGC_DUNIT | CGC_RESERVED;

for (i = 0; i < ARRAY_SIZE(kirkwood_clks); i++) {
	if (kirkwood_clks[i]->enable_count)
		used |= kirkwood_clks[i]->/*PFM*/->mask;
}

/* disable anything in curr, but not in used */
if (CGC_SATA0 & (curr & ~used)) {
	/* disable sata0 logic */
}

...
#########

This would handle both fdt and non-fdt use cases.

thx,

Jason.
