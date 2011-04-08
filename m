From: will.deacon@arm.com (Will Deacon)
Date: Fri, 08 Apr 2011 18:15:12 +0100
Subject: [RFC] Extending ARM perf-events for multiple PMUs
Message-ID: <1302282912.5758.25.camel@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Currently the perf code on ARM only caters for the core CPU PMU. In actual
fact, this only represents a subset of the performance monitoring hardware
available in real SoCs and is arguably the simplest to interact with. This
long-winded email is an attempt to classify the possible event sources that we
might see so that we can have clean support for them in the future. I think
that the perf tools might also need tweaking slightly so they can handle PMUs
which can't service per-cpu or per-task events (instead, you essentially have
a single system-wide event).

We can split PMUs up into two basic categories (an `action' here is usually an
interrupt but could be defined as any state recording or signalling operation).

  (1) CPU-aware PMUs

      This type of PMU is typically per-CPU and accessed via co-processor
      instructions. Actions may be delivered as PPIs. Events scheduled onto
      a CPU-aware PMU can be grouped, possibly with events scheduled for other
      per-CPU PMUs on the same CPU. An action delivered by one of these PMUs
      can *always* be attributed to a specific CPU but not necessarily a
      specific task. Accessing a CPU-aware PMU is a synchronous operation.

  (2) System PMUs

      System PMUs are typically outside of the CPU domain. Bus monitors, GPU
      counters and external L2 cache controller monitors are all system PMUs.
      Actions delivered by these PMUs cannot be attributed to a particular CPU
      and certainly cannot be associated with a particular piece of code. They
      are memory-mapped and cannot be grouped with other PMUs of any type.
      Accesses to a system PMU may be asynchronous.

      System PMUs can be further split up into `counting' and `filtering'
      PMUs:

      (i) Counting PMUs

          Counting PMUs increment a counter whenever a particular event occurs
	  and can deliver an action periodically (for example, on overflow or
	  after a certain amount of time has passed). The event types are
	  hardwired as particular, discrete events such as `cycles' or
	  `misses'.

      (ii) Filtering PMUs

          Filtering PMUs respond to a query. For example, `generate an action
	  whenever you see a bus access which fits the following criteria'. The
	  action may simply be to increment a counter, in which case this PMU
	  can act as a highly configurable counting PMU, where the event types
	  are dynamic.

Now, we currently support the core CPU PMU, which is obviously a CPU-aware PMU
that generates interrupts as actions. Another example of a CPU-aware PMU is
the VFP PMU in Qualcomm's Scorpion. The next step (moving outwards from the
core) is to add support for L2 cache controllers. I expect most of these to be
Counting System PMUs, although I can envisage them being CPU-aware if built
into the core with enough extra hardware.

Implementing support for CPU-aware PMUs can be done alongside the current CPU
PMU code and much of the code can be shared with the core PMU providing that
the event namespaces are distinct.

Implementing support for Counting System PMUs can reuse a lot of the
functionality in perf_event.c (for example, struct arm_pmu) but the low-level
accessors should be separate and a new struct pmu should be used. This means
that we will want multiple instances of struct arm_pmu and a method to translate
from a struct pmu to a struct arm_pmu. We'll also need to clean up some of the
armpmu_* functions to ensure the correction indirection is used when invoking
per-pmu functions.

Finally, the Filtering System PMUs will probably need their own struct pmu
instances for each device and can make use of the dynamic sysfs interface via
perf_pmu_register. I don't see any scope for common code in this space yet.

I appreciate this is especially hand-wavy stuff, but I'd like to check we've
got all of our bases covered before introducing system PMUs to ARM. The first
victim is the PL310 L2CC on the Cortex-A9.

Feedback welcome,

Will
