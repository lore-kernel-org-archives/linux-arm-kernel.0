From: rusty@rustcorp.com.au (Rusty Russell)
Date: Wed, 28 Mar 2012 16:39:31 +1030
Subject: [PATCH] ARM: test for PMU feature on v7 (v2 with typo fix)
In-Reply-To: <20120326094054.GA2475@mudshark.cambridge.arm.com>
References: <4F590411.9060201@arm.com> <87ty1g88dv.fsf@rustcorp.com.au>
 <87r4wk889a.fsf@rustcorp.com.au>
 <20120323095314.GA13622@mudshark.cambridge.arm.com>
 <87fwcy9abw.fsf@rustcorp.com.au>
 <20120326094054.GA2475@mudshark.cambridge.arm.com>
Message-ID: <87pqbx9rz8.fsf@rustcorp.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 26 Mar 2012 10:40:54 +0100, Will Deacon <will.deacon@arm.com> wrote:
> [removed some dead email addresses from CC]

Thanks!

> On Fri, Mar 23, 2012 at 11:17:07PM +0000, Rusty Russell wrote:
> > I had assumed that as we trend towards a common cross-platform kernel,
> > we should be relying on feature registers where available, not the
> > model.
> 
> The PMU is very tightly coupled with the CPU and it is necessary to know
> exactly which CPU you have so that you can map microarchitectural events to
> their identifiers. This is not discoverable in the architecture [PMUv2
> provides some support for discovering the status of architected events, but
> that is still not enough and is only present on A7 and A15 so far] so that's
> why we probe the CPU instead.

OK.

> Now, if everything was device-tree based then we could simply use a
> different binding for each CPU but since we support perf on non-DT
> platforms, probing the CPU type is the best solution. I would like to avoid
> the probing code if we are initialised from DT, but I've not got round to it
> yet (this would be useful for big.LITTLE).

I'll be interested to see how you encode the mapping of
microarchitectural events to their identifiers here.

> > > Would you be able to advertise 0 event counters instead and treat the PMU
> > > largely as RAZ/WI? The only tricky bit I can see is the cycle counter, which
> > > is mandated by the presence of a PMU, however this could also just RAZ
> > > initially.
> > 
> > Yes, that's the effect of the current emulation hack.  Far better not to
> > lie to the guest, however, than get weird results from profiling.
> 
> I'd rather lie to the guest than modify it just to avoid emulating the
> device correctly. Even then, the profiling results wouldn't be especially
> weird -- everything would be 0, which is a lot better than random
> numbers.

Sure, but nowhere as neat an experience as having "no hardware support
available" printed, and nicely defined failure mode :(

When I get back in May, I'll look at how hard it will to be implement
this properly, if noone else does.

Thanks,
Rusty.
-- 
  How could I marry someone with more hair than me?  http://baldalex.org
