From: will.deacon@arm.com (Will Deacon)
Date: Mon, 11 Apr 2011 19:00:07 +0100
Subject: [RFC] Extending ARM perf-events for multiple PMUs
In-Reply-To: <4DA33A71.6010804@codeaurora.org>
References: <1302282912.5758.25.camel@e102144-lin.cambridge.arm.com>
	<4DA33A71.6010804@codeaurora.org>
Message-ID: <1302544807.24286.83.camel@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-04-11 at 18:29 +0100, Ashwin Chaugule wrote:
> Hi Will,

Hi Ashwin,

> Thanks for the starting the discussion here.
> 
> On 4/8/2011 1:15 PM, Will Deacon wrote:
> >
> >   (1) CPU-aware PMUs
> >
> >       This type of PMU is typically per-CPU and accessed via co-processor
> >       instructions. Actions may be delivered as PPIs. Events scheduled onto
> >       a CPU-aware PMU can be grouped, possibly with events scheduled for other
> >       per-CPU PMUs on the same CPU. An action delivered by one of these PMUs
> >       can *always* be attributed to a specific CPU but not necessarily a
> >       specific task. Accessing a CPU-aware PMU is a synchronous operation.
> >
> 
> I didn't understand when would an action not be attributed to a task in
> this category ? If we know which CPU "enabled" the event, this should be
> possible ?

I don't think that's enough from a profiling perspective because the
state of the device will be altered by other tasks. For example, the
number of misses in the L2 cache for a given task is going to be
affected by the other tasks running in the system, even if we only
profile during the period in which the task is running. I think it's
better to permit only per-CPU events in the this case, attributing the
samples to tasks and letting the user work out what's going on.

> > Now, we currently support the core CPU PMU, which is obviously a CPU-aware PMU
> > that generates interrupts as actions. Another example of a CPU-aware PMU is
> > the VFP PMU in Qualcomm's Scorpion. The next step (moving outwards from the
> > core) is to add support for L2 cache controllers. I expect most of these to be
> > Counting System PMUs, although I can envisage them being CPU-aware if built
> > into the core with enough extra hardware.
> 
> For the Qcom L2CC, the PMU can be configured to filter events based on
> specific masters. This fact would make it a CPU-aware PMU, although its
> NOT per-core and triggers SPI's.

I have a similar issue with this; filtering based on the master *isn't*
the same as having per-master samples, simply because the combined
effect of the masters will influence all of the results. That doesn't
mean that the filtering feature isn't useful, just that it should be
described in the event encoding rather than by pretending to support
per-CPU events.

> In such a case, I found it to be quite ugly trying to reuse the per-cpu
> data structures esp in the interrupt handler, since the interrupt can
> trigger on a CPU where the event wasn't enabled. A cleaner approach was to
> use a separate struct pmu. However, I agree that this approach would lead
> to several pmu's popping up in arch/arm.
> 
I expect to see new struct pmus, I'd just like to try and identify
common patterns before the code mounts up. I imagine that we'll have a
struct pmu for L2 cache controllers, for example, from which people can
hang their own specific accessors. Whether or not we can hang other
system PMUs off such an implementation is unclear to me at the moment.

> So, I think we could add another category for such highly configurable
> PMUs, which are not per-core, but have enough extra h/w to make them
> cpu-aware. These need to be treated differently by arm perf, because they
> can't really use the per-cpu data structures of the cpu-aware pmu's and as
> such can't easily re-use of many of the functions.
> 
> In fact, most of Qcomm PMU's (bus, fabric etc.) will fall under this new
> category. At first glance, these would appear to fall under the System PMU
> (counting) category, but they don't because of the extra h/w logic that
> allows origin filtering of events.

I think they do; they just have some event encodings that monitor events
specific to particular masters (but may not necessarily be attributable
to them).

> Also, having all this origin filtering logic helps us track per-process
> events on these PMU's, for which we need extra functions to decide how to
> allocate and configure counters based on which context (task, cpu) the
> event is enabled in.

I don't think we should go down the road of splitting up the counters on
a given PMU so that they can be shared between different tasks on
different CPUs. There will probably be a single control register, so
keeping everything in sync will be impossible.

Will
