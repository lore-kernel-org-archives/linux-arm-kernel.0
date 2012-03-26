From: will.deacon@arm.com (Will Deacon)
Date: Mon, 26 Mar 2012 10:40:54 +0100
Subject: [PATCH] ARM: test for PMU feature on v7 (v2 with typo fix)
In-Reply-To: <87fwcy9abw.fsf@rustcorp.com.au>
References: <4F590411.9060201@arm.com> <87ty1g88dv.fsf@rustcorp.com.au>
 <87r4wk889a.fsf@rustcorp.com.au>
 <20120323095314.GA13622@mudshark.cambridge.arm.com>
 <87fwcy9abw.fsf@rustcorp.com.au>
Message-ID: <20120326094054.GA2475@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[removed some dead email addresses from CC]

On Fri, Mar 23, 2012 at 11:17:07PM +0000, Rusty Russell wrote:
> On Fri, 23 Mar 2012 09:53:14 +0000, Will Deacon <will.deacon@arm.com> wrote:
> > On Fri, Mar 23, 2012 at 12:34:57AM +0000, Rusty Russell wrote:
> ...
> > >  static struct arm_pmu *__init armv7_a8_pmu_init(void)
> > >  {
> > > +	if (!armv7_pmu_avail())
> > > +		return NULL;
> > 
> > This code is only executed if we know for sure that we are running on a
> > Cortex-A8. Cortex-A8 implementations have a PMU, so I don't like having the
> > probe here in case we are running on a virtualised CPU that doesn't quite
> > match the hardware.
> 
> OK, I see that argument, but I don't like it.  eg. the Cortex A-15 is
> defined to have a PMUv2 with 6 counters, and below you're arguing we
> should implement zero of them.

Well, I think you should actually implement all 6 of them if that's the
target which you're emulating. However, there are bigger peripherals to fry
than the PMU so if you want to get something working quickly then a dummy
PMU makes sense as a stopgap.

> I had assumed that as we trend towards a common cross-platform kernel,
> we should be relying on feature registers where available, not the
> model.

The PMU is very tightly coupled with the CPU and it is necessary to know
exactly which CPU you have so that you can map microarchitectural events to
their identifiers. This is not discoverable in the architecture [PMUv2
provides some support for discovering the status of architected events, but
that is still not enough and is only present on A7 and A15 so far] so that's
why we probe the CPU instead.

Now, if everything was device-tree based then we could simply use a
different binding for each CPU but since we support perf on non-DT
platforms, probing the CPU type is the best solution. I would like to avoid
the probing code if we are initialised from DT, but I've not got round to it
yet (this would be useful for big.LITTLE).

> > Would you be able to advertise 0 event counters instead and treat the PMU
> > largely as RAZ/WI? The only tricky bit I can see is the cycle counter, which
> > is mandated by the presence of a PMU, however this could also just RAZ
> > initially.
> 
> Yes, that's the effect of the current emulation hack.  Far better not to
> lie to the guest, however, than get weird results from profiling.

I'd rather lie to the guest than modify it just to avoid emulating the
device correctly. Even then, the profiling results wouldn't be especially
weird -- everything would be 0, which is a lot better than random numbers.

Will
