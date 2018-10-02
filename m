From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Tue, 2 Oct 2018 15:11:26 +0100
Subject: [PATCH v3 2/3] perf: add arm64 smmuv3 pmu driver
In-Reply-To: <20180921150803.25444-3-shameerali.kolothum.thodi@huawei.com>
References: <20180921150803.25444-1-shameerali.kolothum.thodi@huawei.com>
 <20180921150803.25444-3-shameerali.kolothum.thodi@huawei.com>
Message-ID: <ecc2877c-146c-d70f-efd7-306fe704d55f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shameer,

I have a few comments below, mostly naive since I don't know anything
about perf drivers.

On 21/09/2018 16:08, Shameer Kolothum wrote:
> From: Neil Leeder <nleeder@codeaurora.org>
> 
> Adds a new driver to support the SMMUv3 PMU and add it into the
> perf events framework.
> 
> Each SMMU node may have multiple PMUs associated with it, each of
> which may support different events.
> 
> SMMUv3 PMCG devices are named as smmuv3_pmcg_<phys_addr_page> where
> <phys_addr_page> is the physical page address of the SMMU PMCG.
> For example, the PMCG at 0xff88840000 is named smmuv3_pmcg_ff88840
> 
> Filtering by stream id is done by specifying filtering parameters
> with the event. options are:
>    filter_enable    - 0 = no filtering, 1 = filtering enabled
>    filter_span      - 0 = exact match, 1 = pattern match
>    filter_stream_id - pattern to filter against
> Further filtering information is available in the SMMU documentation.
> 
> Example: perf stat -e smmuv3_pmcg_ff88840/transaction,filter_enable=1,
>                        filter_span=1,filter_stream_id=0x42/ -a pwd
> Applies filter pattern 0x42 to transaction events.
> 
> SMMU events are not attributable to a CPU, so task mode and sampling
> are not supported.
> 
> Signed-off-by: Neil Leeder <nleeder@codeaurora.org>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/perf/Kconfig          |   9 +
>  drivers/perf/Makefile         |   1 +
>  drivers/perf/arm_smmuv3_pmu.c | 736 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 746 insertions(+)
>  create mode 100644 drivers/perf/arm_smmuv3_pmu.c
> 
> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index 08ebaf7..34969dd 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -52,6 +52,15 @@ config ARM_PMU_ACPI
>  	depends on ARM_PMU && ACPI
>  	def_bool y
>  
> +config ARM_SMMU_V3_PMU
> +	 bool "ARM SMMUv3 Performance Monitors {Extension}"

Why the curly braces? I didn't find that notation in other Kconfig files

> +	 depends on ARM64 && ACPI && ARM_SMMU_V3
> +	   help
> +	   Provides support for the SMMU version 3 performance monitor unit (PMU)
> +	   on ARM-based systems.
> +	   Adds the SMMU PMU into the perf events subsystem for
> +	   monitoring SMMU performance events.
> +
>  config ARM_DSU_PMU
>  	tristate "ARM DynamIQ Shared Unit (DSU) PMU"
>  	depends on ARM64
> diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
> index b3902bd..f10a932 100644
> --- a/drivers/perf/Makefile
> +++ b/drivers/perf/Makefile
[...]
> +/*
> + * This driver adds support for perf events to use the Performance
> + * Monitor Counter Groups (PMCG) associated with an SMMUv3 node
> + * to monitor that node.
> + *
> + * SMMUv3 PMCG devices are named as smmuv3_pmcg_<phys_addr_page> where
> + * <phys_addr_page> is the physical page address of the SMMU PMCG.
> + * For example, the PMCG at 0xff88840000 is named smmuv3_pmcg_ff88840
> +
> + * Filtering by stream id is done by specifying filtering parameters
> + * with the event. options are:
> + *   filter_enable    - 0 = no filtering, 1 = filtering enabled
> + *   filter_span      - 0 = exact match, 1 = pattern match
> + *   filter_stream_id - pattern to filter against
> + * Further filtering information is available in the SMMU documentation.
> + *
> + * Example: perf stat -e smmuv3_pmcg_ff88840/transaction,filter_enable=1,
> + *                       filter_span=1,filter_stream_id=0x42/ -a pwd

I'm curious, why is pwd used as example? Wouldn't something like netperf
be a more realistic workload?

> + * Applies filter pattern 0x42 to transaction events.

Adding that this pattern matches SIDs 0x42 and 0x43 might be helpful,
since span filtering is a bit awkward

[...]
> +#define SMMU_PMU_EVENT_ATTR_EXTRACTOR(_name, _config, _size, _shift)    \
> +	static inline u32 get_##_name(struct perf_event *event)         \
> +	{                                                               \
> +		return (event->attr._config >> (_shift)) &              \
> +			GENMASK_ULL((_size) - 1, 0);                    \

FIELD_GET could make this slightly nicer

> +	}
> +
> +SMMU_PMU_EVENT_ATTR_EXTRACTOR(event, config, 16, 0);
> +SMMU_PMU_EVENT_ATTR_EXTRACTOR(filter_stream_id, config1, 32, 0);
> +SMMU_PMU_EVENT_ATTR_EXTRACTOR(filter_span, config1, 1, 32);
> +SMMU_PMU_EVENT_ATTR_EXTRACTOR(filter_enable, config1, 1, 34);

filter_enable is at bit 33, not 34

[...]
> +static void smmu_pmu_set_period(struct smmu_pmu *smmu_pmu,
> +				struct hw_perf_event *hwc)
> +{
> +	u32 idx = hwc->idx;
> +	u64 new;
> +
> +	/*
> +	 * We limit the max period to half the max counter value of the counter
> +	 * size, so that even in the case of extreme interrupt latency the
> +	 * counter will (hopefully) not wrap past its initial value.
> +	 */
> +	new = smmu_pmu->counter_mask >> 1;

