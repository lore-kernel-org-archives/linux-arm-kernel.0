From: jpihet@mvista.com (Jean Pihet)
Date: Mon, 21 Dec 2009 12:43:07 +0100
Subject: Perf Event support for ARMv7 (was: Re: [PATCH 5/5]
	arm/perfevents: implement perf event support for ARMv6)
In-Reply-To: <000701ca822d$6de761a0$49b624e0$@deacon@arm.com>
References: <1260875712-29712-1-git-send-email-jamie.iles@picochip.com>
	<1261155929.6094.11.camel@def-laptop>
	<000701ca822d$6de761a0$49b624e0$@deacon@arm.com>
Message-ID: <200912211243.07254.jpihet@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Monday 21 December 2009 12:04:55 Will Deacon wrote:
> Hi Jean,
>
> I've provided some comments inline. Hopefully they're useful.
Thanks for reviewing the code.

> * Jean Pihet wrote:
> > Hello,
> >
> > Here is a patch that adds the support for ARMv7 processors, using the
> > PMNC HW unit.
> >
> > The code is for review, it has been compiled and boot tested only, the
> > complete testing is in progress. Please let me know if the patch is
> > wrapped or garbled I will send it attached (20KB in size).
> >
> > Feedback is welcome.
>
> <snip>
>
> > diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
> > index abb5267..79e92ce 100644
> > --- a/arch/arm/kernel/perf_event.c
> > +++ b/arch/arm/kernel/perf_event.c
> > @@ -4,6 +4,7 @@
> >   * ARM performance counter support.
> >   *
> >   * Copyright (C) 2009 picoChip Designs, Ltd., Jamie Iles
> > + * ARMv7 support: Jean Pihet <jpihet@mvista.com>
> >   *
> >   * This code is based on the sparc64 perf event code, which is in turn
> > based
> >   * on the x86 code. Callchain code is based on the ARM OProfile
> > backtrace
> > @@ -35,8 +36,11 @@ DEFINE_SPINLOCK(pmu_lock);
> >   * ARMv6 supports a maximum of 3 events, starting from index 1. If we
> > add
> >   * another platform that supports more, we need to increase this to be
> > the
> >   * largest of all platforms.
> > + *
> > + * ARMv7 supports up to 5 events:
> > + *  cycle counter CCNT + 4 events counters CNT0..3
> >   */
> > -#define ARMPMU_MAX_HWEVENTS		4
> > +#define ARMPMU_MAX_HWEVENTS		5
>
> The maximum number of event counters on ARMv7 is currently 6 [Cortex-A9],
> plus a cycle counter. Additionally, the number of event counters actually
> available is implementation defined (the cycle counter is mandatory). You
> can find out the number of event counters using the PMCR ((PMCR >> 11) &
> 0x1f).
I think we should support Cortex-A8 for now and add support for Cortex-A9 on 
top of it. IIUC a generic ARMV7 support is not possible so I will need 
separate handling for Cortex-A8 and -A9. Is that correct?

Unfortunately I do not have any -A9 HW for now. I will look at the spec in 
order to spot the differences between both PMNC units.

