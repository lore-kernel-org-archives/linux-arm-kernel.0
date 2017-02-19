From: anurupvasu@gmail.com (Anurup M)
Date: Sun, 19 Feb 2017 13:51:22 -0500
Subject: [PATCH v4 10/11] drivers: perf: hisi: Handle counter overflow IRQ in
 MN PMU
Message-ID: <1487530282-42731-1-git-send-email-anurup.m@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MN1 support IRQ for counter overflow handling.
MN1 use the index 26 of the Fabric Totem IRQ.
The interrupt parent will be Hisilicon Mbigen-v2.
The interrupt type is LPI.

Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Signed-off-by: Anurup M <anurup.m@huawei.com>
---
 drivers/perf/hisilicon/hisi_uncore_mn.c | 121 ++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/drivers/perf/hisilicon/hisi_uncore_mn.c b/drivers/perf/hisilicon/hisi_uncore_mn.c
index 3fe5982..490b11f 100644
--- a/drivers/perf/hisilicon/hisi_uncore_mn.c
+++ b/drivers/perf/hisilicon/hisi_uncore_mn.c
@@ -23,6 +23,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/of_irq.h>
 #include <linux/perf_event.h>
 #include "hisi_uncore_pmu.h"
 
@@ -54,6 +55,11 @@ enum armv8_hisi_mn_counters {
 #define MN1_EVENT_EN 0x01
 #define MN1_BANK_SELECT 0x01
 
+#define MN1_INTM_REG_OFF 0x060
+#define MN1_INTS_REG_OFF 0x068
+#define MN1_INTC_REG_OFF 0x06C
+#define MN1_INTM_UNMASK_ALL 0x0
+
 #define GET_MODULE_ID(hwmod_data) hwmod_data->mn_hwcfg.module_id
 
 struct hisi_mn_hwcfg {
@@ -118,6 +124,49 @@ static u64 hisi_mn_event_update(struct perf_event *event,
 	return new_raw_count;
 }
 
+static irqreturn_t hisi_pmu_mn_isr(int irq, void *dev_id)
+{
+	struct hisi_pmu *mn_pmu = dev_id;
+	struct hisi_mn_data *mn_data = mn_pmu->hwmod_data;
+	struct hisi_djtag_client *client = mn_data->client;
+	struct perf_event *event;
+	u32 module_id = GET_MODULE_ID(mn_data);
+	unsigned long flags;
+	u32 value = 0;
+	int bit_pos;
+
+	raw_spin_lock_irqsave(&mn_pmu->lock, flags);
+
+	/* Read the INTS register */
+	hisi_djtag_readreg(module_id, MN1_BANK_SELECT, MN1_INTS_REG_OFF,
+							client, &value);
+	if (!value) {
+		raw_spin_unlock_irqrestore(&mn_pmu->lock, flags);
+		return IRQ_NONE;
+	}
+
+	/* Find the counter index which overflowed and handle them */
+	for (bit_pos = 0; bit_pos < HISI_MAX_CFG_MN_CNTR; bit_pos++) {
+		if (test_bit(bit_pos, (void *)&value)) {
+			/* Clear the IRQ status flag */
+			hisi_djtag_writereg(module_id, MN1_BANK_SELECT,
+				MN1_INTC_REG_OFF, (1 << bit_pos), client);
+
+			/* Get the corresponding event struct */
+			event = mn_pmu->hw_perf_events[bit_pos];
+			if (!event)
+				continue;
+
+			hisi_mn_event_update(event, &event->hw, bit_pos);
+			hisi_pmu_set_event_period(event);
+			perf_event_update_userpage(event);
+		}
+	}
+
+	raw_spin_unlock_irqrestore(&mn_pmu->lock, flags);
+	return IRQ_HANDLED;
+}
+
 static void hisi_mn_set_evtype(struct hisi_pmu *mn_pmu, int idx, u32 val)
 {
 	struct hisi_mn_data *mn_data = mn_pmu->hwmod_data;
@@ -265,6 +314,51 @@ static int hisi_mn_get_event_idx(struct hisi_pmu *mn_pmu)
 	return event_idx;
 }
 
+static void hisi_mn_enable_interrupts(u32 module_id,
+				     struct hisi_djtag_client *client)
+{
+	u32 value = 0;
+
+	hisi_djtag_readreg(module_id, MN1_BANK_SELECT, MN1_INTM_REG_OFF,
+							client, &value);
+	if (value)
+		hisi_djtag_writereg(module_id, MN1_BANK_SELECT,
+					MN1_INTM_REG_OFF, MN1_INTM_UNMASK_ALL,
+									client);
+}
+
+static int hisi_mn_init_irq(int irq, struct hisi_pmu *mn_pmu,
+				     struct hisi_djtag_client *client)
+{
+	struct hisi_mn_data *mn_data = mn_pmu->hwmod_data;
+	u32 module_id = GET_MODULE_ID(mn_data);
+	struct device *dev = &client->dev;
+	int rc;
+
+	rc = devm_request_irq(dev, irq, hisi_pmu_mn_isr,
+			       IRQF_NOBALANCING | IRQF_NO_THREAD,
+					       dev_name(dev), mn_pmu);
+	if (rc) {
+		dev_err(dev, "Could not request IRQ:%d\n", irq);
+		return rc;
+	}
+
+	/* Overflow interrupt also should use the same CPU */
+	rc = irq_set_affinity(irq, &mn_pmu->cpu);
+	if (rc) {
+		dev_err(dev, "could not set IRQ affinity!\n");
+		return rc;
+	}
+
+	/*
+	 * Unmask all interrupts in Mask register
+	 * Enable all IRQ's
+	 */
+	hisi_mn_enable_interrupts(module_id, client);
+
+	return 0;
+}
+
 static const struct of_device_id mn_of_match[] = {
 	{ .compatible = "hisilicon,hip05-pmu-mn-v1", },
 	{ .compatible = "hisilicon,hip06-pmu-mn-v1", },
@@ -273,6 +367,29 @@ static const struct of_device_id mn_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, mn_of_match);
 
+static int hisi_mn_init_irqs_fdt(struct device *dev,
+				struct hisi_pmu *mn_pmu)
+{
+	struct hisi_mn_data *mn_data = mn_pmu->hwmod_data;
+	struct hisi_djtag_client *client = mn_data->client;
+	int irq = -1, num_irqs, i;
+
+	num_irqs = of_irq_count(dev->of_node);
+	for (i = 0; i < num_irqs; i++) {
+		irq = of_irq_get(dev->of_node, i);
+		if (irq < 0)
+			dev_info(dev, "No IRQ resource!\n");
+	}
+
+	if (irq < 0)
+		return 0;
+
+	/* The last entry in the IRQ list to be chosen
+	 * This is as per mbigen-v2 IRQ mapping
+	 */
+	return hisi_mn_init_irq(irq, mn_pmu, client);
+}
+
 static int hisi_mn_init_data(struct hisi_pmu *mn_pmu,
 				struct hisi_djtag_client *client)
 {
@@ -306,6 +423,10 @@ static int hisi_mn_init_data(struct hisi_pmu *mn_pmu,
 			return -EINVAL;
 		}
 
+		ret = hisi_mn_init_irqs_fdt(dev, mn_pmu);
+		if (ret)
+			return ret;
+
 		ret = device_property_read_u32(dev, "hisilicon,module-id",
 						       &mn_hwcfg->module_id);
 		if (ret < 0) {
-- 
2.1.4
