From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 29 Sep 2015 11:30:10 +0100
Subject: [PATCH] arm-cci500: Workaround pmu_event_set_period
In-Reply-To: <560A562C.9060508@arm.com>
References: <1443196253-22765-1-git-send-email-suzuki.poulose@arm.com>
 <20150928153813.GA27704@leverpostej> <560A562C.9060508@arm.com>
Message-ID: <20150929103010.GA5622@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> > Does reset work while the counters are clock gated?
> 
> No. It doesn't. Both PMCR.CEN and Count Control should be turned on to
> alter the value of the counter.  

Ok. I take it PMCR.CEN is global and Count Control is per-counter?

> > I take it that we can configure the counters while they are disabled,
> > even if we can't alter the counter value?
> 
> We can program the events for the counter, but we can't alter the counter
> value.

Ok, that's something, at least.

> >> So we cannot reliably use the counters and compute the number of events
> >> generated during the sampling period since we don't have the value of the
> >> counter at start.
> >>
> >> Here are the possible solutions:
> >>
> >>   1) Disable clock gating on CCI-500 by setting Control_Override_Reg[bit3].
> >>      - The Control_Override_Reg is secure (and hence not programmable from
> >>        Linux), and also has an impact on power consumption.
> >>
> >>   2) Change the order of operations
> >> 	i.e,
> >> 	a) Program and enable individual counters
> >> 	b) Enable counting on all the counters by setting PMCR.CEN
> >> 	c) Write the period to the individual counters
> >> 	d) Disable the counters
> >>      - This could cause in unnecessary noise in the other counters and is
> >>        costly (we should repeat this for all enabled counters).
> >>
> >>   3) Don't set the counter value, instead use the current count as the
> >>      starting count and compute the delta at the end of sampling.
> >
> > This leaves us less broken than we currently are, but as far as I can
> > tell, this leaves us back where we started, with the overflow issues
> > seen elsewhere, cf:
> >
> > a737823d37666255 ("ARM: 6835/1: perf: ensure overflows aren't missed due to IRQ latency")
> > 5727347180ebc6b4 ("ARM: 7354/1: perf: limit sample_period to half max_period in non-sampling mode")
> 
> Thanks for the pointers. Even now, without this change, theoretically
> we could run into the overflow, isn't it ? So we should fix it for ever.

It's not really fixable as such (given sufficiently frequent events and
large enough IRQ latency there's simply nothing you can do). The current
behaviour on CCI-400 is about the best we can do, so we should aim for
that on CCI-500 if possible.

> > We could get rid of the flag and always do:
> >
> > 	pmu_write_counter(event, 1UL << 31);
> > 	val = pmu_read_counter(event);
> >
> > That should work for CCI-400 and CCI-500, and if the CCI-500 counters
> > aren't clock-gated (e.g. because of FW configuration) then we get the
> > period that we actually wanted.
> 
> Yes, thats looks neater. I will change it with some comments in there.

Great.

That still leaves us with racy overflow handling on a clock gated
CCI-500 PMU, which we should aim to avoid if possible.

> > However, can't we use an event which won't count to solve the race with
> > option 2?
> 
> Even if we found one, won't we have to set the 'no-op' event on all counters,
> if we want to change a counter value to prevent other counters from counting?

Can't we just clear the counter_enable bits for the other counters?

We could handle that in pmu_{disable,enable} to amortize the cost (or
even do it lazily on the first re-programming).

> And it gets complicated with/without event grouping.

I don't see why grouping would be any more complicated by this. What am
I missing?

> > Per the TRM, events for unimplemented interfaces don't count, though I'm
> > not sure if there's an event that's guaranteed to not count in all
> > configurations. Perhaps we might be able to dig one up.
> 
> IIRC, there wasn't any mention about a single event which falls into that
> category. I think solution 3 is much cleaner than finding and using a dummy
> event.

I agree that it is simpler, but it leaves us with a worrying high chance
of coming up with erroneous values, which detracts from the usefulness
of the PMU.

Thanks,
Mark.
