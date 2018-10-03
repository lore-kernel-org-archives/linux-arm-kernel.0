From: shameerali.kolothum.thodi@huawei.com (Shameerali Kolothum Thodi)
Date: Wed, 3 Oct 2018 11:28:19 +0000
Subject: [PATCH v3 2/3] perf: add arm64 smmuv3 pmu driver
In-Reply-To: <2b4a53bc-7839-6826-44ed-6099c732a31a@arm.com>
References: <20180921150803.25444-1-shameerali.kolothum.thodi@huawei.com>
 <20180921150803.25444-3-shameerali.kolothum.thodi@huawei.com>
 <2b4a53bc-7839-6826-44ed-6099c732a31a@arm.com>
Message-ID: <5FC3163CFD30C246ABAA99954A238FA838794127@FRAEML521-MBX.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy at arm.com]
> Sent: 03 October 2018 11:37
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
> On 21/09/18 16:08, Shameer Kolothum wrote:
> [...]
> > +
> > +	err = cpuhp_state_add_instance_nocalls(cpuhp_state_num,
> > +					       &smmu_pmu->node);
> 
> In theory a hotplug event could happen as soon as the instance is
> registered...
> 
> > +	if (err) {
> > +		dev_err(dev, "Error %d registering hotplug, PMU @%pa\n",
> > +			err, &res_0->start);
> > +		return err;
> > +	}
> > +
> > +	/* Pick one CPU to be the preferred one to use */
> > +	smmu_pmu->on_cpu = get_cpu();
> 
> ...so this looks too late, i.e. a race here can result in a bogus call
> to perf_pmu_migrate_context() with an uninitialised pmu.

Thanks Robin. I will reorder them.

Shameer

> Robin. 
> > +	WARN_ON(irq_set_affinity(smmu_pmu->irq, cpumask_of(smmu_pmu-
> >on_cpu)));
> > +
> > +	err = perf_pmu_register(&smmu_pmu->pmu, name, -1);
> > +	if (err) {
> > +		dev_err(dev, "Error %d registering PMU @%pa\n",
> > +			err, &res_0->start);
> > +		goto out_unregister;
> > +	}
> > +
> > +	put_cpu();
