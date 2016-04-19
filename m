From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 19 Apr 2016 16:06:08 +0100
Subject: [PATCH v2 1/5] arm64/perf: Basic uncore counter support for
 Cavium ThunderX
In-Reply-To: <2588abcb011df6e60cd8212a8583454999180748.1457539622.git.jglauber@cavium.com>
References: <cover.1457539621.git.jglauber@cavium.com>
 <2588abcb011df6e60cd8212a8583454999180748.1457539622.git.jglauber@cavium.com>
Message-ID: <20160419150607.GB20991@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 09, 2016 at 05:21:03PM +0100, Jan Glauber wrote:
> Provide "uncore" facilities for different non-CPU performance
> counter units. Based on Intel/AMD uncore pmu support.
> 
> The uncore drivers cover quite different functionality including
> L2 Cache, memory controllers and interconnects.
> 
> The uncore PMUs can be found under /sys/bus/event_source/devices.
> All counters are exported via sysfs in the corresponding events
> files under the PMU directory so the perf tool can list the event names.
> 
> There are some points that are special in this implementation:
> 
> 1) The PMU detection relies on PCI device detection. If a
>    matching PCI device is found the PMU is created. The code can deal
>    with multiple units of the same type, e.g. more than one memory
>    controller.
>    Note: There is also a CPUID check to determine the CPU variant,
>    this is needed to support different hardware versions that use
>    the same PCI IDs.
> 
> 2) Counters are summarized across different units of the same type
>    on one NUMA node.
>    For instance L2C TAD 0..7 are presented as a single counter
>    (adding the values from TAD 0 to 7). Although losing the ability
>    to read a single value the merged values are easier to use.

Merging within a NUMA node, but no further seems a little arbitrary.

> 3) NUMA support. The device node id is used to group devices by node
>    so counters on one node can be merged. The NUMA node can be selected
>    via a new sysfs node attribute.
>    Without NUMA support all devices will be on node 0.

It doesn't seem great that this depends on kernel configuration (which
is independent of HW configuration). It seems confusing for the user,
and fragile.

Do we not have access to another way of grouping cores (e.g. a socket
ID), that's independent of kernel configuration? That seems to be how
the x86 uncore PMUs are handled.

If we don't have that information, it really feels like we need
additional info from FW (which would also solve the CPUID issue with
point 1), or this is likely to be very fragile.

> +void thunder_uncore_read(struct perf_event *event)
> +{
> +	struct thunder_uncore *uncore = event_to_thunder_uncore(event);
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct thunder_uncore_node *node;
> +	struct thunder_uncore_unit *unit;
> +	u64 prev, new = 0;
> +	s64 delta;
> +
> +	node = get_node(hwc->config, uncore);
> +
> +	/*
> +	 * No counter overflow interrupts so we do not
> +	 * have to worry about prev_count changing on us.
> +	 */
> +	prev = local64_read(&hwc->prev_count);
> +
> +	/* read counter values from all units on the node */
> +	list_for_each_entry(unit, &node->unit_list, entry)
> +		new += readq(hwc->event_base + unit->map);
> +
> +	local64_set(&hwc->prev_count, new);
> +	delta = new - prev;
> +	local64_add(delta, &event->count);
> +}
> +
> +void thunder_uncore_del(struct perf_event *event, int flags)
> +{
> +	struct thunder_uncore *uncore = event_to_thunder_uncore(event);
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct thunder_uncore_node *node;
> +	int i;
> +
> +	event->pmu->stop(event, PERF_EF_UPDATE);
> +
> +	/*
> +	 * For programmable counters we need to check where we installed it.
> +	 * To keep this function generic always test the more complicated
> +	 * case (free running counters won't need the loop).
> +	 */
> +	node = get_node(hwc->config, uncore);
> +	for (i = 0; i < node->num_counters; i++) {
> +		if (cmpxchg(&node->events[i], event, NULL) == event)
> +			break;
> +	}
> +	hwc->idx = -1;
> +}

It's very difficult to know what's going on here with the lack of a
corresponding *_add function. Is there any reason there is not a common
implementation, at least for the shared logic?

Similarly, it's difficult to know what state the read function is
expecting (e.g. are counters always initialised to 0 to start with)?

> +int thunder_uncore_event_init(struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct thunder_uncore_node *node;
> +	struct thunder_uncore *uncore;
> +
> +	if (event->attr.type != event->pmu->type)
> +		return -ENOENT;
> +
> +	/* we do not support sampling */
> +	if (is_sampling_event(event))
> +		return -EINVAL;
> +
> +	/* counters do not have these bits */
> +	if (event->attr.exclude_user	||
> +	    event->attr.exclude_kernel	||
> +	    event->attr.exclude_host	||
> +	    event->attr.exclude_guest	||
> +	    event->attr.exclude_hv	||
> +	    event->attr.exclude_idle)
> +		return -EINVAL;
> +
> +	/* counters are 64 bit wide and without overflow interrupts */
> +

It would be good to describe the implications of this; otherwise it
seems like a floating comment.

> +	uncore = event_to_thunder_uncore(event);
> +	if (!uncore)
> +		return -ENODEV;
> +	if (!uncore->event_valid(event->attr.config & UNCORE_EVENT_ID_MASK))
> +		return -EINVAL;
> +
> +	/* check NUMA node */
> +	node = get_node(event->attr.config, uncore);

As above, I don't think using Linux NUMA node IDs is a good idea,
especially for a user-facing ABI.

> +	if (!node) {
> +		pr_debug("Invalid numa node selected\n");
> +		return -EINVAL;
> +	}
> +
> +	hwc->config = event->attr.config;
> +	hwc->idx = -1;
> +	return 0;
> +}

