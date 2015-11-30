From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Tue, 01 Dec 2015 01:23:01 +0200
Subject: [PATCH V5 21/26] coresight: etm-perf: new PMU driver for ETM
 tracers
In-Reply-To: <1448849687-5724-22-git-send-email-mathieu.poirier@linaro.org>
References: <1448849687-5724-1-git-send-email-mathieu.poirier@linaro.org>
 <1448849687-5724-22-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <87poyrysve.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mathieu Poirier <mathieu.poirier@linaro.org> writes:

> +static void etm_event_destroy(struct perf_event *event) {}
> +
> +static int etm_event_init(struct perf_event *event)
> +{
> +	if (event->attr.type != etm_pmu.type)
> +		return -ENOENT;
> +
> +	if (event->cpu >= nr_cpu_ids)
> +		return -EINVAL;
> +
> +	event->destroy = etm_event_destroy;

You don't have to do this if it's a nop, event::destroy can be NULL.

> +
> +	return 0;
> +}


> +static void *alloc_event_data(int cpu)
> +{
> +	int lcpu, size;
> +	cpumask_t *mask;
> +	struct etm_cpu_data *cpu_data;
> +	struct etm_event_data *event_data;
> +
> +	/* First get memory for the session's data */
> +	event_data = kzalloc(sizeof(struct etm_event_data), GFP_KERNEL);
> +	 if (!event_data)

Looks like a whitespace mixup.

> +		return NULL;
> +
> +	/* Make sure nothing disappears under us */
> +	get_online_cpus();
> +	size = num_online_cpus();
> +
> +	mask = &event_data->mask;
> +	if (cpu != -1)
> +		cpumask_set_cpu(cpu, mask);
> +	else
> +		cpumask_copy(mask, cpu_online_mask);

It would be nice to have a comment somewhere here explaining that you
have to set up tracer on each cpu in case of per-thread counter and
why. We must have discussed this, but I forgot already.

Btw, do you want to also set 'size' to 1 for cpu != -1 case?

> +	put_online_cpus();
> +
> +	/* Allocate an array of cpu_data to work with */
> +	event_data->cpu_data = kcalloc(size,
> +				       sizeof(struct etm_cpu_data *),
> +				       GFP_KERNEL);
> +	if (!event_data->cpu_data)
> +		goto free_event_data;
> +
> +	/* Allocate a cpu_data for each CPU this event is dealing with */
> +	for_each_cpu(lcpu, mask) {
> +		cpu_data = kzalloc(sizeof(struct etm_cpu_data), GFP_KERNEL);
> +		if (!cpu_data)
> +			goto free_event_data;
> +
> +		event_data->cpu_data[lcpu] = cpu_data;
> +	}

Wouldn't it be easier to allocate the whole thing with one

event_data->cpu_data = kcalloc(size, sizeof(struct etm_cpu_data), GFP_KERNEL);

?

Regards,
--
Alex
