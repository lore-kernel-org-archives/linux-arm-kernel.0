From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 3 Mar 2017 14:50:41 +0000
Subject: [PATCH V3] perf: qcom: Add L3 cache PMU driver
In-Reply-To: <1488488312-6294-1-git-send-email-agustinv@codeaurora.org>
References: <1488488312-6294-1-git-send-email-agustinv@codeaurora.org>
Message-ID: <20170303145040.GB12945@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Augustin,

On Thu, Mar 02, 2017 at 03:58:32PM -0500, Agustin Vega-Frias wrote:
> This adds a new dynamic PMU to the Perf Events framework to program
> and control the L3 cache PMUs in some Qualcomm Technologies SOCs.
> 
> The driver supports a distributed cache architecture where the overall
> cache for a socket is comprised of multiple slices each with its own PMU.
> Access to each individual PMU is provided even though all CPUs share all
> the slices. User space needs to aggregate to individual counts to provide
> a global picture.
>
> The driver exports formatting and event information to sysfs so it can
> be used by the perf user space tools with the syntaxes:
>    perf stat -a -e l3cache_0_0/read-miss/
>    perf stat -a -e l3cache_0_0/event=0x21/

As a high-level thing, while we can't do aggregation of counts across
slices, and while we'd have to reject cross-slice groups, we *could*
have a single struct PMU that covers all those slices, with userspace
selecting which slice an event targets via
perf_event_attr::config{,1,2}. i.e. we'd treat those as independent
sub-units under the PMU.

With some sysfs and userspace work, it would then be possible to have
the perf tool infer automatically that it should open an event on each
sub-unit as it currently does per-cpu.

> 
> Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>
> ---
>  drivers/perf/Kconfig       |  10 +
>  drivers/perf/Makefile      |   1 +
>  drivers/perf/qcom_l3_pmu.c | 755 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/cpuhotplug.h |   1 +
>  4 files changed, 767 insertions(+)
>  create mode 100644 drivers/perf/qcom_l3_pmu.c

This could do with documentation, as we have for the L2 PMU in
Documentation/perf/qcom_l2_pmu.txt, e.g. with hhow to user the long
counter option.

IIRC this also has a flat event space, rather than the row/column style
that the L2 PMU has. That would be worth mentioning explicitly, too.

[...]

> diff --git a/drivers/perf/qcom_l3_pmu.c b/drivers/perf/qcom_l3_pmu.c
> new file mode 100644
> index 0000000..207f174
> --- /dev/null
> +++ b/drivers/perf/qcom_l3_pmu.c
> @@ -0,0 +1,755 @@
> +/* Copyright (c) 2015-2017, The Linux Foundation. All rights reserved.
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
> +
> +#include <linux/module.h>
> +#include <linux/bitops.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/list.h>
> +#include <linux/acpi.h>
> +#include <linux/perf_event.h>
> +#include <linux/platform_device.h>

Nit: please keep includes ordered alphabetically.

Also, as a general stylistic note, please keep the start of the file
file organised as:

1) description of the file
2) copyright
3) includes
4) code

(perhaps with 1 & 2 being the same comment block)

That's what we do in the other PMU drivers in this directory.

> +/*
> + * Driver for the L3 cache PMUs in Qualcomm Technologies chips.
> + *
> + * The driver supports a distributed cache architecture where the overall
> + * cache for a socket is comprised of multiple slices each with its own PMU.
> + * Access to each individual PMU is provided even though all CPUs share all
> + * the slices. User space needs to aggregate to individual counts to provide
> + * a global picture.
> + *
> + * The hardware supports counter chaining to provide the user a way to avoid
> + * overhead of software counter maintenance. This is exposed via a the 'lc'
> + * flag field in perf_event_attr.config.

We should be able to refer to the documentation file here.

> + *
> + * The hardware also supports a feature that asserts the IRQ on the toggling
> + * of the most significanty bit in the 32bit counter.

Nit: s/significanty/significant/

This is just an overflow interrupt, right?

Or does this interrupt also trigger when bit 31 goes from 0 to 1?

[...]

> +/*
> + * Decoding of settings from perf_event_attr
> + *
> + * The config format for perf events is:
> + * - config: bits 0-7: event type
> + *           bit  32:  HW counter size requested, 0: 32 bits, 1: 64 bits
> + */