What about the CPU handling?

Where do you verify that cpu != -1, and assign the event to a particular
CPU prior to the pmu::add callback? That should be common to all of your
uncore PMUs, and should live here.

> +static ssize_t node_show(struct device *dev, struct device_attribute *attr, char *page)
> +{
> +	if (NODES_SHIFT)
> +		return sprintf(page, "config:16-%d\n", 16 + NODES_SHIFT - 1);
> +	else
> +		return sprintf(page, "config:16\n");
> +}

I'm not keen on this depending on the kernel configuration.

> +static int thunder_uncore_pmu_cpu_notifier(struct notifier_block *nb,
> +					   unsigned long action, void *data)
> +{
> +	struct thunder_uncore *uncore = container_of(nb, struct thunder_uncore, cpu_nb);
> +	int new_cpu, old_cpu = (long) data;
> +
> +	switch (action & ~CPU_TASKS_FROZEN) {
> +	case CPU_DOWN_PREPARE:
> +		if (!cpumask_test_and_clear_cpu(old_cpu, &thunder_active_mask))
> +			break;
> +		new_cpu = cpumask_any_but(cpu_online_mask, old_cpu);

Above it was mentioned that events are groups per node/socket. So surely
it doesn't make sens to migrate this to any arbitrary CPU, but only CPUs
in the same node?

If I have active events for node 0, what happens when I hotplug out the
last CPU for that node (but have CPUs online in node 1)?

Is it guaranteed that power is retained for the device?

> +		if (new_cpu >= nr_cpu_ids)
> +			break;
> +		perf_pmu_migrate_context(uncore->pmu, old_cpu, new_cpu);
> +		cpumask_set_cpu(new_cpu, &thunder_active_mask);
> +		break;
> +	default:
> +		break;
> +	}
> +	return NOTIFY_OK;
> +}
> +
> +static struct thunder_uncore_node *alloc_node(struct thunder_uncore *uncore, int node_id, int counters)
> +{
> +	struct thunder_uncore_node *node;
> +
> +	node = kzalloc(sizeof(struct thunder_uncore_node), GFP_KERNEL);

Use:
	node = kzalloc(sizeof(*node), GFP_KERNEL);

> +int __init thunder_uncore_setup(struct thunder_uncore *uncore, int device_id,
> +			 unsigned long offset, unsigned long size,
> +			 struct pmu *pmu, int counters)
> +{
> +	struct thunder_uncore_unit  *unit, *tmp;
> +	struct thunder_uncore_node *node;
> +	struct pci_dev *pdev = NULL;
> +	int ret, node_id, found = 0;
> +
> +	/* detect PCI devices */
> +	do {
> +		pdev = pci_get_device(PCI_VENDOR_ID_CAVIUM, device_id, pdev);
> +		if (!pdev)
> +			break;

the loop would look cleaner like:

	unsigned int vendor_id = PCI_VENDOR_ID_CAVIUM;

	while ((pdev = pci_get_device(vendor_id, device_id, pdev))) {

		...

	}

> +
> +		node_id = dev_to_node(&pdev->dev);
> +		/*
> +		 * -1 without NUMA, set to 0 because we always have at
> +		 *  least node 0.
> +		 */
> +		if (node_id < 0)
> +			node_id = 0;

Again, this seems fragile to me. I am very much not keen on this
behaviour varying based on a logically unrelated kernel configuration
option.

> +
> +		/* allocate node if necessary */
> +		if (!uncore->nodes[node_id])
> +			uncore->nodes[node_id] = alloc_node(uncore, node_id, counters);
> +
> +		node = uncore->nodes[node_id];
> +		if (!node) {
> +			ret = -ENOMEM;
> +			goto fail;
> +		}
> +
> +		unit = kzalloc(sizeof(struct thunder_uncore_unit), GFP_KERNEL);

Use:
	unit = kzalloc(sizeof(*unit), GFP_KERNEL)

> +	/*
> +	 * perf PMU is CPU dependent in difference to our uncore devices.
> +	 * Just pick a CPU and migrate away if it goes offline.
> +	 */
> +	cpumask_set_cpu(smp_processor_id(), &thunder_active_mask);

The current CPU is not guaranteed to be in the same node, no?

My comments earlier w.r.t. migration apply here too.

> +
> +	uncore->cpu_nb.notifier_call = thunder_uncore_pmu_cpu_notifier;
> +	uncore->cpu_nb.priority = CPU_PRI_PERF + 1;
> +	ret = register_cpu_notifier(&uncore->cpu_nb);
> +	if (ret)
> +		goto fail;
> +
> +	ret = perf_pmu_register(pmu, pmu->name, -1);
> +	if (ret)
> +		goto fail_pmu;
> +
> +	uncore->pmu = pmu;

Typically, the data related to the PMU is put in a struct which wraps
the struct pmu. That allows you to map either way using container_of.

Is there a particular reason for thunder_uncore to not contain the
struct PMU, rather than a pointer to it?

Thanks,
Mark.
