From: will.deacon@arm.com (Will Deacon)
Date: Mon, 4 Jan 2010 16:52:01 -0000
Subject: Perf Event support for ARMv7 (was: Re: [PATCH 5/5]
	arm/perfevents: implement perf event support for ARMv6)
In-Reply-To: <200912291458.20609.jpihet@mvista.com>
References: <1260875712-29712-1-git-send-email-jamie.iles@picochip.com>
	<200912211435.05094.jpihet@mvista.com>
	<200912221751.39662.jpihet@mvista.com>
	<200912291458.20609.jpihet@mvista.com>
Message-ID: <000101ca8d5e$3ce84e20$b6b8ea60$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean,

Thanks for this. Feedback inline.

* Jean Pihet wrote:

> Here is the updated patch after testing on HW.
> I will rebase it on Jamie's latest patch set as soon as they are out.
> 
> Feedback is welcome!

> Some remarks and questions:
> 
> 1) The number of available counters can reach 32 on ARMv7, so the macro
> ARMPMU_MAX_HWEVENTS is now defined as 32. Is that correct?

I think index 0 is reserved for the events array, so this should probably be 33.
Hopefully that doesn't break any bitmasks.

> 2) Please note that the Cortex-A9 events do not easily map to the predefined
> events. Cf. armv7_a9_perf_map and armv7_a9_perf_cache_map in the code.
> - the PERF_COUNT_HW_INSTRUCTIONS event is not found. It looks like the number
> of instructions is calculated by adding events numbers (events from 0x70 till
> 0x74: MAIN_UNIT_EXECUTED_INST, SECOND_UNIT_EXECUTED_INST,
> LD_ST_UNIT_EXECUTED_INST, FP_EXECUTED_INST and NEON_EXECUTED_INST),