Cool trick :)

> +
> +	local64_set(&hwc->prev_count, new);
> +	smmu_pmu_counter_set_value(smmu_pmu, idx, new);
> +}
> +
> +static unsigned int smmu_pmu_get_event_idx(struct smmu_pmu *smmu_pmu)
> +{
> +	unsigned int idx;
> +	unsigned int num_ctrs = smmu_pmu->num_counters;
> +
> +	idx = find_first_zero_bit(smmu_pmu->used_counters, num_ctrs);
> +	if (idx == num_ctrs)
> +		/* The counters are all in use. */
> +		return -EAGAIN;

Then this function's return type probably shouldn't be unsigned

> +
> +	set_bit(idx, smmu_pmu->used_counters);
> +
> +	return idx;
> +}
> +
> +/*
> + * Implementation of abstract pmu functionality required by
> + * the core perf events code.
> + */
> +
> +static int smmu_pmu_event_init(struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct smmu_pmu *smmu_pmu = to_smmu_pmu(event->pmu);
> +	struct device *dev = smmu_pmu->dev;
> +	struct perf_event *sibling;
> +	u32 event_id;
> +
> +	if (event->attr.type != event->pmu->type)
> +		return -ENOENT;
> +
> +	if (hwc->sample_period) {
> +		dev_dbg_ratelimited(dev, "Sampling not supported\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (event->cpu < 0) {
> +		dev_dbg_ratelimited(dev, "Per-task mode not supported\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	/* We cannot filter accurately so we just don't allow it. */
> +	if (event->attr.exclude_user || event->attr.exclude_kernel ||
> +	    event->attr.exclude_hv || event->attr.exclude_idle) {
> +		dev_dbg_ratelimited(dev, "Can't exclude execution levels\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	/* Verify specified event is supported on this PMU */
> +	event_id = get_event(event);
> +	if (((event_id < SMMU_ARCH_MAX_EVENT_ID) &&
> +	    (!test_bit(event_id, smmu_pmu->supported_events))) ||
> +	    (event_id > SMMU_IMPDEF_MAX_EVENT_ID)) {

>= ?

> +		dev_dbg_ratelimited(dev, "Invalid event %d for this PMU\n",
> +				    event_id);
> +		return -EINVAL;
> +	}

[...]
> +static struct attribute *smmu_pmu_events[] = {
> +	SMMU_EVENT_ATTR(cycles, 0),
> +	SMMU_EVENT_ATTR(transaction, 1),
> +	SMMU_EVENT_ATTR(tlb_miss, 2),
> +	SMMU_EVENT_ATTR(config_cache_miss, 3),
> +	SMMU_EVENT_ATTR(trans_table_walk, 4),

This name is a bit misleading - as far as I understand the event doesn't
count table walks, but memory accesses performed during a walk.

> +	SMMU_EVENT_ATTR(config_struct_access, 5),
> +	SMMU_EVENT_ATTR(pcie_ats_trans_rq, 6),
> +	SMMU_EVENT_ATTR(pcie_ats_trans_passed, 7),
> +	NULL
> +};

[...]
> +static int smmu_pmu_setup_irq(struct smmu_pmu *pmu)
> +{
> +	unsigned long flags = IRQF_NOBALANCING | IRQF_SHARED | IRQF_NO_THREAD;

Why do you need SHARED?

> +	int irq, ret = -ENXIO;
> +
> +	irq = pmu->irq;
> +	if (irq)
> +		ret = devm_request_irq(pmu->dev, irq, smmu_pmu_handle_irq,
> +				       flags, "smmuv3-pmu", pmu);
> +	return ret;
> +}
> +
> +static void smmu_pmu_reset(struct smmu_pmu *smmu_pmu)
> +{
> +	smmu_pmu_disable(&smmu_pmu->pmu);
> +
> +	/* Disable counter and interrupt */
> +	writeq_relaxed(smmu_pmu->counter_present_mask,
> +		       smmu_pmu->reg_base + SMMU_PMCG_CNTENCLR0);
> +	writeq_relaxed(smmu_pmu->counter_present_mask,
> +		       smmu_pmu->reg_base + SMMU_PMCG_INTENCLR0);
> +	writeq_relaxed(smmu_pmu->counter_present_mask,
> +		       smmu_pmu->reloc_base + SMMU_PMCG_OVSCLR0);
> +
> +	writeq_relaxed(0, smmu_pmu->reg_base + SMMU_PMCG_IRQ_CFG0);

smmu_pmu_setup_msi clears CFG0 a second time, so this line can be
deleted in patch 3, or moved to smmu_pmu_setup_msi right away.

> +}
> +
> +static int smmu_pmu_probe(struct platform_device *pdev)
> +{
> +	struct smmu_pmu *smmu_pmu;
> +	struct resource *res_0, *res_1;
> +	u32 cfgr, reg_size;
> +	u64 ceid_64[2];
> +	int irq, err;
> +	char *name;
> +	struct device *dev = &pdev->dev;
> +
> +	smmu_pmu = devm_kzalloc(dev, sizeof(*smmu_pmu), GFP_KERNEL);
> +	if (!smmu_pmu)
> +		return -ENOMEM;
> +
> +	smmu_pmu->dev = dev;
> +
> +	platform_set_drvdata(pdev, smmu_pmu);
> +	smmu_pmu->pmu = (struct pmu) {
> +		.task_ctx_nr    = perf_invalid_context,
> +		.pmu_enable	= smmu_pmu_enable,
> +		.pmu_disable	= smmu_pmu_disable,
> +		.event_init	= smmu_pmu_event_init,
> +		.add		= smmu_pmu_event_add,
> +		.del		= smmu_pmu_event_del,
> +		.start		= smmu_pmu_event_start,
> +		.stop		= smmu_pmu_event_stop,
> +		.read		= smmu_pmu_event_read,
> +		.attr_groups	= smmu_pmu_attr_grps,
> +	};
> +
> +	res_0 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	smmu_pmu->reg_base = devm_ioremap_resource(dev, res_0);
> +	if (IS_ERR(smmu_pmu->reg_base))
> +		return PTR_ERR(smmu_pmu->reg_base);
> +
> +	cfgr = readl_relaxed(smmu_pmu->reg_base + SMMU_PMCG_CFGR);
> +
> +	/* Determine if page 1 is present */
> +	if (cfgr & SMMU_PMCG_CFGR_RELOC_CTRS) {
> +		res_1 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +		smmu_pmu->reloc_base = devm_ioremap_resource(dev, res_1);
> +		if (IS_ERR(smmu_pmu->reloc_base))
> +			return PTR_ERR(smmu_pmu->reloc_base);
> +	} else {
> +		smmu_pmu->reloc_base = smmu_pmu->reg_base;
> +	}
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq > 0)
> +		smmu_pmu->irq = irq;
> +
> +	ceid_64[0] = readq_relaxed(smmu_pmu->reg_base + SMMU_PMCG_CEID0);
> +	ceid_64[1] = readq_relaxed(smmu_pmu->reg_base + SMMU_PMCG_CEID1);
> +	bitmap_from_arr32(smmu_pmu->supported_events, (u32 *)ceid_64,
> +			  SMMU_ARCH_MAX_EVENT_ID);
> +
> +	smmu_pmu->num_counters = FIELD_GET(SMMU_PMCG_CFGR_NCTR_MASK, cfgr) + 1;
> +	smmu_pmu->counter_present_mask = GENMASK(smmu_pmu->num_counters - 1, 0);
> +
> +	reg_size = FIELD_GET(SMMU_PMCG_CFGR_SIZE_MASK, cfgr);
> +	smmu_pmu->counter_mask = GENMASK_ULL(reg_size, 0);
> +
> +	smmu_pmu_reset(smmu_pmu);
> +
> +	err = smmu_pmu_setup_irq(smmu_pmu);
> +	if (err) {
> +		dev_err(dev, "Setup irq failed, PMU @%pa\n", &res_0->start);

You can probably remove "PMU @%pa" from error and info messages, since
the device name already uniquely identifies it:
"[    6.168200] arm-smmu-v3-pmu 2b442000.smmu-pmcg: Registered SMMU PMU
@ 0x000000002b442000 using 4 counters"

Thanks,
Jean
