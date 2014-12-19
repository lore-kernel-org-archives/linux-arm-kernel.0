From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 19 Dec 2014 02:15:59 +0000 (UTC)
Subject: regression: Clock changes in next-20141205 break at least
 omap4
In-Reply-To: <20141218233739.29014.73421@quantum>
References: <20141212194238.20398.33333@quantum> <548F8B70.2060803@nvidia.com>
 <5490816E.7060706@codeaurora.org> <54908F8D.2020202@nvidia.com>
 <20141216202301.GF11502@n2100.arm.linux.org.uk>
 <alpine.DEB.2.02.1412162034420.3102@utopia.booyaka.com>
 <20141216205754.GG11502@n2100.arm.linux.org.uk>
 <alpine.DEB.2.02.1412162159270.3102@utopia.booyaka.com>
 <1418809957.3347.1.camel@pengutronix.de>
 <alpine.DEB.2.02.1412181717450.3102@utopia.booyaka.com>
 <20141218233739.29014.73421@quantum>
Message-ID: <alpine.DEB.2.02.1412190034040.3102@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 18 Dec 2014, Mike Turquette wrote:

> Quoting Paul Walmsley (2014-12-18 11:23:07)
>
> > Flipping over from hardware to software, in the Linux clock tree, there's 
> > usually not much point to modeling the VCO/DCO directly because it tends 
> > not to be under the direct control of the OS, and it is usually tightly 
> > integrated into the PLLs from a hardware point of view.  But unlike most 
> > of the Linux clock tree nodes that are downstream from clock sources, 
> > which use clocks that are electrically driven by the clock source, the 
> > clock signal that PLLs and PLL-like clocks generate is not directly driven 
> > by the reference clock.
> 
> Hi Paul,

Hi Mike,

> This is debatable given that the formula to determine the OMAP DPLL 
> output rate directly depends upon the rate of the input clock (osc, 
> 32Khz, hsd, bypass, etc). I'm not speaking for all PLLs, just for the 
> OMAP ones that I am familiar with.

The frequency and phase noise characteristics of the PLL's output signal 
are partially a function of the reference clock.  But that's only because 
the reference clock is used to steer the VCO.  It's not because the 
reference clock itself appears on the PLL output.  Even if the reference 
clock dividers and VCO loop dividers were both set to divide-by-one, the 
reference clock still would not appear on the PLL output - merely a 
simulacrum of it, originating by the VCO.  The PLL's output clock is, 
electrically, directly driven by the VCO.

Page 5 of this PDF has a nice frequency synthesis PLL block diagram with 
integer dividers:

    http://www.ti.com/lit/an/swra029/swra029.pdf

To rephrase, if, in the block diagram above, one were to remove everything 
from the TCXO reference clock on the left to the triangle to the left of 
the VCO, and to replace all that with a constant voltage input to the VCO, 
you'd still get a clock signal out of the IP block, even though the 
reference clock would no longer exist.

> > So why is a reference clock listed as a Linux parent clock of an OMAP PLL?  
> > At least for OMAP, it was sort of shoehorned in to represent a gating 
> > dependency.  It was a way of stating that the reference clock had to be 
> > enabled for the PLL to generate an output clock.  (The off-chip crystal 
> > oscillator that drives most of the PLL reference clocks could be disabled 
> > when all of its users were idle, to save energy.)  But this type of gating 
> > dependency is equally true for, say, a separate functional clock that the 
> > clock source requires in order to operate.  (OMAP PLLs didn't have a 
> > separate functional clock, at least not that I was aware of; but that's 
> > not true for some similar clock sources used in other SoCs.)
> 
> Using your terminology above, it is possible to do what you want to do
> today without any change to the clock framework. Simply make each DPLL a
> device. That device calls clk_get, clk_prepare_enable on the input
> reference clock. 

I think I did something like that with the Tegra DFLL driver last year.  
Except the clock provider device was the DFLL IP block itself, with its 
own registers, etc., and not an additional abstraction, if I recall 
correctly.

