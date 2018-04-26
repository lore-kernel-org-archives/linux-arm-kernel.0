From: kim.phillips@arm.com (Kim Phillips)
Date: Thu, 26 Apr 2018 17:06:24 -0500
Subject: [PATCH v4 2/2] ThunderX2: Add Cavium ThunderX2 SoC UNCORE PMU
 driver
In-Reply-To: <20180425090047.6485-3-ganapatrao.kulkarni@cavium.com>
References: <20180425090047.6485-1-ganapatrao.kulkarni@cavium.com>
 <20180425090047.6485-3-ganapatrao.kulkarni@cavium.com>
Message-ID: <20180426170624.bfcba885431d57d0de2a3ddd@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 25 Apr 2018 14:30:47 +0530
Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com> wrote:

> +static int thunderx2_uncore_event_init(struct perf_event *event)
...
> +	/*
> +	 * SOC PMU counters are shared across all cores.
> +	 * Therefore, it does not support per-process mode.
> +	 * Also, it does not support event sampling mode.
> +	 */
> +	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
> +		return -EINVAL;
> +
> +	/* SOC counters do not have usr/os/guest/host bits */
> +	if (event->attr.exclude_user || event->attr.exclude_kernel ||
> +	    event->attr.exclude_host || event->attr.exclude_guest)
> +		return -EINVAL;
> +
> +	if (event->cpu < 0)
> +		return -EINVAL;
> +
> +	pmu_uncore = pmu_to_thunderx2_pmu_uncore(event->pmu);
> +
> +	if (!pmu_uncore)
> +		return -ENODEV;
> +
> +	/* Pick first online cpu from the node */
> +	event->cpu = cpumask_first(
> +			cpumask_of_node(pmu_uncore->uncore_dev->node));
> +
> +	if (event->cpu >= nr_cpu_ids)
> +		return -EINVAL;
> +
> +	if (event->attr.config >= pmu_uncore->uncore_dev->max_events)
> +		return -EINVAL;
> +
> +	/* store event id */
> +	hwc->config = event->attr.config;
> +
> +	/* Validate the group */
> +	if (!thunderx2_uncore_validate_event_group(event))
> +		return -EINVAL;

This PMU driver can be made more user-friendly by not just silently
returning an error code such as -EINVAL, but by emitting a useful
message describing the specific error via dmesg.

Thanks,

Kim
