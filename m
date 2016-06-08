From: nleeder@codeaurora.org (Neil Leeder)
Date: Wed, 8 Jun 2016 11:16:06 -0400
Subject: [PATCH 2/2] soc: qcom: add l2 cache perf events driver
In-Reply-To: <20160606095139.GC6831@leverpostej>
References: <1464987812-14360-1-git-send-email-nleeder@codeaurora.org>
 <1464987812-14360-3-git-send-email-nleeder@codeaurora.org>
 <20160606095139.GC6831@leverpostej>
Message-ID: <be1cc820-7b9d-041b-06d8-cefeb43934d5@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,
Thank you for the detailed review.

On 6/6/2016 05:51 AM, Mark Rutland wrote:
> On Fri, Jun 03, 2016 at 05:03:32PM -0400, Neil Leeder wrote:
>> Adds perf events support for L2 cache PMU.
>>
>> The L2 cache PMU driver is named 'l2cache' and can be used
>> with perf events to profile L2 events such as cache hits
>> and misses.
>>
>> Signed-off-by: Neil Leeder <nleeder@codeaurora.org>
>> ---
>>  drivers/soc/qcom/Kconfig               |  10 +
>>  drivers/soc/qcom/Makefile              |   1 +
>>  drivers/soc/qcom/perf_event_l2.c       | 917 +++++++++++++++++++++++++++++++++
>>  include/linux/soc/qcom/perf_event_l2.h |  82 +++
>>  4 files changed, 1010 insertions(+)
>>  create mode 100644 drivers/soc/qcom/perf_event_l2.c
>>  create mode 100644 include/linux/soc/qcom/perf_event_l2.h
>>

[...]

>> +++ b/drivers/soc/qcom/perf_event_l2.c
>> @@ -0,0 +1,917 @@
>> +/* Copyright (c) 2015,2016 The Linux Foundation. All rights reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 and
>> + * only version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +#define pr_fmt(fmt) "l2 perfevents: " fmt
>> +
>> +#include <linux/module.h>
>> +#include <linux/bitops.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/irq.h>
>> +#include <linux/list.h>
>> +#include <linux/acpi.h>
>> +#include <linux/perf_event.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/soc/qcom/perf_event_l2.h>
>> +#include <linux/soc/qcom/l2-accessors.h>
>> +
>> +/*
>> + * The cache is made-up of one or more slices, each slice has its own PMU.
>> + * This structure represents one of the hardware PMUs.
>> + */
> 
> I take it each slice PMU is shared by several CPUs? i.e. there aren't
> per-cpu slice PMU counters.
> 

That is correct.

>> +struct hml2_pmu {
>> +	struct list_head entry;
>> +	struct perf_event *events[MAX_L2_CTRS];
>> +	unsigned long used_mask[BITS_TO_LONGS(MAX_L2_EVENTS)];
> 
> What's the difference between MAX_L2_CTRS and MAX_L2_EVENTS?
> 
> I'm surprised that they are different. What precisely do either
> represent?
> 
> Surely you don't have different events per-slice? Why do you need the
> PMU pointers at the slice level?
> 

Qualcomm PMUs have events arranged in a matrix of rows (codes) and columns (groups).
Only one event can be enabled from each group at once.
The upper part of used_mask is used to keep a record of which group has been
used. This is the same mechanism used in armv7
(arch/arm/perf_event_v7.c:krait_event_to_bit()).
So used_mask contains both an indication for a physical counter in use, and also
for the group, which is why it's a different size from MAX_L2_CTRS.

I kept this because it's what's done in armv7. If there's an objection, I can
move the group used_mask to its own bitmap.

>> +	unsigned int valid_cpus;
>> +	int on_cpu;
>> +	u8 cpu[MAX_CPUS_IN_CLUSTER];
> 
> These all look suspicious to me (potentially barring on_cpu)
> 
> Surely this is an uncore PMU? It represents a shared resource, with
> shared counters, so it should be.
> 
> If you need to encode a set of CPUs, use a cpumask.
> 

Agreed. I will use a cpumask.

>> +	atomic64_t prev_count[MAX_L2_CTRS];
>> +	spinlock_t pmu_lock;
>> +};
>> +
>> +/*
>> + * Aggregate PMU. Implements the core pmu functions and manages
>> + * the hardware PMUs.
>> + */
>> +struct l2cache_pmu {
>> +	u32 num_pmus;
>> +	struct list_head pmus;
>> +	struct pmu pmu;
>> +	int num_counters;
>> +};
>> +
>> +#define to_l2cache_pmu(p) (container_of(p, struct l2cache_pmu, pmu))
>> +
>> +static DEFINE_PER_CPU(struct hml2_pmu *, cpu_to_pmu);
>> +static struct l2cache_pmu l2cache_pmu = { 0 };
>> +static int num_cpus_in_cluster;
>> +
>> +static u32 l2_cycle_ctr_idx;
>> +static u32 l2_reset_mask;
>> +static u32 mpidr_affl1_shift;
> 
> Eww. Drivers really shouldn't be messing with the MPIDR. The precise
> values are bound to change between generations of SoCs leaving us with a
> mess.
> 
> The FW should tell us precisely which CPUs device are affine to.
> 