My interest is mostly to determine whether some of that special-case code 
can be converted into data that the CCF core can operate on, in a 
consistent manner that would be useful across platforms, and in a way that 
several people could potentially agree on.

> Coincidentally these new DPLL device are clock providers themselves and 
> they provide root clocks of their own which are the DPLLs and 
> corresponding Mx outputs. This model would treat the reference clock as 
> something that drives the DPLL device's logic, but not as a part of the 
> clock signal chain.
> 
> I don't personally agree with the idea that the reference clock is not a
> parent of the DPLL,

I'd be interested to know how you would define a parent clock, if it 
differs from the electrical "source clock" definition that I mentioned.

The Linux clock tree is a software abstraction.  So one could define 
"parent clock" however one wishes.  (That's not to say that all 
definitions are equally useful...) 

One could state, for example, that a parent clock is any clock that has 
some effect on the output of the child clock.  That would be one 
definition which might be consistent with your comments.  The problem with 
that is that it means that a clock can have multiple simultaneously-active 
parents, which I'd na?vely think we'd want to avoid, if we could.

I also have to admit that my bias is towards definitions with some kind of 
relationship to the hardware, which helps avoid the "utter relativism" 
problem that you mention below.

> but I don't oppose any change to the OMAP clock driver along those lines 
> so long as it is done in a sane way. It seems there is never just one 
> correct way to look at these things.

I'd say that to the extent that one could come up with concrete 
definitions for terms like "parent clocks," it allows others to reason 
about how the CCF should work, helps distinguish between data and code 
changes that do and don't make sense, and helps others understand which 
changes might be acceptable to maintainers.

> > The clock framework wasn't re-entrant back then, and we wanted to avoid 
> > implementing re-entrancy because we were worried that it could turn into a 
> > mess.  So we just wound up listing the reference clock as the PLL's Linux 
> > parent clock.
> > 
> > My original comment was just intended to be a reflection on what it means 
> > to be a "parent clock" in the Linux clock tree sense.  If it's intended to 
> > represent "source clocks" as they are defined above, then PLLs and 
> > PLL-like clocks should be root nodes, except for the few cases where it's 
> > useful to add a node for the underlying source oscillator directly (for 
> > example, if open-loop mode is supported).
> > 
> > This might be the right way forward for the time being, and I like the 
> > idea of stating that Linux parent clocks should represent electrical 
> > "source clock" relationships.  
> > 
> > That raises the question of what to do about the additional gating 
> > relationships.  At the moment, the clock type code needs to be responsible 
> > for calling clk_enable() etc. on all of the reference and functional 
> > clocks that need to be ungated for the clock source to work.  But it has 
> > always seemed preferable to me to represent fundamental hardware 
> > structural constraints in data.  If the data structures are well-defined, 
> > then the data should be relatively easy to analyze, reason about, 
> > generate, validate, share across platforms, and operate upon iteratively; 
> > unlike custom per-clocktype code, which often isn't.
> 
> I completely agree that the interfaces and abstractions in the clock
> framework do not scale well. As an example, there could be much more
> reuse if callbacks such as .get_best_div() existed and the large variety
> of .round_rate() implementations could be replaced by a single generic
> one.
> 
> Easier mixing and matching of callbacks would be great as well. We don't
> quite have polymorphism but something better could be achieved than the
> complex clock type. Namely the ability to combine various clock hardware
> ops at run-time without having to always generate unique struct clk_ops
> per platform.
> 
> I think there are lots of ideas out there on how to improve this stuff.

Oh, just in case it isn't clear, my objective wasn't to criticize the 
existing CCF.  Just thinking that if it was possible to come to an 
agreement on how to define some of these entities, it might make it easier 
to reason together about ways to work on the core code and data 
structures.  I'd hate to spend a bunch of time working on changes that you 
would eventually nack because we might not agree on what a parent clock is 
:-)


- Paul