Not really a problem, but is there a specific reason to avoid bits 31-8?

> +static inline u32 get_event_type(struct perf_event *event)
> +{
> +	return (event->attr.config) & L3_MAX_EVTYPE;
> +}
> +
> +static inline int get_hw_counter_size(struct perf_event *event)
> +{
> +	return event->attr.config >> 32 & 1;
> +}

This would be better as something like

#define L3_EVENT_ATTR_LC_BIT	32

static inline bool event_uses_long_counter(struct perf_event *event)
{
	return !!(event->attr.config & BIT_ULL(L3_EVENT_ATTR_LC_BIT));
}

That way it's clear what the return value means, and you can reuse the
definition for the sysfs attr.

That means qcom_l3_cache__event_add() has to be more explicit w.r.t. the
order parameter for the bitmap search, but that's a good thing.

[...]

> +struct l3cache_pmu_hwc {
> +	struct perf_event	*event;
> +	/* Called to start event monitoring */
> +	void (*start)(struct perf_event *event);
> +	/* Called to stop event monitoring */
> +	void (*stop)(struct perf_event *event, int flags);
> +	/* Called to update the perf_event */
> +	void (*update)(struct perf_event *event);
> +};

Even if having separate ops makes handling chaining simpler, I don't
think we need a copy of all these per-event.

We can instead have something like:

struct l3cache_event_ops {
	void (*start)(struct perf_event *event);
	void (*stop)(struct perf_event *event, int flags);
	void (*update)(struct perf_event *event);
};

struct l3cache_event_ops event_ops_std;
struct l3cache_event_ops event_ops_long;

static struct l3cache_event_ops *l3cache_event_get_ops(struct perf_event *event)
{
	if (event_uses_long_counter(event))
		return &event_ops_long;
	else
		return &event_ops_std;
}

... and callers the need the ops can consult
l3cache_event_get_ops(event).

[...]

> +
> +/*
> + * Main PMU, inherits from the core perf PMU type
> + */
> +struct l3cache_pmu {
> +	struct pmu		perf_pmu;

Please call this pmu.

More generally, for function arguments and vars, please name a struct
pmu as 'pmu', and an l3cache_pmu as 'l3pmu' (or something like that).

That'll keep things consistent and easier to follow, even for those
unfamiliar with this particular driver.

> +	struct hlist_node	node;
> +	void __iomem		*regs;
> +	struct l3cache_pmu_hwc	counters[L3_NUM_COUNTERS];
> +	unsigned long		used_mask[BITS_TO_LONGS(L3_NUM_COUNTERS)];
> +	cpumask_t		cpumask;
> +};
> +
> +#define to_l3cache_pmu(p) (container_of(p, struct l3cache_pmu, perf_pmu))
> +
> +/*
> + * 64 bit counter implementation
> + */
> +
> +static void qcom_l3_cache__64bit_counter_start(struct perf_event *event)
> +{
> +	struct l3cache_pmu *pmu = to_l3cache_pmu(event->pmu);
> +	int idx = event->hw.idx;
> +	u32 evsel = get_event_type(event);
> +	u64 evcnt = local64_read(&event->count);
> +	u32 gang = readl_relaxed(pmu->regs + L3_M_BC_GANG);
> +
> +	writel_relaxed(gang | GANG_EN(idx), pmu->regs + L3_M_BC_GANG);

I take it this is what actually configures the chaining behaviour?

> +	writel_relaxed(evcnt >> 32, pmu->regs + L3_HML3_PM_EVCNTR(idx+1));
> +	writel_relaxed((u32)evcnt, pmu->regs + L3_HML3_PM_EVCNTR(idx));


It's not safe to use perf_event::count in this manner. The core perf
code can change the count value at any time it wants (e.g. see
PERF_EVENT_IOC_RESET), so this will result in bogus counts.

Drivers should keep track of the HW value using
hw_perf_event::prev_count, and add the delta into perf_event::count.

Please do so here.

> +	writel_relaxed(EVSEL(0), pmu->regs + L3_HML3_PM_EVTYPE(idx+1));
> +	writel_relaxed(EVSEL(evsel), pmu->regs + L3_HML3_PM_EVTYPE(idx));
> +
> +	writel_relaxed(PMCNTENSET(idx+1), pmu->regs + L3_M_BC_CNTENSET);
> +	writel_relaxed(PMCNTENSET(idx), pmu->regs + L3_M_BC_CNTENSET);
> +}

