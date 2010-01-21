From: jamie@jamieiles.com (Jamie Iles)
Date: Thu, 21 Jan 2010 09:39:17 +0000
Subject: [PATCH 5/5] arm/perfevents: implement perf event support for ARMv6
In-Reply-To: <1263471256-3739-6-git-send-email-jamie.iles@picochip.com>
References: <1263471256-3739-1-git-send-email-jamie.iles@picochip.com>
	<1263471256-3739-2-git-send-email-jamie.iles@picochip.com>
	<1263471256-3739-3-git-send-email-jamie.iles@picochip.com>
	<1263471256-3739-4-git-send-email-jamie.iles@picochip.com>
	<1263471256-3739-5-git-send-email-jamie.iles@picochip.com>
	<1263471256-3739-6-git-send-email-jamie.iles@picochip.com>
Message-ID: <20100121093917.GB4908@wear.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 14, 2010 at 12:14:16PM +0000, Jamie Iles wrote:
> This patch implements support for ARMv6 performance counters in the
> Linux performance events subsystem. ARMv6 architectures that have the
> performance counters should enable HW_PERF_EVENTS and define the
> interrupts for the counters in arch/arm/kernel/perf_event.c
The commit message needs a tweak before submitting as the IRQs are listed in
arch/arm/kernel/pmu.c now rather than perf_event.c.

> +static int __init
> +init_hw_perf_events(void)
> +{
> +#define CPUID_MASK	0xFFF0
> +	unsigned long cpuid = read_cpuid_id() & CPUID_MASK;
> +
> +	switch (cpuid) {
> +	case 0xB360:	/* ARM1136 */
> +	case 0xB560:	/* ARM1156 */
> +	case 0xB760:	/* ARM1176 */
> +		armpmu = &armv6pmu;
> +		memcpy(armpmu_perf_cache_map, armv6_perf_cache_map,
> +				sizeof(armv6_perf_cache_map));
> +		perf_max_events	= armv6pmu.num_events;
> +		break;
> +	case 0xB020:	/* ARM11mpcore */
> +		armpmu = &armv6mpcore_pmu;
> +		memcpy(armpmu_perf_cache_map, armv6mpcore_perf_cache_map,
> +				sizeof(armv6mpcore_perf_cache_map));
> +		perf_max_events = armv6mpcore_pmu.num_events;
> +		break;
> +	default:
> +		pr_info("no hardware support available\n");
> +		perf_max_events = -1;
> +	}
> +
> +	if (armpmu)
> +		pr_info("enabled with %s PMU driver\n",
> +				armpmu->name);
> +
> +	return 0;
> +}
> +arch_initcall(init_hw_perf_events);
Given the difficulty in determining the CPU type 100%, this should be changed
to:

	unsigned long cpuid = read_cpuid_id();
	unsigned long implementor = (cpuid & 0xFF000000) >> 24;
	unsigned long part_number = (cpuid & 0xFFF0);
	
	/* We only support ARM CPUs implemented by ARM at the moment. */
	if (implementor == 0x41) {
		switch (part_number) {
		case 0xB360:
		case 0xB560:
			etc

Jamie