Event 0x68 - `Instructions coming out of the core renaming stage'
can be used as an approximation for PERF_COUNT_HW_INSTRUCTIONS.

> - the HW_BRANCH events are not found

0x0c is HW_BRANCH_INSTRUCTIONS and 0x10 is HW_BRANCH_MISSES.
0x12 is the number of predictable branch instructions executed, so the mispredict
rate is 0x10/0x12. These events are defined for v7, so A8 should take these
definitions too.

> - the global cache events 0x50 and 0x51 define the COHERENT_LINE_HIT and
> COHERENT_LINE_MISS events, is that correct?

0x50 is COHERENT_LINE_MISS and 0x51 is COHERENT_LINE_HIT. These are only available
on A9 with SMP.

> - L1 and L2 cache events are not found. Those could be available in separate
> PL310 registers, TBC

We could use 0x01 for icache miss, 0x03 for dcache miss and 0x04 for dcache access.

> - no TLB events excepted the ITLB_MISS event are found.

I think 0x05 is DTLB_MISS.

<snip>

> +/*
> + * ARMv7 Cortex-A8 and Cortex-A9 Performance Events handling code.
> + *
> + * Copied from ARMv6 code, with the low level code inspired
> + *  by the ARMv7 Oprofile code.
> + *
> + * Cortex-A8 has up to 4 configurable performance counters and
> + *  a single cycle counter.
> + * Cortex-A9 has up to 31 configurable performance counters and
> + *  a single cycle counter.
> + *
> + * All counters can be enabled/disabled and IRQ masked separately. The cycle
> + *  counter and all 4 performance counters together can be reset separately.
> + */
> +
> +#define ARMV7_PMU_CORTEX_A8_NAME		"ARMv7 Cortex-A8"
> +
> +#define ARMV7_PMU_CORTEX_A9_NAME		"ARMv7 Cortex-A9"
> +
> +/* Common ARMv7 event types */
> +enum armv7_perf_types {
> +	ARMV7_PERFCTR_PMNC_SW_INCR		= 0x00,
> +	ARMV7_PERFCTR_IFETCH_MISS		= 0x01,
> +	ARMV7_PERFCTR_ITLB_MISS			= 0x02,
> +	ARMV7_PERFCTR_DCACHE_REFILL		= 0x03,
> +	ARMV7_PERFCTR_DCACHE_ACCESS		= 0x04,
> +	ARMV7_PERFCTR_DTLB_REFILL		= 0x05,
> +	ARMV7_PERFCTR_DREAD			= 0x06,
> +	ARMV7_PERFCTR_DWRITE			= 0x07,
> +
> +	ARMV7_PERFCTR_EXC_TAKEN			= 0x09,
> +	ARMV7_PERFCTR_EXC_EXECUTED		= 0x0A,
> +	ARMV7_PERFCTR_CID_WRITE			= 0x0B,
> +	ARMV7_PERFCTR_PC_WRITE			= 0x0C,
> +	ARMV7_PERFCTR_PC_IMM_BRANCH		= 0x0D,
> +	ARMV7_PERFCTR_UNALIGNED_ACCESS		= 0x0F,
> +	ARMV7_PERFCTR_PC_BRANCH_MIS_PRED	= 0x10,
> +	ARMV7_PERFCTR_CLOCK_CYCLES		= 0x11,
> +
> +	ARMV7_PERFCTR_PC_BRANCH_MIS_USED	= 0x12,
> +
> +	ARMV7_PERFCTR_CPU_CYCLES		= 0xFF
> +};

For consistency, I think it's better to stick to either MISS or REFILL.
Events 0x01 and 0x03 are the same, but for instructions and data respectively.

<snip>

> +static const unsigned armv7_a8_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
> +					  [PERF_COUNT_HW_CACHE_OP_MAX]
> +					  [PERF_COUNT_HW_CACHE_RESULT_MAX] = {
> +	[C(L1D)] = {
> +		/*
> +		 * The performance counters don't differentiate between read
> +		 * and write accesses/misses so this isn't strictly correct,
> +		 * but it's the best we can do. Writes and reads get
> +		 * combined.
> +		 */
> +		[C(OP_READ)] = {
> +			[C(RESULT_ACCESS)]	= ARMV7_PERFCTR_DCACHE_ACCESS,
> +			[C(RESULT_MISS)]	= ARMV7_PERFCTR_L1_DATA_MISS,
> +		},
> +		[C(OP_WRITE)] = {
> +			[C(RESULT_ACCESS)]	= ARMV7_PERFCTR_DCACHE_ACCESS,
> +			[C(RESULT_MISS)]	= ARMV7_PERFCTR_L1_DATA_MISS,
> +		},
> +		[C(OP_PREFETCH)] = {
> +			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
> +			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
> +		},
> +	},

You're using the A8-only event 0x49 [ARMV7_PERFCTR_L1_DATA_MISS]. This also
counts hash misses in the address translation during the cache lookup procedure,
even if the resulting access is a [slightly slower] hit. I think you're better off
using event 0x03. In fact, I'd try to use architecturally defined events whenever
you can because that allows for comparisons between v7 cores.

> +	[C(L1I)] = {
> +		[C(OP_READ)] = {
> +			[C(RESULT_ACCESS)]	= ARMV7_PERFCTR_L1_INST,
> +			[C(RESULT_MISS)]	= ARMV7_PERFCTR_L1_INST_MISS,
> +		},
> +		[C(OP_WRITE)] = {
> +			[C(RESULT_ACCESS)]	= ARMV7_PERFCTR_L1_INST,
> +			[C(RESULT_MISS)]	= ARMV7_PERFCTR_L1_INST_MISS,
> +		},
> +		[C(OP_PREFETCH)] = {
> +			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
> +			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
> +		},
> +	},

Same thing here. I'd suggest using 0x01 instead of 0x4a.

<snip>

> +/*
> + * Available counters
> + */
> +#define ARMV7_CNT0 		0	/* First event counter */
> +#define ARMV7_CCNT 		31	/* Cycle counter */
> +
> +#define ARMV7_A8_CNTMAX		5	/* Cortex-A8: up to 4 counters + CCNT */
> +#define ARMV7_A9_CNTMAX		32	/* Cortex-A9: up to 31 counters + CCNT*/

Actually, A9 has a maximum number of 6 event counters + CCNT.

<snip>

> +#define CPUID_V6_MASK   	0x7F000
> +#define CPUID_V6_BITS   	0x7B000
> +
> +#define CPUID_CORTEX_A8_BITS	0xC080
> +#define CPUID_CORTEX_A8_MASK	0xFFF0
> +
> +#define CPUID_CORTEX_A9_BITS	0xC090
> +#define CPUID_CORTEX_A9_MASK	0xFFF0

Just define CPUID_V7_MASK.

> +	unsigned long cpuid = read_cpuid_id();
> +
> +	/*
> +	 * ARMv6 detection
> +	 */
> +	if (CPUID_V6_BITS == (cpuid & CPUID_V6_MASK)) {
> +		armpmu = &armv6pmu;
> +		memcpy(armpmu_perf_cache_map, armv6_perf_cache_map,
> +			sizeof(armv6_perf_cache_map));
> +		perf_max_events	= armv6pmu.num_events;
> +	}
> +	/*
> +	 * ARMv7 detection
> +	 */
> +	else if (cpu_architecture() == CPU_ARCH_ARMv7) {
> +		/*
> +		 * Cortex-A8 detection
> +		 */
> +		if ((cpuid & CPUID_CORTEX_A8_MASK) == CPUID_CORTEX_A8_BITS) {
> +			armv7pmu.name = ARMV7_PMU_CORTEX_A8_NAME;
> +			memcpy(armpmu_perf_cache_map, armv7_a8_perf_cache_map,
> +				sizeof(armv7_a8_perf_cache_map));
> +			armv7pmu.event_map = armv7_a8_pmu_event_map;
> +			armpmu = &armv7pmu;
> +		} else
> +		/*
> +		 * Cortex-A9 detection
> +		 */
> +			if ((cpuid & CPUID_CORTEX_A9_MASK)
> +			    == CPUID_CORTEX_A9_BITS) {
> +				armv7pmu.name = ARMV7_PMU_CORTEX_A9_NAME;
> +				memcpy(armpmu_perf_cache_map,
> +					armv7_a9_perf_cache_map,
> +					sizeof(armv7_a9_perf_cache_map));
> +				armv7pmu.event_map = armv7_a9_pmu_event_map;
> +				armpmu = &armv7pmu;
> +		} else
> +			perf_max_events = -1;

The A9 code indentation is a level too deep I think. It might also be
worth adding a cpu_architecture() check to the v6 test just in case a
v7 core conflicts with the mask.

I hope that helps. Please let me know what you think about the event
numberings.

Cheers,

Will
