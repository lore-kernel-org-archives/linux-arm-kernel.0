From: Jonathan.Cameron@huawei.com (Jonathan Cameron)
Date: Mon, 24 Jul 2017 21:22:07 +0800
Subject: [PATCH v7 1/3] perf: cavium: Support memory controller PMU
 counters
In-Reply-To: <20170724085718.GA6485@hc>
References: <20170719120847.21183-1-jglauber@cavium.com>
 <20170719120847.21183-2-jglauber@cavium.com>
 <20170719212722.000017e1@huawei.com> <20170724085718.GA6485@hc>
Message-ID: <20170724212207.00006206@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 24 Jul 2017 10:57:18 +0200
Jan Glauber <jan.glauber@caviumnetworks.com> wrote:

> Hi Jonathan,
> 
> On Wed, Jul 19, 2017 at 09:31:01PM +0800, Jonathan Cameron wrote:
> > On Wed, 19 Jul 2017 14:08:45 +0200
> > Jan Glauber <jglauber@cavium.com> wrote:
> >   
> > > Add support for the PMU counters on Cavium SOC memory controllers.
> > > 
> > > This patch also adds generic functions to allow supporting more
> > > devices with PMU counters.
> > > 
> > > Properties of the LMC PMU counters:
> > > - not stoppable
> > > - fixed purpose
> > > - read-only
> > > - one PCI device per memory controller
> > > 
> > > Signed-off-by: Jan Glauber <jglauber@cavium.com>  
> > Hi Jan,
> > 
> > A few little things I noticed whilst taking a quick look.
> > 
> > Jonathan  
> > > ---
> > >  drivers/perf/Kconfig       |   8 +
> > >  drivers/perf/Makefile      |   1 +
> > >  drivers/perf/cavium_pmu.c  | 416 +++++++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/cpuhotplug.h |   1 +
> > >  4 files changed, 426 insertions(+)
> > >  create mode 100644 drivers/perf/cavium_pmu.c  
> > <snip>  
> > > +
> > > +/*
> > > + * The pmu events are independent from CPUs. Provide a cpumask
> > > + * nevertheless to prevent perf from adding the event per-cpu and just
> > > + * set the mask to one online CPU. Use the same cpumask for all "uncore"
> > > + * devices.
> > > + *
> > > + * There is a performance penalty for accessing a device from a CPU on
> > > + * another socket, but we do not care.
> > > + */
> > > +static int cvm_pmu_offline_cpu(unsigned int old_cpu, struct hlist_node *node)
> > > +{
> > > +	struct cvm_pmu_dev *pmu_dev;
> > > +	int new_cpu;
> > > +
> > > +	pmu_dev = hlist_entry_safe(node, struct cvm_pmu_dev, cpuhp_node);
> > > +	if (!cpumask_test_and_clear_cpu(old_cpu, &pmu_dev->active_mask))
> > > +		return 0;
> > > +
> > > +	new_cpu = cpumask_any_but(cpu_online_mask, old_cpu);
> > > +	if (new_cpu >= nr_cpu_ids)
> > > +		return 0;  
> > Blank line.  
> 
> OK
> 
> > > +	perf_pmu_migrate_context(&pmu_dev->pmu, old_cpu, new_cpu);
> > > +	cpumask_set_cpu(new_cpu, &pmu_dev->active_mask);  
> > nitpick : blank line here would help readability.  
> 
> OK
> 
> > > +	return 0;
> > > +}
> > > +
> > > +static ssize_t cvm_pmu_attr_show_cpumask(struct device *dev,
> > > +					 struct device_attribute *attr,
> > > +					 char *buf)
> > > +{
> > > +	struct pmu *pmu = dev_get_drvdata(dev);
> > > +	struct cvm_pmu_dev *pmu_dev = container_of(pmu, struct cvm_pmu_dev, pmu);
> > > +
> > > +	return cpumap_print_to_pagebuf(true, buf, &pmu_dev->active_mask);
> > > +}
> > > +
> > > +static DEVICE_ATTR(cpumask, S_IRUGO, cvm_pmu_attr_show_cpumask, NULL);
> > > +
> > > +static struct attribute *cvm_pmu_attrs[] = {
> > > +	&dev_attr_cpumask.attr,
> > > +	NULL,
> > > +};
> > > +
> > > +static struct attribute_group cvm_pmu_attr_group = {
> > > +	.attrs = cvm_pmu_attrs,
> > > +};
> > > +
> > > +/*
> > > + * LMC (memory controller) counters:
> > > + * - not stoppable, always on, read-only
> > > + * - one PCI device per memory controller
> > > + */
> > > +#define LMC_CONFIG_OFFSET		0x188
> > > +#define LMC_CONFIG_RESET_BIT		BIT(17)
> > > +
> > > +/* LMC events */
> > > +#define LMC_EVENT_IFB_CNT		0x1d0
> > > +#define LMC_EVENT_OPS_CNT		0x1d8
> > > +#define LMC_EVENT_DCLK_CNT		0x1e0
> > > +#define LMC_EVENT_BANK_CONFLICT1	0x360
> > > +#define LMC_EVENT_BANK_CONFLICT2	0x368
> > > +
> > > +#define CVM_PMU_LMC_EVENT_ATTR(_name, _id)						\
> > > +	&((struct perf_pmu_events_attr[]) {						\
> > > +		{									\
> > > +			__ATTR(_name, S_IRUGO, cvm_pmu_event_sysfs_show, NULL),		\
> > > +			_id,								\
> > > +			"lmc_event=" __stringify(_id),					\
> > > +		}									\
> > > +	})[0].attr.attr
> > > +
> > > +/* map counter numbers to register offsets */
> > > +static int lmc_events[] = {
> > > +	LMC_EVENT_IFB_CNT,
> > > +	LMC_EVENT_OPS_CNT,
> > > +	LMC_EVENT_DCLK_CNT,
> > > +	LMC_EVENT_BANK_CONFLICT1,
> > > +	LMC_EVENT_BANK_CONFLICT2,
> > > +};
> > > +
> > > +static int cvm_pmu_lmc_add(struct perf_event *event, int flags)
> > > +{
> > > +	struct hw_perf_event *hwc = &event->hw;
> > > +
> > > +	return cvm_pmu_add(event, flags, LMC_CONFIG_OFFSET,
> > > +			   lmc_events[hwc->config]);
> > > +}
> > > +
> > > +PMU_FORMAT_ATTR(lmc_event, "config:0-2");
> > > +
> > > +static struct attribute *cvm_pmu_lmc_format_attr[] = {
> > > +	&format_attr_lmc_event.attr,
> > > +	NULL,
> > > +};
> > > +
> > > +static struct attribute_group cvm_pmu_lmc_format_group = {
> > > +	.name = "format",
> > > +	.attrs = cvm_pmu_lmc_format_attr,
> > > +};
> > > +
> > > +static struct attribute *cvm_pmu_lmc_events_attr[] = {
> > > +	CVM_PMU_LMC_EVENT_ATTR(ifb_cnt,		0),
> > > +	CVM_PMU_LMC_EVENT_ATTR(ops_cnt,		1),
> > > +	CVM_PMU_LMC_EVENT_ATTR(dclk_cnt,	2),
> > > +	CVM_PMU_LMC_EVENT_ATTR(bank_conflict1,	3),
> > > +	CVM_PMU_LMC_EVENT_ATTR(bank_conflict2,	4),
> > > +	NULL,
> > > +};
> > > +
> > > +static struct attribute_group cvm_pmu_lmc_events_group = {
> > > +	.name = "events",
> > > +	.attrs = cvm_pmu_lmc_events_attr,
> > > +};
> > > +
> > > +static const struct attribute_group *cvm_pmu_lmc_attr_groups[] = {
> > > +	&cvm_pmu_attr_group,
> > > +	&cvm_pmu_lmc_format_group,
> > > +	&cvm_pmu_lmc_events_group,
> > > +	NULL,
> > > +};
> > > +
> > > +static bool cvm_pmu_lmc_event_valid(u64 config)
> > > +{
> > > +	return (config < ARRAY_SIZE(lmc_events));
> > > +}
> > > +
> > > +static int cvm_pmu_lmc_probe(struct pci_dev *pdev)
> > > +{
> > > +	struct cvm_pmu_dev *next, *lmc;
> > > +	int nr = 0, ret = -ENOMEM;
> > > +
> > > +	lmc = kzalloc(sizeof(*lmc), GFP_KERNEL);
> > > +	if (!lmc)
> > > +		goto fail_nomem;  
> > cleaner to do a direct return here as nothing to unwind.
> > return -ENOMEM;  
> 
> OK.
> 
> > > +
> > > +	lmc->map = ioremap(pci_resource_start(pdev, 0),
> > > +			   pci_resource_len(pdev, 0));  
> > Might be overly paranoid, but ioremap can return NULL,
> > so should really be checked.
> >   
> 
> I'll add the check.
> 
> > > +	list_for_each_entry(next, &cvm_pmu_lmcs, entry)
> > > +		nr++;
> > > +	lmc->pmu_name = kasprintf(GFP_KERNEL, "lmc%d", nr);  
> > Check for error on the allocation.  
> 
> OK, missed that.
> 
> > > +
> > > +	lmc->pdev = pdev;
> > > +	lmc->num_counters = ARRAY_SIZE(lmc_events);
> > > +	lmc->pmu = (struct pmu) {
> > > +		.task_ctx_nr    = perf_invalid_context,
> > > +		.event_init	= cvm_pmu_event_init,
> > > +		.add		= cvm_pmu_lmc_add,
> > > +		.del		= cvm_pmu_del,
> > > +		.start		= cvm_pmu_start,
> > > +		.stop		= cvm_pmu_stop,
> > > +		.read		= cvm_pmu_read,
> > > +		.attr_groups	= cvm_pmu_lmc_attr_groups,
> > > +	};
> > > +
> > > +	cpuhp_state_add_instance_nocalls(CPUHP_AP_PERF_ARM_CVM_ONLINE,
> > > +					 &lmc->cpuhp_node);  
> > This function can fail by the look of it.  Should be checking it's
> > return value really.
> >   
> 
> I'm ignoring the return value on purpose as I don't want probe() to fail
> even if this would return an error.
A comment perhaps to explain this.
> 
> > > +
> > > +	/*
> > > +	 * perf PMU is CPU dependent so pick a random CPU and migrate away
> > > +	 * if it goes offline.
> > > +	 */
> > > +	cpumask_set_cpu(smp_processor_id(), &lmc->active_mask);
> > > +
> > > +	ret = perf_pmu_register(&lmc->pmu, lmc->pmu_name, -1);
> > > +	if (ret)
> > > +		goto fail_hp;
> > > +
> > > +	list_add(&lmc->entry, &cvm_pmu_lmcs);
> > > +
> > > +	lmc->event_valid = cvm_pmu_lmc_event_valid;  
> > These last two elements rather look like they might cause a
> > potential race as the perf_pmu_register has made the counters
> > available.  
> 
> Yes, they should happen before perf_pmu_register.
> 
> > > +	dev_info(&pdev->dev, "Enabled %s PMU with %d counters\n",
> > > +		 lmc->pmu_name, lmc->num_counters);
> > > +	return 0;
> > > +
> > > +fail_hp:
> > > +	kfree(lmc->pmu_name);  
> > Convention is to unwind in the opposite order to the way things
> > were created / set up.  Becomes more relevant once you are
> > checking more error codes.  
> 
> Agreed.
> 
> > > +	cpuhp_state_remove_instance(CPUHP_AP_PERF_ARM_CVM_ONLINE,
> > > +				    &lmc->cpuhp_node);
> > > +	iounmap(lmc->map);
> > > +	kfree(lmc);
> > > +fail_nomem:
> > > +	return ret;
> > > +}
> > > +
> > > +static int __init cvm_pmu_init(void)
> > > +{
> > > +	unsigned long implementor = read_cpuid_implementor();
> > > +	unsigned int vendor_id = PCI_VENDOR_ID_CAVIUM;
> > > +	struct pci_dev *pdev = NULL;
> > > +	int rc;
> > > +
> > > +	if (implementor != ARM_CPU_IMP_CAVIUM)
> > > +		return -ENODEV;
> > > +
> > > +	INIT_LIST_HEAD(&cvm_pmu_lmcs);
> > > +
> > > +	rc = cpuhp_setup_state_multi(CPUHP_AP_PERF_ARM_CVM_ONLINE,
> > > +				     "perf/arm/cvm:online", NULL,
> > > +				     cvm_pmu_offline_cpu);
> > > +
> > > +	/* detect LMC devices */
> > > +	while ((pdev = pci_get_device(vendor_id, 0xa022, pdev))) {
> > > +		if (!pdev)
> > > +			break;
> > > +		rc = cvm_pmu_lmc_probe(pdev);
> > > +		if (rc)
> > > +			return rc;
> > > +	}
> > > +	return 0;
> > > +}  
> > A comment perhaps explaining why this is a late_initcall?  What
> > dependency are we forcing to be true?  
> 
> PCI probing should be finished before, I'll add a comment.
> 
> thanks for the review,
You are welcome.
> Jan
> 
> > > +late_initcall(cvm_pmu_init);
> > > diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> > > index b56573b..78ac3d2 100644
> > > --- a/include/linux/cpuhotplug.h
> > > +++ b/include/linux/cpuhotplug.h
> > > @@ -141,6 +141,7 @@ enum cpuhp_state {
> > >  	CPUHP_AP_PERF_ARM_QCOM_L3_ONLINE,
> > >  	CPUHP_AP_WORKQUEUE_ONLINE,
> > >  	CPUHP_AP_RCUTREE_ONLINE,
> > > +	CPUHP_AP_PERF_ARM_CVM_ONLINE,
> > >  	CPUHP_AP_ONLINE_DYN,
> > >  	CPUHP_AP_ONLINE_DYN_END		= CPUHP_AP_ONLINE_DYN + 30,
> > >  	CPUHP_AP_X86_HPET_ONLINE,  
> >   
