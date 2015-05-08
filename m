From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 8 May 2015 08:22:46 +0100
Subject: [PATCH v6 4/4] clk: dt: Introduce binding for always-on clock
 support
In-Reply-To: <20150507212052.GM11057@lukather>
References: <20150408103832.GG5162@x1> <20150408155705.GF26727@lukather>
 <20150408172344.GH5162@x1> <20150422093446.GA28007@lukather>
 <20150429141751.GR9169@x1> <20150429202332.GG6062@lukather>
 <20150430095722.GB1815@x1> <20150501053406.GI4946@pengutronix.de>
 <20150501064405.GB4047@x1> <20150507212052.GM11057@lukather>
Message-ID: <20150508072246.GH16220@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 07 May 2015, Maxime Ripard wrote:

> On Fri, May 01, 2015 at 07:44:05AM +0100, Lee Jones wrote:
> > > > Does Sascha's antidote patch change your opinion?  We can use DT to
> > > > declare critical clocks, and in the rare case of the introduction of a
> > > > new DDRFreq-like feature, which doesn't adapt the DT will still be
> > > > able to unlock the criticalness of the clock and use it as expected?
> > > 
> > > Honestly I'm not very fond of declaring these in the device tree, but
> > 
> > I know why you guys are saying that, but I'd like you to understand
> > the reasons for me pushing for this.  Rather than be being deliberately
> > obtuse, I'm thinking of the mess that not having this stuff in DT will
> > cause for clock implementations like ours, which describe more of a
> > framework than a description.
> 
> The DT should dictate our implementation, not the other way around. I
> know that we are pretty bad at doing this, and that there's some clear
> abstraction violations already widely used, but really, using this
> kind of argument is pretty bad.

I guess then you haven't correctly understood my argument, as that's
exactly what's happened.  We have a DT implementation which accurately
describes the clock architecture on each of our platforms. The
associated C code in drivers/clk/ is written to extract the
information from it, the hardware description and register the clocks
properly.

What makes you think differently?

> The DT can (and is) shared between several OS and bootloaders, what if
> the *BSDs or barebox, or whatever, guys come up with the exact same
> argument to make a completely different binding?
> 
> We'd end up either in a deadlock, or forcing our solution down the
> throat to some other system. I'm not sure any of these outcomes is
> something we want.

Not sure I understand why this is different from any other binding?

> > The providers in drivers/clock/st are blissfully ignorant of platform
> > specifics.  Per-platform configuration is described in DT.
> 
> Maybe they just need a small amount of education then.

Easy to say (and implement), but that means duplicating the hardware
description in DT, which is not a design win.

> > So we'd have 2 options to use a C-only based API; 1) duplicate
> > platform information in drivers/clk/st, or 2) supply a vendor
> > specific st,critical-clocks binding, pull out those references then
> > run them though the aforementioned framework.  It is my opinion that
> > neither of those methods are desirable.
> 
> 3) have a generic solution for this in the clock framework, like Mike
> suggested.

Did you actually read and understand the points here?  If not, just
say so and I'll figure out a way to explain the issues better.  3) is
not an alternative to 1) and 2).  Instead 1) and 2) imply 3).

I *want* to have a generic solution, and have made several passes at
writing one.  The question here is; what does that look like?  Some
people don't like the idea of having it in DT due to possible abuse of
the property.  But we can't have anything only in C because our clock
implementation (rightly) doesn't know or (shouldn't have to) care
about platform specifics.  Instead all platform description is in DT,
where it should be.  So to specify critical-clocks we need either 1)
or 2) above to pull the info out and send to 3).

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
