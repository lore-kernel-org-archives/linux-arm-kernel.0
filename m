From: agustinv@codeaurora.org (Agustin Vega-Frias)
Date: Thu,  2 Mar 2017 15:58:32 -0500
Subject: [PATCH V3] perf: qcom: Add L3 cache PMU driver
Message-ID: <1488488312-6294-1-git-send-email-agustinv@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a new dynamic PMU to the Perf Events framework to program
and control the L3 cache PMUs in some Qualcomm Technologies SOCs.

The driver supports a distributed cache architecture where the overall
cache for a socket is comprised of multiple slices each with its own PMU.
Access to each individual PMU is provided even though all CPUs share all
the slices. User space needs to aggregate to individual counts to provide
a global picture.

The driver exports formatting and event information to sysfs so it can
be used by the perf user space tools with the syntaxes:
   perf stat -a -e l3cache_0_0/read-miss/
   perf stat -a -e l3cache_0_0/event=0x21/

Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>
---
 drivers/perf/Kconfig       |  10 +
 drivers/perf/Makefile      |   1 +
 drivers/perf/qcom_l3_pmu.c | 755 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/cpuhotplug.h |   1 +
 4 files changed, 767 insertions(+)
 create mode 100644 drivers/perf/qcom_l3_pmu.c

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 4d5c5f9..7df32f7 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -12,6 +12,16 @@ config ARM_PMU
 	  Say y if you want to use CPU performance monitors on ARM-based
 	  systems.
 
+config QCOM_L3_PMU
+	bool "Qualcomm Technologies L3-cache PMU"
+	depends on ARCH_QCOM && ARM64 && PERF_EVENTS && ACPI
+	select QCOM_IRQ_COMBINER
+	help
+	   Provides support for the L3 cache performance monitor unit (PMU)
+	   in Qualcomm Technologies processors.
+	   Adds the L3 cache PMU into the perf events subsystem for
+	   monitoring L3 cache events.
+
 config XGENE_PMU
         depends on PERF_EVENTS && ARCH_XGENE
         bool "APM X-Gene SoC PMU"
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index b116e98..89a2daa 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_ARM_PMU) += arm_pmu.o
+obj-$(CONFIG_QCOM_L3_PMU) += qcom_l3_pmu.o
 obj-$(CONFIG_XGENE_PMU) += xgene_pmu.o
