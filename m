From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 15 Aug 2016 17:50:50 +0100
Subject: [PATCH v2] Added perf functionality to mmdc driver
In-Reply-To: <20160815223035.5429-1-zhengyu.shen@nxp.com>
References: <20160815223035.5429-1-zhengyu.shen@nxp.com>
Message-ID: <20160815165050.GB31080@svinekod>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Aug 15, 2016 at 05:30:35PM -0500, Zhengyu Shen wrote:
> MMDC is a multi-mode DDR controller that supports DDR3/DDR3L x16/x32/x64 and
> LPDDR2 two channel x16/x32 memory types. MMDC is configurable, high performance,
> and optimized. MMDC is present on i.MX6 Quad and i.MX6 QuadPlus devices, but
> this driver only supports i.MX6 Quad at the moment. MMDC provides registers
> for performance counters which read via this driver to help debug memory
> throughput and similar issues.
> 
> $ perf stat -a -e mmdc/busy-cycles/,mmdc/read-accesses/,mmdc/read-bytes/,mmdc/total-cycles/,mmdc/write-accesses/,mmdc/write-bytes/ dd if=/dev/zero of=/dev/null bs=1M count=5000
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
> Signed-off-by: Zhengyu Shen <zhengyu.shen@nxp.com>
> ---
> change from v1 to v2:
> 	Added cpumask and migration handling support to driver
> 	Validated event during event_init
> 	Added code to properly stop counters
> 	Used perf_invalid_context instead of perf_sw_context
> 	Added hrtimer to poll for overflow 
> 	Added better description
> 	Added support for multiple mmdcs

As I commented on v1 w.r.t. the above, I would appreciate being Cc'd on future
versions of this patch.