IIUC, we're not enabling the interrupt here, is that correct?

If that's deliberate, there should be a comment as to why.

These are all relaxed, so what ensures the counter is actually started
when we return from this function?

> +static void qcom_l3_cache__64bit_counter_stop(struct perf_event *event,
> +					      int flags)
> +{
> +	struct l3cache_pmu *pmu = to_l3cache_pmu(event->pmu);
> +	int idx = event->hw.idx;
> +	u32 gang = readl_relaxed(pmu->regs + L3_M_BC_GANG);
> +
> +	writel_relaxed(gang & ~GANG_EN(idx), pmu->regs + L3_M_BC_GANG);
> +	writel_relaxed(PMCNTENCLR(idx), pmu->regs + L3_M_BC_CNTENCLR);
> +	writel_relaxed(PMCNTENCLR(idx+1), pmu->regs + L3_M_BC_CNTENCLR);
> +}
> +
> +static void qcom_l3_cache__64bit_counter_update(struct perf_event *event)
> +{
> +	struct l3cache_pmu *pmu = to_l3cache_pmu(event->pmu);
> +	int idx = event->hw.idx;
> +	u32 hi_new, hi_old, lo;
> +	int i, retries = 2;
> +
> +	hi_new = readl_relaxed(pmu->regs + L3_HML3_PM_EVCNTR(idx+1));
> +	hi_old = hi_new + 1;
> +	for (i = 0; (i < retries) && (hi_old != hi_new); i++) {
> +		hi_old = hi_new;
> +		lo = readl_relaxed(pmu->regs + L3_HML3_PM_EVCNTR(idx));
> +		hi_new = readl_relaxed(pmu->regs + L3_HML3_PM_EVCNTR(idx+1));
> +	}

This looks overly complicated, and would be far simpler using a pattern
like:

do {
	hi = readl_relaxed(pmu->regs + L3_HML3_PM_EVCNTR(idx+1));
	lo = readl_relaxed(pmu->regs + L3_HML3_PM_EVCNTR(idx));
} while (hi != readl_relaxed(pmu->regs + L3_HML3_PM_EVCNTR(idx+1)));

If we need a bounded number of retries, we should warn rather than
exiting the loop ant potentially returning junk.

Elsewhere when we read a 64-bit free-running counter in two halves (e.g.
in arch_counter_get_cntvct_mem()), it's assumed that 32-bit overflow
takes sufficiently long that it's unlikely to occur often enough to
result in a livelock, and we don't need to explicitly bound the loop.

> +
> +	local64_set(&event->count, ((u64)hi_new << 32) | lo);

As mentioned above for qcom_l3_cache__64bit_counter_start(), please use
hw_perf_event::prev_count in the usual way, and accumulate the delta
into perf_event::count when updating.

Doing so means you can share most of the logic for update.

> +}
> +
> +/*
> + * 32 bit counter interface implementation
> + */
> +
> +static void qcom_l3_cache__32bit_counter_start(struct perf_event *event)
> +{
> +	struct l3cache_pmu *pmu = to_l3cache_pmu(event->pmu);
> +	int idx = event->hw.idx;
> +	u32 evsel = get_event_type(event);
> +	u32 irqctl = readl_relaxed(pmu->regs + L3_M_BC_IRQCTL);
> +
> +	local64_set(&event->hw.prev_count, 0);

Please follow the example set elsewhere, and start the counter at half
its max value (e.g. 0x80000000 here). So long as the IRQ is taken before
another 2^31 events occur, that caters for extreme IRQ latency, and the
IRQ handler doesn't have to treat the overflow as an implicit extra
counter bit.

> +	writel_relaxed(0, pmu->regs + L3_HML3_PM_EVCNTR(idx));
> +	writel_relaxed(irqctl | PMIRQONMSBEN(idx), pmu->regs + L3_M_BC_IRQCTL);
> +	writel_relaxed(EVSEL(evsel), pmu->regs + L3_HML3_PM_EVTYPE(idx));
> +	writel_relaxed(PMINTENSET(idx), pmu->regs + L3_M_BC_INTENSET);
> +	writel_relaxed(PMCNTENSET(idx), pmu->regs + L3_M_BC_CNTENSET);
> +}
> +
> +static void qcom_l3_cache__32bit_counter_stop(struct perf_event *event,
> +					      int flags)
> +{
> +	struct l3cache_pmu *pmu = to_l3cache_pmu(event->pmu);
> +	int idx = event->hw.idx;
> +	u32 irqctl = readl_relaxed(pmu->regs + L3_M_BC_IRQCTL);
> +
> +	writel_relaxed(irqctl & ~PMIRQONMSBEN(idx), pmu->regs + L3_M_BC_IRQCTL);
> +	writel_relaxed(PMINTENCLR(idx), pmu->regs + L3_M_BC_INTENCLR);
> +	writel_relaxed(PMCNTENCLR(idx), pmu->regs + L3_M_BC_CNTENCLR);
> +}
> +
> +static void qcom_l3_cache__32bit_counter_update(struct perf_event *event)
> +{
> +	struct l3cache_pmu *pmu = to_l3cache_pmu(event->pmu);
> +	int idx = event->hw.idx;
> +	u32 delta, prev, now;
> +
> +	do {
> +		prev = local64_read(&event->hw.prev_count);
> +		now = readl_relaxed(pmu->regs + L3_HML3_PM_EVCNTR(idx));
> +	} while (local64_cmpxchg(&event->hw.prev_count, prev, now) != prev);
> +
> +	delta = now - prev;
> +	local64_add(delta, &event->count);
> +}

