From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 5 Sep 2016 15:10:59 +0100
Subject: [PATCH v4] ARM: imx: Added perf functionality to mmdc driver
In-Reply-To: <20160831170029.27756-1-zhengyu.shen@nxp.com>
References: <20160831170029.27756-1-zhengyu.shen@nxp.com>
Message-ID: <20160905141059.GC6826@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Aug 31, 2016 at 12:00:29PM -0500, Zhengyu Shen wrote:
> MMDC is a multi-mode DDR controller that supports DDR3/DDR3L x16/x32/x64
> and LPDDR2 two channel x16/x32 memory types. MMDC is configurable, high
> performance, and optimized. MMDC is present on i.MX6 Quad and i.MX6
> QuadPlus devices, but this driver only supports i.MX6 Quad at the moment.
> MMDC provides registers for performance counters which read via this
> driver to help debug memory throughput and similar issues.

This is largely looking better, but there a few issues which remain,
some of which are major (e.g. erroneous use of perf_event::count, which
will result in misleading output). Full details below.

> +PMU_EVENT_ATTR_STRING(total-cycles, mmdc_total_cycles, "event=0x00")
> +PMU_EVENT_ATTR_STRING(busy-cycles, mmdc_busy_cycles, "event=0x01")
> +PMU_EVENT_ATTR_STRING(read-accesses, mmdc_read_accesses, "event=0x02")
> +PMU_EVENT_ATTR_STRING(write-accesses, mmdc_write_accesses, "config=0x03")
> +PMU_EVENT_ATTR_STRING(read-bytes, mmdc_read_bytes, "event=0x04")
> +PMU_EVENT_ATTR_STRING(read-bytes.unit, mmdc_read_bytes_unit, "MB");
> +PMU_EVENT_ATTR_STRING(read-bytes.scale, mmdc_read_bytes_scale, "0.000001");
> +PMU_EVENT_ATTR_STRING(write-bytes, mmdc_write_bytes, "event=0x05")
> +PMU_EVENT_ATTR_STRING(write-bytes.unit, mmdc_write_bytes_unit, "MB");
> +PMU_EVENT_ATTR_STRING(write-bytes.scale, mmdc_write_bytes_scale, "0.000001");
> +
> +struct mmdc_pmu {
> +	struct pmu pmu;
> +	void __iomem *mmdc_base;
> +	cpumask_t cpu;
> +	struct hrtimer hrtimer;
> +	unsigned int irq;

As mmdc_pmu::irq is never set, it's pointless. Please remove it.

> +	unsigned int active_events;
> +	struct device *dev;
> +	struct perf_event *mmdc_events[MMDC_NUM_COUNTERS];
> +	spinlock_t mmdc_active_events_lock;

The core code serialises pmu::{add,del,start,stop} by taking ctx->lock
and disabling IRQs, so you shouldn't need to enforce that locally.
Please remove this lock.

[...]

> +static struct mmdc_pmu *cpuhp_mmdc_pmu;

Elsewhere in the driver you use IDA, implying there can be multiple
instances. So this is insufficient. Use the new multi-instance support
[1], as we have for the CCN [2]. That way you don't need a global
singleton.

[...]

> +static int mmdc_pmu_offline_cpu(unsigned int cpu)
> +{
> +	struct mmdc_pmu *pmu_mmdc = cpuhp_mmdc_pmu;
> +	int target;
> +
> +	if (!cpumask_test_and_clear_cpu(cpu, &pmu_mmdc->cpu))
> +		return 0;
> +
> +	target = cpumask_any_but(cpu_online_mask, cpu);
> +	if (target >= nr_cpu_ids)
> +		return 0;
> +
> +	perf_pmu_migrate_context(&pmu_mmdc->pmu, cpu, target);
> +	cpumask_set_cpu(target, &pmu_mmdc->cpu);
> +	if (pmu_mmdc->irq)
> +		WARN_ON(irq_set_affinity_hint(pmu_mmdc->irq, &pmu_mmdc->cpu) != 0);

As mmdc_pmu::irq is never set, I think we can get rid of the IRQ
manipulation logic here, and just have the context migration.

> +
> +	return 0;
> +}
> +
> +static int mmdc_event_init(struct perf_event *event)
> +{
> +	struct mmdc_pmu *pmu_mmdc = to_mmdc_pmu(event->pmu);
> +	int cfg = event->attr.config;
> +	struct perf_event *sibling;
> +
> +	if (event->attr.type != event->pmu->type)
> +		return -ENOENT;
> +
> +	if (event->cpu < 0) {
> +		dev_warn(pmu_mmdc->dev, "Can't provide per-task data!\n");
> +		return -EOPNOTSUPP;
> +	}

Please also check is_sampling_event(event) and event->attach_state. See
the l2x0 driver [3].

> +
> +	if (event->attr.exclude_user		||
> +			event->attr.exclude_kernel	||
> +			event->attr.exclude_hv		||
> +			event->attr.exclude_idle	||
> +			event->attr.exclude_host	||
> +			event->attr.exclude_guest	||
> +			event->attr.sample_period)
> +		return -EINVAL;
> +
> +	if (cfg < 0 || cfg >= MMDC_NUM_COUNTERS)
> +		return -EINVAL;

Do you ever plan to use the other config fields in future? It might be
worth sanity-checking that they are all zero.

> +	if (event->group_leader->pmu != event->pmu &&
> +			!is_software_event(event->group_leader))
> +		return -EINVAL;
> +
> +	list_for_each_entry(sibling, &event->group_leader->sibling_list,
> +			group_entry)
> +		if (sibling->pmu != event->pmu &&
> +				!is_software_event(sibling))
> +			return -EINVAL;

Given that several expressions are split over multiple lines, this would
be clearer with braces around the loop.

You should also ensure that the group is possible to schedule (i.e.
doesn't require more counters than the HW has). If all counters are
equivalent, that should just involve counting how many HW events the
group has. See the l2x0 driver [3] for an example.

> +
> +	event->cpu = cpumask_first(&pmu_mmdc->cpu);
> +	return 0;
> +}
> +
> +static void mmdc_event_update(struct perf_event *event)
> +{
> +	struct mmdc_pmu *pmu_mmdc = to_mmdc_pmu(event->pmu);
> +	u32 val;
> +	u64 prev_val;
> +
> +	prev_val = local64_read(&event->count);
> +	val = mmdc_read_counter(pmu_mmdc, (int) event->attr.config);

That cast shouldn't be necessary.

> +	local64_add(val - (u32)(prev_val & 0xFFFFFFFF), &event->count);
> +}

This isn't right. You should be using hw_perf_event::prev_count to hold
the shadowed hardware counter value. The event::count field is an
aggregate, so you can't rely on the lower 32 bits in this way.

> +static void mmdc_event_start(struct perf_event *event, int flags)
> +{
> +	struct mmdc_pmu *pmu_mmdc = to_mmdc_pmu(event->pmu);
> +	void __iomem *mmdc_base, *reg;
> +
> +	mmdc_base = pmu_mmdc->mmdc_base;
> +	reg = mmdc_base + MMDC_MADPCR0;
> +
> +	/*
> +	 * hrtimer is required because mmdc does not provide an interrupt so
> +	 * polling is necessary
> +	 */
> +	hrtimer_start(&pmu_mmdc->hrtimer, mmdc_timer_period(),
> +			HRTIMER_MODE_REL_PINNED);

Do this in mmdc_event_add() where you manipulate the count. That will
make things easier to follow.

> +
> +	writel(DBG_RST, reg);

You should update the shadow value (hw_perf_event::prev_count) here.

> +	writel(DBG_EN, reg);
> +}
> +
> +static int mmdc_event_add(struct perf_event *event, int flags)
> +{
> +	struct mmdc_pmu *pmu_mmdc = to_mmdc_pmu(event->pmu);
> +	int cfg = (int)event->attr.config;

That cast shouldn't be necessary.

> +
> +	if (WARN_ONCE((cfg < 0 || cfg >= MMDC_NUM_COUNTERS),
> +				"invalid configuration %d for mmdc", cfg))
> +		return -1;
> +
> +	local64_set(&event->count, 0);

This is wrong. The count is supposed to be the aggregate count so far,
and should *never* be reset. As with the above comments, use
hw_perf_event::prev_count to hold a shadow count, and update this
whenever the HW is actually updated. i.e. zero it in mmdc_event_start()
where you actually zero the counter.

> +	if (flags & PERF_EF_START)
> +		mmdc_event_start(event, flags);
> +
> +	spin_lock(&pmu_mmdc->mmdc_active_events_lock);
> +	pmu_mmdc->mmdc_events[cfg] = event;
> +	pmu_mmdc->active_events++;
> +	spin_unlock(&pmu_mmdc->mmdc_active_events_lock);
> +
> +	return 0;
> +}
> +
> +static void mmdc_event_stop(struct perf_event *event, int flags)
> +{
> +	struct mmdc_pmu *pmu_mmdc = to_mmdc_pmu(event->pmu);
> +	void __iomem *mmdc_base, *reg;
> +	int cfg = (int)event->attr.config;

That cast shouldn't be necessary.

> +
> +	mmdc_base = pmu_mmdc->mmdc_base;
> +	reg = mmdc_base + MMDC_MADPCR0;
> +
> +	if (WARN_ONCE((cfg < 0 || cfg >= MMDC_NUM_COUNTERS),
> +				"invalid configuration %d for mmdc counter", cfg))
> +		return;
> +
> +	spin_lock(&pmu_mmdc->mmdc_active_events_lock);
> +	if (pmu_mmdc->active_events <= 0)
> +		hrtimer_cancel(&pmu_mmdc->hrtimer);
> +	spin_unlock(&pmu_mmdc->mmdc_active_events_lock);

Do this in mmdc_event_del() where you decrement the count.

> +
> +	writel(PRF_FRZ, reg);
> +	mmdc_event_update(event);
> +}
> +
> +static void mmdc_event_del(struct perf_event *event, int flags)
> +{
> +	struct mmdc_pmu *pmu_mmdc = to_mmdc_pmu(event->pmu);
> +	int cfg = (int)event->attr.config;

That cast shouldn't be necessary.

[...]

> +static int imx_mmdc_perf_init(struct platform_device *pdev, void __iomem *mmdc_base)
> +{
> +	struct mmdc_pmu *pmu_mmdc;
> +	char *name;
> +	int mmdc_num;
> +	int ret;
> +
> +	pmu_mmdc = kzalloc(sizeof(*pmu_mmdc), GFP_KERNEL);
> +	if (!pmu_mmdc) {
> +		pr_err("failed to allocate PMU device!\n");
> +		return -ENOMEM;
> +	}
> +
> +	mmdc_num = mmdc_pmu_init(pmu_mmdc, mmdc_base, &pdev->dev);
> +	if (mmdc_num == 0)
> +		name = "mmdc";
> +	else
> +		name = devm_kasprintf(&pdev->dev,
> +				GFP_KERNEL, "mmdc_%d", mmdc_num);

Please use "mmdc%d" consistently.

Thanks,
Mark.

[1] https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/log/?h=smp/hotplug
[2] https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/commit/?h=smp/hotplug&id=8df038725ad5351a9730759e0a24a5c5d96be661
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-August/452843.html
