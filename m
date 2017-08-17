From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 17 Aug 2017 15:52:24 +0100
Subject: [PATCH v5 6/6] perf: ARM DynamIQ Shared Unit PMU support
In-Reply-To: <20170816141056.GB11934@leverpostej>
References: <1502192246-5623-1-git-send-email-suzuki.poulose@arm.com>
 <1502192246-5623-7-git-send-email-suzuki.poulose@arm.com>
 <20170816141056.GB11934@leverpostej>
Message-ID: <bb4b8a9c-1a4a-4ead-255b-9f0e43dcf73b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 16/08/17 15:10, Mark Rutland wrote:
> On Tue, Aug 08, 2017 at 12:37:26PM +0100, Suzuki K Poulose wrote:
>> +/*
>> + * struct dsu_pmu	- DSU PMU descriptor
>> + *
>> + * @pmu_lock		: Protects accesses to DSU PMU register from multiple
>> + *			  CPUs.
>> + * @hw_events		: Holds the event counter state.
>> + * @supported_cpus	: CPUs attached to the DSU.
>> + * @active_cpu		: CPU to which the PMU is bound for accesses.
>> + * @cpuhp_node		: Node for CPU hotplug notifier link.
>> + * @num_counters	: Number of event counters implemented by the PMU,
>> + *			  excluding the cycle counter.
>> + * @irq			: Interrupt line for counter overflow.
>> + * @cpmceid_bitmap	: Bitmap for the availability of architected common
>> + *			  events (event_code < 0x40).
>> + */
>> +struct dsu_pmu {
>> +	struct pmu			pmu;
>> +	struct device			*dev;
>> +	raw_spinlock_t			pmu_lock;
>
> I'm in two minds about pmu_lock. The core has to take the ctx lock for
> most (all?) operations, and we only allow events to be opened on a
> particular CPU, so there shouldn't be concurrent accesses from other
> CPUs.
>
> We do need to disable interrupts in order to serialise against the IRQ
> handler, and disabling IRQs doesn't make it clear that we're protecting
> a particular resource.
>
> Could we update the description to make it clear that the pmu_lock is
> used to serialise against the IRQ handler? It also happens to protect
> cross-cpu accesses, but those would be a bug.

Sure, I can.

>
> Other PMU drivers have locks which may not be necessary; I can try to
> clean those up later.
>
> [...]
>
>> +static struct attribute *dsu_pmu_event_attrs[] = {
>> +	DSU_EVENT_ATTR(cycles, 0x11),
>> +	DSU_EVENT_ATTR(bus_acecss, 0x19),
>> +	DSU_EVENT_ATTR(memory_error, 0x1a),
>> +	DSU_EVENT_ATTR(bus_cycles, 0x1d),
>> +	DSU_EVENT_ATTR(l3d_cache_allocate, 0x29),
>> +	DSU_EVENT_ATTR(l3d_cache_refill, 0x2a),
>> +	DSU_EVENT_ATTR(l3d_cache, 0x2b),
>> +	DSU_EVENT_ATTR(l3d_cache_wb, 0x2c),
>
> MAX_COMMON_EVENTS seems to be 0x40, so are we just assuming the below
> are implemented?
>
> If so, why bother exposing them at all? We can't know that they're going
> to work...
>

Thats right. The only defending argument is that the event codes are specific
to the DynamIQ, unlike the COMMON_EVENTS which matches the ARMv8 PMU event codes.
So, someone would need to carefully find the event code for a particular event.
Having these entries would make it easier for the user to do the profiling.

Also, future revisions of the DSU could potentially expose more events. So there
wouldn't be any way to tell the user (provided there aren't any changes to the
programming model and we decide to reuse the same compatible string) what we *could*
potentially support. In short, this is not a problem at the moment and we could
do something about it as and when required.

>> +	DSU_EVENT_ATTR(bus_access_rd, 0x60),
>> +	DSU_EVENT_ATTR(bus_access_wr, 0x61),
>> +	DSU_EVENT_ATTR(bus_access_shared, 0x62),
>> +	DSU_EVENT_ATTR(bus_access_not_shared, 0x63),
>> +	DSU_EVENT_ATTR(bus_access_normal, 0x64),

...

>> +static bool dsu_pmu_event_supported(struct dsu_pmu *dsu_pmu, unsigned long evt)
>> +{
>> +	/*
>> +	 * DSU PMU provides a bit map for events with
>> +	 *   id < DSU_PMU_MAX_COMMON_EVENTS.
>> +	 * Events above the range are reported as supported, as
>> +	 * tracking the support needs per-chip tables and makes
>> +	 * it difficult to track. If an event is not supported,
>> +	 * it won't be counted.
>> +	 */
>> +	if (evt >= DSU_PMU_MAX_COMMON_EVENTS)
>> +		return true;
>> +	/* The PMU driver doesn't support chain mode */
>> +	if (evt == DSU_PMU_EVT_CHAIN)
>> +		return false;
>> +	return test_bit(evt, dsu_pmu->cpmceid_bitmap);
>> +}
>
> I don't think we need to use this for event_init() (more on that below),
> so I think this can be simplified.
>
> [...]
>
>> +static struct attribute *dsu_pmu_cpumask_attrs[] = {
>> +	DSU_CPUMASK_ATTR(cpumask, DSU_ACTIVE_CPU_MASK),
>> +	DSU_CPUMASK_ATTR(supported_cpus, DSU_SUPPORTED_CPU_MASK),
>> +	NULL,
>> +};
>
> Normally we only expose one mask.
>
> Why do we need the supported cpu mask? What is the intended use-case?
>
> [...]
>

Thats just to let the user know the CPUs bound to this PMU instance.

>> +static inline u64 dsu_pmu_read_counter(struct perf_event *event)
>> +{
>> +	u64 val = 0;
>> +	unsigned long flags;
>> +	struct dsu_pmu *dsu_pmu = to_dsu_pmu(event->pmu);
>> +	int idx = event->hw.idx;
>> +
>> +	if (WARN_ON(!cpumask_test_cpu(smp_processor_id(),
>> +				 &dsu_pmu->supported_cpus)))
>> +		return 0;
>
> It would be better to check that this is the active CPU, since reading
> on another supported CPU would still be wrong.
>
> Likewise for the check in dsu_pmu_write_counter().
>
> [...]
>

OK.

>> +static void dsu_pmu_enable_counter(struct dsu_pmu *dsu_pmu, int idx)
>> +{
>> +	unsigned long flags;
>> +
>> +	raw_spin_lock_irqsave(&dsu_pmu->pmu_lock, flags);
>> +	__dsu_pmu_counter_interrupt_enable(idx);
>> +	__dsu_pmu_enable_counter(idx);
>> +	raw_spin_unlock_irqrestore(&dsu_pmu->pmu_lock, flags);
>> +}
>> +
>> +static void dsu_pmu_disable_counter(struct dsu_pmu *dsu_pmu, int idx)
>> +{
>> +	unsigned long flags;
>> +
>> +	raw_spin_lock_irqsave(&dsu_pmu->pmu_lock, flags);
>> +	__dsu_pmu_disable_counter(idx);
>> +	__dsu_pmu_counter_interrupt_disable(idx);
>> +	raw_spin_unlock_irqrestore(&dsu_pmu->pmu_lock, flags);
>> +}
>
> Do we need the disable/enable IRQs across these? AFAICT these writing to
> set/clr registers, so there's no RMW race to worry about so long as the
> rest of the code does likewise.
>
> [...]

Ah, you're right. We don't need to do a select register operation here.

>
>> +static inline u32 dsu_pmu_get_status(void)
>> +{
>> +	return __dsu_pmu_get_pmovsclr();
>> +}
>
> This could do with a better name. It's not clear what status it's meant
> to get.
>
> [...]
>

Agreed, I was in double mind about the name, myself.

>> +static irqreturn_t dsu_pmu_handle_irq(int irq_num, void *dev)
>> +{
>> +	int i;
>> +	bool handled = false;
>> +	struct dsu_pmu *dsu_pmu = dev;
>> +	struct dsu_hw_events *hw_events = &dsu_pmu->hw_events;
>> +	unsigned long overflow, workset;
>> +
>> +	overflow = (unsigned long)dsu_pmu_get_status();
>
> This cast isn't necessary.
>
>> +	bitmap_and(&workset, &overflow, hw_events->used_mask,
>> +		   DSU_PMU_MAX_HW_CNTRS);
>> +
>> +	if (!workset)
>> +		return IRQ_NONE;
>> +
>> +	for_each_set_bit(i, &workset, DSU_PMU_MAX_HW_CNTRS) {
>> +		struct perf_event *event = hw_events->events[i];
>> +
>> +		if (WARN_ON(!event))
>> +			continue;
>
> Unless we explicitly clear an event's overflow flag when we remove it,
> this could happen in normal operation. This should probably have a
> _ONCE(), if we think we need it.
>
> [...]
>


>> +static int dsu_pmu_add(struct perf_event *event, int flags)
>> +{
>> +	struct dsu_pmu *dsu_pmu = to_dsu_pmu(event->pmu);
>> +	struct dsu_hw_events *hw_events = &dsu_pmu->hw_events;
>> +	struct hw_perf_event *hwc = &event->hw;
>> +	int idx;
>> +
>> +	if (!cpumask_test_cpu(smp_processor_id(), &dsu_pmu->supported_cpus))
>> +		return -ENOENT;
>
> This shouldn't ever happen, and we can check against the active cpumask,
> with a WARN_ON_ONCE(). We have to do this for CPU PMUs since they
> support events which can migrate with tasks, but that's not the case
> here.
>
> [...]
>

But, we have to make sure we are reading the events from a CPU within this
DSU in case we have multiple DSU units. In any case, reading it from a CPU
outside the active cpumask is a tighter check. I will change it.


>> +static int dsu_pmu_validate_event(struct pmu *pmu,
>> +				  struct dsu_hw_events *hw_events,
>> +				  struct perf_event *event)
>> +{
>> +	if (is_software_event(event))
>> +		return 1;
>> +	/* Reject groups spanning multiple HW PMUs. */
>> +	if (event->pmu != pmu)
>> +		return 0;
>> +	if (event->state < PERF_EVENT_STATE_OFF)
>> +		return 1;
>> +	if (event->state == PERF_EVENT_STATE_OFF && !event->attr.enable_on_exec)
>> +		return 1;
>
> This doesn't make sense for a !CPU pmu, and I think you can nuke the
> prior test, too, which I think doesn't make sense.
>
>> +	return dsu_pmu_get_event_idx(hw_events, event) >= 0;
>> +}
>
> This whole function could be bool.
>

Agreed.

>> +/*
>> + * Make sure the group of events can be scheduled at once
>> + * on the PMU.
>> + */
>> +static int dsu_pmu_validate_group(struct perf_event *event)
>> +{
>> +	struct perf_event *sibling, *leader = event->group_leader;
>> +	struct dsu_hw_events fake_hw;
>> +
>> +	if (event->group_leader == event)
>> +		return 0;
>> +
>> +	memset(fake_hw.used_mask, 0, sizeof(fake_hw.used_mask));
>> +	if (!dsu_pmu_validate_event(event->pmu, &fake_hw, leader))
>> +		return -EINVAL;
>> +	list_for_each_entry(sibling, &leader->sibling_list, group_entry) {
>> +		if (!dsu_pmu_validate_event(event->pmu, &fake_hw, sibling))
>> +			return -EINVAL;
>> +	}
>> +	if (!dsu_pmu_validate_event(event->pmu, &fake_hw, event))
>> +		return -EINVAL;
>> +	return 0;
>> +}
>
> The return value has the opposite polarity to dsu_pmu_validate_event(),
> which is rather confusing.
>
> [...]
>

Yes, you're right. I will clean it up.

>> +static int dsu_pmu_event_init(struct perf_event *event)
>> +{
>> +	struct dsu_pmu *dsu_pmu = to_dsu_pmu(event->pmu);
>> +
>> +	if (event->attr.type != event->pmu->type)
>> +		return -ENOENT;
>> +
>> +	if (!dsu_pmu_event_supported(dsu_pmu, event->attr.config))
>> +		return -EOPNOTSUPP;
>
> I can see why we track this for the sysfs nodes, but why do we bother
> enforcing it for event_init()? Especially given we only enforce it for a
> subset of values...
>
> We don't do that for other PMUs, and assuming that this doesn't break
> the HW, I'd rather we allowed users to request raw values, even if we
> think the HW won't count them.

OK, I will remove it.

>> +
>> +	/* We cannot support task bound events */
>> +	if (event->cpu < 0) {
>> +		dev_dbg(dsu_pmu->pmu.dev, "Can't support per-task counters\n");
>> +		return -EINVAL;
>> +	}
>
> We should also check (event->attach_state & PERF_ATTACH_TASK), since you
> could have a per-task event with a CPU filter, and that doesn't make
> sense either.
>
> [...]

OK

>
>> +/**
>> + * dsu_pmu_dt_get_cpus: Get the list of CPUs in the cluster.
>> + */
>> +static int dsu_pmu_dt_get_cpus(struct device_node *dev, cpumask_t *mask)
>> +{
>> +	int i = 0, n, cpu;
>> +	struct device_node *cpu_node;
>> +
>> +	n = of_count_phandle_with_args(dev, "cpus", NULL);
>> +	if (n <= 0)
>> +		return -ENODEV;
>> +	for (; i < n; i++) {
>> +		cpu_node = of_parse_phandle(dev, "cpus", i);
>> +		if (!cpu_node)
>> +			break;
>> +		cpu = of_cpu_node_to_id(cpu_node);
>> +		of_node_put(cpu_node);
>> +		if (cpu < 0)
>> +			break;
>
> I believe this can happen if the kernel's nr_cpus were capped below the
> number of CPUs in the system. So we need to iterate all entries of the
> cpus list regardless.
>

Good point. Initial version of the driver used to ignore the failures, but
was changed later. I will roll it back.

>> +		cpumask_set_cpu(cpu, mask);
>> +	}
>> +	if (i != n)
>> +		return -EINVAL;
>> +	return 0;
>> +}
>
> [...]
>
>> +
>> +/*
>> + * dsu_pmu_probe_pmu: Probe the PMU details on a CPU in the cluster.
>> + */
>> +static void dsu_pmu_probe_pmu(void *data)
>> +{
>> +	struct dsu_pmu *dsu_pmu = data;
>> +	u64 cpmcr;
>> +	u32 cpmceid[2];
>> +
>> +	if (WARN_ON(!cpumask_test_cpu(smp_processor_id(),
>> +		&dsu_pmu->supported_cpus)))
>> +		return;
>
> I can't see how this can happen unless core kernel code is critically
> broken, given that the only caller uses smp_call_function_any() with the
> supported_cpus mask.
>
> Do we need this check?

You're right, we can remove it.

>
>> +	cpmcr = __dsu_pmu_read_pmcr();
>> +	dsu_pmu->num_counters = ((cpmcr >> CLUSTERPMCR_N_SHIFT) &
>> +					CLUSTERPMCR_N_MASK);
>> +	if (!dsu_pmu->num_counters)
>> +		return;
>
> Is that valid? What range of values makes sense?
>
> [...]
>

We should at least have one counter implemented (excluding the cycle counter).
And yes, we should check if the num_counters <= 31.

>> +	/*
>> +	 * Find one CPU in the DSU to handle the IRQs.
>> +	 * It is highly unlikely that we would fail
>> +	 * to find one, given the probing has succeeded.
>> +	 */
>> +	cpu = dsu_pmu_get_online_cpu(dsu_pmu);
>> +	if (cpu >= nr_cpu_ids)
>> +		return -ENODEV;
>> +	cpumask_set_cpu(cpu, &dsu_pmu->active_cpu);
>> +	rc = irq_set_affinity_hint(irq, &dsu_pmu->active_cpu);
>
> Is setting the affinity hint strong enough?
>
> Can the affinity be changed behind the back of this driver?
>

Did you mean to use "force"d affinity settings ? If so, modules
don't have the luxury of doing that. Hence this one. I think that also
brings up the problem where we could be reading the counters from
a different CPU than we requested. So, I think it would be good to keep
the CPU check, wherever we could access the PMU.

>> +static int dsu_pmu_cpu_teardown(unsigned int cpu, struct hlist_node *node)
>> +{
>> +	int dst;
>> +	struct dsu_pmu *dsu_pmu = hlist_entry_safe(node, struct dsu_pmu,
>> +						   cpuhp_node);
>> +
>> +	if (!cpumask_test_and_clear_cpu(cpu, &dsu_pmu->active_cpu))
>> +		return 0;
>> +
>> +	dst = dsu_pmu_get_online_cpu_any_but(dsu_pmu, cpu);
>> +	if (dst < nr_cpu_ids) {
>> +		cpumask_set_cpu(dst, &dsu_pmu->active_cpu);
>> +		perf_pmu_migrate_context(&dsu_pmu->pmu, cpu, dst);
>> +		irq_set_affinity_hint(dsu_pmu->irq, &dsu_pmu->active_cpu);
>
> Likewise, is this sufficient?

Thanks a lot for the detailed review !

Cheers
Suzuki
