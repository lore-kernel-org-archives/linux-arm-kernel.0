From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 19 Oct 2017 12:22:07 +0100
Subject: [PATCH v6 2/6] perf: hisi: Add support for HiSilicon SoC uncore
 PMU driver
In-Reply-To: <1508411121-125691-3-git-send-email-zhangshaokun@hisilicon.com>
References: <1508411121-125691-1-git-send-email-zhangshaokun@hisilicon.com>
 <1508411121-125691-3-git-send-email-zhangshaokun@hisilicon.com>
Message-ID: <20171019112206.gpkwqwvn6mo6z5ry@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 19, 2017 at 07:05:17PM +0800, Shaokun Zhang wrote:
> This patch adds support HiSilicon SoC uncore PMU driver framework and
> interfaces.

> +static bool hisi_validate_event_group(struct perf_event *event)
> +{
> +	struct perf_event *sibling, *leader = event->group_leader;
> +	struct hisi_pmu *hisi_pmu = to_hisi_pmu(event->pmu);
> +	/* Include count for the event */
> +	int counters = 1;
> +
> +	/*
> +	 * We must NOT create groups containing mixed PMUs, although
> +	 * software events are acceptable
> +	 */
> +	if (leader->pmu != event->pmu && !is_software_event(leader))
> +		return false;
> +
> +	/* Increment counter for the leader */
> +	counters++;

Sorry I didn't spot this before, but I believe this should be:

	if (event != leader && !is_software_event(leader))
		counters++;

Since the leader can be a SW event, and for the group leader itself,
event == leader.

Assuming there aren't any major issues elsewhere, I can fix this up when
applying the series.

Thanks,
Mark.
