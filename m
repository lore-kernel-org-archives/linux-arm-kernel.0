From: john@metanate.com (John Keeping)
Date: Mon, 26 Sep 2016 18:04:39 +0100
Subject: [PATCH 1/2] clk: rockchip: add I2S internal clock IDs for rk3288
In-Reply-To: <21692410.II2VYnELL8@phil>
References: <20160907165330.14607-1-john@metanate.com>
 <2003903.QOgKKA6m1b@phil>
 <20160907191823.7f955ae2.john@metanate.com>
 <21692410.II2VYnELL8@phil>
Message-ID: <20160926180439.64a16cf1.john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 25 Sep 2016 23:50:29 +0200, Heiko Stuebner wrote:

> Am Mittwoch, 7. September 2016, 19:18:23 CEST schrieb John Keeping:
> > On Wed, 07 Sep 2016 19:58:31 +0200, Heiko Stuebner wrote:  
> > > Am Mittwoch, 7. September 2016, 17:53:29 CEST schrieb John Keeping:  
> > > > To minimize jitter on the I2S clocks, it is important that the
> > > > denominator in the fractional divider is much greater than the
> > > > numerator.  Add identifiers for these internal clocks so that the
> > > > specific clock topology and rates can be specified in the device tree.  
> > > 
> > > The TRM states that the denominator must be bigger than 20. Is this the
> > > one
> > > you found or did you find further constraints?  
> > 
> > Is it not that the denominator must be bigger than 20 times the
> > numerator?  That's what we found, although it seems that the greater the
> > divisor the better, so our aim is dividing down from 594MHz from GPLL to
> > the target rate in i2s_frac.  
> 
> That is good to know ... the TRM probably lost the real information during 
> translation or so and only states that hard value. Looking at the rk3368 TRM 
> just now, the value really is 20 times greater than the numerator.
> 
> 
> > > Did you try teaching the fractional divider to handle these constraints
> > > before going this way?  
> > 
> > No, I hadn't looked at doing that.  I'm not sure how that would work,
> > we'd need to add support for fractional divider changing the parent rate
> > wouldn't we?  
> 
> Doug had a somewhat similar problem, mentioning the lack of a "bestdiv" 
> equivalent that the standard divider provides. I'm not sure if there isn't a 
> way to provide something like this and/or make the fractional clock honor 
> specific requirments concerning numerator/denominator - any mathematicians 
> around? :-)

Yes, this is difficult, although I expect a simple approach of setting
the input as fast as possible would work reasonably well in practice.
But even when the input is a mux with a fixed set of possible rates it
is difficult to extract its maximum frequency within the clock
framework.

> One could also replace the generic fraction divider use with a rockchip-
> specific implementation that somehow handles that.

I hadn't considered that, I assumed there would be a strong preference
for enhancing the generic code rather than writing a special case
implementation.

> > > Exporting the internal clocks really would be sort of plan d or e, after
> > > handling this in the clock framework failed. Especially as i2s rates are
> > > probably dependant on the media being handled (frequencies and such), so
> > > setting fractional rates statically in the dts won't help you much in the
> > > general case, as any new playback could trigger a clk_set_rate call
> > > anyway?  
> > 
> > We're not setting the fractional rate specifically, instead we're
> > setting the i2s_pre rate and parent explicitly and banning the i2s_src
> > mux setting to i2s_pre, which means that clk_set_rate on sclk_i2s0 will
> > always change i2s_frac but leave i2s_pre alone.  
> 
> But then you are again in the situation where some requested rate can ignore 
> those fractional-divider constraints? In general I really don't like encoding 
> such board-specific behaviour into the generic clock tree, like needing to 
> disable parent relationships.

Yes, I wouldn't suggest changing the clock mux in the upstream kernel.
I was hoping specifying an assigned parent in DT would be enough to keep
the parent set correctly, but it doesn't seem to be.

> It works for your board now but does not necessarily for all other boards, 
> which might require other "hacks" and also doesn't solve the general problem 
> for all other fractional dividers we have.

The sensible heuristic is to minimize the length of the clock path when
there are two equally good routes, which would handle the case where the
I2S clock can be generated without the need for a fractional divider.
But I don't think the clock framework has any way to take into account
that a mux may end up bypassing another clock.

It seems that even without the fractional divider we can't get low
enough jitter to meet our requirements, so we've decided to use an
external clock for I2S.  As a result of that, we're no longer using this
part of the clock tree at all, so I'm happy to drop these patches.


John
