From: ashwinc@codeaurora.org (Ashwin Chaugule)
Date: Mon, 11 Apr 2011 13:29:21 -0400
Subject: [RFC] Extending ARM perf-events for multiple PMUs
In-Reply-To: <1302282912.5758.25.camel@e102144-lin.cambridge.arm.com>
References: <1302282912.5758.25.camel@e102144-lin.cambridge.arm.com>
Message-ID: <4DA33A71.6010804@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,
Thanks for the starting the discussion here.

On 4/8/2011 1:15 PM, Will Deacon wrote:
> 
>   (1) CPU-aware PMUs
> 
>       This type of PMU is typically per-CPU and accessed via co-processor
>       instructions. Actions may be delivered as PPIs. Events scheduled onto
>       a CPU-aware PMU can be grouped, possibly with events scheduled for other
>       per-CPU PMUs on the same CPU. An action delivered by one of these PMUs
>       can *always* be attributed to a specific CPU but not necessarily a
>       specific task. Accessing a CPU-aware PMU is a synchronous operation.
>

I didn't understand when would an action not be attributed to a task in
this category ? If we know which CPU "enabled" the event, this should be
possible ?


>   (2) System PMUs
> 
>       System PMUs are typically outside of the CPU domain. Bus monitors, GPU
>       counters and external L2 cache controller monitors are all system PMUs.
>       Actions delivered by these PMUs cannot be attributed to a particular CPU
>       and certainly cannot be associated with a particular piece of code. They
>       are memory-mapped and cannot be grouped with other PMUs of any type.
>       Accesses to a system PMU may be asynchronous.
> 
>       System PMUs can be further split up into `counting' and `filtering'
>       PMUs:
> 
>       (i) Counting PMUs
> 
>           Counting PMUs increment a counter whenever a particular event occurs
> 	  and can deliver an action periodically (for example, on overflow or
> 	  after a certain amount of time has passed). The event types are
> 	  hardwired as particular, discrete events such as `cycles' or
> 	  `misses'.
> 
>       (ii) Filtering PMUs
> 
>           Filtering PMUs respond to a query. For example, `generate an action
> 	  whenever you see a bus access which fits the following criteria'. The
> 	  action may simply be to increment a counter, in which case this PMU
> 	  can act as a highly configurable counting PMU, where the event types
> 	  are dynamic.
> 
> Now, we currently support the core CPU PMU, which is obviously a CPU-aware PMU
> that generates interrupts as actions. Another example of a CPU-aware PMU is
> the VFP PMU in Qualcomm's Scorpion. The next step (moving outwards from the
> core) is to add support for L2 cache controllers. I expect most of these to be
> Counting System PMUs, although I can envisage them being CPU-aware if built
> into the core with enough extra hardware.

For the Qcom L2CC, the PMU can be configured to filter events based on
specific masters. This fact would make it a CPU-aware PMU, although its
NOT per-core and triggers SPI's.

In such a case, I found it to be quite ugly trying to reuse the per-cpu
data structures esp in the interrupt handler, since the interrupt can
trigger on a CPU where the event wasn't enabled. A cleaner approach was to
use a separate struct pmu. However, I agree that this approach would lead
to several pmu's popping up in arch/arm.

So, I think we could add another category for such highly configurable
PMUs, which are not per-core, but have enough extra h/w to make them
cpu-aware. These need to be treated differently by arm perf, because they
can't really use the per-cpu data structures of the cpu-aware pmu's and as
such can't easily re-use of many of the functions.

In fact, most of Qcomm PMU's (bus, fabric etc.) will fall under this new
category. At first glance, these would appear to fall under the System PMU
(counting) category, but they don't because of the extra h/w logic that
allows origin filtering of events.

Also, having all this origin filtering logic helps us track per-process
events on these PMU's, for which we need extra functions to decide how to
allocate and configure counters based on which context (task, cpu) the
event is enabled in.

Cheers,
Ashwin


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
