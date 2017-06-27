From: zhangshaokun@hisilicon.com (Shaokun Zhang)
Date: Tue, 27 Jun 2017 16:26:37 +0800
Subject: [PATCH 2/6] drivers: perf: hisi: Add support for HiSilicon SoC uncore
 PMU driver
In-Reply-To: <1498552001-182148-1-git-send-email-zhangshaokun@hisilicon.com>
References: <1498552001-182148-1-git-send-email-zhangshaokun@hisilicon.com>
Message-ID: <1498552001-182148-3-git-send-email-zhangshaokun@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support HiSilicon SoC uncore PMU driver framework and
interfaces.

Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Signed-off-by: Anurup M <anurup.m@huawei.com>
---
 drivers/perf/Kconfig                     |   7 +
 drivers/perf/Makefile                    |   1 +
 drivers/perf/hisilicon/Makefile          |   1 +
 drivers/perf/hisilicon/hisi_uncore_pmu.c | 416 +++++++++++++++++++++++++++++++
 drivers/perf/hisilicon/hisi_uncore_pmu.h | 116 +++++++++
 5 files changed, 541 insertions(+)
 create mode 100644 drivers/perf/hisilicon/Makefile
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_pmu.c
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_pmu.h

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index e5197ff..14b7b9d 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -17,6 +17,13 @@ config ARM_PMU_ACPI
 	depends on ARM_PMU && ACPI
 	def_bool y
 
