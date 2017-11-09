From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 9 Nov 2017 10:07:02 +0000
Subject: [PATCH v10 5/7] perf: cavium: Support memory controller PMU
 counters
In-Reply-To: <20170925123502.17289-6-jglauber@cavium.com>
References: <20170925123502.17289-1-jglauber@cavium.com>
 <20170925123502.17289-6-jglauber@cavium.com>
Message-ID: <6ff478bb-ebaf-da43-3ee8-2889209278ca@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/09/17 13:35, Jan Glauber wrote:
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
> ---
>   drivers/perf/Kconfig            |   8 +
>   drivers/perf/Makefile           |   1 +
>   drivers/perf/cavium_pmu.c       | 430 ++++++++++++++++++++++++++++++++++++++++
>   drivers/soc/cavium/cavium_lmc.c |   4 +
>   include/linux/cpuhotplug.h      |   1 +
>   include/linux/soc/cavium/lmc.h  |   3 +
>   6 files changed, 447 insertions(+)
>   create mode 100644 drivers/perf/cavium_pmu.c

> +int cvm_lmc_pmu_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> +{
> +	struct cvm_pmu_dev *next, *lmc;
> +	int nr = 0, ret = -ENOMEM;
> +	char *name;
> +
> +	lmc = devm_kzalloc(&pdev->dev, sizeof(*lmc), GFP_KERNEL);
> +	if (!lmc)
> +		return -ENOMEM;
> +
> +	lmc->map = devm_ioremap(&pdev->dev, pci_resource_start(pdev, 0),
> +				pci_resource_len(pdev, 0));
> +	if (!lmc->map)
> +		return -EINVAL;
> +
> +	list_for_each_entry(next, &cvm_pmu_lmcs, entry)
> +		nr++;
> +	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "lmc%d", nr);
> +	if (!name)
> +		return -ENOMEM;
> +
> +	lmc->pdev = pdev;
> +	lmc->num_counters = ARRAY_SIZE(cvm_pmu_lmc_events_attr) - 1;
> +	lmc->pmu = (struct pmu) {
> +		.task_ctx_nr    = perf_invalid_context,
> +		.name		= name,
> +		.event_init	= cvm_pmu_event_init,
> +		.add		= cvm_pmu_lmc_add,
> +		.del		= cvm_pmu_del,
> +		.start		= cvm_pmu_start,
> +		.stop		= cvm_pmu_stop,
> +		.read		= cvm_pmu_read,
> +		.attr_groups	= cvm_pmu_lmc_attr_groups,
> +	};
> +

You need to fill in the "module" field of the PMU to prevent the module from
being unloaded while the PMU is active.

See :

http://lists.infradead.org/pipermail/linux-arm-kernel/2017-November/540647.html

Suzuki
