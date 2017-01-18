From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 18 Jan 2017 11:35:23 +0000
Subject: [PATCH v3 6/9] kvm: arm/arm64: Add host pmu to support VM
 introspection
In-Reply-To: <1a6b8d71-58a5-b29b-3f01-e945deb2baf6@arm.com>
References: <20170110113856.7183-1-punit.agrawal@arm.com>
 <20170110113856.7183-7-punit.agrawal@arm.com>
 <1a6b8d71-58a5-b29b-3f01-e945deb2baf6@arm.com>
Message-ID: <20170118113523.GB3231@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2017 at 11:21:21AM +0000, Marc Zyngier wrote:
> On 10/01/17 11:38, Punit Agrawal wrote:
> > +#define VM_MASK	GENMASK_ULL(31, 0)
> > +#define EVENT_MASK	GENMASK_ULL(32, 39)
> > +#define EVENT_SHIFT	(32)
> > +
> > +#define to_pid(cfg)	((cfg) & VM_MASK)
> > +#define to_event(cfg)	(((cfg) & EVENT_MASK) >> EVENT_SHIFT)
> > +
> > +PMU_FORMAT_ATTR(vm, "config:0-31");
> > +PMU_FORMAT_ATTR(event, "config:32-39");
> 
> I'm a bit confused by these. Can't you get the PID of the VM you're
> tracing directly from perf, without having to encode things? And if you
> can't, surely this should be a function of the size of pid_t?
>
> Mark, can you shine some light here?

AFAICT, this is not necessary.

The perf_event_open() syscall takes a PID separately from the
perf_event_attr. i.e. we should be able to do:

// monitor a particular vCPU
perf_event_open(attr, vcpupid, -1, -1, 0)

... or .. 

// monitor a particular vCPU on a pCPU
perf_event_open(attr, vcpupid, cpu, -1, 0)

... or ...

// monitor all vCPUs on a pCPU
perf_event_open(attr, -1, cpu, -1, 0)

... so this shouldn't be necessary. AFAICT, this is a SW PMU, so there
should be no issue with using the perf_sw_context.

If this is a bodge to avoid opening a perf_event per vCPU thread, then I
completely disagree with the approach. This would be better handled in
userspace by discovering the set of threads and opening events for each.

Thanks,
Mark.