During partial goods processing firmware renumbers the CPUs.
The only association between the CPU numbers the kernel sees and the
physical CPUs & slices is through MPIDR. But see a comment below
where I think I can remove some of the MPIDR handling, including
this variable.

>> +static inline u32 idx_to_reg(u32 idx)
>> +{
>> +	u32 bit;
>> +
>> +	if (idx == l2_cycle_ctr_idx)
>> +		bit = BIT(L2CYCLE_CTR_BIT);
>> +	else
>> +		bit = BIT(idx);
>> +	return bit;
>> +}
> 
> Probably worth giving a _bit suffix on this function. That makes it less
> confusing when it's used later.
> 

OK.

> [...]
> 
>> +static inline void hml2_pmu__enable(void)
>> +{
>> +	/* Ensure all programming commands are done before proceeding */
>> +	wmb();
>> +	set_l2_indirect_reg(L2PMCR, L2PMCR_GLOBAL_ENABLE);
>> +}
>> +
>> +static inline void hml2_pmu__disable(void)
>> +{
>> +	set_l2_indirect_reg(L2PMCR, L2PMCR_GLOBAL_DISABLE);
>> +	/* Ensure the basic counter unit is stopped before proceeding */
>> +	wmb();
>> +}
> 
> What does set_l2_indirect_reg do? IIRC it does system register accesses,
> so I don't see why wmb() (A.K.A dsb(st)) would ensure completion of
> those. So what's going on in hml2_pmu__disable()?
> 
> What exactly are you trying to order here?
> 

I think this is left over from a previous version - I'll remove it.

>> +static inline void hml2_pmu__counter_set_value(u32 idx, u64 value)
>> +{
>> +	u32 counter_reg;
>> +
>> +	if (idx == l2_cycle_ctr_idx) {
>> +		set_l2_indirect_reg(L2PMCCNTR, value);
>> +	} else {
>> +		counter_reg = (idx * 16) + IA_L2PMXEVCNTR_BASE;
>> +		set_l2_indirect_reg(counter_reg, (u32)(value & 0xFFFFFFFF));
>> +	}
>> +}
>> +
>> +static inline u64 hml2_pmu__counter_get_value(u32 idx)
>> +{
>> +	u64 value;
>> +	u32 counter_reg;
>> +
>> +	if (idx == l2_cycle_ctr_idx) {
>> +		value = get_l2_indirect_reg(L2PMCCNTR);
>> +	} else {
>> +		counter_reg = (idx * 16) + IA_L2PMXEVCNTR_BASE;
>> +		value = get_l2_indirect_reg(counter_reg);
>> +	}
>> +
>> +	return value;
>> +}
> 
> It would be good to explain the magic 16 for these two (ideally using
> some well-named mnemonic).
> 

Will do.

> [...]
> 
>> +static inline int event_to_bit(unsigned int group)
>> +{
>> +	/* Lower bits are reserved for use by the counters */
>> +	return group + MAX_L2_CTRS + 1;
>> +}
> 
> What exactly is a group in this context? Why is this not group_to_bit?
> 

