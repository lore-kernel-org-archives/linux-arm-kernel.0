From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 1 Sep 2016 17:30:52 +0100
Subject: [PATCH v4 2/2] soc: qcom: add l2 cache perf events driver
In-Reply-To: <1472576493-26382-3-git-send-email-nleeder@codeaurora.org>
References: <1472576493-26382-1-git-send-email-nleeder@codeaurora.org>
 <1472576493-26382-3-git-send-email-nleeder@codeaurora.org>
Message-ID: <20160901163051.GA6731@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

On Tue, Aug 30, 2016 at 01:01:33PM -0400, Neil Leeder wrote:
> Adds perf events support for L2 cache PMU.
> 
> The L2 cache PMU driver is named 'l2cache_0' and can be used
> with perf events to profile L2 events such as cache hits
> and misses.
> 
> Signed-off-by: Neil Leeder <nleeder@codeaurora.org>
> ---
>  drivers/soc/qcom/Kconfig               |  10 +
>  drivers/soc/qcom/Makefile              |   1 +
>  drivers/soc/qcom/perf_event_l2.c       | 855 +++++++++++++++++++++++++++++++++
>  include/linux/cpuhotplug.h             |   1 +
>  include/linux/soc/qcom/perf_event_l2.h |  79 +++

Unless you have another user of perf_event_l2.h, please fold that into
perf_event_l2.c. Nothing is gained by having that separate.

If you do have another user of that, please describe that. Given the
values are HW constants I can't imagine what else would be using that.

>  5 files changed, 946 insertions(+)
>  create mode 100644 drivers/soc/qcom/perf_event_l2.c
>  create mode 100644 include/linux/soc/qcom/perf_event_l2.h
> 
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index ddd6b71..7e71d8d 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -16,6 +16,16 @@ config QCOM_L2_ACCESSORS
>  	  Provides support for accessing registers in the L2 cache
>  	  for Qualcomm Technologies ARM64 chips.
>  
> +config QCOM_PERF_EVENTS_L2
> +	bool "Qualcomm Technologies L2-cache perf events"
> +	depends on ARCH_QCOM && ARM64 && HW_PERF_EVENTS && ACPI
> +	select QCOM_L2_ACCESSORS

As with prior postings, I think it makes sense to fold the accessors
from patch 1 in also. They can be factored out if and when a subsequent
patch series adds another user.

> +	  help
> +	  Provides support for the L2 cache performance monitor unit (PMU)
> +	  in Qualcomm Technologies processors.
> +	  Adds the L2 cache PMU into the perf events subsystem for
> +	  monitoring L2 cache events.
> +
>  config QCOM_PM
>  	bool "Qualcomm Power Management"
>  	depends on ARCH_QCOM && !ARM64
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index 6ef29b9..c8e89ca9 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -1,5 +1,6 @@
>  obj-$(CONFIG_QCOM_GSBI)	+=	qcom_gsbi.o
>  obj-$(CONFIG_QCOM_L2_ACCESSORS) += l2-accessors.o
> +obj-$(CONFIG_QCOM_PERF_EVENTS_L2)	+= perf_event_l2.o
>  obj-$(CONFIG_QCOM_PM)	+=	spm.o
>  obj-$(CONFIG_QCOM_SMD) +=	smd.o
>  obj-$(CONFIG_QCOM_SMD_RPM)	+= smd-rpm.o
> diff --git a/drivers/soc/qcom/perf_event_l2.c b/drivers/soc/qcom/perf_event_l2.c
> new file mode 100644
> index 0000000..5c13e87
> --- /dev/null
> +++ b/drivers/soc/qcom/perf_event_l2.c
> @@ -0,0 +1,855 @@
> +/* Copyright (c) 2015,2016 The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +#define pr_fmt(fmt) "l2 perfevents: " fmt

There are no printk uses in the file, so this can go.

Otherwise, it'd be worth using "qcom-l2", or better, drop the above and
use dev_printk and friends.

> +
> +#include <linux/acpi.h>
> +#include <linux/interrupt.h>
> +#include <linux/perf_event.h>
> +#include <linux/platform_device.h>
> +#include <linux/soc/qcom/l2-accessors.h>
> +#include <linux/soc/qcom/perf_event_l2.h>
> +
> +/*
> + * Aggregate PMU. Implements the core pmu functions and manages
> + * the hardware PMUs.
> + */
> +struct l2cache_pmu {
> +	struct list_head entry;
> +	u32 num_pmus;
> +	struct pmu pmu;
> +	int num_counters;
> +	cpumask_t cpumask;
> +	struct platform_device *pdev;
> +};
> +
> +/*
> + * The cache is made-up of one or more slices, each slice has its own PMU.
> + * This structure represents one of the hardware PMUs.
> + */

