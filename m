From: will.deacon@arm.com (Will Deacon)
Date: Tue, 15 Dec 2009 14:29:21 -0000
Subject: [PATCH 5/5] arm/perfevents: implement perf event support for ARMv6
In-Reply-To: <1260875712-29712-6-git-send-email-jamie.iles@picochip.com>
References: <1260875712-29712-1-git-send-email-jamie.iles@picochip.com>	<1260875712-29712-2-git-send-email-jamie.iles@picochip.com>	<1260875712-29712-3-git-send-email-jamie.iles@picochip.com>	<1260875712-29712-4-git-send-email-jamie.iles@picochip.com>	<1260875712-29712-5-git-send-email-jamie.iles@picochip.com>
	<1260875712-29712-6-git-send-email-jamie.iles@picochip.com>
Message-ID: <000101ca7d92$fe903000$fbb09000$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jamie,

I've not looked at the entire patch in depth, but I did spot a couple
of things:

> This patch implements support for ARMv6 performance counters in the
> Linux performance events subsystem. ARMv6 architectures that have the
> performance counters should enable HW_PERF_EVENTS and define the
> interrupts for the counters in arch/arm/kernel/perf_event.c
> 
> This implementation also provides an ARM PMU abstraction layer to allow
> ARMv7 and others to be supported in the future by adding new a
> 'struct arm_pmu'.

<snip>

> +static struct arm_pmu armv6pmu = {
> +	.name			= "v6",
> +	.handle_irq		= armv6pmu_handle_irq,
> +	.enable			= armv6pmu_enable_event,
> +	.disable		= armv6pmu_disable_event,
> +	.event_map		= armv6pmu_event_map,
> +	.raw_event		= armv6pmu_raw_event,
> +        .read_counter           = armv6pmu_read_counter,
> +        .write_counter          = armv6pmu_write_counter,
> +	.get_event_idx		= armv6pmu_get_event_idx,
> +        .start                  = armv6pmu_start,
> +	.stop		        = armv6pmu_stop,
> +	.num_events		= 3,
> +	.max_period		= (1LLU << 32) - 1,
> +};

Your indentation seems to have gone awry here, I think I saw it somewhere
else in the file too.

> +static int __init
> +init_hw_perf_events(void)
> +{
> +#define CPUID_V6_MASK   0x7F000
> +#define CPUID_V6_BITS   0x7B000
> +        unsigned long cpuid = read_cpuid_id();
> +
> +        if (CPUID_V6_BITS == (cpuid & CPUID_V6_MASK)) {
> +                armpmu = &armv6pmu;
> +                memcpy(armpmu_perf_cache_map, armv6_perf_cache_map,
> +                       sizeof(armv6_perf_cache_map));
> +                perf_max_events	= armv6pmu.num_events;
> +        } else {
> +                pr_info("no hardware support available\n");
> +                perf_max_events = -1;
> +        }
> +
> +        if (armpmu)
> +                pr_info("enabled with %s PMU driver\n",
> +                        armpmu->name);
> +
> +        return 0;
> +}
> +arch_initcall(init_hw_perf_events);

Watch out for the 11MPCore CPU. The event numbers are defined *slightly*
differently (1136,1156 and 1176 don't have any conflicts with each other,
but the 11MPCore does). If you look at the TRM the first 6 events are the
same as for other v6 cores, but then event 0x06 becomes a new event: `branch
not predicted' which offsets the others by one. Other than that, the PMUs
are accessed the same way on each core, so you just need to make sure you
select the correct event mappings.

Cheers,

Will
