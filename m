From: agustinv@codeaurora.org (Agustin Vega-Frias)
Date: Fri, 18 Mar 2016 16:37:02 -0400
Subject: [PATCH V1] perf: qcom: Add L3 cache PMU driver
Message-ID: <1458333422-8963-1-git-send-email-agustinv@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a new dynamic PMU to the Perf Events framework to program
and control the L3 cache PMUs in some Qualcomm Technologies SOCs.

The driver supports a distributed cache architecture where the overall
cache is comprised of multiple slices each with its own PMU. The driver
aggregates counts across the whole system to provide a global picture
of the metrics selected by the user.

The driver exports formatting and event information to sysfs so it can
be used by the perf user space tools with the syntaxes:
   perf stat -a -e l3cache/read-miss/
   perf stat -a -e l3cache/event=0x21/

Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>
---
 arch/arm64/kernel/Makefile                   |   4 +
 arch/arm64/kernel/perf_event_qcom_l3_cache.c | 816 +++++++++++++++++++++++++++
 2 files changed, 820 insertions(+)
 create mode 100644 arch/arm64/kernel/perf_event_qcom_l3_cache.c

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 83cd7e6..eff5dea 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -43,6 +43,10 @@ arm64-obj-$(CONFIG_ARMV8_DEPRECATED)	+= armv8_deprecated.o
 arm64-obj-$(CONFIG_ACPI)		+= acpi.o
 arm64-obj-$(CONFIG_PARAVIRT)		+= paravirt.o
 
+ifeq ($(CONFIG_ARCH_QCOM), y)
+arm64-obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event_qcom_l3_cache.o
+endif
+
 obj-y					+= $(arm64-obj-y) vdso/
 obj-m					+= $(arm64-obj-m)
 head-y					:= head.o
