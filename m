From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Tue, 2 Oct 2018 17:19:03 +0100
Subject: [PATCH v3 2/3] perf: add arm64 smmuv3 pmu driver
In-Reply-To: <ecc2877c-146c-d70f-efd7-306fe704d55f@arm.com>
References: <20180921150803.25444-1-shameerali.kolothum.thodi@huawei.com>
 <20180921150803.25444-3-shameerali.kolothum.thodi@huawei.com>
 <ecc2877c-146c-d70f-efd7-306fe704d55f@arm.com>
Message-ID: <1dc554eb-7ed2-45b3-109f-8cec286b4525@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/10/2018 15:11, Jean-Philippe Brucker wrote:
>> +	cfgr = readl_relaxed(smmu_pmu->reg_base + SMMU_PMCG_CFGR);

Something I missed previously: when SMMU_PMCG_CFGR.SID_FILTER_TYPE is 1,
filtering for all counters is configured by SMMU_PMCG_SMR0 and
SMMU_PMCG_EVTYPER0 (instead of having one separate filter per counter).

In that mode with your patch, if the user applies a filter to the first
event in the list passed to perf, it will be applied to all events.
Filter applied on any subsequent event will be ignored. Could we make
this more explicit? Maybe in the probe print that the PMCG is
global-filtering, and when attempting to apply a filter to something
else than EVCNTR0, return an error?

Thanks,
Jean
