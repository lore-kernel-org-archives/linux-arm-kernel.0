From: anurupvasu@gmail.com (Anurup M)
Date: Thu,  4 Aug 2016 05:07:10 -0400
Subject: [RFC PATCH v1 06/10] arm64:perf: Add support for Hisilicon SoC event
 counters
In-Reply-To: <1470301634-79736-1-git-send-email-anurup.m@huawei.com>
References: <1470301634-79736-1-git-send-email-anurup.m@huawei.com>
Message-ID: <1470301634-79736-7-git-send-email-anurup.m@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	1. Hip05 uncore PMU to support different hardware
	   event counters.
	2. Hisilicon PMU shall use the DJTAG hardware interface
	   to access hardware event counters and configuration
	   register.
	3. Routines to initialize and setup PMU.
	4. Routines to enable/disable/add/del/start/stop hardware
	   event counting.
	5. Add support to count L3 cache hardware events.

Signed-off-by: Anurup M <anurup.m@huawei.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 drivers/perf/hisilicon/hisi_uncore_l3c.c | 511 +++++++++++++++++++++++++++++++
 drivers/perf/hisilicon/hisi_uncore_l3c.h | 100 ++++++
 drivers/perf/hisilicon/hisi_uncore_pmu.c | 476 ++++++++++++++++++++++++++++
 drivers/perf/hisilicon/hisi_uncore_pmu.h | 128 ++++++++
 4 files changed, 1215 insertions(+)
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_l3c.c
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_l3c.h
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_pmu.c
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_pmu.h