+config HISI_PMU
+	bool "HiSilicon SoC PMU"
+	depends on ACPI && (ARM64 || COMPILE_TEST)
+	help
+	  Support for HiSilicon SoC uncore performance monitoring
+	  unit (PMU), such as: L3C, HHA and DDRC.
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
index 0000000..3a21c9e
--- /dev/null
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
@@ -0,0 +1,416 @@
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
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#include <linux/bitmap.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/perf_event.h>
+#include "hisi_uncore_pmu.h"
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
+ * sysfs cpumask attributes
+ */
+ssize_t hisi_cpumask_sysfs_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct pmu *pmu = dev_get_drvdata(dev);
+	struct hisi_pmu *hisi_pmu = to_hisi_pmu(pmu);
+
+	return cpumap_print_to_pagebuf(true, buf, &hisi_pmu->cpus);
+}
+
+/* Read Super CPU cluster and CPU cluster ID from MPIDR_EL1 */
+void hisi_read_scl_and_ccl_id(u32 *scl_id, u32 *ccl_id)
+{
+	u64 mpidr;
+
+	mpidr = read_cpuid_mpidr();
+	if (mpidr & MPIDR_MT_BITMASK) {
+		if (scl_id)
+			*scl_id = MPIDR_AFFINITY_LEVEL(mpidr, 3);
+		if (ccl_id)
+			*ccl_id = MPIDR_AFFINITY_LEVEL(mpidr, 2);
+	} else {
+		if (scl_id)
+			*scl_id = MPIDR_AFFINITY_LEVEL(mpidr, 2);
+		if (ccl_id)
+			*ccl_id = MPIDR_AFFINITY_LEVEL(mpidr, 1);
+	}
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
+void hisi_uncore_pmu_clear_event_idx(struct hisi_pmu *hisi_pmu, int idx)
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
+	struct hisi_pmu *hisi_pmu;
+	struct hw_perf_event *hwc = &event->hw;
+	int cpu;
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
+	/* Select an available CPU to monitor events in this PMU */
+	hisi_pmu = to_hisi_pmu(event->pmu);
+	cpu = cpumask_first(&hisi_pmu->cpus);
+	if (cpu >= nr_cpu_ids)
+		return -EINVAL;
+
+	/* Enforce to use the same CPU for all events in this PMU */
+	event->cpu = cpu;
+
+	return 0;
+}
+
+/*
+ * Set the counter to count the event that we're interested in,
+ * and enable counter and interrupt.
+ */
+static void hisi_uncore_pmu_enable_event(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct hisi_pmu *hisi_pmu = to_hisi_pmu(event->pmu);
+
+	/*
+	 * Write event code in event select registers(for DDRC PMU,
+	 * event has been mapped to fixed-purpose counter, there is
+	 * no need to write event type).
+	 */
+	if (hisi_pmu->ops->write_evtype)
+		hisi_pmu->ops->write_evtype(hisi_pmu, hwc->idx,
+					    GET_EVENTID(event));
+
+	/* Enable the hardware event counting and interrupt */
+	hisi_pmu->ops->enable_counter(hisi_pmu, hwc);
+	hisi_pmu->ops->enable_counter_int(hisi_pmu, hwc);
+}
+
+/*
+ * Disable counting and interrupt.
+ */
+static void hisi_uncore_pmu_disable_event(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct hisi_pmu *hisi_pmu = to_hisi_pmu(event->pmu);
+
+	hisi_pmu->ops->disable_counter(hisi_pmu, hwc);
+	hisi_pmu->ops->disable_counter_int(hisi_pmu, hwc);
+}
+
+void hisi_uncore_pmu_set_event_period(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct hisi_pmu *hisi_pmu = to_hisi_pmu(event->pmu);
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
+u64 hisi_uncore_pmu_event_update(struct perf_event *event)
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
+
+	return new_raw_count;
+}
+
+void hisi_uncore_pmu_start(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct hisi_pmu *hisi_pmu = to_hisi_pmu(event->pmu);
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
+	/* Read hardware counter and update the Perf counter statistics */
+	hisi_uncore_pmu_event_update(event);
+	hwc->state |= PERF_HES_UPTODATE;
+}
+
+int hisi_uncore_pmu_add(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct hisi_pmu *hisi_pmu = to_hisi_pmu(event->pmu);
+	int idx;
+
+	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
+
+	/* Get an available counter index for counting */
+	idx = hisi_pmu->ops->get_event_idx(event);
+	if (idx < 0)
+		return -EAGAIN;
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
+	struct hw_perf_event *hwc = &event->hw;
+	struct hisi_pmu *hisi_pmu = to_hisi_pmu(event->pmu);
+
+	hisi_uncore_pmu_stop(event, PERF_EF_UPDATE);
+	hisi_uncore_pmu_clear_event_idx(hisi_pmu, hwc->idx);
+	perf_event_update_userpage(event);
+	hisi_pmu->pmu_events.hw_events[hwc->idx] = NULL;
+}
+
+struct hisi_pmu *hisi_pmu_alloc(struct device *dev, u32 num_cntrs)
+{
+	struct hisi_pmu *hisi_pmu;
+	struct hisi_pmu_hwevents *pmu_events;
+
+	hisi_pmu = devm_kzalloc(dev, sizeof(*hisi_pmu), GFP_KERNEL);
+	if (!hisi_pmu)
+		return ERR_PTR(-ENOMEM);
+
+	pmu_events = &hisi_pmu->pmu_events;
+	pmu_events->hw_events = devm_kcalloc(dev,
+					     num_cntrs,
+					     sizeof(*pmu_events->hw_events),
+					     GFP_KERNEL);
+	if (!pmu_events->hw_events)
+		return ERR_PTR(-ENOMEM);
+
+	pmu_events->used_mask = devm_kcalloc(dev,
+					     BITS_TO_LONGS(num_cntrs),
+					     sizeof(*pmu_events->used_mask),
+					     GFP_KERNEL);
+	if (!pmu_events->used_mask)
+		return ERR_PTR(-ENOMEM);
+
+	return hisi_pmu;
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
+	int enabled = bitmap_weight(hisi_pmu->pmu_events.used_mask,
+				    hisi_pmu->num_counters);
+
+	if (enabled)
+		return;
+
+	hisi_pmu->ops->stop_counters(hisi_pmu);
+}
+
+int hisi_uncore_pmu_setup(struct hisi_pmu *hisi_pmu, const char *pmu_name)
+{
+	/* Register the events with perf */
+	return perf_pmu_register(&hisi_pmu->pmu, pmu_name, -1);
+}
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.h b/drivers/perf/hisilicon/hisi_uncore_pmu.h
new file mode 100644
index 0000000..eb2abb0
--- /dev/null
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.h
@@ -0,0 +1,116 @@
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
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef __HISI_UNCORE_PMU_H__
+#define __HISI_UNCORE_PMU_H__
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/ktime.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <asm/local64.h>
+
+#undef pr_fmt
+#define pr_fmt(fmt)     "hisi_pmu: " fmt
+
+#define GET_EVENTID(ev)   (ev->hw.config_base & 0xff)
+#define to_hisi_pmu(p)	(container_of(p, struct hisi_pmu, pmu))
+#define HISI_MAX_PERIOD(nr) (BIT_ULL(nr) - 1)
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
+	struct perf_event **hw_events;
+	unsigned long *used_mask;
+};
+
+/* Generic pmu struct for different pmu types */
+struct hisi_pmu {
+	const char *name;
+	struct pmu pmu;
+	const struct hisi_uncore_ops *ops;
+	struct hisi_pmu_hwevents pmu_events;
+	cpumask_t cpus;
+	struct device *dev;
+	struct hlist_node node;
+	u32 scl_id;
+	u32 ccl_id;
+	/* Hardware information for different pmu types */
+	void __iomem *base;
+	union {
+		u32 ddrc_chn_id;
+		u32 l3c_tag_id;
+		u32 hha_uid;
+	};
+	int num_counters;
+	int num_events;
+	int counter_bits;
+};
+
+int hisi_uncore_pmu_counter_valid(struct hisi_pmu *hisi_pmu, int idx);
+int hisi_uncore_pmu_get_event_idx(struct perf_event *event);
+void hisi_uncore_pmu_clear_event_idx(struct hisi_pmu *hisi_pmu, int idx);
+void hisi_uncore_pmu_read(struct perf_event *event);
+int hisi_uncore_pmu_add(struct perf_event *event, int flags);
+void hisi_uncore_pmu_del(struct perf_event *event, int flags);
+void hisi_uncore_pmu_start(struct perf_event *event, int flags);
+void hisi_uncore_pmu_stop(struct perf_event *event, int flags);
+void hisi_uncore_pmu_set_event_period(struct perf_event *event);
+u64 hisi_uncore_pmu_event_update(struct perf_event *event);
+int hisi_uncore_pmu_event_init(struct perf_event *event);
+int hisi_uncore_pmu_setup(struct hisi_pmu *hisi_pmu, const char *pmu_name);
+void hisi_uncore_pmu_enable(struct pmu *pmu);
+void hisi_uncore_pmu_disable(struct pmu *pmu);
+struct hisi_pmu *hisi_pmu_alloc(struct device *dev, u32 num_cntrs);
+ssize_t hisi_event_sysfs_show(struct device *dev,
+			      struct device_attribute *attr, char *buf);
+ssize_t hisi_format_sysfs_show(struct device *dev,
+			       struct device_attribute *attr, char *buf);
+ssize_t hisi_cpumask_sysfs_show(struct device *dev,
+				struct device_attribute *attr, char *buf);
+void hisi_read_scl_and_ccl_id(u32 *scl_id, u32 *ccl_id);
+#endif /* __HISI_UNCORE_PMU_H__ */
-- 
1.9.1