> >  /* The events for a given CPU. */
> >  struct cpu_hw_events {
> > @@ -965,6 +969,701 @@ static struct arm_pmu armv6pmu = {
> >  	.max_period		= (1LLU << 32) - 1,
> >  };
> >
> > +/*
> > + * ARMv7 Performance counter handling code.
> > + *
> > + * Copied from ARMv6 code, with the low level code inspired
> > + *  by the ARMv7 Oprofile code.
> > + *
> > + * ARMv7 has 4 configurable performance counters and a single cycle
> > counter.
> > + * All counters can be enabled/disabled and IRQ masked separately. The
> > cycle
> > + *  counter and all 4 performance counters together can be reset
> > separately.
> > + */
> > +
> > +enum armv7_perf_types {
> > +	ARMV7_PERFCTR_PMNC_SW_INCR		= 0x00,
> > +	ARMV7_PERFCTR_IFETCH_MISS		= 0x01,
> > +	ARMV7_PERFCTR_ITLB_MISS			= 0x02,
> > +	ARMV7_PERFCTR_DCACHE_REFILL		= 0x03,
> > +	ARMV7_PERFCTR_DCACHE_ACCESS		= 0x04,
> > +	ARMV7_PERFCTR_DTLB_REFILL		= 0x05,
> > +	ARMV7_PERFCTR_DREAD			= 0x06,
> > +	ARMV7_PERFCTR_DWRITE			= 0x07,
> > +	ARMV7_PERFCTR_INSTR_EXECUTED		= 0x08,
> > +	ARMV7_PERFCTR_EXC_TAKEN			= 0x09,
> > +	ARMV7_PERFCTR_EXC_EXECUTED		= 0x0A,
> > +	ARMV7_PERFCTR_CID_WRITE			= 0x0B,
> > +	ARMV7_PERFCTR_PC_WRITE			= 0x0C,
> > +	ARMV7_PERFCTR_PC_IMM_BRANCH		= 0x0D,
> > +	ARMV7_PERFCTR_PC_PROC_RETURN		= 0x0E,
> > +	ARMV7_PERFCTR_UNALIGNED_ACCESS		= 0x0F,
> > +	ARMV7_PERFCTR_PC_BRANCH_MIS_PRED	= 0x10,
> > +
> > +	ARMV7_PERFCTR_PC_BRANCH_MIS_USED	= 0x12,
>
> Ok - the events so far are defined by the v7 architecture.
> Note that this doesn't necessarily mean they are all supported by
> the core.
Is there a way to detect the supported PMU events at run-time? Is it harmful 
to use unsupported events?

> > +	ARMV7_PERFCTR_WRITE_BUFFER_FULL		= 0x40,
> > +	ARMV7_PERFCTR_L2_STORE_MERGED		= 0x41,
> > +	ARMV7_PERFCTR_L2_STORE_BUFF		= 0x42,
> > +	ARMV7_PERFCTR_L2_ACCESS			= 0x43,
> > +	ARMV7_PERFCTR_L2_CACH_MISS		= 0x44,
> > +	ARMV7_PERFCTR_AXI_READ_CYCLES		= 0x45,
> > +	ARMV7_PERFCTR_AXI_WRITE_CYCLES		= 0x46,
> > +	ARMV7_PERFCTR_MEMORY_REPLAY		= 0x47,
> > +	ARMV7_PERFCTR_UNALIGNED_ACCESS_REPLAY	= 0x48,
> > +	ARMV7_PERFCTR_L1_DATA_MISS		= 0x49,
> > +	ARMV7_PERFCTR_L1_INST_MISS		= 0x4A,
> > +	ARMV7_PERFCTR_L1_DATA_COLORING		= 0x4B,
> > +	ARMV7_PERFCTR_L1_NEON_DATA		= 0x4C,
> > +	ARMV7_PERFCTR_L1_NEON_CACH_DATA		= 0x4D,
> > +	ARMV7_PERFCTR_L2_NEON			= 0x4E,
> > +	ARMV7_PERFCTR_L2_NEON_HIT		= 0x4F,
> > +	ARMV7_PERFCTR_L1_INST			= 0x50,
> > +	ARMV7_PERFCTR_PC_RETURN_MIS_PRED	= 0x51,
> > +	ARMV7_PERFCTR_PC_BRANCH_FAILED		= 0x52,
> > +	ARMV7_PERFCTR_PC_BRANCH_TAKEN		= 0x53,
> > +	ARMV7_PERFCTR_PC_BRANCH_EXECUTED	= 0x54,
> > +	ARMV7_PERFCTR_OP_EXECUTED		= 0x55,
> > +	ARMV7_PERFCTR_CYCLES_INST_STALL		= 0x56,
> > +	ARMV7_PERFCTR_CYCLES_INST		= 0x57,
> > +	ARMV7_PERFCTR_CYCLES_NEON_DATA_STALL	= 0x58,
> > +	ARMV7_PERFCTR_CYCLES_NEON_INST_STALL	= 0x59,
> > +	ARMV7_PERFCTR_NEON_CYCLES		= 0x5A,
> > +
> > +	ARMV7_PERFCTR_PMU0_EVENTS		= 0x70,
> > +	ARMV7_PERFCTR_PMU1_EVENTS		= 0x71,
> > +	ARMV7_PERFCTR_PMU_EVENTS		= 0x72,
> > +
> > +	ARMV7_PERFCTR_CPU_CYCLES		= 0xFF
> > +};
>
> These events are specific to the Cortex-A8.
> Unfortunately, these numbers clash with events specific
> to the Cortex-A9 [and potentially future v7 cores].
> For example, 0x40 on the A8 is WRITE_BUFFER_FULL but on the
> A9 it is JAVA_BYTECODE_EXEC. This means that you'll need to
> take a similar approach as was taken for ARM11MP vs ARM11*.
Ok so I will need to separate Cortex-A8 from -A9.

> <snip>
>
> > +/*
> > + * Available counters
> > + */
> > +#define ARMV7_CCNT 		0
> > +#define ARMV7_CNT0 		1
> > +#define ARMV7_CNT1 		2
> > +#define ARMV7_CNT2 		3
> > +#define ARMV7_CNT3 		4
> > +#define ARMV7_CNTMAX 		5
> > +#define ARMV7_COUNTER_TO_CCNT	(ARMV7_CYCLE_COUNTER - ARMV7_CCNT)
> > +
> > +#define ARMV7_CPU_COUNTER(cpu, counter)	((cpu) * CNTMAX + (counter))
>
> You don't use this macro. I imagine there are others which are no longer
> used too.
Ok I am checking and cleaning the code.

> <snip>
>
> > +static inline int armv7_pmnc_select_counter(unsigned int cnt)
> > +{
> > +	u32 val;
> > +
> > +	cnt -= ARMV7_COUNTER_TO_CCNT;
> > +
> > +	if ((cnt == ARMV7_CCNT) || (cnt >= ARMV7_CNTMAX)) {
> > +		printk(KERN_ERR "oprofile: CPU%u selecting wrong PMNC counter"
> > +			" %d\n", smp_processor_id(), cnt);
> > +		return -1;
> > +	}
>
> Nice error message :)
Indeed! Theis is corrected already.

> <snip>
>
> >  static int __init
> >  init_hw_perf_events(void)
> >  {
> > @@ -977,6 +1676,13 @@ init_hw_perf_events(void)
> >                  memcpy(armpmu_perf_cache_map, armv6_perf_cache_map,
> >                         sizeof(armv6_perf_cache_map));
> >                  perf_max_events	= armv6pmu.num_events;
> > +	} else if (cpu_architecture() == CPU_ARCH_ARMv7) {
> > +		armpmu = &armv7pmu;
> > +		memcpy(armpmu_perf_cache_map, armv7_perf_cache_map,
> > +			sizeof(armv7_perf_cache_map));
> > +		perf_max_events	= armv7pmu.num_events;
> > +		/* Initialize & Reset PMNC: C bit and P bit */
> > +		armv7_pmnc_write(ARMV7_PMNC_P | ARMV7_PMNC_C);
> >          } else {
> >                  pr_info("no hardware support available\n");
> >                  perf_max_events = -1;
>
> You'll need to switch on the cpuid to select the correct event mappings.
>
> I've implemented this for oprofile, I'll post it as an RFC after Christmas
> as I won't be able to respond in the meantime.
Ok. Do you know how I can differentiate Cortex-A8 from -A9?

I will post a new version with the corrections.
>
> Cheers,
>
> Will

Cheers and a good celebration time,
Jean
