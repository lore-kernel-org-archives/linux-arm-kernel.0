From: zhangshaokun@hisilicon.com (Shaokun Zhang)
Date: Mon, 22 May 2017 20:48:35 +0800
Subject: [PATCH v8 7/9] drivers: perf: hisi: Add support for Hisilicon SoC
 event counters
Message-ID: <1495457315-238544-1-git-send-email-zhangshaokun@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Anurup M <anurup.m@huawei.com>

1. HiP05/06/07 uncore PMU to support different hardware event counters.
2. Hisilicon PMU shall use the DJTAG hardware interface to access
   hardware event counters and configuration register.
3. Routines to enable/disable/add/del/start/stop hardware event counting.
4. Add support to count L3 cache hardware events. Each L3 cache banks will
   be registered as separate PMU with perf.
5. L3C events will be listed at /sys/devices/hisi_l3cX_Y/events/
6. L3C PMU in HiP05/06/07 does not support counter overflow IRQ. So hrtimer
   is used to poll and avoid overflow.
7. The driver supports DT and ACPI mode.

Signed-off-by: Anurup M <anurup.m@huawei.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/perf/hisilicon/Makefile          |   2 +-
 drivers/perf/hisilicon/hisi_uncore_l3c.c | 594 +++++++++++++++++++++++++++++++
 drivers/perf/hisilicon/hisi_uncore_pmu.c | 451 +++++++++++++++++++++++
 drivers/perf/hisilicon/hisi_uncore_pmu.h | 135 +++++++
 4 files changed, 1181 insertions(+), 1 deletion(-)
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_l3c.c
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_pmu.c
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_pmu.h