This is the column(group) part of the event format. If group used_mask gets
separated out from the existing used_mask, this will go away,

>> +static int l2_cache__get_event_idx(struct hml2_pmu *slice,
>> +				   struct perf_event *event)
>> +{
>> +	struct hw_perf_event *hwc = &event->hw;
>> +	int idx;
>> +	int bit;
>> +
>> +	if (hwc->config_base == L2CYCLE_CTR_RAW_CODE) {
>> +		if (test_and_set_bit(l2_cycle_ctr_idx, slice->used_mask))
>> +			return -EAGAIN;
>> +
>> +		return l2_cycle_ctr_idx;
>> +	}
>> +
>> +	if (L2_EVT_GROUP(hwc->config_base) > L2_EVT_GROUP_MAX)
>> +		return -EINVAL;
> 
> This doesn't look right. L2_EVT_GROUP() masks out and shifts out bits,
> so I can pass an invalid value and it will be silently coerced to some
> valid value.
> 

I will add event validation in __event_init(). Then this check won't be needed here.

>> +
>> +	/* check for column exclusion */
>> +	bit = event_to_bit(L2_EVT_GROUP(hwc->config_base));
>> +	if (test_and_set_bit(bit, slice->used_mask)) {
>> +		pr_err("column exclusion for evt %lx\n", hwc->config_base);
>> +		event->state = PERF_EVENT_STATE_OFF;
>> +		return -EINVAL;
>> +	}
>> +
>> +	for (idx = 0; idx < l2cache_pmu.num_counters - 1; idx++) {
>> +		if (!test_and_set_bit(idx, slice->used_mask))
>> +			return idx;
>> +	}
>> +
>> +	/* The counters are all in use. */
>> +	clear_bit(bit, slice->used_mask);
>> +	return -EAGAIN;
>> +}
> 
> [...]
> 
>> +static irqreturn_t l2_cache__handle_irq(int irq_num, void *data)
>> +{
>> +	struct hml2_pmu *slice = data;
>> +	u32 ovsr;
>> +	int idx;
>> +	struct pt_regs *regs;
>> +
>> +	ovsr = hml2_pmu__getreset_ovsr();
>> +	if (!hml2_pmu__has_overflowed(ovsr))
>> +		return IRQ_NONE;
>> +
>> +	regs = get_irq_regs();
>> +
>> +	for (idx = 0; idx < l2cache_pmu.num_counters; idx++) {
>> +		struct perf_event *event = slice->events[idx];
>> +		struct hw_perf_event *hwc;
>> +		struct perf_sample_data data;
>> +
>> +		if (!event)
>> +			continue;
>> +
>> +		if (!hml2_pmu__counter_has_overflowed(ovsr, idx))
>> +			continue;
>> +
>> +		l2_cache__event_update_from_slice(event, slice);
>> +		hwc = &event->hw;
>> +
>> +		if (is_sampling_event(event)) {
>> +			perf_sample_data_init(&data, 0, hwc->last_period);
> 
> I don't think sampling makes sense, given this is an uncore PMU and the
> events are triggered by other CPUs.

There is origin filtering so events can be attributed to a CPU when sampling.

> 
>> +			if (!l2_cache__event_set_period(event, hwc))
>> +				continue;
>> +			if (perf_event_overflow(event, &data, regs))
>> +				l2_cache__event_disable(event);
>> +		} else {
>> +			l2_cache__slice_set_period(slice, hwc);
>> +		}
>> +	}
>> +
>> +	/*
>> +	 * Handle the pending perf events.
>> +	 *
>> +	 * Note: this call *must* be run with interrupts disabled. For
>> +	 * platforms that can have the PMU interrupts raised as an NMI, this
>> +	 * will not work.
>> +	 */
>> +	irq_work_run();
>> +
>> +	return IRQ_HANDLED;
>> +}
> 
> [...]
> 
>> +static int l2_cache__event_init(struct perf_event *event)
>> +{
>> +	struct hw_perf_event *hwc = &event->hw;
>> +	struct hml2_pmu *slice;
>> +
>> +	if (event->attr.type != l2cache_pmu.pmu.type)
>> +		return -ENOENT;
>> +
>> +	/* We cannot filter accurately so we just don't allow it. */
>> +	if (event->attr.exclude_user || event->attr.exclude_kernel ||
>> +			event->attr.exclude_hv || event->attr.exclude_idle)
>> +		return -EINVAL;
>> +
> 
> Please also check grouping. For instance, you definitely don't support
> event->pmu != event->group_leader->pmu, modulo so weirdness with
> software events. See drivers/bus/arm-ccn.c.
> 
> Do you support groups of events at all?
> 
> If so, you must validate that the groups are also schedulable.
> 

I'll add grouping checks

>> +	hwc->idx = -1;
>> +	hwc->config_base = event->attr.config;
>> +
>> +	/*
>> +	 * Ensure all events are on the same cpu so all events are in the
>> +	 * same cpu context, to avoid races on pmu_enable etc.
>> +	 * For the first event, record its CPU in slice->on_cpu.
>> +	 * For subsequent events on that slice, force the event to that cpu.
>> +	 */
>> +	slice = get_hml2_pmu(to_l2cache_pmu(event->pmu), event->cpu);
>> +	if (slice->on_cpu == -1)
>> +		slice->on_cpu = event->cpu;
>> +	else
>> +		event->cpu = slice->on_cpu;
> 
> Please just do the usual thing for uncore PMU CPU handling. Take a look
> at the arm-ccn driver.
> 

I'll look at arm-ccn's handling


>> +	/*
>> +	 * For counting events use L2_CNT_PERIOD which allows for simplified
>> +	 * math and proper handling of overflows.
>> +	 */
>> +	if (hwc->sample_period == 0) {
>> +		hwc->sample_period = L2_CNT_PERIOD;
>> +		hwc->last_period   = hwc->sample_period;
>> +		local64_set(&hwc->period_left, hwc->sample_period);
>> +	}
>> +
>> +	return 0;
>> +}
> 
> Huh? You haven't validated the event. Please validate the config is a
> real, countable event that you support before assuming success.
> 

