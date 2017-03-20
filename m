From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 20 Mar 2017 10:21:36 +0100
Subject: [PATCH] drm/etnaviv: add etnaviv cooling device
In-Reply-To: <20170315140541.GT21222@n2100.armlinux.org.uk>
References: <E1cn8jj-0002mp-SO@rmk-PC.armlinux.org.uk>
 <1489582989.16018.4.camel@pengutronix.de>
 <20170315140541.GT21222@n2100.armlinux.org.uk>
Message-ID: <1490001696.2895.9.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 15.03.2017, 14:05 +0000 schrieb Russell King - ARM
Linux:
> On Wed, Mar 15, 2017 at 02:03:09PM +0100, Lucas Stach wrote:
> > Am Sonntag, den 12.03.2017, 19:00 +0000 schrieb Russell King:
> > > Each Vivante GPU contains a clock divider which can divide the GPU clock
> > > by 2^n, which can lower the power dissipation from the GPU.  It has been
> > > suggested that the GC600 on Dove is responsible for 20-30% of the power
> > > dissipation from the SoC, so lowering the GPU clock rate provides a way
> > > to throttle the power dissiptation, and reduce the temperature when the
> > > SoC gets hot.
> > > 
> > > This patch hooks the Etnaviv driver into the kernel's thermal management
> > > to allow the GPUs to be throttled when necessary, allowing a reduction in
> > > GPU clock rate from /1 to /64 in power of 2 steps.
> > 
> > Are those power of 2 steps a hardware limitation, or is it something you
> > implemented this way to get a smaller number of steps, with a more
> > meaningful difference in clock speed?
> > My understanding was that the FSCALE value is just a regular divider
> > with all steps values in the range of 1-64 being usable.
> 
> I don't share your understanding.  The Vivante GAL kernel driver only
> ever sets power-of-two values.  I have no evidence to support your
> suggestion.
> 
> There's evidence that says your understanding is incorrect however.
> It isn't a divider.  A value of 0x40 gives the fastest clock rate,
> a value of 0x01 gives the slowest.  If it were a binary divider,
> a value of 0x7f would give the slowest rate - so why doesn't Vivante
> use that in galcore when putting the GPU into idle/lower power - why
> do they just 0x01.
> 
> This all leads me to believe that it's not a binary divider, but a
> set of bits that select the clock from a set of divide-by-two stages,
> and having more than one bit set is invalid.
> 
> However, without definitive information from Vivante, we'll never
> really know.  We're unlikely to get that.
> 
Yes, it seems your understanding is correct and my mental model of this
FSCALE thing was off.

I'll pick up this patch for the next round of etnaviv features.

Regards,
Lucas
