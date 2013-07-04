From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 04 Jul 2013 16:19:53 -0700
Subject: [RFC] clk: add flags to distinguish xtal clocks
In-Reply-To: <1372977465.21065.136.camel@cumari.coelho.fi>
References: <1372971912-10877-1-git-send-email-coelho@ti.com>
 <20130704222538.10823.2559@quantum>
 <1372977465.21065.136.camel@cumari.coelho.fi>
Message-ID: <20130704231953.10823.94331@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Luciano Coelho (2013-07-04 15:37:45)
> On Thu, 2013-07-04 at 15:25 -0700, Mike Turquette wrote:
> > Quoting Luciano Coelho (2013-07-04 14:05:12)
> > > Add a flag that indicate whether the clock is a crystal or not.  Since
> > > no clocks set this flag right now, include an additional flag that
> > > indicates whether the type is set or not.  If the CLK_IS_TYPE_DEFINED
> > > flag is not set, the value of the CLK_IS_TYPE_XTAL flag is undefined.
> > > This ensures backwards compatibility.
> > > 
> > > Additionally, parse a new device tree binding in clk-fixed-rate to set
> > > this flag.
> > > 
> > > Signed-off-by: Luciano Coelho <coelho@ti.com>
> > > ---
> > > 
> > > I'm not  familiar with the common clock framework and I'm not
> > > entirely sure the flags can be used in such a way, but to me it looks
> > > reasonable, since some clock consumers may need to know what type of
> > > clock is being provided.
> > > 
> > > Specifically, the wl12xx firmware needs to know if the clock is XTAL
> > > or not to handle the stabilization and boosts properly.
> > 
> > Hi Luciano,
> 
> Hi Mike,
> 
> > I'd like clarification on one point. Is the same clock input signal used
> > on the wifi chip? What I mean is, are there multiple clock inputs and
> > XTAL is one, and not-XTAL is another?
> 
> This wifi chip can work with a few different clocks and some of them are
> XTAL and others are not.  What the chip's firmware can use is one of
> these:
> 
> 19.2MHz (not XTAL)
> 26.0MHz (not XTAL)
> 26.0MHz (XTAL)
> 38.4MHz (not XTAL)
> 38.4MHz (XTAL)
> 52.0MHz (not XTAL)
> 
> It treats the XTAL clocks differently (but I don't really understand
> enough of the details), so the driver needs to configure the firmware
> according to these values.

Thanks for the explanation.

> 
> 
> > Or is it the same clock input and basically the problem is that you need
> > to know what kind of waveform to expect (e.g. square versus sine)?
> 
> It's the same clock input in the chip's perspective.  One clock input
> that can be any of the combinations I mentioned above.  Again, I'm not
> familiar with clocks, so I guess the square vs. sine explanation is
> plausible.  What I could see in the firmware is that it handles the
> clocks differently if they're xtal or not.

OMAP has a similar thing where sys_clkin (the fast reference clock for
the chip) can be 19.2, 26, 38.4, etc. This is easy to handle since only
the rates matter.

In your case you need some extra metadata to know what to do. I'm really
not sure if CLK_IS_TYPE_XTAL is the most useful form this metadata can
take. It would be best to know if the waveform is what you really need
to know, or perhaps something else. For instance you might be affected
by some clock signal stabilization time. Can you talk to your hardware
guys and figure it out? I'd rather model the actual needs instead of
just tossing a flag in there.

Regards,
Mike

> 
> --
> Luca.
