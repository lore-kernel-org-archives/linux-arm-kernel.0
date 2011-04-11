From: will.deacon@arm.com (Will Deacon)
Date: Mon, 11 Apr 2011 12:29:53 +0100
Subject: [RFC] Extending ARM perf-events for multiple PMUs
In-Reply-To: <1302349235.9086.1270.camel@twins>
References: <1302282912.5758.25.camel@e102144-lin.cambridge.arm.com>
	<1302349235.9086.1270.camel@twins>
Message-ID: <1302521393.24286.66.camel@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Sat, 2011-04-09 at 12:40 +0100, Peter Zijlstra wrote:
> >       System PMUs can be further split up into `counting' and `filtering'
> >       PMUs:
> >
> >       (i) Counting PMUs
> >
> >           Counting PMUs increment a counter whenever a particular event occurs
> >         and can deliver an action periodically (for example, on overflow or
> >         after a certain amount of time has passed). The event types are
> >         hardwired as particular, discrete events such as `cycles' or
> >         `misses'.
> >
> >       (ii) Filtering PMUs
> >
> >           Filtering PMUs respond to a query. For example, `generate an action
> >         whenever you see a bus access which fits the following criteria'. The
> >         action may simply be to increment a counter, in which case this PMU
> >         can act as a highly configurable counting PMU, where the event types
> >         are dynamic.
> 
> I don't see this distinction, both will have to count, and telling it
> what to count is a function of perf_event_attr::config* and how the
> hardware implements that is of no interest.

Sure, fundamentally we're just writing bits rather than interpreting
them. The reason I mention the difference is that filtering PMUs will
always need their own struct pmu because of the lack of an event
namespace. The other problem is only an issue for some userspace tools
(like Oprofile) which require lists of events and their hex codes.

> > I appreciate this is especially hand-wavy stuff, but I'd like to check we've
> > got all of our bases covered before introducing system PMUs to ARM. The first
> > victim is the PL310 L2CC on the Cortex-A9.
> 
> Right, so x86 has this too, and we have a fairly complete implementation
> of the Nehalem/Westmere uncore PMU, which is a NODE/memory controller
> PMU. Afaik we're mostly waiting on Intel to clarify some hardware
> details.
> 
> So the perf core supports multiple hardware PMUs, but currently only one
> of which can do per-task sampling, if you've got multiple CPU local PMUs
> we need to do a little extra.
> 
> See perf_pmu_register(), what say a memory controller PMU would do is
> something like:
> 
>   perf_pmu_register(&node_pmu, "node", -1);
> 
> that will create a /sys/bus/event_source/devices/node/ directory in
> which will host the PMU details for userspace. This is currently limited
> to a single 'type' file which includes the number to provide
> perf_event_attr::type, but could (and should) be extended to provide
> some important events as well, which will provide the the bits to put in
> perf_event_attr::config.

Yup, the registration stuff is a good fit for these. I think we may want
an extra level of indirection under arch/arm/ to avoid lots of code
duplication for the struct pmu functions though (like we have for the
CPU PMU).

> I just haven't figured out a way to dynamically add files/directories in
> the whole struct device sysfs muck (that also pleases the driver/sysfs
> folks). Nor have we agreed on a sane layout for such events there.
> 
> What we do for the events is map the provided CPU number to a memory
> controller (cpu_to_node() does that for our case), and then use the
> first online cpu in that node mask to drive the event.
> 
> If you've got system wide things like GPUs, where every cpu maps to the
> same device, simply use the first online cpu and create a pmu instance
> per device.

Would this result in userspace attributing all of the data to a
particular CPU? We could consider allowing events where the cpu is -1
and the task pid is -1 as well. Non system-wide PMUs could reject these
and demand multiple events instead.

> Now, I've also wanted to make symlinks in the regular sysfs topology to
> these bus/event_source nodes, but again, that's something I've not
> managed to find out how to do yet.
> 
> That is, for the currently existing "cpu" node, I'd like to have:
> 
>   /sys/devices/system/cpu/cpuN/event_source -> /sys/bus/event_source/devices/cpu
> 
> And similar for the node thing:
> 
>   /sys/devices/system/node/nodeN/event_source -> /sys/bus/event_source/devices/node
> 
> And for a GPU we could have:
> 
>   /sys/devices/pci0000:00/0000:00:02.0/drm/card0/event_source -> /sys/bus/event_source/devices/IGC0

That looks like a good way to show the topology of the event sources to
me.

Thanks for your feedback,

Will
