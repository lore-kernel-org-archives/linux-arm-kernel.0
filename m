From: john.garry@huawei.com (John Garry)
Date: Wed, 3 Oct 2018 12:06:41 +0100
Subject: [PATCH v3 2/3] perf: add arm64 smmuv3 pmu driver
In-Reply-To: <20180921150803.25444-3-shameerali.kolothum.thodi@huawei.com>
References: <20180921150803.25444-1-shameerali.kolothum.thodi@huawei.com>
 <20180921150803.25444-3-shameerali.kolothum.thodi@huawei.com>
Message-ID: <e3546ab9-269c-c39c-344f-ff2eb9a5336b@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/09/2018 16:08, Shameer Kolothum wrote:
> +
> +ssize_t smmu_pmu_event_show(struct device *dev,
> +			    struct device_attribute *attr, char *page)
> +{
> +	struct perf_pmu_events_attr *pmu_attr;
> +
> +	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
> +
> +	return sprintf(page, "event=0x%02llx\n", pmu_attr->id);
> +}

Is there some reason PMU drivers have their own edition of this 
function? I see a few similar ones here:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/kernel/perf_event.c#n309

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/perf/core-book3s.c#n1986

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/s390/kernel/perf_event.c#n239

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/perf/qcom_l2_pmu.c#n731

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/perf/qcom_l3_pmu.c#n655

That is apart from the event id width format.

But the leading zeroes seem to be cropped anyway in the perf tool, 
according to this:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/util/pmu.c#n335 
(this was added in 0c24d6fb7db, in June 18)

John

> +
> +#define SMMU_EVENT_ATTR(_name, _id)					  \
> +	(&((struct perf_pmu_events_attr[]) {				  \
> +		{ .attr = __ATTR(_name, 0444, smmu_pmu_event_show, NULL), \
> +		  .id = _id, }						  \
> +	})[0].attr.attr)
> +
> +static struct attribute *smmu_pmu_events[] = {
> +	SMMU_EVENT_ATTR(cycles, 0),
> +	SMMU_EVENT_ATTR(transaction, 1),
> +	SMMU_EVENT_ATTR(tlb_miss, 2),
> +	SMMU_EVENT_ATTR(config_cache_miss, 3),
> +	SMMU_EVENT_ATTR(trans_table_walk, 4),
> +	SMMU_EVENT_ATTR(config_struct_access, 5),
> +	SMMU_EVENT_ATTR(pcie_ats_trans_rq, 6),
> +	SMMU_EVENT_ATTR(pcie_ats_trans_passed, 7),
> +	NULL
> +};
