From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 2 Jun 2017 17:33:38 +0100
Subject: [PATCH v5 2/3] perf: cavium: Support memory controller PMU
 counters
In-Reply-To: <20170517083122.5050-3-jglauber@cavium.com>
References: <20170517083122.5050-1-jglauber@cavium.com>
 <20170517083122.5050-3-jglauber@cavium.com>
Message-ID: <20170602163337.GM28299@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, May 17, 2017 at 10:31:21AM +0200, Jan Glauber wrote:
> Add support for the PMU counters on Cavium SOC memory controllers.
> 
> This patch also adds generic functions to allow supporting more
> devices with PMU counters.

Please add a short description of the PMU. e.g. whether counters are
programmable, how they relate to components in the system.

> @@ -810,6 +812,9 @@ static int thunderx_lmc_probe(struct pci_dev *pdev,
>  		}
>  	}
>  
> +	if (IS_ENABLED(CONFIG_CAVIUM_PMU))
> +		lmc->pmu_data = cvm_pmu_probe(pdev, lmc->regs, CVM_PMU_LMC);

I don't think this makes sense given CAVIUM_PMU is a tristate. This
can't work if that's a module.

> @@ -824,6 +829,9 @@ static void thunderx_lmc_remove(struct pci_dev *pdev)
>  	struct mem_ctl_info *mci = pci_get_drvdata(pdev);
>  	struct thunderx_lmc *lmc = mci->pvt_info;
>  
> +	if (IS_ENABLED(CONFIG_CAVIUM_PMU))
> +		cvm_pmu_remove(pdev, lmc->pmu_data, CVM_PMU_LMC);

Likewise.

[...]

