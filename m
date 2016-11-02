From: anurupvasu@gmail.com (Anurup M)
Date: Wed,  2 Nov 2016 11:42:50 -0400
Subject: [PATCH v1 07/11] perf: hisi: Add support for Hisilicon SoC event
 counters
In-Reply-To: <1478101374-18778-1-git-send-email-anurup.m@huawei.com>
References: <1478101374-18778-1-git-send-email-anurup.m@huawei.com>
Message-ID: <1478101374-18778-8-git-send-email-anurup.m@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	1. Hip05/06/07 uncore PMU to support different hardware
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
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/perf/Makefile                    |   1 +
 drivers/perf/hisilicon/Makefile          |   1 +
 drivers/perf/hisilicon/hisi_uncore_l3c.c | 571 +++++++++++++++++++++++++++++++
 drivers/perf/hisilicon/hisi_uncore_l3c.h |  67 ++++
 drivers/perf/hisilicon/hisi_uncore_pmu.c | 331 ++++++++++++++++++
 drivers/perf/hisilicon/hisi_uncore_pmu.h | 108 ++++++
 6 files changed, 1079 insertions(+)
 create mode 100644 drivers/perf/hisilicon/Makefile
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_l3c.c
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_l3c.h
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_pmu.c
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_pmu.h

diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index b116e98..061f229 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_ARM_PMU) += arm_pmu.o
 obj-$(CONFIG_XGENE_PMU) += xgene_pmu.o
