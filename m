From: zhangshaokun@hisilicon.com (Shaokun Zhang)
Date: Tue, 22 Aug 2017 16:07:53 +0800
Subject: [PATCH v5 2/6] perf: hisi: Add support for HiSilicon SoC uncore PMU
 driver
In-Reply-To: <1503389277-134131-1-git-send-email-zhangshaokun@hisilicon.com>
References: <1503389277-134131-1-git-send-email-zhangshaokun@hisilicon.com>
Message-ID: <1503389277-134131-3-git-send-email-zhangshaokun@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support HiSilicon SoC uncore PMU driver framework and
interfaces.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Signed-off-by: Anurup M <anurup.m@huawei.com>
---
 drivers/perf/Kconfig                     |   7 +
 drivers/perf/Makefile                    |   1 +
 drivers/perf/hisilicon/Makefile          |   1 +
 drivers/perf/hisilicon/hisi_uncore_pmu.c | 440 +++++++++++++++++++++++++++++++
 drivers/perf/hisilicon/hisi_uncore_pmu.h | 107 ++++++++
 5 files changed, 556 insertions(+)
 create mode 100644 drivers/perf/hisilicon/Makefile
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_pmu.c
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_pmu.h

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index e5197ff..b1a3894 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -17,6 +17,13 @@ config ARM_PMU_ACPI
 	depends on ARM_PMU && ACPI
 	def_bool y
 
+config HISI_PMU
+       bool "HiSilicon SoC PMU"
+       depends on ARM64 && ACPI
+       help
+         Support for HiSilicon SoC uncore performance monitoring
+         unit (PMU), such as: L3C, HHA and DDRC.
+
 config QCOM_L2_PMU
 	bool "Qualcomm Technologies L2-cache PMU"
 	depends on ARCH_QCOM && ARM64 && ACPI
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index 6420bd4..41d3342 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -1,5 +1,6 @@
 obj-$(CONFIG_ARM_PMU) += arm_pmu.o arm_pmu_platform.o
 obj-$(CONFIG_ARM_PMU_ACPI) += arm_pmu_acpi.o
+obj-$(CONFIG_HISI_PMU) += hisilicon/
 obj-$(CONFIG_QCOM_L2_PMU)	+= qcom_l2_pmu.o
 obj-$(CONFIG_QCOM_L3_PMU) += qcom_l3_pmu.o
 obj-$(CONFIG_XGENE_PMU) += xgene_pmu.o