I realise that this is ground we've covered before, but I'm rather fuzzy
on the slice details, which makes this very difficult to review, and
will make it very difficult to come back to in future.

It would be helpful if you could expand the block comment above to
elaborate a little further on the HW design, and the concepts you are
trying to capture above.

Specifically:
- How do slices relate to CPUs? 1-1, M-N, or somewhere between?
- What are groups? What are columns? How do they relate to counters?

> +struct hml2_pmu {
> +	struct perf_event *events[MAX_L2_CTRS];
> +	struct l2cache_pmu *l2cache_pmu;
> +	unsigned long used_mask[BITS_TO_LONGS(MAX_L2_CTRS)];
> +	unsigned long group_used_mask[BITS_TO_LONGS(L2_EVT_GROUP_MAX + 1)];

Please use DECLARE_BITMAP. Also, the "used_mask" name is ambiguous, so I
would recommend "used_counters", and likewise "used_groups" instead of
group_used_mask. e.g.

	DECLARE_BITMAP(used_counters, MAX_L2_CTRS);
	DECLARE_BITMAP(used_groups, L2_EVT_GROUP_MAX + 1);

> +	int group_to_counter[L2_EVT_GROUP_MAX + 1];
> +	int irq;
> +	/* The CPU that is used for collecting events on this slice */
> +	int on_cpu;
> +	/* All the CPUs associated with this slice */
> +	cpumask_t slice_cpus;
> +	atomic64_t prev_count[MAX_L2_CTRS];

Use the hw_perf_event field for this. See struct perf_event::hw and
struct hw_perf_event.

> +	spinlock_t pmu_lock;
> +};
> +
> +#define to_l2cache_pmu(p) (container_of(p, struct l2cache_pmu, pmu))
> +
> +static DEFINE_MUTEX(l2cache_pmu_mutex);


A mutex (which can sleep) is not safe for the hotplug state machine
stuff. See recent patches to the arm_pmu code.

That's further subsumed by the multi-instance stuff, so this (and the
list) will not be necessary shortly.

> +static LIST_HEAD(l2cache_pmu_list);
> +static DEFINE_PER_CPU(struct hml2_pmu *, cpu_to_pmu);

Typically, per-cpu variables are named after what the variable holds,
ignoring the fact that it's per-cpu. The naming here makes it sound like
each per-cpu instances holds a CPU -> PMU mapping, which is not the
case.

I would recommend:

static DEFINE_PER_CPU(struct hml2_pmu *, pmu_slice);

> +static u32 l2_cycle_ctr_idx;
> +static u32 l2_reset_mask;
> +
> +static inline u32 idx_to_reg_bit(u32 idx)
> +{
> +	u32 bit;
> +
> +	if (idx == l2_cycle_ctr_idx)
> +		bit = BIT(L2CYCLE_CTR_BIT);
> +	else
> +		bit = BIT(idx);
> +	return bit;
> +}

This can be:

static inline u32 idx_to_reg_bit(u32 idx)
{
	if (idx == l2_cycle_ctr_idx);
		return BIT(L2CYCLE_CTR_BIT);
	
	return BIT(idx);
}

