From: anurupvasu@gmail.com (Anurup M)
Date: Tue, 28 Jun 2016 05:50:26 -0400
Subject: [PATCH 5/8] arm64:perf: L3 cache(LLC) event counting in perf
In-Reply-To: <1467107429-55477-1-git-send-email-anurup.m@huawei.com>
References: <1467107429-55477-1-git-send-email-anurup.m@huawei.com>
Message-ID: <1467107429-55477-6-git-send-email-anurup.m@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	1. Add support to count L3 cache(LLC) hardware events.
	2. Add events as RAW events.
	  The events to count can be selected as RAW event
	  referring to the hardware user manual.
	  e.g.: To input as RAW events the RAW event code is
		-e r124f301
	  The RAW event encoding followed is
	  <socket ID(2 bit)><SCCL ID(4 bit)><ModuleID(4 bit)>
	  <Bank(4 bit)><event code(12 bit)>
	  So 0x1 is SocketID, 0x2 is SCCL ID, 0x4 is the LLC
	  hardware module ID, 0xf is for sum of all LLC banks,
	  0x301 is the event code for LLC_READ_ALLOCATE.
	3. Routines to read/write/start/stop/count the hardware events
	   counting

Signed-off-by: Anurup M <anurup.m@huawei.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 drivers/perf/hisilicon/hisi_uncore_llc.c | 542 +++++++++++++++++++++++++++++++
 drivers/perf/hisilicon/hisi_uncore_llc.h | 100 ++++++
 drivers/perf/hisilicon/hisi_uncore_pmu.c |  66 +++-
 drivers/perf/hisilicon/hisi_uncore_pmu.h |   3 +
 4 files changed, 700 insertions(+), 11 deletions(-)
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_llc.c
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_llc.h