diff --git a/drivers/perf/hisilicon/Makefile b/drivers/perf/hisilicon/Makefile
new file mode 100644
index 0000000..2783bb3
--- /dev/null
+++ b/drivers/perf/hisilicon/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_HISI_PMU) += hisi_uncore_pmu.o
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
new file mode 100644
index 0000000..f7e8ca2
--- /dev/null
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
@@ -0,0 +1,440 @@
+/*
+ * HiSilicon SoC Hardware event counters support
+ *
+ * Copyright (C) 2017 Hisilicon Limited
+ * Author: Anurup M <anurup.m@huawei.com>
+ *         Shaokun Zhang <zhangshaokun@hisilicon.com>
+ *
+ * This code is based on the uncore PMUs like arm-cci and arm-ccn.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/bitmap.h>
+#include <linux/bitops.h>
+#include <linux/bug.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+
+#include <asm/local64.h>
+
+#include "hisi_uncore_pmu.h"
+
+#define HISI_GET_EVENTID(ev) (ev->hw.config_base & 0xff)
+#define HISI_MAX_PERIOD(nr) (BIT_ULL(nr) - 1)
+
+/*
+ * PMU format attributes
+ */
+ssize_t hisi_format_sysfs_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct dev_ext_attribute *eattr;
+
+	eattr = container_of(attr, struct dev_ext_attribute, attr);
+
+	return sprintf(buf, "%s\n", (char *)eattr->var);
+}
+
+/*
+ * PMU event attributes
+ */
+ssize_t hisi_event_sysfs_show(struct device *dev,
+			      struct device_attribute *attr, char *page)
+{
+	struct dev_ext_attribute *eattr;
+
+	eattr = container_of(attr, struct dev_ext_attribute, attr);
+
+	return sprintf(page, "config=0x%lx\n", (unsigned long)eattr->var);
+}
+
+/*
+ * sysfs cpumask attributes. For uncore PMU, we only have a single CPU to show
+ */
+ssize_t hisi_cpumask_sysfs_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct hisi_pmu *hisi_pmu = to_hisi_pmu(dev_get_drvdata(dev));
+
+	return sprintf(buf, "%d\n", hisi_pmu->on_cpu);
+}
+
+static bool hisi_validate_event_group(struct perf_event *event)
+{
+	struct perf_event *sibling, *leader = event->group_leader;
+	struct hisi_pmu *hisi_pmu = to_hisi_pmu(event->pmu);
+	/* Include count for the event */
+	int counters = 1;
+
+	/*
+	 * We must NOT create groups containing mixed PMUs, although
+	 * software events are acceptable
+	 */
+	if (leader->pmu != event->pmu && !is_software_event(leader))
+		return false;
+
+	/* Increment counter for the leader */
+	counters++;
+
+	list_for_each_entry(sibling, &event->group_leader->sibling_list,
+			    group_entry) {
+		if (is_software_event(sibling))
+			continue;
+		if (sibling->pmu != event->pmu)
+			return false;
+		/* Increment counter for each sibling */
+		counters++;
+	}
+
+	/* The group can not count events more than the counters in the HW */
+	return counters <= hisi_pmu->num_counters;
+}
+
+int hisi_uncore_pmu_counter_valid(struct hisi_pmu *hisi_pmu, int idx)
+{
+	return (idx >= 0 && idx < hisi_pmu->num_counters);
+}
+
+int hisi_uncore_pmu_get_event_idx(struct perf_event *event)
+{
+	struct hisi_pmu *hisi_pmu = to_hisi_pmu(event->pmu);
+	unsigned long *used_mask = hisi_pmu->pmu_events.used_mask;
+	u32 num_counters = hisi_pmu->num_counters;
+	int idx;
+
+	idx = find_first_zero_bit(used_mask, num_counters);
+	if (idx == num_counters)
+		return -EAGAIN;
+
+	set_bit(idx, used_mask);
+
+	return idx;
+}
+
+static void hisi_uncore_pmu_clear_event_idx(struct hisi_pmu *hisi_pmu, int idx)
+{
+	if (!hisi_uncore_pmu_counter_valid(hisi_pmu, idx)) {
+		dev_err(hisi_pmu->dev, "Unsupported event index:%d!\n", idx);
+		return;
+	}
+
+	clear_bit(idx, hisi_pmu->pmu_events.used_mask);
+}
+
+int hisi_uncore_pmu_event_init(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct hisi_pmu *hisi_pmu;
+
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	/*
+	 * We do not support sampling as the counters are all
+	 * shared by all CPU cores in a CPU die(SCCL). Also we
+	 * do not support attach to a task(per-process mode)
+	 */
+	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
+		return -EOPNOTSUPP;
+
+	/* counters do not have these bits */
+	if (event->attr.exclude_user	||
+	    event->attr.exclude_kernel	||
+	    event->attr.exclude_host	||
+	    event->attr.exclude_guest	||
+	    event->attr.exclude_hv	||
+	    event->attr.exclude_idle)
+		return -EINVAL;
+
+	/*
+	 *  The uncore counters not specific to any CPU, so cannot
+	 *  support per-task
+	 */
+	if (event->cpu < 0)
+		return -EINVAL;
+
+	/*
+	 * Validate if the events in group does not exceed the
+	 * available counters in hardware.
+	 */
+	if (!hisi_validate_event_group(event))
+		return -EINVAL;
+
+	/*
+	 * We don't assign an index until we actually place the event onto
+	 * hardware. Use -1 to signify that we haven't decided where to put it
+	 * yet.
+	 */
+	hwc->idx		= -1;
+	hwc->config_base	= event->attr.config;
+
+	hisi_pmu = to_hisi_pmu(event->pmu);
+	/* Enforce to use the same CPU for all events in this PMU */
+	event->cpu = hisi_pmu->on_cpu;
+
+	return 0;
+}
+
+/*
+ * Set the counter to count the event that we're interested in,
+ * and enable interrupt and counter.
+ */
+static void hisi_uncore_pmu_enable_event(struct perf_event *event)
+{
+	struct hisi_pmu *hisi_pmu = to_hisi_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	hisi_pmu->ops->write_evtype(hisi_pmu, hwc->idx,
+				    HISI_GET_EVENTID(event));
+
+	hisi_pmu->ops->enable_counter_int(hisi_pmu, hwc);
+	hisi_pmu->ops->enable_counter(hisi_pmu, hwc);
+}
+
+/*
+ * Disable counter and interrupt.
+ */
+static void hisi_uncore_pmu_disable_event(struct perf_event *event)
+{
+	struct hisi_pmu *hisi_pmu = to_hisi_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	hisi_pmu->ops->disable_counter(hisi_pmu, hwc);
+	hisi_pmu->ops->disable_counter_int(hisi_pmu, hwc);
+}
+
+void hisi_uncore_pmu_set_event_period(struct perf_event *event)
+{
+	struct hisi_pmu *hisi_pmu = to_hisi_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	/*
+	 * The HiSilicon PMU counters support 32 bits or 48 bits, depending on
+	 * the PMU. We reduce it to 2^(counter_bits - 1) to account for the
+	 * extreme interrupt latency. So we could hopefully handle the overflow
+	 * interrupt before another 2^(counter_bits - 1) events occur and the
+	 * counter overtakes its previous value.
+	 */
+	u64 val = BIT_ULL(hisi_pmu->counter_bits - 1);
+
+	local64_set(&hwc->prev_count, val);
+	/* Write start value to the hardware event counter */
+	hisi_pmu->ops->write_counter(hisi_pmu, hwc, val);
+}
+
+void hisi_uncore_pmu_event_update(struct perf_event *event)
+{
+	struct hisi_pmu *hisi_pmu = to_hisi_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	u64 delta, prev_raw_count, new_raw_count;
+
+	do {
+		/* Read the count from the counter register */
+		new_raw_count = hisi_pmu->ops->read_counter(hisi_pmu, hwc);
+		prev_raw_count = local64_read(&hwc->prev_count);
+	} while (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
+				 new_raw_count) != prev_raw_count);
+	/*
+	 * compute the delta
+	 */
+	delta = (new_raw_count - prev_raw_count) &
+		HISI_MAX_PERIOD(hisi_pmu->counter_bits);
+	local64_add(delta, &event->count);
+}
+
+void hisi_uncore_pmu_start(struct perf_event *event, int flags)
+{
+	struct hisi_pmu *hisi_pmu = to_hisi_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (WARN_ON_ONCE(!(hwc->state & PERF_HES_STOPPED)))
+		return;
+
+	WARN_ON_ONCE(!(hwc->state & PERF_HES_UPTODATE));
+	hwc->state = 0;
+	hisi_uncore_pmu_set_event_period(event);
+
+	if (flags & PERF_EF_RELOAD) {
+		u64 prev_raw_count =  local64_read(&hwc->prev_count);
+
+		hisi_pmu->ops->write_counter(hisi_pmu, hwc, prev_raw_count);
+	}
+
+	hisi_uncore_pmu_enable_event(event);
+	perf_event_update_userpage(event);
+}
+
+void hisi_uncore_pmu_stop(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	hisi_uncore_pmu_disable_event(event);
+	WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
+	hwc->state |= PERF_HES_STOPPED;
+
+	if (hwc->state & PERF_HES_UPTODATE)
+		return;
+
+	/* Read hardware counter and update the perf counter statistics */
+	hisi_uncore_pmu_event_update(event);
+	hwc->state |= PERF_HES_UPTODATE;
+}
+
+int hisi_uncore_pmu_add(struct perf_event *event, int flags)
+{
+	struct hisi_pmu *hisi_pmu = to_hisi_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	int idx;
+
+	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
+
+	/* Get an available counter index for counting */
+	idx = hisi_pmu->ops->get_event_idx(event);
+	if (idx < 0)
+		return idx;
+
+	event->hw.idx = idx;
+	hisi_pmu->pmu_events.hw_events[idx] = event;
+
+	if (flags & PERF_EF_START)
+		hisi_uncore_pmu_start(event, PERF_EF_RELOAD);
+
+	return 0;
+}
+
+void hisi_uncore_pmu_del(struct perf_event *event, int flags)
+{
+	struct hisi_pmu *hisi_pmu = to_hisi_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	hisi_uncore_pmu_stop(event, PERF_EF_UPDATE);
+	hisi_uncore_pmu_clear_event_idx(hisi_pmu, hwc->idx);
+	perf_event_update_userpage(event);
+	hisi_pmu->pmu_events.hw_events[hwc->idx] = NULL;
+}
+
+void hisi_uncore_pmu_read(struct perf_event *event)
+{
+	/* Read hardware counter and update the perf counter statistics */
+	hisi_uncore_pmu_event_update(event);
+}
+
+void hisi_uncore_pmu_enable(struct pmu *pmu)
+{
+	struct hisi_pmu *hisi_pmu = to_hisi_pmu(pmu);
+	int enabled = bitmap_weight(hisi_pmu->pmu_events.used_mask,
+				    hisi_pmu->num_counters);
+
+	if (!enabled)
+		return;
+
+	hisi_pmu->ops->start_counters(hisi_pmu);
+}
+
+void hisi_uncore_pmu_disable(struct pmu *pmu)
+{
+	struct hisi_pmu *hisi_pmu = to_hisi_pmu(pmu);
+
+	hisi_pmu->ops->stop_counters(hisi_pmu);
+}
+
+/*
+ * Read Super CPU cluster and CPU cluster ID from MPIDR_EL1.
+ * If multi-threading is supported, SCCL_ID is in MPIDR[aff3] and CCL_ID
+ * is in MPIDR[aff2]; if not, SCCL_ID is in MPIDR[aff2] and CCL_ID is
+ * in MPIDR[aff1]. If this changes in future, this shall be updated.
+ */
+void hisi_read_sccl_and_ccl_id(u32 *sccl_id, u32 *ccl_id)
+{
+	u64 mpidr;
+
+	mpidr = read_cpuid_mpidr();
+	if (mpidr & MPIDR_MT_BITMASK) {
+		if (sccl_id)
+			*sccl_id = MPIDR_AFFINITY_LEVEL(mpidr, 3);
+		if (ccl_id)
+			*ccl_id = MPIDR_AFFINITY_LEVEL(mpidr, 2);
+	} else {
+		if (sccl_id)
+			*sccl_id = MPIDR_AFFINITY_LEVEL(mpidr, 2);
+		if (ccl_id)
+			*ccl_id = MPIDR_AFFINITY_LEVEL(mpidr, 1);
+	}
+}
+
+int hisi_uncore_pmu_online_cpu(unsigned int cpu, struct hlist_node *node)
+{
+	struct hisi_pmu *hisi_pmu;
+
+	hisi_pmu = hlist_entry_safe(node, struct hisi_pmu, node);
+
+	/*
+	 * If the CPU is associated with the PMU, set it in online_cpus of
+	 * the PMU.
+	 */
+	if (cpumask_test_cpu(cpu, &hisi_pmu->associated_cpus))
+		cpumask_set_cpu(cpu, &hisi_pmu->online_cpus);
+	else
+		return 0;
+
+	/* If another CPU is already managing this PMU, simply return. */
+	if (hisi_pmu->on_cpu != -1)
+		return 0;
+
+	/* Use this CPU in cpumask for event counting */
+	hisi_pmu->on_cpu = cpu;
+
+	/* Overflow interrupt also should use the same CPU */
+	WARN_ON(irq_set_affinity(hisi_pmu->irq, cpumask_of(cpu)));
+
+	return 0;
+}
+
+int hisi_uncore_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
+{
+	struct hisi_pmu *hisi_pmu;
+	cpumask_t pmu_online_cpus;
+	unsigned int target;
+
+	hisi_pmu = hlist_entry_safe(node, struct hisi_pmu, node);
+
+	/*
+	 * If the CPU is online with the PMU, clear it in online_cpus of
+	 * the PMU.
+	 */
+	if (!cpumask_test_and_clear_cpu(cpu, &hisi_pmu->online_cpus) ||
+	    (hisi_pmu->on_cpu != cpu))
+		return 0;
+
+	hisi_pmu->on_cpu = -1;
+
+	/* Any other CPU associated with the PMU is still online */
+	cpumask_and(&pmu_online_cpus, &hisi_pmu->online_cpus, cpu_online_mask);
+	target = cpumask_any_but(&pmu_online_cpus, cpu);
+	if (target >= nr_cpu_ids)
+		return 0;
+
+	perf_pmu_migrate_context(&hisi_pmu->pmu, cpu, target);
+	/* Use this CPU for event counting */
+	hisi_pmu->on_cpu = target;
+	WARN_ON(irq_set_affinity(hisi_pmu->irq, cpumask_of(target)));
+
+	return 0;
+}
+
+/*
+ * Check whether the CPU is associated with this uncore PMU by SCCL_ID,
+ * if true, set the associated cpumask of the uncore PMU.
+ */
+void hisi_uncore_pmu_set_cpumask_by_sccl(void *arg)
+{
+	struct hisi_pmu *hisi_pmu = (struct hisi_pmu *)arg;
+	u32 sccl_id;
+
+	hisi_read_sccl_and_ccl_id(&sccl_id, NULL);
+	if (sccl_id == hisi_pmu->sccl_id)
+		cpumask_set_cpu(smp_processor_id(), &hisi_pmu->associated_cpus);
+}
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.h b/drivers/perf/hisilicon/hisi_uncore_pmu.h
new file mode 100644
index 0000000..4cda9ca
--- /dev/null
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.h
@@ -0,0 +1,107 @@
+/*
+ * HiSilicon SoC Hardware event counters support
+ *
+ * Copyright (C) 2017 Hisilicon Limited
+ * Author: Anurup M <anurup.m@huawei.com>
+ *         Shaokun Zhang <zhangshaokun@hisilicon.com>
+ *
+ * This code is based on the uncore PMUs like arm-cci and arm-ccn.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __HISI_UNCORE_PMU_H__
+#define __HISI_UNCORE_PMU_H__
+
+#include <linux/cpumask.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/perf_event.h>
+#include <linux/types.h>
+
+#undef pr_fmt
+#define pr_fmt(fmt)     "hisi_pmu: " fmt
+
+#define HISI_MAX_COUNTERS 0x10
+#define to_hisi_pmu(p)	(container_of(p, struct hisi_pmu, pmu))
+
+#define HISI_PMU_ATTR(_name, _func, _config)				\
+	(&((struct dev_ext_attribute[]) {				\
+		{ __ATTR(_name, 0444, _func, NULL), (void *)_config }   \
+	})[0].attr.attr)
+
+#define HISI_PMU_FORMAT_ATTR(_name, _config)		\
+	HISI_PMU_ATTR(_name, hisi_format_sysfs_show, (void *)_config)
+#define HISI_PMU_EVENT_ATTR(_name, _config)		\
+	HISI_PMU_ATTR(_name, hisi_event_sysfs_show, (unsigned long)_config)
+
+struct hisi_pmu;
+
+struct hisi_uncore_ops {
+	void (*write_evtype)(struct hisi_pmu *, int, u32);
+	int (*get_event_idx)(struct perf_event *);
+	u64 (*read_counter)(struct hisi_pmu *, struct hw_perf_event *);
+	void (*write_counter)(struct hisi_pmu *, struct hw_perf_event *, u64);
+	void (*enable_counter)(struct hisi_pmu *, struct hw_perf_event *);
+	void (*disable_counter)(struct hisi_pmu *, struct hw_perf_event *);
+	void (*enable_counter_int)(struct hisi_pmu *, struct hw_perf_event *);
+	void (*disable_counter_int)(struct hisi_pmu *, struct hw_perf_event *);
+	void (*start_counters)(struct hisi_pmu *);
+	void (*stop_counters)(struct hisi_pmu *);
+};
+
+struct hisi_pmu_hwevents {
+	struct perf_event *hw_events[HISI_MAX_COUNTERS];
+	DECLARE_BITMAP(used_mask, HISI_MAX_COUNTERS);
+};
+
+/* Generic pmu struct for different pmu types */
+struct hisi_pmu {
+	struct pmu pmu;
+	const struct hisi_uncore_ops *ops;
+	struct hisi_pmu_hwevents pmu_events;
+	/*
+	 * online_cpus: All online CPUs associated with the PMU
+	 * associated_cpus: All CPUs associated with the PMU who is
+	 * initialised when probe.
+	 */
+	cpumask_t online_cpus, associated_cpus;
+	/* CPU used for counting */
+	int on_cpu;
+	int irq;
+	struct device *dev;
+	struct hlist_node node;
+	u32 sccl_id;
+	u32 ccl_id;
+	/* Hardware information for different pmu types */
+	void __iomem *base;
+	/* the ID of the PMU modules */
+	u32 id;
+	int num_counters;
+	int counter_bits;
+};
+
+int hisi_uncore_pmu_counter_valid(struct hisi_pmu *hisi_pmu, int idx);
+int hisi_uncore_pmu_get_event_idx(struct perf_event *event);
+void hisi_uncore_pmu_read(struct perf_event *event);
+int hisi_uncore_pmu_add(struct perf_event *event, int flags);
+void hisi_uncore_pmu_del(struct perf_event *event, int flags);
+void hisi_uncore_pmu_start(struct perf_event *event, int flags);
+void hisi_uncore_pmu_stop(struct perf_event *event, int flags);
+void hisi_uncore_pmu_set_event_period(struct perf_event *event);
+void hisi_uncore_pmu_event_update(struct perf_event *event);
+int hisi_uncore_pmu_event_init(struct perf_event *event);
+void hisi_uncore_pmu_enable(struct pmu *pmu);
+void hisi_uncore_pmu_disable(struct pmu *pmu);
+ssize_t hisi_event_sysfs_show(struct device *dev,
+			      struct device_attribute *attr, char *buf);
+ssize_t hisi_format_sysfs_show(struct device *dev,
+			       struct device_attribute *attr, char *buf);
+ssize_t hisi_cpumask_sysfs_show(struct device *dev,
+				struct device_attribute *attr, char *buf);
+void hisi_read_sccl_and_ccl_id(u32 *sccl_id, u32 *ccl_id);
+int hisi_uncore_pmu_online_cpu(unsigned int cpu, struct hlist_node *node);
+int hisi_uncore_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node);
+void hisi_uncore_pmu_set_cpumask_by_sccl(void *arg);
+#endif /* __HISI_UNCORE_PMU_H__ */
-- 
1.9.1
