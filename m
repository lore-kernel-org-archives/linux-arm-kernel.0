From: peterz@infradead.org (Peter Zijlstra)
Date: Sat, 09 Apr 2011 13:40:35 +0200
Subject: [RFC] Extending ARM perf-events for multiple PMUs
In-Reply-To: <1302282912.5758.25.camel@e102144-lin.cambridge.arm.com>
References: <1302282912.5758.25.camel@e102144-lin.cambridge.arm.com>
Message-ID: <1302349235.9086.1270.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-04-08 at 18:15 +0100, Will Deacon wrote:
> Hello,
> 
> Currently the perf code on ARM only caters for the core CPU PMU. In actual
> fact, this only represents a subset of the performance monitoring hardware
> available in real SoCs and is arguably the simplest to interact with. This
> long-winded email is an attempt to classify the possible event sources that we
> might see so that we can have clean support for them in the future. I think
> that the perf tools might also need tweaking slightly so they can handle PMUs
> which can't service per-cpu or per-task events (instead, you essentially have
> a single system-wide event).
> 
> We can split PMUs up into two basic categories (an `action' here is usually an
> interrupt but could be defined as any state recording or signalling operation).
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

I don't see this distinction, both will have to count, and telling it
what to count is a function of perf_event_attr::config* and how the
hardware implements that is of no interest.

> Now, we currently support the core CPU PMU, which is obviously a CPU-aware PMU
> that generates interrupts as actions. Another example of a CPU-aware PMU is
> the VFP PMU in Qualcomm's Scorpion. The next step (moving outwards from the
> core) is to add support for L2 cache controllers. I expect most of these to be
> Counting System PMUs, although I can envisage them being CPU-aware if built
> into the core with enough extra hardware.
> 
> Implementing support for CPU-aware PMUs can be done alongside the current CPU
> PMU code and much of the code can be shared with the core PMU providing that
> the event namespaces are distinct.
> 
> Implementing support for Counting System PMUs can reuse a lot of the
> functionality in perf_event.c (for example, struct arm_pmu) but the low-level
> accessors should be separate and a new struct pmu should be used. This means
> that we will want multiple instances of struct arm_pmu and a method to translate
> from a struct pmu to a struct arm_pmu. We'll also need to clean up some of the
> armpmu_* functions to ensure the correction indirection is used when invoking
> per-pmu functions.
> 
> Finally, the Filtering System PMUs will probably need their own struct pmu
> instances for each device and can make use of the dynamic sysfs interface via
> perf_pmu_register. I don't see any scope for common code in this space yet.
> 
> I appreciate this is especially hand-wavy stuff, but I'd like to check we've
> got all of our bases covered before introducing system PMUs to ARM. The first
> victim is the PL310 L2CC on the Cortex-A9.

Right, so x86 has this too, and we have a fairly complete implementation
of the Nehalem/Westmere uncore PMU, which is a NODE/memory controller
PMU. Afaik we're mostly waiting on Intel to clarify some hardware
details.

So the perf core supports multiple hardware PMUs, but currently only one
of which can do per-task sampling, if you've got multiple CPU local PMUs
we need to do a little extra.

See perf_pmu_register(), what say a memory controller PMU would do is
something like:

  perf_pmu_register(&node_pmu, "node", -1);

that will create a /sys/bus/event_source/devices/node/ directory in
which will host the PMU details for userspace. This is currently limited
to a single 'type' file which includes the number to provide
perf_event_attr::type, but could (and should) be extended to provide
some important events as well, which will provide the the bits to put in
perf_event_attr::config.

I just haven't figured out a way to dynamically add files/directories in
the whole struct device sysfs muck (that also pleases the driver/sysfs
folks). Nor have we agreed on a sane layout for such events there.

What we do for the events is map the provided CPU number to a memory
controller (cpu_to_node() does that for our case), and then use the
first online cpu in that node mask to drive the event.

If you've got system wide things like GPUs, where every cpu maps to the
same device, simply use the first online cpu and create a pmu instance
per device.

Now, I've also wanted to make symlinks in the regular sysfs topology to
these bus/event_source nodes, but again, that's something I've not
managed to find out how to do yet.

That is, for the currently existing "cpu" node, I'd like to have:

  /sys/devices/system/cpu/cpuN/event_source -> /sys/bus/event_source/devices/cpu

And similar for the node thing:

  /sys/devices/system/node/nodeN/event_source -> /sys/bus/event_source/devices/node

And for a GPU we could have:

  /sys/devices/pci0000:00/0000:00:02.0/drm/card0/event_source -> /sys/bus/event_source/devices/IGC0
