From: anurupvasu@gmail.com (Anurup M)
Date: Tue, 28 Jun 2016 05:50:25 -0400
Subject: [PATCH 4/8] arm64:perf: Add support for Hisilicon SoC event counters
In-Reply-To: <1467107429-55477-1-git-send-email-anurup.m@huawei.com>
References: <1467107429-55477-1-git-send-email-anurup.m@huawei.com>
Message-ID: <1467107429-55477-5-git-send-email-anurup.m@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	1. Hisilicon SoC PMU to support different hardware event
	   counters.
	2. Register with Perf PMU as RAW events.
	3. Hisilicon PMU shall use the DJTAG hardware interface
	   to access hardware event counters and configuration
	   register.
	4. Routines to initialze and setup PMU.
	5. Routines to enable/disable/add/del/start/stop hardware
	   event counting.

Signed-off-by: Anurup M <anurup.m@huawei.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 drivers/perf/hisilicon/hisi_uncore_pmu.c | 465 +++++++++++++++++++++++++++++++
 drivers/perf/hisilicon/hisi_uncore_pmu.h | 125 +++++++++
 2 files changed, 590 insertions(+)
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_pmu.c
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_pmu.h

diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
new file mode 100644
index 0000000..40bdc23
--- /dev/null
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
@@ -0,0 +1,465 @@
+/*
+ * HiSilicon SoC Hardware event counters support
+ *
+ * Copyright (C) 2016 Huawei Technologies Limited
+ * Author: Anurup M <anurup.m@huawei.com>
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
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/bitmap.h>
+#include <linux/of.h>
+#include <linux/perf_event.h>
+#include "hisi_uncore_pmu.h"
+
+/* djtag read interface - Call djtag driver to access SoC registers */
+int hisi_djtag_readreg(int module_id, int bank, u32 offset,
+				struct device_node *djtag_node, u32 *pvalue)
+{
+	int ret;
+	u32 chain_id = 0;
+
+	while (bank != 1) {
+		bank = (bank >> 0x1);
+		chain_id++;
+	}
+
+	ret = djtag_readl(djtag_node, offset, module_id, chain_id, pvalue);
+	if (ret)
+		pr_warn("Djtag:%s Read failed!\n", djtag_node->full_name);
+
+	return ret;
+}
+
+/* djtag write interface - Call djtag driver  to access SoC registers */
+int hisi_djtag_writereg(int module_id, int bank,
+				u32 offset, u32 value,
+				struct device_node *djtag_node)
+{
+	int ret;
+
+	ret = djtag_writel(djtag_node, offset, module_id, 0, value);
+	if (ret)
+		pr_warn("Djtag:%s Write failed!\n", djtag_node->full_name);
+
+	return ret;
+}
+
+void hisi_uncore_pmu_write_evtype(struct hisi_hwmod_unit *punit,
+						int idx, u32 val)
+{
+	/* TBD: Select event based on Hardware counter Module */
+}
+
+int hisi_pmu_get_event_idx(struct hw_perf_event *hwc,
+						struct hisi_hwmod_unit *punit)
+{
+	int event_idx = -1;
+
+	/* TBD - Get the available hardware event counter index */
+
+	return event_idx;
+}
+
+void hisi_pmu_clear_event_idx(struct hw_perf_event *hwc,
+					struct hisi_hwmod_unit *punit,
+								int idx)
+{
+	/* TBD - Release the hardware event counter index */
+}
+
+static int
+__hw_perf_event_init(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	int mapping;
+
+	mapping = pmu_map_event(event);
+	if (mapping < 0) {
+		pr_debug("event %x:%llx not supported\n", event->attr.type,
+							 event->attr.config);
+		return mapping;
+	}
+
+	/*
+	 * We don't assign an index until we actually place the event onto
+	 * hardware. Use -1 to signify that we haven't decided where to put it
+	 * yet.
+	 */
+	hwc->idx		= -1;
+	hwc->config_base	= 0;
+	hwc->config		= 0;
+	hwc->event_base		= 0;
+
+	/*
+	 * For HiSilicon SoC store the event encoding into the config_base
+	 * field.
+	 */
+	hwc->config_base = event->attr.config;
+
+	/*
+	 * Limit the sample_period to half of the counter width. That way, the
+	 * new counter value is far less likely to overtake the previous one
+	 * unless you have some serious IRQ latency issues.
+	 */
+	hwc->sample_period  = HISI_MAX_PERIOD >> 1;
+	hwc->last_period    = hwc->sample_period;
+	local64_set(&hwc->period_left, hwc->sample_period);
+
+	/* TBD: Initialize event counter variables to support multiple
+	 * HiSilicon Soc SCCL and banks
+	 */
+
+	return 0;
+}
+
+void hw_perf_event_destroy(struct perf_event *event)
+{
+	struct hisi_pmu *phisi_pmu = to_hisi_pmu(event->pmu);
+	struct hisi_hwmod_unit *punit;
+	atomic_t *active_events;
+	struct mutex *reserve_mutex;
+	u32 unit_idx = GET_UNIT_IDX(event->hw.config_base);
+
+	punit = &phisi_pmu->hwmod_pmu_unit[unit_idx];
+	active_events = &punit->active_events;
+	reserve_mutex = &punit->reserve_mutex;
+
+	if (atomic_dec_and_mutex_lock(active_events, reserve_mutex)) {
+		/* FIXME: Release IRQ here */
+		mutex_unlock(reserve_mutex);
+	}
+}
+
+int hisi_uncore_pmu_event_init(struct perf_event *event)
+{
+	struct hisi_pmu *phisi_pmu = to_hisi_pmu(event->pmu);
+	struct hisi_hwmod_unit *punit;
+	u32 raw_event_code = event->attr.config;
+	u32 unit_idx = GET_UNIT_IDX(raw_event_code);
+	int err;
+
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	/* we do not support sampling */
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
+	punit = &phisi_pmu->hwmod_pmu_unit[unit_idx];
+
+	event->destroy = hw_perf_event_destroy;
+
+	err = __hw_perf_event_init(event);
+	if (err)
+		hw_perf_event_destroy(event);
+
+	return err;
+}
+
+
+/* Read hardware counter and update the Perf counter statistics */
+u64 hisi_uncore_pmu_event_update(struct perf_event *event,
+					struct hw_perf_event *hwc,
+							int idx) {
+	u64 new_raw_count = 0;
+	/*
+	 * TBD: Identify Event type and read appropriate hardware
+	 * counter and sum the values
+	 */
+
+	return new_raw_count;
+}
+
+void hisi_uncore_pmu_enable(struct pmu *pmu)
+{
+	/* TBD: Enable all the PMU counters. */
+}
+
+void hisi_uncore_pmu_disable(struct pmu *pmu)
+{
+	/* TBD: Disable all the PMU counters. */
+}
+
+int hisi_pmu_enable_counter(struct hisi_hwmod_unit *punit,
+							int idx)
+{
+	int ret = 0;
+
+	/* TBD - Enable the hardware event counting */
+
+	return ret;
+}
+
+void hisi_pmu_disable_counter(struct hisi_hwmod_unit *punit,
+							int idx)
+{
+	/* TBD - Disable the hardware event counting */
+}
+
+void hisi_uncore_pmu_enable_event(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct hisi_pmu *phisi_pmu = to_hisi_pmu(event->pmu);
+	struct hisi_hwmod_unit *punit;
+	u32 unit_idx = GET_UNIT_IDX(hwc->config_base);
+	int idx = hwc->idx;
+
+	punit = &phisi_pmu->hwmod_pmu_unit[unit_idx];
+
+	/*
+	 * Enable counter and set the counter to count
+	 * the event that we're interested in.
+	 */
+
+	/*
+	 * Disable counter
+	 */
+	hisi_pmu_disable_counter(punit, idx);
+
+	/*
+	 * Set event (if destined for Hisilicon SoC counters).
+	 */
+	hisi_uncore_pmu_write_evtype(punit, idx, hwc->config_base);
+
+	/*
+	 * Enable counter
+	 */
+	hisi_pmu_enable_counter(punit, idx);
+
+}
+
+int hisi_pmu_write_counter(struct hisi_hwmod_unit *punit,
+						int idx,
+						u32 value)
+{
+	int ret = 0;
+
+	/* TBD - Write to the hardware event counter */
+
+	return ret;
+}
+
+void hisi_pmu_event_set_period(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct hisi_pmu *phisi_pmu = to_hisi_pmu(event->pmu);
+	struct hisi_hwmod_unit *punit;
+	u32 unit_idx = GET_UNIT_IDX(hwc->config_base);
+	int idx = hwc->idx;
+
+	/*
+	 * The Hisilicon PMU counters have a period of 2^32. To account for the
+	 * possiblity of extreme interrupt latency we program for a period of
+	 * half that. Hopefully we can handle the interrupt before another 2^31
+	 * events occur and the counter overtakes its previous value.
+	 */
+	u64 val = 1ULL << 31;
+
+	punit = &phisi_pmu->hwmod_pmu_unit[unit_idx];
+	local64_set(&hwc->prev_count, val);
+	hisi_pmu_write_counter(punit, idx, val);
+}
+
+void hisi_uncore_pmu_start(struct perf_event *event,
+						int pmu_flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct hisi_pmu *phisi_pmu = to_hisi_pmu(event->pmu);
+	struct hisi_hwmod_unit *punit;
+	struct hisi_pmu_hw_events *hw_events;
+	u32 unit_idx = GET_UNIT_IDX(hwc->config_base);
+	unsigned long flags;
+
+	if (unit_idx >= (HISI_SCCL_MAX - 1)) {
+		pr_err("Invalid unitID=%d in event code=%lu!\n",
+					unit_idx + 1, hwc->config_base);
+		return;
+	}
+
+	punit = &phisi_pmu->hwmod_pmu_unit[unit_idx];
+	hw_events = &punit->hw_events;
+
+	/*
+	 * To handle interrupt latency, we always reprogram the period
+	 * regardlesss of PERF_EF_RELOAD.
+	 */
+	if (pmu_flags & PERF_EF_RELOAD)
+		WARN_ON_ONCE(!(hwc->state & PERF_HES_UPTODATE));
+
+	hwc->state = 0;
+
+	raw_spin_lock_irqsave(&hw_events->pmu_lock, flags);
+
+	hisi_pmu_event_set_period(event);
+	hisi_uncore_pmu_enable_event(event);
+
+	raw_spin_unlock_irqrestore(&hw_events->pmu_lock, flags);
+}
+
+void hisi_uncore_pmu_stop(struct perf_event *event,
+						int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct hisi_pmu *phisi_pmu = to_hisi_pmu(event->pmu);
+	struct hisi_hwmod_unit *punit = NULL;
+	u32 unit_idx = GET_UNIT_IDX(hwc->config_base);
+	int idx = hwc->idx;
+
+	if (hwc->state & PERF_HES_STOPPED)
+		return;
+
+	punit = &phisi_pmu->hwmod_pmu_unit[unit_idx];
+
+	/*
+	 * We always reprogram the counter, so ignore PERF_EF_UPDATE. See
+	 * hisi_uncore_pmu_start()
+	 */
+	hisi_pmu_disable_counter(punit, idx);
+	hisi_uncore_pmu_event_update(event, hwc, idx);
+	hwc->state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
+
+}
+
+int hisi_uncore_pmu_add(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct hisi_pmu *phisipmu = to_hisi_pmu(event->pmu);
+	struct hisi_hwmod_unit *punit;
+	struct hisi_pmu_hw_events *hw_events;
+	u32 unit_idx = GET_UNIT_IDX(hwc->config_base);
+	int idx, err = 0;
+
+	if (unit_idx >= (HISI_SCCL_MAX - 1)) {
+		pr_err("Invalid unitID=%d in event code=%lu\n",
+					unit_idx + 1, hwc->config_base);
+		return -EINVAL;
+	}
+
+	punit = &phisipmu->hwmod_pmu_unit[unit_idx];
+	hw_events = &punit->hw_events;
+
+	/* If we don't have a free counter then return early. */
+	idx = hisi_pmu_get_event_idx(hwc, punit);
+	if (idx < 0) {
+		err = idx;
+		goto out;
+	}
+
+	event->hw.idx = idx;
+	hw_events->events[idx] = event;
+
+	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
+	if (flags & PERF_EF_START)
+		hisi_uncore_pmu_start(event, PERF_EF_RELOAD);
+
+	/* Propagate our changes to the userspace mapping. */
+	perf_event_update_userpage(event);
+
+out:
+	return err;
+}
+
+void hisi_uncore_pmu_del(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct hisi_pmu *phisipmu = to_hisi_pmu(event->pmu);
+	struct hisi_hwmod_unit *punit;
+	struct hisi_pmu_hw_events *hw_events;
+	u32 unit_idx = GET_UNIT_IDX(hwc->config_base);
+	int idx = hwc->idx;
+
+	punit = &phisipmu->hwmod_pmu_unit[unit_idx];
+	hw_events = &punit->hw_events;
+
+	hisi_uncore_pmu_stop(event, PERF_EF_UPDATE);
+	hw_events->events[idx] = NULL;
+
+	hisi_pmu_clear_event_idx(hwc, punit, idx);
+
+	perf_event_update_userpage(event);
+}
+
+int pmu_map_event(struct perf_event *event)
+{
+	return (int)(event->attr.config & HISI_EVTYPE_EVENT);
+}
+
+struct hisi_pmu *hisi_pmu_alloc(struct platform_device *pdev)
+{
+	struct hisi_pmu *phisipmu;
+
+	phisipmu = devm_kzalloc(&pdev->dev, sizeof(*phisipmu), GFP_KERNEL);
+	if (!phisipmu)
+		return ERR_PTR(-ENOMEM);
+
+	return phisipmu;
+}
+
+int hisi_pmu_unit_init(struct platform_device *pdev,
+				struct hisi_hwmod_unit *punit,
+						int unit_id,
+						int num_counters)
+{
+	punit->hw_events.events = devm_kcalloc(&pdev->dev,
+				     num_counters,
+				     sizeof(*punit->hw_events.events),
+							     GFP_KERNEL);
+	if (!punit->hw_events.events)
+		return -ENOMEM;
+
+	raw_spin_lock_init(&punit->hw_events.pmu_lock);
+	atomic_set(&punit->active_events, 0);
+	mutex_init(&punit->reserve_mutex);
+
+	punit->unit_id = unit_id;
+
+	return 0;
+}
+
+void hisi_uncore_pmu_read(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	int idx = hwc->idx;
+
+	hisi_uncore_pmu_event_update(event, hwc, idx);
+}
+
+int hisi_uncore_pmu_setup(struct hisi_pmu *hisipmu,
+				struct platform_device *pdev,
+						char *pmu_name)
+{
+	int ret;
+
+	/* Register the events are RAW events to support RAW events too */
+	ret = perf_pmu_register(&hisipmu->pmu, pmu_name, PERF_TYPE_RAW);
+	if (ret)
+		goto fail;
+
+	return 0;
+
+fail:
+	return ret;
+}
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.h b/drivers/perf/hisilicon/hisi_uncore_pmu.h
new file mode 100644
index 0000000..7fbd09c
--- /dev/null
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.h
@@ -0,0 +1,125 @@
+/*
+ * HiSilicon SoC Hardware event counters support
+ *
+ * Copyright (C) 2016 Huawei Technologies Limited
+ * Author: Anurup M <anurup.m@huawei.com>
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
+#ifndef __HISI_UNCORE_PMU_H__
+#define __HISI_UNCORE_PMU_H__
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <asm/local64.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <asm/hisi-djtag.h>
+
+#undef pr_fmt
+#define pr_fmt(fmt)     "hisi_pmu: " fmt
+
+#define HISI_SCCL_MAX	(1 << 4)
+#define HISI_SCCL_MASK	(0xF00000)
+#define HISI_SCCL_SHIFT 20
+
+#define HISI_EVTYPE_EVENT	0xfff
+#define HISI_MAX_PERIOD ((1LLU << 32) - 1)
+
+#define MAX_COUNTERS 30
+#define MAX_UNITS 8
+
+enum hisi_hwmod_type {
+	HISI_LLC = 0x0,
+};
+
+/* Event granularity */
+enum hisi_pmu_type {
+	CORE_SPECIFIC,
+	CCL_SPECIFIC,
+	SCCL_SPECIFIC,
+	SOCKET_SPECIFIC,
+};
+
+struct hisi_pmu_hw_events {
+	struct perf_event **events;
+	raw_spinlock_t pmu_lock;
+};
+
+/* Hardware module information */
+struct hisi_hwmod_unit {
+	   int unit_id;
+	   struct hisi_pmu_hw_events hw_events;
+	   atomic_t active_events;
+	   struct mutex reserve_mutex;
+	   void *hwmod_data;
+};
+
+/* Generic pmu struct for different pmu types */
+struct hisi_pmu {
+	const char *name;
+	enum hisi_pmu_type pmu_type;
+	enum hisi_hwmod_type hwmod_type;
+	int num_counters;
+	int	num_events;
+	struct perf_event *events[MAX_COUNTERS];
+	int num_units;
+	int (*check_event)(u64);
+	struct hisi_hwmod_unit hwmod_pmu_unit[MAX_UNITS];
+	struct pmu pmu; /* for custom pmu ops */
+	struct platform_device *plat_device;
+};
+
+#define to_hisi_pmu(c)	(container_of(c, struct hisi_pmu, pmu))
+
+#define GET_UNIT_IDX(event_code)		\
+	(((event_code & HISI_SCCL_MASK) >>	\
+			   HISI_SCCL_SHIFT) - 1)
+
+int pmu_map_event(struct perf_event *);
+u64 hisi_pmu_event_update(struct perf_event *,
+				struct hw_perf_event *, int);
+int hisi_pmu_enable_counter(struct hisi_hwmod_unit *, int);
+void hisi_pmu_disable_counter(struct hisi_hwmod_unit *, int);
+int hisi_pmu_write_counter(struct hisi_hwmod_unit *, int, u32);
+void hisi_pmu_write_evtype(int, u32);
+int hisi_pmu_get_event_idx(struct hw_perf_event *,
+				struct hisi_hwmod_unit *);
+void hisi_pmu_clear_event_idx(struct hw_perf_event *,
+				struct hisi_hwmod_unit *, int);
+void hisi_uncore_pmu_read(struct perf_event *);
+void hisi_uncore_pmu_del(struct perf_event *, int);
+int hisi_uncore_pmu_add(struct perf_event *, int);
+void hisi_uncore_pmu_start(struct perf_event *, int);
+void hisi_uncore_pmu_stop(struct perf_event *, int);
+void hisi_pmu_event_set_period(struct perf_event *);
+void hisi_uncore_pmu_enable_event(struct perf_event *);
+void hisi_uncore_pmu_disable_event(struct perf_event *);
+void hisi_uncore_pmu_enable(struct pmu *);
+void hisi_uncore_pmu_disable(struct pmu *);
+struct hisi_pmu *hisi_uncore_pmu_alloc(struct platform_device *);
+int hisi_uncore_pmu_setup(struct hisi_pmu *hisi_pmu,
+				struct platform_device *, char *);
+void hisi_uncore_pmu_write_evtype(struct hisi_hwmod_unit *, int, u32);
+int hisi_uncore_pmu_event_init(struct perf_event *);
+int hisi_djtag_readreg(int, int, u32, struct device_node *, u32 *);
+int hisi_djtag_writereg(int, int, u32, u32, struct device_node *);
+int hisi_pmu_unit_init(struct platform_device *,
+				struct hisi_hwmod_unit *,
+						int, int);
+struct hisi_pmu *hisi_pmu_alloc(struct platform_device *);
+#endif /* __HISI_UNCORE_PMU_H__ */
-- 
2.1.4
