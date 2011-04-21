From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 21 Apr 2011 11:31:17 +0100
Subject: [PATCH RFC] clk: add support for automatic parent handling
In-Reply-To: <alpine.LFD.2.02.1104211045220.3323@ionos>
References: <alpine.LFD.2.00.1104192339180.2744@localhost6.localdomain6>
	<1303308457-7501-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.02.1104201704350.3323@ionos>
	<20110420185922.GD31131@pengutronix.de>
	<alpine.LFD.2.02.1104202113250.3323@ionos>
	<20110421072259.GG31131@pengutronix.de>
	<alpine.LFD.2.02.1104211045220.3323@ionos>
Message-ID: <20110421103117.GB16776@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 21, 2011 at 11:12:36AM +0200, Thomas Gleixner wrote:
> On Thu, 21 Apr 2011, Uwe Kleine-K?nig wrote:

> > If there were a pointer tracking the parent you still needed to program
> > out the get_parent function anyhow to set the pointer initially. But I
> > agree that in other situations having a pointer is more comfortable and
> > saves ugly error handling e.g. in set_parent.

> That's nonsense. Why do you want a get_parent() function at all?
> parent is set up when the clock is established in the clock tree. And
> that's not done by some random driver. That's a property of the clock.

That's not universal - right now the drivers can and do know about this
on some platforms.  In some cases there will be requirements beyond the
clock rate which mean that the driver will need to be able to tell the
framework that, for example, it needs one clock to be in the same clock
domain as another.

> > >    - a field for the base register

> > This is not needed for all clocks (at least not a say void __iomem *). I
> > think it's fine here to leave that to the platforms as it is now.

> Crap. All clocks which are configurable in some way or can be
> enabled/disabled need access register(s) so you need a base address.

That's not reliably the case, some systems have some of the clock tree
(esepcialy the core parts of the tree) controlled by a system management
unit which isn't memory mapped and it's common for I2C or SPI connected
chips to be involved to some extent too.  One advantage we should be
able to get from this framework is that it will be much easier to have
standard drivers for off-SoC chips that could be shared.