diff --git a/drivers/perf/hisilicon/hisi_uncore_llc.c b/drivers/perf/hisilicon/hisi_uncore_llc.c
new file mode 100644
index 0000000..a771e1a
--- /dev/null
+++ b/drivers/perf/hisilicon/hisi_uncore_llc.c
@@ -0,0 +1,542 @@
+/*
+ * HiSilicon SoC LLC Hardware event counters support
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
+#include <linux/module.h>
+#include <linux/bitmap.h>
+#include <linux/of.h>
+#include <linux/perf_event.h>
+#include "hisi_uncore_llc.h"
+
+/* Map cfg_en values for LLC Banks */
+const int llc_cfgen_map[] = { HISI_LLC_BANK0_CFGEN, HISI_LLC_BANK1_CFGEN,
+				HISI_LLC_BANK2_CFGEN, HISI_LLC_BANK3_CFGEN
+};
+
+struct hisi_pmu *hisi_uncore_llc;
+
+static inline int hisi_llc_counter_valid(int idx)
+{
+	return (idx >= HISI_IDX_LLC_COUNTER0 &&
+			idx <= HISI_IDX_LLC_COUNTER_MAX);
+}
+
+u64 hisi_llc_event_update(struct perf_event *event,
+				struct hw_perf_event *hwc, int idx)
+{
+	struct device_node *djtag_node;
+	struct hisi_pmu *pllc_pmu = to_hisi_pmu(event->pmu);
+	struct hisi_hwmod_unit *punit;
+	struct hisi_llc_data *llc_hwmod_data;
+	u64 delta, prev_raw_count, new_raw_count = 0;
+	int cfg_en;
+	u32 raw_event_code = hwc->config_base;
+	u32 scclID = (raw_event_code & HISI_SCCL_MASK) >> 20;
+	u32 llc_idx = scclID - 1;
+	int i;
+
+	if (!scclID || (scclID >= HISI_SCCL_MASK)) {
+		pr_err("Invalid SCCL=%d in event code!\n", scclID);
+		return 0;
+	}
+
+	if (!hisi_llc_counter_valid(idx)) {
+		pr_err("Unsupported event index:%d!\n", idx);
+		return 0;
+	}
+
+	punit = &pllc_pmu->hwmod_pmu_unit[llc_idx];
+	llc_hwmod_data = punit->hwmod_data;
+
+	/* Check if the LLC data is initialized for this SCCL */
+	if (!llc_hwmod_data->djtag_node) {
+		pr_err("SCCL=%d not initialized!\n", scclID);
+		return 0;
+	}
+
+	/* Find the djtag device node of the SCCL */
+	djtag_node = llc_hwmod_data->djtag_node;
+
+	do {
+		prev_raw_count = local64_read(&hwc->prev_count);
+		for (i = 0; i < llc_hwmod_data->num_banks; i++) {
+			cfg_en = llc_hwmod_data->bank[i].cfg_en;
+
+			new_raw_count =
+					hisi_read_llc_counter(idx,
+							djtag_node, cfg_en);
+			delta = (new_raw_count - prev_raw_count) &
+							HISI_MAX_PERIOD;
+
+			local64_add(delta, &event->count);
+
+			pr_debug("delta for event:0x%x is %llu\n",
+						raw_event_code, delta);
+		}
+	} while (local64_cmpxchg(
+			&hwc->prev_count, prev_raw_count, new_raw_count) !=
+								prev_raw_count);
+
+	return new_raw_count;
+}
+
+/*
+ * Initialize LLC hardware before counting.
+ */
+int hisi_init_llc_hw_perf_event(struct hisi_pmu *pllc_pmu,
+					struct hw_perf_event *hwc)
+{
+	struct hisi_hwmod_unit *punit;
+	u32 raw_event_code = hwc->config_base;
+	atomic_t *active_events;
+	u32 scclID = (raw_event_code & HISI_SCCL_MASK) >> HISI_SCCL_SHIFT;
+	u32 llc_idx = scclID - 1;
+
+	if ((scclID == 0) || (scclID >= HISI_SCCL_MAX)) {
+		pr_err("Invalid SCCL=%d in event code=%d!\n",
+					scclID, raw_event_code);
+		return -EINVAL;
+	}
+
+	punit = &pllc_pmu->hwmod_pmu_unit[llc_idx];
+	active_events = &punit->active_events;
+
+	/* Increment the active_events for the first event counting */
+	if (!atomic_inc_not_zero(active_events)) {
+		mutex_lock(&punit->reserve_mutex);
+		if (atomic_read(active_events) == 0)
+			atomic_inc(active_events);
+		mutex_unlock(&punit->reserve_mutex);
+	}
+
+	return 0;
+}
+
+void hisi_set_llc_evtype(struct hisi_llc_data *llc_hwmod_data,
+						int idx, u32 val)
+{
+	struct device_node *djtag_node;
+	u32 reg_offset;
+	u32 value = 0;
+	int cfg_en;
+	u32 event_value;
+	int i;
+
+	event_value = (val -
+			HISI_HWEVENT_LLC_READ_ALLOCATE);
+
+	/* Select the appropriate Event select register */
+	if (idx <= 3)
+		reg_offset = HISI_LLC_EVENT_TYPE0_REG_OFF;
+	else
+		reg_offset = HISI_LLC_EVENT_TYPE1_REG_OFF;
+
+	/* Value to write to event type register */
+	val = event_value << (8 * idx);
+
+	/* Find the djtag device node of the Unit */
+	djtag_node = llc_hwmod_data->djtag_node;
+
+	/*
+	 * Set the event in LLC_EVENT_TYPEx Register
+	 * for all LLC banks
+	 */
+	for (i = 0; i < llc_hwmod_data->num_banks; i++) {
+		cfg_en = llc_hwmod_data->bank[i].cfg_en;
+		hisi_djtag_readreg(HISI_LLC_MODULE_ID,
+				cfg_en,
+				reg_offset,
+				djtag_node, &value);
+
+		value &= ~(0xff << (8 * idx));
+		value |= val;
+
+		hisi_djtag_writereg(HISI_LLC_MODULE_ID,
+				cfg_en,
+				reg_offset,
+				value,
+				djtag_node);
+	}
+}
+
+u32 hisi_write_llc_counter(struct hisi_llc_data *llc_hwmod_data,
+					int idx, u32 value)
+{
+	struct device_node *djtag_node;
+	int cfg_en;
+	u32 reg_offset = 0;
+	int i, ret = 0;
+
+	if (!hisi_llc_counter_valid(idx)) {
+		pr_err("Unsupported event index:%d!\n", idx);
+		return -EINVAL;
+	}
+
+	reg_offset = HISI_LLC_COUNTER0_REG_OFF +
+					(idx * 4);
+
+	/* Find the djtag device node of the Unit */
+	djtag_node = llc_hwmod_data->djtag_node;
+
+	for (i = 0; i < llc_hwmod_data->num_banks; i++) {
+		cfg_en = llc_hwmod_data->bank[i].cfg_en;
+		ret = hisi_djtag_writereg(HISI_LLC_MODULE_ID,
+					cfg_en,
+					reg_offset,
+					value,
+					djtag_node);
+		if (!ret)
+			ret = value;
+	}
+
+	return ret;
+}
+
+int hisi_enable_llc_counter(struct hisi_llc_data *llc_hwmod_data, int idx)
+{
+	struct device_node *djtag_node;
+	u32 value = 0;
+	int cfg_en;
+	int i, ret = 0;
+
+	if (!hisi_llc_counter_valid(idx)) {
+		pr_err("Unsupported event index:%d!\n", idx);
+		return -EINVAL;
+	}
+
+	/* Find the djtag device node of the Unit */
+	djtag_node = llc_hwmod_data->djtag_node;
+
+	/*
+	 * Set the event_bus_en bit in LLC AUCNTRL to enable counting
+	 * for all LLC banks
+	 */
+	for (i = 0; i < llc_hwmod_data->num_banks; i++) {
+		cfg_en = llc_hwmod_data->bank[i].cfg_en;
+		ret = hisi_djtag_readreg(HISI_LLC_MODULE_ID,
+				cfg_en,
+				HISI_LLC_AUCTRL_REG_OFF,
+				djtag_node, &value);
+
+		value |= HISI_LLC_AUCTRL_EVENT_BUS_EN;
+		ret = hisi_djtag_writereg(HISI_LLC_MODULE_ID,
+				cfg_en,
+				HISI_LLC_AUCTRL_REG_OFF,
+				value,
+				djtag_node);
+	}
+
+	return ret;
+}
+
+void hisi_disable_llc_counter(struct hisi_llc_data *llc_hwmod_data, int idx)
+{
+	struct device_node *djtag_node;
+	u32 value = 0;
+	int cfg_en;
+	int i;
+
+	if (!hisi_llc_counter_valid(idx)) {
+		pr_err("Unsupported event index:%d!\n", idx);
+		return;
+	}
+
+	/* Find the djtag device node of the Unit */
+	djtag_node = llc_hwmod_data->djtag_node;
+
+	/*
+	 * Clear the event_bus_en bit in LLC AUCNTRL if no other
+	 * event counting for all LLC banks
+	 */
+	for (i = 0; i < llc_hwmod_data->num_banks; i++) {
+		cfg_en = llc_hwmod_data->bank[i].cfg_en;
+		hisi_djtag_readreg(HISI_LLC_MODULE_ID,
+				cfg_en,
+				HISI_LLC_AUCTRL_REG_OFF,
+				djtag_node, &value);
+
+		value &= ~(HISI_LLC_AUCTRL_EVENT_BUS_EN);
+		hisi_djtag_writereg(HISI_LLC_MODULE_ID,
+				cfg_en,
+				HISI_LLC_AUCTRL_REG_OFF,
+				value,
+				djtag_node);
+	}
+}
+
+void hisi_clear_llc_event_idx(struct hisi_hwmod_unit *punit,
+							int idx)
+{
+	struct device_node *djtag_node;
+	void *bitmap_addr;
+	struct hisi_llc_data *llc_hwmod_data = punit->hwmod_data;
+	u32 cfg_en, value, reg_offset;
+	int i;
+
+	if (!hisi_llc_counter_valid(idx)) {
+		pr_err("Unsupported event index:%d!\n", idx);
+		return;
+	}
+
+	bitmap_addr = llc_hwmod_data->hisi_llc_event_used_mask;
+
+	__clear_bit(idx, bitmap_addr);
+
+	/* Clear Counting in LLC event config register */
+	if (idx <= 3)
+		reg_offset = HISI_LLC_EVENT_TYPE0_REG_OFF;
+	else
+		reg_offset = HISI_LLC_EVENT_TYPE1_REG_OFF;
+
+	djtag_node = llc_hwmod_data->djtag_node;
+
+	/*
+	 * Clear the event in LLC_EVENT_TYPEx Register
+	 * for all LLC banks
+	 */
+	for (i = 0; i < llc_hwmod_data->num_banks; i++) {
+		cfg_en = llc_hwmod_data->bank[i].cfg_en;
+
+		hisi_djtag_readreg(HISI_LLC_MODULE_ID,
+				cfg_en,
+				reg_offset,
+				djtag_node, &value);
+
+		value &= ~(0xff << (8 * idx));
+		value |= (0xff << (8 * idx));
+		hisi_djtag_writereg(HISI_LLC_MODULE_ID,
+				cfg_en,
+				reg_offset,
+				value,
+				djtag_node);
+	}
+}
+
+int hisi_llc_get_event_idx(struct hisi_hwmod_unit *punit)
+{
+	struct hisi_llc_data *llc_hwmod_data = punit->hwmod_data;
+	int event_idx;
+
+	event_idx =
+		find_first_zero_bit(
+			llc_hwmod_data->hisi_llc_event_used_mask,
+					HISI_MAX_CFG_LLC_CNTR);
+
+	if (event_idx == HISI_MAX_CFG_LLC_CNTR)
+		return -EAGAIN;
+
+	__set_bit(event_idx,
+		llc_hwmod_data->hisi_llc_event_used_mask);
+
+	pr_debug("event_idx=%d\n", event_idx);
+
+	return event_idx;
+}
+
+u32 hisi_read_llc_counter(int idx, struct device_node *djtag_node, int bank)
+{
+	u32 reg_offset = 0;
+	u32 value;
+
+	if (!hisi_llc_counter_valid(idx)) {
+		pr_err("Unsupported event index:%d!\n", idx);
+		return -EINVAL;
+	}
+
+	reg_offset = HISI_LLC_COUNTER0_REG_OFF + (idx * 4);
+
+	hisi_djtag_readreg(HISI_LLC_MODULE_ID, /* ModuleID  */
+			bank,
+			reg_offset, /* Register Offset */
+			djtag_node, &value);
+
+	return value;
+}
+
+static int init_hisi_llc_banks(struct hisi_llc_data *pllc_data,
+				struct platform_device *pdev)
+{
+	int i;
+
+	pllc_data->num_banks = NUM_LLC_BANKS;
+	for (i = 0; i < NUM_LLC_BANKS; i++)
+		pllc_data->bank[i].cfg_en = llc_cfgen_map[i];
+
+	return 0;
+}
+
+static int init_hisi_llc_data(struct platform_device *pdev,
+					struct hisi_pmu *pllc_pmu,
+							int *punit_id)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node;
+	struct device_node *djtag_node;
+	struct hisi_hwmod_unit *punit;
+	struct hisi_llc_data *llc_hwmod_data;
+	struct of_phandle_args arg;
+	int ret, sccl_id;
+
+	ret = of_parse_phandle_with_fixed_args(node,
+						"djtag", 1, 0, &arg);
+	if (!ret) {
+		if (arg.args[0] > 0  && arg.args[0] <= MAX_UNITS) {
+			sccl_id = arg.args[0];
+			djtag_node = arg.np;
+			if (sccl_id >= MAX_UNITS) {
+				pr_err("llc_device_probe-Invalid SCCL=%d!\n",
+						sccl_id);
+				return -EINVAL;
+			}
+		} else
+			return -EINVAL;
+	} else {
+		pr_err("llc_device_probe-node without djtag!\n");
+		return -EINVAL;
+	}
+
+	llc_hwmod_data = kzalloc(sizeof(struct hisi_llc_data), GFP_KERNEL);
+	if (!llc_hwmod_data)
+		return -ENOMEM;
+
+	llc_hwmod_data->djtag_node = djtag_node;
+	punit = &pllc_pmu->hwmod_pmu_unit[sccl_id - 1];
+
+	ret = hisi_pmu_unit_init(pdev, punit, sccl_id,
+					HISI_MAX_CFG_LLC_CNTR);
+	if (ret) {
+		kfree(llc_hwmod_data);
+		return ret;
+	}
+
+	ret = init_hisi_llc_banks(llc_hwmod_data, pdev);
+	if (ret) {
+		kfree(llc_hwmod_data);
+		return ret;
+	}
+
+	punit->hwmod_data = llc_hwmod_data;
+
+	*punit_id = sccl_id - 1;
+	return 0;
+}
+
+static void hisi_free_llc_data(struct hisi_hwmod_unit *punit)
+{
+	kfree(punit->hwmod_data);
+}
+
+void hisi_llc_pmu_init(struct platform_device *pdev,
+					struct hisi_pmu *pllc_pmu)
+{
+	pllc_pmu->pmu_type = SCCL_SPECIFIC;
+	pllc_pmu->name = "HISI_L3C";
+	pllc_pmu->num_counters = HISI_MAX_CFG_LLC_CNTR;
+	pllc_pmu->num_events = HISI_LLC_MAX_EVENTS;
+	pllc_pmu->hwmod_type = HISI_LLC;
+}
+
+static int hisi_pmu_llc_dev_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct hisi_pmu *pllc_pmu = hisi_uncore_llc;
+	struct hisi_hwmod_unit *punit;
+	int unit_id;
+
+	/* Allocate and Register PMU for the first time */
+	if (!hisi_uncore_llc) {
+		pllc_pmu = hisi_pmu_alloc(pdev);
+		if (IS_ERR(pllc_pmu))
+			return PTR_ERR(pllc_pmu);
+		hisi_llc_pmu_init(pdev, pllc_pmu);
+	}
+
+	ret = init_hisi_llc_data(pdev, pllc_pmu, &unit_id);
+	if (ret)
+		goto fail_init;
+
+	pllc_pmu->num_units++;
+
+	pllc_pmu->plat_device = pdev;
+	hisi_llc_pmu_init(pdev, pllc_pmu);
+
+	if (!hisi_uncore_llc) {
+		/* First active LLC in the chip registers the pmu */
+		pllc_pmu->pmu = (struct pmu) {
+				.name		= "HISI-L3C-PMU",
+		/*		.task_ctx_nr	= perf_invalid_context, */
+				.pmu_enable = hisi_uncore_pmu_enable,
+				.pmu_disable = hisi_uncore_pmu_disable,
+				.event_init = hisi_uncore_pmu_event_init,
+				.add = hisi_uncore_pmu_add,
+				.del = hisi_uncore_pmu_del,
+				.start = hisi_uncore_pmu_start,
+				.stop = hisi_uncore_pmu_stop,
+				.read = hisi_uncore_pmu_read,
+		};
+
+		ret = hisi_uncore_pmu_setup(pllc_pmu, pdev, "hisi_l3c");
+		if (ret) {
+			pr_err("hisi_uncore_pmu_init FAILED!!\n");
+			goto fail;
+		}
+
+		hisi_uncore_llc = pllc_pmu;
+	}
+
+	return 0;
+
+fail:
+	punit = &pllc_pmu->hwmod_pmu_unit[unit_id];
+	hisi_free_llc_data(punit);
+
+fail_init:
+	if (!hisi_uncore_llc)
+		devm_kfree(&pdev->dev, pllc_pmu);
+
+	return ret;
+}
+
+static int hisi_pmu_llc_dev_remove(struct platform_device *pdev)
+{
+	if (hisi_uncore_llc)
+		devm_kfree(&pdev->dev, hisi_uncore_llc);
+
+	return 0;
+}
+
+static const struct of_device_id llc_of_match[] = {
+	{ .compatible = "hisilicon,hip05-llc", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, llc_of_match);
+
+static struct platform_driver hisi_pmu_llc_driver = {
+	.driver = {
+		.name = "hisi-llc-perf",
+		.of_match_table = llc_of_match,
+	},
+	.probe = hisi_pmu_llc_dev_probe,
+	.remove = hisi_pmu_llc_dev_remove,
+};
+module_platform_driver(hisi_pmu_llc_driver);
+
+MODULE_DESCRIPTION("HiSilicon ARMv8 LLC PMU driver");
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Anurup M");
diff --git a/drivers/perf/hisilicon/hisi_uncore_llc.h b/drivers/perf/hisilicon/hisi_uncore_llc.h
new file mode 100644
index 0000000..beb4219
--- /dev/null
+++ b/drivers/perf/hisilicon/hisi_uncore_llc.h
@@ -0,0 +1,100 @@
+/*
+ * HiSilicon SoC LLC Hardware event counters support
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
+#ifndef __HISI_UNCORE_LLC_H__
+#define __HISI_UNCORE_LLC_H__
+
+#include "hisi_uncore_pmu.h"
+
+/*
+ * ARMv8 HiSilicon LLC RAW event types.
+ */
+enum armv8_hisi_llc_event_types {
+	HISI_HWEVENT_LLC_READ_ALLOCATE		= 0x300,
+	HISI_HWEVENT_LLC_WRITE_ALLOCATE		= 0x301,
+	HISI_HWEVENT_LLC_READ_NOALLOCATE	= 0x302,
+	HISI_HWEVENT_LLC_WRITE_NOALLOCATE	= 0x303,
+	HISI_HWEVENT_LLC_READ_HIT		= 0x304,
+	HISI_HWEVENT_LLC_WRITE_HIT		= 0x305,
+	HISI_HWEVENT_LLC_EVENT_MAX		= 0x315,
+};
+
+/*
+ * ARMv8 HiSilicon Hardware counter Index.
+ */
+enum armv8_hisi_llc_counters {
+	HISI_IDX_LLC_COUNTER0		= 0x0,
+	HISI_IDX_LLC_COUNTER_MAX	= 0x7,
+};
+
+#define HISI_LLC_MODULE_ID	0x04
+
+#define HISI_LLC_BANK0_CFGEN  0x02
+#define HISI_LLC_BANK1_CFGEN  0x04
+#define HISI_LLC_BANK2_CFGEN  0x01
+#define HISI_LLC_BANK3_CFGEN  0x08
+
+#define HISI_LLC_AUCTRL_REG_OFF 0x04
+#define HISI_LLC_AUCTRL_EVENT_BUS_EN 0x1000000
+
+#define HISI_LLC_EVENT_TYPE0_REG_OFF 0x140
+#define HISI_LLC_EVENT_TYPE1_REG_OFF 0x144
+
+#define HISI_MAX_CFG_LLC_CNTR	0x08
+
+#define HISI_LLC_COUNTER0_REG_OFF 0x170
+
+#define HISI_LLC_MAX_EVENTS 22
+
+#define NUM_LLC_BANKS 4
+
+struct hisi_hwc_prev_counter {
+	local64_t prev_count;
+};
+
+struct hisi_llc_hwc_data_info {
+	u32 num_banks;
+	struct hisi_hwc_prev_counter *hwc_prev_counters;
+};
+
+struct llc_bank_info {
+	u32 cfg_en;
+};
+
+struct hisi_llc_data {
+	struct device_node *djtag_node;
+	DECLARE_BITMAP(hisi_llc_event_used_mask,
+				HISI_MAX_CFG_LLC_CNTR);
+	u32 num_banks;
+	struct llc_bank_info bank[MAX_BANKS];
+};
+
+int hisi_llc_get_event_idx(struct hisi_hwmod_unit *);
+void hisi_clear_llc_event_idx(struct hisi_hwmod_unit *,	int);
+void hisi_set_llc_evtype(struct hisi_llc_data *, int, u32);
+u32 hisi_read_llc_counter(int, struct device_node *, int);
+u32 hisi_write_llc_counter(struct hisi_llc_data *, int, u32);
+int hisi_init_llc_hw_perf_event(struct hisi_pmu *, struct hw_perf_event *);
+u64 hisi_llc_event_update(struct perf_event *,
+					struct hw_perf_event *, int);
+void hisi_disable_llc_counter(struct hisi_llc_data *, int);
+int hisi_enable_llc_counter(struct hisi_llc_data *, int);
+
+#endif /* __HISI_UNCORE_LLC_H__ */
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
index 40bdc23..e02cb81 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
@@ -24,6 +24,7 @@
 #include <linux/of.h>
 #include <linux/perf_event.h>
 #include "hisi_uncore_pmu.h"
+#include "hisi_uncore_llc.h"
 
 /* djtag read interface - Call djtag driver to access SoC registers */
 int hisi_djtag_readreg(int module_id, int bank, u32 offset,
@@ -61,15 +62,24 @@ int hisi_djtag_writereg(int module_id, int bank,
 void hisi_uncore_pmu_write_evtype(struct hisi_hwmod_unit *punit,
 						int idx, u32 val)
 {
-	/* TBD: Select event based on Hardware counter Module */
+	/* Select event based on Hardware counter Module */
+	if (idx >= HISI_IDX_LLC_COUNTER0 &&
+		idx <= HISI_IDX_LLC_COUNTER_MAX)
+		hisi_set_llc_evtype(punit->hwmod_data, idx, val);
 }
 
 int hisi_pmu_get_event_idx(struct hw_perf_event *hwc,
 						struct hisi_hwmod_unit *punit)
 {
 	int event_idx = -1;
+	u32 raw_event_code = hwc->config_base;
+	unsigned long evtype = raw_event_code & HISI_EVTYPE_EVENT;
 
-	/* TBD - Get the available hardware event counter index */
+	/* If event type is LLC events */
+	if (evtype >= HISI_HWEVENT_LLC_READ_ALLOCATE &&
+			evtype <= HISI_HWEVENT_LLC_EVENT_MAX) {
+		event_idx = hisi_llc_get_event_idx(punit);
+	}
 
 	return event_idx;
 }
@@ -78,14 +88,22 @@ void hisi_pmu_clear_event_idx(struct hw_perf_event *hwc,
 					struct hisi_hwmod_unit *punit,
 								int idx)
 {
-	/* TBD - Release the hardware event counter index */
+	u32 raw_event_code = hwc->config_base;
+	unsigned long evtype = raw_event_code & HISI_EVTYPE_EVENT;
+
+	if (evtype >= HISI_HWEVENT_LLC_READ_ALLOCATE &&
+			evtype <= HISI_HWEVENT_LLC_EVENT_MAX) {
+		hisi_clear_llc_event_idx(punit, idx);
+	}
 }
 
 static int
 __hw_perf_event_init(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
+	struct hisi_pmu *phisi_pmu = to_hisi_pmu(event->pmu);
 	int mapping;
+	int err;
 
 	mapping = pmu_map_event(event);
 	if (mapping < 0) {
@@ -108,7 +126,11 @@ __hw_perf_event_init(struct perf_event *event)
 	 * For HiSilicon SoC store the event encoding into the config_base
 	 * field.
 	 */
-	hwc->config_base = event->attr.config;
+	/* For HiSilicon SoC LLC update config_base based on event encoding */
+	if (mapping >= HISI_HWEVENT_LLC_READ_ALLOCATE &&
+				mapping <= HISI_HWEVENT_LLC_EVENT_MAX) {
+		hwc->config_base = event->attr.config;
+	}
 
 	/*
 	 * Limit the sample_period to half of the counter width. That way, the
@@ -119,9 +141,18 @@ __hw_perf_event_init(struct perf_event *event)
 	hwc->last_period    = hwc->sample_period;
 	local64_set(&hwc->period_left, hwc->sample_period);
 
-	/* TBD: Initialize event counter variables to support multiple
-	 * HiSilicon Soc SCCL and banks
+	/* Initialize event counter variables to support multiple
+	 * HiSilicon SoC SCCL and banks
 	 */
+	if (mapping >= HISI_HWEVENT_LLC_READ_ALLOCATE &&
+				mapping <= HISI_HWEVENT_LLC_EVENT_MAX) {
+		/* Init LLC hardware */
+		err = hisi_init_llc_hw_perf_event(phisi_pmu, hwc);
+		if (err)
+			return err;
+	} else {
+		return -EINVAL;
+	}
 
 	return 0;
 }
@@ -185,10 +216,15 @@ u64 hisi_uncore_pmu_event_update(struct perf_event *event,
 					struct hw_perf_event *hwc,
 							int idx) {
 	u64 new_raw_count = 0;
+	int cntr_idx = idx & ~(HISI_CNTR_SCCL_MASK);
+
 	/*
-	 * TBD: Identify Event type and read appropriate hardware
+	 * Identify Event type and read appropriate hardware
 	 * counter and sum the values
 	 */
+	if (cntr_idx >= HISI_IDX_LLC_COUNTER0 &&
+		cntr_idx <= HISI_IDX_LLC_COUNTER_MAX)
+		new_raw_count = hisi_llc_event_update(event, hwc, idx);
 
 	return new_raw_count;
 }
@@ -208,7 +244,9 @@ int hisi_pmu_enable_counter(struct hisi_hwmod_unit *punit,
 {
 	int ret = 0;
 
-	/* TBD - Enable the hardware event counting */
+	if (idx >= HISI_IDX_LLC_COUNTER0 &&
+		idx <= HISI_IDX_LLC_COUNTER_MAX)
+		ret = hisi_enable_llc_counter(punit->hwmod_data, idx);
 
 	return ret;
 }
@@ -216,7 +254,11 @@ int hisi_pmu_enable_counter(struct hisi_hwmod_unit *punit,
 void hisi_pmu_disable_counter(struct hisi_hwmod_unit *punit,
 							int idx)
 {
-	/* TBD - Disable the hardware event counting */
+	int cntr_idx = idx & ~(HISI_CNTR_SCCL_MASK);
+
+	if (cntr_idx >= HISI_IDX_LLC_COUNTER0 &&
+		 cntr_idx <= HISI_IDX_LLC_COUNTER_MAX)
+		hisi_disable_llc_counter(punit->hwmod_data, idx);
 }
 
 void hisi_uncore_pmu_enable_event(struct perf_event *event)
@@ -257,7 +299,9 @@ int hisi_pmu_write_counter(struct hisi_hwmod_unit *punit,
 {
 	int ret = 0;
 
-	/* TBD - Write to the hardware event counter */
+	if (idx >= HISI_IDX_LLC_COUNTER0 &&
+		idx <= HISI_IDX_LLC_COUNTER_MAX)
+		ret = hisi_write_llc_counter(punit->hwmod_data, idx, value);
 
 	return ret;
 }
@@ -324,7 +368,7 @@ void hisi_uncore_pmu_stop(struct perf_event *event,
 {
 	struct hw_perf_event *hwc = &event->hw;
 	struct hisi_pmu *phisi_pmu = to_hisi_pmu(event->pmu);
-	struct hisi_hwmod_unit *punit = NULL;
+	struct hisi_hwmod_unit *punit;
 	u32 unit_idx = GET_UNIT_IDX(hwc->config_base);
 	int idx = hwc->idx;
 
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.h b/drivers/perf/hisilicon/hisi_uncore_pmu.h
index 7fbd09c..dfc8c83 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.h
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.h
@@ -33,6 +33,8 @@
 #undef pr_fmt
 #define pr_fmt(fmt)     "hisi_pmu: " fmt
 
+#define HISI_CNTR_SCCL_MASK    (0xF00)
+
 #define HISI_SCCL_MAX	(1 << 4)
 #define HISI_SCCL_MASK	(0xF00000)
 #define HISI_SCCL_SHIFT 20
@@ -40,6 +42,7 @@
 #define HISI_EVTYPE_EVENT	0xfff
 #define HISI_MAX_PERIOD ((1LLU << 32) - 1)
 
+#define MAX_BANKS 8
 #define MAX_COUNTERS 30
 #define MAX_UNITS 8
 
-- 
2.1.4