diff --git a/drivers/perf/qcom_l3_pmu.c b/drivers/perf/qcom_l3_pmu.c
new file mode 100644
index 0000000..207f174
--- /dev/null
+++ b/drivers/perf/qcom_l3_pmu.c
@@ -0,0 +1,755 @@
+/* Copyright (c) 2015-2017, The Linux Foundation. All rights reserved.
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
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/list.h>
+#include <linux/acpi.h>
+#include <linux/perf_event.h>
+#include <linux/platform_device.h>
+
+/*
+ * Driver for the L3 cache PMUs in Qualcomm Technologies chips.
+ *
+ * The driver supports a distributed cache architecture where the overall
+ * cache for a socket is comprised of multiple slices each with its own PMU.
+ * Access to each individual PMU is provided even though all CPUs share all
+ * the slices. User space needs to aggregate to individual counts to provide
+ * a global picture.
+ *
+ * The hardware supports counter chaining to provide the user a way to avoid
+ * overhead of software counter maintenance. This is exposed via a the 'lc'
+ * flag field in perf_event_attr.config.
+ *
+ * The hardware also supports a feature that asserts the IRQ on the toggling
+ * of the most significanty bit in the 32bit counter. This feature is used
+ * to improve precision and to avoid counter reprogramming operations, since
+ * we can leave the counters as free running.
+ */
+
+/*
+ * General constants
+ */
+
+#define L3_NUM_COUNTERS  8
+#define L3_MAX_EVTYPE    0xFF
+
+/*
+ * Register offsets
+ */
+
+/* Perfmon registers */
+#define L3_HML3_PM_CR       0x000
+#define L3_HML3_PM_EVCNTR(__cntr) (0x420 + ((__cntr) & 0x7) * 8)
+#define L3_HML3_PM_CNTCTL(__cntr) (0x120 + ((__cntr) & 0x7) * 8)
+#define L3_HML3_PM_EVTYPE(__cntr) (0x220 + ((__cntr) & 0x7) * 8)
+#define L3_HML3_PM_FILTRA   0x300
+#define L3_HML3_PM_FILTRB   0x308
+#define L3_HML3_PM_FILTRC   0x310
+#define L3_HML3_PM_FILTRAM  0x304
+#define L3_HML3_PM_FILTRBM  0x30C
+#define L3_HML3_PM_FILTRCM  0x314
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
+#define L3_M_BC_IRQCTL     0x96C
+
+/*
+ * Bit field definitions
+ */
+
+/* L3_HML3_PM_CR */
+#define PM_CR_RESET           (0)
+
+/* L3_HML3_PM_XCNTCTL/L3_HML3_PM_CNTCTLx */
+#define PMCNT_RESET           (0)
+
+/* L3_HML3_PM_EVTYPEx */
+#define EVSEL(__val)          ((u32)((__val) & 0xFF))
+
+/* Reset value for all the filter registers */
+#define PM_FLTR_RESET         (0)
+
+/* L3_M_BC_CR */
+#define BC_RESET              (((u32)1) << 1)
+#define BC_ENABLE             ((u32)1)
+
+/* L3_M_BC_SATROLL_CR */
+#define BC_SATROLL_CR_RESET   (0)
+
+/* L3_M_BC_CNTENSET */
+#define PMCNTENSET(__cntr)    (((u32)1) << ((__cntr) & 0x7))
+
+/* L3_M_BC_CNTENCLR */
+#define PMCNTENCLR(__cntr)    (((u32)1) << ((__cntr) & 0x7))
+#define BC_CNTENCLR_RESET     (0xFF)
+
+/* L3_M_BC_INTENSET */
+#define PMINTENSET(__cntr)    (((u32)1) << ((__cntr) & 0x7))
+
+/* L3_M_BC_INTENCLR */
+#define PMINTENCLR(__cntr)    (((u32)1) << ((__cntr) & 0x7))
+#define BC_INTENCLR_RESET     (0xFF)
+
+/* L3_M_BC_GANG */
+#define GANG_EN(__cntr)       (((u32)1) << ((__cntr) & 0x7))
+#define BC_GANG_RESET         (0)
+
+/* L3_M_BC_OVSR */
+#define PMOVSRCLR(__cntr)     (((u32)1) << ((__cntr) & 0x7))
+#define PMOVSRCLR_RESET       (0xFF)
+
+/* L3_M_BC_IRQCTL */
+#define PMIRQONMSBEN(__cntr)  (((u32)1) << ((__cntr) & 0x7))
+#define BC_IRQCTL_RESET       (0x0)
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
+static inline int get_hw_counter_size(struct perf_event *event)
+{
+	return event->attr.config >> 32 & 1;
+}
+
+/*
+ * Hardware counter interface.
+ *
+ * This interface allows operations on counters to be polymorphic.
+ * The hardware supports counter chaining to allow 64 bit virtual counters.
+ * We expose this capability as a config option for each event, that way
+ * a user can create perf events that use 32 bit counters for events that
+ * increment at a slower rate, and perf events that use 64 bit counters
+ * for events that increment faster and avoid IRQ overhead.
+ */
+struct l3cache_pmu_hwc {
+	struct perf_event	*event;
+	/* Called to start event monitoring */
+	void (*start)(struct perf_event *event);
+	/* Called to stop event monitoring */
+	void (*stop)(struct perf_event *event, int flags);
+	/* Called to update the perf_event */
+	void (*update)(struct perf_event *event);
+};
+
+/*
+ * Main PMU, inherits from the core perf PMU type
+ */
+struct l3cache_pmu {
+	struct pmu		perf_pmu;
+	struct hlist_node	node;
+	void __iomem		*regs;
+	struct l3cache_pmu_hwc	counters[L3_NUM_COUNTERS];
+	unsigned long		used_mask[BITS_TO_LONGS(L3_NUM_COUNTERS)];
+	cpumask_t		cpumask;
+};
+
+#define to_l3cache_pmu(p) (container_of(p, struct l3cache_pmu, perf_pmu))
+
+/*
+ * 64 bit counter implementation
+ */
+
+static void qcom_l3_cache__64bit_counter_start(struct perf_event *event)
+{
+	struct l3cache_pmu *pmu = to_l3cache_pmu(event->pmu);
+	int idx = event->hw.idx;
+	u32 evsel = get_event_type(event);
+	u64 evcnt = local64_read(&event->count);
+	u32 gang = readl_relaxed(pmu->regs + L3_M_BC_GANG);
+
+	writel_relaxed(gang | GANG_EN(idx), pmu->regs + L3_M_BC_GANG);
+
+	writel_relaxed(evcnt >> 32, pmu->regs + L3_HML3_PM_EVCNTR(idx+1));
+	writel_relaxed((u32)evcnt, pmu->regs + L3_HML3_PM_EVCNTR(idx));
+
+	writel_relaxed(EVSEL(0), pmu->regs + L3_HML3_PM_EVTYPE(idx+1));
+	writel_relaxed(EVSEL(evsel), pmu->regs + L3_HML3_PM_EVTYPE(idx));
+
+	writel_relaxed(PMCNTENSET(idx+1), pmu->regs + L3_M_BC_CNTENSET);
+	writel_relaxed(PMCNTENSET(idx), pmu->regs + L3_M_BC_CNTENSET);
+}
+
+static void qcom_l3_cache__64bit_counter_stop(struct perf_event *event,
+					      int flags)
+{
+	struct l3cache_pmu *pmu = to_l3cache_pmu(event->pmu);
+	int idx = event->hw.idx;
+	u32 gang = readl_relaxed(pmu->regs + L3_M_BC_GANG);
+
+	writel_relaxed(gang & ~GANG_EN(idx), pmu->regs + L3_M_BC_GANG);
+	writel_relaxed(PMCNTENCLR(idx), pmu->regs + L3_M_BC_CNTENCLR);
+	writel_relaxed(PMCNTENCLR(idx+1), pmu->regs + L3_M_BC_CNTENCLR);
+}
+
+static void qcom_l3_cache__64bit_counter_update(struct perf_event *event)
+{
+	struct l3cache_pmu *pmu = to_l3cache_pmu(event->pmu);
+	int idx = event->hw.idx;
+	u32 hi_new, hi_old, lo;
+	int i, retries = 2;
+
+	hi_new = readl_relaxed(pmu->regs + L3_HML3_PM_EVCNTR(idx+1));
+	hi_old = hi_new + 1;
+	for (i = 0; (i < retries) && (hi_old != hi_new); i++) {
+		hi_old = hi_new;
+		lo = readl_relaxed(pmu->regs + L3_HML3_PM_EVCNTR(idx));
+		hi_new = readl_relaxed(pmu->regs + L3_HML3_PM_EVCNTR(idx+1));
+	}
+
+	local64_set(&event->count, ((u64)hi_new << 32) | lo);
+}
+
+/*
+ * 32 bit counter interface implementation
+ */
+
+static void qcom_l3_cache__32bit_counter_start(struct perf_event *event)
+{
+	struct l3cache_pmu *pmu = to_l3cache_pmu(event->pmu);
+	int idx = event->hw.idx;
+	u32 evsel = get_event_type(event);
+	u32 irqctl = readl_relaxed(pmu->regs + L3_M_BC_IRQCTL);
+
+	local64_set(&event->hw.prev_count, 0);
+	writel_relaxed(0, pmu->regs + L3_HML3_PM_EVCNTR(idx));
+	writel_relaxed(irqctl | PMIRQONMSBEN(idx), pmu->regs + L3_M_BC_IRQCTL);
+	writel_relaxed(EVSEL(evsel), pmu->regs + L3_HML3_PM_EVTYPE(idx));
+	writel_relaxed(PMINTENSET(idx), pmu->regs + L3_M_BC_INTENSET);
+	writel_relaxed(PMCNTENSET(idx), pmu->regs + L3_M_BC_CNTENSET);
+}
+
+static void qcom_l3_cache__32bit_counter_stop(struct perf_event *event,
+					      int flags)
+{
+	struct l3cache_pmu *pmu = to_l3cache_pmu(event->pmu);
+	int idx = event->hw.idx;
+	u32 irqctl = readl_relaxed(pmu->regs + L3_M_BC_IRQCTL);
+
+	writel_relaxed(irqctl & ~PMIRQONMSBEN(idx), pmu->regs + L3_M_BC_IRQCTL);
+	writel_relaxed(PMINTENCLR(idx), pmu->regs + L3_M_BC_INTENCLR);
+	writel_relaxed(PMCNTENCLR(idx), pmu->regs + L3_M_BC_CNTENCLR);
+}
+
+static void qcom_l3_cache__32bit_counter_update(struct perf_event *event)
+{
+	struct l3cache_pmu *pmu = to_l3cache_pmu(event->pmu);
+	int idx = event->hw.idx;
+	u32 delta, prev, now;
+
+	do {
+		prev = local64_read(&event->hw.prev_count);
+		now = readl_relaxed(pmu->regs + L3_HML3_PM_EVCNTR(idx));
+	} while (local64_cmpxchg(&event->hw.prev_count, prev, now) != prev);
+
+	delta = now - prev;
+	local64_add(delta, &event->count);
+}
+
+/*
+ * Top level PMU functions.
+ */
+
+static inline void qcom_l3_cache__init(struct l3cache_pmu *pmu)
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
+
+	writel_relaxed(BC_CNTENCLR_RESET, pmu->regs + L3_M_BC_CNTENCLR);
+	writel_relaxed(BC_INTENCLR_RESET, pmu->regs + L3_M_BC_INTENCLR);
+	writel_relaxed(PMOVSRCLR_RESET, pmu->regs + L3_M_BC_OVSR);
+	writel_relaxed(BC_GANG_RESET, pmu->regs + L3_M_BC_GANG);
+	writel_relaxed(BC_IRQCTL_RESET, pmu->regs + L3_M_BC_IRQCTL);
+	writel_relaxed(PM_CR_RESET, pmu->regs + L3_HML3_PM_CR);
+
+	for (i = 0; i < L3_NUM_COUNTERS; ++i) {
+		writel_relaxed(PMCNT_RESET, pmu->regs + L3_HML3_PM_CNTCTL(i));
+		writel_relaxed(EVSEL(0), pmu->regs + L3_HML3_PM_EVTYPE(i));
+	}
+
+	writel_relaxed(PM_FLTR_RESET, pmu->regs + L3_HML3_PM_FILTRA);
+	writel_relaxed(PM_FLTR_RESET, pmu->regs + L3_HML3_PM_FILTRAM);
+	writel_relaxed(PM_FLTR_RESET, pmu->regs + L3_HML3_PM_FILTRB);
+	writel_relaxed(PM_FLTR_RESET, pmu->regs + L3_HML3_PM_FILTRBM);
+	writel_relaxed(PM_FLTR_RESET, pmu->regs + L3_HML3_PM_FILTRC);
+	writel_relaxed(PM_FLTR_RESET, pmu->regs + L3_HML3_PM_FILTRCM);
+
+	/*
+	 * Use writel here to ensure all programming commands are done
+	 *  before proceeding
+	 */
+	writel(BC_ENABLE, pmu->regs + L3_M_BC_CR);
+}
+
+static irqreturn_t qcom_l3_cache__handle_irq(int irq_num, void *data)
+{
+	struct l3cache_pmu *pmu = data;
+	u32 status = readl_relaxed(pmu->regs + L3_M_BC_OVSR);
+	int idx;
+
+	if (status == 0)
+		return IRQ_NONE;
+
+	writel_relaxed(status, pmu->regs + L3_M_BC_OVSR);
+	while (status) {
+		struct perf_event *event;
+
+		idx = __ffs(status);
+		status &= ~(1 << idx);
+		event = pmu->counters[idx].event;
+		if (!event)
+			continue;
+
+		qcom_l3_cache__32bit_counter_update(event);
+	}
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * Implementation of abstract pmu functionality required by
+ * the core perf events code.
+ */
+
+static void qcom_l3_cache__pmu_enable(struct pmu *perf_pmu)
+{
+	struct l3cache_pmu *pmu = to_l3cache_pmu(perf_pmu);
+	int i;
+
+	/*
+	 * Re-write CNTCTL for all existing events to re-assert
+	 * the start trigger.
+	 */
+	for (i = 0; i < L3_NUM_COUNTERS; i++)
+		if (pmu->counters[i].event)
+			writel_relaxed(PMCNT_RESET, pmu->regs + L3_HML3_PM_CNTCTL(i));
+
+	/* Ensure all programming commands are done before proceeding */
+	writel(BC_ENABLE, pmu->regs + L3_M_BC_CR);
+}
+
+static void qcom_l3_cache__pmu_disable(struct pmu *perf_pmu)
+{
+	struct l3cache_pmu *pmu = to_l3cache_pmu(perf_pmu);
+
+	writel_relaxed(0, pmu->regs + L3_M_BC_CR);
+
+	/* Ensure the basic counter unit is stopped before proceeding */
+	wmb();
+}
+
+static int qcom_l3_cache__event_init(struct perf_event *event)
+{
+	struct l3cache_pmu *pmu;
+	struct hw_perf_event *hwc = &event->hw;
+
+	/*
+	 * Is the event for this PMU?
+	 */
+	if (event->attr.type != event->pmu->type)
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
+	 * Task mode not available, we run the counters as socket counters,
+	 * not attributable to any CPU and therefore cannot attribute per-task.
+	 */
+	if (event->cpu < 0)
+		return -EINVAL;
+
+	/*
+	 * Many perf core operations (eg. events rotation) operate on a
+	 * single CPU context. This is obvious for CPU PMUs, where one
+	 * expects the same sets of events being observed on all CPUs,
+	 * but can lead to issues for off-core PMUs, like this one, where
+	 * each event could be theoretically assigned to a different CPU.
+	 * To mitigate this, we enforce CPU assignment to one designated
+	 * processor (the one described in the "cpumask" attribute exported
+	 * by the PMU device). perf user space tools honor this and avoid
+	 * opening more than one copy of the events.
+	 */
+	pmu = to_l3cache_pmu(event->pmu);
+	event->cpu = cpumask_first(&pmu->cpumask);
+
+	return 0;
+}
+
+static void qcom_l3_cache__event_start(struct perf_event *event, int flags)
+{
+	struct l3cache_pmu *pmu = to_l3cache_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	hwc->state = 0;
+
+	pmu->counters[hwc->idx].start(event);
+}
+
+static void qcom_l3_cache__event_stop(struct perf_event *event, int flags)
+{
+	struct l3cache_pmu *pmu = to_l3cache_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (!(hwc->state & PERF_HES_STOPPED)) {
+		pmu->counters[hwc->idx].stop(event, flags);
+
+		if (flags & PERF_EF_UPDATE)
+			pmu->counters[hwc->idx].update(event);
+		hwc->state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
+	}
+}
+
+static int qcom_l3_cache__event_add(struct perf_event *event, int flags)
+{
+	struct l3cache_pmu *pmu = to_l3cache_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	int idx;
+	int sz;
+
+	/*
+	 * Try to allocate a counter.
+	 */
+	sz = get_hw_counter_size(event);
+	idx = bitmap_find_free_region(pmu->used_mask, L3_NUM_COUNTERS, sz);
+	if (idx < 0)
+		/* The counters are all in use. */
+		return -EAGAIN;
+
+	hwc->idx = idx;
+	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
+
+	if (sz == 0)
+		pmu->counters[idx] = (struct l3cache_pmu_hwc) {
+			.event = event,
+			.start = qcom_l3_cache__32bit_counter_start,
+			.stop = qcom_l3_cache__32bit_counter_stop,
+			.update = qcom_l3_cache__32bit_counter_update
+		};
+	else {
+		pmu->counters[idx] = (struct l3cache_pmu_hwc) {
+			.event = event,
+			.start = qcom_l3_cache__64bit_counter_start,
+			.stop = qcom_l3_cache__64bit_counter_stop,
+			.update = qcom_l3_cache__64bit_counter_update
+		};
+		pmu->counters[idx+1] = pmu->counters[idx];
+	}
+
+	if (flags & PERF_EF_START)
+		qcom_l3_cache__event_start(event, 0);
+
+	/* Propagate changes to the userspace mapping. */
+	perf_event_update_userpage(event);
+
+	return 0;
+}
+
+static void qcom_l3_cache__event_del(struct perf_event *event, int flags)
+{
+	struct l3cache_pmu *pmu = to_l3cache_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	int sz;
+
+	qcom_l3_cache__event_stop(event,  flags | PERF_EF_UPDATE);
+	sz = get_hw_counter_size(event);
+	pmu->counters[hwc->idx].event = NULL;
+	if (sz)
+		pmu->counters[hwc->idx+1].event = NULL;
+	bitmap_release_region(pmu->used_mask, hwc->idx, sz);
+
+	perf_event_update_userpage(event);
+}
+
+static void qcom_l3_cache__event_read(struct perf_event *event)
+{
+	struct l3cache_pmu *pmu = to_l3cache_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	pmu->counters[hwc->idx].update(event);
+}
+
+/*
+ * Add support for creating events symbolically when using the perf
+ * user space tools command line. E.g.:
+ *   perf stat -a -e l3cache/event=read-miss/ ls
+ *   perf stat -a -e l3cache/event=0x21/ ls
+ */
+
+ssize_t l3cache_pmu_event_sysfs_show(struct device *dev,
+				     struct device_attribute *attr, char *page)
+{
+	struct perf_pmu_events_attr *pmu_attr;
+
+	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
+	return sprintf(page, "event=0x%02llx\n", pmu_attr->id);
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
+PMU_FORMAT_ATTR(lc, "config:32");
+
+static struct attribute *qcom_l3_cache_pmu_formats[] = {
+	&format_attr_event.attr,
+	&format_attr_lc.attr,
+	NULL,
+};
+
+static struct attribute_group qcom_l3_cache_pmu_format_group = {
+	.name = "format",
+	.attrs = qcom_l3_cache_pmu_formats,
+};
+
+static ssize_t qcom_l3_cache_pmu_cpumask_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct l3cache_pmu *pmu = to_l3cache_pmu(dev_get_drvdata(dev));
+
+	return cpumap_print_to_pagebuf(true, buf, &pmu->cpumask);
+}
+
+static struct device_attribute qcom_l3_cache_pmu_cpumask_attr =
+		__ATTR(cpumask, 0444, qcom_l3_cache_pmu_cpumask_show, NULL);
+
+static struct attribute *qcom_l3_cache_pmu_cpumask_attrs[] = {
+	&qcom_l3_cache_pmu_cpumask_attr.attr,
+	NULL,
+};
+
+static struct attribute_group qcom_l3_cache_pmu_cpumask_attr_group = {
+	.attrs = qcom_l3_cache_pmu_cpumask_attrs,
+};
+
+
+static const struct attribute_group *qcom_l3_cache_pmu_attr_grps[] = {
+	&qcom_l3_cache_pmu_format_group,
+	&qcom_l3_cache_pmu_events_group,
+	&qcom_l3_cache_pmu_cpumask_attr_group,
+	NULL,
+};
+
+/*
+ * Probing functions and data.
+ */
+
+static int qcom_l3_cache_pmu_online_cpu(unsigned int cpu, struct hlist_node *node)
+{
+	struct l3cache_pmu *pmu = hlist_entry_safe(node, struct l3cache_pmu, node);
+
+	/* If there is not a CPU/PMU association pick this CPU */
+	if (cpumask_empty(&pmu->cpumask))
+		cpumask_set_cpu(cpu, &pmu->cpumask);
+
+	return 0;
+}
+
+static int qcom_l3_cache_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
+{
+	struct l3cache_pmu *pmu = hlist_entry_safe(node, struct l3cache_pmu, node);
+	unsigned int target;
+
+	if (!cpumask_test_and_clear_cpu(cpu, &pmu->cpumask))
+		return 0;
+	target = cpumask_any_but(cpu_online_mask, cpu);
+	if (target >= nr_cpu_ids)
+		return 0;
+	perf_pmu_migrate_context(&pmu->perf_pmu, cpu, target);
+	cpumask_set_cpu(target, &pmu->cpumask);
+	return 0;
+}
+
+static int qcom_l3_cache_pmu_probe(struct platform_device *pdev)
+{
+	struct l3cache_pmu *pmu;
+	struct acpi_device *acpi_dev;
+	struct resource *memrc;
+	int rc;
+	char *name;
+
+	/* Initialize the PMU data structures */
+
+	acpi_dev = ACPI_COMPANION(&pdev->dev);
+	if (!acpi_dev)
+		return -ENODEV;
+
+	pmu = devm_kzalloc(&pdev->dev, sizeof(*pmu), GFP_KERNEL);
+	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "l3cache_%s_%s",
+		      acpi_dev->parent->pnp.unique_id, acpi_dev->pnp.unique_id);
+	if (!pmu || !name)
+		return -ENOMEM;
+
+	pmu->perf_pmu = (struct pmu) {
+		.task_ctx_nr	= perf_invalid_context,
+
+		.pmu_enable	= qcom_l3_cache__pmu_enable,
+		.pmu_disable	= qcom_l3_cache__pmu_disable,
+		.event_init	= qcom_l3_cache__event_init,
+		.add		= qcom_l3_cache__event_add,
+		.del		= qcom_l3_cache__event_del,
+		.start		= qcom_l3_cache__event_start,
+		.stop		= qcom_l3_cache__event_stop,
+		.read		= qcom_l3_cache__event_read,
+
+		.attr_groups	= qcom_l3_cache_pmu_attr_grps,
+	};
+
+	memrc = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	pmu->regs = devm_ioremap_resource(&pdev->dev, memrc);
+	if (IS_ERR(pmu->regs)) {
+		dev_err(&pdev->dev, "Can't map PMU @%pa\n", &memrc->start);
+		return PTR_ERR(pmu->regs);
+	}
+
+	qcom_l3_cache__init(pmu);
+
+	rc = platform_get_irq(pdev, 0);
+	if (rc <= 0) {
+		dev_err(&pdev->dev, "Failed to get valid irq for PMU @%pa\n",
+			&memrc->start);
+		return rc;
+	}
+
+	rc = devm_request_irq(&pdev->dev, rc, qcom_l3_cache__handle_irq, 0,
+			      name, pmu);
+	if (rc) {
+		dev_err(&pdev->dev, "Request for IRQ failed for slice @%pa\n",
+			&memrc->start);
+		return rc;
+	}
+
+	/* Add this instance to the list used by the offline callback */
+	rc = cpuhp_state_add_instance(CPUHP_AP_PERF_QCOM_L3CACHE_ONLINE, &pmu->node);
+	if (rc) {
+		dev_err(&pdev->dev, "Error %d registering hotplug", rc);
+		return rc;
+	}
+
+	rc = perf_pmu_register(&pmu->perf_pmu, name, -1);
+	if (rc < 0) {
+		dev_err(&pdev->dev, "Failed to register L3 cache PMU (%d)\n", rc);
+		return rc;
+	}
+
+	dev_info(&pdev->dev, "Registered %s, type: %d\n", name, pmu->perf_pmu.type);
+
+	return 0;
+}
+
+static const struct acpi_device_id qcom_l3_cache_pmu_acpi_match[] = {
+	{ "QCOM8081", },
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
+};
+
+static int __init register_qcom_l3_cache_pmu_driver(void)
+{
+	int ret;
+
+	/* Install a hook to update the reader CPU in case it goes offline */
+	ret = cpuhp_setup_state_multi(CPUHP_AP_PERF_QCOM_L3CACHE_ONLINE,
+				      "perf/qcom/l3cache:online",
+				      qcom_l3_cache_pmu_online_cpu,
+				      qcom_l3_cache_pmu_offline_cpu);
+	if (ret)
+		return ret;
+
+	return platform_driver_register(&qcom_l3_cache_pmu_driver);
+}
+device_initcall(register_qcom_l3_cache_pmu_driver);
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 921acaa..be83438 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -137,6 +137,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_ARM_CCI_ONLINE,
 	CPUHP_AP_PERF_ARM_CCN_ONLINE,
 	CPUHP_AP_PERF_ARM_L2X0_ONLINE,
+	CPUHP_AP_PERF_QCOM_L3CACHE_ONLINE,
 	CPUHP_AP_WORKQUEUE_ONLINE,
 	CPUHP_AP_RCUTREE_ONLINE,
 	CPUHP_AP_ONLINE_DYN,
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
