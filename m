From: Jonathan.Cameron@huawei.com (Jonathan Cameron)
Date: Tue, 25 Jul 2017 23:56:34 +0800
Subject: [PATCH v8 1/3] perf: cavium: Support memory controller PMU
 counters
In-Reply-To: <20170725150422.4775-2-jglauber@cavium.com>
References: <20170725150422.4775-1-jglauber@cavium.com>
 <20170725150422.4775-2-jglauber@cavium.com>
Message-ID: <20170725235634.00002574@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 25 Jul 2017 17:04:20 +0200
Jan Glauber <jglauber@cavium.com> wrote:

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
One trivial point inline which, whilst it obviously makes to actual
difference, makes review a tiny bit easier.

Otherwise looks good to me, but I'm somewhat new to this area
so who knows what I've missed ;)

> ---
>  drivers/perf/Kconfig       |   8 +
>  drivers/perf/Makefile      |   1 +
>  drivers/perf/cavium_pmu.c  | 424 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/cpuhotplug.h |   1 +
>  4 files changed, 434 insertions(+)
>  create mode 100644 drivers/perf/cavium_pmu.c
<snip>
> +static int cvm_pmu_lmc_probe(struct pci_dev *pdev)
> +{
> +	struct cvm_pmu_dev *next, *lmc;
> +	int nr = 0, ret = -ENOMEM;
> +
> +	lmc = kzalloc(sizeof(*lmc), GFP_KERNEL);
> +	if (!lmc)
> +		return -ENOMEM;
> +
> +	lmc->map = ioremap(pci_resource_start(pdev, 0),
> +			   pci_resource_len(pdev, 0));
> +	if (!lmc->map)
> +		goto fail_ioremap;
> +
> +	list_for_each_entry(next, &cvm_pmu_lmcs, entry)
> +		nr++;
> +	lmc->pmu_name = kasprintf(GFP_KERNEL, "lmc%d", nr);
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
Expected order to unwind the above would be the reverse of this.

> +fail_kasprintf:
> +	iounmap(lmc->map);
> +fail_ioremap:
> +	kfree(lmc);
> +	return ret;
> +}
> +
> +static int __init cvm_pmu_init(void)
> +{
> +	unsigned long implementor = read_cpuid_implementor();
> +	unsigned int vendor_id = PCI_VENDOR_ID_CAVIUM;
> +	struct pci_dev *pdev = NULL;
> +	int rc;
> +
> +	if (implementor != ARM_CPU_IMP_CAVIUM)
> +		return -ENODEV;
> +
> +	INIT_LIST_HEAD(&cvm_pmu_lmcs);
> +
> +	rc = cpuhp_setup_state_multi(CPUHP_AP_PERF_ARM_CVM_ONLINE,
> +				     "perf/arm/cvm:online", NULL,
> +				     cvm_pmu_offline_cpu);
> +
> +	/* detect LMC devices */
> +	while ((pdev = pci_get_device(vendor_id, 0xa022, pdev))) {
> +		if (!pdev)
> +			break;
> +		rc = cvm_pmu_lmc_probe(pdev);
> +		if (rc)
> +			return rc;
> +	}
> +	return 0;
> +}
> +late_initcall(cvm_pmu_init);	/* should come after PCI init */
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index b56573b..78ac3d2 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -141,6 +141,7 @@ enum cpuhp_state {
>  	CPUHP_AP_PERF_ARM_QCOM_L3_ONLINE,
>  	CPUHP_AP_WORKQUEUE_ONLINE,
>  	CPUHP_AP_RCUTREE_ONLINE,
> +	CPUHP_AP_PERF_ARM_CVM_ONLINE,
>  	CPUHP_AP_ONLINE_DYN,
>  	CPUHP_AP_ONLINE_DYN_END		= CPUHP_AP_ONLINE_DYN + 30,
>  	CPUHP_AP_X86_HPET_ONLINE,
