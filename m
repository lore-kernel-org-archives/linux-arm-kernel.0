From: shameerali.kolothum.thodi@huawei.com (Shameerali Kolothum Thodi)
Date: Wed, 3 Oct 2018 08:52:35 +0000
Subject: [PATCH v3 2/3] perf: add arm64 smmuv3 pmu driver
In-Reply-To: <1cdc3c01-e8f9-fd60-da88-cc49d22fe0be@arm.com>
References: <20180921150803.25444-1-shameerali.kolothum.thodi@huawei.com>
 <20180921150803.25444-3-shameerali.kolothum.thodi@huawei.com>
 <ecc2877c-146c-d70f-efd7-306fe704d55f@arm.com>
 <1dc554eb-7ed2-45b3-109f-8cec286b4525@arm.com>
 <1cdc3c01-e8f9-fd60-da88-cc49d22fe0be@arm.com>
Message-ID: <5FC3163CFD30C246ABAA99954A238FA838793F64@FRAEML521-MBX.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy at arm.com]
> Sent: 02 October 2018 17:35
> To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>; Shameerali
> Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> lorenzo.pieralisi at arm.com
> Cc: mark.rutland at arm.com; vkilari at codeaurora.org;
> neil.m.leeder at gmail.com; pabba at codeaurora.org; John Garry
> <john.garry@huawei.com>; will.deacon at arm.com; rruigrok at codeaurora.org;
> Linuxarm <linuxarm@huawei.com>; linux-acpi at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; Guohanjun (Hanjun Guo)
> <guohanjun@huawei.com>; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH v3 2/3] perf: add arm64 smmuv3 pmu driver
> 
> On 02/10/18 17:19, Jean-Philippe Brucker wrote:
> > On 02/10/2018 15:11, Jean-Philippe Brucker wrote:
> >>> +	cfgr = readl_relaxed(smmu_pmu->reg_base + SMMU_PMCG_CFGR);
> >
> > Something I missed previously: when SMMU_PMCG_CFGR.SID_FILTER_TYPE
> is 1,
> > filtering for all counters is configured by SMMU_PMCG_SMR0 and
> > SMMU_PMCG_EVTYPER0 (instead of having one separate filter per counter).
> 
> Oh, I hadn't even noticed it had that mode as well...

Thanks Jean. Missed that completely. 
 
> > In that mode with your patch, if the user applies a filter to the first
> > event in the list passed to perf, it will be applied to all events.
> > Filter applied on any subsequent event will be ignored. Could we make
> > this more explicit? Maybe in the probe print that the PMCG is
> > global-filtering, and when attempting to apply a filter to something
> > else than EVCNTR0, return an error?
> 
> FWIW filtering is always per-counter-group on the SMMUv2 PMU, and it's
> actually pretty straightforward to cope with - pmu->add() just needs to
> reject the event if one with an incompatible configuration is already
> scheduled, so perf core handles it much like having more events than
> counters, by rotating the mutually-exclusive sets.

I will take a look and address this in next version.

Thanks,
Shameer
