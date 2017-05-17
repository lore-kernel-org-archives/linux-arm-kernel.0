From: jglauber@cavium.com (Jan Glauber)
Date: Wed, 17 May 2017 10:31:22 +0200
Subject: [PATCH v5 3/3] perf: cavium: Support transmit-link PMU counters
In-Reply-To: <20170517083122.5050-1-jglauber@cavium.com>
References: <20170517083122.5050-1-jglauber@cavium.com>
Message-ID: <20170517083122.5050-4-jglauber@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the transmit-link (TLK) PMU counters found
on Caviums SOCs with an interconnect.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/edac/thunderx_edac.c    |   7 ++
 drivers/perf/cavium_pmu.c       | 223 +++++++++++++++++++++++++++++++++++++++-
 include/linux/perf/cavium_pmu.h |   1 +
 3 files changed, 230 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/thunderx_edac.c b/drivers/edac/thunderx_edac.c
index 8de4faf..d3da6d3 100644
--- a/drivers/edac/thunderx_edac.c
+++ b/drivers/edac/thunderx_edac.c
@@ -1496,6 +1496,10 @@ static int thunderx_ocx_probe(struct pci_dev *pdev,
 
 	writeq(OCX_COM_INT_ENA_ALL, ocx->regs + OCX_COM_INT_ENA_W1S);
 
+	if (IS_ENABLED(CONFIG_CAVIUM_PMU))
+		ocx->pmu_data = cvm_pmu_probe(pdev, ocx->regs,
+					      CVM_PMU_TLK);
+
 	return 0;
 err_free:
 	edac_device_free_ctl_info(edac_dev);
@@ -1509,6 +1513,9 @@ static void thunderx_ocx_remove(struct pci_dev *pdev)
 	struct thunderx_ocx *ocx = edac_dev->pvt_info;
 	int i;
 
+	if (IS_ENABLED(CONFIG_CAVIUM_PMU))
+		cvm_pmu_remove(pdev, ocx->pmu_data, CVM_PMU_TLK);
+
 	writeq(OCX_COM_INT_ENA_ALL, ocx->regs + OCX_COM_INT_ENA_W1C);
 
 	for (i = 0; i < OCX_INTS; i++) {
diff --git a/drivers/perf/cavium_pmu.c b/drivers/perf/cavium_pmu.c
index 9881dc8..379c08a 100644
--- a/drivers/perf/cavium_pmu.c
+++ b/drivers/perf/cavium_pmu.c
@@ -21,6 +21,7 @@
 #include <linux/perf/cavium_pmu.h>
 
 struct list_head cvm_pmu_lmcs;
+struct list_head cvm_pmu_tlks;
 
 /*
  * Common Cavium PMU stuff
@@ -367,11 +368,228 @@ static void cvm_pmu_lmc_remove(struct pci_dev *pdev, void *pmu_data)
 	kfree(lmc);
 }
 
+/*
+ * CCPI interface controller (OCX) Transmit link (TLK) counters:
+ * - per-unit control
+ * - writable
+ * - one PCI device with multiple TLK units
+ */
+
+#define TLK_NR_UNITS			3
+#define TLK_UNIT_OFFSET			0x2000
+#define TLK_START_ADDR			0x10000
+#define TLK_STAT_CTL_OFFSET		0x40
+#define TLK_STAT_OFFSET			0x400
+
+#define TLK_STAT_ENABLE_BIT		BIT(0)
+#define TLK_STAT_RESET_BIT		BIT(1)
+
+#define CVM_PMU_TLK_EVENT_ATTR(_name, _id)						\
+	&((struct perf_pmu_events_attr[]) {						\
+		{									\
+			__ATTR(_name, S_IRUGO, cvm_pmu_event_sysfs_show, NULL),		\
+			0,								\
+			"tlk_event=" __stringify(_id),					\
+		}									\
+	})[0].attr.attr
+
+static void cvm_pmu_tlk_enable_pmu(struct pmu *pmu)
+{
+	struct cvm_pmu_dev *pmu_dev = container_of(pmu, struct cvm_pmu_dev, pmu);
+
+	/* enable all counters */
+	writeb(TLK_STAT_ENABLE_BIT, pmu_dev->map + TLK_STAT_CTL_OFFSET);
+}
+
+static void cvm_pmu_tlk_disable_pmu(struct pmu *pmu)
+{
+	struct cvm_pmu_dev *pmu_dev = container_of(pmu, struct cvm_pmu_dev, pmu);
+
+	/* disable all counters */
+	writeb(0, pmu_dev->map + TLK_STAT_CTL_OFFSET);
+}
+
+static int cvm_pmu_tlk_add(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	return cvm_pmu_add(event, flags, TLK_STAT_CTL_OFFSET,
+			   TLK_STAT_OFFSET + hwc->config * 8);
+}
+
+PMU_FORMAT_ATTR(tlk_event, "config:0-5");
+
+static struct attribute *cvm_pmu_tlk_format_attr[] = {
+	&format_attr_tlk_event.attr,
+	NULL,
+};
+
+static struct attribute_group cvm_pmu_tlk_format_group = {
+	.name = "format",
+	.attrs = cvm_pmu_tlk_format_attr,
+};
+
+static struct attribute *cvm_pmu_tlk_events_attr[] = {
+	CVM_PMU_TLK_EVENT_ATTR(idle_cnt,	0x00),
+	CVM_PMU_TLK_EVENT_ATTR(data_cnt,	0x01),
+	CVM_PMU_TLK_EVENT_ATTR(sync_cnt,	0x02),
+	CVM_PMU_TLK_EVENT_ATTR(retry_cnt,	0x03),
+	CVM_PMU_TLK_EVENT_ATTR(err_cnt,		0x04),
+	CVM_PMU_TLK_EVENT_ATTR(mat0_cnt,	0x08),
+	CVM_PMU_TLK_EVENT_ATTR(mat1_cnt,	0x09),
+	CVM_PMU_TLK_EVENT_ATTR(mat2_cnt,	0x0a),
+	CVM_PMU_TLK_EVENT_ATTR(mat3_cnt,	0x0b),
+	CVM_PMU_TLK_EVENT_ATTR(vc0_cmd,		0x10),
+	CVM_PMU_TLK_EVENT_ATTR(vc1_cmd,		0x11),
+	CVM_PMU_TLK_EVENT_ATTR(vc2_cmd,		0x12),
+	CVM_PMU_TLK_EVENT_ATTR(vc3_cmd,		0x13),
+	CVM_PMU_TLK_EVENT_ATTR(vc4_cmd,		0x14),
+	CVM_PMU_TLK_EVENT_ATTR(vc5_cmd,		0x15),
+	CVM_PMU_TLK_EVENT_ATTR(vc0_pkt,		0x20),
+	CVM_PMU_TLK_EVENT_ATTR(vc1_pkt,		0x21),
+	CVM_PMU_TLK_EVENT_ATTR(vc2_pkt,		0x22),
+	CVM_PMU_TLK_EVENT_ATTR(vc3_pkt,		0x23),
+	CVM_PMU_TLK_EVENT_ATTR(vc4_pkt,		0x24),
+	CVM_PMU_TLK_EVENT_ATTR(vc5_pkt,		0x25),
+	CVM_PMU_TLK_EVENT_ATTR(vc6_pkt,		0x26),
+	CVM_PMU_TLK_EVENT_ATTR(vc7_pkt,		0x27),
+	CVM_PMU_TLK_EVENT_ATTR(vc8_pkt,		0x28),
+	CVM_PMU_TLK_EVENT_ATTR(vc9_pkt,		0x29),
+	CVM_PMU_TLK_EVENT_ATTR(vc10_pkt,	0x2a),
+	CVM_PMU_TLK_EVENT_ATTR(vc11_pkt,	0x2b),
+	CVM_PMU_TLK_EVENT_ATTR(vc12_pkt,	0x2c),
+	CVM_PMU_TLK_EVENT_ATTR(vc13_pkt,	0x2d),
+	CVM_PMU_TLK_EVENT_ATTR(vc0_con,		0x30),
+	CVM_PMU_TLK_EVENT_ATTR(vc1_con,		0x31),
+	CVM_PMU_TLK_EVENT_ATTR(vc2_con,		0x32),
+	CVM_PMU_TLK_EVENT_ATTR(vc3_con,		0x33),
+	CVM_PMU_TLK_EVENT_ATTR(vc4_con,		0x34),
+	CVM_PMU_TLK_EVENT_ATTR(vc5_con,		0x35),
+	CVM_PMU_TLK_EVENT_ATTR(vc6_con,		0x36),
+	CVM_PMU_TLK_EVENT_ATTR(vc7_con,		0x37),
+	CVM_PMU_TLK_EVENT_ATTR(vc8_con,		0x38),
+	CVM_PMU_TLK_EVENT_ATTR(vc9_con,		0x39),
+	CVM_PMU_TLK_EVENT_ATTR(vc10_con,	0x3a),
+	CVM_PMU_TLK_EVENT_ATTR(vc11_con,	0x3b),
+	CVM_PMU_TLK_EVENT_ATTR(vc12_con,	0x3c),
+	CVM_PMU_TLK_EVENT_ATTR(vc13_con,	0x3d),
+	NULL,
+};
+
+static struct attribute_group cvm_pmu_tlk_events_group = {
+	.name = "events",
+	.attrs = cvm_pmu_tlk_events_attr,
+};
+static const struct attribute_group *cvm_pmu_tlk_attr_groups[] = {
+	&cvm_pmu_attr_group,
+	&cvm_pmu_tlk_format_group,
+	&cvm_pmu_tlk_events_group,
+	NULL,
+};
+
+static bool cvm_pmu_tlk_event_valid(u64 config)
+{
+	if (config < ARRAY_SIZE(cvm_pmu_tlk_events_attr))
+		return true;
+
+	return false;
+}
+
+static void *cvm_pmu_tlk_probe_unit(struct pci_dev *pdev, void __iomem *regs,
+				    int nr)
+{
+	struct cvm_pmu_dev *tlk;
+	int ret = -ENOMEM;
+	char name[12];
+
+	tlk = kzalloc(sizeof(*tlk), GFP_KERNEL);
+	if (!tlk)
+		goto fail_nomem;
+
+	memset(name, 0, 12);
+	snprintf(name, 12, "ocx_tlk%d", nr);
+
+	list_add(&tlk->entry, &cvm_pmu_tlks);
+
+	tlk->pdev = pdev;
+	tlk->map = regs + TLK_START_ADDR + nr * TLK_UNIT_OFFSET;
+	tlk->num_counters = ARRAY_SIZE(cvm_pmu_tlk_events_attr) - 1;
+	tlk->pmu = (struct pmu) {
+		.name		= name,
+		.task_ctx_nr    = perf_invalid_context,
+		.pmu_enable	= cvm_pmu_tlk_enable_pmu,
+		.pmu_disable	= cvm_pmu_tlk_disable_pmu,
+		.event_init	= cvm_pmu_event_init,
+		.add		= cvm_pmu_tlk_add,
+		.del		= cvm_pmu_del,
+		.start		= cvm_pmu_start,
+		.stop		= cvm_pmu_stop,
+		.read		= cvm_pmu_read,
+		.attr_groups	= cvm_pmu_tlk_attr_groups,
+	};
+
+	cpuhp_state_add_instance_nocalls(CPUHP_AP_PERF_ARM_CVM_ONLINE,
+					 &tlk->cpuhp_node);
+
+	/*
+	 * perf PMU is CPU dependent so pick a random CPU and migrate away
+	 * if it goes offline.
+	 */
+	cpumask_set_cpu(smp_processor_id(), &tlk->active_mask);
+
+	ret = perf_pmu_register(&tlk->pmu, tlk->pmu.name, -1);
+	if (ret)
+		goto fail_hp;
+
+	tlk->event_valid = cvm_pmu_tlk_event_valid;
+	return tlk;
+
+fail_hp:
+	cpuhp_state_remove_instance(CPUHP_AP_PERF_ARM_CVM_ONLINE,
+				    &tlk->cpuhp_node);
+	kfree(tlk);
+fail_nomem:
+	return ERR_PTR(ret);
+}
+
+static void *cvm_pmu_tlk_probe(struct pci_dev *pdev, void __iomem *regs)
+{
+	struct cvm_pmu_dev *tlk;
+	int i;
+
+	for (i = 0; i < TLK_NR_UNITS; i++) {
+		tlk = cvm_pmu_tlk_probe_unit(pdev, regs, i);
+		if (PTR_ERR(tlk))
+			continue;
+		dev_info(&pdev->dev, "Enabled %s PMU with %d counters\n",
+			 tlk->pmu.name, tlk->num_counters);
+	}
+	return &cvm_pmu_tlks;
+}
+
+static void cvm_pmu_tlk_remove(struct pci_dev *pdev, void *pmu_data)
+{
+	struct list_head *l, *tmp;
+	struct cvm_pmu_dev *tlk;
+
+	list_for_each_safe(l, tmp, &cvm_pmu_tlks) {
+		tlk = list_entry(l,  struct cvm_pmu_dev, entry);
+
+		list_del(&tlk->entry);
+		cpuhp_state_remove_instance(CPUHP_AP_PERF_ARM_CVM_ONLINE,
+					    &tlk->cpuhp_node);
+		perf_pmu_unregister(&tlk->pmu);
+		kfree(tlk);
+	}
+}
+
 void *cvm_pmu_probe(struct pci_dev *pdev, void __iomem *regs, int type)
 {
 	switch (type) {
 	case CVM_PMU_LMC:
 		return cvm_pmu_lmc_probe(pdev, regs);
+	case CVM_PMU_TLK:
+		return cvm_pmu_tlk_probe(pdev, regs);
 	}
 	return NULL;
 }
@@ -382,6 +600,8 @@ void cvm_pmu_remove(struct pci_dev *pdev, void *pmu_data, int type)
 	switch (type) {
 	case CVM_PMU_LMC:
 		return cvm_pmu_lmc_remove(pdev, pmu_data);
+	case CVM_PMU_TLK:
+		return cvm_pmu_tlk_remove(pdev, pmu_data);
 	}
 }
 EXPORT_SYMBOL_GPL(cvm_pmu_remove);
@@ -389,6 +609,7 @@ EXPORT_SYMBOL_GPL(cvm_pmu_remove);
 static int __init cvm_pmu_init(void)
 {
 	INIT_LIST_HEAD(&cvm_pmu_lmcs);
+	INIT_LIST_HEAD(&cvm_pmu_tlks);
 
 	return cpuhp_setup_state_multi(CPUHP_AP_PERF_ARM_CVM_ONLINE,
 				       "perf/arm/cvm:online", NULL,
@@ -397,7 +618,7 @@ static int __init cvm_pmu_init(void)
 
 static void __exit cvm_pmu_exit(void)
 {
-	if (list_empty(&cvm_pmu_lmcs))
+	if (list_empty(&cvm_pmu_lmcs) && list_empty(&cvm_pmu_tlks))
 		cpuhp_remove_state(CPUHP_AP_PERF_ARM_CVM_ONLINE);
 }
 
diff --git a/include/linux/perf/cavium_pmu.h b/include/linux/perf/cavium_pmu.h
index 7b13346..78f4d57 100644
--- a/include/linux/perf/cavium_pmu.h
+++ b/include/linux/perf/cavium_pmu.h
@@ -9,6 +9,7 @@
 
 enum cvm_pmu_type {
 	CVM_PMU_LMC,
+	CVM_PMU_TLK,
 };
 
 /* maximum number of parallel hardware counters for all pmu types */
-- 
2.9.0.rc0.21.g7777322
