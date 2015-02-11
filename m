From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 11 Feb 2015 15:28:04 -0800
Subject: [PATCH 2/2] ARM: perf: Add support for Scorpion PMUs
In-Reply-To: <1423616724-20849-3-git-send-email-sboyd@codeaurora.org>
References: <1423616724-20849-1-git-send-email-sboyd@codeaurora.org>
 <1423616724-20849-3-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150211232804.GF11190@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/10, Stephen Boyd wrote:
> Scorpion supports a set of local performance monitor event
> selection registers (LPM) sitting behind a cp15 based interface
> that extend the architected PMU events to include Scorpion CPU
> and Venum VFP specific events. To use these events the user is
> expected to program the lpm register with the event code shifted
> into the group they care about and then point the PMNx event at
> that region+group combo by writing a LPMn_GROUPx event. Add
> support for this hardware.
> 
> Note: the raw event number is a pure software construct that
> allows us to map the multi-dimensional number space of regions,
> groups, and event codes into a flat event number space suitable
> for use by the perf framework.
> 
> This is based on code originally written by Ashwin Chaugule and
> Neil Leeder [1] massed to become similar to the Krait PMU support
> code.
> 
> [1] https://www.codeaurora.org/cgit/quic/la/kernel/msm/tree/arch/arm/kernel/perf_event_msm.c?h=msm-3.4
> 
> Cc: Neil Leeder <nleeder@codeaurora.org>
> Cc: Ashwin Chaugule <ashwinc@codeaurora.org>
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/arm/pmu.txt |   2 +
>  arch/arm/kernel/perf_event_cpu.c              |   2 +
>  arch/arm/kernel/perf_event_v7.c               | 395 ++++++++++++++++++++++++++
>  3 files changed, 399 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/pmu.txt b/Documentation/devicetree/bindings/arm/pmu.txt
> index 75ef91d08f3b..6e54a9d88b7a 100644
> --- a/Documentation/devicetree/bindings/arm/pmu.txt
> +++ b/Documentation/devicetree/bindings/arm/pmu.txt
> @@ -18,6 +18,8 @@ Required properties:
>  	"arm,arm11mpcore-pmu"
>  	"arm,arm1176-pmu"
>  	"arm,arm1136-pmu"
> +	"qcom,scorpion-pmu"
> +	"qcom,scorpion-mp-pmu"
>  	"qcom,krait-pmu"
>  - interrupts : 1 combined interrupt or 1 per core. If the interrupt is a per-cpu
>                 interrupt (PPI) then 1 interrupt should be specified.
> diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
> index dd9acc95ebc0..010ffd241434 100644
> --- a/arch/arm/kernel/perf_event_cpu.c
> +++ b/arch/arm/kernel/perf_event_cpu.c
> @@ -242,6 +242,8 @@ static struct of_device_id cpu_pmu_of_device_ids[] = {
>  	{.compatible = "arm,arm11mpcore-pmu",	.data = armv6mpcore_pmu_init},
>  	{.compatible = "arm,arm1176-pmu",	.data = armv6_1176_pmu_init},
>  	{.compatible = "arm,arm1136-pmu",	.data = armv6_1136_pmu_init},
> +	{.compatible = "qcom,scorpion-pmu",	.data = scorpion_pmu_init},
> +	{.compatible = "qcom,scorpion-mp-pmu",	.data = scorpion_pmu_init},
>  	{.compatible = "qcom,krait-pmu",	.data = krait_pmu_init},
>  	{},
>  };
> diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
> index 84a3ec3bc592..14bc8726f554 100644
> --- a/arch/arm/kernel/perf_event_v7.c
> +++ b/arch/arm/kernel/perf_event_v7.c
> @@ -140,6 +140,23 @@ enum krait_perf_types {
>  	KRAIT_PERFCTR_L1_DTLB_ACCESS			= 0x12210,
>  };
>  
> +/* ARMv7 Scorpion specific event types */
> +enum scorpion_perf_types {
> +	SCORPION_LPM0_GROUP0				= 0x4c,
> +	SCORPION_LPM1_GROUP0				= 0x50,
> +	SCORPION_LPM2_GROUP0				= 0x54,
> +	SCORPION_L2LPM_GROUP0				= 0x58,
> +	SCORPION_VLPM_GROUP0				= 0x5c,
> +
> +	SCORPION_ICACHE_ACCESS				= 0x10053,
> +	SCORPION_ICACHE_MISS				= 0x10052,
> +
> +	SCORPION_DTLB_ACCESS				= 0x12013,
> +	SCORPION_DTLB_MISS				= 0x12012,
> +
> +	SCORPION_ITLB_MISS				= 0x12021,
> +};
> +
>  /*
>   * Cortex-A8 HW events mapping
>   *
> @@ -482,6 +499,51 @@ static const unsigned krait_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
>  };
>  
>  /*
> + * Scorpion HW events mapping
> + */
> +static const unsigned scorpion_perf_map[PERF_COUNT_HW_MAX] = {
> +	PERF_MAP_ALL_UNSUPPORTED,
> +	[PERF_COUNT_HW_CPU_CYCLES]	    = ARMV7_PERFCTR_CPU_CYCLES,
> +	[PERF_COUNT_HW_INSTRUCTIONS]	    = ARMV7_PERFCTR_INSTR_EXECUTED,
> +	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = ARMV7_PERFCTR_PC_WRITE,
> +	[PERF_COUNT_HW_BRANCH_MISSES]	    = ARMV7_PERFCTR_PC_BRANCH_MIS_PRED,
> +	[PERF_COUNT_HW_BUS_CYCLES]	    = ARMV7_PERFCTR_CLOCK_CYCLES,
> +};
> +
> +static const unsigned scorpion_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
> +					    [PERF_COUNT_HW_CACHE_OP_MAX]
> +					    [PERF_COUNT_HW_CACHE_RESULT_MAX] = {
> +	PERF_CACHE_MAP_ALL_UNSUPPORTED,
> +	/*
> +	 * The performance counters don't differentiate between read and write
> +	 * accesses/misses so this isn't strictly correct, but it's the best we
> +	 * can do. Writes and reads get combined.
> +	 */
> +	[C(L1D)][C(OP_READ)][C(RESULT_ACCESS)] = ARMV7_PERFCTR_L1_DCACHE_ACCESS,
> +	[C(L1D)][C(OP_READ)][C(RESULT_MISS)] = ARMV7_PERFCTR_L1_DCACHE_REFILL,
> +	[C(L1D)][C(OP_WRITE)][C(RESULT_ACCESS)] = ARMV7_PERFCTR_L1_DCACHE_ACCESS,
> +	[C(L1D)][C(OP_WRITE)][C(RESULT_MISS)] = ARMV7_PERFCTR_L1_DCACHE_REFILL,
> +	[C(L1I)][C(OP_READ)][C(RESULT_ACCESS)] = SCORPION_ICACHE_ACCESS,
> +	[C(L1I)][C(OP_READ)][C(RESULT_MISS)] = SCORPION_ICACHE_MISS,
> +	[C(L1I)][C(OP_WRITE)][C(RESULT_ACCESS)] = SCORPION_ICACHE_ACCESS,
> +	[C(L1I)][C(OP_WRITE)][C(RESULT_MISS)] = SCORPION_ICACHE_MISS,
> +	/*
> +	 * Only ITLB misses and DTLB refills are supported.  If users want the
> +	 * DTLB refills misses a raw counter must be used.
> +	 */
> +	[C(DTLB)][C(OP_READ)][C(RESULT_ACCESS)] = SCORPION_DTLB_ACCESS,
> +	[C(DTLB)][C(OP_READ)][C(RESULT_MISS)] = SCORPION_DTLB_MISS,
> +	[C(DTLB)][C(OP_WRITE)][C(RESULT_ACCESS)] = SCORPION_DTLB_ACCESS,
> +	[C(DTLB)][C(OP_WRITE)][C(RESULT_MISS)] = SCORPION_DTLB_MISS,
> +	[C(ITLB)][C(OP_READ)][C(RESULT_MISS)] = SCORPION_ITLB_MISS,
> +	[C(ITLB)][C(OP_WRITE)][C(RESULT_MISS)] = SCORPION_ITLB_MISS,
> +	[C(BPU)][C(OP_READ)][C(RESULT_ACCESS)] = ARMV7_PERFCTR_PC_BRANCH_PRED,
> +	[C(BPU)][C(OP_READ)][C(RESULT_MISS)] = ARMV7_PERFCTR_PC_BRANCH_PRED,
> +	[C(BPU)][C(OP_WRITE)][C(RESULT_ACCESS)] = ARMV7_PERFCTR_PC_BRANCH_PRED,
> +	[C(BPU)][C(OP_WRITE)][C(RESULT_MISS)] = ARMV7_PERFCTR_PC_BRANCH_PRED,
> +};
> +
> +/*
>   * Perf Events' indices
>   */
>  #define	ARMV7_IDX_CYCLE_COUNTER	0
> @@ -976,6 +1038,12 @@ static int krait_map_event_no_branch(struct perf_event *event)
>  				&krait_perf_cache_map, 0xFFFFF);
>  }
>  
> +static int scorpion_map_event(struct perf_event *event)
> +{
> +	return armpmu_map_event(event, &scorpion_perf_map,
> +				&scorpion_perf_cache_map, 0xFFFFF);
> +}
> +
>  static void armv7pmu_init(struct arm_pmu *cpu_pmu)
>  {
>  	cpu_pmu->handle_irq	= armv7pmu_handle_irq;
> @@ -1463,6 +1531,333 @@ static int krait_pmu_init(struct arm_pmu *cpu_pmu)
>  	cpu_pmu->clear_event_idx = krait_pmu_clear_event_idx;
>  	return 0;
>  }
> +
> +/*
> + * Scorpion Local Performance Monitor Register (LPMn)
> + *
> + *            31   30     24     16     8      0
> + *            +--------------------------------+
> + *  LPM0      | EN |  CC  |  CC  |  CC  |  CC  |   N = 1, R = 0
> + *            +--------------------------------+
> + *  LPM1      | EN |  CC  |  CC  |  CC  |  CC  |   N = 1, R = 1
> + *            +--------------------------------+
> + *  LPM2      | EN |  CC  |  CC  |  CC  |  CC  |   N = 1, R = 2
> + *            +--------------------------------+
> + *  L2LPM     | EN |  CC  |  CC  |  CC  |  CC  |   N = 1, R = 3
> + *            +--------------------------------+
> + *  VLPM      | EN |  CC  |  CC  |  CC  |  CC  |   N = 2, R = ?
> + *            +--------------------------------+
> + *              EN | G=3  | G=2  | G=1  | G=0
> + *
> + *
> + *  Event Encoding:
> + *
> + *      hwc->config_base = 0xNRCCG
> + *
> + *      N  = prefix, 1 for Scorpion CPU (LPMn/L2LPM), 2 for Venum VFP (VLPM)
> + *      R  = region register
> + *      CC = class of events the group G is choosing from
> + *      G  = group or particular event
> + *
> + *  Example: 0x12021 is a Scorpion CPU event in LPM2's group 1 with code 2
> + *
> + *  A region (R) corresponds to a piece of the CPU (execution unit, instruction
> + *  unit, etc.) while the event code (CC) corresponds to a particular class of
> + *  events (interrupts for example). An event code is broken down into
> + *  groups (G) that can be mapped into the PMU (irq, fiqs, and irq+fiqs for
> + *  example).
> + */
> +
> +static u32 scorpion_read_pmresrn(int n)
> +{
> +	u32 val;
> +
> +	switch (n) {
> +	case 0:
> +		asm volatile("mrc p15, 0, %0, c15, c0, 0" : "=r" (val));
> +		break;
> +	case 1:
> +		asm volatile("mrc p15, 1, %0, c15, c0, 0" : "=r" (val));
> +		break;
> +	case 2:
> +		asm volatile("mrc p15, 2, %0, c15, c0, 0" : "=r" (val));
> +		break;
> +	case 3:
> +		asm volatile("mrc p15, 3, %0, c15, c2, 0" : "=r" (val));
> +		break;
> +	default:
> +		BUG(); /* Should be validated in scorpion_pmu_get_event_idx() */
> +	}
> +
> +	return val;
> +}
> +
> +static void scorpion_write_pmresrn(int n, u32 val)
> +{
> +	switch (n) {
> +	case 0:
> +		asm volatile("mcr p15, 0, %0, c15, c0, 0" : : "r" (val));
> +		break;
> +	case 1:
> +		asm volatile("mcr p15, 1, %0, c15, c0, 0" : : "r" (val));
> +		break;
> +	case 2:
> +		asm volatile("mcr p15, 2, %0, c15, c0, 0" : : "r" (val));
> +		break;
> +	case 3:
> +		asm volatile("mcr p15, 3, %0, c15, c0, 0" : : "r" (val));
> +		break;
> +	default:
> +		BUG(); /* Should be validated in scorpion_pmu_get_event_idx() */
> +	}
> +}
> +
> +static u32 scorpion_get_pmresrn_event(unsigned int region)
> +{
> +	static const u32 pmresrn_table[] = { SCORPION_LPM0_GROUP0,
> +					     SCORPION_LPM1_GROUP0,
> +					     SCORPION_LPM2_GROUP0,
> +					     SCORPION_L2LPM_GROUP0 };
> +	return pmresrn_table[region];
> +}
> +
> +static void scorpion_evt_setup(int idx, u32 config_base)
> +{
> +	u32 val;
> +	u32 mask;
> +	u32 vval, fval;
> +	unsigned int region;
> +	unsigned int group;
> +	unsigned int code;
> +	unsigned int group_shift;
> +	bool venum_event;
> +
> +	krait_decode_event(config_base, &region, &group, &code, &venum_event,
> +			   NULL);
> +
> +	group_shift = group * 8;
> +	mask = 0xff << group_shift;
> +
> +	/* Configure evtsel for the region and group */
> +	if (venum_event)
> +		val = SCORPION_VLPM_GROUP0;
> +	else
> +		val = scorpion_get_pmresrn_event(region);
> +	val += group;
> +	/* Mix in mode-exclusion bits */
> +	val |= config_base & (ARMV7_EXCLUDE_USER | ARMV7_EXCLUDE_PL1);
> +	armv7_pmnc_write_evtsel(idx, val);
> +
> +	asm volatile("mcr p15, 0, %0, c9, c15, 0" : : "r" (0));
> +
> +	if (venum_event) {
> +		venum_pre_pmresr(&vval, &fval);
> +		val = venum_read_pmresr();
> +		val &= ~mask;
> +		val |= code << group_shift;
> +		val |= PMRESRn_EN;
> +		venum_write_pmresr(val);
> +		venum_post_pmresr(vval, fval);
> +	} else {
> +		val = scorpion_read_pmresrn(region);
> +		val &= ~mask;
> +		val |= code << group_shift;
> +		val |= PMRESRn_EN;
> +		scorpion_write_pmresrn(region, val);
> +	}
> +}
> +
> +static void scorpion_clearpmu(u32 config_base)
> +{
> +	u32 val;
> +	u32 vval, fval;
> +	unsigned int region;
> +	unsigned int group;
> +	bool venum_event;
> +
> +	krait_decode_event(config_base, &region, &group, NULL, &venum_event,
> +			   NULL);
> +
> +	if (venum_event) {
> +		venum_pre_pmresr(&vval, &fval);
> +		val = venum_read_pmresr();
> +		val = clear_pmresrn_group(val, group);
> +		venum_write_pmresr(val);
> +		venum_post_pmresr(vval, fval);
> +	} else {
> +		val = scorpion_read_pmresrn(region);
> +		val = clear_pmresrn_group(val, group);
> +		scorpion_write_pmresrn(region, val);
> +	}
> +}
> +
> +static void scorpion_pmu_disable_event(struct perf_event *event)
> +{
> +	unsigned long flags;
> +	struct hw_perf_event *hwc = &event->hw;
> +	int idx = hwc->idx;
> +	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
> +	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
> +
> +	/* Disable counter and interrupt */
> +	raw_spin_lock_irqsave(&events->pmu_lock, flags);
> +
> +	/* Disable counter */
> +	armv7_pmnc_disable_counter(idx);
> +
> +	/*
> +	 * Clear pmresr code (if destined for PMNx counters)
> +	 */
> +	if (hwc->config_base & KRAIT_EVENT_MASK)
> +		scorpion_clearpmu(hwc->config_base);
> +
> +	/* Disable interrupt for this counter */
> +	armv7_pmnc_disable_intens(idx);
> +
> +	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
> +}
> +
> +static void scorpion_pmu_enable_event(struct perf_event *event)
> +{
> +	unsigned long flags;
> +	struct hw_perf_event *hwc = &event->hw;
> +	int idx = hwc->idx;
> +	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
> +	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
> +
> +	/*
> +	 * Enable counter and interrupt, and set the counter to count
> +	 * the event that we're interested in.
> +	 */
> +	raw_spin_lock_irqsave(&events->pmu_lock, flags);
> +
> +	/* Disable counter */
> +	armv7_pmnc_disable_counter(idx);
> +
> +	/*
> +	 * Set event (if destined for PMNx counters)
> +	 * We don't set the event for the cycle counter because we
> +	 * don't have the ability to perform event filtering.
> +	 */
> +	if (hwc->config_base & KRAIT_EVENT_MASK)
> +		scorpion_evt_setup(idx, hwc->config_base);
> +	else if (idx != ARMV7_IDX_CYCLE_COUNTER)
> +		armv7_pmnc_write_evtsel(idx, hwc->config_base);
> +
> +	/* Enable interrupt for this counter */
> +	armv7_pmnc_enable_intens(idx);
> +
> +	/* Enable counter */
> +	armv7_pmnc_enable_counter(idx);
> +
> +	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
> +}
> +
> +static void scorpion_pmu_reset(void *info)
> +{
> +	u32 vval, fval;
> +
> +	armv7pmu_reset(info);
> +
> +	/* Clear all pmresrs */
> +	scorpion_write_pmresrn(0, 0);
> +	scorpion_write_pmresrn(1, 0);
> +	scorpion_write_pmresrn(2, 0);
> +	scorpion_write_pmresrn(3, 0);
> +
> +	venum_pre_pmresr(&vval, &fval);
> +	venum_write_pmresr(0);
> +	venum_post_pmresr(vval, fval);
> +}
> +
> +static int scorpion_event_to_bit(struct perf_event *event, unsigned int region,
> +			      unsigned int group)
> +{
> +	int bit;
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
> +
> +	if (hwc->config_base & VENUM_EVENT)
> +		bit = SCORPION_VLPM_GROUP0;
> +	else
> +		bit = scorpion_get_pmresrn_event(region);
> +	bit -= scorpion_get_pmresrn_event(0);
> +	bit += group;
> +	/*
> +	 * Lower bits are reserved for use by the counters (see
> +	 * armv7pmu_get_event_idx() for more info)
> +	 */
> +	bit += ARMV7_IDX_COUNTER_LAST(cpu_pmu) + 1;
> +
> +	return bit;
> +}
> +
> +/*
> + * We check for column exclusion constraints here.
> + * Two events cant use the same group within a pmresr register.
> + */
> +static int scorpion_pmu_get_event_idx(struct pmu_hw_events *cpuc,
> +				   struct perf_event *event)
> +{
> +	int idx;
> +	int bit = -1;
> +	unsigned int region;
> +	unsigned int code;
> +	unsigned int group;
> +	bool venum_event, scorpion_event;
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	krait_decode_event(hwc->config_base, &region, &group, &code,
> +			   &venum_event, &scorpion_event);
> +
> +	if (venum_event || scorpion_event) {
> +		/* Ignore invalid events */
> +		if (group > 3 || region > 3)
> +			return -EINVAL;
> +
> +		bit = scorpion_event_to_bit(event, region, group);
> +		if (test_and_set_bit(bit, cpuc->used_mask))
> +			return -EAGAIN;
> +	}
> +
> +	idx = armv7pmu_get_event_idx(cpuc, event);
> +	if (idx < 0 && bit >= 0)
> +		clear_bit(bit, cpuc->used_mask);
> +
> +	return idx;
> +}
> +
> +static void scorpion_pmu_clear_event_idx(struct pmu_hw_events *cpuc,
> +				      struct perf_event *event)
> +{
> +	int bit;
> +	struct hw_perf_event *hwc = &event->hw;
> +	unsigned int region;
> +	unsigned int group;
> +	bool venum_event, scorpion_event;
> +
> +	krait_decode_event(hwc->config_base, &region, &group, NULL,
> +			   &venum_event, &scorpion_event);
> +
> +	if (venum_event || scorpion_event) {
> +		bit = scorpion_event_to_bit(event, region, group);
> +		clear_bit(bit, cpuc->used_mask);
> +	}
> +}
> +
> +static int scorpion_pmu_init(struct arm_pmu *cpu_pmu)
> +{
> +	armv7pmu_init(cpu_pmu);
> +	cpu_pmu->name		= "armv7_scorpion";
> +	cpu_pmu->map_event	= scorpion_map_event;
> +	cpu_pmu->num_events	= armv7_read_num_pmnc_events();
> +	cpu_pmu->reset		= scorpion_pmu_reset;
> +	cpu_pmu->enable		= scorpion_pmu_enable_event;
> +	cpu_pmu->disable	= scorpion_pmu_disable_event;
> +	cpu_pmu->get_event_idx	= scorpion_pmu_get_event_idx;
> +	cpu_pmu->clear_event_idx = scorpion_pmu_clear_event_idx;
> +	return 0;
> +}
>  #else
>  static inline int armv7_a8_pmu_init(struct arm_pmu *cpu_pmu)

I forgot to add the empty scorpion_pmu_init() when
CONFIG_CPU_V7=n. If there's no other comments by the end of the
week I'll send a v2.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
