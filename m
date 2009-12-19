From: jamie@jamieiles.com (Jamie Iles)
Date: Sat, 19 Dec 2009 10:29:05 +0000
Subject: Perf Event support for ARMv7 (was: Re: [PATCH 5/5]
	arm/perfevents: implement perf event support for ARMv6)
In-Reply-To: <1261155929.6094.11.camel@def-laptop>
References: <1260875712-29712-1-git-send-email-jamie.iles@picochip.com>
	<1260875712-29712-2-git-send-email-jamie.iles@picochip.com>
	<1260875712-29712-3-git-send-email-jamie.iles@picochip.com>
	<1260875712-29712-4-git-send-email-jamie.iles@picochip.com>
	<1260875712-29712-5-git-send-email-jamie.iles@picochip.com>
	<1260875712-29712-6-git-send-email-jamie.iles@picochip.com>
	<1261155929.6094.11.camel@def-laptop>
Message-ID: <20091219102905.GA26526@wear.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2009 at 06:05:29PM +0100, Jean Pihet wrote:
> Here is a patch that adds the support for ARMv7 processors, using the
> PMNC HW unit.
> 
> The code is for review, it has been compiled and boot tested only, the
> complete testing is in progress. Please let me know if the patch is
> wrapped or garbled I will send it attached (20KB in size).
Excellent! It looks good to me, a few minor comments though. I don't know if
it's my mail client but some of the longer lines appeared to wrap onto 2 patch
lines but it's not difficult to apply.

