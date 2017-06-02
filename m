From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 2 Jun 2017 17:39:38 +0100
Subject: [PATCH v5 3/3] perf: cavium: Support transmit-link PMU counters
In-Reply-To: <20170517083122.5050-4-jglauber@cavium.com>
References: <20170517083122.5050-1-jglauber@cavium.com>
 <20170517083122.5050-4-jglauber@cavium.com>
Message-ID: <20170602163937.GN28299@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 17, 2017 at 10:31:22AM +0200, Jan Glauber wrote:
> Add support for the transmit-link (TLK) PMU counters found
> on Caviums SOCs with an interconnect.
> 
> Signed-off-by: Jan Glauber <jglauber@cavium.com>
> ---
>  drivers/edac/thunderx_edac.c    |   7 ++
>  drivers/perf/cavium_pmu.c       | 223 +++++++++++++++++++++++++++++++++++++++-
>  include/linux/perf/cavium_pmu.h |   1 +
>  3 files changed, 230 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/thunderx_edac.c b/drivers/edac/thunderx_edac.c
> index 8de4faf..d3da6d3 100644
> --- a/drivers/edac/thunderx_edac.c
> +++ b/drivers/edac/thunderx_edac.c
> @@ -1496,6 +1496,10 @@ static int thunderx_ocx_probe(struct pci_dev *pdev,
>  
>  	writeq(OCX_COM_INT_ENA_ALL, ocx->regs + OCX_COM_INT_ENA_W1S);
>  
> +	if (IS_ENABLED(CONFIG_CAVIUM_PMU))
> +		ocx->pmu_data = cvm_pmu_probe(pdev, ocx->regs,
> +					      CVM_PMU_TLK);
> +
>  	return 0;
>  err_free:
>  	edac_device_free_ctl_info(edac_dev);
> @@ -1509,6 +1513,9 @@ static void thunderx_ocx_remove(struct pci_dev *pdev)
>  	struct thunderx_ocx *ocx = edac_dev->pvt_info;
>  	int i;
>  
> +	if (IS_ENABLED(CONFIG_CAVIUM_PMU))
> +		cvm_pmu_remove(pdev, ocx->pmu_data, CVM_PMU_TLK);
> +

As with the prior patch, I don't think we can handle the PMU like this.


[...]

> +static int cvm_pmu_tlk_add(struct perf_event *event, int flags)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	return cvm_pmu_add(event, flags, TLK_STAT_CTL_OFFSET,
> +			   TLK_STAT_OFFSET + hwc->config * 8);
> +}

> +static void *cvm_pmu_tlk_probe_unit(struct pci_dev *pdev, void __iomem *regs,
> +				    int nr)
> +{
> +	struct cvm_pmu_dev *tlk;
> +	int ret = -ENOMEM;
> +	char name[12];
> +
> +	tlk = kzalloc(sizeof(*tlk), GFP_KERNEL);
> +	if (!tlk)
> +		goto fail_nomem;
> +
> +	memset(name, 0, 12);
> +	snprintf(name, 12, "ocx_tlk%d", nr);

Please kasprintf() the name and pass it to perf_pmu_register().

AFAICT, pmu::name is a char *, and perf_pmu_register() doesn't make a copy, so
this isn't safe.

> +
> +	list_add(&tlk->entry, &cvm_pmu_tlks);

As withthe prio patch, please add the element to the list after
handling the failure cases.

> +
> +	tlk->pdev = pdev;
> +	tlk->map = regs + TLK_START_ADDR + nr * TLK_UNIT_OFFSET;
> +	tlk->num_counters = ARRAY_SIZE(cvm_pmu_tlk_events_attr) - 1;
> +	tlk->pmu = (struct pmu) {
> +		.name		= name,
> +		.task_ctx_nr    = perf_invalid_context,
> +		.pmu_enable	= cvm_pmu_tlk_enable_pmu,
> +		.pmu_disable	= cvm_pmu_tlk_disable_pmu,
> +		.event_init	= cvm_pmu_event_init,
> +		.add		= cvm_pmu_tlk_add,
> +		.del		= cvm_pmu_del,
> +		.start		= cvm_pmu_start,
> +		.stop		= cvm_pmu_stop,
> +		.read		= cvm_pmu_read,
> +		.attr_groups	= cvm_pmu_tlk_attr_groups,
> +	};
> +
> +	cpuhp_state_add_instance_nocalls(CPUHP_AP_PERF_ARM_CVM_ONLINE,
> +					 &tlk->cpuhp_node);
> +
> +	/*
> +	 * perf PMU is CPU dependent so pick a random CPU and migrate away
> +	 * if it goes offline.
> +	 */
> +	cpumask_set_cpu(smp_processor_id(), &tlk->active_mask);
> +
> +	ret = perf_pmu_register(&tlk->pmu, tlk->pmu.name, -1);
> +	if (ret)
> +		goto fail_hp;
> +
> +	tlk->event_valid = cvm_pmu_tlk_event_valid;
> +	return tlk;
> +
> +fail_hp:
> +	cpuhp_state_remove_instance(CPUHP_AP_PERF_ARM_CVM_ONLINE,
> +				    &tlk->cpuhp_node);
> +	kfree(tlk);
> +fail_nomem:
> +	return ERR_PTR(ret);
> +}

Thanks,
Mark.
