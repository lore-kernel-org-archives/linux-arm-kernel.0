From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 5 Aug 2016 16:03:30 +0100
Subject: [PATCH] Added perf functionality to mmdc driver
In-Reply-To: <20160805143525.28765-1-zhengyu.shen@nxp.com>
References: <20160805143525.28765-1-zhengyu.shen@nxp.com>
Message-ID: <20160805150330.GG25152@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 05, 2016 at 09:35:25AM -0500, Zhengyu Shen wrote:
> $ perf stat -e mmdc/busy-cycles/,mmdc/read-accesses/,mmdc/read-bytes/,mmdc/total-cycles/,mmdc/write-accesses/,mmdc/write-bytes/ dd if=/dev/zero of=/dev/null bs=1M count=5000
> Performance counter stats for 'dd if=/dev/zero of=/dev/null bs=1M count=5000':
> 
>          898021787      mmdc/busy-cycles/
>           14819600      mmdc/read-accesses/
>             471.30 MB   mmdc/read-bytes/
>         2815419216      mmdc/total-cycles/
>           13367354      mmdc/write-accesses/
>             427.76 MB   mmdc/write-bytes/
> 
>        5.334757334 seconds time elapsed
> 

As Peter noted, you must better describe this, e.g.

* What is the MMDC (it appears to be a DRAM controller?)
* Which devices have this?
* What types of event does it support?
* Does it have many cuonters? How wide are they? Is there an overflow
  interrupt?
* Who is this useful for?

Generally, this looks far from complete, though it's difficult to tell
what the driver should be doing, given the lack of information. Comments
below.

[...]

> +PMU_EVENT_ATTR_STRING(total-cycles, evattr_total_cycles, "event=0x01")
> +PMU_EVENT_ATTR_STRING(busy-cycles, evattr_busy_cycles, "event=0x02")
> +PMU_EVENT_ATTR_STRING(read-accesses, evattr_read_accesses, "event=0x03")
> +PMU_EVENT_ATTR_STRING(write-accesses, evattr_write_accesses, "config=0x04")
> +PMU_EVENT_ATTR_STRING(read-bytes, evattr_read_bytes, "event=0x05")
> +PMU_EVENT_ATTR_STRING(read-bytes.unit, evattr_read_bytes_unit, "MB");
> +PMU_EVENT_ATTR_STRING(read-bytes.scale, evattr_read_bytes_scale, "0.000001");
> +PMU_EVENT_ATTR_STRING(write-bytes, evattr_write_bytes, "event=0x06")
> +PMU_EVENT_ATTR_STRING(write-bytes.unit, evattr_write_bytes_unit, "MB");
> +PMU_EVENT_ATTR_STRING(write-bytes.scale, evattr_write_bytes_scale, "0.000001");
> +
> +struct mmdc_pmu
> +{
> +	struct pmu pmu;
> +	void __iomem *mmdc_base;
> +};
> +
> +static struct attribute *events_attrs[] = {
> +	&evattr_total_cycles.attr.attr,
> +	&evattr_busy_cycles.attr.attr,
> +	&evattr_read_accesses.attr.attr,
> +	&evattr_write_accesses.attr.attr,
> +	&evattr_read_bytes.attr.attr,
> +	&evattr_read_bytes_unit.attr.attr,
> +	&evattr_read_bytes_scale.attr.attr,
> +	&evattr_write_bytes.attr.attr,
> +	&evattr_write_bytes_unit.attr.attr,
> +	&evattr_write_bytes_scale.attr.attr,
> +	NULL,
> +};
> +
> +PMU_FORMAT_ATTR(event, "config:0-63");
> +static struct attribute *format_attrs[] = {
> +	&format_attr_event.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group format_attr_group = {
> +	.name = "format",
> +	.attrs = format_attrs,
> +};
> +
> +static struct attribute_group events_attr_group = {
> +	.name = "events",
> +	.attrs = events_attrs,
> +};
> +
> +static const struct attribute_group * attr_groups[] = {
> +	&events_attr_group,
> +	&format_attr_group,
> +	NULL,
> +};

This is an uncore PMU. You need a cpumask file, along with migration
handling.

See drivers/bus/arm-ccn.c for an example.

> +static int mmdc_event_init(struct perf_event *event)
> +{
> +	u64 val;
> +	if (event->attr.type != event->pmu->type)
> +		return -ENOENT;

You *must* validate the event here.

Check the config, grouping, filtering options, etc.

> +	mmdc_enable_profiling(event);
> +	val = mmdc_read_counter(event);
> +	local64_set(&event->hw.prev_count, val);

Are the counters not writable?

> +	return 0;
> +}
> +
> +static void mmdc_event_update(struct perf_event * event)
> +{
> +	u64 val;
> +	val = mmdc_read_counter(event);
> +	local64_set(&event->count, val);
> +}

What about prev_count?

> +static void mmdc_event_start(struct perf_event *event, int flags)
> +{
> +	mmdc_event_update(event);
> +}

Huh?

Are the counters always-running, with no mechanism to start/stop them?

If so, you must reject event groups, as ratios will be bogus.

> +static int mmdc_event_add(struct perf_event *event, int flags)
> +{
> +	if (flags & PERF_EF_START)
> +		mmdc_event_start(event, flags);
> +	return 0;
> +}
> +
> +static void mmdc_event_stop(struct perf_event *event, int flags)
> +{
> +	mmdc_event_update(event);
> +}
> +
> +static void mmdc_event_del(struct perf_event *event, int flags)
> +{
> +	mmdc_event_stop(event, PERF_EF_UPDATE);
> +}
> +
> +static void mmdc_pmu_init(struct mmdc_pmu *pmu_mmdc, void __iomem *mmdc_base)
> +{
> +	*pmu_mmdc = (struct mmdc_pmu) {
> +		.pmu = (struct pmu) {
> +			.task_ctx_nr    = perf_sw_context,

NAK. This is *not* a softwre PMU. This is a system/uncore PMU, and
should use perf_invalid_context.

> +			.attr_groups    = attr_groups,
> +			.event_init     = mmdc_event_init,
> +			.add            = mmdc_event_add,
> +			.del            = mmdc_event_del,
> +			.start          = mmdc_event_start,
> +			.stop           = mmdc_event_stop,
> +			.read           = mmdc_event_update,
> +			.capabilities   = PERF_PMU_CAP_NO_INTERRUPT,

This avoids sampling events, but you still need to poll to account for
overflow.

> +		},
> +		.mmdc_base = mmdc_base,
> +	};
> +}
> +
>  static int imx_mmdc_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node;
>  	void __iomem *mmdc_base, *reg;
> +	struct mmdc_pmu *pmu_mmdc;
>  	u32 val;
>  	int timeout = 0x400;
>  
> @@ -61,7 +249,22 @@ static int imx_mmdc_probe(struct platform_device *pdev)
>  			__func__);
>  		return -EBUSY;
>  	}
> +	pmu_mmdc = kzalloc(sizeof(struct mmdc_pmu), GFP_KERNEL);

Nit: use sizeof(*pmu_mmdc)

> +	if (!pmu_mmdc) {
> +		pr_err("failed to allocate PMU device!\n");
> +		return -ENOMEM;
> +    }
> +	mmdc_pmu_init(pmu_mmdc, mmdc_base);
> +	platform_set_drvdata(pdev, pmu_mmdc);
> +	perf_pmu_register(&(pmu_mmdc->pmu), "mmdc", -1);
> +	return 0;
> +}

Thanks,
Mark.