> +
> +static inline struct hml2_pmu *get_hml2_pmu(int cpu)
> +{
> +	return per_cpu(cpu_to_pmu, cpu);
> +}
> +
> +static void hml2_pmu__reset_on_slice(void *x)
> +{
> +	/* Reset all ctrs */
> +	set_l2_indirect_reg(L2PMCR, L2PMCR_RESET_ALL);
> +	set_l2_indirect_reg(L2PMCNTENCLR, l2_reset_mask);
> +	set_l2_indirect_reg(L2PMINTENCLR, l2_reset_mask);
> +	set_l2_indirect_reg(L2PMOVSCLR, l2_reset_mask);
> +}
> +
> +static inline void hml2_pmu__reset(struct hml2_pmu *slice)
> +{
> +	int cpu;
> +
> +	if (cpumask_test_cpu(smp_processor_id(), &slice->slice_cpus)) {
> +		hml2_pmu__reset_on_slice(NULL);
> +		return;
> +	}
> +
> +	/* Call each cpu in the cluster until one works */
> +	for_each_cpu(cpu, &slice->slice_cpus) {
> +		if (!smp_call_function_single(cpu, hml2_pmu__reset_on_slice,
> +					      NULL, 1))
> +			return;
> +	}

Homebrew smp_call_function_any()? I think the above can be replaces
with:

	cpumask_t *mask = &slice->slice_cpus;

	if (!smp_call_function_any(mask, hml2_pmu__reset_on_slice, NULL))
		return;

> +
> +	dev_err(&slice->l2cache_pmu->pdev->dev,
> +		"Failed to reset on cluster with cpu %d\n",
> +		cpumask_first(&slice->slice_cpus));
> +}
> +
> +static inline void hml2_pmu__enable(void)
> +{
> +	set_l2_indirect_reg(L2PMCR, L2PMCR_GLOBAL_ENABLE);
> +}
> +
> +static inline void hml2_pmu__disable(void)
> +{
> +	set_l2_indirect_reg(L2PMCR, L2PMCR_GLOBAL_DISABLE);
> +}

Are these per-slice, or shared across slices?

I had assumed everything prefixed with hml2_pmu was per-slice, but the
GLOBAL naming, and the use below in l2_cache__pmu_{enable,disable}
implies that's not the case here.

> +
> +static inline void hml2_pmu__counter_set_value(u32 idx, u64 value)
> +{
> +	u32 counter_reg;
> +
> +	if (idx == l2_cycle_ctr_idx) {
> +		set_l2_indirect_reg(L2PMCCNTR, value);
> +	} else {
> +		counter_reg = (idx * IA_L2_REG_OFFSET) + IA_L2PMXEVCNTR_BASE;
> +		set_l2_indirect_reg(counter_reg, (u32)(value & GENMASK(31, 0)));

You shouldn't need the u32 cast here.

> +	}
> +}
> +
> +static inline u64 hml2_pmu__counter_get_value(u32 idx)
> +{
> +	u64 value;
> +	u32 counter_reg;
> +
> +	if (idx == l2_cycle_ctr_idx) {
> +		value = get_l2_indirect_reg(L2PMCCNTR);
> +	} else {
> +		counter_reg = (idx * IA_L2_REG_OFFSET) + IA_L2PMXEVCNTR_BASE;
> +		value = get_l2_indirect_reg(counter_reg);
> +	}
> +
> +	return value;
> +}
> +
> +static inline void hml2_pmu__counter_enable(u32 idx)
> +{
> +	u32 reg;
> +
> +	reg = get_l2_indirect_reg(L2PMCNTENSET);
> +	reg |= idx_to_reg_bit(idx);
> +	set_l2_indirect_reg(L2PMCNTENSET, reg);
> +

Just to check, given you have separate SET and CLR registers, do you
actually need a RMW sequence here? Does wirintg a zero to a field in the
SET register actually clear it?

> +}
> +static inline void hml2_pmu__counter_disable(u32 idx)
> +{
> +	set_l2_indirect_reg(L2PMCNTENCLR, idx_to_reg_bit(idx));
> +}
> +
> +static inline void hml2_pmu__counter_enable_interrupt(u32 idx)
> +{
> +	u32 reg;
> +
> +	reg = get_l2_indirect_reg(L2PMINTENSET);
> +	reg |= idx_to_reg_bit(idx);
> +	set_l2_indirect_reg(L2PMINTENSET, reg);
> +}