> +#define to_pmu_dev(x) container_of((x), struct cvm_pmu_dev, pmu)
> +
> +static int cvm_pmu_event_init(struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct cvm_pmu_dev *pmu_dev;
> +
> +	if (event->attr.type != event->pmu->type)
> +		return -ENOENT;
> +
> +	/* we do not support sampling */
> +	if (is_sampling_event(event))
> +		return -EINVAL;
> +
> +	/* PMU counters do not support any these bits */
> +	if (event->attr.exclude_user	||
> +	    event->attr.exclude_kernel	||
> +	    event->attr.exclude_host	||
> +	    event->attr.exclude_guest	||
> +	    event->attr.exclude_hv	||
> +	    event->attr.exclude_idle)
> +		return -EINVAL;
> +
> +	pmu_dev = to_pmu_dev(event->pmu);
> +	if (!pmu_dev)
> +		return -ENODEV;

This cannot happen given to_pmu_dev() is just a container_of().

> +	if (!pmu_dev->event_valid(event->attr.config))
> +		return -EINVAL;

Is group validation expected to take place in this callback?

AFAICT, nothing does so (including cvm_pmu_lmc_event_valid()).

> +
> +	hwc->config = event->attr.config;
> +	hwc->idx = -1;
> +	return 0;
> +}
> +
> +static void cvm_pmu_read(struct perf_event *event)
> +{
> +	struct cvm_pmu_dev *pmu_dev = to_pmu_dev(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	u64 prev, delta, new;
> +
> +	new = readq(hwc->event_base + pmu_dev->map);
> +
> +	prev = local64_read(&hwc->prev_count);
> +	local64_set(&hwc->prev_count, new);
> +	delta = new - prev;
> +	local64_add(delta, &event->count);
> +}

Typically we need a local64_cmpxchg loop to update prev_count.

Why is that not the case here?

> +static void cvm_pmu_start(struct perf_event *event, int flags)
> +{
> +	struct cvm_pmu_dev *pmu_dev = to_pmu_dev(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	u64 new;
> +
> +	if (WARN_ON_ONCE(!(hwc->state & PERF_HES_STOPPED)))
> +		return;
> +
> +	WARN_ON_ONCE(!(hwc->state & PERF_HES_UPTODATE));
> +	hwc->state = 0;
> +
> +	/* update prev_count always in order support unstoppable counters */

All of the counters are free-running and unstoppable?

Please mention that in the commit message.

> +	new = readq(hwc->event_base + pmu_dev->map);
> +	local64_set(&hwc->prev_count, new);
> +
> +	perf_event_update_userpage(event);
> +}
> +
> +static void cvm_pmu_stop(struct perf_event *event, int flags)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
> +	hwc->state |= PERF_HES_STOPPED;
> +
> +	if ((flags & PERF_EF_UPDATE) && !(hwc->state & PERF_HES_UPTODATE)) {
> +		cvm_pmu_read(event);
> +		hwc->state |= PERF_HES_UPTODATE;
> +	}
> +}
> +
> +static int cvm_pmu_add(struct perf_event *event, int flags, u64 config_base,
> +		       u64 event_base)
> +{
> +	struct cvm_pmu_dev *pmu_dev = to_pmu_dev(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	if (!cmpxchg(&pmu_dev->events[hwc->config], NULL, event))
> +		hwc->idx = hwc->config;

So all of the counters are fixed-purpose?

Please mention that in the commit message

> +
> +	if (hwc->idx == -1)
> +		return -EBUSY;
> +
> +	hwc->config_base = config_base;
> +	hwc->event_base = event_base;
> +	hwc->state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
> +
> +	if (flags & PERF_EF_START)
> +		pmu_dev->pmu.start(event, PERF_EF_RELOAD);
> +
> +	return 0;
> +}
> +
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

AFAICT cvm_pmu_{start,add} don't handle programmable counters at all.
What's going on?

> +	 * To keep this function generic always test the more complicated
> +	 * case (free running counters won't need the loop).
> +	 */
> +	for (i = 0; i < pmu_dev->num_counters; i++)
> +		if (cmpxchg(&pmu_dev->events[i], event, NULL) == event)
> +			break;
> +
> +	perf_event_update_userpage(event);
> +	hwc->idx = -1;
> +}

> +static bool cvm_pmu_lmc_event_valid(u64 config)
> +{
> +	if (config < ARRAY_SIZE(lmc_events))
> +		return true;
> +	return false;
> +}

	return (config < ARRAY_SIZE(lmc_events));

> +static void *cvm_pmu_lmc_probe(struct pci_dev *pdev, void __iomem *regs)
> +{
> +	struct cvm_pmu_dev *next, *lmc;
> +	int nr = 0, ret = -ENOMEM;
> +	char name[8];
> +
> +	lmc = kzalloc(sizeof(*lmc), GFP_KERNEL);
> +	if (!lmc)
> +		goto fail_nomem;
> +
> +	list_for_each_entry(next, &cvm_pmu_lmcs, entry)
> +		nr++;
> +	memset(name, 0, 8);
> +	snprintf(name, 8, "lmc%d", nr);
> +
> +	list_add(&lmc->entry, &cvm_pmu_lmcs);

Please add the new element to the list after we've exhausted the error
cases below...

> +
> +	lmc->pdev = pdev;
> +	lmc->map = regs;
> +	lmc->num_counters = ARRAY_SIZE(lmc_events);
> +	lmc->pmu = (struct pmu) {
> +		.name		= name,
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
> +	ret = perf_pmu_register(&lmc->pmu, lmc->pmu.name, -1);
> +	if (ret)
> +		goto fail_hp;
> +
> +	lmc->event_valid = cvm_pmu_lmc_event_valid;
> +	dev_info(&pdev->dev, "Enabled %s PMU with %d counters\n",
> +		 lmc->pmu.name, lmc->num_counters);
> +	return lmc;
> +
> +fail_hp:
> +	cpuhp_state_remove_instance(CPUHP_AP_PERF_ARM_CVM_ONLINE,
> +				    &lmc->cpuhp_node);
> +	kfree(lmc);

... so that we don't free it without removing it.

> +fail_nomem:
> +	return ERR_PTR(ret);
> +}

Thanks,
Mark.
