From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Wed, 16 Nov 2011 14:23:01 +0000
Subject: [PATCH] arm: mx28: check for gated clocks when setting saif
 divider
In-Reply-To: <20111116135125.GE2596@pengutronix.de>
References: <1315650583-4793-1-git-send-email-w.sang@pengutronix.de>
 <20111116132222.GD2596@pengutronix.de>
 <65EE16ACC360FA4D99C96DC085B3F7722D4E65@039-SN1MPN1-002.039d.mgd.msft.net>
 <20111116135125.GE2596@pengutronix.de>
Message-ID: <65EE16ACC360FA4D99C96DC085B3F7722DA330@039-SN1MPN1-002.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Wolfram Sang [mailto:w.sang at pengutronix.de]
> Sent: Wednesday, November 16, 2011 9:51 PM
> To: Dong Aisheng-B29396
> Cc: linux-arm-kernel at lists.infradead.org; Sascha Hauer; Guo Shawn-R65073
> Subject: Re: [PATCH] arm: mx28: check for gated clocks when setting saif
> divider
> 
> On Wed, Nov 16, 2011 at 01:35:04PM +0000, Dong Aisheng-B29396 wrote:
> > > -----Original Message-----
> > > From: Wolfram Sang [mailto:w.sang at pengutronix.de]
> > > Sent: Wednesday, November 16, 2011 9:22 PM
> > > To: linux-arm-kernel at lists.infradead.org
> > > Cc: Sascha Hauer; Guo Shawn-R65073; Dong Aisheng-B29396
> > > Subject: Re: [PATCH] arm: mx28: check for gated clocks when setting
> > > saif divider
> > >
> > > On Sat, Sep 10, 2011 at 12:29:43PM +0200, Wolfram Sang wrote:
> > > > Like with all other clocks, the divider for the SAIF devices
> > > > should not be altered when the clock is gated. Bail out when this
> > > > is the case like the other clocks do.
> > > >
> > > > Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> > > > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > > > Cc: Shawn Guo <shawn.guo@freescale.com>
> > > > Cc: Dong Aisheng-B29396 <B29396@freescale.com>
> > > > ---
> > > >
> > > > Aisheng: I think this is the correct solution for clock-mx28.c. If
> > > > setting the rate of the saif clocks hit the error path, it should
> > > > be
> > > fixed in the driver?
> > >
> > > Ping. Trying to catch up, has this been resolved meanwhile?
> > >
> > Sorry, I missed this patch.
> >
> > If I understand right, the convention way is to clk_set_rate() then
> > clk_enable().I f that, is it reasonable for driver to do something like:
> > Clk_enable -> clk_set_rate->clk_disable to set a proper rate, then
> > when needs the clock on, do clk_enable again?
> 
> Confused, do you really mean enable -> set_rate -> disable? Because you
> can't set clocks when they are enabled?
> 
Yes.

> Well, to be honest, this is all is not very nice due to mxs restrictions.
Yes, it's truly not comfortable for drivers know this restrictions
(not handled by clock code).

> I chose this approach because this is the common pattern in all other
> clocks. There might be a better way of handling this, but then we'd need
> to adapt all other clocks as well. What we definately should not have is
> one kind of handling the 'already enabled' case for a few clocks and
> another kind for others.
> 
I agree with you point here.
I was wondering formerly that maybe we can handle this restriction in clock code
that not make clk_set_rate function blocked by clock is still not enable issue.
I know that all other clocks are using the pattern as you said now.
If we decide to follow that pattern, I will agree (although not comfortable)
and update the driver side.

Regards
Dong Aisheng
