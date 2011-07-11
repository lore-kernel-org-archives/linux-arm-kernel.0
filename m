From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 11 Jul 2011 11:28:56 +0100
Subject: [PATCH 0/6] clk: Initial feedback for off-SoC slow bus clocks
In-Reply-To: <20110711100759.GG26347@pengutronix.de>
References: <20110711025344.GA27497@opensource.wolfsonmicro.com>
	<20110711093124.GA3239@n2100.arm.linux.org.uk>
	<20110711100759.GG26347@pengutronix.de>
Message-ID: <20110711102856.GG3239@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2011 at 12:07:59PM +0200, Sascha Hauer wrote:
> On Mon, Jul 11, 2011 at 10:31:24AM +0100, Russell King - ARM Linux wrote:
> > On Mon, Jul 11, 2011 at 11:53:44AM +0900, Mark Brown wrote:
> > > The biggest issue I ran into was that as the clocks are all registered
> > > by name with the API if you've got two instances of the same off-SoC
> > > device in the system you'll not be able to disambiguate between the
> > > clocks it provides.
> > 
> > Sigh.  That sounds like yet more trash.  Obviously whoever thought
> > up that doesn't actually understand clks.
> 
> Nope. In the patches Jeremy posted clocks have a name, but this name
> is not meant to be used with clk_get. clk_get is still implemented
> in clkdev, so the matching between clocks and devices is independent
> of the clock name.
> 
> In earlier versions of Jeremys patches the clock name was only present
> when debugfs was compiled in and I think it can be changed back to this.
> 
> That said the debugfs support (which is not present in Jeremys latest
> series) would break if two clocks with the same name have the same
> parent, because the clock core would try to create to debugfs entries
> with the same name.

If that's all its for, then can't some other solution for debugfs names
(lets stop calling them clock names to avoid confusion) be found -
such as

	sprintf(debugfsname, "%s@%p", clk->debugfsprefix, clk);

Or how about using something like this:

$debugfs/clkdev/device/connection -> ../../clk/<name-of-clk>
$debugfs/clk/<name-of-clk>

where <name-of-clk> could just be the address of the struct clk (which
eliminates the need to pass any names in) or some prefix plus an
incrementing identifier, or just an incrementing number.

I did think about introducing such a scheme along with clkdev (and did
have some code but that's long gone), but without the $debugfs/clk/ bit
being standardized, it wouldn't have worked.