This doesn't take overflow into account, so we're potentially losing
2^32 events here when called from the IRQ handler.

If you start the counter at half of its max value, this should be ok
as-is.

[...]

> +static irqreturn_t qcom_l3_cache__handle_irq(int irq_num, void *data)
> +{
> +	struct l3cache_pmu *pmu = data;
> +	u32 status = readl_relaxed(pmu->regs + L3_M_BC_OVSR);
> +	int idx;
> +
> +	if (status == 0)
> +		return IRQ_NONE;
> +
> +	writel_relaxed(status, pmu->regs + L3_M_BC_OVSR);

I take it this clears the overflow status bits? i.e. it's write to
clear?

It would be worth a comment.

> +	while (status) {
> +		struct perf_event *event;
> +
> +		idx = __ffs(status);
> +		status &= ~(1 << idx);

It would be better to have status in an unsigned long, and use
for_each_set_bit() over that.

> +		event = pmu->counters[idx].event;
> +		if (!event)
> +			continue;
> +
> +		qcom_l3_cache__32bit_counter_update(event);

It would be worth a comment as to why we don't consider 64-bit events.

Even given that, for consistency it'd be worth updating the counter
using the usual ops indirection.

> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/*
> + * Implementation of abstract pmu functionality required by
> + * the core perf events code.
> + */
> +
> +static void qcom_l3_cache__pmu_enable(struct pmu *perf_pmu)
> +{
> +	struct l3cache_pmu *pmu = to_l3cache_pmu(perf_pmu);
> +	int i;
> +
> +	/*
> +	 * Re-write CNTCTL for all existing events to re-assert
> +	 * the start trigger.
> +	 */
> +	for (i = 0; i < L3_NUM_COUNTERS; i++)
> +		if (pmu->counters[i].event)
> +			writel_relaxed(PMCNT_RESET, pmu->regs + L3_HML3_PM_CNTCTL(i));

Could you elaborate on this, please?

Why do we need to poke each event? What happens if we didn't do this?

> +
> +	/* Ensure all programming commands are done before proceeding */
> +	writel(BC_ENABLE, pmu->regs + L3_M_BC_CR);
> +}
> +
> +static void qcom_l3_cache__pmu_disable(struct pmu *perf_pmu)
> +{
> +	struct l3cache_pmu *pmu = to_l3cache_pmu(perf_pmu);
> +
> +	writel_relaxed(0, pmu->regs + L3_M_BC_CR);
> +
> +	/* Ensure the basic counter unit is stopped before proceeding */
> +	wmb();

You presumably want likewise on the enable path, before enabling the
PMU.

> +}
> +
> +static int qcom_l3_cache__event_init(struct perf_event *event)
> +{
> +	struct l3cache_pmu *pmu;
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	/*
> +	 * Is the event for this PMU?
> +	 */
> +	if (event->attr.type != event->pmu->type)
> +		return -ENOENT;
> +
> +	/*
> +	 * There are no per-counter mode filters in the PMU.
> +	 */
> +	if (event->attr.exclude_user || event->attr.exclude_kernel ||
> +	    event->attr.exclude_hv || event->attr.exclude_idle)
> +		return -EINVAL;
> +
> +	hwc->idx = -1;
> +

Please do this after the remaining return conditions below.

> +	/*
> +	 * Sampling not supported since these events are not core-attributable.
> +	 */
> +	if (hwc->sample_period)
> +		return -EINVAL;
> +
> +	/*
> +	 * Task mode not available, we run the counters as socket counters,
> +	 * not attributable to any CPU and therefore cannot attribute per-task.
> +	 */
> +	if (event->cpu < 0)
> +		return -EINVAL;
> +

You also need to check the event grouping here. Please look at the QC L2
PMU driver's l2_cache_event_init().

> +	/*
> +	 * Many perf core operations (eg. events rotation) operate on a
> +	 * single CPU context. This is obvious for CPU PMUs, where one
> +	 * expects the same sets of events being observed on all CPUs,
> +	 * but can lead to issues for off-core PMUs, like this one, where
> +	 * each event could be theoretically assigned to a different CPU.
> +	 * To mitigate this, we enforce CPU assignment to one designated
> +	 * processor (the one described in the "cpumask" attribute exported
> +	 * by the PMU device). perf user space tools honor this and avoid
> +	 * opening more than one copy of the events.
> +	 */
> +	pmu = to_l3cache_pmu(event->pmu);
> +	event->cpu = cpumask_first(&pmu->cpumask);
> +
> +	return 0;
> +}
> +
> +static void qcom_l3_cache__event_start(struct perf_event *event, int flags)
> +{
> +	struct l3cache_pmu *pmu = to_l3cache_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	hwc->state = 0;
> +
> +	pmu->counters[hwc->idx].start(event);
> +}
> +
> +static void qcom_l3_cache__event_stop(struct perf_event *event, int flags)
> +{
> +	struct l3cache_pmu *pmu = to_l3cache_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	if (!(hwc->state & PERF_HES_STOPPED)) {

Please use an early return to handle this, e.g.

	if (hwc->state & PERF_HES_STOPPED)
		return;

That makes it easier to follow the rest of the function, which doesn't
need to be in a block, indented.

> +		pmu->counters[hwc->idx].stop(event, flags);
> +
> +		if (flags & PERF_EF_UPDATE)
> +			pmu->counters[hwc->idx].update(event);
> +		hwc->state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
> +	}
> +}
> +
> +static int qcom_l3_cache__event_add(struct perf_event *event, int flags)
> +{
> +	struct l3cache_pmu *pmu = to_l3cache_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	int idx;
> +	int sz;
> +
> +	/*
> +	 * Try to allocate a counter.
> +	 */
> +	sz = get_hw_counter_size(event);
> +	idx = bitmap_find_free_region(pmu->used_mask, L3_NUM_COUNTERS, sz);

Is it strictly necessary for these to be an even/odd pair, or can
chained events be used with any two counters?

> +	if (idx < 0)
> +		/* The counters are all in use. */
> +		return -EAGAIN;
> +
> +	hwc->idx = idx;
> +	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
> +
> +	if (sz == 0)
> +		pmu->counters[idx] = (struct l3cache_pmu_hwc) {
> +			.event = event,
> +			.start = qcom_l3_cache__32bit_counter_start,
> +			.stop = qcom_l3_cache__32bit_counter_stop,
> +			.update = qcom_l3_cache__32bit_counter_update
> +		};
> +	else {
> +		pmu->counters[idx] = (struct l3cache_pmu_hwc) {
> +			.event = event,
> +			.start = qcom_l3_cache__64bit_counter_start,
> +			.stop = qcom_l3_cache__64bit_counter_stop,
> +			.update = qcom_l3_cache__64bit_counter_update
> +		};
> +		pmu->counters[idx+1] = pmu->counters[idx];
> +	}

This should be able to go, if we use the ops indirection suggested
above.

In the long counter case, do we even need to touch the additional
pmu->counters[] slot?

AFAICT, we'll never use it for anything. The irq handler implicitly
ignores all pmu->counters[] slots for long events, since they don't
generate irqs, and elsewhere we don't sseem to use this.

> +
> +	if (flags & PERF_EF_START)
> +		qcom_l3_cache__event_start(event, 0);
> +
> +	/* Propagate changes to the userspace mapping. */
> +	perf_event_update_userpage(event);
> +
> +	return 0;
> +}
> +
> +static void qcom_l3_cache__event_del(struct perf_event *event, int flags)
> +{
> +	struct l3cache_pmu *pmu = to_l3cache_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	int sz;
> +
> +	qcom_l3_cache__event_stop(event,  flags | PERF_EF_UPDATE);
> +	sz = get_hw_counter_size(event);
> +	pmu->counters[hwc->idx].event = NULL;
> +	if (sz)
> +		pmu->counters[hwc->idx+1].event = NULL;

As above, it's not clear to me if we need to touch this slot at all.

[...]

> +#define L3CACHE_EVENT_VAR(__id)	pmu_event_attr_##__id
> +#define L3CACHE_EVENT_PTR(__id)	(&L3CACHE_EVENT_VAR(__id).attr.attr)
> +
> +#define L3CACHE_EVENT_ATTR(__name, __id)			\
> +	PMU_EVENT_ATTR(__name, L3CACHE_EVENT_VAR(__id), __id,	\
> +		       l3cache_pmu_event_sysfs_show)
> +
> +
> +L3CACHE_EVENT_ATTR(cycles, L3_CYCLES);
> +L3CACHE_EVENT_ATTR(read-hit, L3_READ_HIT);
> +L3CACHE_EVENT_ATTR(read-miss, L3_READ_MISS);
> +L3CACHE_EVENT_ATTR(read-hit-d-side, L3_READ_HIT_D);
> +L3CACHE_EVENT_ATTR(read-miss-d-side, L3_READ_MISS_D);
> +L3CACHE_EVENT_ATTR(write-hit, L3_WRITE_HIT);
> +L3CACHE_EVENT_ATTR(write-miss, L3_WRITE_MISS);
> +
> +static struct attribute *qcom_l3_cache_pmu_events[] = {
> +	L3CACHE_EVENT_PTR(L3_CYCLES),
> +	L3CACHE_EVENT_PTR(L3_READ_HIT),
> +	L3CACHE_EVENT_PTR(L3_READ_MISS),
> +	L3CACHE_EVENT_PTR(L3_READ_HIT_D),
> +	L3CACHE_EVENT_PTR(L3_READ_MISS_D),
> +	L3CACHE_EVENT_PTR(L3_WRITE_HIT),
> +	L3CACHE_EVENT_PTR(L3_WRITE_MISS),
> +	NULL
> +};

Please follow the approach taken by drivers/perf/xgene_pmu.c's
XGENE_PMU_EVENT_ATTR(), so that they can be definied in-place.

> +
> +static struct attribute_group qcom_l3_cache_pmu_events_group = {
> +	.name = "events",
> +	.attrs = qcom_l3_cache_pmu_events,
> +};
> +
> +PMU_FORMAT_ATTR(event, "config:0-7");
> +PMU_FORMAT_ATTR(lc, "config:32");
> +
> +static struct attribute *qcom_l3_cache_pmu_formats[] = {
> +	&format_attr_event.attr,
> +	&format_attr_lc.attr,
> +	NULL,
> +};

Likewise, see XGENE_PMU_FORMAT_ATTR().

Thanks,
Mark.