Likewise?

> +static inline void hml2_pmu__counter_disable_interrupt(u32 idx)
> +{
> +	set_l2_indirect_reg(L2PMINTENCLR, idx_to_reg_bit(idx));
> +}
> +
> +static inline void hml2_pmu__set_evcntcr(u32 ctr, u32 val)
> +{
> +	u32 evtcr_reg = (ctr * IA_L2_REG_OFFSET) + IA_L2PMXEVCNTCR_BASE;
> +
> +	set_l2_indirect_reg(evtcr_reg, val);
> +}
> +
> +static inline void hml2_pmu__set_evtyper(u32 ctr, u32 val)
> +{
> +	u32 evtype_reg = (ctr * IA_L2_REG_OFFSET) + IA_L2PMXEVTYPER_BASE;
> +
> +	set_l2_indirect_reg(evtype_reg, val);
> +}
> +
> +static void hml2_pmu__set_resr(struct hml2_pmu *slice,
> +			       u32 event_group, u32 event_cc)
> +{
> +	u64 field;
> +	u64 resr_val;
> +	u32 shift;
> +	unsigned long iflags;

Nit: s/iflags/flags/ for consistency

[mark at leverpostej:~/src/linux]% git grep irqsave | grep ',\s*flags)' | wc -l
15074
[mark at leverpostej:~/src/linux]% git grep irqsave | grep ',\s*iflags)' | wc -l
106

> +
> +	shift = L2PMRESR_GROUP_BITS * event_group;
> +	field = ((u64)(event_cc & L2PMRESR_GROUP_MASK) << shift) | L2PMRESR_EN;
> +
> +	spin_lock_irqsave(&slice->pmu_lock, iflags);
> +
> +	resr_val = get_l2_indirect_reg(L2PMRESR);
> +	resr_val &= ~(L2PMRESR_GROUP_MASK << shift);
> +	resr_val |= field;
> +	set_l2_indirect_reg(L2PMRESR, resr_val);
> +
> +	spin_unlock_irqrestore(&slice->pmu_lock, iflags);
> +}
> +
> +static inline void hml2_pmu__set_evfilter_sys_mode(u32 ctr)
> +{
> +	set_l2_indirect_reg((ctr * IA_L2_REG_OFFSET) + IA_L2PMXEVFILTER_BASE,
> +			    L2PMXEVFILTER_SUFILTER_ALL |
> +			    L2PMXEVFILTER_ORGFILTER_IDINDEP |
> +			    L2PMXEVFILTER_ORGFILTER_ALL);
> +}

This is painful to read. Please use temporary variables for the two
parameters.

What are these filters?

> +
> +static inline u32 hml2_pmu__getreset_ovsr(void)
> +{
> +	u32 result = get_l2_indirect_reg(L2PMOVSSET);
> +
> +	set_l2_indirect_reg(L2PMOVSCLR, result);
> +	return result;
> +}
> +
> +static inline bool hml2_pmu__has_overflowed(u32 ovsr)
> +{
> +	return !!(ovsr & l2_reset_mask);
> +}

It took me a moment to figure out what was happening here.

l2_reset_mask is the mask of counters actually present, right?

Please rename it to something that doesn't imply it's specific to reset.

If a counter isn't implemented, is its bit zero, one, or unknown?

> +static inline bool hml2_pmu__counter_has_overflowed(u32 ovsr, u32 idx)
> +{
> +	return !!(ovsr & idx_to_reg_bit(idx));
> +}
> +
> +static void l2_cache__event_update_from_slice(struct perf_event *event,
> +					      struct hml2_pmu *slice)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	u64 delta64, prev, now;
> +	u32 delta;
> +	u32 idx = hwc->idx;
> +
> +	do {
> +		prev = atomic64_read(&slice->prev_count[idx]);
> +		now = hml2_pmu__counter_get_value(idx);
> +	} while (atomic64_cmpxchg(&slice->prev_count[idx], prev, now) != prev);
> +

