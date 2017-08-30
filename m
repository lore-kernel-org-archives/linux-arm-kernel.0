From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 30 Aug 2017 11:03:00 +0100
Subject: [RFC PATCH v9 5/7] perf: cavium: Support memory controller PMU
 counters
In-Reply-To: <20170829131238.4988-6-jglauber@cavium.com>
References: <20170829131238.4988-1-jglauber@cavium.com>
 <20170829131238.4988-6-jglauber@cavium.com>
Message-ID: <09997d9f-0003-0eb0-63d1-9b31e26e2229@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/08/17 14:12, Jan Glauber wrote:
> Add support for the PMU counters on Cavium SOC memory controllers.
>
> This patch also adds generic functions to allow supporting more
> devices with PMU counters.
>
> Properties of the LMC PMU counters:
> - not stoppable
> - fixed purpose
> - read-only
> - one PCI device per memory controller
>
> Signed-off-by: Jan Glauber <jglauber@cavium.com>

Jan,

Some minor comments below.

> +static void cvm_pmu_del(struct perf_event *event, int flags)
> +{
> +	struct cvm_pmu_dev *pmu_dev = to_pmu_dev(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	int i;
> +
> +	event->pmu->stop(event, PERF_EF_UPDATE);
> +
> +	/*
> +	 * For programmable counters we need to check where we installed it.
> +	 * To keep this function generic always test the more complicated
> +	 * case (free running counters won't need the loop).
> +	 */
> +	for (i = 0; i < pmu_dev->num_counters; i++)
> +		if (cmpxchg(&pmu_dev->events[i], event, NULL) == event)
> +			break;

Does this mean, it is the only way to map any given event (for programmable counters)
to a hardware counter ? What do we store in hwc->idx ? We have 2 additional
struct hw_perf_event_extra fields. We should be able to use one field to map it
back to the counter, isn't it ?

> +
> +	perf_event_update_userpage(event);
> +	hwc->idx = -1;
> +}
> +

...

> +/* LMC events */
> +#define LMC_EVENT_IFB_CNT		0x1d0
> +#define LMC_EVENT_OPS_CNT		0x1d8
> +#define LMC_EVENT_DCLK_CNT		0x1e0
> +#define LMC_EVENT_BANK_CONFLICT1	0x360
> +#define LMC_EVENT_BANK_CONFLICT2	0x368
> +
> +#define CVM_PMU_LMC_EVENT_ATTR(_name, _id)						\
> +	&((struct perf_pmu_events_attr[]) {						\
> +		{									\
> +			__ATTR(_name, S_IRUGO, cvm_pmu_event_sysfs_show, NULL),		\
> +			_id,								\
> +			"lmc_event=" __stringify(_id),					\
> +		}									\
> +	})[0].attr.attr
> +
> +/* map counter numbers to register offsets */
> +static int lmc_events[] = {
> +	LMC_EVENT_IFB_CNT,
> +	LMC_EVENT_OPS_CNT,
> +	LMC_EVENT_DCLK_CNT,
> +	LMC_EVENT_BANK_CONFLICT1,
> +	LMC_EVENT_BANK_CONFLICT2,
> +};
> +
> +static int cvm_pmu_lmc_add(struct perf_event *event, int flags)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	return cvm_pmu_add(event, flags, LMC_CONFIG_OFFSET,
> +			   lmc_events[hwc->config]);
> +}
> +

Is there any reason why we can't use the LMC event code directly
here, avoiding the mapping altogether ?

