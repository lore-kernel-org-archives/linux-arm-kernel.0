From: punit.agrawal@arm.com (Punit Agrawal)
Date: Wed, 18 Jan 2017 14:58:20 +0000
Subject: [PATCH v3 6/9] kvm: arm/arm64: Add host pmu to support VM
 introspection
In-Reply-To: <20170118134558.GF28063@arm.com> (Will Deacon's message of "Wed,
 18 Jan 2017 13:45:58 +0000")
References: <20170110113856.7183-1-punit.agrawal@arm.com>
 <20170110113856.7183-7-punit.agrawal@arm.com>
 <1a6b8d71-58a5-b29b-3f01-e945deb2baf6@arm.com>
 <20170118113523.GB3231@leverpostej>
 <87o9z4msi3.fsf@e105922-lin.cambridge.arm.com>
 <20170118134558.GF28063@arm.com>
Message-ID: <87bmv4mn3n.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will Deacon <will.deacon@arm.com> writes:

> On Wed, Jan 18, 2017 at 01:01:40PM +0000, Punit Agrawal wrote:
>> Mark Rutland <mark.rutland@arm.com> writes:
>> 
>> > On Wed, Jan 18, 2017 at 11:21:21AM +0000, Marc Zyngier wrote:
>> >> On 10/01/17 11:38, Punit Agrawal wrote:
>> >> > +#define VM_MASK	GENMASK_ULL(31, 0)
>> >> > +#define EVENT_MASK	GENMASK_ULL(32, 39)
>> >> > +#define EVENT_SHIFT	(32)
>> >> > +
>> >> > +#define to_pid(cfg)	((cfg) & VM_MASK)
>> >> > +#define to_event(cfg)	(((cfg) & EVENT_MASK) >> EVENT_SHIFT)
>> >> > +
>> >> > +PMU_FORMAT_ATTR(vm, "config:0-31");
>> >> > +PMU_FORMAT_ATTR(event, "config:32-39");
>> >> 
>> >> I'm a bit confused by these. Can't you get the PID of the VM you're
>> >> tracing directly from perf, without having to encode things?
>> 
>> With perf attached to a PID, the event gets scheduled out when the task
>> is context switched. As the PID of the controlling process was used,
>> none of the vCPU events were counted.
>
> So it sounds like userspace needs to deal with this by attaching to the PIDs
> of the vCPUs. Given that perf kvm seems to have knowledge of vCPUs, it would
> be nice to know why that logic isn't reusable here. Take a look in
> tools/perf/builtin-kvm.c and if it's not up to the job, then perhaps it can
> be improved.

Thanks for the pointer. I'll have a play with perf kvm to see if it can
be leveraged here.

>
> Will
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