As covered above, use hwc->prev_count.

> +	if (idx == l2_cycle_ctr_idx) {
> +		/*
> +		 * The cycle counter is 64-bit so needs separate handling
> +		 * of 64-bit delta.
> +		 */
> +		delta64 = now - prev;
> +		local64_add(delta64, &event->count);
> +	} else {
> +		/*
> +		 * 32-bit counters need the unsigned 32-bit math to handle
> +		 * overflow and now < prev
> +		 */
> +		delta = now - prev;
> +		local64_add(delta, &event->count);
> +	}
> +}
> +
> +static void l2_cache__slice_set_period(struct hml2_pmu *slice,
> +				       struct hw_perf_event *hwc)
> +{
> +	u64 value = L2_MAX_PERIOD - (L2_CNT_PERIOD - 1);
> +	u32 idx = hwc->idx;
> +	u64 prev = atomic64_read(&slice->prev_count[idx]);

Use hwc->prev_count.

> +
> +	if (prev < value) {
> +		value += prev;
> +		atomic64_set(&slice->prev_count[idx], value);
> +	} else {
> +		value = prev;
> +	}

I don't follow this. Surely you need to update the prev_count in either
case? Otherwise subsequent updates are going to give you erroneous
numbers.

> +
> +	hml2_pmu__counter_set_value(idx, value);
> +}
> +
> +static int l2_cache__get_event_idx(struct hml2_pmu *slice,
> +				   struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	int idx;
> +
> +	if (hwc->config_base == L2CYCLE_CTR_RAW_CODE) {
> +		if (test_and_set_bit(l2_cycle_ctr_idx, slice->used_mask))
> +			return -EAGAIN;
> +
> +		return l2_cycle_ctr_idx;
> +	}
> +
> +	for (idx = 0; idx < slice->l2cache_pmu->num_counters - 1; idx++) {
> +		if (!test_and_set_bit(idx, slice->used_mask)) {
> +			set_bit(L2_EVT_GROUP(hwc->config_base),
> +				slice->group_used_mask);

Can't the group already be taken by another event?

> +			return idx;
> +		}
> +	}
> +
> +	/* The counters are all in use. */
> +	return -EAGAIN;
> +}
> +
> +static void l2_cache__clear_event_idx(struct hml2_pmu *slice,
> +				      struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	clear_bit(L2_EVT_GROUP(hwc->config_base), slice->group_used_mask);
> +}

What about used_mask? Shouldn't this mirror l2_cache__get_event_idx?