diff --git a/arch/arm64/kernel/perf_event_qcom_l3_cache.c b/arch/arm64/kernel/perf_event_qcom_l3_cache.c
new file mode 100644
index 0000000..89b5ceb
--- /dev/null
+++ b/arch/arm64/kernel/perf_event_qcom_l3_cache.c
@@ -0,0 +1,816 @@
+/* Copyright (c) 2015-2016, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/bitops.h>
+#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/list.h>
+#include <linux/acpi.h>
+#include <linux/perf_event.h>
+#include <linux/platform_device.h>
+
+/*
+ * Driver for the L3 cache PMUs in Qualcomm Technologies chips.
+ *
+ * The driver supports a distributed cache architecture where the overall
+ * cache is comprised of multiple slices each with its own PMU. The driver
+ * aggregates counts across the whole system to provide a global picture
+ * of the metrics selected by the user.
+ */
+
+/*
+ * General constants
+ */
+
+#define L3_NUM_COUNTERS  (8)
+#define L3_MAX_EVTYPE    (0xFF)
+#define L3_MAX_PERIOD    U32_MAX
+#define L3_CNT_PERIOD    (U32_MAX - 0xFFFF)
+
+/*
+ * Register offsets
+ */
+
+/* Perfmon registers */
+#define L3_HML3_PM_CR       0x000
+#define L3_HML3_PM_EVCNTR(__cntr) (0x040 + ((__cntr) & 0x7) * 8)
+#define L3_HML3_PM_CNTCTL(__cntr) (0x200 + ((__cntr) & 0x7) * 8)
+#define L3_HML3_PM_EVTYPE(__cntr) (0x240 + ((__cntr) & 0x7) * 8)
+#define L3_HML3_PM_FILTRA   0x460
+#define L3_HML3_PM_FILTRB   0x464
+#define L3_HML3_PM_FILTRC   0x468
+#define L3_HML3_PM_FILTRAM  0x470
+#define L3_HML3_PM_FILTRBM  0x474
+#define L3_HML3_PM_FILTRCM  0x478
+
+/* Basic counter registers */
+#define L3_M_BC_CR         0x500
+#define L3_M_BC_SATROLL_CR 0x504
+#define L3_M_BC_CNTENSET   0x508
+#define L3_M_BC_CNTENCLR   0x50C
+#define L3_M_BC_INTENSET   0x510
+#define L3_M_BC_INTENCLR   0x514
+#define L3_M_BC_GANG       0x718
+#define L3_M_BC_OVSR       0x740
+
+/*
+ * Bit field manipulators
+ */
+
+/* L3_HML3_PM_CR */
+#define PM_CR_RESET      (0)
+
+/* L3_HML3_PM_XCNTCTL/L3_HML3_PM_CNTCTLx */
+#define PMCNT_RESET            (0)
+
+/* L3_HML3_PM_EVTYPEx */
+#define EVSEL(__val)       ((u32)((__val) & 0xFF))
+
+/* Reset value for all the filter registers */
+#define PM_FLTR_RESET      (0)
+
+/* L3_M_BC_CR */
+#define BC_RETRIEVAL_MODE  (((u32)1) << 2)
+#define BC_RESET           (((u32)1) << 1)
+#define BC_ENABLE          ((u32)1)
+
+/* L3_M_BC_SATROLL_CR */
+#define BC_SATROLL_CR_RESET  (0)
+
+/* L3_M_BC_CNTENSET */
+#define PMCNTENSET(__cntr)  (((u32)1) << ((__cntr) & 0x7))
+
+/* L3_M_BC_CNTENCLR */
+#define PMCNTENCLR(__cntr)  (((u32)1) << ((__cntr) & 0x7))
+#define BC_CNTENCLR_RESET   (0xFF)
+
+/* L3_M_BC_INTENSET */
+#define PMINTENSET(__cntr)  (((u32)1) << ((__cntr) & 0x7))
+
+/* L3_M_BC_INTENCLR */
+#define PMINTENCLR(__cntr)  (((u32)1) << ((__cntr) & 0x7))
+#define BC_INTENCLR_RESET   (0xFF)
+
+/* L3_M_BC_GANG */
+#define BC_GANG_RESET    (0)
+
+/* L3_M_BC_OVSR */
+#define PMOVSRCLR(__cntr)  (((u32)1) << ((__cntr) & 0x7))
+#define PMOVSRCLR_RESET    (0xFF)
+
+/*
+ * Events
+ */
+
+#define L3_CYCLES		0x01
+#define L3_READ_HIT		0x20
+#define L3_READ_MISS		0x21
+#define L3_READ_HIT_D		0x22
+#define L3_READ_MISS_D		0x23
+#define L3_WRITE_HIT		0x24
+#define L3_WRITE_MISS		0x25
+
+/*
+ * The cache is made-up of one or more slices, each slice has its own PMU.
+ * This structure represents one of the hardware PMUs.
+ */
+struct hml3_pmu {
+	struct list_head	entry;
+	void __iomem		*regs;
+	u32			inten;
+	atomic_t		prev_count[L3_NUM_COUNTERS];
+};
+
+static
+void hml3_pmu__reset(struct hml3_pmu *pmu)
+{
+	int i;
+
+	writel_relaxed(BC_RESET, pmu->regs + L3_M_BC_CR);
+
+	/*
+	 * Use writel for the first programming command to ensure the basic
+	 * counter unit is stopped before proceeding
+	 */
+	writel(BC_SATROLL_CR_RESET, pmu->regs + L3_M_BC_SATROLL_CR);
+	writel_relaxed(BC_CNTENCLR_RESET, pmu->regs + L3_M_BC_CNTENCLR);
+	writel_relaxed(BC_INTENCLR_RESET, pmu->regs + L3_M_BC_INTENCLR);
+	writel_relaxed(BC_GANG_RESET, pmu->regs + L3_M_BC_GANG);
+	writel_relaxed(PMOVSRCLR_RESET, pmu->regs + L3_M_BC_OVSR);
+
+	writel_relaxed(PM_CR_RESET, pmu->regs + L3_HML3_PM_CR);
+	for (i = 0; i < L3_NUM_COUNTERS; ++i) {
+		writel_relaxed(PMCNT_RESET, pmu->regs + L3_HML3_PM_CNTCTL(i));
+		writel_relaxed(EVSEL(0), pmu->regs + L3_HML3_PM_EVTYPE(i));
+	}
+	writel_relaxed(PM_FLTR_RESET, pmu->regs + L3_HML3_PM_FILTRA);
+	writel_relaxed(PM_FLTR_RESET, pmu->regs + L3_HML3_PM_FILTRB);
+	writel_relaxed(PM_FLTR_RESET, pmu->regs + L3_HML3_PM_FILTRC);
+	writel_relaxed(PM_FLTR_RESET, pmu->regs + L3_HML3_PM_FILTRAM);
+	writel_relaxed(PM_FLTR_RESET, pmu->regs + L3_HML3_PM_FILTRBM);
+	writel_relaxed(PM_FLTR_RESET, pmu->regs + L3_HML3_PM_FILTRCM);
+	pmu->inten = 0;
+}
+
+static inline
+void hml3_pmu__init(struct hml3_pmu *pmu, void __iomem *regs)
+{
+	pmu->regs = regs;
+	hml3_pmu__reset(pmu);
+
+	/*
+	 * Use writel here to ensure all programming commands are done
+	 *  before proceeding
+	 */
+	writel(BC_ENABLE, pmu->regs + L3_M_BC_CR);
+}
+
+static inline
+void hml3_pmu__deinit(struct hml3_pmu *pmu)
+{
+	hml3_pmu__reset(pmu);
+}
+
+static inline
+void hml3_pmu__enable(struct hml3_pmu *pmu)
+{
+	writel_relaxed(BC_ENABLE, pmu->regs + L3_M_BC_CR);
+}
+
+static inline
+void hml3_pmu__disable(struct hml3_pmu *pmu)
+{
+	writel_relaxed(0, pmu->regs + L3_M_BC_CR);
+}
+
+static inline
+void hml3_pmu__counter_set_event(struct hml3_pmu *pmu, u8 cntr, u32 event)
+{
+	writel_relaxed(EVSEL(event), pmu->regs + L3_HML3_PM_EVTYPE(cntr));
+}
+
+static inline
+void hml3_pmu__counter_set_value(struct hml3_pmu *pmu, u8 cntr, u32 value)
+{
+	writel_relaxed(value, pmu->regs + L3_HML3_PM_EVCNTR(cntr));
+}
+
+static inline
+u32 hml3_pmu__counter_get_value(struct hml3_pmu *pmu, u8 cntr)
+{
+	return readl_relaxed(pmu->regs + L3_HML3_PM_EVCNTR(cntr));
+}
+
+static inline
+void hml3_pmu__counter_enable(struct hml3_pmu *pmu, u8 cntr)
+{
+	writel_relaxed(PMCNTENSET(cntr), pmu->regs + L3_M_BC_CNTENSET);
+}
+
+static inline
+void hml3_pmu__counter_reset_trigger(struct hml3_pmu *pmu, u8 cntr)
+{
+	writel_relaxed(PMCNT_RESET, pmu->regs + L3_HML3_PM_CNTCTL(cntr));
+}
+
+static inline
+void hml3_pmu__counter_disable(struct hml3_pmu *pmu, u8 cntr)
+{
+	writel_relaxed(PMCNTENCLR(cntr), pmu->regs + L3_M_BC_CNTENCLR);
+}
+
+static inline
+void hml3_pmu__counter_enable_interrupt(struct hml3_pmu *pmu, u8 cntr)
+{
+	writel_relaxed(PMINTENSET(cntr), pmu->regs + L3_M_BC_INTENSET);
+	pmu->inten |= PMINTENSET(cntr);
+}
+
+static inline
+void hml3_pmu__counter_disable_interrupt(struct hml3_pmu *pmu, u8 cntr)
+{
+	writel_relaxed(PMINTENCLR(cntr), pmu->regs + L3_M_BC_INTENCLR);
+	pmu->inten &= ~(PMINTENCLR(cntr));
+}
+
+static inline
+u32 hml3_pmu__getreset_ovsr(struct hml3_pmu *pmu)
+{
+	u32 result = readl_relaxed(pmu->regs + L3_M_BC_OVSR);
+
+	writel_relaxed(result, pmu->regs + L3_M_BC_OVSR);
+	return result;
+}
+
+static inline
+int hml3_pmu__has_overflowed(u32 ovsr)
+{
+	return (ovsr & PMOVSRCLR_RESET) != 0;
+}
+
+static inline
+int hml3_pmu__counter_has_overflowed(u32 ovsr, u8 cntr)
+{
+	return (ovsr & PMOVSRCLR(cntr)) != 0;
+}
+
+/*
+ * Decoding of settings from perf_event_attr
+ *
+ * The config format for perf events is:
+ * - config: bits 0-7: event type
+ *           bit  32:  HW counter size requested, 0: 32 bits, 1: 64 bits
+ */
+static inline u32 get_event_type(struct perf_event *event)
+{
+	return (event->attr.config) & L3_MAX_EVTYPE;
+}
+
+/*
+ * Aggregate PMU. Implements the core pmu functions and manages
+ * the hardware PMU, configuring each one in the same way and
+ * aggregating events when needed.
+ */
+
+struct l3cache_pmu {
+	u32			num_pmus;
+	atomic_t		cpu;
+	struct list_head	pmus;
+	unsigned long		used_mask[BITS_TO_LONGS(L3_NUM_COUNTERS)];
+	struct perf_event	*events[L3_NUM_COUNTERS];
+	struct pmu		pmu;
+};
+
+#define to_l3cache_pmu(p) (container_of(p, struct l3cache_pmu, pmu))
+
+static struct l3cache_pmu l3cache_pmu = { 0 };
+
+static
+void qcom_l3_cache__event_update_from_slice(struct perf_event *event,
+					    struct hml3_pmu *slice)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	u32 delta, prev, now;
+
+again:
+	prev = atomic_read(&slice->prev_count[hwc->idx]);
+	now = hml3_pmu__counter_get_value(slice, hwc->idx);
+
+	if (atomic_cmpxchg(&slice->prev_count[hwc->idx], prev, now) != prev)
+		goto again;
+
+	delta = now - prev;
+
+	local64_add(delta, &event->count);
+}
+
+static
+void qcom_l3_cache__slice_set_period(struct hml3_pmu *slice, int idx, u32 prev)
+{
+	u32 value = L3_MAX_PERIOD - (L3_CNT_PERIOD - 1);
+
+	if (prev < value) {
+		value += prev;
+		atomic_set(&slice->prev_count[idx], value);
+	} else {
+		value = prev;
+	}
+	hml3_pmu__counter_set_value(slice, idx, value);
+}
+
+static
+int qcom_l3_cache__get_event_idx(struct l3cache_pmu *system)
+{
+	int idx;
+
+	for (idx = 0; idx < L3_NUM_COUNTERS; ++idx) {
+		if (!test_and_set_bit(idx, system->used_mask))
+			return idx;
+	}
+
+	/* The counters are all in use. */
+	return -EAGAIN;
+}
+
+static
+irqreturn_t qcom_l3_cache__handle_irq(int irq_num, void *data)
+{
+	struct hml3_pmu *slice = data;
+	u32 status;
+	int idx;
+
+	status = hml3_pmu__getreset_ovsr(slice);
+	if (!hml3_pmu__has_overflowed(status))
+		return IRQ_NONE;
+
+	while (status) {
+		struct perf_event *event;
+
+		idx = __ffs(status);
+		status &= ~(1 << idx);
+		event = l3cache_pmu.events[idx];
+		if (!event)
+			continue;
+
+		qcom_l3_cache__event_update_from_slice(event, slice);
+		qcom_l3_cache__slice_set_period(slice, idx,
+					atomic_read(&slice->prev_count[idx]));
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
+/*
+ * Implementation of abstract pmu functionality required by
+ * the core perf events code.
+ */
+
+static
+void qcom_l3_cache__pmu_enable(struct pmu *pmu)
+{
+	struct l3cache_pmu *system = to_l3cache_pmu(pmu);
+	struct hml3_pmu *slice;
+	int idx;
+
+	/*
+	 * Re-write CNTCTL for all existing events to re-assert
+	 * the start trigger.
+	 */
+	for (idx = 0; idx < L3_NUM_COUNTERS; idx++)
+		if (system->events[idx])
+			list_for_each_entry(slice, &system->pmus, entry)
+				hml3_pmu__counter_reset_trigger(slice, idx);
+
+	/* Ensure all programming commands are done before proceeding */
+	wmb();
+	list_for_each_entry(slice, &system->pmus, entry)
+		hml3_pmu__enable(slice);
+}
+
+static
+void qcom_l3_cache__pmu_disable(struct pmu *pmu)
+{
+	struct l3cache_pmu *system = to_l3cache_pmu(pmu);
+	struct hml3_pmu *slice;
+
+	list_for_each_entry(slice, &system->pmus, entry)
+		hml3_pmu__disable(slice);
+
+	/* Ensure the basic counter unit is stopped before proceeding */
+	wmb();
+}
+
+static
+int qcom_l3_cache__event_init(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (event->attr.type != l3cache_pmu.pmu.type)
+		return -ENOENT;
+
+	/*
+	 * There are no per-counter mode filters in the PMU.
+	 */
+	if (event->attr.exclude_user || event->attr.exclude_kernel ||
+	    event->attr.exclude_hv || event->attr.exclude_idle)
+		return -EINVAL;
+
+	hwc->idx = -1;
+
+	/*
+	 * Sampling not supported since these events are not core-attributable.
+	 */
+	if (hwc->sample_period)
+		return -EINVAL;
+
+	/*
+	 * Task mode not available, we run the counters as system counters,
+	 * not attributable to any CPU and therefore cannot attribute per-task.
+	 */
+	if (event->cpu < 0)
+		return -EINVAL;
+
+	return 0;
+}
+
+static
+void qcom_l3_cache__event_update(struct perf_event *event)
+{
+	struct l3cache_pmu *system = to_l3cache_pmu(event->pmu);
+	struct hml3_pmu *slice;
+
+	list_for_each_entry(slice, &system->pmus, entry)
+		qcom_l3_cache__event_update_from_slice(event, slice);
+}
+
+static
+void qcom_l3_cache__event_start(struct perf_event *event, int flags)
+{
+	struct l3cache_pmu *system = to_l3cache_pmu(event->pmu);
+	struct hml3_pmu *slice;
+	struct hw_perf_event *hwc = &event->hw;
+	int idx = hwc->idx;
+	u32 event_type = get_event_type(event);
+
+	hwc->state = 0;
+
+	if (flags & PERF_EF_RELOAD)
+		WARN_ON(system->num_pmus != 1);
+
+	list_for_each_entry(slice, &system->pmus, entry) {
+		qcom_l3_cache__slice_set_period(slice, hwc->idx, 0);
+		hml3_pmu__counter_set_event(slice, idx, event_type);
+		hml3_pmu__counter_enable_interrupt(slice, idx);
+		hml3_pmu__counter_enable(slice, idx);
+	}
+}
+
+static
+void qcom_l3_cache__event_stop(struct perf_event *event, int flags)
+{
+	struct l3cache_pmu *system = to_l3cache_pmu(event->pmu);
+	struct hml3_pmu *slice;
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (!(hwc->state & PERF_HES_STOPPED)) {
+		list_for_each_entry(slice, &system->pmus, entry) {
+			hml3_pmu__counter_disable_interrupt(slice, hwc->idx);
+			hml3_pmu__counter_disable(slice, hwc->idx);
+		}
+
+		if (flags & PERF_EF_UPDATE)
+			qcom_l3_cache__event_update(event);
+		hwc->state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
+	}
+}
+
+static
+int qcom_l3_cache__event_add(struct perf_event *event, int flags)
+{
+	struct l3cache_pmu *system = to_l3cache_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	int idx;
+	int prev_cpu;
+	int err = 0;
+
+	/*
+	 * We need to disable the pmu while adding the event, otherwise
+	 * the perf tick might kick-in and re-add this event.
+	 */
+	perf_pmu_disable(event->pmu);
+
+	/*
+	 * This ensures all events are on the same CPU context. No need to open
+	 * these on all CPUs since they are system events. The strategy here is
+	 * to set system->cpu when the first event is created and from that
+	 * point on, only events in the same CPU context will be allowed to be
+	 * active. system->cpu will get reset back to -1 when the last event
+	 * is deleted, please see qcom_l3_cache__event_del below.
+	 */
+	prev_cpu = atomic_cmpxchg(&system->cpu, -1, event->cpu);
+	if ((event->cpu != prev_cpu) && (prev_cpu != -1)) {
+		err = -EAGAIN;
+		goto out;
+	}
+
+	/*
+	 * Try to allocate a counter.
+	 */
+	idx = qcom_l3_cache__get_event_idx(system);
+	if (idx < 0) {
+		err = idx;
+		goto out;
+	}
+
+	hwc->idx = idx;
+	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
+	system->events[idx] = event;
+
+	if (flags & PERF_EF_START)
+		qcom_l3_cache__event_start(event, flags);
+
+	/* Propagate changes to the userspace mapping. */
+	perf_event_update_userpage(event);
+
+out:
+	perf_pmu_enable(event->pmu);
+	return err;
+}
+
+static
+void qcom_l3_cache__event_del(struct perf_event *event, int flags)
+{
+	struct l3cache_pmu *system = to_l3cache_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	qcom_l3_cache__event_stop(event, flags | PERF_EF_UPDATE);
+	system->events[hwc->idx] = NULL;
+	clear_bit(hwc->idx, system->used_mask);
+
+	/*
+	 * If this is the last event, reset &system->cpu to allow the next
+	 * event to be created in any CPU context.
+	 */
+	if (find_first_bit(system->used_mask, L3_NUM_COUNTERS) ==
+	    L3_NUM_COUNTERS)
+		atomic_set(&system->cpu, -1);
+
+	perf_event_update_userpage(event);
+}
+
+static
+void qcom_l3_cache__event_read(struct perf_event *event)
+{
+	qcom_l3_cache__event_update(event);
+}
+
+static
+int dummy_event_idx(struct perf_event *event)
+{
+	return 0;
+}
+
+/*
+ * Export nodes so perf user space can create events symbolically. E.g.:
+ *   perf stat -a -e l3cache/read-miss/ ls
+ *   perf stat -a -e l3cache/event=0x21/ ls
+ */
+
+ssize_t l3cache_pmu_event_sysfs_show(struct device *dev,
+				     struct device_attribute *attr, char *page)
+{
+	struct perf_pmu_events_attr *pmu_attr;
+
+	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
+	return sprintf(page, "event=0x%02llx,name=%s\n",
+		       pmu_attr->id, attr->attr.name);
+}
+
+#define L3CACHE_EVENT_VAR(__id)	pmu_event_attr_##__id
+#define L3CACHE_EVENT_PTR(__id)	(&L3CACHE_EVENT_VAR(__id).attr.attr)
+
+#define L3CACHE_EVENT_ATTR(__name, __id)			\
+	PMU_EVENT_ATTR(__name, L3CACHE_EVENT_VAR(__id), __id,	\
+		       l3cache_pmu_event_sysfs_show)
+
+
+L3CACHE_EVENT_ATTR(cycles, L3_CYCLES);
+L3CACHE_EVENT_ATTR(read-hit, L3_READ_HIT);
+L3CACHE_EVENT_ATTR(read-miss, L3_READ_MISS);
+L3CACHE_EVENT_ATTR(read-hit-d-side, L3_READ_HIT_D);
+L3CACHE_EVENT_ATTR(read-miss-d-side, L3_READ_MISS_D);
+L3CACHE_EVENT_ATTR(write-hit, L3_WRITE_HIT);
+L3CACHE_EVENT_ATTR(write-miss, L3_WRITE_MISS);
+
+static struct attribute *qcom_l3_cache_pmu_events[] = {
+	L3CACHE_EVENT_PTR(L3_CYCLES),
+	L3CACHE_EVENT_PTR(L3_READ_HIT),
+	L3CACHE_EVENT_PTR(L3_READ_MISS),
+	L3CACHE_EVENT_PTR(L3_READ_HIT_D),
+	L3CACHE_EVENT_PTR(L3_READ_MISS_D),
+	L3CACHE_EVENT_PTR(L3_WRITE_HIT),
+	L3CACHE_EVENT_PTR(L3_WRITE_MISS),
+	NULL
+};
+
+static struct attribute_group qcom_l3_cache_pmu_events_group = {
+	.name = "events",
+	.attrs = qcom_l3_cache_pmu_events,
+};
+
+PMU_FORMAT_ATTR(event, "config:0-7");
+static struct attribute *qcom_l3_cache_pmu_formats[] = {
+	&format_attr_event.attr,
+	NULL,
+};
+
+static struct attribute_group qcom_l3_cache_pmu_format_group = {
+	.name = "format",
+	.attrs = qcom_l3_cache_pmu_formats,
+};
+
+static const struct attribute_group *qcom_l3_cache_pmu_attr_grps[] = {
+	&qcom_l3_cache_pmu_format_group,
+	&qcom_l3_cache_pmu_events_group,
+	NULL,
+};
+
+/*
+ * Probing functions and data.
+ */
+
+/*
+ * In some platforms interrupt resources might not come directly from the GIC,
+ * but from separate IRQ circuitry that signals a summary IRQ to the GIC and
+ * is handled by a secondary IRQ controller. This is problematic under ACPI boot
+ * because the ACPI core does not use the Resource Source field on the Extended
+ * Interrupt Descriptor, which in theory could be used to specify an alternative
+ * IRQ controller.
+
+ * For this reason in these platforms we implement the secondary IRQ controller
+ * using the gpiolib and specify the IRQs as GpioInt resources, so when getting
+ * an IRQ from the device we first try platform_get_irq and if it fails we try
+ * devm_gpiod_get_index/gpiod_to_irq.
+ */
+static
+int qcom_l3_cache_pmu_get_slice_irq(struct platform_device *pdev,
+				    struct platform_device *sdev)
+{
+	int virq = platform_get_irq(sdev, 0);
+	struct gpio_desc *desc;
+
+	if (virq >= 0)
+		return virq;
+
+	desc = devm_gpiod_get_index(&sdev->dev, NULL, 0, GPIOD_ASIS);
+	if (IS_ERR(desc))
+		return -ENOENT;
+
+	return gpiod_to_irq(desc);
+}
+
+static int qcom_l3_cache_pmu_probe_slice(struct device *dev, void *data)
+{
+	struct platform_device *pdev = to_platform_device(dev->parent);
+	struct platform_device *sdev = to_platform_device(dev);
+	struct l3cache_pmu *system = data;
+	struct resource *slice_info;
+	void __iomem *slice_mem;
+	struct hml3_pmu *slice;
+	int irq, err;
+
+	slice_info = platform_get_resource(sdev, IORESOURCE_MEM, 0);
+	slice = devm_kzalloc(&pdev->dev, sizeof(*slice), GFP_KERNEL);
+	if (!slice)
+		return -ENOMEM;
+
+	slice_mem = devm_ioremap_resource(&pdev->dev, slice_info);
+	if (IS_ERR(slice_mem)) {
+		dev_err(&pdev->dev, "Can't map slice @%pa\n",
+			&slice_info->start);
+		return PTR_ERR(slice_mem);
+	}
+
+	irq = qcom_l3_cache_pmu_get_slice_irq(pdev, sdev);
+	if (irq < 0) {
+		dev_err(&pdev->dev,
+			"Failed to get valid irq for slice @%pa\n",
+			&slice_info->start);
+		return irq;
+	}
+
+	err = devm_request_irq(&pdev->dev, irq, qcom_l3_cache__handle_irq, 0,
+			       "qcom-l3-cache-pmu", slice);
+	if (err) {
+		dev_err(&pdev->dev, "Request for IRQ failed for slice @%pa\n",
+			&slice_info->start);
+		return err;
+	}
+
+	hml3_pmu__init(slice, slice_mem);
+	list_add(&slice->entry, &system->pmus);
+	l3cache_pmu.num_pmus++;
+
+	return 0;
+}
+
+static int qcom_l3_cache_pmu_probe(struct platform_device *pdev)
+{
+	int result;
+
+	INIT_LIST_HEAD(&l3cache_pmu.pmus);
+
+	atomic_set(&l3cache_pmu.cpu, -1);
+	l3cache_pmu.pmu = (struct pmu) {
+		.task_ctx_nr	= perf_hw_context,
+
+		.name		= "l3cache",
+		.pmu_enable	= qcom_l3_cache__pmu_enable,
+		.pmu_disable	= qcom_l3_cache__pmu_disable,
+		.event_init	= qcom_l3_cache__event_init,
+		.add		= qcom_l3_cache__event_add,
+		.del		= qcom_l3_cache__event_del,
+		.start		= qcom_l3_cache__event_start,
+		.stop		= qcom_l3_cache__event_stop,
+		.read		= qcom_l3_cache__event_read,
+
+		.event_idx	= dummy_event_idx,
+
+		.attr_groups	= qcom_l3_cache_pmu_attr_grps,
+	};
+
+	result = device_for_each_child(&pdev->dev, &l3cache_pmu,
+				       qcom_l3_cache_pmu_probe_slice);
+
+	if (result < 0)
+		return -ENODEV;
+
+	if (l3cache_pmu.num_pmus == 0) {
+		dev_err(&pdev->dev, "No hardware HML3 PMUs found\n");
+		return -ENODEV;
+	}
+
+	result = perf_pmu_register(&l3cache_pmu.pmu,
+				   l3cache_pmu.pmu.name, -1);
+
+	if (result < 0)
+		dev_err(&pdev->dev,
+			"Failed to register L3 cache PMU (%d)\n",
+			result);
+	else
+		dev_info(&pdev->dev,
+			 "Registered L3 cache PMU, type: %d, using %d HW PMUs\n",
+			 l3cache_pmu.pmu.type, l3cache_pmu.num_pmus);
+
+	return result;
+}
+
+static int qcom_l3_cache_pmu_remove(struct platform_device *pdev)
+{
+	perf_pmu_unregister(&l3cache_pmu.pmu);
+	return 0;
+}
+
+static const struct acpi_device_id qcom_l3_cache_pmu_acpi_match[] = {
+	{ "QCOM8080", },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, qcom_l3_cache_pmu_acpi_match);
+
+static struct platform_driver qcom_l3_cache_pmu_driver = {
+	.driver = {
+		.name = "qcom-l3cache-pmu",
+		.owner = THIS_MODULE,
+		.acpi_match_table = ACPI_PTR(qcom_l3_cache_pmu_acpi_match),
+	},
+	.probe = qcom_l3_cache_pmu_probe,
+	.remove = qcom_l3_cache_pmu_remove,
+};
+
+static int __init register_qcom_l3_cache_pmu_driver(void)
+{
+	return platform_driver_register(&qcom_l3_cache_pmu_driver);
+}
+device_initcall(register_qcom_l3_cache_pmu_driver);
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
