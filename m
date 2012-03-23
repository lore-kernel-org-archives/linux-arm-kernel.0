From: rusty@rustcorp.com.au (Rusty Russell)
Date: Sat, 24 Mar 2012 09:47:07 +1030
Subject: [PATCH] ARM: test for PMU feature on v7 (v2 with typo fix)
In-Reply-To: <20120323095314.GA13622@mudshark.cambridge.arm.com>
References: <4F590411.9060201@arm.com> <87ty1g88dv.fsf@rustcorp.com.au>
 <87r4wk889a.fsf@rustcorp.com.au>
 <20120323095314.GA13622@mudshark.cambridge.arm.com>
Message-ID: <87fwcy9abw.fsf@rustcorp.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 23 Mar 2012 09:53:14 +0000, Will Deacon <will.deacon@arm.com> wrote:
> Hi Rusty,
> 
> On Fri, Mar 23, 2012 at 12:34:57AM +0000, Rusty Russell wrote:
> > The v7 ARM (B4.1.82) specifies that bits 27-24 of the ID_DFR0 reg show
> > what performance monitoring (if any) is available.  We should test this
> > before assuming (useful for inside virtualized environments, for example).
> 
> Ok, I can see why you don't want to emulate a PMU but I don't agree with the
> patch :)
...
> >  static struct arm_pmu *__init armv7_a8_pmu_init(void)
> >  {
> > +	if (!armv7_pmu_avail())
> > +		return NULL;
> 
> This code is only executed if we know for sure that we are running on a
> Cortex-A8. Cortex-A8 implementations have a PMU, so I don't like having the
> probe here in case we are running on a virtualised CPU that doesn't quite
> match the hardware.

OK, I see that argument, but I don't like it.  eg. the Cortex A-15 is
defined to have a PMUv2 with 6 counters, and below you're arguing we
should implement zero of them.

I had assumed that as we trend towards a common cross-platform kernel,
we should be relying on feature registers where available, not the
model.

> Would you be able to advertise 0 event counters instead and treat the PMU
> largely as RAZ/WI? The only tricky bit I can see is the cycle counter, which
> is mandated by the presence of a PMU, however this could also just RAZ
> initially.

Yes, that's the effect of the current emulation hack.  Far better not to
lie to the guest, however, than get weird results from profiling.

Cheers,
Rusty.
-- 
  How could I marry someone with more hair than me?  http://baldalex.org
