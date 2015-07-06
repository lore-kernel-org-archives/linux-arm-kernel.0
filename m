From: mark.rutland@arm.com (Mark Rutland)
Date: Mon,  6 Jul 2015 12:23:55 +0100
Subject: [PATCHv3 3/9] arm64: perf: move to shared arm_pmu framework
In-Reply-To: <1436181842-19402-1-git-send-email-mark.rutland@arm.com>
References: <1436181842-19402-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1436181842-19402-4-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the arm_pmu framework has been factored out to drivers/perf we
can make use of it for arm64, gaining support for heterogeneous PMUs
and unifying the two codebases before they diverge further.

The as yet unused PMU name for PMUv3 is changed to armv8_pmuv3, matching
the style previously applied to the 32-bit PMUs.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: will Deacon <will.deacon@arm.com>
---
 arch/arm64/Kconfig                   |    8 +-
 arch/arm64/include/asm/pmu.h         |   83 --
 arch/arm64/kernel/Makefile           |    2 +-
 arch/arm64/kernel/perf_event.c       | 1416 ----------------------------------
 arch/arm64/kernel/perf_event_pmuv3.c |  653 ++++++++++++++++
 drivers/perf/Kconfig                 |    2 +-
 6 files changed, 657 insertions(+), 1507 deletions(-)
 delete mode 100644 arch/arm64/include/asm/pmu.h
 delete mode 100644 arch/arm64/kernel/perf_event.c
 create mode 100644 arch/arm64/kernel/perf_event_pmuv3.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 0f6edb1..9bdbc1a 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -544,12 +544,8 @@ config HAVE_ARCH_PFN_VALID
 	def_bool ARCH_HAS_HOLES_MEMORYMODEL || !SPARSEMEM
 
 config HW_PERF_EVENTS
-	bool "Enable hardware performance counter support for perf events"
-	depends on PERF_EVENTS
-	default y
-	help
-	  Enable hardware performance counter support for perf events. If
-	  disabled, perf events will use software events only.
+	def_bool y
+	depends on ARM_PMU
 
 config SYS_SUPPORTS_HUGETLBFS
 	def_bool y
diff --git a/arch/arm64/include/asm/pmu.h b/arch/arm64/include/asm/pmu.h
deleted file mode 100644
index b7710a5..0000000
--- a/arch/arm64/include/asm/pmu.h
+++ /dev/null
@@ -1,83 +0,0 @@
-/*
- * Based on arch/arm/include/asm/pmu.h
- *
- * Copyright (C) 2009 picoChip Designs Ltd, Jamie Iles
- * Copyright (C) 2012 ARM Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-#ifndef __ASM_PMU_H
-#define __ASM_PMU_H
-
-#ifdef CONFIG_HW_PERF_EVENTS
-
-/* The events for a given PMU register set. */
-struct pmu_hw_events {
-	/*
-	 * The events that are active on the PMU for the given index.
-	 */
-	struct perf_event	**events;
-
-	/*
-	 * A 1 bit for an index indicates that the counter is being used for
-	 * an event. A 0 means that the counter can be used.
-	 */
-	unsigned long           *used_mask;
-
-	/*
-	 * Hardware lock to serialize accesses to PMU registers. Needed for the
-	 * read/modify/write sequences.
-	 */
-	raw_spinlock_t		pmu_lock;
-};
-
-struct arm_pmu {
-	struct pmu		pmu;
-	cpumask_t		active_irqs;
-	int			*irq_affinity;
-	const char		*name;
-	irqreturn_t		(*handle_irq)(int irq_num, void *dev);
-	void			(*enable)(struct hw_perf_event *evt, int idx);
-	void			(*disable)(struct hw_perf_event *evt, int idx);
-	int			(*get_event_idx)(struct pmu_hw_events *hw_events,
-						 struct hw_perf_event *hwc);
-	int			(*set_event_filter)(struct hw_perf_event *evt,
-						    struct perf_event_attr *attr);
-	u32			(*read_counter)(int idx);
-	void			(*write_counter)(int idx, u32 val);
-	void			(*start)(void);
-	void			(*stop)(void);
-	void			(*reset)(void *);
-	int			(*map_event)(struct perf_event *event);
-	int			num_events;
-	atomic_t		active_events;
-	struct mutex		reserve_mutex;
-	u64			max_period;
-	struct platform_device	*plat_device;
-	struct pmu_hw_events	*(*get_hw_events)(void);
-};
-
-#define to_arm_pmu(p) (container_of(p, struct arm_pmu, pmu))
-
-int __init armpmu_register(struct arm_pmu *armpmu, char *name, int type);
-
-u64 armpmu_event_update(struct perf_event *event,
-			struct hw_perf_event *hwc,
-			int idx);
-
-int armpmu_event_set_period(struct perf_event *event,
-			    struct hw_perf_event *hwc,
-			    int idx);
-
-#endif /* CONFIG_HW_PERF_EVENTS */
-#endif /* __ASM_PMU_H */
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index e89063e..8a94901 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -26,7 +26,7 @@ arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
 arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
 arm64-obj-$(CONFIG_SMP)			+= smp.o smp_spin_table.o topology.o
 arm64-obj-$(CONFIG_PERF_EVENTS)		+= perf_regs.o perf_callchain.o
-arm64-obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o
+arm64-obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event_pmuv3.o
 arm64-obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 arm64-obj-$(CONFIG_CPU_PM)		+= sleep.o suspend.o
 arm64-obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