> +static u32 mmdc_read_counter(struct mmdc_pmu *pmu_mmdc, int cfg, u64 prev_val)
> +{
> +	u32 val;
> +	void __iomem *mmdc_base, *reg;
> +	mmdc_base = pmu_mmdc->mmdc_base;
> +
> +	switch (cfg)
> +	{
> +		case TOTAL_CYCLES:
> +			reg = mmdc_base + MMDC_MADPSR0;
> +			break;
> +		case BUSY_CYCLES:
> +			reg = mmdc_base + MMDC_MADPSR1;
> +			break;
> +		case READ_ACCESSES:
> +			reg = mmdc_base + MMDC_MADPSR2;
> +			break;
> +		case WRITE_ACCESSES:
> +			reg = mmdc_base + MMDC_MADPSR3;
> +			break;
> +		case READ_BYTES:
> +			reg = mmdc_base + MMDC_MADPSR4;
> +			break;
> +		case WRITE_BYTES:
> +			reg = mmdc_base + MMDC_MADPSR5;
> +			break;
> +		default:
> +			return -1;

This is probably worth a WARN_ONCE, given this should never happen if things
are working correctly.

> +static int mmdc_cpu_notifier(struct notifier_block *nb,
> +        unsigned long action, void *hcpu)
> +{
> +	struct mmdc_pmu *pmu_mmdc = container_of(nb, struct mmdc_pmu, cpu_nb);
> +	unsigned int cpu = (long)hcpu; /* for (long) see kernel/cpu.c */
> +	unsigned int target;
> +
> +	switch (action & ~CPU_TASKS_FROZEN) {
> +		case CPU_DOWN_PREPARE:
> +			if (!cpumask_test_and_clear_cpu(cpu, &pmu_mmdc->cpu))
> +				break;
> +			target = cpumask_any_but(cpu_online_mask, cpu);
> +			if (target >= nr_cpu_ids)
> +				break;
> +			perf_pmu_migrate_context(&pmu_mmdc->pmu, cpu, target);
> +			cpumask_set_cpu(target, &pmu_mmdc->cpu);
> +		default:
> +			break;
> +    }
> +
> +	return NOTIFY_OK;
> +}

CPU notifiers are being ripped out of the kernel with the new hotplug state
machine stuff. See [1] for examples.

> +static int mmdc_event_init(struct perf_event *event)
> +{
> +	struct mmdc_pmu *pmu_mmdc = to_mmdc_pmu(event->pmu);
> +	if (event->attr.type != event->pmu->type)
> +		return -ENOENT;
> +
> +	if (event->cpu < 0) {
> +		dev_warn(pmu_mmdc->dev, "Can't provide per-task data!\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (event->attr.exclude_user   ||
> +			event->attr.exclude_kernel ||
> +			event->attr.exclude_hv     ||
> +			event->attr.exclude_idle   ||
> +			event->attr.exclude_host)
> +		return -EINVAL;

Likewise for exclude_guest here.

You also need to reject sampling events.

You also need to sanity-check grouping.

For the Nth time, I'm going to say that really, we should have the core check
this (or expose helpers to do so). It's somewhat ridiculous that evry driver
has to blacklist everything it doesn't support, rather than whitelisting the
few things that it does.

> +
> +	mmdc_enable_profiling(event);

This doesn't look right. Until we call add() we shouldn't have to poke HW.
event_init should just verify the veent and set up datastructures as required.

It would be better to count the number of active events and enable/disable the
PMU as reuired in the add() and del() callbacks.

> +	event->cpu = cpumask_first(&pmu_mmdc->cpu);
> +	local64_set(&event->count, 0);
> +
> +	return 0;
> +}
> +
> +static void mmdc_event_update(struct perf_event * event)
> +{
> +	struct mmdc_pmu *pmu_mmdc = to_mmdc_pmu(event->pmu);
> +	u32 val;
> +	u64 prev_val;
> +	prev_val = local64_read(&event->count);
> +	val = mmdc_read_counter(pmu_mmdc, (int) event->attr.config, prev_val);
> +	local64_add(val - (u32)(prev_val&0xFFFFFFFF) , &event->count);
> +}

Nit: please add spaces eithr side of the '&'.

> +static void mmdc_event_start(struct perf_event *event, int flags)
> +{
> +	struct mmdc_pmu *pmu_mmdc = to_mmdc_pmu(event->pmu);
> +	void __iomem *mmdc_base, *reg;
> +
> +	local64_set(&event->count, 0);
> +	mmdc_base = pmu_mmdc->mmdc_base;
> +	reg = mmdc_base + MMDC_MADPCR0;
> +	hrtimer_start(&pmu_mmdc->hrtimer, mmdc_timer_period(),
> +			HRTIMER_MODE_REL_PINNED);

Why is a hrtimer necessary? Is this just copy-pasted from CCN, or do you have
similar HW issues?

Is there no overflow interrupt?

> +
> +	writel_relaxed(DBG_RST, reg);
> +	writel_relaxed(DBG_EN, reg);
> +}
> +
> +static int mmdc_event_add(struct perf_event *event, int flags)
> +{
> +	struct mmdc_pmu *pmu_mmdc = to_mmdc_pmu(event->pmu);
> +	int cfg = (int)event->attr.config;
> +	if (cfg >= 1 &&	cfg <= MMDC_NUM_COUNTERS)
> +		pmu_mmdc->mmdc_events[cfg - 1] = event;

Surely this should never happen, and we don't want to start such a broken
event? SO this should be something like:

	if (WARN_ONCE(cfg < 1 || cfg > MMDC_NUM_COUNTERS))
		return;

Also, why not use zero-based indices like everyone else?

> +static void mmdc_event_stop(struct perf_event *event, int flags)
> +{
> +	struct mmdc_pmu *pmu_mmdc = to_mmdc_pmu(event->pmu);
> +	void __iomem *mmdc_base, *reg;
> +	int cfg = (int)event->attr.config;
> +
> +	mmdc_base = pmu_mmdc->mmdc_base;
> +	reg = mmdc_base + MMDC_MADPCR0;
> +	if (cfg >= 1 &&	cfg <= MMDC_NUM_COUNTERS)

Same comment as above here.

> +	{
> +		if (hrtimer_active(&pmu_mmdc->hrtimer))
> +			hrtimer_cancel(&pmu_mmdc->hrtimer);

What if I have multiple events? As soon as I stop one the hrtimer will be
stopped for all of them. Note I fixed a similar bug in the CCN driver in [2].

> +
> +		writel_relaxed(PRF_FRZ, reg);

Why relaxed?

I see no barriers as one would expect to go with relaxed IO accessors, so I
assume this is premature optimisation, and likely introducing bugs. Please use
the non-relaxed accessors.

> +static void mmdc_overflow_handler(struct mmdc_pmu *pmu_mmdc)
> +{
> +	int i;
> +	u32 val;
> +	u64 prev_val;
> +
> +	for (i = 0; i < MMDC_NUM_COUNTERS; i++)
> +	{
> +		struct perf_event *event = pmu_mmdc->mmdc_events[i];
> +		if (event)
> +		{
> +			prev_val = local64_read(&event->count);
> +			val = mmdc_read_counter(pmu_mmdc, i + 1, prev_val);
> +			local64_add(val - (u32)(prev_val&0xFFFFFFFF) , &event->count);
> +		}
> +	}
> +}

Can't you call your update function for each event? This seems to be a copy of
that logic.

> @@ -61,7 +392,35 @@ static int imx_mmdc_probe(struct platform_device *pdev)
>  			__func__);
>  		return -EBUSY;
>  	}
> +	pmu_mmdc = kzalloc(sizeof(*pmu_mmdc), GFP_KERNEL);
>  
> +	if (!pmu_mmdc) {
> +		pr_err("failed to allocate PMU device!\n");
> +		return -ENOMEM;
> +	}
> +	mmdc_num = mmdc_pmu_init(pmu_mmdc, mmdc_base, &pdev->dev);
> +	dev_info(pmu_mmdc->dev, "No access to interrupts, using timer.\n");

You haven't even tried...

> +	hrtimer_init(&pmu_mmdc->hrtimer, CLOCK_MONOTONIC,
> +			HRTIMER_MODE_REL);
> +	pmu_mmdc->hrtimer.function = mmdc_timer_handler;
> +	register_cpu_notifier(&pmu_mmdc->cpu_nb);
> +	if (mmdc_num == 0) {
> +		name = "mmdc";
> +	} else {
> +		int len = snprintf(NULL, 0, "mmdc_%d", mmdc_num);
> +		name = devm_kzalloc(&pdev->dev, len + 1, GFP_KERNEL);
> +		snprintf(name, len + 1, "mmdc_%d", mmdc_num);
> +	}

Use devm_kasptrintf.

Thanks,
Mark.

[1] https://lkml.org/lkml/2016/7/11/312
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-August/448369.html
