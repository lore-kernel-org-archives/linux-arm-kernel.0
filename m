From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 11 Oct 2018 12:25:47 +0100
Subject: [PATCH v3 2/3] perf: add arm64 smmuv3 pmu driver
In-Reply-To: <20180921150803.25444-3-shameerali.kolothum.thodi@huawei.com>
References: <20180921150803.25444-1-shameerali.kolothum.thodi@huawei.com>
 <20180921150803.25444-3-shameerali.kolothum.thodi@huawei.com>
Message-ID: <d649de4e-e0cc-4188-5e56-fea1488b9d6b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shameer,

One more thing...

On 21/09/18 16:08, Shameer Kolothum wrote:
[...]
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

We still need to solve the resource-claiming issue when one (or both) of 
the PMCG pages belongs to the parent device's register space. I recall 
we chucked a few nascent ideas about before; did anyone manage to come 
up with anything concrete?

Robin.