[snip]
> I had a question about the events mapping to user space. Although most
> of the events are mapped in the kernel code, some of the exotic events
> are not mapped (e.g. NEON or PMU related events). How to use those
> events from user space? Is it done using the raw mappings?
Yes, the raw events should do the trick. 'perf stat -a -e rff -- sleep 1' will
do cycle counting on v6 using the raw event number.
> +enum armv7_perf_types {
> +	ARMV7_PERFCTR_PMNC_SW_INCR		= 0x00,
> +	ARMV7_PERFCTR_IFETCH_MISS		= 0x01,
> +	ARMV7_PERFCTR_ITLB_MISS			= 0x02,
> +	ARMV7_PERFCTR_DCACHE_REFILL		= 0x03,
> +	ARMV7_PERFCTR_DCACHE_ACCESS		= 0x04,
> +	ARMV7_PERFCTR_DTLB_REFILL		= 0x05,
> +	ARMV7_PERFCTR_DREAD			= 0x06,
> +	ARMV7_PERFCTR_DWRITE			= 0x07,
> +	ARMV7_PERFCTR_INSTR_EXECUTED		= 0x08,
> +	ARMV7_PERFCTR_EXC_TAKEN			= 0x09,
> +	ARMV7_PERFCTR_EXC_EXECUTED		= 0x0A,
> +	ARMV7_PERFCTR_CID_WRITE			= 0x0B,
> +	ARMV7_PERFCTR_PC_WRITE			= 0x0C,
> +	ARMV7_PERFCTR_PC_IMM_BRANCH		= 0x0D,
> +	ARMV7_PERFCTR_PC_PROC_RETURN		= 0x0E,
> +	ARMV7_PERFCTR_UNALIGNED_ACCESS		= 0x0F,
> +	ARMV7_PERFCTR_PC_BRANCH_MIS_PRED	= 0x10,
> +
> +	ARMV7_PERFCTR_PC_BRANCH_MIS_USED	= 0x12,
> +
> +	ARMV7_PERFCTR_WRITE_BUFFER_FULL		= 0x40,
> +	ARMV7_PERFCTR_L2_STORE_MERGED		= 0x41,
> +	ARMV7_PERFCTR_L2_STORE_BUFF		= 0x42,
> +	ARMV7_PERFCTR_L2_ACCESS			= 0x43,
> +	ARMV7_PERFCTR_L2_CACH_MISS		= 0x44,
> +	ARMV7_PERFCTR_AXI_READ_CYCLES		= 0x45,
> +	ARMV7_PERFCTR_AXI_WRITE_CYCLES		= 0x46,
> +	ARMV7_PERFCTR_MEMORY_REPLAY		= 0x47,
> +	ARMV7_PERFCTR_UNALIGNED_ACCESS_REPLAY	= 0x48,
> +	ARMV7_PERFCTR_L1_DATA_MISS		= 0x49,
> +	ARMV7_PERFCTR_L1_INST_MISS		= 0x4A,
> +	ARMV7_PERFCTR_L1_DATA_COLORING		= 0x4B,
> +	ARMV7_PERFCTR_L1_NEON_DATA		= 0x4C,
> +	ARMV7_PERFCTR_L1_NEON_CACH_DATA		= 0x4D,
> +	ARMV7_PERFCTR_L2_NEON			= 0x4E,
> +	ARMV7_PERFCTR_L2_NEON_HIT		= 0x4F,
> +	ARMV7_PERFCTR_L1_INST			= 0x50,
> +	ARMV7_PERFCTR_PC_RETURN_MIS_PRED	= 0x51,
> +	ARMV7_PERFCTR_PC_BRANCH_FAILED		= 0x52,
> +	ARMV7_PERFCTR_PC_BRANCH_TAKEN		= 0x53,
> +	ARMV7_PERFCTR_PC_BRANCH_EXECUTED	= 0x54,
> +	ARMV7_PERFCTR_OP_EXECUTED		= 0x55,
> +	ARMV7_PERFCTR_CYCLES_INST_STALL		= 0x56,
> +	ARMV7_PERFCTR_CYCLES_INST		= 0x57,
> +	ARMV7_PERFCTR_CYCLES_NEON_DATA_STALL	= 0x58,
> +	ARMV7_PERFCTR_CYCLES_NEON_INST_STALL	= 0x59,
> +	ARMV7_PERFCTR_NEON_CYCLES		= 0x5A,
> +
> +	ARMV7_PERFCTR_PMU0_EVENTS		= 0x70,
> +	ARMV7_PERFCTR_PMU1_EVENTS		= 0x71,
> +	ARMV7_PERFCTR_PMU_EVENTS		= 0x72,
> +
> +	ARMV7_PERFCTR_CPU_CYCLES		= 0xFF
> +};
> +
> +enum armv7_counters {
> +	ARMV7_CYCLE_COUNTER = 1,
> +	ARMV7_COUNTER0,
> +	ARMV7_COUNTER1,
> +	ARMV7_COUNTER2,
> +	ARMV7_COUNTER3,
> +};
> +
> +/*
> + * The hardware events that we support. We do support cache operations
> but
> + * we have harvard caches and no way to combine instruction and data
> + * accesses/misses in hardware.
> + */
> +static const unsigned armv7_perf_map[PERF_COUNT_HW_MAX] = {
> +	[PERF_COUNT_HW_CPU_CYCLES]	    = ARMV7_PERFCTR_CPU_CYCLES,
> +	[PERF_COUNT_HW_INSTRUCTIONS]	    = ARMV7_PERFCTR_INSTR_EXECUTED,
> +	[PERF_COUNT_HW_CACHE_REFERENCES]    = HW_OP_UNSUPPORTED,
> +	[PERF_COUNT_HW_CACHE_MISSES]	    = HW_OP_UNSUPPORTED,
> +	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = ARMV7_PERFCTR_PC_BRANCH_TAKEN,
> +	[PERF_COUNT_HW_BRANCH_MISSES]	    = ARMV7_PERFCTR_PC_BRANCH_FAILED,
> +	[PERF_COUNT_HW_BUS_CYCLES]	    = HW_OP_UNSUPPORTED,
> +};
> +
> +static const unsigned armv7_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
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
> +	[C(LL)] = {
> +		[C(OP_READ)] = {
> +			[C(RESULT_ACCESS)]	= ARMV7_PERFCTR_L2_ACCESS,
> +			[C(RESULT_MISS)]	= ARMV7_PERFCTR_L2_CACH_MISS,
> +		},
> +		[C(OP_WRITE)] = {
> +			[C(RESULT_ACCESS)]	= ARMV7_PERFCTR_L2_ACCESS,
> +			[C(RESULT_MISS)]	= ARMV7_PERFCTR_L2_CACH_MISS,
> +		},
> +		[C(OP_PREFETCH)] = {
> +			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
> +			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
> +		},
> +	},
> +	[C(DTLB)] = {
> +		/*
> +		 * The ARM performance counters can count micro DTLB misses,
> +		 * micro ITLB misses and main TLB misses. There isn't an event
> +		 * for TLB misses, so use the micro misses here and if users
> +		 * want the main TLB misses they can use a raw counter.
> +		 */
I think this comment needs to be changed for v7. From the events enum it
doesn't look like v7 has micro tlb events.

> +static inline int armv7_pmnc_select_counter(unsigned int cnt)
> +{
> +	u32 val;
> +
> +	cnt -= ARMV7_COUNTER_TO_CCNT;
> +
> +	if ((cnt == ARMV7_CCNT) || (cnt >= ARMV7_CNTMAX)) {
> +		printk(KERN_ERR "oprofile: CPU%u selecting wrong PMNC counter"
> +			" %d\n", smp_processor_id(), cnt);
Most of the printk's refer to oprofile. Could we use pr_err() etc so we get
the same prefix for all messages?

[snip]
> +		if (armv7_pmnc_select_counter(counter) == counter)
> +			asm volatile("mrc p15, 0, %0, c9, c13, 2"
> +				     : "=r" (value));
Does this sequence need some locking to make sure that we really do read from
the counter that we've selected? The same applies to the other places.

Jamie