diff --git a/drivers/perf/hisilicon/hisi_uncore_l3c.c b/drivers/perf/hisilicon/hisi_uncore_l3c.c
new file mode 100644
index 0000000..e606cc4
--- /dev/null
+++ b/drivers/perf/hisilicon/hisi_uncore_l3c.c
@@ -0,0 +1,511 @@
+/*
+ * HiSilicon SoC L3C Hardware event counters support
+ *
+ * Copyright (C) 2016 Huawei Technologies Limited
+ * Author: Anurup M <anurup.m@huawei.com>
+ *
+ * This code is based on the uncore PMU's like arm-cci and
+ * arm-ccn.
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
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/perf_event.h>
+#include "hisi_uncore_l3c.h"
+
+/* Map cfg_en values for L3C Banks */
+const int l3c_cfgen_map[] = { HISI_L3C_BANK0_CFGEN, HISI_L3C_BANK1_CFGEN,
+				HISI_L3C_BANK2_CFGEN, HISI_L3C_BANK3_CFGEN
+};
+
+static struct hisi_pmu *hisi_uncore_l3c;
+
+static inline int hisi_l3c_counter_valid(int idx)
+{
+	return (idx >= HISI_IDX_L3C_COUNTER0 &&
+			idx <= HISI_IDX_L3C_COUNTER_MAX);
+}
+
+u64 hisi_l3c_event_update(struct perf_event *event,
+				struct hw_perf_event *hwc, int idx)
+{
+	struct device_node *djtag_node;
+	struct hisi_pmu *pl3c_pmu = to_hisi_pmu(event->pmu);
+	struct hisi_hwmod_unit *punit;
+	struct hisi_l3c_data *l3c_hwmod_data;
+	u64 delta, prev_raw_count, new_raw_count = 0;
+	int cfg_en;
+	u32 raw_event_code = hwc->config_base;
+	u32 scclID = (raw_event_code & HISI_SCCL_MASK) >> 20;
+	u32 l3c_idx = scclID - 1;
+	int i;
+
+	if (!scclID || (scclID >= HISI_SCCL_MASK)) {
+		pr_err("Invalid SCCL=%d in event code!\n", scclID);
+		return 0;
+	}
+
+	if (!hisi_l3c_counter_valid(idx)) {
+		pr_err("Unsupported event index:%d!\n", idx);
+		return 0;
+	}
+
+	punit = &pl3c_pmu->hwmod_pmu_unit[l3c_idx];
+	l3c_hwmod_data = punit->hwmod_data;
+
+	/* Check if the L3C data is initialized for this SCCL */
+	if (!l3c_hwmod_data->djtag_node) {
+		pr_err("SCCL=%d not initialized!\n", scclID);
+		return 0;
+	}
+
+	/* Find the djtag device node of the SCCL */
+	djtag_node = l3c_hwmod_data->djtag_node;
+
+	do {
+		prev_raw_count = local64_read(&hwc->prev_count);
+		for (i = 0; i < l3c_hwmod_data->num_banks; i++) {
+			cfg_en = l3c_hwmod_data->bank[i].cfg_en;
+
+			new_raw_count =
+					hisi_read_l3c_counter(idx,
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
+void hisi_set_l3c_evtype(struct hisi_l3c_data *l3c_hwmod_data,
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
+			HISI_HWEVENT_L3C_READ_ALLOCATE);
+
+	/* Select the appropriate Event select register */
+	if (idx <= 3)
+		reg_offset = HISI_L3C_EVENT_TYPE0_REG_OFF;
+	else
+		reg_offset = HISI_L3C_EVENT_TYPE1_REG_OFF;
+
+	/* Value to write to event type register */
+	val = event_value << (8 * idx);
+
+	/* Find the djtag device node of the Unit */
+	djtag_node = l3c_hwmod_data->djtag_node;
+
+	/*
+	 * Set the event in L3C_EVENT_TYPEx Register
+	 * for all L3C banks
+	 */
+	for (i = 0; i < l3c_hwmod_data->num_banks; i++) {
+		cfg_en = l3c_hwmod_data->bank[i].cfg_en;
+		hisi_djtag_readreg(HISI_L3C_MODULE_ID,
+				cfg_en,
+				reg_offset,
+				djtag_node, &value);
+
+		value &= ~(0xff << (8 * idx));
+		value |= val;
+
+		hisi_djtag_writereg(HISI_L3C_MODULE_ID,
+				cfg_en,
+				reg_offset,
+				value,
+				djtag_node);
+	}
+}
+
+u32 hisi_write_l3c_counter(struct hisi_l3c_data *l3c_hwmod_data,
+					int idx, u32 value)
+{
+	struct device_node *djtag_node;
+	int cfg_en;
+	u32 reg_offset = 0;
+	int i, ret = 0;
+
+	if (!hisi_l3c_counter_valid(idx)) {
+		pr_err("Unsupported event index:%d!\n", idx);
+		return -EINVAL;
+	}
+
+	reg_offset = HISI_L3C_COUNTER0_REG_OFF +
+					(idx * 4);
+
+	/* Find the djtag device node of the Unit */
+	djtag_node = l3c_hwmod_data->djtag_node;
+
+	for (i = 0; i < l3c_hwmod_data->num_banks; i++) {
+		cfg_en = l3c_hwmod_data->bank[i].cfg_en;
+		ret = hisi_djtag_writereg(HISI_L3C_MODULE_ID,
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
+int hisi_enable_l3c_counter(struct hisi_l3c_data *l3c_hwmod_data, int idx)
+{
+	struct device_node *djtag_node;
+	u32 value = 0;
+	int cfg_en;
+	int i, ret = 0;
+
+	if (!hisi_l3c_counter_valid(idx)) {
+		pr_err("Unsupported event index:%d!\n", idx);
+		return -EINVAL;
+	}
+
+	/* Find the djtag device node of the Unit */
+	djtag_node = l3c_hwmod_data->djtag_node;
+
+	/*
+	 * Set the event_bus_en bit in L3C AUCNTRL to enable counting
+	 * for all L3C banks
+	 */
+	for (i = 0; i < l3c_hwmod_data->num_banks; i++) {
+		cfg_en = l3c_hwmod_data->bank[i].cfg_en;
+		ret = hisi_djtag_readreg(HISI_L3C_MODULE_ID,
+				cfg_en,
+				HISI_L3C_AUCTRL_REG_OFF,
+				djtag_node, &value);
+
+		value |= HISI_L3C_AUCTRL_EVENT_BUS_EN;
+		ret = hisi_djtag_writereg(HISI_L3C_MODULE_ID,
+				cfg_en,
+				HISI_L3C_AUCTRL_REG_OFF,
+				value,
+				djtag_node);
+	}
+
+	return ret;
+}
+
+void hisi_disable_l3c_counter(struct hisi_l3c_data *l3c_hwmod_data, int idx)
+{
+	struct device_node *djtag_node;
+	u32 value = 0;
+	int cfg_en;
+	int i;
+
+	if (!hisi_l3c_counter_valid(idx)) {
+		pr_err("Unsupported event index:%d!\n", idx);
+		return;
+	}
+
+	/* Find the djtag device node of the Unit */
+	djtag_node = l3c_hwmod_data->djtag_node;
+
+	/*
+	 * Clear the event_bus_en bit in L3C AUCNTRL if no other
+	 * event counting for all L3C banks
+	 */
+	for (i = 0; i < l3c_hwmod_data->num_banks; i++) {
+		cfg_en = l3c_hwmod_data->bank[i].cfg_en;
+		hisi_djtag_readreg(HISI_L3C_MODULE_ID,
+				cfg_en,
+				HISI_L3C_AUCTRL_REG_OFF,
+				djtag_node, &value);
+
+		value &= ~(HISI_L3C_AUCTRL_EVENT_BUS_EN);
+		hisi_djtag_writereg(HISI_L3C_MODULE_ID,
+				cfg_en,
+				HISI_L3C_AUCTRL_REG_OFF,
+				value,
+				djtag_node);
+	}
+}
+
+void hisi_clear_l3c_event_idx(struct hisi_hwmod_unit *punit,
+							int idx)
+{
+	struct device_node *djtag_node;
+	void *bitmap_addr;
+	struct hisi_l3c_data *l3c_hwmod_data = punit->hwmod_data;
+	u32 cfg_en, value, reg_offset;
+	int i;
+
+	if (!hisi_l3c_counter_valid(idx)) {
+		pr_err("Unsupported event index:%d!\n", idx);
+		return;
+	}
+
+	bitmap_addr = l3c_hwmod_data->hisi_l3c_event_used_mask;
+
+	__clear_bit(idx, bitmap_addr);
+
+	/* Clear Counting in L3C event config register */
+	if (idx <= 3)
+		reg_offset = HISI_L3C_EVENT_TYPE0_REG_OFF;
+	else
+		reg_offset = HISI_L3C_EVENT_TYPE1_REG_OFF;
+
+	djtag_node = l3c_hwmod_data->djtag_node;
+
+	/*
+	 * Clear the event in L3C_EVENT_TYPEx Register
+	 * for all L3C banks
+	 */
+	for (i = 0; i < l3c_hwmod_data->num_banks; i++) {
+		cfg_en = l3c_hwmod_data->bank[i].cfg_en;
+
+		hisi_djtag_readreg(HISI_L3C_MODULE_ID,
+				cfg_en,
+				reg_offset,
+				djtag_node, &value);
+
+		value &= ~(0xff << (8 * idx));
+		value |= (0xff << (8 * idx));
+		hisi_djtag_writereg(HISI_L3C_MODULE_ID,
+				cfg_en,
+				reg_offset,
+				value,
+				djtag_node);
+	}
+}
+
+int hisi_l3c_get_event_idx(struct hisi_hwmod_unit *punit)
+{
+	struct hisi_l3c_data *l3c_hwmod_data = punit->hwmod_data;
+	int event_idx;
+
+	event_idx =
+		find_first_zero_bit(
+			l3c_hwmod_data->hisi_l3c_event_used_mask,
+					HISI_MAX_CFG_L3C_CNTR);
+
+	if (event_idx == HISI_MAX_CFG_L3C_CNTR)
+		return -EAGAIN;
+
+	__set_bit(event_idx,
+		l3c_hwmod_data->hisi_l3c_event_used_mask);
+
+	pr_debug("event_idx=%d\n", event_idx);
+
+	return event_idx;
+}
+
+u32 hisi_read_l3c_counter(int idx, struct device_node *djtag_node, int bank)
+{
+	u32 reg_offset = 0;
+	u32 value;
+
+	if (!hisi_l3c_counter_valid(idx)) {
+		pr_err("Unsupported event index:%d!\n", idx);
+		return -EINVAL;
+	}
+
+	reg_offset = HISI_L3C_COUNTER0_REG_OFF + (idx * 4);
+
+	hisi_djtag_readreg(HISI_L3C_MODULE_ID, /* ModuleID  */
+			bank,
+			reg_offset, /* Register Offset */
+			djtag_node, &value);
+
+	return value;
+}
+
+static int init_hisi_l3c_banks(struct hisi_l3c_data *pl3c_data,
+				struct platform_device *pdev)
+{
+	int i;
+
+	pl3c_data->num_banks = NUM_L3C_BANKS;
+	for (i = 0; i < NUM_L3C_BANKS; i++)
+		pl3c_data->bank[i].cfg_en = l3c_cfgen_map[i];
+
+	return 0;
+}
+
+static int init_hisi_l3c_data(struct platform_device *pdev,
+					struct hisi_pmu *pl3c_pmu,
+							int *punit_id)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node;
+	struct device_node *djtag_node;
+	struct hisi_hwmod_unit *punit;
+	struct hisi_l3c_data *l3c_hwmod_data;
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
+				pr_err("l3c_device_probe-Invalid SCCL=%d!\n",
+						sccl_id);
+				return -EINVAL;
+			}
+		} else
+			return -EINVAL;
+	} else {
+		pr_err("l3c_device_probe-node without djtag!\n");
+		return -EINVAL;
+	}
+
+	l3c_hwmod_data = kzalloc(sizeof(struct hisi_l3c_data), GFP_KERNEL);
+	if (!l3c_hwmod_data)
+		return -ENOMEM;
+
+	l3c_hwmod_data->djtag_node = djtag_node;
+	punit = &pl3c_pmu->hwmod_pmu_unit[sccl_id - 1];
+
+	ret = hisi_pmu_unit_init(pdev, punit, sccl_id,
+					HISI_MAX_CFG_L3C_CNTR);
+	if (ret) {
+		kfree(l3c_hwmod_data);
+		return ret;
+	}
+
+	ret = init_hisi_l3c_banks(l3c_hwmod_data, pdev);
+	if (ret) {
+		kfree(l3c_hwmod_data);
+		return ret;
+	}
+
+	punit->hwmod_data = l3c_hwmod_data;
+
+	*punit_id = sccl_id - 1;
+	return 0;
+}
+
+static void hisi_free_l3c_data(struct hisi_hwmod_unit *punit)
+{
+	kfree(punit->hwmod_data);
+}
+
+void hisi_l3c_pmu_init(struct platform_device *pdev,
+					struct hisi_pmu *pl3c_pmu)
+{
+	pl3c_pmu->pmu_type = SCCL_SPECIFIC;
+	pl3c_pmu->name = "hip05_l3c";
+	pl3c_pmu->num_counters = HISI_MAX_CFG_L3C_CNTR;
+	pl3c_pmu->num_events = HISI_L3C_MAX_EVENTS;
+	pl3c_pmu->hwmod_type = HISI_L3C;
+}
+
+static int hisi_pmu_l3c_dev_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct hisi_pmu *pl3c_pmu = hisi_uncore_l3c;
+	struct hisi_hwmod_unit *punit;
+	int unit_id;
+
+	/* Allocate and Register PMU for the first time */
+	if (!hisi_uncore_l3c) {
+		pl3c_pmu = hisi_pmu_alloc(pdev);
+		if (IS_ERR(pl3c_pmu))
+			return PTR_ERR(pl3c_pmu);
+		hisi_l3c_pmu_init(pdev, pl3c_pmu);
+	}
+
+	ret = init_hisi_l3c_data(pdev, pl3c_pmu, &unit_id);
+	if (ret)
+		goto fail_init;
+
+	pl3c_pmu->num_units++;
+
+	pl3c_pmu->plat_device = pdev;
+	hisi_l3c_pmu_init(pdev, pl3c_pmu);
+
+	if (!hisi_uncore_l3c) {
+		/* First active L3C in the chip registers the pmu */
+		pl3c_pmu->pmu = (struct pmu) {
+				.name		= "hip05_l3c",
+				.task_ctx_nr	= perf_invalid_context,
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
+		ret = hisi_uncore_pmu_setup(pl3c_pmu, pdev, "hip05_l3c");
+		if (ret) {
+			pr_err("hisi_uncore_pmu_init FAILED!!\n");
+			goto fail;
+		}
+
+		hisi_uncore_l3c = pl3c_pmu;
+	}
+
+	return 0;
+
+fail:
+	punit = &pl3c_pmu->hwmod_pmu_unit[unit_id];
+	hisi_free_l3c_data(punit);
+
+fail_init:
+	if (!hisi_uncore_l3c)
+		devm_kfree(&pdev->dev, pl3c_pmu);
+
+	return ret;
+}
+
+static int hisi_pmu_l3c_dev_remove(struct platform_device *pdev)
+{
+	if (hisi_uncore_l3c)
+		devm_kfree(&pdev->dev, hisi_uncore_l3c);
+
+	return 0;
+}
+
+static const struct of_device_id l3c_of_match[] = {
+	{ .compatible = "hisilicon,hip05-l3c", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, l3c_of_match);
+
+static struct platform_driver hisi_pmu_l3c_driver = {
+	.driver = {
+		.name = "hip05-l3c-pmu",
+		.of_match_table = l3c_of_match,
+	},
+	.probe = hisi_pmu_l3c_dev_probe,
+	.remove = hisi_pmu_l3c_dev_remove,
+};
+module_platform_driver(hisi_pmu_l3c_driver);
+
+MODULE_DESCRIPTION("HiSilicon HIP05 L3C PMU driver");
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Anurup M");
diff --git a/drivers/perf/hisilicon/hisi_uncore_l3c.h b/drivers/perf/hisilicon/hisi_uncore_l3c.h
new file mode 100644
index 0000000..389e228
--- /dev/null
+++ b/drivers/perf/hisilicon/hisi_uncore_l3c.h
@@ -0,0 +1,100 @@
+/*
+ * HiSilicon SoC L3C Hardware event counters support
+ *
+ * Copyright (C) 2016 Huawei Technologies Limited
+ * Author: Anurup M <anurup.m@huawei.com>
+ *
+ * This code is based on the uncore PMU's like arm-cci and
+ * arm-ccn.
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
+#ifndef __HISI_UNCORE_L3C_H__
+#define __HISI_UNCORE_L3C_H__
+
+#include "hisi_uncore_pmu.h"
+
+/*
+ * ARMv8 HiSilicon L3C RAW event types.
+ */
+enum armv8_hisi_l3c_event_types {
+	HISI_HWEVENT_L3C_READ_ALLOCATE		= 0x300,
+	HISI_HWEVENT_L3C_WRITE_ALLOCATE		= 0x301,
+	HISI_HWEVENT_L3C_READ_NOALLOCATE	= 0x302,
+	HISI_HWEVENT_L3C_WRITE_NOALLOCATE	= 0x303,
+	HISI_HWEVENT_L3C_READ_HIT		= 0x304,
+	HISI_HWEVENT_L3C_WRITE_HIT		= 0x305,
+	HISI_HWEVENT_L3C_EVENT_MAX		= 0x315,
+};
+
+/*
+ * ARMv8 HiSilicon Hardware counter Index.
+ */
+enum armv8_hisi_l3c_counters {
+	HISI_IDX_L3C_COUNTER0		= 0x0,
+	HISI_IDX_L3C_COUNTER_MAX	= 0x7,
+};
+
+#define HISI_L3C_MODULE_ID	0x04
+
+#define HISI_L3C_BANK0_CFGEN  0x02
+#define HISI_L3C_BANK1_CFGEN  0x04
+#define HISI_L3C_BANK2_CFGEN  0x01
+#define HISI_L3C_BANK3_CFGEN  0x08
+
+#define HISI_L3C_AUCTRL_REG_OFF 0x04
+#define HISI_L3C_AUCTRL_EVENT_BUS_EN 0x1000000
+
+#define HISI_L3C_EVENT_TYPE0_REG_OFF 0x140
+#define HISI_L3C_EVENT_TYPE1_REG_OFF 0x144
+
+#define HISI_MAX_CFG_L3C_CNTR	0x08
+
+#define HISI_L3C_COUNTER0_REG_OFF 0x170
+
+#define HISI_L3C_MAX_EVENTS 22
+
+#define NUM_L3C_BANKS 4
+
+struct hisi_hwc_prev_counter {
+	local64_t prev_count;
+};
+
+struct hisi_l3c_hwc_data_info {
+	u32 num_banks;
+	struct hisi_hwc_prev_counter *hwc_prev_counters;
+};
+
+struct l3c_bank_info {
+	u32 cfg_en;
+};
+
+struct hisi_l3c_data {
+	struct device_node *djtag_node;
+	DECLARE_BITMAP(hisi_l3c_event_used_mask,
+				HISI_MAX_CFG_L3C_CNTR);
+	u32 num_banks;
+	struct l3c_bank_info bank[MAX_BANKS];
+};
+
+int hisi_l3c_get_event_idx(struct hisi_hwmod_unit *);
+void hisi_clear_l3c_event_idx(struct hisi_hwmod_unit *,	int);
+void hisi_set_l3c_evtype(struct hisi_l3c_data *, int, u32);
+u32 hisi_read_l3c_counter(int, struct device_node *, int);
+u32 hisi_write_l3c_counter(struct hisi_l3c_data *, int, u32);
+u64 hisi_l3c_event_update(struct perf_event *,
+				struct hw_perf_event *, int);
+void hisi_disable_l3c_counter(struct hisi_l3c_data *, int);
+int hisi_enable_l3c_counter(struct hisi_l3c_data *, int);
+
+#endif /* __HISI_UNCORE_L3C_H__ */
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
new file mode 100644
index 0000000..d0dffc3
--- /dev/null
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
@@ -0,0 +1,476 @@
+/*
+ * HiSilicon SoC Hardware event counters support
+ *
+ * Copyright (C) 2016 Huawei Technologies Limited
+ * Author: Anurup M <anurup.m@huawei.com>
+ *
+ * This code is based on the uncore PMU's like arm-cci and
+ * arm-ccn.
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
+#include "hisi_uncore_l3c.h"
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
+	ret = hisi_djtag_readl(djtag_node, offset, module_id,
+							chain_id, pvalue);
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
+	ret = hisi_djtag_writel(djtag_node, offset, module_id,
+						HISI_DJTAG_MOD_MASK, value);
+	if (ret)
+		pr_warn("Djtag:%s Write failed!\n", djtag_node->full_name);
+
+	return ret;
+}
+
+void hisi_uncore_pmu_write_evtype(struct hisi_hwmod_unit *punit,
+						int idx, u32 val)
+{
+	/* Select event based on Hardware counter Module */
+	if (idx >= HISI_IDX_L3C_COUNTER0 &&
+		idx <= HISI_IDX_L3C_COUNTER_MAX)
+		hisi_set_l3c_evtype(punit->hwmod_data, idx, val);
+}
+
+int hisi_pmu_get_event_idx(struct hw_perf_event *hwc,
+						struct hisi_hwmod_unit *punit)
+{
+	int event_idx = -1;
+	u32 raw_event_code = hwc->config_base;
+	unsigned long evtype = raw_event_code & HISI_EVTYPE_EVENT;
+
+	/* Get the available hardware event counter index */
+	/* If event type is L3C events */
+	if (evtype >= HISI_HWEVENT_L3C_READ_ALLOCATE &&
+			evtype <= HISI_HWEVENT_L3C_EVENT_MAX) {
+		event_idx = hisi_l3c_get_event_idx(punit);
+	}
+
+	return event_idx;
+}
+
+void hisi_pmu_clear_event_idx(struct hw_perf_event *hwc,
+					struct hisi_hwmod_unit *punit,
+								int idx)
+{
+	/* Release the hardware event counter index */
+	u32 raw_event_code = hwc->config_base;
+	unsigned long evtype = raw_event_code & HISI_EVTYPE_EVENT;
+
+	if (evtype >= HISI_HWEVENT_L3C_READ_ALLOCATE &&
+			evtype <= HISI_HWEVENT_L3C_EVENT_MAX) {
+		hisi_clear_l3c_event_idx(punit, idx);
+	}
+}
+
+static int pmu_map_event(struct perf_event *event)
+{
+	return (int)(event->attr.config & HISI_EVTYPE_EVENT);
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
+	/* For HiSilicon SoC L3C update config_base based on event encoding */
+	if (mapping >= HISI_HWEVENT_L3C_READ_ALLOCATE &&
+				mapping <= HISI_HWEVENT_L3C_EVENT_MAX) {
+		hwc->config_base = event->attr.config;
+	} else {
+		return -EINVAL;
+	}
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
+	return 0;
+}
+
+int hisi_uncore_pmu_event_init(struct perf_event *event)
+{
+	struct hisi_pmu *phisi_pmu = to_hisi_pmu(event->pmu);
+	struct hisi_hwmod_unit *punit;
+	u32 raw_event_code = event->attr.config;
+	int err;
+
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	/* we do not support sampling as the counters are all
+	 * shared by all CPU cores in a CPU die(SCCL). Also we
+	 * donot support attach to a task(per-process mode)
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
+//	if (event->cpu < 0)
+//		return -EINVAL;
+
+	/* FIXME: event->cpu = cpumask_first(&pmu_dev->parent->cpu);
+	 */
+
+	punit = &phisi_pmu->hwmod_pmu_unit[GET_UNIT_IDX(raw_event_code)];
+
+	err = __hw_perf_event_init(event);
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
+	int cntr_idx = idx & ~(HISI_CNTR_SCCL_MASK);
+
+	/*
+	 * Identify Event type and read appropriate hardware
+	 * counter and sum the values
+	 */
+	if (cntr_idx >= HISI_IDX_L3C_COUNTER0 &&
+		cntr_idx <= HISI_IDX_L3C_COUNTER_MAX)
+		new_raw_count = hisi_l3c_event_update(event, hwc, idx);
+
+	return new_raw_count;
+}
+
+void hisi_uncore_pmu_enable(struct pmu *pmu)
+{
+	/* Enable all the PMU counters. */
+}
+
+void hisi_uncore_pmu_disable(struct pmu *pmu)
+{
+	/* Disable all the PMU counters. */
+}
+
+int hisi_pmu_enable_counter(struct hisi_hwmod_unit *punit,
+							int idx)
+{
+	int ret = 0;
+
+	/* Enable the hardware event counting */
+	if (idx >= HISI_IDX_L3C_COUNTER0 &&
+		idx <= HISI_IDX_L3C_COUNTER_MAX)
+		ret = hisi_enable_l3c_counter(punit->hwmod_data, idx);
+
+	return ret;
+}
+
+void hisi_pmu_disable_counter(struct hisi_hwmod_unit *punit,
+							int idx)
+{
+	/* Disable the hardware event counting */
+	int cntr_idx = idx & ~(HISI_CNTR_SCCL_MASK);
+
+	if (cntr_idx >= HISI_IDX_L3C_COUNTER0 &&
+		 cntr_idx <= HISI_IDX_L3C_COUNTER_MAX)
+		hisi_disable_l3c_counter(punit->hwmod_data, idx);
+}
+
+/*
+ * Enable counter and set the counter to count
+ * the event that we're interested in.
+ */
+void hisi_uncore_pmu_enable_event(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct hisi_pmu *phisi_pmu = to_hisi_pmu(event->pmu);
+	struct hisi_hwmod_unit *punit;
+
+	punit = &phisi_pmu->hwmod_pmu_unit[GET_UNIT_IDX(hwc->config_base)];
+
+	/*
+	 * Disable counter
+	 */
+	hisi_pmu_disable_counter(punit, GET_CNTR_IDX(hwc));
+
+	/*
+	 * Set event (if destined for Hisilicon SoC counters).
+	 */
+	hisi_uncore_pmu_write_evtype(punit, GET_CNTR_IDX(hwc),
+						hwc->config_base);
+
+	/*
+	 * Enable counter
+	 */
+	hisi_pmu_enable_counter(punit, GET_CNTR_IDX(hwc));
+
+}
+
+int hisi_pmu_write_counter(struct hisi_hwmod_unit *punit,
+						int idx,
+						u32 value)
+{
+	int ret = 0;
+
+	/* Write to the hardware event counter */
+	if (idx >= HISI_IDX_L3C_COUNTER0 &&
+		idx <= HISI_IDX_L3C_COUNTER_MAX)
+		ret = hisi_write_l3c_counter(punit->hwmod_data, idx, value);
+
+	return ret;
+}
+
+void hisi_pmu_event_set_period(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct hisi_pmu *phisi_pmu = to_hisi_pmu(event->pmu);
+	struct hisi_hwmod_unit *punit;
+
+	/*
+	 * The Hisilicon PMU counters have a period of 2^32. To account for the
+	 * possiblity of extreme interrupt latency we program for a period of
+	 * half that. Hopefully we can handle the interrupt before another 2^31
+	 * events occur and the counter overtakes its previous value.
+	 */
+	u64 val = 1ULL << 31;
+
+	punit = &phisi_pmu->hwmod_pmu_unit[GET_UNIT_IDX(hwc->config_base)];
+	local64_set(&hwc->prev_count, val);
+	hisi_pmu_write_counter(punit, GET_CNTR_IDX(hwc), val);
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
+	struct hisi_hwmod_unit *punit;
+
+	if (hwc->state & PERF_HES_STOPPED)
+		return;
+
+	punit = &phisi_pmu->hwmod_pmu_unit[GET_UNIT_IDX(hwc->config_base)];
+
+	/*
+	 * We always reprogram the counter, so ignore PERF_EF_UPDATE. See
+	 * hisi_uncore_pmu_start()
+	 */
+	hisi_pmu_disable_counter(punit, GET_CNTR_IDX(hwc));
+	hisi_uncore_pmu_event_update(event, hwc, GET_CNTR_IDX(hwc));
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
+
+	punit = &phisipmu->hwmod_pmu_unit[GET_UNIT_IDX(hwc->config_base)];
+	hw_events = &punit->hw_events;
+
+	hisi_uncore_pmu_stop(event, PERF_EF_UPDATE);
+	hw_events->events[GET_CNTR_IDX(hwc)] = NULL;
+
+	hisi_pmu_clear_event_idx(hwc, punit, GET_CNTR_IDX(hwc));
+
+	perf_event_update_userpage(event);
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
+
+	punit->unit_id = unit_id;
+
+	return 0;
+}
+
+void hisi_uncore_pmu_read(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	hisi_uncore_pmu_event_update(event, hwc, GET_CNTR_IDX(hwc));
+}
+
+int hisi_uncore_pmu_setup(struct hisi_pmu *hisipmu,
+				struct platform_device *pdev,
+						char *pmu_name)
+{
+	int ret;
+
+	/* Register the events with perf */
+	ret = perf_pmu_register(&hisipmu->pmu, pmu_name, -1);
+	if (ret)
+		return ret;
+
+	return 0;
+}
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.h b/drivers/perf/hisilicon/hisi_uncore_pmu.h
new file mode 100644
index 0000000..75ef282
--- /dev/null
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.h
@@ -0,0 +1,128 @@
+/*
+ * HiSilicon SoC Hardware event counters support
+ *
+ * Copyright (C) 2016 Huawei Technologies Limited
+ * Author: Anurup M <anurup.m@huawei.com>
+ *
+ * This code is based on the uncore PMU's like arm-cci and
+ * arm-ccn.
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
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/soc/hisilicon/djtag.h>
+#include <linux/types.h>
+#include <asm/local64.h>
+
+#undef pr_fmt
+#define pr_fmt(fmt)     "hisi_pmu: " fmt
+
+#define HISI_DJTAG_MOD_MASK (0xFFFF)
+
+#define HISI_CNTR_SCCL_MASK    (0xF00)
+
+#define HISI_SCCL_MAX	(1 << 4)
+#define HISI_SCCL_MASK	(0xF00000)
+#define HISI_SCCL_SHIFT 20
+
+#define HISI_EVTYPE_EVENT	0xfff
+#define HISI_MAX_PERIOD ((1LLU << 32) - 1)
+
+#define MAX_BANKS 8
+#define MAX_COUNTERS 30
+#define MAX_UNITS 8
+
+#define GET_CNTR_IDX(hwc) (hwc->idx)
+#define to_hisi_pmu(c)	(container_of(c, struct hisi_pmu, pmu))
+
+#define GET_UNIT_IDX(event_code)		\
+	(((event_code & HISI_SCCL_MASK) >>	\
+			   HISI_SCCL_SHIFT) - 1)
+
+enum hisi_hwmod_type {
+	HISI_L3C = 0x0,
+};
+
+/* Event granularity */
+enum hisi_pmu_type {
+	CORE_SPECIFIC,
+	CCL_SPECIFIC, /* For future use */
+	SCCL_SPECIFIC,
+	CHIP_SPECIFIC, /* For future use */
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
+	struct hisi_hwmod_unit hwmod_pmu_unit[MAX_UNITS];
+	struct pmu pmu; /* for custom pmu ops */
+	struct platform_device *plat_device;
+};
+
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
