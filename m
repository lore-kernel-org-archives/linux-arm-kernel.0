From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 31 Mar 2017 14:59:55 +0100
Subject: [PATCH V5] perf: qcom: Add L3 cache PMU driver
In-Reply-To: <1490302997-28640-1-git-send-email-agustinv@codeaurora.org>
References: <1490302997-28640-1-git-send-email-agustinv@codeaurora.org>
Message-ID: <20170331135955.GB6488@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Agustin,

On Thu, Mar 23, 2017 at 05:03:17PM -0400, Agustin Vega-Frias wrote:
> This adds a new dynamic PMU to the Perf Events framework to program
> and control the L3 cache PMUs in some Qualcomm Technologies SOCs.
> 
> The driver supports a distributed cache architecture where the overall
> cache for a socket is comprised of multiple slices each with its own PMU.
> Access to each individual PMU is provided even though all CPUs share all
> the slices. User space needs to aggregate to individual counts to provide
> a global picture.
> 
> The driver exports formatting and event information to sysfs so it can
> be used by the perf user space tools with the syntaxes:
>    perf stat -a -e l3cache_0_0/read-miss/
>    perf stat -a -e l3cache_0_0/event=0x21/
> 
> Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>

Thanks for respinning this; it looks good to me.

> +static int qcom_l3_cache__event_init(struct perf_event *event)
> +{
> +	struct l3cache_pmu *l3pmu = to_l3cache_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct perf_event *sibling;

> +	/*
> +	 * We must NOT create groups containing mixed PMUs, although software
> +	 * events are acceptable
> +	 */
> +	if (event->group_leader->pmu != event->pmu &&
> +			!is_software_event(event->group_leader))
> +		return -EINVAL;
> +
> +	list_for_each_entry(sibling, &event->group_leader->sibling_list,
> +			group_entry)
> +		if (sibling->pmu != event->pmu &&
> +				!is_software_event(sibling))
> +			return -EINVAL;

Sorry for spotting this so late, but I just  noticed that we don't
validate the group isn't too large to ever fit in the HW, which is
important for avoiding pointless work in perf_rotate_context() when the
mux hrtimer callback occurs.

We fail to do that in other drivers, too, so that's something we should
clean up more generally.

Here, I'd like to factor the group validation logic out into a helper:

#define event_num_counters(e)	(event_uses_long_counter(e) ? 2 : 1)

static bool qcom_l3_cache__validate_event_group(struct perf_event *event)
{
	struct perf_event *leader = event->group_leader;
	struct perf_event *sibling;
	int counters = 0;

	/*
	 * We must NOT create groups containing mixed PMUs, although
	 * software.
	 */
	if (leader->pmu != event->pmu && !is_software_event(leader))
		return false;

	counters = event_num_counters(event);
	counters += event_num_counters(leader);

	list_for_each_entry(sibling, &leader->sibling_list, group_entry) {
		if (is_software_event(sibling))
			continue;
		if (sibling->pmu != event->pmu)
			return false;
		counters += event_num_counters(sibling);
	}

	/*
	 * If the group requires more counters than the HW has, it
	 * cannot ever be scheduled.
	 */
	return counters <= L3_NUM_COUNTERS;
}

... where in qcom_l3_cache__event_init() we'd do:

	if (!qcom_l3_cache__validate_event_group(event))
		return -EINVAL;

If you're happy with that, I can make that change when applying.

Thanks,
Mark.
