From: jglauber@cavium.com (Jan Glauber)
Date: Tue, 25 Jul 2017 17:04:21 +0200
Subject: [PATCH v8 2/3] perf: cavium: Support transmit-link PMU counters
In-Reply-To: <20170725150422.4775-1-jglauber@cavium.com>
References: <20170725150422.4775-1-jglauber@cavium.com>
Message-ID: <20170725150422.4775-3-jglauber@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the transmit-link (OCX TLK) PMU counters found
on Caviums SOCs with a processor interconnect.

Properties of the OCX TLK counters:
- per-unit control
- fixed purpose
- writable
- one PCI device with multiple TLK units

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/perf/cavium_pmu.c | 222 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 222 insertions(+)

diff --git a/drivers/perf/cavium_pmu.c b/drivers/perf/cavium_pmu.c
index 582eb41..d2dd111f 100644
--- a/drivers/perf/cavium_pmu.c
+++ b/drivers/perf/cavium_pmu.c
@@ -19,6 +19,7 @@
 
 enum cvm_pmu_type {
 	CVM_PMU_LMC,
+	CVM_PMU_TLK,
 };
 
 /* maximum number of parallel hardware counters for all pmu types */
@@ -39,6 +40,7 @@ struct cvm_pmu_dev {
 };
 
 static struct list_head cvm_pmu_lmcs;
+static struct list_head cvm_pmu_tlks;
 
 /*
  * Common Cavium PMU stuff
@@ -395,6 +397,216 @@ static int cvm_pmu_lmc_probe(struct pci_dev *pdev)
 	return ret;
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
+#define TLK_UNIT_LEN			0x7ff
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
+			_id,								\
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
+
+static const struct attribute_group *cvm_pmu_tlk_attr_groups[] = {
+	&cvm_pmu_attr_group,
+	&cvm_pmu_tlk_format_group,
+	&cvm_pmu_tlk_events_group,
+	NULL,
+};
+
+static bool cvm_pmu_tlk_event_valid(u64 config)
+{
+	struct perf_pmu_events_attr *attr;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(cvm_pmu_tlk_events_attr) - 1; i++) {
+		attr = (struct perf_pmu_events_attr *)cvm_pmu_tlk_events_attr[i];
+		if (attr->id == config)
+			return true;
+	}
+	return false;
+}
+
+static int cvm_pmu_tlk_probe_unit(struct pci_dev *pdev, int nr)
+{
+	struct cvm_pmu_dev *tlk;
+	int ret = -ENOMEM;
+
+	tlk = kzalloc(sizeof(*tlk), GFP_KERNEL);
+	if (!tlk)
+		return -ENOMEM;
+
+	tlk->map = ioremap(pci_resource_start(pdev, 0) + TLK_START_ADDR +
+			   nr * TLK_UNIT_OFFSET, TLK_UNIT_LEN);
+	if (!tlk->map)
+		goto fail_ioremap;
+
+	tlk->pmu_name = kasprintf(GFP_KERNEL, "ocx_tlk%d", nr);
+	if (!tlk->pmu_name)
+		goto fail_kasprintf;
+
+	tlk->pdev = pdev;
+	tlk->num_counters = ARRAY_SIZE(cvm_pmu_tlk_events_attr) - 1;
+	tlk->pmu = (struct pmu) {
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
+	list_add(&tlk->entry, &cvm_pmu_tlks);
+	tlk->event_valid = cvm_pmu_tlk_event_valid;
+
+	ret = perf_pmu_register(&tlk->pmu, tlk->pmu_name, -1);
+	if (ret)
+		goto fail_pmu;
+
+	dev_info(&pdev->dev, "Enabled %s PMU with %d counters\n",
+		 tlk->pmu_name, tlk->num_counters);
+	return 0;
+
+fail_pmu:
+	kfree(tlk->pmu_name);
+	cpuhp_state_remove_instance(CPUHP_AP_PERF_ARM_CVM_ONLINE,
+				    &tlk->cpuhp_node);
+fail_kasprintf:
+	iounmap(tlk->map);
+fail_ioremap:
+	kfree(tlk);
+	return ret;
+}
+
+static int cvm_pmu_tlk_probe(struct pci_dev *pdev)
+{
+	int rc, i;
+
+	for (i = 0; i < TLK_NR_UNITS; i++) {
+		rc = cvm_pmu_tlk_probe_unit(pdev, i);
+		if (rc)
+			return rc;
+	}
+	return 0;
+}
+
 static int __init cvm_pmu_init(void)
 {
 	unsigned long implementor = read_cpuid_implementor();
@@ -406,6 +618,7 @@ static int __init cvm_pmu_init(void)
 		return -ENODEV;
 
 	INIT_LIST_HEAD(&cvm_pmu_lmcs);
+	INIT_LIST_HEAD(&cvm_pmu_tlks);
 
 	rc = cpuhp_setup_state_multi(CPUHP_AP_PERF_ARM_CVM_ONLINE,
 				     "perf/arm/cvm:online", NULL,
@@ -419,6 +632,15 @@ static int __init cvm_pmu_init(void)
 		if (rc)
 			return rc;
 	}
+
+	/* detect OCX TLK devices */
+	while ((pdev = pci_get_device(vendor_id, 0xa013, pdev))) {
+		if (!pdev)
+			break;
+		rc = cvm_pmu_tlk_probe(pdev);
+		if (rc)
+			return rc;
+	}
 	return 0;
 }
 late_initcall(cvm_pmu_init);	/* should come after PCI init */
-- 
2.9.0.rc0.21.g7777322
