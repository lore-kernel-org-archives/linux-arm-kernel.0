From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 19 Sep 2016 13:48:42 +0100
Subject: [PATCH 1/1 v6] ARM: imx: Added perf functionality to mmdc driver
In-Reply-To: <1473864500-24256-1-git-send-email-Frank.Li@nxp.com>
References: <1473864500-24256-1-git-send-email-Frank.Li@nxp.com>
Message-ID: <20160919124641.GB12473@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is generally looking good now. There are just a few issues
remaining which I've noted below.

On Wed, Sep 14, 2016 at 09:48:20AM -0500, Frank Li wrote:
> From: Zhengyu Shen <zhengyu.shen@nxp.com>

> +static bool mmdc_pmu_group_is_valid(struct perf_event *event)

As a general note, you prefix other functions with mmdc_ rather than
mmdc_pmu. For consistency, it would be better for all the perf-specific
functions to be called mmdc_pmu_*. Likewise for attr_groups.

> +{
> +	struct pmu *pmu = event->pmu;
> +	struct perf_event *leader = event->group_leader;
> +	struct perf_event *sibling;
> +
> +	int cfg = leader->attr.config;
> +	int counter_mask = 0;
> +
> +	if (cfg < 0 || cfg >= MMDC_NUM_COUNTERS)
> +		return false;

For any event managed by this PMU, this is checked in event_init, so
this check is unnecessary.

> +
> +	if (leader->pmu == pmu)
> +		counter_mask |= 1 << cfg;
> +	else if (!is_software_event(leader))
> +		return false;
> +
> +	list_for_each_entry(sibling, &leader->sibling_list, group_entry) {
> +		if (sibling->pmu == pmu) {
> +			cfg = sibling->attr.config;
> +			if (cfg < 0 || cfg >= MMDC_NUM_COUNTERS)
> +				return false;

Likewise.

> +			counter_mask |= 1 << cfg;
> +		} else if (!is_software_event(sibling)) {
> +			return false;
> +		}
> +	}
> +
> +	if (event == leader)
> +		return true;
> +
> +	cfg = event->attr.config;
> +	if (cfg < 0 || cfg >= MMDC_NUM_COUNTERS)
> +		return false;
> +
> +	return !(counter_mask & (1 << cfg));
> +}

I think this would be far clearer if written something like the below:

bool mmdc_pmu_group_event_is_valid(struct perf_event *event,
				   struct pmu *pmu,
				   unsigned long *used_counters)
{
	int counter = event->attr.config;

	if (is_software_event(event))
		return true;
	if (event->pmu != pmu)
		return false;
	return !test_and_set_bit(counter, &used_counters);
}

/*
 * Each event has a single fixed-purpose counter, so we can only have a
 * single active event for each at any point in time. Here we just check
 * for duplicates, and rely on mmdc_pmu_event_init to verify that the HW
 * event numbers are valid.
 */
bool mmdc_pmu_group_is_valid(struct perf_event *event)
{
	struct pmu *pmu = event->pmu;
	struct perf_event *leader = event->group_leader;
	struct perf_event *sibling;
	unigned long used_counters = 0;

	set_bit(counter(event), &used_counters);

	if (event != leader) {
		if (!mmdc_pmu_event_is_valid(event, pmu, &counter_mask))
			return false;
	}

	list_for_each_entry(sibling, &leader->sibling_list, group_entry) {
		if (!mmdc_pmu_group_event_is_valid(event, pmu, &used_counters))
			return false;
	}

	return true;
}

> +static int mmdc_event_add(struct perf_event *event, int flags)
> +{
> +	struct mmdc_pmu *pmu_mmdc = to_mmdc_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	int cfg = event->attr.config;
> +
> +	if (WARN_ONCE((cfg < 0 || cfg >= MMDC_NUM_COUNTERS),
> +				"invalid configuration %d for mmdc", cfg))
> +		return -1;

This should never happen, as you checked this at event_init time.

If you must check this here, please use a real error code mnemonic
rather than -1 (which happens to be -EPERM).

> +
> +	if (flags & PERF_EF_START)
> +		mmdc_event_start(event, flags);
> +
> +	pmu_mmdc->mmdc_events[cfg] = event;
> +	pmu_mmdc->active_events++;
> +
> +	local64_set(&hwc->prev_count, mmdc_read_counter(pmu_mmdc, cfg));
> +
> +	return 0;
> +}

You must verify at pmu::add() time that the counter isn't in use
already, as you can have separate events (i.e. that aren't in the same
group) trying to reuse the same counter.

If you don't check that, then stopping/starting/resetting the counter
will not work as expected, and you will get erroneous results.

I think that here all you need to do is to check that check
pmu_mmdc->mmdc_events[cfg] is NULL before you assign to it. If it has a
non-NULL value, return -EAGAIN.

> +
> +static void mmdc_event_stop(struct perf_event *event, int flags)
> +{
> +	struct mmdc_pmu *pmu_mmdc = to_mmdc_pmu(event->pmu);
> +	void __iomem *mmdc_base, *reg;
> +	int cfg = (int)event->attr.config;
> +
> +	mmdc_base = pmu_mmdc->mmdc_base;
> +	reg = mmdc_base + MMDC_MADPCR0;
> +
> +	if (WARN_ONCE((cfg < 0 || cfg >= MMDC_NUM_COUNTERS),
> +				"invalid configuration %d for mmdc counter", cfg))
> +		return;

You checked this at event_init time. Is it really necessary to check
again?

> +static void mmdc_event_del(struct perf_event *event, int flags)
> +{
> +	struct mmdc_pmu *pmu_mmdc = to_mmdc_pmu(event->pmu);
> +	int cfg = event->attr.config;
> +
> +	pmu_mmdc->mmdc_events[cfg] = NULL;
> +	pmu_mmdc->active_events--;
> +
> +	if (pmu_mmdc->active_events <= 0)
> +		hrtimer_cancel(&pmu_mmdc->hrtimer);

You should only have to check that this is equal to zero. If
active_events is negative, you have a bigger problem.

Thanks,
Mark.
