From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 17 Nov 2011 09:18:34 +0800
Subject: [PATCH] arm: mx28: check for gated clocks when setting saif
 divider
In-Reply-To: <20111116135125.GE2596@pengutronix.de>
References: <1315650583-4793-1-git-send-email-w.sang@pengutronix.de>
 <20111116132222.GD2596@pengutronix.de>
 <65EE16ACC360FA4D99C96DC085B3F7722D4E65@039-SN1MPN1-002.039d.mgd.msft.net>
 <20111116135125.GE2596@pengutronix.de>
Message-ID: <20111117011833.GD14656@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2011 at 02:51:26PM +0100, Wolfram Sang wrote:
> On Wed, Nov 16, 2011 at 01:35:04PM +0000, Dong Aisheng-B29396 wrote:
> > > -----Original Message-----
> > > From: Wolfram Sang [mailto:w.sang at pengutronix.de]
> > > Sent: Wednesday, November 16, 2011 9:22 PM
> > > To: linux-arm-kernel at lists.infradead.org
> > > Cc: Sascha Hauer; Guo Shawn-R65073; Dong Aisheng-B29396
> > > Subject: Re: [PATCH] arm: mx28: check for gated clocks when setting saif
> > > divider
> > > 
> > > On Sat, Sep 10, 2011 at 12:29:43PM +0200, Wolfram Sang wrote:
> > > > Like with all other clocks, the divider for the SAIF devices should
> > > > not be altered when the clock is gated. Bail out when this is the case
> > > > like the other clocks do.
> > > >
> > > > Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> > > > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > > > Cc: Shawn Guo <shawn.guo@freescale.com>
> > > > Cc: Dong Aisheng-B29396 <B29396@freescale.com>
> > > > ---
> > > >
> > > > Aisheng: I think this is the correct solution for clock-mx28.c. If
> > > > setting the rate of the saif clocks hit the error path, it should be
> > > fixed in the driver?
> > > 
> > > Ping. Trying to catch up, has this been resolved meanwhile?
> > > 
> > Sorry, I missed this patch.
> > 
> > If I understand right, the convention way is to clk_set_rate() then
> > clk_enable().I f that, is it reasonable for driver to do something like:
> > Clk_enable -> clk_set_rate->clk_disable to set a proper rate,
> > then when needs the clock on, do clk_enable again?
> 
> Confused, do you really mean enable -> set_rate -> disable? Because you
> can't set clocks when they are enabled?
> 
> Well, to be honest, this is all is not very nice due to mxs
> restrictions.

When the code was written, it inherited the restriction from FSL
internal code.  I doubt the restriction is the hardware one, and I
would try to remove the restriction when migrating to common clock
framework.

> I chose this approach because this is the common pattern
> in all other clocks. There might be a better way of handling this, but
> then we'd need to adapt all other clocks as well. What we definately
> should not have is one kind of handling the 'already enabled' case for a
> few clocks and another kind for others.
> 
What about leaving it as it is for now, and try to consolidate when
we rework the code for common clock framework migration?

-- 
Regards,
Shawn
