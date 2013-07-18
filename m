From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 18 Jul 2013 19:55:45 +0800
Subject: [PATCH 4/4] ARM: imx6q: remove board specific CLKO setup
In-Reply-To: <20130718083603.GK10380@pengutronix.de>
References: <1374132670-791-1-git-send-email-shawn.guo@linaro.org>
 <1374132670-791-5-git-send-email-shawn.guo@linaro.org>
 <20130718083603.GK10380@pengutronix.de>
Message-ID: <20130718115541.GA16328@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 18, 2013 at 10:36:03AM +0200, Sascha Hauer wrote:
> On Thu, Jul 18, 2013 at 03:31:10PM +0800, Shawn Guo wrote:
> > The CLKO is widely used by imx6q board designs to clock audio codec.
> > Since most codecs accept 24 MHz frequency, let's initially set up CLKO
> > with OSC24M (cko <-- cko2 <-- osc).  Then those board specific CLKO
> > setup for audio codec can be removed.
> > 
> > The board dts files also need an update on cko reference in codec node.
> > 
> > +	/*
> > +	 * Let's initially set up CLKO with OSC24M, since this configuration
> > +	 * is widely used by imx6q board designs to clock audio codec.
> > +	 */
> > +	ret = clk_set_parent(clk[cko2_sel], clk[osc]);
> > +	if (!ret)
> > +		ret = clk_set_parent(clk[cko], clk[cko2]);
> > +	if (ret)
> > +		pr_warn("failed to set up CLKO: %d\n", ret);
> 
> 
> I don't really like that the clock setup code fiddles with clocks it has
> no knowledge about just because it happens to be correct for several
> boards.

I have to admit it's not the best way to handle it, and I can understand
your concern.  What I like about it is we can remove those board
specific hooks from mach-imx6q.c at least for now.

> 
> I currently have no example where this bites me, so I think I can live
> with it for now. I just wonder what I should do when this clock is used
> for something vital to the system (clocking an FPGA for example?).

Go back to set up CLKO in mach-imx6q.c with board specific hook for the
system?

I think I chose to change the default CLKO setup for audio use case, as
all the users we've seen so far is audio codec.  I can still have this
setup done in mach-imx6q.c with of_machine_is_compatible() check on all
those board.  But that also means we need to register lookups for those
CLKO clocks and call clk_get_sys() to get them.

Shawn
