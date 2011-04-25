From: richard.zhao@freescale.com (Richard Zhao)
Date: Mon, 25 Apr 2011 10:03:49 +0800
Subject: [PATCH RFC] clk: add support for automatic parent handling
In-Reply-To: <20110421123542.GE11788@opensource.wolfsonmicro.com>
References: <alpine.LFD.2.00.1104192339180.2744@localhost6.localdomain6>
	<1303308457-7501-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.02.1104201704350.3323@ionos>
	<20110420185922.GD31131@pengutronix.de>
	<alpine.LFD.2.02.1104202113250.3323@ionos>
	<20110421074214.GE15233@pengutronix.de>
	<alpine.LFD.2.02.1104211113030.3323@ionos>
	<20110421115050.GC16776@sirena.org.uk>
	<alpine.LFD.2.02.1104211403130.3323@ionos>
	<20110421123542.GE11788@opensource.wolfsonmicro.com>
Message-ID: <20110425020348.GA6540@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 21, 2011 at 01:35:42PM +0100, Mark Brown wrote:
> On Thu, Apr 21, 2011 at 02:20:22PM +0200, Thomas Gleixner wrote:
> > On Thu, 21 Apr 2011, Mark Brown wrote:
> 
> > > There's nothing intrinsic about the concept of a clock which means that
> > > it needs to be memory mapped or have a particular set of registers for
> > > us to work with.  This sounds like something that ought to be factored
> > > out but it's not obvious to me that it should be part of the core struct.
> 
> > Care to look over the various implementations and find out that a lot
> > of them look like:
> 
> Please bear in mind that due to the fact that we've currently got one
> clock implementation per subarchitecture anything off-SoC has some
> serious barriers to implementation in kernel.  For the system management
> units you'd be looking at very new systems, this is a new development.
How many arch have off-soc clocks? Where's the source? 
At least for arm, nearly all is memory mapped clock registers. clk is free
to override, we just need abstract the most common things.

Thanks
Richard
> 
> > Just in about 100 variations of the theme. Which is basically the same
> > as we have in irq chip implementations. And I showed how much of these
> > things can be factored out when done right. And even if a particular
> > clock does not implement enable/disable calls, then having
> > regs.enable_reg around is not a problem.
> 
> This is why I said "This sounds like something that ought to be factored
> out but it's not obvious to me that it should be part of the core
> struct" above - I agree strongly that we should have a generic memory
> mapped implementation which factors out all the redundant code you'd get
> for these clocks.
> 
> > Because that's what we implement via container_of now. And we can add
> > such stuff which is obvious right away.
> 
> That's exactly the sort of thing I'm suggesting.  You were asking for
> this to be part of struct clk itself, embedding the struct clk in a
> struct mm_clk (or whatever) and having standard ops for the mm_clk a
> much better abstraction.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