> +PMU_FORMAT_ATTR(lmc_event, "config:0-2");
> +
> +static struct attribute *cvm_pmu_lmc_format_attr[] = {
> +	&format_attr_lmc_event.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group cvm_pmu_lmc_format_group = {
> +	.name = "format",
> +	.attrs = cvm_pmu_lmc_format_attr,
> +};
> +
> +static struct attribute *cvm_pmu_lmc_events_attr[] = {
> +	CVM_PMU_LMC_EVENT_ATTR(ifb_cnt,		0),
> +	CVM_PMU_LMC_EVENT_ATTR(ops_cnt,		1),
> +	CVM_PMU_LMC_EVENT_ATTR(dclk_cnt,	2),
> +	CVM_PMU_LMC_EVENT_ATTR(bank_conflict1,	3),
> +	CVM_PMU_LMC_EVENT_ATTR(bank_conflict2,	4),
> +	NULL,
> +};
> +
> +static struct attribute_group cvm_pmu_lmc_events_group = {
> +	.name = "events",
> +	.attrs = cvm_pmu_lmc_events_attr,
> +};
> +
> +static const struct attribute_group *cvm_pmu_lmc_attr_groups[] = {
> +	&cvm_pmu_attr_group,
> +	&cvm_pmu_lmc_format_group,
> +	&cvm_pmu_lmc_events_group,
> +	NULL,
> +};
> +
> +static bool cvm_pmu_lmc_event_valid(u64 config)
> +{
> +	return (config < ARRAY_SIZE(lmc_events));
> +}
> +
> +int cvm_lmc_pmu_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> +{
> +	struct cvm_pmu_dev *next, *lmc;
> +	int nr = 0, ret = -ENOMEM;
> +
> +	lmc = kzalloc(sizeof(*lmc), GFP_KERNEL);
> +	if (!lmc)
> +		return -ENOMEM;

As Shaokun mentioned already, we could use devm_kzalloc() to avoid having to
cleanup the memory explicitly upon error and during module unload.

> +
> +	lmc->map = ioremap(pci_resource_start(pdev, 0),
> +			   pci_resource_len(pdev, 0));

Use devm_ioremap here. See below.

> +	if (!lmc->map)
> +		goto fail_ioremap;
> +
> +	list_for_each_entry(next, &cvm_pmu_lmcs, entry)
> +		nr++;
> +	lmc->pmu_name = kasprintf(GFP_KERNEL, "lmc%d", nr);

Again, you could remove the field and use devm_kasprintf() into a local
variable for using it with pmu_register. It would be automatically free'd
upon error or device removal.

> +	if (!lmc->pmu_name)
> +		goto fail_kasprintf;
> +
> +	lmc->pdev = pdev;
> +	lmc->num_counters = ARRAY_SIZE(lmc_events);
> +	lmc->pmu = (struct pmu) {
> +		.task_ctx_nr    = perf_invalid_context,
> +		.event_init	= cvm_pmu_event_init,
> +		.add		= cvm_pmu_lmc_add,
> +		.del		= cvm_pmu_del,
> +		.start		= cvm_pmu_start,
> +		.stop		= cvm_pmu_stop,
> +		.read		= cvm_pmu_read,
> +		.attr_groups	= cvm_pmu_lmc_attr_groups,
> +	};
> +
> +	cpuhp_state_add_instance_nocalls(CPUHP_AP_PERF_ARM_CVM_ONLINE,
> +					 &lmc->cpuhp_node);
> +
> +	/*
> +	 * perf PMU is CPU dependent so pick a random CPU and migrate away
> +	 * if it goes offline.
> +	 */
> +	cpumask_set_cpu(smp_processor_id(), &lmc->active_mask);
> +
> +	list_add(&lmc->entry, &cvm_pmu_lmcs);
> +	lmc->event_valid = cvm_pmu_lmc_event_valid;
> +
> +	ret = perf_pmu_register(&lmc->pmu, lmc->pmu_name, -1);
> +	if (ret)
> +		goto fail_pmu;
> +
> +	dev_info(&pdev->dev, "Enabled %s PMU with %d counters\n",
> +		 lmc->pmu_name, lmc->num_counters);
> +	return 0;
> +
> +fail_pmu:
> +	kfree(lmc->pmu_name);
> +	cpuhp_state_remove_instance(CPUHP_AP_PERF_ARM_CVM_ONLINE,
> +				    &lmc->cpuhp_node);
> +fail_kasprintf:
> +	iounmap(lmc->map);
> +fail_ioremap:
> +	kfree(lmc);

As mentioned above, if you switch to devm_* versions, you could get rid of this
kfrees and iounmap.