> +
> +static irqreturn_t l2_cache__handle_irq(int irq_num, void *data)
> +{
> +	struct hml2_pmu *slice = data;
> +	u32 ovsr;
> +	int idx;
> +
> +	ovsr = hml2_pmu__getreset_ovsr();
> +	if (!hml2_pmu__has_overflowed(ovsr))
> +		return IRQ_NONE;
> +
> +	for (idx = 0; idx < slice->l2cache_pmu->num_counters; idx++) {

Can't you use for_each_set_bit over the used_mask?

> +		struct perf_event *event = slice->events[idx];
> +		struct hw_perf_event *hwc;
> +
> +		if (!event)
> +			continue;

Then so long as we're careful with the mask manipulation we can remove
this check.

> +
> +		if (!hml2_pmu__counter_has_overflowed(ovsr, idx))
> +			continue;
> +
> +		l2_cache__event_update_from_slice(event, slice);
> +		hwc = &event->hw;
> +
> +		l2_cache__slice_set_period(slice, hwc);
> +	}
> +
> +	/*
> +	 * Handle the pending perf events.
> +	 *
> +	 * Note: this call *must* be run with interrupts disabled. For
> +	 * platforms that can have the PMU interrupts raised as an NMI, this
> +	 * will not work.
> +	 */

Please remove the last sentence, as we do not have an NMI.

> +	irq_work_run();

Do we ever have any work to run? I thought that only happened in the
case of an overflow event when sampling, which isn't possible here...

> +
> +	return IRQ_HANDLED;
> +}
> +
> +/*
> + * Implementation of abstract pmu functionality required by
> + * the core perf events code.
> + */
> +
> +static void l2_cache__pmu_enable(struct pmu *pmu)
> +{
> +	hml2_pmu__enable();
> +}
> +
> +static void l2_cache__pmu_disable(struct pmu *pmu)
> +{
> +	hml2_pmu__disable();
> +}
> +
> +static int l2_cache__event_init(struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct hml2_pmu *slice;
> +	struct perf_event *sibling;
> +	struct l2cache_pmu *l2cache_pmu = to_l2cache_pmu(event->pmu);

Defer this until after the type check. You don't know it's an
l2cache_pmu yet.

> +
> +	if (event->attr.type != l2cache_pmu->pmu.type)
> +		return -ENOENT;
> +
> +	if (hwc->sample_period) {
> +		dev_warn(&l2cache_pmu->pdev->dev, "Sampling not supported\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (event->cpu < 0) {
> +		dev_warn(&l2cache_pmu->pdev->dev, "Per-task mode not supported\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	/* We cannot filter accurately so we just don't allow it. */
> +	if (event->attr.exclude_user || event->attr.exclude_kernel ||
> +	    event->attr.exclude_hv || event->attr.exclude_idle) {
> +		dev_warn(&l2cache_pmu->pdev->dev, "Can't exclude execution levels\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (((L2_EVT_GROUP(event->attr.config) > L2_EVT_GROUP_MAX) ||
> +	    (L2_EVT_PREFIX(event->attr.config) != 0) ||
> +	    (L2_EVT_REG(event->attr.config) != 0)) &&
> +	    (event->attr.config != L2CYCLE_CTR_RAW_CODE)) {
> +		dev_warn(&l2cache_pmu->pdev->dev, "Invalid config %llx\n",
> +			 event->attr.config);
> +		return -EINVAL;
> +	}
> +
> +	/* Don't allow groups with mixed PMUs, except for s/w events */
> +	if (event->group_leader->pmu != event->pmu &&
> +	    !is_software_event(event->group_leader)) {
> +		dev_warn(&l2cache_pmu->pdev->dev,
> +			 "Can't create mixed PMU group\n");
> +		return -EINVAL;
> +	}
> +
> +	list_for_each_entry(sibling, &event->group_leader->sibling_list,
> +			    group_entry)
> +		if (sibling->pmu != event->pmu &&
> +		    !is_software_event(sibling)) {
> +			dev_warn(&l2cache_pmu->pdev->dev,
> +				 "Can't create mixed PMU group\n");
> +			return -EINVAL;
> +		}
> +
> +	hwc->idx = -1;
> +	hwc->config_base = event->attr.config;
> +
> +	/*
> +	 * Ensure all events are on the same cpu so all events are in the
> +	 * same cpu context, to avoid races on pmu_enable etc.
> +	 */
> +	slice = get_hml2_pmu(event->cpu);
> +	event->cpu = slice->on_cpu;

This could put an event on a different CPU to its group siblings, which
is broken.

> +
> +	return 0;
> +}
> +
> +static void l2_cache__event_update(struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	if (hwc->idx < 0)
> +		return;

When does this happen?

> +
> +	l2_cache__event_update_from_slice(event, get_hml2_pmu(event->cpu));
> +}
> +
> +static void l2_cache__event_start(struct perf_event *event, int flags)
> +{
> +	struct hml2_pmu *slice;
> +	struct hw_perf_event *hwc = &event->hw;
> +	int idx = hwc->idx;
> +	u32 config;
> +	u32 evt_prefix, event_cc, event_group;
> +
> +	if (idx < 0)
> +		return;

When does this happen?

> +
> +	hwc->state = 0;
> +
> +	slice = get_hml2_pmu(event->cpu);
> +	l2_cache__slice_set_period(slice, hwc);
> +
> +	if (hwc->config_base == L2CYCLE_CTR_RAW_CODE)
> +		goto out;

Why?

You can't reset or program the cycle counter value?

> +
> +	config = hwc->config_base;
> +	evt_prefix  = L2_EVT_PREFIX(config);
> +	event_cc    = L2_EVT_CODE(config);
> +	event_group = L2_EVT_GROUP(config);
> +
> +	hml2_pmu__set_evcntcr(idx, 0x0);
> +	hml2_pmu__set_evtyper(idx, event_group);
> +	hml2_pmu__set_resr(slice, event_group, event_cc);
> +	hml2_pmu__set_evfilter_sys_mode(idx);
> +out:
> +	hml2_pmu__counter_enable_interrupt(idx);
> +	hml2_pmu__counter_enable(idx);
> +}
> +
> +static void l2_cache__event_stop(struct perf_event *event, int flags)
> +{
> +	struct hml2_pmu *slice;
> +	struct hw_perf_event *hwc = &event->hw;
> +	int idx = hwc->idx;
> +
> +	if (idx < 0)
> +		return;

When does this happen?

> +
> +	if (!(hwc->state & PERF_HES_STOPPED)) {
> +		slice = get_hml2_pmu(event->cpu);
> +		hml2_pmu__counter_disable_interrupt(idx);
> +		hml2_pmu__counter_disable(idx);
> +
> +		if (flags & PERF_EF_UPDATE)
> +			l2_cache__event_update(event);
> +		hwc->state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
> +	}
> +}

[...]

> +static void l2_cache__event_del(struct perf_event *event, int flags)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct hml2_pmu *slice;
> +	int idx = hwc->idx;
> +
> +	if (idx < 0)
> +		return;

When does this happen?

> +
> +	slice = get_hml2_pmu(event->cpu);
> +	l2_cache__event_stop(event, flags | PERF_EF_UPDATE);
> +	slice->events[idx] = NULL;
> +	clear_bit(idx, slice->used_mask);
> +	l2_cache__clear_event_idx(slice, event);
> +
> +	perf_event_update_userpage(event);
> +}

[...]

> +static int l2cache_pmu_online_cpu(unsigned int cpu)
> +{
> +	struct hml2_pmu *slice;
> +	struct l2cache_pmu *l2cache_pmu;
> +	cpumask_t slice_online_cpus;
> +
> +	mutex_lock(&l2cache_pmu_mutex);

As I mentioned above, using a mutex here is not safe, as it can sleep,
and will be called in a context where that is not permitted.

> +	list_for_each_entry(l2cache_pmu, &l2cache_pmu_list, entry) {
> +		slice = get_hml2_pmu(cpu);
> +		cpumask_and(&slice_online_cpus, &slice->slice_cpus,
> +			    cpu_online_mask);
> +		if (cpumask_weight(&slice_online_cpus) == 1) {
> +			/* all CPUs on this slice were down, use this one */
> +			slice->on_cpu = cpu;
> +			cpumask_set_cpu(cpu, &l2cache_pmu->cpumask);
> +			WARN_ON(irq_set_affinity(slice->irq, cpumask_of(cpu)));
> +		}

Please split this up with some newlines.

> +	}
> +	mutex_unlock(&l2cache_pmu_mutex);
> +
> +	return 0;
> +}
> +
> +static int l2cache_pmu_offline_cpu(unsigned int cpu)
> +{
> +	struct hml2_pmu *slice;
> +	struct l2cache_pmu *l2cache_pmu;
> +	cpumask_t slice_online_cpus;
> +	unsigned int target;
> +
> +	mutex_lock(&l2cache_pmu_mutex);
> +	list_for_each_entry(l2cache_pmu, &l2cache_pmu_list, entry) {
> +		if (!cpumask_test_and_clear_cpu(cpu, &l2cache_pmu->cpumask))
> +			break;

Shouldn't that be a continue, so we check the other PMUs in the list?

> +		slice = get_hml2_pmu(cpu);
> +		cpumask_and(&slice_online_cpus, &slice->slice_cpus,
> +			    cpu_online_mask);
> +		/* Any other CPU for this slice which is still online */
> +		target = cpumask_any_but(&slice_online_cpus, cpu);
> +		if (target >= nr_cpu_ids)
> +			break;
> +		perf_pmu_migrate_context(&l2cache_pmu->pmu, cpu, target);
> +		slice->on_cpu = target;
> +		cpumask_set_cpu(target, &l2cache_pmu->cpumask);
> +		WARN_ON(irq_set_affinity(slice->irq, cpumask_of(target)));

Please try to split this up with newlines to make it more legible.

> +	}
> +	mutex_unlock(&l2cache_pmu_mutex);
> +
> +	return 0;
> +}
> +
> +static int l2_cache_pmu_probe_slice(struct device *dev, void *data)
> +{
> +	struct platform_device *pdev = to_platform_device(dev->parent);
> +	struct platform_device *sdev = to_platform_device(dev);
> +	struct l2cache_pmu *l2cache_pmu = data;
> +	struct hml2_pmu *slice;
> +	struct acpi_device *device;
> +	int irq;
> +	int err;
> +	int logical_cpu;
> +	unsigned long fw_slice_id;
> +
> +	if (acpi_bus_get_device(ACPI_HANDLE(dev), &device))
> +		return -ENODEV;
> +
> +	if (kstrtol(device->pnp.unique_id, 10, &fw_slice_id) < 0) {
> +		dev_err(&pdev->dev, "unable to read ACPI uid\n");
> +		return -ENODEV;
> +	}
> +
> +	irq = platform_get_irq(sdev, 0);
> +	if (irq < 0) {
> +		dev_err(&pdev->dev,
> +			"Failed to get valid irq for slice %ld\n", fw_slice_id);
> +		return irq;
> +	}
> +
> +	slice = devm_kzalloc(&pdev->dev, sizeof(*slice), GFP_KERNEL);
> +	if (!slice)
> +		return -ENOMEM;
> +
> +	slice->l2cache_pmu = l2cache_pmu;
> +	for_each_present_cpu(logical_cpu) {
> +		if (topology_physical_package_id(logical_cpu) == fw_slice_id) {
> +			cpumask_set_cpu(logical_cpu, &slice->slice_cpus);
> +			per_cpu(cpu_to_pmu, logical_cpu) = slice;
> +		}
> +	}
> +	slice->irq = irq;
> +
> +	if (cpumask_empty(&slice->slice_cpus)) {
> +		dev_err(&pdev->dev, "No CPUs found for L2 cache instance %ld\n",
> +			fw_slice_id);
> +		return -ENODEV;
> +	}
> +
> +	/* Pick one CPU to be the preferred one to use in the slice */
> +	slice->on_cpu = cpumask_first(&slice->slice_cpus);
> +
> +	if (irq_set_affinity(irq, cpumask_of(slice->on_cpu))) {
> +		dev_err(&pdev->dev,
> +			"Unable to set irq affinity (irq=%d, cpu=%d)\n",
> +			irq, slice->on_cpu);
> +		return -ENODEV;
> +	}
> +
> +	err = devm_request_irq(
> +		&pdev->dev, irq, l2_cache__handle_irq,
> +		IRQF_NOBALANCING, "l2-cache-pmu", slice);

Unusual formatting.

> +	if (err) {
> +		dev_err(&pdev->dev,
> +			"Unable to request IRQ%d for L2 PMU counters\n",
> +			irq);
> +		return err;
> +	}
> +
> +	dev_info(&pdev->dev,
> +		 "Registered L2 cache PMU instance %ld with %d CPUs\n",
> +		 fw_slice_id, cpumask_weight(&slice->slice_cpus));
> +
> +	slice->pmu_lock = __SPIN_LOCK_UNLOCKED(slice->pmu_lock);
> +	cpumask_set_cpu(slice->on_cpu, &l2cache_pmu->cpumask);
> +
> +	hml2_pmu__reset(slice);
> +	l2cache_pmu->num_pmus++;
> +
> +	return 0;
> +}

Thanks,
Mark.
