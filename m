From: shameerali.kolothum.thodi@huawei.com (Shameerali Kolothum Thodi)
Date: Thu, 11 Oct 2018 11:49:18 +0000
Subject: [PATCH v3 2/3] perf: add arm64 smmuv3 pmu driver
In-Reply-To: <d649de4e-e0cc-4188-5e56-fea1488b9d6b@arm.com>
References: <20180921150803.25444-1-shameerali.kolothum.thodi@huawei.com>
 <20180921150803.25444-3-shameerali.kolothum.thodi@huawei.com>
 <d649de4e-e0cc-4188-5e56-fea1488b9d6b@arm.com>
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83879AD29@FRAEML521-MBX.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy at arm.com]
> Sent: 11 October 2018 12:26
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> lorenzo.pieralisi at arm.com
> Cc: will.deacon at arm.com; mark.rutland at arm.com; Guohanjun (Hanjun Guo)
> <guohanjun@huawei.com>; John Garry <john.garry@huawei.com>;
> pabba at codeaurora.org; vkilari at codeaurora.org; rruigrok at codeaurora.org;
> linux-acpi at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; Linuxarm <linuxarm@huawei.com>;
> neil.m.leeder at gmail.com
> Subject: Re: [PATCH v3 2/3] perf: add arm64 smmuv3 pmu driver
> 
> Hi Shameer,
> 
> One more thing...
> 
> On 21/09/18 16:08, Shameer Kolothum wrote:
> [...]
> > +static int smmu_pmu_probe(struct platform_device *pdev)
> > +{
> > +	struct smmu_pmu *smmu_pmu;
> > +	struct resource *res_0, *res_1;
> > +	u32 cfgr, reg_size;
> > +	u64 ceid_64[2];
> > +	int irq, err;
> > +	char *name;
> > +	struct device *dev = &pdev->dev;
> > +
> > +	smmu_pmu = devm_kzalloc(dev, sizeof(*smmu_pmu), GFP_KERNEL);
> > +	if (!smmu_pmu)
> > +		return -ENOMEM;
> > +
> > +	smmu_pmu->dev = dev;
> > +
> > +	platform_set_drvdata(pdev, smmu_pmu);
> > +	smmu_pmu->pmu = (struct pmu) {
> > +		.task_ctx_nr    = perf_invalid_context,
> > +		.pmu_enable	= smmu_pmu_enable,
> > +		.pmu_disable	= smmu_pmu_disable,
> > +		.event_init	= smmu_pmu_event_init,
> > +		.add		= smmu_pmu_event_add,
> > +		.del		= smmu_pmu_event_del,
> > +		.start		= smmu_pmu_event_start,
> > +		.stop		= smmu_pmu_event_stop,
> > +		.read		= smmu_pmu_event_read,
> > +		.attr_groups	= smmu_pmu_attr_grps,
> > +	};
> > +
> > +	res_0 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	smmu_pmu->reg_base = devm_ioremap_resource(dev, res_0);
> 
> We still need to solve the resource-claiming issue when one (or both) of
> the PMCG pages belongs to the parent device's register space. I recall
> we chucked a few nascent ideas about before; did anyone manage to come
> up with anything concrete?

Right. We had an early version of an evaluation board where we had this issue, 
but this has been fixed in an updated revision and is not a priority for now. 

Agree that this is an issue as the spec doesn?t forbid using parent SMMU register
space and it looks like not an easy one to solve either. The initial idea was setting
the PMCG as a child dev, but that didn?t help.

I had an off list discussion with Lorenzo on this, but nothing concrete.

Lorenzo, 

Please update if you have any new ideas/thoughts on this.

Thanks,
Shameer

> Robin.