deleted file mode 100644
index c886915..0000000
--- a/arch/arm64/kernel/perf_event.c
+++ /dev/null
@@ -1,1416 +0,0 @@
-/*
- * PMU support
- *
- * Copyright (C) 2012 ARM Limited
- * Author: Will Deacon <will.deacon@arm.com>
- *
- * This code is based heavily on the ARMv7 perf event code.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-#define pr_fmt(fmt) "hw perfevents: " fmt
-
-#include <linux/bitmap.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/kernel.h>
-#include <linux/export.h>
-#include <linux/of.h>
-#include <linux/perf_event.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
-#include <linux/spinlock.h>
-#include <linux/uaccess.h>
-
-#include <asm/cputype.h>
-#include <asm/irq.h>
-#include <asm/irq_regs.h>
-#include <asm/pmu.h>
-
-/*
- * ARMv8 supports a maximum of 32 events.
- * The cycle counter is included in this total.
- */
-#define ARMPMU_MAX_HWEVENTS		32
-
-static DEFINE_PER_CPU(struct perf_event * [ARMPMU_MAX_HWEVENTS], hw_events);
-static DEFINE_PER_CPU(unsigned long [BITS_TO_LONGS(ARMPMU_MAX_HWEVENTS)], used_mask);
-static DEFINE_PER_CPU(struct pmu_hw_events, cpu_hw_events);
-
-#define to_arm_pmu(p) (container_of(p, struct arm_pmu, pmu))
-
-/* Set at runtime when we know what CPU type we are. */
-static struct arm_pmu *cpu_pmu;
-
-int
-armpmu_get_max_events(void)
-{
-	int max_events = 0;
-
-	if (cpu_pmu != NULL)
-		max_events = cpu_pmu->num_events;
-
-	return max_events;
-}
-EXPORT_SYMBOL_GPL(armpmu_get_max_events);
-
-int perf_num_counters(void)
-{
-	return armpmu_get_max_events();
-}
-EXPORT_SYMBOL_GPL(perf_num_counters);
-
-#define HW_OP_UNSUPPORTED		0xFFFF
-
-#define C(_x) \
-	PERF_COUNT_HW_CACHE_##_x
-
-#define CACHE_OP_UNSUPPORTED		0xFFFF
-
-static int
-armpmu_map_cache_event(const unsigned (*cache_map)
-				      [PERF_COUNT_HW_CACHE_MAX]
-				      [PERF_COUNT_HW_CACHE_OP_MAX]
-				      [PERF_COUNT_HW_CACHE_RESULT_MAX],
-		       u64 config)
-{
-	unsigned int cache_type, cache_op, cache_result, ret;
-
-	cache_type = (config >>  0) & 0xff;
-	if (cache_type >= PERF_COUNT_HW_CACHE_MAX)
-		return -EINVAL;
-
-	cache_op = (config >>  8) & 0xff;
-	if (cache_op >= PERF_COUNT_HW_CACHE_OP_MAX)
-		return -EINVAL;
-
-	cache_result = (config >> 16) & 0xff;
-	if (cache_result >= PERF_COUNT_HW_CACHE_RESULT_MAX)
-		return -EINVAL;
-
-	ret = (int)(*cache_map)[cache_type][cache_op][cache_result];
-
-	if (ret == CACHE_OP_UNSUPPORTED)
-		return -ENOENT;
-
-	return ret;
-}
-
-static int
-armpmu_map_event(const unsigned (*event_map)[PERF_COUNT_HW_MAX], u64 config)
-{
-	int mapping;
-
-	if (config >= PERF_COUNT_HW_MAX)
-		return -EINVAL;
-
-	mapping = (*event_map)[config];
-	return mapping == HW_OP_UNSUPPORTED ? -ENOENT : mapping;
-}
-
-static int
-armpmu_map_raw_event(u32 raw_event_mask, u64 config)
-{
-	return (int)(config & raw_event_mask);
-}
-
-static int map_cpu_event(struct perf_event *event,
-			 const unsigned (*event_map)[PERF_COUNT_HW_MAX],
-			 const unsigned (*cache_map)
-					[PERF_COUNT_HW_CACHE_MAX]
-					[PERF_COUNT_HW_CACHE_OP_MAX]
-					[PERF_COUNT_HW_CACHE_RESULT_MAX],
-			 u32 raw_event_mask)
-{
-	u64 config = event->attr.config;
-
-	switch (event->attr.type) {
-	case PERF_TYPE_HARDWARE:
-		return armpmu_map_event(event_map, config);
-	case PERF_TYPE_HW_CACHE:
-		return armpmu_map_cache_event(cache_map, config);
-	case PERF_TYPE_RAW:
-		return armpmu_map_raw_event(raw_event_mask, config);
-	}
-
-	return -ENOENT;
-}
-
-int
-armpmu_event_set_period(struct perf_event *event,
-			struct hw_perf_event *hwc,
-			int idx)
-{
-	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
-	s64 left = local64_read(&hwc->period_left);
-	s64 period = hwc->sample_period;
-	int ret = 0;
-
-	if (unlikely(left <= -period)) {
-		left = period;
-		local64_set(&hwc->period_left, left);
-		hwc->last_period = period;
-		ret = 1;
-	}
-
-	if (unlikely(left <= 0)) {
-		left += period;
-		local64_set(&hwc->period_left, left);
-		hwc->last_period = period;
-		ret = 1;
-	}
-
-	/*
-	 * Limit the maximum period to prevent the counter value
-	 * from overtaking the one we are about to program. In
-	 * effect we are reducing max_period to account for
-	 * interrupt latency (and we are being very conservative).
-	 */
-	if (left > (armpmu->max_period >> 1))
-		left = armpmu->max_period >> 1;
-
-	local64_set(&hwc->prev_count, (u64)-left);
-
-	armpmu->write_counter(idx, (u64)(-left) & 0xffffffff);
-
-	perf_event_update_userpage(event);
-
-	return ret;
-}
-
-u64
-armpmu_event_update(struct perf_event *event,
-		    struct hw_perf_event *hwc,
-		    int idx)
-{
-	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
-	u64 delta, prev_raw_count, new_raw_count;
-
-again:
-	prev_raw_count = local64_read(&hwc->prev_count);
-	new_raw_count = armpmu->read_counter(idx);
-
-	if (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
-			     new_raw_count) != prev_raw_count)
-		goto again;
-
-	delta = (new_raw_count - prev_raw_count) & armpmu->max_period;
-
-	local64_add(delta, &event->count);
-	local64_sub(delta, &hwc->period_left);
-
-	return new_raw_count;
-}
-
-static void
-armpmu_read(struct perf_event *event)
-{
-	struct hw_perf_event *hwc = &event->hw;
-
-	/* Don't read disabled counters! */
-	if (hwc->idx < 0)
-		return;
-
-	armpmu_event_update(event, hwc, hwc->idx);
-}
-
-static void
-armpmu_stop(struct perf_event *event, int flags)
-{
-	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
-	struct hw_perf_event *hwc = &event->hw;
-
-	/*
-	 * ARM pmu always has to update the counter, so ignore
-	 * PERF_EF_UPDATE, see comments in armpmu_start().
-	 */
-	if (!(hwc->state & PERF_HES_STOPPED)) {
-		armpmu->disable(hwc, hwc->idx);
-		barrier(); /* why? */
-		armpmu_event_update(event, hwc, hwc->idx);
-		hwc->state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
-	}
-}
-
-static void
-armpmu_start(struct perf_event *event, int flags)
-{
-	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
-	struct hw_perf_event *hwc = &event->hw;
-
-	/*
-	 * ARM pmu always has to reprogram the period, so ignore
-	 * PERF_EF_RELOAD, see the comment below.
-	 */
-	if (flags & PERF_EF_RELOAD)
-		WARN_ON_ONCE(!(hwc->state & PERF_HES_UPTODATE));
-
-	hwc->state = 0;
-	/*
-	 * Set the period again. Some counters can't be stopped, so when we
-	 * were stopped we simply disabled the IRQ source and the counter
-	 * may have been left counting. If we don't do this step then we may
-	 * get an interrupt too soon or *way* too late if the overflow has
-	 * happened since disabling.
-	 */
-	armpmu_event_set_period(event, hwc, hwc->idx);
-	armpmu->enable(hwc, hwc->idx);
-}
-
-static void
-armpmu_del(struct perf_event *event, int flags)
-{
-	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
-	struct pmu_hw_events *hw_events = armpmu->get_hw_events();
-	struct hw_perf_event *hwc = &event->hw;
-	int idx = hwc->idx;
-
-	WARN_ON(idx < 0);
-
-	armpmu_stop(event, PERF_EF_UPDATE);
-	hw_events->events[idx] = NULL;
-	clear_bit(idx, hw_events->used_mask);
-
-	perf_event_update_userpage(event);
-}
-
-static int
-armpmu_add(struct perf_event *event, int flags)
-{
-	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
-	struct pmu_hw_events *hw_events = armpmu->get_hw_events();
-	struct hw_perf_event *hwc = &event->hw;
-	int idx;
-	int err = 0;
-
-	perf_pmu_disable(event->pmu);
-
-	/* If we don't have a space for the counter then finish early. */
-	idx = armpmu->get_event_idx(hw_events, hwc);
-	if (idx < 0) {
-		err = idx;
-		goto out;
-	}
-
-	/*
-	 * If there is an event in the counter we are going to use then make
-	 * sure it is disabled.
-	 */
-	event->hw.idx = idx;
-	armpmu->disable(hwc, idx);
-	hw_events->events[idx] = event;
-
-	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
-	if (flags & PERF_EF_START)
-		armpmu_start(event, PERF_EF_RELOAD);
-
-	/* Propagate our changes to the userspace mapping. */
-	perf_event_update_userpage(event);
-
-out:
-	perf_pmu_enable(event->pmu);
-	return err;
-}
-
-static int
-validate_event(struct pmu *pmu, struct pmu_hw_events *hw_events,
-				struct perf_event *event)
-{
-	struct arm_pmu *armpmu;
-	struct hw_perf_event fake_event = event->hw;
-	struct pmu *leader_pmu = event->group_leader->pmu;
-
-	if (is_software_event(event))
-		return 1;
-
-	/*
-	 * Reject groups spanning multiple HW PMUs (e.g. CPU + CCI). The
-	 * core perf code won't check that the pmu->ctx == leader->ctx
-	 * until after pmu->event_init(event).
-	 */
-	if (event->pmu != pmu)
-		return 0;
-
-	if (event->pmu != leader_pmu || event->state < PERF_EVENT_STATE_OFF)
-		return 1;
-
-	if (event->state == PERF_EVENT_STATE_OFF && !event->attr.enable_on_exec)
-		return 1;
-
-	armpmu = to_arm_pmu(event->pmu);
-	return armpmu->get_event_idx(hw_events, &fake_event) >= 0;
-}
-
-static int
-validate_group(struct perf_event *event)
-{
-	struct perf_event *sibling, *leader = event->group_leader;
-	struct pmu_hw_events fake_pmu;
-	DECLARE_BITMAP(fake_used_mask, ARMPMU_MAX_HWEVENTS);
-
-	/*
-	 * Initialise the fake PMU. We only need to populate the
-	 * used_mask for the purposes of validation.
-	 */
-	memset(fake_used_mask, 0, sizeof(fake_used_mask));
-	fake_pmu.used_mask = fake_used_mask;
-
-	if (!validate_event(event->pmu, &fake_pmu, leader))
-		return -EINVAL;
-
-	list_for_each_entry(sibling, &leader->sibling_list, group_entry) {
-		if (!validate_event(event->pmu, &fake_pmu, sibling))
-			return -EINVAL;
-	}
-
-	if (!validate_event(event->pmu, &fake_pmu, event))
-		return -EINVAL;
-
-	return 0;
-}
-
-static void
-armpmu_disable_percpu_irq(void *data)
-{
-	unsigned int irq = *(unsigned int *)data;
-	disable_percpu_irq(irq);
-}
-
-static void
-armpmu_release_hardware(struct arm_pmu *armpmu)
-{
-	int irq;
-	unsigned int i, irqs;
-	struct platform_device *pmu_device = armpmu->plat_device;
-
-	irqs = min(pmu_device->num_resources, num_possible_cpus());
-	if (!irqs)
-		return;
-
-	irq = platform_get_irq(pmu_device, 0);
-	if (irq <= 0)
-		return;
-
-	if (irq_is_percpu(irq)) {
-		on_each_cpu(armpmu_disable_percpu_irq, &irq, 1);
-		free_percpu_irq(irq, &cpu_hw_events);
-	} else {
-		for (i = 0; i < irqs; ++i) {
-			int cpu = i;
-
-			if (armpmu->irq_affinity)
-				cpu = armpmu->irq_affinity[i];
-
-			if (!cpumask_test_and_clear_cpu(cpu, &armpmu->active_irqs))
-				continue;
-			irq = platform_get_irq(pmu_device, i);
-			if (irq > 0)
-				free_irq(irq, armpmu);
-		}
-	}
-}
-
-static void
-armpmu_enable_percpu_irq(void *data)
-{
-	unsigned int irq = *(unsigned int *)data;
-	enable_percpu_irq(irq, IRQ_TYPE_NONE);
-}
-
-static int
-armpmu_reserve_hardware(struct arm_pmu *armpmu)
-{
-	int err, irq;
-	unsigned int i, irqs;
-	struct platform_device *pmu_device = armpmu->plat_device;
-
-	if (!pmu_device) {
-		pr_err("no PMU device registered\n");
-		return -ENODEV;
-	}
-
-	irqs = min(pmu_device->num_resources, num_possible_cpus());
-	if (!irqs) {
-		pr_err("no irqs for PMUs defined\n");
-		return -ENODEV;
-	}
-
-	irq = platform_get_irq(pmu_device, 0);
-	if (irq <= 0) {
-		pr_err("failed to get valid irq for PMU device\n");
-		return -ENODEV;
-	}
-
-	if (irq_is_percpu(irq)) {
-		err = request_percpu_irq(irq, armpmu->handle_irq,
-				"arm-pmu", &cpu_hw_events);
-
-		if (err) {
-			pr_err("unable to request percpu IRQ%d for ARM PMU counters\n",
-					irq);
-			armpmu_release_hardware(armpmu);
-			return err;
-		}
-
-		on_each_cpu(armpmu_enable_percpu_irq, &irq, 1);
-	} else {
-		for (i = 0; i < irqs; ++i) {
-			int cpu = i;
-
-			err = 0;
-			irq = platform_get_irq(pmu_device, i);
-			if (irq <= 0)
-				continue;
-
-			if (armpmu->irq_affinity)
-				cpu = armpmu->irq_affinity[i];
-
-			/*
-			 * If we have a single PMU interrupt that we can't shift,
-			 * assume that we're running on a uniprocessor machine and
-			 * continue. Otherwise, continue without this interrupt.
-			 */
-			if (irq_set_affinity(irq, cpumask_of(cpu)) && irqs > 1) {
-				pr_warning("unable to set irq affinity (irq=%d, cpu=%u)\n",
-						irq, cpu);
-				continue;
-			}
-
-			err = request_irq(irq, armpmu->handle_irq,
-					IRQF_NOBALANCING | IRQF_NO_THREAD,
-					"arm-pmu", armpmu);
-			if (err) {
-				pr_err("unable to request IRQ%d for ARM PMU counters\n",
-						irq);
-				armpmu_release_hardware(armpmu);
-				return err;
-			}
-
-			cpumask_set_cpu(cpu, &armpmu->active_irqs);
-		}
-	}
-
-	return 0;
-}
-
-static void
-hw_perf_event_destroy(struct perf_event *event)
-{
-	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
-	atomic_t *active_events	 = &armpmu->active_events;
-	struct mutex *pmu_reserve_mutex = &armpmu->reserve_mutex;
-
-	if (atomic_dec_and_mutex_lock(active_events, pmu_reserve_mutex)) {
-		armpmu_release_hardware(armpmu);
-		mutex_unlock(pmu_reserve_mutex);
-	}
-}
-
-static int
-event_requires_mode_exclusion(struct perf_event_attr *attr)
-{
-	return attr->exclude_idle || attr->exclude_user ||
-	       attr->exclude_kernel || attr->exclude_hv;
-}
-
-static int
-__hw_perf_event_init(struct perf_event *event)
-{
-	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
-	struct hw_perf_event *hwc = &event->hw;
-	int mapping, err;
-
-	mapping = armpmu->map_event(event);
-
-	if (mapping < 0) {
-		pr_debug("event %x:%llx not supported\n", event->attr.type,
-			 event->attr.config);
-		return mapping;
-	}
-
-	/*
-	 * We don't assign an index until we actually place the event onto
-	 * hardware. Use -1 to signify that we haven't decided where to put it
-	 * yet. For SMP systems, each core has it's own PMU so we can't do any
-	 * clever allocation or constraints checking at this point.
-	 */
-	hwc->idx		= -1;
-	hwc->config_base	= 0;
-	hwc->config		= 0;
-	hwc->event_base		= 0;
-
-	/*
-	 * Check whether we need to exclude the counter from certain modes.
-	 */
-	if ((!armpmu->set_event_filter ||
-	     armpmu->set_event_filter(hwc, &event->attr)) &&
-	     event_requires_mode_exclusion(&event->attr)) {
-		pr_debug("ARM performance counters do not support mode exclusion\n");
-		return -EPERM;
-	}
-
-	/*
-	 * Store the event encoding into the config_base field.
-	 */
-	hwc->config_base	    |= (unsigned long)mapping;
-
-	if (!hwc->sample_period) {
-		/*
-		 * For non-sampling runs, limit the sample_period to half
-		 * of the counter width. That way, the new counter value
-		 * is far less likely to overtake the previous one unless
-		 * you have some serious IRQ latency issues.
-		 */
-		hwc->sample_period  = armpmu->max_period >> 1;
-		hwc->last_period    = hwc->sample_period;
-		local64_set(&hwc->period_left, hwc->sample_period);
-	}
-
-	err = 0;
-	if (event->group_leader != event) {
-		err = validate_group(event);
-		if (err)
-			return -EINVAL;
-	}
-
-	return err;
-}
-
-static int armpmu_event_init(struct perf_event *event)
-{
-	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
-	int err = 0;
-	atomic_t *active_events = &armpmu->active_events;
-
-	if (armpmu->map_event(event) == -ENOENT)
-		return -ENOENT;
-
-	event->destroy = hw_perf_event_destroy;
-
-	if (!atomic_inc_not_zero(active_events)) {
-		mutex_lock(&armpmu->reserve_mutex);
-		if (atomic_read(active_events) == 0)
-			err = armpmu_reserve_hardware(armpmu);
-
-		if (!err)
-			atomic_inc(active_events);
-		mutex_unlock(&armpmu->reserve_mutex);
-	}
-
-	if (err)
-		return err;
-
-	err = __hw_perf_event_init(event);
-	if (err)
-		hw_perf_event_destroy(event);
-
-	return err;
-}
-
-static void armpmu_enable(struct pmu *pmu)
-{
-	struct arm_pmu *armpmu = to_arm_pmu(pmu);
-	struct pmu_hw_events *hw_events = armpmu->get_hw_events();
-	int enabled = bitmap_weight(hw_events->used_mask, armpmu->num_events);
-
-	if (enabled)
-		armpmu->start();
-}
-
-static void armpmu_disable(struct pmu *pmu)
-{
-	struct arm_pmu *armpmu = to_arm_pmu(pmu);
-	armpmu->stop();
-}
-
-static void __init armpmu_init(struct arm_pmu *armpmu)
-{
-	atomic_set(&armpmu->active_events, 0);
-	mutex_init(&armpmu->reserve_mutex);
-
-	armpmu->pmu = (struct pmu) {
-		.pmu_enable	= armpmu_enable,
-		.pmu_disable	= armpmu_disable,
-		.event_init	= armpmu_event_init,
-		.add		= armpmu_add,
-		.del		= armpmu_del,
-		.start		= armpmu_start,
-		.stop		= armpmu_stop,
-		.read		= armpmu_read,
-	};
-}
-
-int __init armpmu_register(struct arm_pmu *armpmu, char *name, int type)
-{
-	armpmu_init(armpmu);
-	return perf_pmu_register(&armpmu->pmu, name, type);
-}
-
-/*
- * ARMv8 PMUv3 Performance Events handling code.
- * Common event types.
- */
-enum armv8_pmuv3_perf_types {
-	/* Required events. */
-	ARMV8_PMUV3_PERFCTR_PMNC_SW_INCR			= 0x00,
-	ARMV8_PMUV3_PERFCTR_L1_DCACHE_REFILL			= 0x03,
-	ARMV8_PMUV3_PERFCTR_L1_DCACHE_ACCESS			= 0x04,
-	ARMV8_PMUV3_PERFCTR_PC_BRANCH_MIS_PRED			= 0x10,
-	ARMV8_PMUV3_PERFCTR_CLOCK_CYCLES			= 0x11,
-	ARMV8_PMUV3_PERFCTR_PC_BRANCH_PRED			= 0x12,
-
-	/* At least one of the following is required. */
-	ARMV8_PMUV3_PERFCTR_INSTR_EXECUTED			= 0x08,
-	ARMV8_PMUV3_PERFCTR_OP_SPEC				= 0x1B,
-
-	/* Common architectural events. */
-	ARMV8_PMUV3_PERFCTR_MEM_READ				= 0x06,
-	ARMV8_PMUV3_PERFCTR_MEM_WRITE				= 0x07,
-	ARMV8_PMUV3_PERFCTR_EXC_TAKEN				= 0x09,
-	ARMV8_PMUV3_PERFCTR_EXC_EXECUTED			= 0x0A,
-	ARMV8_PMUV3_PERFCTR_CID_WRITE				= 0x0B,
-	ARMV8_PMUV3_PERFCTR_PC_WRITE				= 0x0C,
-	ARMV8_PMUV3_PERFCTR_PC_IMM_BRANCH			= 0x0D,
-	ARMV8_PMUV3_PERFCTR_PC_PROC_RETURN			= 0x0E,
-	ARMV8_PMUV3_PERFCTR_MEM_UNALIGNED_ACCESS		= 0x0F,
-	ARMV8_PMUV3_PERFCTR_TTBR_WRITE				= 0x1C,
-
-	/* Common microarchitectural events. */
-	ARMV8_PMUV3_PERFCTR_L1_ICACHE_REFILL			= 0x01,
-	ARMV8_PMUV3_PERFCTR_ITLB_REFILL				= 0x02,
-	ARMV8_PMUV3_PERFCTR_DTLB_REFILL				= 0x05,
-	ARMV8_PMUV3_PERFCTR_MEM_ACCESS				= 0x13,
-	ARMV8_PMUV3_PERFCTR_L1_ICACHE_ACCESS			= 0x14,
-	ARMV8_PMUV3_PERFCTR_L1_DCACHE_WB			= 0x15,
-	ARMV8_PMUV3_PERFCTR_L2_CACHE_ACCESS			= 0x16,
-	ARMV8_PMUV3_PERFCTR_L2_CACHE_REFILL			= 0x17,
-	ARMV8_PMUV3_PERFCTR_L2_CACHE_WB				= 0x18,
-	ARMV8_PMUV3_PERFCTR_BUS_ACCESS				= 0x19,
-	ARMV8_PMUV3_PERFCTR_MEM_ERROR				= 0x1A,
-	ARMV8_PMUV3_PERFCTR_BUS_CYCLES				= 0x1D,
-};
-
-/* PMUv3 HW events mapping. */
-static const unsigned armv8_pmuv3_perf_map[PERF_COUNT_HW_MAX] = {
-	[PERF_COUNT_HW_CPU_CYCLES]		= ARMV8_PMUV3_PERFCTR_CLOCK_CYCLES,
-	[PERF_COUNT_HW_INSTRUCTIONS]		= ARMV8_PMUV3_PERFCTR_INSTR_EXECUTED,
-	[PERF_COUNT_HW_CACHE_REFERENCES]	= ARMV8_PMUV3_PERFCTR_L1_DCACHE_ACCESS,
-	[PERF_COUNT_HW_CACHE_MISSES]		= ARMV8_PMUV3_PERFCTR_L1_DCACHE_REFILL,
-	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= HW_OP_UNSUPPORTED,
-	[PERF_COUNT_HW_BRANCH_MISSES]		= ARMV8_PMUV3_PERFCTR_PC_BRANCH_MIS_PRED,
-	[PERF_COUNT_HW_BUS_CYCLES]		= HW_OP_UNSUPPORTED,
-	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND]	= HW_OP_UNSUPPORTED,
-	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND]	= HW_OP_UNSUPPORTED,
-};
-
-static const unsigned armv8_pmuv3_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
-						[PERF_COUNT_HW_CACHE_OP_MAX]
-						[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
-	[C(L1D)] = {
-		[C(OP_READ)] = {
-			[C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_L1_DCACHE_ACCESS,
-			[C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_L1_DCACHE_REFILL,
-		},
-		[C(OP_WRITE)] = {
-			[C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_L1_DCACHE_ACCESS,
-			[C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_L1_DCACHE_REFILL,
-		},
-		[C(OP_PREFETCH)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
-		},
-	},
-	[C(L1I)] = {
-		[C(OP_READ)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
-		},
-		[C(OP_WRITE)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
-		},
-		[C(OP_PREFETCH)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
-		},
-	},
-	[C(LL)] = {
-		[C(OP_READ)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
-		},
-		[C(OP_WRITE)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
-		},
-		[C(OP_PREFETCH)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
-		},
-	},
-	[C(DTLB)] = {
-		[C(OP_READ)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
-		},
-		[C(OP_WRITE)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
-		},
-		[C(OP_PREFETCH)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
-		},
-	},
-	[C(ITLB)] = {
-		[C(OP_READ)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
-		},
-		[C(OP_WRITE)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
-		},
-		[C(OP_PREFETCH)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
-		},
-	},
-	[C(BPU)] = {
-		[C(OP_READ)] = {
-			[C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_PC_BRANCH_PRED,
-			[C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_PC_BRANCH_MIS_PRED,
-		},
-		[C(OP_WRITE)] = {
-			[C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_PC_BRANCH_PRED,
-			[C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_PC_BRANCH_MIS_PRED,
-		},
-		[C(OP_PREFETCH)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
-		},
-	},
-	[C(NODE)] = {
-		[C(OP_READ)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
-		},
-		[C(OP_WRITE)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
-		},
-		[C(OP_PREFETCH)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
-		},
-	},
-};
-
-/*
- * Perf Events' indices
- */
-#define	ARMV8_IDX_CYCLE_COUNTER	0
-#define	ARMV8_IDX_COUNTER0	1
-#define	ARMV8_IDX_COUNTER_LAST	(ARMV8_IDX_CYCLE_COUNTER + cpu_pmu->num_events - 1)
-
-#define	ARMV8_MAX_COUNTERS	32
-#define	ARMV8_COUNTER_MASK	(ARMV8_MAX_COUNTERS - 1)
-
-/*
- * ARMv8 low level PMU access
- */
-
-/*
- * Perf Event to low level counters mapping
- */
-#define	ARMV8_IDX_TO_COUNTER(x)	\
-	(((x) - ARMV8_IDX_COUNTER0) & ARMV8_COUNTER_MASK)
-
-/*
- * Per-CPU PMCR: config reg
- */
-#define ARMV8_PMCR_E		(1 << 0) /* Enable all counters */
-#define ARMV8_PMCR_P		(1 << 1) /* Reset all counters */
-#define ARMV8_PMCR_C		(1 << 2) /* Cycle counter reset */
-#define ARMV8_PMCR_D		(1 << 3) /* CCNT counts every 64th cpu cycle */
-#define ARMV8_PMCR_X		(1 << 4) /* Export to ETM */
-#define ARMV8_PMCR_DP		(1 << 5) /* Disable CCNT if non-invasive debug*/
-#define	ARMV8_PMCR_N_SHIFT	11	 /* Number of counters supported */
-#define	ARMV8_PMCR_N_MASK	0x1f
-#define	ARMV8_PMCR_MASK		0x3f	 /* Mask for writable bits */
-
-/*
- * PMOVSR: counters overflow flag status reg
- */
-#define	ARMV8_OVSR_MASK		0xffffffff	/* Mask for writable bits */
-#define	ARMV8_OVERFLOWED_MASK	ARMV8_OVSR_MASK
-
-/*
- * PMXEVTYPER: Event selection reg
- */
-#define	ARMV8_EVTYPE_MASK	0xc80003ff	/* Mask for writable bits */
-#define	ARMV8_EVTYPE_EVENT	0x3ff		/* Mask for EVENT bits */
-
-/*
- * Event filters for PMUv3
- */
-#define	ARMV8_EXCLUDE_EL1	(1 << 31)
-#define	ARMV8_EXCLUDE_EL0	(1 << 30)
-#define	ARMV8_INCLUDE_EL2	(1 << 27)
-
-static inline u32 armv8pmu_pmcr_read(void)
-{
-	u32 val;
-	asm volatile("mrs %0, pmcr_el0" : "=r" (val));
-	return val;
-}
-
-static inline void armv8pmu_pmcr_write(u32 val)
-{
-	val &= ARMV8_PMCR_MASK;
-	isb();
-	asm volatile("msr pmcr_el0, %0" :: "r" (val));
-}
-
-static inline int armv8pmu_has_overflowed(u32 pmovsr)
-{
-	return pmovsr & ARMV8_OVERFLOWED_MASK;
-}
-
-static inline int armv8pmu_counter_valid(int idx)
-{
-	return idx >= ARMV8_IDX_CYCLE_COUNTER && idx <= ARMV8_IDX_COUNTER_LAST;
-}
-
-static inline int armv8pmu_counter_has_overflowed(u32 pmnc, int idx)
-{
-	int ret = 0;
-	u32 counter;
-
-	if (!armv8pmu_counter_valid(idx)) {
-		pr_err("CPU%u checking wrong counter %d overflow status\n",
-			smp_processor_id(), idx);
-	} else {
-		counter = ARMV8_IDX_TO_COUNTER(idx);
-		ret = pmnc & BIT(counter);
-	}
-
-	return ret;
-}
-
-static inline int armv8pmu_select_counter(int idx)
-{
-	u32 counter;
-
-	if (!armv8pmu_counter_valid(idx)) {
-		pr_err("CPU%u selecting wrong PMNC counter %d\n",
-			smp_processor_id(), idx);
-		return -EINVAL;
-	}
-
-	counter = ARMV8_IDX_TO_COUNTER(idx);
-	asm volatile("msr pmselr_el0, %0" :: "r" (counter));
-	isb();
-
-	return idx;
-}
-
-static inline u32 armv8pmu_read_counter(int idx)
-{
-	u32 value = 0;
-
-	if (!armv8pmu_counter_valid(idx))
-		pr_err("CPU%u reading wrong counter %d\n",
-			smp_processor_id(), idx);
-	else if (idx == ARMV8_IDX_CYCLE_COUNTER)
-		asm volatile("mrs %0, pmccntr_el0" : "=r" (value));
-	else if (armv8pmu_select_counter(idx) == idx)
-		asm volatile("mrs %0, pmxevcntr_el0" : "=r" (value));
-
-	return value;
-}
-
-static inline void armv8pmu_write_counter(int idx, u32 value)
-{
-	if (!armv8pmu_counter_valid(idx))
-		pr_err("CPU%u writing wrong counter %d\n",
-			smp_processor_id(), idx);
-	else if (idx == ARMV8_IDX_CYCLE_COUNTER)
-		asm volatile("msr pmccntr_el0, %0" :: "r" (value));
-	else if (armv8pmu_select_counter(idx) == idx)
-		asm volatile("msr pmxevcntr_el0, %0" :: "r" (value));
-}
-
-static inline void armv8pmu_write_evtype(int idx, u32 val)
-{
-	if (armv8pmu_select_counter(idx) == idx) {
-		val &= ARMV8_EVTYPE_MASK;
-		asm volatile("msr pmxevtyper_el0, %0" :: "r" (val));
-	}
-}
-
-static inline int armv8pmu_enable_counter(int idx)
-{
-	u32 counter;
-
-	if (!armv8pmu_counter_valid(idx)) {
-		pr_err("CPU%u enabling wrong PMNC counter %d\n",
-			smp_processor_id(), idx);
-		return -EINVAL;
-	}
-
-	counter = ARMV8_IDX_TO_COUNTER(idx);
-	asm volatile("msr pmcntenset_el0, %0" :: "r" (BIT(counter)));
-	return idx;
-}
-
-static inline int armv8pmu_disable_counter(int idx)
-{
-	u32 counter;
-
-	if (!armv8pmu_counter_valid(idx)) {
-		pr_err("CPU%u disabling wrong PMNC counter %d\n",
-			smp_processor_id(), idx);
-		return -EINVAL;
-	}
-
-	counter = ARMV8_IDX_TO_COUNTER(idx);
-	asm volatile("msr pmcntenclr_el0, %0" :: "r" (BIT(counter)));
-	return idx;
-}
-
-static inline int armv8pmu_enable_intens(int idx)
-{
-	u32 counter;
-
-	if (!armv8pmu_counter_valid(idx)) {
-		pr_err("CPU%u enabling wrong PMNC counter IRQ enable %d\n",
-			smp_processor_id(), idx);
-		return -EINVAL;
-	}
-
-	counter = ARMV8_IDX_TO_COUNTER(idx);
-	asm volatile("msr pmintenset_el1, %0" :: "r" (BIT(counter)));
-	return idx;
-}
-
-static inline int armv8pmu_disable_intens(int idx)
-{
-	u32 counter;
-
-	if (!armv8pmu_counter_valid(idx)) {
-		pr_err("CPU%u disabling wrong PMNC counter IRQ enable %d\n",
-			smp_processor_id(), idx);
-		return -EINVAL;
-	}
-
-	counter = ARMV8_IDX_TO_COUNTER(idx);
-	asm volatile("msr pmintenclr_el1, %0" :: "r" (BIT(counter)));
-	isb();
-	/* Clear the overflow flag in case an interrupt is pending. */
-	asm volatile("msr pmovsclr_el0, %0" :: "r" (BIT(counter)));
-	isb();
-	return idx;
-}
-
-static inline u32 armv8pmu_getreset_flags(void)
-{
-	u32 value;
-
-	/* Read */
-	asm volatile("mrs %0, pmovsclr_el0" : "=r" (value));
-
-	/* Write to clear flags */
-	value &= ARMV8_OVSR_MASK;
-	asm volatile("msr pmovsclr_el0, %0" :: "r" (value));
-
-	return value;
-}
-
-static void armv8pmu_enable_event(struct hw_perf_event *hwc, int idx)
-{
-	unsigned long flags;
-	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
-
-	/*
-	 * Enable counter and interrupt, and set the counter to count
-	 * the event that we're interested in.
-	 */
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
-
-	/*
-	 * Disable counter
-	 */
-	armv8pmu_disable_counter(idx);
-
-	/*
-	 * Set event (if destined for PMNx counters).
-	 */
-	armv8pmu_write_evtype(idx, hwc->config_base);
-
-	/*
-	 * Enable interrupt for this counter
-	 */
-	armv8pmu_enable_intens(idx);
-
-	/*
-	 * Enable counter
-	 */
-	armv8pmu_enable_counter(idx);
-
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
-}
-
-static void armv8pmu_disable_event(struct hw_perf_event *hwc, int idx)
-{
-	unsigned long flags;
-	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
-
-	/*
-	 * Disable counter and interrupt
-	 */
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
-
-	/*
-	 * Disable counter
-	 */
-	armv8pmu_disable_counter(idx);
-
-	/*
-	 * Disable interrupt for this counter
-	 */
-	armv8pmu_disable_intens(idx);
-
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
-}
-
-static irqreturn_t armv8pmu_handle_irq(int irq_num, void *dev)
-{
-	u32 pmovsr;
-	struct perf_sample_data data;
-	struct pmu_hw_events *cpuc;
-	struct pt_regs *regs;
-	int idx;
-
-	/*
-	 * Get and reset the IRQ flags
-	 */
-	pmovsr = armv8pmu_getreset_flags();
-
-	/*
-	 * Did an overflow occur?
-	 */
-	if (!armv8pmu_has_overflowed(pmovsr))
-		return IRQ_NONE;
-
-	/*
-	 * Handle the counter(s) overflow(s)
-	 */
-	regs = get_irq_regs();
-
-	cpuc = this_cpu_ptr(&cpu_hw_events);
-	for (idx = 0; idx < cpu_pmu->num_events; ++idx) {
-		struct perf_event *event = cpuc->events[idx];
-		struct hw_perf_event *hwc;
-
-		/* Ignore if we don't have an event. */
-		if (!event)
-			continue;
-
-		/*
-		 * We have a single interrupt for all counters. Check that
-		 * each counter has overflowed before we process it.
-		 */
-		if (!armv8pmu_counter_has_overflowed(pmovsr, idx))
-			continue;
-
-		hwc = &event->hw;
-		armpmu_event_update(event, hwc, idx);
-		perf_sample_data_init(&data, 0, hwc->last_period);
-		if (!armpmu_event_set_period(event, hwc, idx))
-			continue;
-
-		if (perf_event_overflow(event, &data, regs))
-			cpu_pmu->disable(hwc, idx);
-	}
-
-	/*
-	 * Handle the pending perf events.
-	 *
-	 * Note: this call *must* be run with interrupts disabled. For
-	 * platforms that can have the PMU interrupts raised as an NMI, this
-	 * will not work.
-	 */
-	irq_work_run();
-
-	return IRQ_HANDLED;
-}
-
-static void armv8pmu_start(void)
-{
-	unsigned long flags;
-	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
-
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
-	/* Enable all counters */
-	armv8pmu_pmcr_write(armv8pmu_pmcr_read() | ARMV8_PMCR_E);
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
-}
-
-static void armv8pmu_stop(void)
-{
-	unsigned long flags;
-	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
-
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
-	/* Disable all counters */
-	armv8pmu_pmcr_write(armv8pmu_pmcr_read() & ~ARMV8_PMCR_E);
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
-}
-
-static int armv8pmu_get_event_idx(struct pmu_hw_events *cpuc,
-				  struct hw_perf_event *event)
-{
-	int idx;
-	unsigned long evtype = event->config_base & ARMV8_EVTYPE_EVENT;
-
-	/* Always place a cycle counter into the cycle counter. */
-	if (evtype == ARMV8_PMUV3_PERFCTR_CLOCK_CYCLES) {
-		if (test_and_set_bit(ARMV8_IDX_CYCLE_COUNTER, cpuc->used_mask))
-			return -EAGAIN;
-
-		return ARMV8_IDX_CYCLE_COUNTER;
-	}
-
-	/*
-	 * For anything other than a cycle counter, try and use
-	 * the events counters
-	 */
-	for (idx = ARMV8_IDX_COUNTER0; idx < cpu_pmu->num_events; ++idx) {
-		if (!test_and_set_bit(idx, cpuc->used_mask))
-			return idx;
-	}
-
-	/* The counters are all in use. */
-	return -EAGAIN;
-}
-
-/*
- * Add an event filter to a given event. This will only work for PMUv2 PMUs.
- */
-static int armv8pmu_set_event_filter(struct hw_perf_event *event,
-				     struct perf_event_attr *attr)
-{
-	unsigned long config_base = 0;
-
-	if (attr->exclude_idle)
-		return -EPERM;
-	if (attr->exclude_user)
-		config_base |= ARMV8_EXCLUDE_EL0;
-	if (attr->exclude_kernel)
-		config_base |= ARMV8_EXCLUDE_EL1;
-	if (!attr->exclude_hv)
-		config_base |= ARMV8_INCLUDE_EL2;
-
-	/*
-	 * Install the filter into config_base as this is used to
-	 * construct the event type.
-	 */
-	event->config_base = config_base;
-
-	return 0;
-}
-
-static void armv8pmu_reset(void *info)
-{
-	u32 idx, nb_cnt = cpu_pmu->num_events;
-
-	/* The counter and interrupt enable registers are unknown at reset. */
-	for (idx = ARMV8_IDX_CYCLE_COUNTER; idx < nb_cnt; ++idx)
-		armv8pmu_disable_event(NULL, idx);
-
-	/* Initialize & Reset PMNC: C and P bits. */
-	armv8pmu_pmcr_write(ARMV8_PMCR_P | ARMV8_PMCR_C);
-
-	/* Disable access from userspace. */
-	asm volatile("msr pmuserenr_el0, %0" :: "r" (0));
-}
-
-static int armv8_pmuv3_map_event(struct perf_event *event)
-{
-	return map_cpu_event(event, &armv8_pmuv3_perf_map,
-				&armv8_pmuv3_perf_cache_map,
-				ARMV8_EVTYPE_EVENT);
-}
-
-static struct arm_pmu armv8pmu = {
-	.handle_irq		= armv8pmu_handle_irq,
-	.enable			= armv8pmu_enable_event,
-	.disable		= armv8pmu_disable_event,
-	.read_counter		= armv8pmu_read_counter,
-	.write_counter		= armv8pmu_write_counter,
-	.get_event_idx		= armv8pmu_get_event_idx,
-	.start			= armv8pmu_start,
-	.stop			= armv8pmu_stop,
-	.reset			= armv8pmu_reset,
-	.max_period		= (1LLU << 32) - 1,
-};
-
-static u32 __init armv8pmu_read_num_pmnc_events(void)
-{
-	u32 nb_cnt;
-
-	/* Read the nb of CNTx counters supported from PMNC */
-	nb_cnt = (armv8pmu_pmcr_read() >> ARMV8_PMCR_N_SHIFT) & ARMV8_PMCR_N_MASK;
-
-	/* Add the CPU cycles counter and return */
-	return nb_cnt + 1;
-}
-
-static struct arm_pmu *__init armv8_pmuv3_pmu_init(void)
-{
-	armv8pmu.name			= "arm/armv8-pmuv3";
-	armv8pmu.map_event		= armv8_pmuv3_map_event;
-	armv8pmu.num_events		= armv8pmu_read_num_pmnc_events();
-	armv8pmu.set_event_filter	= armv8pmu_set_event_filter;
-	return &armv8pmu;
-}
-
-/*
- * Ensure the PMU has sane values out of reset.
- * This requires SMP to be available, so exists as a separate initcall.
- */
-static int __init
-cpu_pmu_reset(void)
-{
-	if (cpu_pmu && cpu_pmu->reset)
-		return on_each_cpu(cpu_pmu->reset, NULL, 1);
-	return 0;
-}
-arch_initcall(cpu_pmu_reset);
-
-/*
- * PMU platform driver and devicetree bindings.
- */
-static const struct of_device_id armpmu_of_device_ids[] = {
-	{.compatible = "arm,armv8-pmuv3"},
-	{},
-};
-
-static int armpmu_device_probe(struct platform_device *pdev)
-{
-	int i, irq, *irqs;
-
-	if (!cpu_pmu)
-		return -ENODEV;
-
-	/* Don't bother with PPIs; they're already affine */
-	irq = platform_get_irq(pdev, 0);
-	if (irq >= 0 && irq_is_percpu(irq))
-		goto out;
-
-	irqs = kcalloc(pdev->num_resources, sizeof(*irqs), GFP_KERNEL);
-	if (!irqs)
-		return -ENOMEM;
-
-	for (i = 0; i < pdev->num_resources; ++i) {
-		struct device_node *dn;
-		int cpu;
-
-		dn = of_parse_phandle(pdev->dev.of_node, "interrupt-affinity",
-				      i);
-		if (!dn) {
-			pr_warn("Failed to parse %s/interrupt-affinity[%d]\n",
-				of_node_full_name(pdev->dev.of_node), i);
-			break;
-		}
-
-		for_each_possible_cpu(cpu)
-			if (arch_find_n_match_cpu_physical_id(dn, cpu, NULL))
-				break;
-
-		if (cpu >= nr_cpu_ids) {
-			pr_warn("Failed to find logical CPU for %s\n",
-				dn->name);
-			of_node_put(dn);
-			break;
-		}
-		of_node_put(dn);
-
-		irqs[i] = cpu;
-	}
-
-	if (i == pdev->num_resources)
-		cpu_pmu->irq_affinity = irqs;
-	else
-		kfree(irqs);
-
-out:
-	cpu_pmu->plat_device = pdev;
-	return 0;
-}
-
-static struct platform_driver armpmu_driver = {
-	.driver		= {
-		.name	= "arm-pmu",
-		.of_match_table = armpmu_of_device_ids,
-	},
-	.probe		= armpmu_device_probe,
-};
-
-static int __init register_pmu_driver(void)
-{
-	return platform_driver_register(&armpmu_driver);
-}
-device_initcall(register_pmu_driver);
-
-static struct pmu_hw_events *armpmu_get_cpu_events(void)
-{
-	return this_cpu_ptr(&cpu_hw_events);
-}
-
-static void __init cpu_pmu_init(struct arm_pmu *armpmu)
-{
-	int cpu;
-	for_each_possible_cpu(cpu) {
-		struct pmu_hw_events *events = &per_cpu(cpu_hw_events, cpu);
-		events->events = per_cpu(hw_events, cpu);
-		events->used_mask = per_cpu(used_mask, cpu);
-		raw_spin_lock_init(&events->pmu_lock);
-	}
-	armpmu->get_hw_events = armpmu_get_cpu_events;
-}
-
-static int __init init_hw_perf_events(void)
-{
-	u64 dfr = read_cpuid(ID_AA64DFR0_EL1);
-
-	switch ((dfr >> 8) & 0xf) {
-	case 0x1:	/* PMUv3 */
-		cpu_pmu = armv8_pmuv3_pmu_init();
-		break;
-	}
-
-	if (cpu_pmu) {
-		pr_info("enabled with %s PMU driver, %d counters available\n",
-			cpu_pmu->name, cpu_pmu->num_events);
-		cpu_pmu_init(cpu_pmu);
-		armpmu_register(cpu_pmu, "cpu", PERF_TYPE_RAW);
-	} else {
-		pr_info("no hardware support available\n");
-	}
-
-	return 0;
-}
-early_initcall(init_hw_perf_events);
-
diff --git a/arch/arm64/kernel/perf_event_pmuv3.c b/arch/arm64/kernel/perf_event_pmuv3.c
new file mode 100644
index 0000000..1f3bbf6
--- /dev/null
+++ b/arch/arm64/kernel/perf_event_pmuv3.c
@@ -0,0 +1,653 @@
+/*
+ * PMU support
+ *
+ * Copyright (C) 2014 ARM Limited
+ * Author: Will Deacon <will.deacon@arm.com>
+ *
+ * This code is based heavily on the ARMv7 perf event code.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <asm/irq_regs.h>
+
+#include <linux/of.h>
+#include <linux/perf/arm_pmu.h>
+#include <linux/platform_device.h>
+
+/*
+ * ARMv8 PMUv3 Performance Events handling code.
+ * Common event types.
+ */
+enum armv8_pmuv3_perf_types {
+	/* Required events. */
+	ARMV8_PMUV3_PERFCTR_PMNC_SW_INCR			= 0x00,
+	ARMV8_PMUV3_PERFCTR_L1_DCACHE_REFILL			= 0x03,
+	ARMV8_PMUV3_PERFCTR_L1_DCACHE_ACCESS			= 0x04,
+	ARMV8_PMUV3_PERFCTR_PC_BRANCH_MIS_PRED			= 0x10,
+	ARMV8_PMUV3_PERFCTR_CLOCK_CYCLES			= 0x11,
+	ARMV8_PMUV3_PERFCTR_PC_BRANCH_PRED			= 0x12,
+
+	/* At least one of the following is required. */
+	ARMV8_PMUV3_PERFCTR_INSTR_EXECUTED			= 0x08,
+	ARMV8_PMUV3_PERFCTR_OP_SPEC				= 0x1B,
+
+	/* Common architectural events. */
+	ARMV8_PMUV3_PERFCTR_MEM_READ				= 0x06,
+	ARMV8_PMUV3_PERFCTR_MEM_WRITE				= 0x07,
+	ARMV8_PMUV3_PERFCTR_EXC_TAKEN				= 0x09,
+	ARMV8_PMUV3_PERFCTR_EXC_EXECUTED			= 0x0A,
+	ARMV8_PMUV3_PERFCTR_CID_WRITE				= 0x0B,
+	ARMV8_PMUV3_PERFCTR_PC_WRITE				= 0x0C,
+	ARMV8_PMUV3_PERFCTR_PC_IMM_BRANCH			= 0x0D,
+	ARMV8_PMUV3_PERFCTR_PC_PROC_RETURN			= 0x0E,
+	ARMV8_PMUV3_PERFCTR_MEM_UNALIGNED_ACCESS		= 0x0F,
+	ARMV8_PMUV3_PERFCTR_TTBR_WRITE				= 0x1C,
+
+	/* Common microarchitectural events. */
+	ARMV8_PMUV3_PERFCTR_L1_ICACHE_REFILL			= 0x01,
+	ARMV8_PMUV3_PERFCTR_ITLB_REFILL				= 0x02,
+	ARMV8_PMUV3_PERFCTR_DTLB_REFILL				= 0x05,
+	ARMV8_PMUV3_PERFCTR_MEM_ACCESS				= 0x13,
+	ARMV8_PMUV3_PERFCTR_L1_ICACHE_ACCESS			= 0x14,
+	ARMV8_PMUV3_PERFCTR_L1_DCACHE_WB			= 0x15,
+	ARMV8_PMUV3_PERFCTR_L2_CACHE_ACCESS			= 0x16,
+	ARMV8_PMUV3_PERFCTR_L2_CACHE_REFILL			= 0x17,
+	ARMV8_PMUV3_PERFCTR_L2_CACHE_WB				= 0x18,
+	ARMV8_PMUV3_PERFCTR_BUS_ACCESS				= 0x19,
+	ARMV8_PMUV3_PERFCTR_MEM_ERROR				= 0x1A,
+	ARMV8_PMUV3_PERFCTR_BUS_CYCLES				= 0x1D,
+};
+
+/* PMUv3 HW events mapping. */
+static const unsigned armv8_pmuv3_perf_map[PERF_COUNT_HW_MAX] = {
+	[PERF_COUNT_HW_CPU_CYCLES]		= ARMV8_PMUV3_PERFCTR_CLOCK_CYCLES,
+	[PERF_COUNT_HW_INSTRUCTIONS]		= ARMV8_PMUV3_PERFCTR_INSTR_EXECUTED,
+	[PERF_COUNT_HW_CACHE_REFERENCES]	= ARMV8_PMUV3_PERFCTR_L1_DCACHE_ACCESS,
+	[PERF_COUNT_HW_CACHE_MISSES]		= ARMV8_PMUV3_PERFCTR_L1_DCACHE_REFILL,
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= HW_OP_UNSUPPORTED,
+	[PERF_COUNT_HW_BRANCH_MISSES]		= ARMV8_PMUV3_PERFCTR_PC_BRANCH_MIS_PRED,
+	[PERF_COUNT_HW_BUS_CYCLES]		= HW_OP_UNSUPPORTED,
+	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND]	= HW_OP_UNSUPPORTED,
+	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND]	= HW_OP_UNSUPPORTED,
+};
+
+static const unsigned armv8_pmuv3_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
+						[PERF_COUNT_HW_CACHE_OP_MAX]
+						[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
+	[C(L1D)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_L1_DCACHE_ACCESS,
+			[C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_L1_DCACHE_REFILL,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_L1_DCACHE_ACCESS,
+			[C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_L1_DCACHE_REFILL,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+	},
+	[C(L1I)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+	},
+	[C(LL)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+	},
+	[C(DTLB)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+	},
+	[C(ITLB)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+	},
+	[C(BPU)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_PC_BRANCH_PRED,
+			[C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_PC_BRANCH_MIS_PRED,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_PC_BRANCH_PRED,
+			[C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_PC_BRANCH_MIS_PRED,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+	},
+	[C(NODE)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+	},
+};
+
+/*
+ * Perf Events' indices
+ */
+#define	ARMV8_IDX_CYCLE_COUNTER	0
+#define	ARMV8_IDX_COUNTER0	1
+#define	ARMV8_IDX_COUNTER_LAST(cpu_pmu) \
+	(ARMV8_IDX_CYCLE_COUNTER + cpu_pmu->num_events - 1)
+
+#define	ARMV8_MAX_COUNTERS	32
+#define	ARMV8_COUNTER_MASK	(ARMV8_MAX_COUNTERS - 1)
+
+/*
+ * ARMv8 low level PMU access
+ */
+
+/*
+ * Perf Event to low level counters mapping
+ */
+#define	ARMV8_IDX_TO_COUNTER(x)	\
+	(((x) - ARMV8_IDX_COUNTER0) & ARMV8_COUNTER_MASK)
+
+/*
+ * Per-CPU PMCR: config reg
+ */
+#define ARMV8_PMCR_E		(1 << 0) /* Enable all counters */
+#define ARMV8_PMCR_P		(1 << 1) /* Reset all counters */
+#define ARMV8_PMCR_C		(1 << 2) /* Cycle counter reset */
+#define ARMV8_PMCR_D		(1 << 3) /* CCNT counts every 64th cpu cycle */
+#define ARMV8_PMCR_X		(1 << 4) /* Export to ETM */
+#define ARMV8_PMCR_DP		(1 << 5) /* Disable CCNT if non-invasive debug*/
+#define	ARMV8_PMCR_N_SHIFT	11	 /* Number of counters supported */
+#define	ARMV8_PMCR_N_MASK	0x1f
+#define	ARMV8_PMCR_MASK		0x3f	 /* Mask for writable bits */
+
+/*
+ * PMOVSR: counters overflow flag status reg
+ */
+#define	ARMV8_OVSR_MASK		0xffffffff	/* Mask for writable bits */
+#define	ARMV8_OVERFLOWED_MASK	ARMV8_OVSR_MASK
+
+/*
+ * PMXEVTYPER: Event selection reg
+ */
+#define	ARMV8_EVTYPE_MASK	0xc80003ff	/* Mask for writable bits */
+#define	ARMV8_EVTYPE_EVENT	0x3ff		/* Mask for EVENT bits */
+
+/*
+ * Event filters for PMUv3
+ */
+#define	ARMV8_EXCLUDE_EL1	(1 << 31)
+#define	ARMV8_EXCLUDE_EL0	(1 << 30)
+#define	ARMV8_INCLUDE_EL2	(1 << 27)
+
+static inline u32 armv8pmu_pmcr_read(void)
+{
+	u32 val;
+	asm volatile("mrs %0, pmcr_el0" : "=r" (val));
+	return val;
+}
+
+static inline void armv8pmu_pmcr_write(u32 val)
+{
+	val &= ARMV8_PMCR_MASK;
+	isb();
+	asm volatile("msr pmcr_el0, %0" :: "r" (val));
+}
+
+static inline int armv8pmu_has_overflowed(u32 pmovsr)
+{
+	return pmovsr & ARMV8_OVERFLOWED_MASK;
+}
+
+static inline int armv8pmu_counter_valid(struct arm_pmu *cpu_pmu, int idx)
+{
+	return idx >= ARMV8_IDX_CYCLE_COUNTER &&
+		idx <= ARMV8_IDX_COUNTER_LAST(cpu_pmu);
+}
+
+static inline int armv8pmu_counter_has_overflowed(u32 pmnc, int idx)
+{
+	return pmnc & BIT(ARMV8_IDX_TO_COUNTER(idx));
+}
+
+static inline int armv8pmu_select_counter(int idx)
+{
+	u32 counter = ARMV8_IDX_TO_COUNTER(idx);
+	asm volatile("msr pmselr_el0, %0" :: "r" (counter));
+	isb();
+
+	return idx;
+}
+
+static inline u32 armv8pmu_read_counter(struct perf_event *event)
+{
+	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	int idx = hwc->idx;
+	u32 value = 0;
+
+	if (!armv8pmu_counter_valid(cpu_pmu, idx))
+		pr_err("CPU%u reading wrong counter %d\n",
+			smp_processor_id(), idx);
+	else if (idx == ARMV8_IDX_CYCLE_COUNTER)
+		asm volatile("mrs %0, pmccntr_el0" : "=r" (value));
+	else if (armv8pmu_select_counter(idx) == idx)
+		asm volatile("mrs %0, pmxevcntr_el0" : "=r" (value));
+
+	return value;
+}
+
+static inline void armv8pmu_write_counter(struct perf_event *event, u32 value)
+{
+	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	int idx = hwc->idx;
+
+	if (!armv8pmu_counter_valid(cpu_pmu, idx))
+		pr_err("CPU%u writing wrong counter %d\n",
+			smp_processor_id(), idx);
+	else if (idx == ARMV8_IDX_CYCLE_COUNTER)
+		asm volatile("msr pmccntr_el0, %0" :: "r" (value));
+	else if (armv8pmu_select_counter(idx) == idx)
+		asm volatile("msr pmxevcntr_el0, %0" :: "r" (value));
+}
+
+static inline void armv8pmu_write_evtype(int idx, u32 val)
+{
+	if (armv8pmu_select_counter(idx) == idx) {
+		val &= ARMV8_EVTYPE_MASK;
+		asm volatile("msr pmxevtyper_el0, %0" :: "r" (val));
+	}
+}
+
+static inline int armv8pmu_enable_counter(int idx)
+{
+	u32 counter = ARMV8_IDX_TO_COUNTER(idx);
+	asm volatile("msr pmcntenset_el0, %0" :: "r" (BIT(counter)));
+	return idx;
+}
+
+static inline int armv8pmu_disable_counter(int idx)
+{
+	u32 counter = ARMV8_IDX_TO_COUNTER(idx);
+	asm volatile("msr pmcntenclr_el0, %0" :: "r" (BIT(counter)));
+	return idx;
+}
+
+static inline int armv8pmu_enable_intens(int idx)
+{
+	u32 counter = ARMV8_IDX_TO_COUNTER(idx);
+	asm volatile("msr pmintenset_el1, %0" :: "r" (BIT(counter)));
+	return idx;
+}
+
+static inline int armv8pmu_disable_intens(int idx)
+{
+	u32 counter = ARMV8_IDX_TO_COUNTER(idx);
+	asm volatile("msr pmintenclr_el1, %0" :: "r" (BIT(counter)));
+	isb();
+	/* Clear the overflow flag in case an interrupt is pending. */
+	asm volatile("msr pmovsclr_el0, %0" :: "r" (BIT(counter)));
+	isb();
+
+	return idx;
+}
+
+static inline u32 armv8pmu_getreset_flags(void)
+{
+	u32 value;
+
+	/* Read */
+	asm volatile("mrs %0, pmovsclr_el0" : "=r" (value));
+
+	/* Write to clear flags */
+	value &= ARMV8_OVSR_MASK;
+	asm volatile("msr pmovsclr_el0, %0" :: "r" (value));
+
+	return value;
+}
+
+static void armv8pmu_enable_event(struct perf_event *event)
+{
+	unsigned long flags;
+	struct hw_perf_event *hwc = &event->hw;
+	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
+	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
+	int idx = hwc->idx;
+
+	/*
+	 * Enable counter and interrupt, and set the counter to count
+	 * the event that we're interested in.
+	 */
+	raw_spin_lock_irqsave(&events->pmu_lock, flags);
+
+	/*
+	 * Disable counter
+	 */
+	armv8pmu_disable_counter(idx);
+
+	/*
+	 * Set event (if destined for PMNx counters).
+	 */
+	armv8pmu_write_evtype(idx, hwc->config_base);
+
+	/*
+	 * Enable interrupt for this counter
+	 */
+	armv8pmu_enable_intens(idx);
+
+	/*
+	 * Enable counter
+	 */
+	armv8pmu_enable_counter(idx);
+
+	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
+}
+
+static void armv8pmu_disable_event(struct perf_event *event)
+{
+	unsigned long flags;
+	struct hw_perf_event *hwc = &event->hw;
+	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
+	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
+	int idx = hwc->idx;
+
+	/*
+	 * Disable counter and interrupt
+	 */
+	raw_spin_lock_irqsave(&events->pmu_lock, flags);
+
+	/*
+	 * Disable counter
+	 */
+	armv8pmu_disable_counter(idx);
+
+	/*
+	 * Disable interrupt for this counter
+	 */
+	armv8pmu_disable_intens(idx);
+
+	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
+}
+
+static irqreturn_t armv8pmu_handle_irq(int irq_num, void *dev)
+{
+	u32 pmovsr;
+	struct perf_sample_data data;
+	struct arm_pmu *cpu_pmu = (struct arm_pmu *)dev;
+	struct pmu_hw_events *cpuc = this_cpu_ptr(cpu_pmu->hw_events);
+	struct pt_regs *regs;
+	int idx;
+
+	/*
+	 * Get and reset the IRQ flags
+	 */
+	pmovsr = armv8pmu_getreset_flags();
+
+	/*
+	 * Did an overflow occur?
+	 */
+	if (!armv8pmu_has_overflowed(pmovsr))
+		return IRQ_NONE;
+
+	/*
+	 * Handle the counter(s) overflow(s)
+	 */
+	regs = get_irq_regs();
+
+	for (idx = 0; idx < cpu_pmu->num_events; ++idx) {
+		struct perf_event *event = cpuc->events[idx];
+		struct hw_perf_event *hwc;
+
+		/* Ignore if we don't have an event. */
+		if (!event)
+			continue;
+
+		/*
+		 * We have a single interrupt for all counters. Check that
+		 * each counter has overflowed before we process it.
+		 */
+		if (!armv8pmu_counter_has_overflowed(pmovsr, idx))
+			continue;
+
+		hwc = &event->hw;
+		armpmu_event_update(event);
+		perf_sample_data_init(&data, 0, hwc->last_period);
+		if (!armpmu_event_set_period(event))
+			continue;
+
+		if (perf_event_overflow(event, &data, regs))
+			cpu_pmu->disable(event);
+	}
+
+	/*
+	 * Handle the pending perf events.
+	 *
+	 * Note: this call *must* be run with interrupts disabled. For
+	 * platforms that can have the PMU interrupts raised as an NMI, this
+	 * will not work.
+	 */
+	irq_work_run();
+
+	return IRQ_HANDLED;
+}
+
+static void armv8pmu_start(struct arm_pmu *cpu_pmu)
+{
+	unsigned long flags;
+	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
+	
+	raw_spin_lock_irqsave(&events->pmu_lock, flags);
+	/* Enable all counters */
+	armv8pmu_pmcr_write(armv8pmu_pmcr_read() | ARMV8_PMCR_E);
+	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
+}
+
+static void armv8pmu_stop(struct arm_pmu *cpu_pmu)
+{
+	unsigned long flags;
+	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
+
+	raw_spin_lock_irqsave(&events->pmu_lock, flags);
+	/* Disable all counters */
+	armv8pmu_pmcr_write(armv8pmu_pmcr_read() & ~ARMV8_PMCR_E);
+	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
+}
+
+static int armv8pmu_get_event_idx(struct pmu_hw_events *cpuc,
+				  struct perf_event *event)
+{
+	int idx;
+	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	unsigned long evtype = hwc->config_base & ARMV8_EVTYPE_EVENT;
+
+	/* Always place a cycle counter into the cycle counter. */
+	if (evtype == ARMV8_PMUV3_PERFCTR_CLOCK_CYCLES) {
+		if (test_and_set_bit(ARMV8_IDX_CYCLE_COUNTER, cpuc->used_mask))
+			return -EAGAIN;
+
+		return ARMV8_IDX_CYCLE_COUNTER;
+	}
+
+	/*
+	 * For anything other than a cycle counter, try and use
+	 * the events counters
+	 */
+	for (idx = ARMV8_IDX_COUNTER0; idx < cpu_pmu->num_events; ++idx) {
+		if (!test_and_set_bit(idx, cpuc->used_mask))
+			return idx;
+	}
+
+	/* The counters are all in use. */
+	return -EAGAIN;
+}
+
+/*
+ * Add an event filter to a given event. This will only work for PMUv2 PMUs.
+ */
+static int armv8pmu_set_event_filter(struct hw_perf_event *event,
+				     struct perf_event_attr *attr)
+{
+	unsigned long config_base = 0;
+
+	if (attr->exclude_idle)
+		return -EPERM;
+	if (attr->exclude_user)
+		config_base |= ARMV8_EXCLUDE_EL0;
+	if (attr->exclude_kernel)
+		config_base |= ARMV8_EXCLUDE_EL1;
+	if (!attr->exclude_hv)
+		config_base |= ARMV8_INCLUDE_EL2;
+
+	/*
+	 * Install the filter into config_base as this is used to
+	 * construct the event type.
+	 */
+	event->config_base = config_base;
+
+	return 0;
+}
+
+static void armv8pmu_reset(void *info)
+{
+	struct arm_pmu *cpu_pmu = (struct arm_pmu *)info;
+	u32 idx, nb_cnt = cpu_pmu->num_events;
+
+	/* The counter and interrupt enable registers are unknown at reset. */
+	for (idx = ARMV8_IDX_CYCLE_COUNTER; idx < nb_cnt; ++idx) {
+		armv8pmu_disable_counter(idx);
+		armv8pmu_disable_intens(idx);
+	}
+
+	/* Initialize & Reset PMNC: C and P bits. */
+	armv8pmu_pmcr_write(ARMV8_PMCR_P | ARMV8_PMCR_C);
+
+	/* Disable access from userspace. */
+	asm volatile("msr pmuserenr_el0, %0" :: "r" (0));
+}
+
+static int armv8_pmuv3_map_event(struct perf_event *event)
+{
+	return armpmu_map_event(event, &armv8_pmuv3_perf_map,
+				&armv8_pmuv3_perf_cache_map,
+				ARMV8_EVTYPE_EVENT);
+}
+
+static void armv8pmu_read_num_pmnc_events(void *info)
+{
+	int *nb_cnt = info;
+
+	/* Read the nb of CNTx counters supported from PMNC */
+	*nb_cnt = (armv8pmu_pmcr_read() >> ARMV8_PMCR_N_SHIFT) & ARMV8_PMCR_N_MASK;
+
+	/* Add the CPU cycles counter */
+	*nb_cnt += 1;
+}
+
+static int armv8pmu_probe_num_events(struct arm_pmu *arm_pmu)
+{
+	return smp_call_function_any(&arm_pmu->supported_cpus,
+				    armv8pmu_read_num_pmnc_events,
+				    &arm_pmu->num_events, 1);
+}
+
+static int armv8_pmuv3_init(struct arm_pmu *cpu_pmu)
+{
+	cpu_pmu->handle_irq		= armv8pmu_handle_irq,
+	cpu_pmu->enable			= armv8pmu_enable_event,
+	cpu_pmu->disable		= armv8pmu_disable_event,
+	cpu_pmu->read_counter		= armv8pmu_read_counter,
+	cpu_pmu->write_counter		= armv8pmu_write_counter,
+	cpu_pmu->get_event_idx		= armv8pmu_get_event_idx,
+	cpu_pmu->start			= armv8pmu_start,
+	cpu_pmu->stop			= armv8pmu_stop,
+	cpu_pmu->reset			= armv8pmu_reset,
+	cpu_pmu->max_period		= (1LLU << 32) - 1,
+	cpu_pmu->name			= "armv8_pmuv3";
+	cpu_pmu->map_event		= armv8_pmuv3_map_event;
+	cpu_pmu->set_event_filter	= armv8pmu_set_event_filter;
+	return armv8pmu_probe_num_events(cpu_pmu);
+}
+
+static const struct of_device_id armv8_pmu_of_device_ids[] = {
+	{.compatible = "arm,armv8-pmuv3",	.data = armv8_pmuv3_init},
+	{},
+};
+
+static int armv8_pmu_device_probe(struct platform_device *pdev)
+{
+	return arm_pmu_device_probe(pdev, armv8_pmu_of_device_ids, NULL);
+}
+
+static struct platform_driver armv8_pmu_driver = {
+	.driver		= {
+		.name	= "armv8-pmu",
+		.of_match_table = armv8_pmu_of_device_ids,
+	},
+	.probe		= armv8_pmu_device_probe,
+};
+
+static int __init register_armv8_pmu_driver(void)
+{
+	return platform_driver_register(&armv8_pmu_driver);
+}
+device_initcall(register_armv8_pmu_driver);
diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index f556b92ae..5cac510 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -5,7 +5,7 @@
 menu "Performance monitor support"
 
 config ARM_PMU
-	depends on PERF_EVENTS && ARM
+	depends on PERF_EVENTS && (ARM || ARM64)
 	bool "ARM PMU framework"
 	default y
 	help
-- 
1.9.1
