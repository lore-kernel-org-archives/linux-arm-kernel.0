From: peterz@infradead.org (Peter Zijlstra)
Date: Tue, 22 Mar 2016 21:48:33 +0100
Subject: [PATCH V1] perf: qcom: Add L3 cache PMU driver
In-Reply-To: <1458333422-8963-1-git-send-email-agustinv@codeaurora.org>
References: <1458333422-8963-1-git-send-email-agustinv@codeaurora.org>
Message-ID: <20160322204833.GE6356@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 18, 2016 at 04:37:02PM -0400, Agustin Vega-Frias wrote:
> +static int qcom_l3_cache_pmu_probe(struct platform_device *pdev)
> +{
> +	int result;
> +
> +	INIT_LIST_HEAD(&l3cache_pmu.pmus);
> +
> +	atomic_set(&l3cache_pmu.cpu, -1);
> +	l3cache_pmu.pmu = (struct pmu) {
> +		.task_ctx_nr	= perf_hw_context,

This cannot be right. There should only be a single perf_hw_context
driver in the system and that is typically the core pmu.

Also, since this is an L3 PMU, it seems very unlikely that these events
are actually per logical CPU, which is required for per-task events.

If these events are indeed not per logical CPU but per L3 cluster, you
should designate a single logical CPU per cluster to handle these
events. See for example arch/x86/events/intel/rapl.c for a relatively
simple PMU driver that has similar constraints.

> +		.name		= "l3cache",
> +		.pmu_enable	= qcom_l3_cache__pmu_enable,
> +		.pmu_disable	= qcom_l3_cache__pmu_disable,
> +		.event_init	= qcom_l3_cache__event_init,
> +		.add		= qcom_l3_cache__event_add,
> +		.del		= qcom_l3_cache__event_del,
> +		.start		= qcom_l3_cache__event_start,
> +		.stop		= qcom_l3_cache__event_stop,
> +		.read		= qcom_l3_cache__event_read,
> +
> +		.event_idx	= dummy_event_idx,

perf_event_idx_default() wasn't good enough?

> +		.attr_groups	= qcom_l3_cache_pmu_attr_grps,
> +	};
