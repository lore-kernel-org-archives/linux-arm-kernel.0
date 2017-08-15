From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 15 Aug 2017 11:41:43 +0100
Subject: [PATCH v4 3/6] perf: hisi: Add support for HiSilicon SoC L3C PMU
 driver
In-Reply-To: <1500984642-204676-4-git-send-email-zhangshaokun@hisilicon.com>
References: <1500984642-204676-1-git-send-email-zhangshaokun@hisilicon.com>
 <1500984642-204676-4-git-send-email-zhangshaokun@hisilicon.com>
Message-ID: <20170815104143.GD6090@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 25, 2017 at 08:10:39PM +0800, Shaokun Zhang wrote:
> This patch adds support for L3C PMU driver in HiSilicon SoC chip, Each
> L3C has own control, counter and interrupt registers and is an separate
> PMU. For each L3C PMU, it has 8-programable counters and supports 0x60
> events, event code is 8-bits and every counter is free-running.
> Interrupt is supported to handle counter (48-bits) overflow.

[...]

> +/* L3C register definition */
> +#define L3C_PERF_CTRL		0x0408
> +#define L3C_INT_MASK		0x0800
> +#define L3C_INT_STATUS		0x0808
> +#define L3C_INT_CLEAR		0x080c
> +#define L3C_EVENT_CTRL	        0x1c00
> +#define L3C_EVENT_TYPE0		0x1d00
> +#define L3C_CNTR0_LOWER		0x1e00

Why does this have a _LOWER suffix?

How big is this regsiter? is it part of a pair of registers?

> +
> +/* L3C has 8-counters and supports 0x60 events */
> +#define L3C_NR_COUNTERS		0x8
> +#define L3C_NR_EVENTS		0x60

What exactly is meant by "supports 0x60 events"?

e.g. does tha mean event IDs 0-0x5f are valid?

> +static irqreturn_t hisi_l3c_pmu_isr(int irq, void *dev_id)
> +{
> +	struct hisi_pmu *l3c_pmu = dev_id;
> +	struct perf_event *event;
> +	unsigned long overflown;
> +	u32 status;
> +	int idx;
> +
> +	/* Read L3C_INT_STATUS register */
> +	status = readl(l3c_pmu->base + L3C_INT_STATUS);
> +	if (!status)
> +		return IRQ_NONE;
> +	overflown = status;

You don't need the temporary u32 value here; you can assign directly to
an unsigned lnog and do all the manipulation on that.

[...]

> +/* Check if the CPU belongs to the SCCL and CCL of PMU */
> +static bool hisi_l3c_is_cpu_in_ccl(struct hisi_pmu *l3c_pmu)
> +{
> +	u32 ccl_id, sccl_id;
> +
> +	hisi_read_sccl_and_ccl_id(&sccl_id, &ccl_id);
> +
> +	if (sccl_id != l3c_pmu->sccl_id)
> +		return false;
> +
> +	if (ccl_id != l3c_pmu->ccl_id)
> +		return false;
> +
> +	/* Return true if matched */
> +	return true;
> +}

The conditionals would be simpler as:

	return (sccl_id == l3c_pmu->sccl_id &&
	        ccl_id == l3c_pmu->ccl_id);

> +
> +static int hisi_l3c_pmu_online_cpu(unsigned int cpu, struct hlist_node *node)
> +{
> +	struct hisi_pmu *l3c_pmu;
> +
> +	l3c_pmu = hlist_entry_safe(node, struct hisi_pmu, node);
> +
> +	/* Proceed only when CPU belongs to the same SCCL and CCL */
> +	if (!hisi_l3c_is_cpu_in_ccl(l3c_pmu))
> +		return 0;

Surely you have a mask of CPUs that you can check instead? You'll need
that for the offline path.

[...]

> +static int hisi_l3c_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
> +{
> +	struct hisi_pmu *l3c_pmu;
> +	cpumask_t ccl_online_cpus;
> +	unsigned int target;
> +
> +	l3c_pmu = hlist_entry_safe(node, struct hisi_pmu, node);
> +
> +	/* Proceed only when CPU belongs to the same SCCL and CCL */
> +	if (!hisi_l3c_is_cpu_in_ccl(l3c_pmu))
> +		return 0;

Again, surely you can check a pre-computed mask?

> +
> +	/* Proceed if this CPU is used for event counting */
> +	if (!cpumask_test_cpu(cpu, &l3c_pmu->cpus))
> +		return 0;

You need to set up the CPU state regardless of whether there are active
events currently. Otherwise the cpumask can be stale, pointing at an
offline CPU, leaving the PMU unusable.

> +
> +	/* Give up ownership of CCL */
> +	cpumask_test_and_clear_cpu(cpu, &l3c_pmu->cpus);
> +
> +	/* Any other CPU for this CCL which is still online */
> +	cpumask_and(&ccl_online_cpus, cpu_coregroup_mask(cpu),
> +		    cpu_online_mask);

What is cpu_coregroup_mask? I do not think you can rely on that
happening to align with the physical CCL mask.

Instead, please:

* Keep track of which CPU(s) this PMU can be used from, with a cpumask.
  Either initialise that at probe time, or add CPUs to that in the
  hotplug callback.

* Use only that mask to determine which CPU to move the PMU context to.

* Use an int to hold the current CPU; there's no need to use a mask to
  hold what shoule be a single CPU ID.

[...]

> +	/* Get the L3C SCCL ID */
> +	if (device_property_read_u32(dev, "hisilicon,scl-id",
> +				     &l3c_pmu->sccl_id)) {
> +		dev_err(dev, "Can not read l3c sccl-id!\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Get the L3C CPU cluster(CCL) ID */
> +	if (device_property_read_u32(dev, "hisilicon,ccl-id",
> +				     &l3c_pmu->ccl_id)) {
> +		dev_err(dev, "Can not read l3c ccl-id!\n");
> +		return -EINVAL;
> +	}

Previously, you expect that these happen to match particular bits of the
MPIDR, which vary for multi-threaded cores. Please document this.

> +static int hisi_l3c_pmu_dev_probe(struct platform_device *pdev,
> +				  struct hisi_pmu *l3c_pmu)
> +{
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	ret = hisi_l3c_pmu_init_data(pdev, l3c_pmu);
> +	if (ret)
> +		return ret;
> +
> +	ret = hisi_l3c_pmu_init_irq(l3c_pmu, pdev);
> +	if (ret)
> +		return ret;
> +
> +	l3c_pmu->name = devm_kasprintf(dev, GFP_KERNEL, "hisi_l3c%u_%u",
> +				       l3c_pmu->l3c_tag_id, l3c_pmu->sccl_id);

As mentioned on the documentation patch, it would be nicer for the name
to be hierarchical, i.e. placing the SCCL ID first.

Thanks,
Mark.