I'll add validation here

>> +static void l2_cache__event_update(struct perf_event *event)
>> +{
>> +	struct l2cache_pmu *system = to_l2cache_pmu(event->pmu);
>> +	struct hml2_pmu *slice;
>> +	struct hw_perf_event *hwc = &event->hw;
>> +
>> +	if (hwc->idx == -1)
>> +		return;
>> +
>> +	slice = get_hml2_pmu(system, event->cpu);
>> +	if (likely(slice))
>> +		l2_cache__event_update_from_slice(event, slice);
>> +}
> 
> When is slice NULL?
> 

I'll remove this

> [...]
> 
>> +static int l2_cache__event_add(struct perf_event *event, int flags)
>> +{
>> +	struct l2cache_pmu *system = to_l2cache_pmu(event->pmu);
>> +	struct hw_perf_event *hwc = &event->hw;
>> +	int idx;
>> +	int err = 0;
>> +	struct hml2_pmu *slice;
>> +
>> +	slice = get_hml2_pmu(system, event->cpu);
>> +	if (!slice) {
>> +		event->state = PERF_EVENT_STATE_OFF;
>> +		hwc->idx = -1;
>> +		goto out;
>> +	}
>> +
>> +	/*
>> +	 * This checks for a duplicate event on the same cluster, which
>> +	 * typically occurs in non-sampling mode when using perf -a,
>> +	 * which generates events on each CPU. In this case, we don't
>> +	 * want to permanently disable the event by setting its state to
>> +	 * OFF, because if the other CPU is subsequently hotplugged, etc,
>> +	 * we want the opportunity to start collecting on this event.
>> +	 */
>> +	if (config_is_dup(slice, hwc)) {
>> +		hwc->idx = -1;
>> +		goto out;
>> +	}
> 
> Eww. This indicates you're just hacking around userspace.
> 
> Make this a uncore PMU, and expose a cpumask. See the arm-ccn driver.
> 

I'll add cpumask

>> +
>> +	idx = l2_cache__get_event_idx(slice, event);
>> +	if (idx < 0) {
>> +		err = idx;
>> +		goto out;
>> +	}
>> +
>> +	hwc->idx = idx;
>> +	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
>> +	slice->events[idx] = event;
>> +	atomic64_set(&slice->prev_count[idx], 0ULL);
>> +
>> +	if (flags & PERF_EF_START)
>> +		l2_cache__event_start(event, flags);
>> +
>> +	/* Propagate changes to the userspace mapping. */
>> +	perf_event_update_userpage(event);
>> +
>> +out:
>> +	return err;
>> +}
> 
> [...]
> 
>> +static inline int mpidr_to_cpu(u32 mpidr)
>> +{
>> +	return MPIDR_AFFINITY_LEVEL(mpidr, 0) |
>> +		(MPIDR_AFFINITY_LEVEL(mpidr, 1) << mpidr_affl1_shift);
>> +}
> 
> I don't follow the logic here.
> 
> What exactly are you trying to get? What space does the result exist in?
> It's neither the Linux logical ID nor the physical ID.
> 

