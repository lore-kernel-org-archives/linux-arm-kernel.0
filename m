From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Mon, 19 Oct 2015 18:37:44 +0300
Subject: [PATCH V2 22/30] coresight: etm-perf: new PMU driver for ETM
 tracers
In-Reply-To: <1445192687-24112-23-git-send-email-mathieu.poirier@linaro.org>
References: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
 <1445192687-24112-23-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <87io62hnsn.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mathieu Poirier <mathieu.poirier@linaro.org> writes:

> +static int etm_event_pmu_start(struct perf_event *event)
> +{
> +	int cpu, ret;
> +	cpumask_t mask;
> +	struct coresight_device *csdev;
> +
> +	cpumask_clear(&mask);
> +	if (event->cpu != -1)
> +		cpumask_set_cpu(event->cpu, &mask);
> +	else
> +		cpumask_copy(&mask, cpu_online_mask);
> +
> +	for_each_cpu(cpu, &mask) {
> +		csdev = per_cpu(csdev_src, cpu);
> +
> +		if (!source_ops(csdev)->perf_start)
> +			continue;
> +
> +		ret = source_ops(csdev)->perf_start(csdev);
> +		if (ret)
> +			goto err;

So long as "perf_start" and "perf_stop" here mean
"pm_runtime_get()/put()", this can work, but in that case maybe a better
name should be used, because no real starting or stopping of anything
takes place here. Since pmu::event_init and event::destroy happen in
allocation/deallocation paths and at event scheduling, it's not a good
idea to actually start anything here.

Regards,
--
Alex