+obj-$(CONFIG_HISI_PMU) += hisilicon/
diff --git a/drivers/perf/hisilicon/Makefile b/drivers/perf/hisilicon/Makefile
new file mode 100644
index 0000000..e1766cf
--- /dev/null
+++ b/drivers/perf/hisilicon/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_HISI_PMU) += hisi_uncore_pmu.o hisi_uncore_l3c.o
diff --git a/drivers/perf/hisilicon/hisi_uncore_l3c.c b/drivers/perf/hisilicon/hisi_uncore_l3c.c
new file mode 100644
index 0000000..f78f7b2
--- /dev/null
+++ b/drivers/perf/hisilicon/hisi_uncore_l3c.c
@@ -0,0 +1,571 @@
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
+static inline int hisi_l3c_counter_valid(int idx)
+{
+	return (idx >= HISI_IDX_L3C_COUNTER0 &&
+			idx <= HISI_IDX_L3C_COUNTER_MAX);
+}
+
+static u32 hisi_read_l3c_counter(struct hisi_l3c_data *l3c_hwmod_data,
+						int cntr_idx, int bank_idx)
+{
+	struct hisi_djtag_client *client = l3c_hwmod_data->client;
+	u32 module_id = l3c_hwmod_data->l3c_hwcfg.module_id[bank_idx];
+	u32 cfg_en = l3c_hwmod_data->l3c_hwcfg.bank_cfgen[bank_idx];
+	u32 reg_offset, value;
+
+	reg_offset = l3c_hwmod_data->l3c_hwcfg.counter_reg0_off +
+							(cntr_idx * 4);
+
+	hisi_djtag_readreg(module_id, cfg_en, reg_offset, client, &value);
+
+	return value;
+}
+
+static u64 hisi_l3c_event_update(struct perf_event *event,
+				struct hw_perf_event *hwc, int idx)
+{
+	struct hisi_pmu *pl3c_pmu = to_hisi_pmu(event->pmu);
+	struct hisi_l3c_data *l3c_hwmod_data = pl3c_pmu->hwmod_data;
+	u64 delta, prev_raw_count, total_raw_count = 0, avg_raw_count = 0;
+	u32 num_banks = l3c_hwmod_data->l3c_hwcfg.num_banks;
+	int i;
+
+	if (!hisi_l3c_counter_valid(idx)) {
+		dev_err(pl3c_pmu->dev, "Unsupported event index:%d!\n", idx);
+		return 0;
+	}
+
+	/* Check if the L3C data is initialized for this SCCL */
+	if (!l3c_hwmod_data->client) {
+		dev_err(pl3c_pmu->dev, "SCL=%d not initialized!\n",
+							pl3c_pmu->scl_id);
+		return 0;
+	}
+
+	do {
+		/* Get count from individual L3C banks and sum them up */
+		for (i = 0; i < num_banks; i++) {
+			total_raw_count += hisi_read_l3c_counter(l3c_hwmod_data,
+									idx, i);
+		}
+		prev_raw_count = local64_read(&hwc->prev_count);
+
+		/*
+		 * As prev_raw_count is updated with average value of
+		 * L3 cache banks, we multiply it by no of banks and
+		 * compute the delta
+		 */
+		delta = (total_raw_count - (prev_raw_count * num_banks)) &
+								HISI_MAX_PERIOD;
+
+		local64_add(delta, &event->count);
+
+		/*
+		 * Divide by num of banks to get average count and
+		 * update prev_count with this value
+		 */
+		avg_raw_count = total_raw_count / num_banks;
+	} while (local64_cmpxchg(
+			 &hwc->prev_count, prev_raw_count, avg_raw_count) !=
+							 prev_raw_count);
+
+	return total_raw_count;
+}
+
+static void hisi_set_l3c_evtype(struct hisi_pmu *pl3c_pmu, int idx, u32 val)
+{
+	struct hisi_djtag_client *client;
+	struct hisi_l3c_data *l3c_hwmod_data = pl3c_pmu->hwmod_data;
+	u32 reg_offset = l3c_hwmod_data->l3c_hwcfg.evtype_reg0_off;
+	u32 event_value, value = 0;
+	u32 cfg_en, module_id;
+	int i;
+
+	event_value = (val -
+			HISI_HWEVENT_L3C_READ_ALLOCATE);
+
+	/* Select the appropriate Event select register */
+	if (idx > 3)
+		reg_offset += 4;
+
+	/* Value to write to event type register */
+	val = event_value << (8 * idx);
+
+	/* Find the djtag Identifier of the Unit */
+	client = l3c_hwmod_data->client;
+
+	/*
+	 * Set the event in L3C_EVENT_TYPEx Register
+	 * for all L3C banks
+	 */
+	for (i = 0; i < l3c_hwmod_data->l3c_hwcfg.num_banks; i++) {
+		module_id = l3c_hwmod_data->l3c_hwcfg.module_id[i];
+		cfg_en = l3c_hwmod_data->l3c_hwcfg.bank_cfgen[i];
+		hisi_djtag_readreg(module_id,
+				cfg_en,
+				reg_offset,
+				client, &value);
+
+		value &= ~(0xff << (8 * idx));
+		value |= val;
+
+		hisi_djtag_writereg(module_id,
+				cfg_en,
+				reg_offset,
+				value,
+				client);
+	}
+}
+
+static u32 hisi_write_l3c_counter(struct hisi_pmu *pl3c_pmu,
+				struct hw_perf_event *hwc, u32 value)
+{
+	struct hisi_djtag_client *client;
+	struct hisi_l3c_data *l3c_hwmod_data = pl3c_pmu->hwmod_data;
+	u32 reg_offset, cfg_en, module_id;
+	int i, ret = 0;
+	int idx = GET_CNTR_IDX(hwc);
+
+	if (!hisi_l3c_counter_valid(idx)) {
+		dev_err(pl3c_pmu->dev,
+				"Unsupported event index:%d!\n", idx);
+		return -EINVAL;
+	}
+
+	reg_offset = l3c_hwmod_data->l3c_hwcfg.counter_reg0_off +
+							(idx * 4);
+
+	client = l3c_hwmod_data->client;
+
+	for (i = 0; i < l3c_hwmod_data->l3c_hwcfg.num_banks; i++) {
+		module_id = l3c_hwmod_data->l3c_hwcfg.module_id[i];
+		cfg_en = l3c_hwmod_data->l3c_hwcfg.bank_cfgen[i];
+		ret = hisi_djtag_writereg(module_id,
+					cfg_en,
+					reg_offset,
+					value,
+					client);
+		if (!ret)
+			ret = value;
+	}
+
+	return ret;
+}
+
+static void hisi_enable_l3c_counter(struct hisi_pmu *pl3c_pmu, int idx)
+{
+	struct hisi_djtag_client *client;
+	struct hisi_l3c_data *l3c_hwmod_data = pl3c_pmu->hwmod_data;
+	u32 reg_offset = l3c_hwmod_data->l3c_hwcfg.event_ctrl_reg_off;
+	u32 eventen = l3c_hwmod_data->l3c_hwcfg.event_enable;
+	u32 value, cfg_en, module_id;
+	int i;
+
+	if (!hisi_l3c_counter_valid(idx)) {
+		dev_err(pl3c_pmu->dev,
+				"Unsupported event index:%d!\n", idx);
+		return;
+	}
+
+	client = l3c_hwmod_data->client;
+
+	/*
+	 * Set the event_bus_en bit in L3C AUCNTRL to enable counting
+	 * for all L3C banks
+	 */
+	for (i = 0; i < l3c_hwmod_data->l3c_hwcfg.num_banks; i++) {
+		module_id = l3c_hwmod_data->l3c_hwcfg.module_id[i];
+		cfg_en = l3c_hwmod_data->l3c_hwcfg.bank_cfgen[i];
+		hisi_djtag_readreg(module_id,
+				cfg_en,
+				reg_offset,
+				client, &value);
+
+		value |= eventen;
+		hisi_djtag_writereg(module_id,
+				cfg_en,
+				reg_offset,
+				value,
+				client);
+	}
+}
+
+static void hisi_disable_l3c_counter(struct hisi_pmu *pl3c_pmu, int idx)
+{
+	struct hisi_djtag_client *client;
+	struct hisi_l3c_data *l3c_hwmod_data = pl3c_pmu->hwmod_data;
+	u32 reg_offset = l3c_hwmod_data->l3c_hwcfg.event_ctrl_reg_off;
+	u32 eventen = l3c_hwmod_data->l3c_hwcfg.event_enable;
+	u32 value, cfg_en, module_id;
+	int i;
+
+	if (!hisi_l3c_counter_valid(idx)) {
+		dev_err(pl3c_pmu->dev,
+				"Unsupported event index:%d!\n", idx);
+		return;
+	}
+
+	/* Find the djtag Identifier of the Unit */
+	client = l3c_hwmod_data->client;
+
+	/*
+	 * Clear the event_bus_en bit in L3C AUCNTRL if no other
+	 * event counting for all L3C banks
+	 */
+	for (i = 0; i < l3c_hwmod_data->l3c_hwcfg.num_banks; i++) {
+		module_id = l3c_hwmod_data->l3c_hwcfg.module_id[i];
+		cfg_en = l3c_hwmod_data->l3c_hwcfg.bank_cfgen[i];
+		hisi_djtag_readreg(module_id,
+				cfg_en,
+				reg_offset,
+				client, &value);
+
+		value &= ~(eventen);
+		hisi_djtag_writereg(module_id,
+				cfg_en,
+				reg_offset,
+				value,
+				client);
+	}
+}
+
+static void hisi_clear_l3c_event_idx(struct hisi_pmu *pl3c_pmu,
+							int idx)
+{
+	struct hisi_djtag_client *client;
+	struct hisi_l3c_data *l3c_hwmod_data = pl3c_pmu->hwmod_data;
+	u32 reg_offset = l3c_hwmod_data->l3c_hwcfg.evtype_reg0_off;
+	void *bitmap_addr;
+	u32 cfg_en, value, module_id;
+	int i;
+
+	if (!hisi_l3c_counter_valid(idx)) {
+		dev_err(pl3c_pmu->dev,
+				"Unsupported event index:%d!\n", idx);
+		return;
+	}
+
+	bitmap_addr = l3c_hwmod_data->hisi_l3c_event_used_mask;
+
+	__clear_bit(idx, bitmap_addr);
+
+	/* Clear Counting in L3C event config register */
+	if (idx > 3)
+		reg_offset += 4;
+
+	client = l3c_hwmod_data->client;
+
+	/*
+	 * Clear the event in L3C_EVENT_TYPEx Register
+	 * for all L3C banks
+	 */
+	for (i = 0; i < l3c_hwmod_data->l3c_hwcfg.num_banks; i++) {
+		module_id = l3c_hwmod_data->l3c_hwcfg.module_id[i];
+		cfg_en = l3c_hwmod_data->l3c_hwcfg.bank_cfgen[i];
+		hisi_djtag_readreg(module_id,
+				cfg_en,
+				reg_offset,
+				client, &value);
+
+		value &= ~(0xff << (8 * idx));
+		value |= (0xff << (8 * idx));
+		hisi_djtag_writereg(module_id,
+				cfg_en,
+				reg_offset,
+				value,
+				client);
+	}
+}
+
+static int hisi_l3c_get_event_idx(struct hisi_pmu *pl3c_pmu)
+{
+	struct hisi_l3c_data *l3c_hwmod_data = pl3c_pmu->hwmod_data;
+	int event_idx;
+
+	event_idx =
+		find_first_zero_bit(
+			l3c_hwmod_data->hisi_l3c_event_used_mask,
+					 pl3c_pmu->num_counters);
+
+	if (event_idx == HISI_MAX_CFG_L3C_CNTR)
+		return -EAGAIN;
+
+	__set_bit(event_idx,
+		l3c_hwmod_data->hisi_l3c_event_used_mask);
+
+	return event_idx;
+}
+
+static void hisi_free_l3c_data(struct hisi_pmu *pl3c_pmu)
+{
+	kfree(pl3c_pmu->hwmod_data);
+	pl3c_pmu->hwmod_data = NULL;
+}
+
+static int init_hisi_l3c_hwcfg(struct device *dev,
+				struct hisi_l3c_data *pl3c_data)
+{
+	struct hisi_l3c_hwcfg *pl3c_hwcfg = &pl3c_data->l3c_hwcfg;
+	struct device_node *node = dev->of_node;
+	u32 prop_len;
+	int ret;
+
+	if (of_property_read_u32(node, "counter-reg",
+				     &pl3c_hwcfg->counter_reg0_off)) {
+		dev_err(dev, "DT:Couldnot read counter-reg!\n");
+		return -EINVAL;
+	}
+
+	if (of_property_read_u32(node, "evctrl-reg",
+				     &pl3c_hwcfg->event_ctrl_reg_off)) {
+		dev_err(dev, "DT:Couldnot read evctrl-reg!\n");
+		return -EINVAL;
+	}
+
+	if (of_property_read_u32(node, "event-en",
+				     &pl3c_hwcfg->event_enable)) {
+		dev_err(dev, "DT:Couldnot read event-en!\n");
+		return -EINVAL;
+	}
+
+	if (of_property_read_u32(node, "evtype-reg",
+				     &pl3c_hwcfg->evtype_reg0_off)) {
+		dev_err(dev, "DT:Couldnot read evtype-reg!\n");
+		return -EINVAL;
+	}
+
+	if (of_property_read_u32(node, "num-banks",
+				     &pl3c_hwcfg->num_banks)) {
+		dev_err(dev, "DT:Couldnot read num-banks!\n");
+		return -EINVAL;
+	}
+
+	prop_len = of_property_count_u32_elems(node, "module-id");
+	if (prop_len != pl3c_hwcfg->num_banks) {
+		dev_err(dev, "DT:module-id entry not valid!\n");
+		return -EINVAL;
+	}
+
+	ret = of_property_read_u32_array(node, "module-id",
+					  &pl3c_hwcfg->module_id[0],
+						  pl3c_hwcfg->num_banks);
+	if (ret < 0) {
+		dev_err(dev, "DT:Couldnot read module-id!\n");
+		return -EINVAL;
+	}
+
+	prop_len = of_property_count_u32_elems(node, "cfgen-map");
+	if (prop_len != pl3c_hwcfg->num_banks) {
+		dev_err(dev, "DT:cfgen-map entrynot valid!\n");
+		return -EINVAL;
+	}
+
+	ret = of_property_read_u32_array(node, "cfgen-map",
+					&pl3c_hwcfg->bank_cfgen[0],
+						pl3c_hwcfg->num_banks);
+	if (ret < 0) {
+		dev_err(dev, "DT:Couldnot read cfgen-map!\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int init_hisi_l3c_data(struct device *dev,
+					struct hisi_pmu *pl3c_pmu,
+					struct hisi_djtag_client *client)
+{
+	struct hisi_l3c_data *l3c_hwmod_data = NULL;
+	int ret;
+
+	l3c_hwmod_data = kzalloc(sizeof(struct hisi_l3c_data),
+							GFP_KERNEL);
+	if (!l3c_hwmod_data)
+		return -ENOMEM;
+
+	/* Set the djtag Identifier */
+	l3c_hwmod_data->client = client;
+
+	pl3c_pmu->hw_events.events = devm_kcalloc(dev,
+					pl3c_pmu->num_counters,
+					sizeof(*pl3c_pmu->hw_events.events),
+					GFP_KERNEL);
+	if (!pl3c_pmu->hw_events.events) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+
+	raw_spin_lock_init(&pl3c_pmu->hw_events.pmu_lock);
+
+	pl3c_pmu->hwmod_data = l3c_hwmod_data;
+
+	ret = init_hisi_l3c_hwcfg(dev, l3c_hwmod_data);
+	if (ret)
+		goto fail;
+
+	return 0;
+
+fail:
+	hisi_free_l3c_data(pl3c_pmu);
+	return ret;
+}
+
+static struct hisi_uncore_ops hisi_uncore_l3c_ops = {
+	.set_evtype = hisi_set_l3c_evtype,
+	.set_event_period = hisi_pmu_set_event_period,
+	.get_event_idx = hisi_l3c_get_event_idx,
+	.clear_event_idx = hisi_clear_l3c_event_idx,
+	.event_update = hisi_l3c_event_update,
+	.enable_counter = hisi_enable_l3c_counter,
+	.disable_counter = hisi_disable_l3c_counter,
+	.write_counter = hisi_write_l3c_counter,
+};
+
+static int hisi_l3c_pmu_init(struct device *dev,
+					struct hisi_pmu *pl3c_pmu)
+{
+	int ret;
+
+	/* Read common PMU properties */
+	ret = hisi_uncore_common_fwprop_read(dev, pl3c_pmu);
+	if (ret)
+		return ret;
+
+	pl3c_pmu->name = kasprintf(GFP_KERNEL, "hisi_l3c%d",
+						pl3c_pmu->scl_id);
+	pl3c_pmu->ops = &hisi_uncore_l3c_ops;
+	pl3c_pmu->dev = dev;
+
+	/* Pick one core to use for cpumask attributes */
+	cpumask_set_cpu(smp_processor_id(), &pl3c_pmu->cpu);
+
+	return 0;
+}
+
+static int hisi_pmu_l3c_dev_probe(struct hisi_djtag_client *client)
+{
+	struct hisi_pmu *pl3c_pmu = NULL;
+	struct device *dev = &client->dev;
+	int ret;
+
+	pl3c_pmu = hisi_pmu_alloc(dev);
+	if (IS_ERR(pl3c_pmu))
+		return PTR_ERR(pl3c_pmu);
+
+	ret = hisi_l3c_pmu_init(dev, pl3c_pmu);
+	if (ret)
+		return ret;
+
+	ret = init_hisi_l3c_data(dev, pl3c_pmu, client);
+	if (ret)
+		goto fail_init;
+
+	/* Register with perf PMU */
+	pl3c_pmu->pmu = (struct pmu) {
+		.name = pl3c_pmu->name,
+		.task_ctx_nr = perf_invalid_context,
+		.event_init = hisi_uncore_pmu_event_init,
+		.add = hisi_uncore_pmu_add,
+		.del = hisi_uncore_pmu_del,
+		.start = hisi_uncore_pmu_start,
+		.stop = hisi_uncore_pmu_stop,
+		.read = hisi_uncore_pmu_read,
+	};
+
+	ret = hisi_uncore_pmu_setup(pl3c_pmu, pl3c_pmu->name);
+	if (ret) {
+		dev_err(dev, "hisi_uncore_pmu_init FAILED!!\n");
+		goto fail;
+	}
+
+	/* Set the drv data to l3c_pmu */
+	dev_set_drvdata(dev, pl3c_pmu);
+
+	return 0;
+
+fail:
+	hisi_free_l3c_data(pl3c_pmu);
+
+fail_init:
+	dev_err(dev, "%s failed\n", __func__);
+	return ret;
+}
+
+static int hisi_pmu_l3c_dev_remove(struct hisi_djtag_client *client)
+{
+	struct hisi_pmu *pl3c_pmu = NULL;
+	struct device *dev = &client->dev;
+
+	pl3c_pmu = dev_get_drvdata(dev);
+
+	perf_pmu_unregister(&pl3c_pmu->pmu);
+	hisi_free_l3c_data(pl3c_pmu);
+
+	return 0;
+}
+
+static const struct of_device_id l3c_of_match[] = {
+	{ .compatible = "hisilicon,hisi-pmu-l3c-v1", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, l3c_of_match);
+
+static struct hisi_djtag_driver hisi_pmu_l3c_driver = {
+	.driver = {
+		.name = "hisi-pmu-l3c",
+		.of_match_table = l3c_of_match,
+	},
+	.probe = hisi_pmu_l3c_dev_probe,
+	.remove = hisi_pmu_l3c_dev_remove,
+};
+
+static int __init hisi_pmu_l3c_init(void)
+{
+	int rc;
+
+	rc = hisi_djtag_register_driver(THIS_MODULE, &hisi_pmu_l3c_driver);
+	if (rc < 0) {
+		pr_err("hisi pmu l3c init failed, rc=%d\n", rc);
+		return rc;
+	}
+
+	return 0;
+}
+module_init(hisi_pmu_l3c_init);
+
+static void __exit hisi_pmu_l3c_exit(void)
+{
+	hisi_djtag_unregister_driver(&hisi_pmu_l3c_driver);
+
+}
+module_exit(hisi_pmu_l3c_exit);
+
+MODULE_DESCRIPTION("HiSilicon SoC HIP0x L3C PMU driver");
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Anurup M");
diff --git a/drivers/perf/hisilicon/hisi_uncore_l3c.h b/drivers/perf/hisilicon/hisi_uncore_l3c.h
new file mode 100644
index 0000000..a4a1777
--- /dev/null
+++ b/drivers/perf/hisilicon/hisi_uncore_l3c.h
@@ -0,0 +1,67 @@
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
+	HISI_HWEVENT_L3C_READ_ALLOCATE		= 0x0,
+	HISI_HWEVENT_L3C_WRITE_ALLOCATE		= 0x01,
+	HISI_HWEVENT_L3C_READ_NOALLOCATE	= 0x02,
+	HISI_HWEVENT_L3C_WRITE_NOALLOCATE	= 0x03,
+	HISI_HWEVENT_L3C_READ_HIT		= 0x04,
+	HISI_HWEVENT_L3C_WRITE_HIT		= 0x05,
+	HISI_HWEVENT_L3C_EVENT_MAX		= 0x15,
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
+#define HISI_MAX_CFG_L3C_CNTR	0x08
+
+struct hisi_l3c_hwcfg {
+	u32 evtype_reg0_off;
+	u32 counter_reg0_off;
+	u32 event_ctrl_reg_off;
+	u32 event_enable;
+	u32 module_id[MAX_BANKS];
+	u32 num_banks;
+	u32 bank_cfgen[MAX_BANKS];
+};
+
+struct hisi_l3c_data {
+	struct hisi_djtag_client *client;
+	DECLARE_BITMAP(hisi_l3c_event_used_mask,
+				HISI_MAX_CFG_L3C_CNTR);
+	struct hisi_l3c_hwcfg l3c_hwcfg;
+};
+
+#endif /* __HISI_UNCORE_L3C_H__ */
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
new file mode 100644
index 0000000..8d29fcc
--- /dev/null
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
@@ -0,0 +1,331 @@
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
+#include "hisi_uncore_pmu.h"
+
+/* djtag read interface - Call djtag driver to access SoC registers */
+int hisi_djtag_readreg(int module_id, int bank, u32 offset,
+				struct hisi_djtag_client *client, u32 *pvalue)
+{
+	int ret;
+	u32 chain_id = 0;
+
+	while (bank != 1) {
+		bank = (bank >> 0x1);
+		chain_id++;
+	}
+
+	ret = hisi_djtag_readl(client, offset, module_id,
+						chain_id, pvalue);
+	if (ret)
+		dev_err(&client->dev, "read failed, ret=%d!\n", ret);
+
+	return ret;
+}
+
+/* djtag write interface - Call djtag driver  to access SoC registers */
+int hisi_djtag_writereg(int module_id, int bank,
+				u32 offset, u32 value,
+				struct hisi_djtag_client *client)
+{
+	int ret;
+
+	ret = hisi_djtag_writel(client, offset, module_id,
+						HISI_DJTAG_MOD_MASK, value);
+	if (ret)
+		dev_err(&client->dev, "write failed, ret=%d!\n", ret);
+
+	return ret;
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
+	struct hisi_pmu *phisi_pmu = to_hisi_pmu(event->pmu);
+	struct device *dev = phisi_pmu->dev;
+	int mapping;
+
+	mapping = pmu_map_event(event);
+	if (mapping < 0) {
+		dev_err(dev, "event %x:%llx not supported\n", event->attr.type,
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
+	hwc->config		= 0;
+	hwc->event_base		= 0;
+
+	/* For HiSilicon SoC L3C update config_base based on event encoding */
+	hwc->config_base = event->attr.config;
+
+	return 0;
+}
+
+int hisi_uncore_pmu_event_init(struct perf_event *event)
+{
+	int err;
+	struct hisi_pmu *phisi_pmu = to_hisi_pmu(event->pmu);
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
+	if (event->cpu < 0)
+		return -EINVAL;
+
+	event->cpu = cpumask_first(&phisi_pmu->cpu);
+
+	err = __hw_perf_event_init(event);
+
+	return err;
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
+
+	/* Disable the hardware event counting */
+	if (phisi_pmu->ops->disable_counter)
+		phisi_pmu->ops->disable_counter(phisi_pmu, GET_CNTR_IDX(hwc));
+
+	/*
+	 * Set event (if destined for Hisilicon SoC counters).
+	 */
+	if (phisi_pmu->ops->set_evtype)
+		phisi_pmu->ops->set_evtype(phisi_pmu, GET_CNTR_IDX(hwc),
+							hwc->config_base);
+
+	/* Enable the hardware event counting */
+	if (phisi_pmu->ops->enable_counter)
+		phisi_pmu->ops->enable_counter(phisi_pmu, GET_CNTR_IDX(hwc));
+}
+
+void hisi_pmu_set_event_period(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct hisi_pmu *phisi_pmu = to_hisi_pmu(event->pmu);
+
+	/*
+	 * The Hisilicon PMU counters have a period of 2^32. To account for the
+	 * possiblity of extreme interrupt latency we program for a period of
+	 * half that. Hopefully we can handle the interrupt before another 2^31
+	 * events occur and the counter overtakes its previous value.
+	 */
+	u64 val = 1ULL << 31;
+
+	local64_set(&hwc->prev_count, val);
+
+	/* Write to the hardware event counter */
+	phisi_pmu->ops->write_counter(phisi_pmu, hwc, val);
+}
+
+void hisi_uncore_pmu_start(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct hisi_pmu *phisi_pmu = to_hisi_pmu(event->pmu);
+	struct hisi_pmu_hw_events *hw_events;
+
+	hw_events = &phisi_pmu->hw_events;
+
+	if (WARN_ON_ONCE(!(hwc->state & PERF_HES_STOPPED)))
+		return;
+
+	WARN_ON_ONCE(!(hwc->state & PERF_HES_UPTODATE));
+	hwc->state = 0;
+
+	if (phisi_pmu->ops->set_event_period)
+		phisi_pmu->ops->set_event_period(event);
+
+	if (flags & PERF_EF_RELOAD) {
+		u64 prev_raw_count =  local64_read(&hwc->prev_count);
+
+		phisi_pmu->ops->write_counter(phisi_pmu, hwc,
+						(u32)prev_raw_count);
+	}
+
+	hisi_uncore_pmu_enable_event(event);
+	perf_event_update_userpage(event);
+}
+
+void hisi_uncore_pmu_stop(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct hisi_pmu *phisi_pmu = to_hisi_pmu(event->pmu);
+
+	if (hwc->state & PERF_HES_UPTODATE)
+		return;
+
+	/*
+	 * We always reprogram the counter, so ignore PERF_EF_UPDATE.
+	 * See hisi_uncore_pmu_start()
+	 */
+	if (phisi_pmu->ops->disable_counter)
+		phisi_pmu->ops->disable_counter(phisi_pmu,
+						GET_CNTR_IDX(hwc));
+
+	WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
+	hwc->state |= PERF_HES_STOPPED;
+	if (hwc->state & PERF_HES_UPTODATE)
+		return;
+
+	/* Read hardware counter and update the Perf counter statistics */
+	phisi_pmu->ops->event_update(event, hwc, GET_CNTR_IDX(hwc));
+	hwc->state |= PERF_HES_UPTODATE;
+}
+
+int hisi_uncore_pmu_add(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct hisi_pmu *phisi_pmu = to_hisi_pmu(event->pmu);
+	struct hisi_pmu_hw_events *hw_events;
+	int idx;
+
+	hw_events = &phisi_pmu->hw_events;
+
+	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
+
+	/* If we don't have a free counter then return early. */
+	idx = phisi_pmu->ops->get_event_idx(phisi_pmu);
+	if (idx < 0)
+		return -EAGAIN;
+
+	event->hw.idx = idx;
+	hw_events->events[idx] = event;
+
+	if (flags & PERF_EF_START)
+		hisi_uncore_pmu_start(event, PERF_EF_RELOAD);
+
+	/* Propagate our changes to the userspace mapping. */
+	perf_event_update_userpage(event);
+
+	return 0;
+}
+
+void hisi_uncore_pmu_del(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct hisi_pmu *phisi_pmu = to_hisi_pmu(event->pmu);
+	struct hisi_pmu_hw_events *hw_events;
+
+	hw_events = &phisi_pmu->hw_events;
+
+	hisi_uncore_pmu_stop(event, PERF_EF_UPDATE);
+
+	phisi_pmu->ops->clear_event_idx(phisi_pmu, GET_CNTR_IDX(hwc));
+	perf_event_update_userpage(event);
+	hw_events->events[GET_CNTR_IDX(hwc)] = NULL;
+}
+
+struct hisi_pmu *hisi_pmu_alloc(struct device *dev)
+{
+	struct hisi_pmu *phisi_pmu;
+
+	phisi_pmu = devm_kzalloc(dev, sizeof(*phisi_pmu), GFP_KERNEL);
+	if (!phisi_pmu)
+		return ERR_PTR(-ENOMEM);
+
+	return phisi_pmu;
+}
+
+void hisi_uncore_pmu_read(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct hisi_pmu *phisi_pmu = to_hisi_pmu(event->pmu);
+
+	/* Read hardware counter and update the Perf counter statistics */
+	phisi_pmu->ops->event_update(event, hwc, GET_CNTR_IDX(hwc));
+}
+
+int hisi_uncore_common_fwprop_read(struct device *dev,
+					struct hisi_pmu *phisi_pmu)
+{
+	if (device_property_read_u32(dev, "num-events",
+					&phisi_pmu->num_events)) {
+		dev_err(dev, "Cant read num-events from DT!\n");
+		return -EINVAL;
+	}
+
+	if (device_property_read_u32(dev, "num-counters",
+				     &phisi_pmu->num_counters)) {
+		dev_err(dev, "Cant read num-counters from DT!\n");
+		return -EINVAL;
+	}
+
+	/* Find the SCL ID */
+	if (device_property_read_u32(dev, "scl-id",
+					&phisi_pmu->scl_id)) {
+		dev_err(dev, "Cant read scl-id!\n");
+		return -EINVAL;
+	}
+
+	if (phisi_pmu->scl_id == 0 ||
+		phisi_pmu->scl_id >= MAX_UNITS) {
+		dev_err(dev, "Invalid SCL=%d!\n",
+					phisi_pmu->scl_id);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int hisi_uncore_pmu_setup(struct hisi_pmu *phisi_pmu,
+					const char *pmu_name)
+{
+	/* Register the events with perf */
+	return perf_pmu_register(&phisi_pmu->pmu, pmu_name, -1);
+}
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.h b/drivers/perf/hisilicon/hisi_uncore_pmu.h
new file mode 100644
index 0000000..b6b16df
--- /dev/null
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.h
@@ -0,0 +1,108 @@
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
+#define HISI_CNTR_SCCL_MASK    (0xF00)
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
+struct hisi_pmu;
+
+struct hisi_uncore_ops {
+	void (*set_evtype)(struct hisi_pmu *, int, u32);
+	void (*set_event_period)(struct perf_event *);
+	int (*get_event_idx)(struct hisi_pmu *);
+	void (*clear_event_idx)(struct hisi_pmu *, int);
+	u64 (*event_update)(struct perf_event *,
+			     struct hw_perf_event *, int);
+	u32 (*read_counter)(struct hisi_pmu *, int, int);
+	u32 (*write_counter)(struct hisi_pmu *,
+				struct hw_perf_event *, u32);
+	void (*enable_counter)(struct hisi_pmu *, int);
+	void (*disable_counter)(struct hisi_pmu *, int);
+};
+
+struct hisi_pmu_hw_events {
+	struct perf_event **events;
+	raw_spinlock_t pmu_lock;
+};
+
+/* Generic pmu struct for different pmu types */
+struct hisi_pmu {
+	const char *name;
+	struct hisi_pmu_hw_events hw_events;
+	struct hisi_uncore_ops *ops;
+	struct device *dev;
+	void *hwmod_data; /* Hardware module specific data */
+	cpumask_t cpu;
+	struct pmu pmu;
+	u32 scl_id;
+	int num_counters;
+	int num_events;
+	int num_units;
+};
+
+void hisi_uncore_pmu_read(struct perf_event *event);
+void hisi_uncore_pmu_del(struct perf_event *event, int flags);
+int hisi_uncore_pmu_add(struct perf_event *event, int flags);
+void hisi_uncore_pmu_start(struct perf_event *event, int flags);
+void hisi_uncore_pmu_stop(struct perf_event *event, int flags);
+void hisi_pmu_set_event_period(struct perf_event *event);
+void hisi_uncore_pmu_enable_event(struct perf_event *event);
+int hisi_uncore_pmu_setup(struct hisi_pmu *phisi_pmu, const char *pmu_name);
+int hisi_uncore_pmu_event_init(struct perf_event *event);
+int hisi_djtag_readreg(int module_id, int bank, u32 offset,
+				struct hisi_djtag_client *client,
+							u32 *pvalue);
+int hisi_djtag_writereg(int module_id, int bank,
+				u32 offset, u32 value,
+				struct hisi_djtag_client *client);
+struct hisi_pmu *hisi_pmu_alloc(struct device *dev);
+int hisi_uncore_common_fwprop_read(struct device *dev,
+					struct hisi_pmu *phisi_pmu);
+#endif /* __HISI_UNCORE_PMU_H__ */
-- 
2.1.4