It's the physical CPU number, constructed out of the MPIDR.AFFL1 (cluster number)
and AFFL0 (CPU number within the cluster).

The goal is to get a list of logical CPUs associated with each slice. As mentioned
above, because of partial goods processing the only way to know this is to involve
the physical id of each CPU from cpu_logical_map().

An alternative way to process this would be to find each logical CPU where its
cluster (MPIDR_AFFINITY_LEVEL( ,1)) matches the slice number from firmware.
This would remove the need for AFFL0, affl1_shift and the num_cpus_in_cluster
property, at the expense of searching every logical cpu per slice.
And that may be a better approach?

>> +
>> +static int get_logical_cpu_index(int phys_cpu)
>> +{
>> +	int cpu;
>> +
>> +	for (cpu = 0; cpu < nr_cpu_ids; cpu++)
>> +		if (mpidr_to_cpu(cpu_logical_map(cpu)) == phys_cpu)
>> +			return cpu;
>> +	return -EINVAL;
>> +}
> 
> As above, I really don't follow this.
> 
> What exactly is phys_cpu?
> 
>> +static int l2_cache_pmu_probe_slice(struct device *dev, void *data)
>> +{
>> +	struct platform_device *pdev = to_platform_device(dev->parent);
>> +	struct platform_device *sdev = to_platform_device(dev);
>> +	struct l2cache_pmu *l2cache_pmu = data;
>> +	struct hml2_pmu *slice;
>> +	struct cpumask affinity_mask;
>> +	struct acpi_device *device;
>> +	int irq, err;
>> +	int phys_cpu, logical_cpu;
>> +	int i;
>> +	unsigned long instance;
>> +
>> +	if (acpi_bus_get_device(ACPI_HANDLE(dev), &device))
>> +		return -ENODEV;
>> +
>> +	if (kstrtol(device->pnp.unique_id, 10, &instance) < 0) {
>> +		pr_err("unable to read ACPI uid\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	irq = platform_get_irq(sdev, 0);
>> +	if (irq < 0) {
>> +		dev_err(&pdev->dev,
>> +			"Failed to get valid irq for slice %ld\n", instance);
>> +		return irq;
>> +	}
>> +
>> +	slice = devm_kzalloc(&pdev->dev, sizeof(*slice), GFP_KERNEL);
>> +	if (!slice)
>> +		return -ENOMEM;
>> +
>> +	cpumask_clear(&affinity_mask);
>> +	slice->on_cpu = -1;
>> +
>> +	for (i = 0; i < num_cpus_in_cluster; i++) {
>> +		phys_cpu = instance * num_cpus_in_cluster + i;
>> +		logical_cpu = get_logical_cpu_index(phys_cpu);
>> +		if (logical_cpu >= 0) {
>> +			slice->cpu[slice->valid_cpus++] = logical_cpu;
>> +			per_cpu(cpu_to_pmu, logical_cpu) = slice;
>> +			cpumask_set_cpu(logical_cpu, &affinity_mask);
>> +		}
>> +	}
> 
> Please, get a better, explicit, description of CPU affinity, rather than
> depending on a fragile unique ID and an arbitrary MPIDR decomposition
> scheme.
> 
>> +
>> +	if (slice->valid_cpus == 0) {
>> +		dev_err(&pdev->dev, "No CPUs found for L2 cache instance %ld\n",
>> +			instance);
>> +		return -ENODEV;
>> +	}
>> +
>> +	if (irq_set_affinity(irq, &affinity_mask)) {
>> +		dev_err(&pdev->dev,
>> +			"Unable to set irq affinity (irq=%d, first cpu=%d)\n",
>> +			irq, slice->cpu[0]);
>> +		return -ENODEV;
>> +	}
> 
> I didn't spot any CPU notifier. Consider hotplug and the automigration
> of IRQs.
> 

I'll add the notifier

>> +
>> +	err = devm_request_irq(
>> +		&pdev->dev, irq, l2_cache__handle_irq,
>> +		IRQF_NOBALANCING, "l2-cache-pmu", slice);
>> +	if (err) {
>> +		dev_err(&pdev->dev,
>> +			"Unable to request IRQ%d for L2 PMU counters\n",
>> +			irq);
>> +		return err;
>> +	}
>> +
>> +	dev_info(&pdev->dev, "Registered L2 cache PMU instance %ld with %d CPUs\n",
>> +		 instance, slice->valid_cpus);
>> +
>> +	slice->pmu_lock = __SPIN_LOCK_UNLOCKED(slice->pmu_lock);
>> +
>> +	hml2_pmu__init(slice);
>> +	list_add(&slice->entry, &l2cache_pmu->pmus);
>> +	l2cache_pmu->num_pmus++;
>> +
>> +	return 0;
>> +}
>> +
>> +static int l2_cache_pmu_probe(struct platform_device *pdev)
>> +{
>> +	int result;
>> +	int err;
>> +
>> +	INIT_LIST_HEAD(&l2cache_pmu.pmus);
>> +
>> +	l2cache_pmu.pmu = (struct pmu) {
>> +		.name		= "l2cache",
>> +		.pmu_enable	= l2_cache__pmu_enable,
>> +		.pmu_disable	= l2_cache__pmu_disable,
>> +		.event_init	= l2_cache__event_init,
>> +		.add		= l2_cache__event_add,
>> +		.del		= l2_cache__event_del,
>> +		.start		= l2_cache__event_start,
>> +		.stop		= l2_cache__event_stop,
>> +		.read		= l2_cache__event_read,
>> +		.attr_groups	= l2_cache_pmu_attr_grps,
>> +	};
>> +
>> +	l2cache_pmu.num_counters = get_num_counters();
>> +	l2_cycle_ctr_idx = l2cache_pmu.num_counters - 1;
>> +	l2_reset_mask = ((1 << (l2cache_pmu.num_counters - 1)) - 1) |
>> +		L2PM_CC_ENABLE;
>> +
>> +	err = device_property_read_u32(&pdev->dev, "qcom,num-cpus-in-cluster",
>> +				       &num_cpus_in_cluster);
> 
> This really is not a property of the L2. It's a larger topological
> detail.
> 
> Describe the CPU affinity explicitly rather than trying to hackishly
> build it up from myriad sources.
> 
>> +	if (err) {
>> +		dev_err(&pdev->dev, "Failed to read number of cpus in cluster\n");
>> +		return err;
>> +	}
>> +	mpidr_affl1_shift = hweight8(num_cpus_in_cluster - 1);
>> +
>> +	/* Read slice info and initialize each slice */
>> +	result = device_for_each_child(&pdev->dev, &l2cache_pmu,
>> +				       l2_cache_pmu_probe_slice);
>> +
>> +	if (result < 0)
>> +		return -ENODEV;
>> +
>> +	if (l2cache_pmu.num_pmus == 0) {
>> +		dev_err(&pdev->dev, "No hardware L2 PMUs found\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	result = perf_pmu_register(&l2cache_pmu.pmu,
>> +				   l2cache_pmu.pmu.name, -1);
>> +
> 
> May you have multiple sockets? You propbably want an instance ID on the
> PMU name.
> 

This is just a single socket implementation.

> Thanks,
> Mark.
> 

Neil

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
