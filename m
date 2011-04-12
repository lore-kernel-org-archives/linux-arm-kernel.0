From: will.deacon@arm.com (Will Deacon)
Date: Tue, 12 Apr 2011 19:08:42 +0100
Subject: [RFC] Extending ARM perf-events for multiple PMUs
In-Reply-To: <4DA368A3.5080602@codeaurora.org>
References: <1302282912.5758.25.camel@e102144-lin.cambridge.arm.com>
	<4DA33A71.6010804@codeaurora.org>
	<1302544807.24286.83.camel@e102144-lin.cambridge.arm.com>
	<4DA368A3.5080602@codeaurora.org>
Message-ID: <1302631722.24286.113.camel@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-04-11 at 21:46 +0100, Ashwin Chaugule wrote:
> Hi Will,

Hello,

> On 4/11/2011 2:00 PM, Will Deacon wrote:
> >
> > I don't think that's enough from a profiling perspective because the
> > state of the device will be altered by other tasks. For example, the
> > number of misses in the L2 cache for a given task is going to be
> > affected by the other tasks running in the system, even if we only
> > profile during the period in which the task is running.
> 
> I'm probably missing something. If another task affects the cache
> contents, this will manifest as an increase in cache misses/hits for the
> task that is being profiled during this interval. This will also happen
> when interrupts trigger and wipe out cache lines anyway. IOW, a counter
> thats counting events from CPU0, will not increment, if the event it is
> counting gets affected by CPU1.

How can you enforce this? If a task on CPU1 has a large working set and
clobbers all of L2, then a task on CPU0 will have no choice but to miss
at L2 if it misses at L1. I think this scenario is similar for all PMUs
that have multiple masters.

> >>
> >> For the Qcom L2CC, the PMU can be configured to filter events based on
> >> specific masters. This fact would make it a CPU-aware PMU, although its
> >> NOT per-core and triggers SPI's.
> >
> > I have a similar issue with this; filtering based on the master *isn't*
> > the same as having per-master samples, simply because the combined
> > effect of the masters will influence all of the results. That doesn't
> > mean that the filtering feature isn't useful, just that it should be
> > described in the event encoding rather than by pretending to support
> > per-CPU events.
> 
> I'll talk with the h/w guys who designed this, but from the spec it seems
> like each event either has an Origin ID, or is Origin independent. If the
> event has an OID, then the counter should *not* be counting the effect of
> the other masters.

Ok, some feedback from the hardware guys would be useful so we know what
we're dealing with. However, we still have some other problems for these
system PMUs if you want to allow the events to specify CPU affinity:

 - What do you do if there are more masters than CPUs?
 - How do you handle mixing events that can be filtered by origin with
those that can't?

So another argument for avoiding CPU affinity is simply that it
complicates the code. I think this complication is unnecessary if we can
get perf working with CPU=1, pid=-1 (I fear there may be locking issues
but I don't know yet). You can specify masters in the event encoding
instead which has the benefit of forcing userspace to think more
carefully about what they are doing (rather than erroneously attributing
samples to CPUs) and also providing more flexibility (for example, if
you have an event that counts interactions between two CPUs - which one
do you attribute it to?).

> >
> >> Also, having all this origin filtering logic helps us track per-process
> >> events on these PMU's, for which we need extra functions to decide how to
> >> allocate and configure counters based on which context (task, cpu) the
> >> event is enabled in.
> >
> > I don't think we should go down the road of splitting up the counters on
> > a given PMU so that they can be shared between different tasks on
> > different CPUs. There will probably be a single control register, so
> > keeping everything in sync will be impossible.
> 
> So, for the L2CC on the 8660 (AFAIK, even the bus/fabric monitors), each
> counter has its own origin filter. So the various counters can count from
> different masters at different profiling intervals.

Ok, that tidies this problem up nicely in this case but for other PMUs
we might not be as fortunate.

Cheers,

Will