diff --git a/drivers/perf/hisilicon/Makefile b/drivers/perf/hisilicon/Makefile
index be8f093..0887b56 100644
--- a/drivers/perf/hisilicon/Makefile
+++ b/drivers/perf/hisilicon/Makefile
@@ -1 +1 @@
-obj-$(CONFIG_HISI_PMU) += djtag.o
+obj-$(CONFIG_HISI_PMU) += djtag.o hisi_uncore_pmu.o hisi_uncore_l3c.o
diff --git a/drivers/perf/hisilicon/hisi_uncore_l3c.c b/drivers/perf/hisilicon/hisi_uncore_l3c.c
new file mode 100644
index 0000000..652f535
--- /dev/null
+++ b/drivers/perf/hisilicon/hisi_uncore_l3c.c
@@ -0,0 +1,594 @@
+/*
+ * HiSilicon SoC L3C Hardware event counters support
+ *
+ * Copyright (C) 2017 Hisilicon Limited
+ * Author: Anurup M <anurup.m@huawei.com>
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
+#include <linux/acpi.h>
+#include <linux/bitmap.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/perf_event.h>
+#include "hisi_uncore_pmu.h"
+
+/*
+ * ARMv8 HiSilicon L3C event types.
+ */
+enum hisi_l3c_pmu_event_types {
+	HISI_HWEVENT_L3C_READ_ALLOCATE		= 0x0,
+	HISI_HWEVENT_L3C_WRITE_ALLOCATE		= 0x01,
+	HISI_HWEVENT_L3C_READ_NOALLOCATE	= 0x02,
+	HISI_HWEVENT_L3C_WRITE_NOALLOCATE	= 0x03,
+	HISI_HWEVENT_L3C_READ_HIT		= 0x04,
+	HISI_HWEVENT_L3C_WRITE_HIT		= 0x05,
+	HISI_HWEVENT_L3C_EVENT_MAX		= 0x41,
+};
+
+/*
+ * ARMv8 HiSilicon Hardware counter Index.
+ */
+enum hisi_l3c_pmu_counters {
+	HISI_IDX_L3C_COUNTER0		= 0x0,
+	HISI_IDX_L3C_COUNTER_MAX	= 0x8,
+};
+
+#define L3C_EVTYPE_REG_OFF 0x140
+#define L3C_EVCTRL_REG_OFF 0x04
+#define L3C_CNT0_REG_OFF 0x170
+#define L3C_EVENT_EN 0x1000000
+
+/*
+ * Default timer frequency to poll and avoid counter overflow.
+ * CPU speed = 2.4Ghz, Therefore Access time = 0.4ns
+ * L1 cache - 2 way set associative
+ * L2  - 16 way set associative
+ * L3  - 16 way set associative. L3 cache has 4 banks.
+ *
+ * Overflow time = 2^31 * (access time L1 + access time L2 + access time L3)
+ * = 2^31 * ((2 * 0.4ns) + (16 * 0.4ns) + (4 * 16 * 0.4ns)) = 70 seconds
+ *
+ * L3 cache is also used by devices like PCIe, SAS etc. at
+ * the same time. So the overflow time could be even smaller.
+ * So on a safe side we use a timer interval of 10sec
+ */
+#define L3C_HRTIMER_INTERVAL (10LL * MSEC_PER_SEC)
+
+#define GET_MODULE_ID(hwmod_data) hwmod_data->module_id
+#define GET_BANK_SEL(hwmod_data) hwmod_data->bank_select
+
+#define L3C_EVTYPE_REG(idx)	(L3C_EVTYPE_REG_OFF + (idx <= 3 ? 0 : 4))
+
+struct hisi_l3c_data {
+	struct hisi_djtag_client *client;
+	u32 module_id;
+	u32 bank_select;
+	u32 bank_id;
+};
+
+struct hisi_l3c_pmu_hw_diff {
+	u32 (*get_bank_id)(u32 module_id, u32 bank_select);
+};
+
+/* hip05/06 chips L3C instance or bank identifier */
+static u32 l3c_bankid_map_v1[MAX_BANKS] = {
+	0x02, 0x04, 0x01, 0x08,
+};
+
+/* hip07 chip L3C instance or bank identifier */
+static u32 l3c_bankid_map_v2[MAX_BANKS] = {
+	0x01, 0x02, 0x03, 0x04,
+};
+
+/*
+ * Find the L3C bank index from the module-id and instance-id device
+ * properties and use it in PMU name.
+ */
+static u32 get_l3c_bank_v1(u32 module_id, u32 bank_select)
+{
+	u32 i;
+
+	/*
+	 * For v1 chip (hip05/06) the index of bank_select
+	 * in the bankid_map gives the bank index.
+	 */
+	for (i = 0 ; i < MAX_BANKS; i++)
+		if (l3c_bankid_map_v1[i] == bank_select)
+			break;
+
+	return i;
+}
+
+static u32 get_l3c_bank_v2(u32 module_id, u32 bank_select)
+{
+	u32 i;
+
+	/*
+	 * For v2 chip (hip07) each bank has different Module ID
+	 * So index of module ID in the bankid_map gives the bank index.
+	 */
+	for (i = 0 ; i < MAX_BANKS; i++)
+		if (l3c_bankid_map_v2[i] == module_id)
+			break;
+
+	return i;
+}
+
+static inline int hisi_l3c_pmu_counter_valid(int idx)
+{
+	return (idx >= HISI_IDX_L3C_COUNTER0 && idx < HISI_IDX_L3C_COUNTER_MAX);
+}
+
+/* Select the counter register offset from the index */
+static inline u32 get_counter_reg_off(int cntr_idx)
+{
+	return (L3C_CNT0_REG_OFF + (cntr_idx * 4));
+}
+
+static u64 hisi_l3c_pmu_read_counter(struct hisi_pmu *l3c_pmu, int cntr_idx)
+{
+	struct hisi_l3c_data *l3c_data = l3c_pmu->hwmod_data;
+	struct hisi_djtag_client *client = l3c_data->client;
+	u32 module_id = GET_MODULE_ID(l3c_data);
+	u32 bank_sel = GET_BANK_SEL(l3c_data);
+	u32 reg_off, value;
+
+	reg_off = get_counter_reg_off(cntr_idx);
+	hisi_djtag_readreg(module_id, bank_sel, reg_off, client, &value);
+
+	return value;
+}
+
+static void hisi_l3c_pmu_set_evtype(struct hisi_pmu *l3c_pmu, int idx, u32 val)
+{
+	struct hisi_l3c_data *l3c_data = l3c_pmu->hwmod_data;
+	struct hisi_djtag_client *client = l3c_data->client;
+	u32 module_id = GET_MODULE_ID(l3c_data);
+	u32 bank_sel = GET_BANK_SEL(l3c_data);
+	u32 reg_off, event_value, value = 0;
+
+	event_value = (val - HISI_HWEVENT_L3C_READ_ALLOCATE);
+
+	/*
+	 * Select the appropriate Event select register(L3C_EVENT_TYPEx).
+	 * There are 2 Event Select registers for the 8 hardware counters.
+	 * For the first 4 hardware counters, the L3C_EVTYPE_REG_OFF is chosen.
+	 * For the next 4 hardware counters, the second register is chosen.
+	 */
+	reg_off = L3C_EVTYPE_REG(idx);
+
+	/*
+	 * Write the event code in L3C_EVENT_TYPEx Register
+	 * Each byte in the 32 bit event select register is used to configure
+	 * the event code. Each byte correspond to a counter register to use.
+	 * Use (idx % 4) to select the byte to update in event select register
+	 * with the event code.
+	 */
+	val = event_value << (8 * (idx % 4));
+
+	hisi_djtag_readreg(module_id, bank_sel, reg_off, client, &value);
+	value &= ~(0xff << (8 * (idx % 4)));
+	value |= val;
+	hisi_djtag_writereg(module_id, bank_sel, reg_off, value, client);
+}
+
+static void hisi_l3c_pmu_clear_evtype(struct hisi_pmu *l3c_pmu, int idx)
+{
+	struct hisi_l3c_data *l3c_data = l3c_pmu->hwmod_data;
+	struct hisi_djtag_client *client = l3c_data->client;
+	u32 module_id = GET_MODULE_ID(l3c_data);
+	u32 bank_sel = GET_BANK_SEL(l3c_data);
+	u32 reg_off, value;
+
+	if (!hisi_l3c_pmu_counter_valid(idx)) {
+		dev_err(l3c_pmu->dev, "Unsupported event index:%d!\n", idx);
+		return;
+	}
+
+	/*
+	 * Clear Counting in L3C event config register.
+	 * Select the appropriate Event select register(L3C_EVENT_TYPEx).
+	 * There are 2 Event Select registers for the 8 hardware counters.
+	 * For the first 4 hardware counters, the L3C_EVTYPE_REG_OFF is chosen.
+	 * For the next 4 hardware counters, the second register is chosen.
+	 */
+	reg_off = L3C_EVTYPE_REG(idx);
+
+	/*
+	 * Clear the event in L3C_EVENT_TYPEx Register
+	 * Each byte in the 32 bit event select register is used to configure
+	 * the event code. Each byte correspond to a counter register to use.
+	 * Use (idx % 4) to select the byte to clear in event select register
+	 * with the vale 0xff.
+	 */
+	hisi_djtag_readreg(module_id, bank_sel, reg_off, client, &value);
+	value &= ~(0xff << (8 * (idx % 4)));
+	value |= (0xff << (8 * (idx % 4)));
+	hisi_djtag_writereg(module_id, bank_sel, reg_off, value, client);
+}
+
+static void hisi_l3c_pmu_write_counter(struct hisi_pmu *l3c_pmu,
+				       struct hw_perf_event *hwc, u32 value)
+{
+	struct hisi_l3c_data *l3c_data = l3c_pmu->hwmod_data;
+	struct hisi_djtag_client *client = l3c_data->client;
+	u32 module_id = GET_MODULE_ID(l3c_data);
+	u32 bank_sel = GET_BANK_SEL(l3c_data);
+	u32 reg_off;
+	int idx = GET_CNTR_IDX(hwc);
+
+	reg_off = get_counter_reg_off(idx);
+	hisi_djtag_writereg(module_id, bank_sel, reg_off, value, client);
+}
+
+static void hisi_l3c_pmu_start_counters(struct hisi_pmu *l3c_pmu)
+{
+	struct hisi_l3c_data *l3c_data = l3c_pmu->hwmod_data;
+	struct hisi_djtag_client *client = l3c_data->client;
+	unsigned long *used_mask = l3c_pmu->pmu_events.used_mask;
+	u32 module_id = GET_MODULE_ID(l3c_data);
+	u32 bank_sel = GET_BANK_SEL(l3c_data);
+	u32 num_counters = l3c_pmu->num_counters;
+	u32 value;
+	int enabled = bitmap_weight(used_mask, num_counters);
+
+	if (!enabled)
+		return;
+
+	/*
+	 * Set the event_bus_en bit in L3C AUCNTRL to start counting
+	 * for the L3C bank
+	 */
+	hisi_djtag_readreg(module_id, bank_sel, L3C_EVCTRL_REG_OFF,
+			   client, &value);
+	value |= L3C_EVENT_EN;
+	hisi_djtag_writereg(module_id, bank_sel, L3C_EVCTRL_REG_OFF,
+			    value, client);
+}
+
+static void hisi_l3c_pmu_stop_counters(struct hisi_pmu *l3c_pmu)
+{
+	struct hisi_l3c_data *l3c_data = l3c_pmu->hwmod_data;
+	struct hisi_djtag_client *client = l3c_data->client;
+	u32 module_id = GET_MODULE_ID(l3c_data);
+	u32 bank_sel = GET_BANK_SEL(l3c_data);
+	u32 value;
+
+	/*
+	 * Clear the event_bus_en bit in L3C AUCNTRL
+	 */
+	hisi_djtag_readreg(module_id, bank_sel, L3C_EVCTRL_REG_OFF,
+			   client, &value);
+	value &= ~(L3C_EVENT_EN);
+	hisi_djtag_writereg(module_id, bank_sel, L3C_EVCTRL_REG_OFF,
+			    value, client);
+}
+
+static void hisi_l3c_pmu_clear_event_idx(struct hisi_pmu *l3c_pmu, int idx)
+{
+	if (!hisi_l3c_pmu_counter_valid(idx)) {
+		dev_err(l3c_pmu->dev, "Unsupported event index:%d!\n", idx);
+		return;
+	}
+	clear_bit(idx, l3c_pmu->pmu_events.used_mask);
+}
+
+static int hisi_l3c_pmu_get_event_idx(struct perf_event *event)
+{
+	struct hisi_pmu *l3c_pmu = to_hisi_pmu(event->pmu);
+	unsigned long *used_mask = l3c_pmu->pmu_events.used_mask;
+	u32 num_counters = l3c_pmu->num_counters;
+	int event_idx;
+
+	event_idx = find_first_zero_bit(used_mask, num_counters);
+	if (event_idx == num_counters)
+		return -EAGAIN;
+
+	set_bit(event_idx, used_mask);
+
+	return event_idx;
+}
+
+/* Handle differences in L3C hw in v1/v2 chips */
+static const struct hisi_l3c_pmu_hw_diff l3c_hw_v1 = {
+	.get_bank_id = get_l3c_bank_v1,
+};
+
+static const struct hisi_l3c_pmu_hw_diff l3c_hw_v2 = {
+	.get_bank_id = get_l3c_bank_v2,
+};
+
+static const struct of_device_id hisi_l3c_pmu_of_match[] = {
+	{ .compatible = "hisilicon,hip05-pmu-l3c-v1", &l3c_hw_v1},
+	{ .compatible = "hisilicon,hip06-pmu-l3c-v1", &l3c_hw_v1},
+	{ .compatible = "hisilicon,hip07-pmu-l3c-v2", &l3c_hw_v2},
+	{},
+};
+MODULE_DEVICE_TABLE(of, hisi_l3c_pmu_of_match);
+
+static const struct acpi_device_id hisi_l3c_pmu_acpi_match[] = {
+	{ "HISI0211", (kernel_ulong_t)&l3c_hw_v1},
+	{ "HISI0212", (kernel_ulong_t)&l3c_hw_v2},
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, hisi_l3c_pmu_acpi_match);
+
+static int hisi_l3c_pmu_get_module_instance_id(struct device *dev,
+					       struct  hisi_l3c_data *l3c_data)
+{
+	int ret;
+
+	ret = device_property_read_u32(dev, "hisilicon,module-id",
+				       &l3c_data->module_id);
+	if (ret < 0) {
+		dev_err(dev, "Could not read module-id!\n");
+		return -EINVAL;
+	}
+
+	ret = device_property_read_u32(dev, "hisilicon,instance-id",
+				       &l3c_data->bank_select);
+	if (ret < 0) {
+		dev_err(dev, "Could not read instance-id!\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static struct attribute *hisi_l3c_pmu_format_attr[] = {
+	HISI_PMU_FORMAT_ATTR(event, "config:0-7"),
+	NULL,
+};
+
+static const struct attribute_group hisi_l3c_pmu_format_group = {
+	.name = "format",
+	.attrs = hisi_l3c_pmu_format_attr,
+};
+
+static struct attribute *hisi_l3c_pmu_events_attr[] = {
+	HISI_PMU_EVENT_ATTR_STR(read_allocate, "event=0x0"),
+	HISI_PMU_EVENT_ATTR_STR(write_allocate, "event=0x01"),
+	HISI_PMU_EVENT_ATTR_STR(read_noallocate, "event=0x02"),
+	HISI_PMU_EVENT_ATTR_STR(write_noallocate, "event=0x03"),
+	HISI_PMU_EVENT_ATTR_STR(read_hit, "event=0x04"),
+	HISI_PMU_EVENT_ATTR_STR(write_hit, "event=0x05"),
+	NULL,
+};
+
+static const struct attribute_group hisi_l3c_pmu_events_group = {
+	.name = "events",
+	.attrs = hisi_l3c_pmu_events_attr,
+};
+
+static struct attribute *hisi_l3c_pmu_attrs[] = {
+	NULL,
+};
+
+static const struct attribute_group hisi_l3c_pmu_attr_group = {
+	.attrs = hisi_l3c_pmu_attrs,
+};
+
+static DEVICE_ATTR(cpumask, 0444, hisi_cpumask_sysfs_show, NULL);
+
+static struct attribute *hisi_l3c_pmu_cpumask_attrs[] = {
+	&dev_attr_cpumask.attr,
+	NULL,
+};
+
+static const struct attribute_group hisi_l3c_pmu_cpumask_attr_group = {
+	.attrs = hisi_l3c_pmu_cpumask_attrs,
+};
+
+static const struct attribute_group *hisi_l3c_pmu_pmu_attr_groups[] = {
+	&hisi_l3c_pmu_attr_group,
+	&hisi_l3c_pmu_format_group,
+	&hisi_l3c_pmu_events_group,
+	&hisi_l3c_pmu_cpumask_attr_group,
+	NULL,
+};
+
+static struct hisi_uncore_ops hisi_uncore_l3c_ops = {
+	.set_evtype = hisi_l3c_pmu_set_evtype,
+	.clear_evtype = hisi_l3c_pmu_clear_evtype,
+	.set_event_period = hisi_uncore_pmu_set_event_period,
+	.get_event_idx = hisi_l3c_pmu_get_event_idx,
+	.clear_event_idx = hisi_l3c_pmu_clear_event_idx,
+	.event_update = hisi_uncore_pmu_event_update,
+	.start_counters = hisi_l3c_pmu_start_counters,
+	.stop_counters = hisi_l3c_pmu_stop_counters,
+	.write_counter = hisi_l3c_pmu_write_counter,
+	.read_counter = hisi_l3c_pmu_read_counter,
+};
+
+/* Initialize hrtimer to poll for avoiding counter overflow */
+static void hisi_l3c_pmu_hrtimer_init(struct hisi_pmu *l3c_pmu)
+{
+	INIT_LIST_HEAD(&l3c_pmu->active_list);
+	l3c_pmu->ops->start_hrtimer = hisi_hrtimer_start;
+	l3c_pmu->ops->stop_hrtimer = hisi_hrtimer_stop;
+	hisi_hrtimer_init(l3c_pmu, L3C_HRTIMER_INTERVAL);
+}
+
+static void hisi_l3c_pmu_init_data(struct hisi_pmu *l3c_pmu,
+				   struct hisi_djtag_client *client)
+{
+	struct device *dev = &client->dev;
+	struct hisi_l3c_data *l3c_data = l3c_pmu->hwmod_data;
+
+	l3c_pmu->num_events = HISI_HWEVENT_L3C_EVENT_MAX;
+	l3c_pmu->num_counters = HISI_IDX_L3C_COUNTER_MAX;
+	l3c_pmu->counter_bits = 32;
+	l3c_pmu->num_active = 0;
+	l3c_pmu->scl_id = hisi_djtag_get_sclid(client);
+	l3c_pmu->name = kasprintf(GFP_KERNEL, "hisi_l3c%u_%u",
+				  l3c_data->bank_id, l3c_pmu->scl_id);
+	l3c_pmu->ops = &hisi_uncore_l3c_ops;
+	l3c_pmu->dev = dev;
+
+	/* Pick one core to use for cpumask attributes */
+	cpumask_set_cpu(smp_processor_id(), &l3c_pmu->cpus);
+
+	/*
+	 * Use poll method to avoid counter overflow as overflow IRQ
+	 * is not supported in v1,v2 hardware.
+	 */
+	hisi_l3c_pmu_hrtimer_init(l3c_pmu);
+}
+
+static int hisi_l3c_pmu_dev_probe(struct hisi_pmu *l3c_pmu,
+				  struct hisi_djtag_client *client)
+{
+	struct hisi_l3c_data *l3c_data;
+	const struct hisi_l3c_pmu_hw_diff *l3c_hw;
+	struct device *dev = &client->dev;
+	int ret;
+
+	l3c_data = devm_kzalloc(dev, sizeof(*l3c_data), GFP_KERNEL);
+	if (!l3c_data)
+		return -ENOMEM;
+
+	/* Set the djtag Identifier */
+	l3c_data->client = client;
+
+	l3c_pmu->hwmod_data = l3c_data;
+
+	if (dev->of_node) {
+		const struct of_device_id *of_id;
+
+		of_id = of_match_device(hisi_l3c_pmu_of_match, dev);
+		if (!of_id) {
+			dev_err(dev, "DT: Match device fail!\n");
+			return -EINVAL;
+		}
+		l3c_hw = of_id->data;
+	} else if (ACPI_COMPANION(dev)) {
+		const struct acpi_device_id *acpi_id;
+
+		acpi_id = acpi_match_device(hisi_l3c_pmu_acpi_match, dev);
+		if (!acpi_id) {
+			dev_err(dev, "ACPI: Match device fail!\n");
+			return -EINVAL;
+		}
+		l3c_hw = (struct hisi_l3c_pmu_hw_diff *)acpi_id->driver_data;
+	} else
+		return -EINVAL;
+
+	/* Get the L3C Module and Instance ID to identify bank index */
+	ret = hisi_l3c_pmu_get_module_instance_id(dev, l3c_data);
+	if (ret < 0)
+		return -EINVAL;
+
+	/* Get the L3C bank index to set the pmu name */
+	l3c_data->bank_id = l3c_hw->get_bank_id(l3c_data->module_id,
+						l3c_data->bank_select);
+	if (l3c_data->bank_id == MAX_BANKS) {
+		dev_err(dev, "Invalid bank-select!\n");
+		return -EINVAL;
+	}
+
+	hisi_l3c_pmu_init_data(l3c_pmu, client);
+
+	return 0;
+}
+
+static int hisi_l3c_pmu_probe(struct hisi_djtag_client *client)
+{
+	struct hisi_pmu *l3c_pmu;
+	struct device *dev = &client->dev;
+	int ret;
+
+	l3c_pmu = hisi_pmu_alloc(dev, HISI_IDX_L3C_COUNTER_MAX);
+	if (!l3c_pmu)
+		return -ENOMEM;
+
+	ret = hisi_l3c_pmu_dev_probe(l3c_pmu, client);
+	if (ret)
+		return ret;
+
+	l3c_pmu->pmu = (struct pmu) {
+		.name = l3c_pmu->name,
+		.task_ctx_nr = perf_invalid_context,
+		.event_init = hisi_uncore_pmu_event_init,
+		.pmu_enable = hisi_uncore_pmu_enable,
+		.pmu_disable = hisi_uncore_pmu_disable,
+		.add = hisi_uncore_pmu_add,
+		.del = hisi_uncore_pmu_del,
+		.start = hisi_uncore_pmu_start,
+		.stop = hisi_uncore_pmu_stop,
+		.read = hisi_uncore_pmu_read,
+		.attr_groups = hisi_l3c_pmu_pmu_attr_groups,
+	};
+
+	ret = hisi_uncore_pmu_setup(l3c_pmu, l3c_pmu->name);
+	if (ret) {
+		dev_err(dev, "hisi_uncore_pmu_init FAILED!!\n");
+		kfree(l3c_pmu->name);
+		return ret;
+	}
+
+	/* Set the drv data to L3C pmu */
+	dev_set_drvdata(dev, l3c_pmu);
+
+	return 0;
+}
+
+static int hisi_l3c_pmu_remove(struct hisi_djtag_client *client)
+{
+	struct hisi_pmu *l3c_pmu;
+	struct device *dev = &client->dev;
+
+	l3c_pmu = dev_get_drvdata(dev);
+	perf_pmu_unregister(&l3c_pmu->pmu);
+	kfree(l3c_pmu->name);
+
+	return 0;
+}
+
+static struct hisi_djtag_driver hisi_l3c_pmu_driver = {
+	.driver = {
+		.name = "hisi-l3c-pmu",
+		.of_match_table = hisi_l3c_pmu_of_match,
+		.acpi_match_table = ACPI_PTR(hisi_l3c_pmu_acpi_match),
+	},
+	.probe = hisi_l3c_pmu_probe,
+	.remove = hisi_l3c_pmu_remove,
+};
+
+static int __init hisi_l3c_pmu_init(void)
+{
+	int ret;
+
+	ret = hisi_djtag_register_driver(THIS_MODULE, &hisi_l3c_pmu_driver);
+	if (ret < 0) {
+		pr_err("hisi pmu L3C init failed, ret=%d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+module_init(hisi_l3c_pmu_init);
+
+static void __exit hisi_l3c_pmu_exit(void)
+{
+	hisi_djtag_unregister_driver(&hisi_l3c_pmu_driver);
+
+}
+module_exit(hisi_l3c_pmu_exit);
+
+MODULE_DESCRIPTION("HiSilicon SoC HIP0x L3C PMU driver");
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Anurup M");
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
new file mode 100644
index 0000000..c0b9e8a
--- /dev/null
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
@@ -0,0 +1,451 @@
+/*
+ * HiSilicon SoC Hardware event counters support
+ *
+ * Copyright (C) 2017 Hisilicon Limited
+ * Author: Anurup M <anurup.m@huawei.com>
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
+	return sprintf(buf, "%s\n", (char *) eattr->var);
+}
+
+/*
+ * PMU event attributes
+ */
+ssize_t hisi_event_sysfs_show(struct device *dev,
+			      struct device_attribute *attr, char *page)
+{
+	struct perf_pmu_events_attr *pmu_attr =
+		container_of(attr, struct perf_pmu_events_attr, attr);
+
+	return sprintf(page, "%s", pmu_attr->event_str);
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
+/* The counter overflow IRQ is not supported for some PMUs
+ * use hrtimer to periodically poll and avoid overflow
+ */
+static enum hrtimer_restart hisi_hrtimer_callback(struct hrtimer *hrtimer)
+{
+	struct hisi_pmu *hisi_pmu = container_of(hrtimer,
+						 struct hisi_pmu, hrtimer);
+	struct perf_event *event;
+	unsigned long flags;
+
+	/* Return if no active events */
+	if (!hisi_pmu->num_active)
+		return HRTIMER_NORESTART;
+
+	local_irq_save(flags);
+
+	/* Update event count for each active event */
+	list_for_each_entry(event, &hisi_pmu->active_list, active_entry) {
+		/* Read hardware counter and update the Perf event counter */
+		hisi_pmu->ops->event_update(event);
+	}
+
+	local_irq_restore(flags);
+	hrtimer_forward_now(hrtimer, ms_to_ktime(hisi_pmu->hrt_duration));
+	return HRTIMER_RESTART;
+}
+
+void hisi_hrtimer_init(struct hisi_pmu *hisi_pmu, u64 timer_interval)
+{
+	/* hr timer clock initalization */
+	hrtimer_init(&hisi_pmu->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hisi_pmu->hrtimer.function = &hisi_hrtimer_callback;
+	hisi_pmu->hrt_duration = timer_interval;
+}
+
+void hisi_hrtimer_start(struct hisi_pmu *hisi_pmu)
+{
+	hrtimer_start(&hisi_pmu->hrtimer,
+		      ms_to_ktime(hisi_pmu->hrt_duration),
+		      HRTIMER_MODE_REL_PINNED);
+}
+
+void hisi_hrtimer_stop(struct hisi_pmu *hisi_pmu)
+{
+	hrtimer_cancel(&hisi_pmu->hrtimer);
+}
+
+/* djtag read interface - Call djtag driver to access SoC registers */
+void hisi_djtag_readreg(int module_id, int bank, u32 offset,
+			struct hisi_djtag_client *client, u32 *value)
+{
+	u32 chain_id = 0;
+
+	/* Get the chain_id from bank_select, to use in djtag */
+	if (bank != 1)
+		chain_id = DJTAG_GET_CHAIN_ID(bank);
+
+	hisi_djtag_readl(client, offset, module_id, chain_id, value);
+}
+
+/* djtag write interface - Call djtag driver  to access SoC registers */
+void hisi_djtag_writereg(int module_id, int bank, u32 offset,
+			 u32 value, struct hisi_djtag_client *client)
+{
+	u32 chain_id = 0;
+
+	/* Get the chain_id from bank_select, to use in djtag */
+	if (bank != 1)
+		chain_id = DJTAG_GET_CHAIN_ID(bank);
+
+	hisi_djtag_writel(client, offset, module_id, (1 << chain_id), value);
+}
+
+static bool hisi_validate_event_group(struct perf_event *event)
+{
+	struct perf_event *sibling, *leader = event->group_leader;
+	struct hisi_pmu *hisi_pmu = to_hisi_pmu(event->pmu);
+	int counters = 1; /* Include count for the event */
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
+	hwc->config		= event->attr.config;
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
+ * Enable counter and set the counter to count
+ * the event that we're interested in.
+ */
+static void hisi_uncore_pmu_enable_event(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct hisi_pmu *hisi_pmu = to_hisi_pmu(event->pmu);
+
+	/*
+	 * Set event in Event select registers.
+	 */
+	hisi_pmu->ops->set_evtype(hisi_pmu, GET_CNTR_IDX(hwc),
+				  GET_EVENTID(event));
+
+	/* Enable the hardware event counting */
+	if (hisi_pmu->ops->enable_counter)
+		hisi_pmu->ops->enable_counter(hisi_pmu, GET_CNTR_IDX(hwc));
+}
+
+/*
+ * Disable counting and clear the event.
+ */
+static void hisi_uncore_pmu_disable_event(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct hisi_pmu *hisi_pmu = to_hisi_pmu(event->pmu);
+
+	/* Disable the hardware event counting */
+	if (hisi_pmu->ops->disable_counter)
+		hisi_pmu->ops->disable_counter(hisi_pmu, GET_CNTR_IDX(hwc));
+
+	/*
+	 * Clear event in Event select registers.
+	 */
+	hisi_pmu->ops->clear_evtype(hisi_pmu, GET_CNTR_IDX(hwc));
+}
+
+void hisi_uncore_pmu_set_event_period(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct hisi_pmu *hisi_pmu = to_hisi_pmu(event->pmu);
+
+	/*
+	 * The Hisilicon PMU counters have a period of 2^32. We reduce it
+	 * to 2^31 to account for the extreme interrupt latency. So we
+	 * could hopefully handle the overflow interrupt before another
+	 * 2^31 events occur and the counter overtakes its previous value.
+	 */
+	u64 val = 1ULL << (hisi_pmu->counter_bits - 1);
+
+	local64_set(&hwc->prev_count, val);
+
+	/* Write start value to the hardware event counter */
+	hisi_pmu->ops->write_counter(hisi_pmu, hwc, (u32) val);
+}
+
+u64 hisi_uncore_pmu_event_update(struct perf_event *event)
+{
+	struct hisi_pmu *hisi_pmu = to_hisi_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	int idx = GET_CNTR_IDX(hwc);
+	u64 delta, prev_raw_count, new_raw_count;
+
+	do {
+		/* Read the count from the counter register */
+		new_raw_count = hisi_pmu->ops->read_counter(hisi_pmu, idx);
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
+	hisi_pmu->ops->set_event_period(event);
+
+	if (flags & PERF_EF_RELOAD) {
+		u64 prev_raw_count =  local64_read(&hwc->prev_count);
+
+		hisi_pmu->ops->write_counter(hisi_pmu, hwc,
+					     (u32) prev_raw_count);
+	}
+
+	/* Start hrtimer when the first event is started in this PMU */
+	if (hisi_pmu->ops->start_hrtimer) {
+		hisi_pmu->num_active++;
+		list_add_tail(&event->active_entry, &hisi_pmu->active_list);
+
+		if (hisi_pmu->num_active == 1)
+			hisi_pmu->ops->start_hrtimer(hisi_pmu);
+	}
+
+	hisi_uncore_pmu_enable_event(event);
+	perf_event_update_userpage(event);
+}
+
+void hisi_uncore_pmu_stop(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct hisi_pmu *hisi_pmu = to_hisi_pmu(event->pmu);
+
+	hisi_uncore_pmu_disable_event(event);
+	WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
+	hwc->state |= PERF_HES_STOPPED;
+
+	/* Stop hrtimer when the last event is stopped in this PMU */
+	if (hisi_pmu->ops->stop_hrtimer) {
+		hisi_pmu->num_active--;
+		list_del(&event->active_entry);
+
+		if (hisi_pmu->num_active == 0)
+			hisi_pmu->ops->stop_hrtimer(hisi_pmu);
+	}
+
+	if (hwc->state & PERF_HES_UPTODATE)
+		return;
+
+	/* Read hardware counter and update the Perf counter statistics */
+	hisi_pmu->ops->event_update(event);
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
+	/* Get an available counter index for counting. */
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
+	hisi_pmu->ops->clear_event_idx(hisi_pmu, GET_CNTR_IDX(hwc));
+	perf_event_update_userpage(event);
+	hisi_pmu->pmu_events.hw_events[GET_CNTR_IDX(hwc)] = NULL;
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
+	struct hisi_pmu *hisi_pmu = to_hisi_pmu(event->pmu);
+
+	/* Read hardware counter and update the Perf counter statistics */
+	hisi_pmu->ops->event_update(event);
+}
+
+void hisi_uncore_pmu_enable(struct pmu *pmu)
+{
+	struct hisi_pmu *hisi_pmu = to_hisi_pmu(pmu);
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
+int hisi_uncore_pmu_setup(struct hisi_pmu *hisi_pmu, const char *pmu_name)
+{
+	/* Register the events with perf */
+	return perf_pmu_register(&hisi_pmu->pmu, pmu_name, -1);
+}
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.h b/drivers/perf/hisilicon/hisi_uncore_pmu.h
new file mode 100644
index 0000000..9c16d30
--- /dev/null
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.h
@@ -0,0 +1,135 @@
+/*
+ * HiSilicon SoC Hardware event counters support
+ *
+ * Copyright (C) 2017 Hisilicon Limited
+ * Author: Anurup M <anurup.m@huawei.com>
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
+#include <linux/hrtimer.h>
+#include <linux/kernel.h>
+#include <linux/ktime.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <asm/local64.h>
+#include "djtag.h"
+
+#undef pr_fmt
+#define pr_fmt(fmt)     "hisi_pmu: " fmt
+
+#define HISI_EVTYPE_EVENT	0xff
+#define GET_EVENTID(ev)   (ev->hw.config & HISI_EVTYPE_EVENT)
+
+#define HISI_MAX_PERIOD(nr) (BIT_ULL(nr) - 1)
+#define MAX_BANKS 4
+
+#define GET_CNTR_IDX(hwc) (hwc->idx)
+#define to_hisi_pmu(c)	(container_of(c, struct hisi_pmu, pmu))
+
+#define HISI_PMU_FORMAT_ATTR(_name, _config)		\
+	(&((struct dev_ext_attribute[]) {		\
+		{ .attr = __ATTR(_name, 0444,		\
+				 hisi_format_sysfs_show,\
+				 NULL),			\
+		  .var = (void *) _config,		\
+		}					\
+	})[0].attr.attr)
+
+#define HISI_PMU_EVENT_ATTR_STR(_name, _str)		\
+	(&((struct perf_pmu_events_attr[]) {		\
+		{ .attr = __ATTR(_name, 0444,		\
+				 hisi_event_sysfs_show,	\
+				 NULL),			\
+		  .event_str = _str,			\
+		}					\
+	  })[0].attr.attr)
+
+struct hisi_pmu;
+
+struct hisi_uncore_ops {
+	void (*set_evtype)(struct hisi_pmu *, int, u32);
+	void (*clear_evtype)(struct hisi_pmu *, int);
+	void (*set_event_period)(struct perf_event *);
+	int (*get_event_idx)(struct perf_event *);
+	void (*clear_event_idx)(struct hisi_pmu *, int);
+	u64 (*event_update)(struct perf_event *);
+	u64 (*read_counter)(struct hisi_pmu *, int);
+	void (*write_counter)(struct hisi_pmu *, struct hw_perf_event *, u32);
+	void (*enable_counter)(struct hisi_pmu *, int);
+	void (*disable_counter)(struct hisi_pmu *, int);
+	void (*start_counters)(struct hisi_pmu *);
+	void (*stop_counters)(struct hisi_pmu *);
+	void (*start_hrtimer)(struct hisi_pmu *);
+	void (*stop_hrtimer)(struct hisi_pmu *);
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
+	struct hisi_uncore_ops *ops;
+	struct hisi_pmu_hwevents pmu_events;
+	void *hwmod_data; /* Hardware module specific data */
+	cpumask_t cpus;
+	struct device *dev;
+	struct list_head active_list; /* Active events list */
+	struct hrtimer hrtimer; /* hrtimer to handle the
+				 * counter overflow
+				 */
+	u64 hrt_duration; /* hrtimer timeout */
+	u32 scl_id;
+	int num_counters;
+	int num_events;
+	int num_active;
+	int counter_bits;
+};
+
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
+void hisi_hrtimer_init(struct hisi_pmu *hisi_pmu, u64 timer_interval);
+void hisi_hrtimer_start(struct hisi_pmu *hisi_pmu);
+void hisi_hrtimer_stop(struct hisi_pmu *hisi_pmu);
+void hisi_djtag_readreg(int module_id, int bank, u32 offset,
+			struct hisi_djtag_client *client, u32 *value);
+void hisi_djtag_writereg(int module_id, int bank, u32 offset,
+			 u32 value, struct hisi_djtag_client *client);
+#endif /* __HISI_UNCORE_PMU_H__ */
-- 
1.9.1
