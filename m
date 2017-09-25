From: jglauber@cavium.com (Jan Glauber)
Date: Mon, 25 Sep 2017 14:35:00 +0200
Subject: [PATCH v10 5/7] perf: cavium: Support memory controller PMU counters
In-Reply-To: <20170925123502.17289-1-jglauber@cavium.com>
References: <20170925123502.17289-1-jglauber@cavium.com>
Message-ID: <20170925123502.17289-6-jglauber@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the PMU counters on Cavium SOC memory controllers.

This patch also adds generic functions to allow supporting more
devices with PMU counters.

Properties of the LMC PMU counters:
- not stoppable
- fixed purpose
- read-only
- one PCI device per memory controller

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/perf/Kconfig            |   8 +
 drivers/perf/Makefile           |   1 +
 drivers/perf/cavium_pmu.c       | 430 ++++++++++++++++++++++++++++++++++++++++
 drivers/soc/cavium/cavium_lmc.c |   4 +
 include/linux/cpuhotplug.h      |   1 +
 include/linux/soc/cavium/lmc.h  |   3 +
 6 files changed, 447 insertions(+)
 create mode 100644 drivers/perf/cavium_pmu.c

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index e5197ffb7422..a787562c5432 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -43,4 +43,12 @@ config XGENE_PMU
         help
           Say y if you want to use APM X-Gene SoC performance monitors.
 
+config CAVIUM_PMU_LMC
+	tristate "Cavium SOC memory controller PMU"
+	depends on ARCH_THUNDER && m
+	select CAVIUM_LMC
+	help
+	  Provides PMU counters for the memory controller on
+	  Cavium ThunderX or OcteonTX SOCs.
+
 endmenu
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index 6420bd4394d5..cd616785047f 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -1,5 +1,6 @@
 obj-$(CONFIG_ARM_PMU) += arm_pmu.o arm_pmu_platform.o
 obj-$(CONFIG_ARM_PMU_ACPI) += arm_pmu_acpi.o
+obj-$(CONFIG_CAVIUM_PMU_LMC) += cavium_pmu.o
 obj-$(CONFIG_QCOM_L2_PMU)	+= qcom_l2_pmu.o
 obj-$(CONFIG_QCOM_L3_PMU) += qcom_l3_pmu.o
 obj-$(CONFIG_XGENE_PMU) += xgene_pmu.o
diff --git a/drivers/perf/cavium_pmu.c b/drivers/perf/cavium_pmu.c
new file mode 100644
index 000000000000..45d1766db474
--- /dev/null
+++ b/drivers/perf/cavium_pmu.c
@@ -0,0 +1,430 @@
+/*
+ * Cavium ARM SOC "uncore" PMU counters
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright Cavium, Inc. 2017
+ * Author(s): Jan Glauber <jan.glauber@cavium.com>
+ *
+ */
+#include <linux/cpuhotplug.h>
+#include <linux/cpumask.h>
+#include <linux/io.h>
+#include <linux/export.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pci.h>
+#include <linux/perf_event.h>
+#include <linux/slab.h>
+#include <linux/soc/cavium/lmc.h>
+
+enum cvm_pmu_type {
+	CVM_PMU_LMC,
+};
+
+/* maximum number of parallel hardware counters for all pmu types */
+#define CVM_PMU_MAX_COUNTERS 64
+
+/* generic struct to cover the different pmu types */
+struct cvm_pmu_dev {
+	struct pmu pmu;
+	bool (*event_valid)(u64);
+	void __iomem *map;
+	struct pci_dev *pdev;
+	int num_counters;
+	struct perf_event *events[CVM_PMU_MAX_COUNTERS];
+	struct list_head entry;
+	struct hlist_node cpuhp_node;
+	cpumask_t active_mask;
+};
+
+static struct list_head cvm_pmu_lmcs;
+static struct list_head cvm_pmu_tlks;
+
+/*
+ * Common Cavium PMU stuff
+ *
+ * Shared properties of the different PMU types:
+ * - all counters are 64 bit long
+ * - there are no overflow interrupts
+ * - all devices with PMU counters appear as PCI devices
+ *
+ * Counter control, access and device association depends on the
+ * PMU type.
+ */
+
+#define to_pmu_dev(x) container_of((x), struct cvm_pmu_dev, pmu)
+
+static int cvm_pmu_event_init(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct cvm_pmu_dev *pmu_dev;
+	struct perf_event *sibling;
+
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	/* we do not support sampling */
+	if (is_sampling_event(event))
+		return -EINVAL;
+
+	/* PMU counters do not support any these bits */
+	if (event->attr.exclude_user	||
+	    event->attr.exclude_kernel	||
+	    event->attr.exclude_host	||
+	    event->attr.exclude_guest	||
+	    event->attr.exclude_hv	||
+	    event->attr.exclude_idle)
+		return -EINVAL;
+
+	pmu_dev = to_pmu_dev(event->pmu);
+	if (!pmu_dev->event_valid(event->attr.config))
+		return -EINVAL;
+
+	/*
+	 * Forbid groups containing mixed PMUs, software events are acceptable.
+	 */
+	if (event->group_leader->pmu != event->pmu &&
+	    !is_software_event(event->group_leader))
+		return -EINVAL;
+
+	list_for_each_entry(sibling, &event->group_leader->sibling_list,
+			    group_entry)
+		if (sibling->pmu != event->pmu &&
+		    !is_software_event(sibling))
+			return -EINVAL;
+
+	hwc->config = event->attr.config;
+	hwc->idx = -1;
+	return 0;
+}
+
+static void cvm_pmu_read(struct perf_event *event)
+{
+	struct cvm_pmu_dev *pmu_dev = to_pmu_dev(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	u64 prev, delta, new;
+
+again:
+	prev = local64_read(&hwc->prev_count);
+	new = readq(hwc->event_base + pmu_dev->map);
+
+	if (local64_cmpxchg(&hwc->prev_count, prev, new) != prev)
+		goto again;
+
+	delta = new - prev;
+	local64_add(delta, &event->count);
+}
+
+static void cvm_pmu_start(struct perf_event *event, int flags)
+{
+	struct cvm_pmu_dev *pmu_dev = to_pmu_dev(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	u64 new;
+
+	if (WARN_ON_ONCE(!(hwc->state & PERF_HES_STOPPED)))
+		return;
+
+	WARN_ON_ONCE(!(hwc->state & PERF_HES_UPTODATE));
+	hwc->state = 0;
+
+	/* update prev_count always in order support unstoppable counters */
+	new = readq(hwc->event_base + pmu_dev->map);
+	local64_set(&hwc->prev_count, new);
+
+	perf_event_update_userpage(event);
+}
+
+static void cvm_pmu_stop(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
+	hwc->state |= PERF_HES_STOPPED;
+
+	if ((flags & PERF_EF_UPDATE) && !(hwc->state & PERF_HES_UPTODATE)) {
+		cvm_pmu_read(event);
+		hwc->state |= PERF_HES_UPTODATE;
+	}
+}
+
+static int cvm_pmu_add(struct perf_event *event, int flags, u64 event_base)
+{
+	struct cvm_pmu_dev *pmu_dev = to_pmu_dev(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	int i;
+
+	for (i = 0; i < pmu_dev->num_counters; i++)
+		if (!cmpxchg(&pmu_dev->events[i], NULL, event)) {
+			hwc->idx = i;
+			break;
+		}
+
+	if (hwc->idx == -1)
+		return -EBUSY;
+
+	hwc->event_base = event_base;
+	hwc->state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
+
+	if (flags & PERF_EF_START)
+		pmu_dev->pmu.start(event, PERF_EF_RELOAD);
+
+	return 0;
+}
+
+static void cvm_pmu_del(struct perf_event *event, int flags)
+{
+	struct cvm_pmu_dev *pmu_dev = to_pmu_dev(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	event->pmu->stop(event, PERF_EF_UPDATE);
+
+	pmu_dev->events[hwc->idx] = NULL;
+	hwc->idx = -1;
+	perf_event_update_userpage(event);
+}
+
+static ssize_t cvm_pmu_event_sysfs_show(struct device *dev,
+					struct device_attribute *attr,
+					char *page)
+{
+	struct perf_pmu_events_attr *pmu_attr =
+		container_of(attr, struct perf_pmu_events_attr, attr);
+
+	if (pmu_attr->event_str)
+		return sprintf(page, "%s", pmu_attr->event_str);
+
+	return 0;
+}
+
+/*
+ * The pmu events are independent from CPUs. Provide a cpumask
+ * nevertheless to prevent perf from adding the event per-cpu and just
+ * set the mask to one online CPU. Use the same cpumask for all "uncore"
+ * devices.
+ *
+ * There is a performance penalty for accessing a device from a CPU on
+ * another socket, but we do not care.
+ */
+static int cvm_pmu_offline_cpu(unsigned int old_cpu, struct hlist_node *node)
+{
+	struct cvm_pmu_dev *pmu_dev;
+	int new_cpu;
+
+	pmu_dev = hlist_entry_safe(node, struct cvm_pmu_dev, cpuhp_node);
+	if (!cpumask_test_and_clear_cpu(old_cpu, &pmu_dev->active_mask))
+		return 0;
+
+	new_cpu = cpumask_any_but(cpu_online_mask, old_cpu);
+	if (new_cpu >= nr_cpu_ids)
+		return 0;
+
+	perf_pmu_migrate_context(&pmu_dev->pmu, old_cpu, new_cpu);
+	cpumask_set_cpu(new_cpu, &pmu_dev->active_mask);
+
+	return 0;
+}
+
+static ssize_t cvm_pmu_attr_show_cpumask(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct pmu *pmu = dev_get_drvdata(dev);
+	struct cvm_pmu_dev *pmu_dev = container_of(pmu, struct cvm_pmu_dev, pmu);
+
+	return cpumap_print_to_pagebuf(true, buf, &pmu_dev->active_mask);
+}
+
+static DEVICE_ATTR(cpumask, S_IRUGO, cvm_pmu_attr_show_cpumask, NULL);
+
+static struct attribute *cvm_pmu_attrs[] = {
+	&dev_attr_cpumask.attr,
+	NULL,
+};
+
+static struct attribute_group cvm_pmu_attr_group = {
+	.attrs = cvm_pmu_attrs,
+};
+
+/*
+ * LMC (memory controller) counters:
+ * - not stoppable, always on, read-only
+ * - one PCI device per memory controller
+ */
+#define LMC_CONFIG_OFFSET		0x188
+#define LMC_CONFIG_RESET_BIT		BIT(17)
+
+/* LMC events */
+#define LMC_EVENT_IFB_CNT		0x1d0
+#define LMC_EVENT_OPS_CNT		0x1d8
+#define LMC_EVENT_DCLK_CNT		0x1e0
+#define LMC_EVENT_BANK_CONFLICT1	0x360
+#define LMC_EVENT_BANK_CONFLICT2	0x368
+
+#define CVM_PMU_LMC_EVENT_ATTR(_name, _id)						\
+	&((struct perf_pmu_events_attr[]) {						\
+		{									\
+			__ATTR(_name, S_IRUGO, cvm_pmu_event_sysfs_show, NULL),		\
+			_id,								\
+			"lmc_event=" __stringify(_id),					\
+		}									\
+	})[0].attr.attr
+
+static int cvm_pmu_lmc_add(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	return cvm_pmu_add(event, flags, hwc->config);
+}
+
+PMU_FORMAT_ATTR(lmc_event, "config:0-9");
+
+static struct attribute *cvm_pmu_lmc_format_attr[] = {
+	&format_attr_lmc_event.attr,
+	NULL,
+};
+
+static struct attribute_group cvm_pmu_lmc_format_group = {
+	.name = "format",
+	.attrs = cvm_pmu_lmc_format_attr,
+};
+
+static struct attribute *cvm_pmu_lmc_events_attr[] = {
+	CVM_PMU_LMC_EVENT_ATTR(ifb_cnt,		0x1d0),
+	CVM_PMU_LMC_EVENT_ATTR(ops_cnt,		0x1d8),
+	CVM_PMU_LMC_EVENT_ATTR(dclk_cnt,	0x1e0),
+	CVM_PMU_LMC_EVENT_ATTR(bank_conflict1,	0x360),
+	CVM_PMU_LMC_EVENT_ATTR(bank_conflict2,	0x368),
+	NULL,
+};
+
+static struct attribute_group cvm_pmu_lmc_events_group = {
+	.name = "events",
+	.attrs = cvm_pmu_lmc_events_attr,
+};
+
+static const struct attribute_group *cvm_pmu_lmc_attr_groups[] = {
+	&cvm_pmu_attr_group,
+	&cvm_pmu_lmc_format_group,
+	&cvm_pmu_lmc_events_group,
+	NULL,
+};
+
+static bool cvm_pmu_lmc_event_valid(u64 config)
+{
+	struct perf_pmu_events_attr *attr;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(cvm_pmu_lmc_events_attr) -1; i++) {
+		attr = (struct perf_pmu_events_attr *)cvm_pmu_lmc_events_attr[i];
+		if (attr->id == config)
+			return true;
+	}
+	return false;
+}
+
+int cvm_lmc_pmu_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	struct cvm_pmu_dev *next, *lmc;
+	int nr = 0, ret = -ENOMEM;
+	char *name;
+
+	lmc = devm_kzalloc(&pdev->dev, sizeof(*lmc), GFP_KERNEL);
+	if (!lmc)
+		return -ENOMEM;
+
+	lmc->map = devm_ioremap(&pdev->dev, pci_resource_start(pdev, 0),
+				pci_resource_len(pdev, 0));
+	if (!lmc->map)
+		return -EINVAL;
+
+	list_for_each_entry(next, &cvm_pmu_lmcs, entry)
+		nr++;
+	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "lmc%d", nr);
+	if (!name)
+		return -ENOMEM;
+
+	lmc->pdev = pdev;
+	lmc->num_counters = ARRAY_SIZE(cvm_pmu_lmc_events_attr) - 1;
+	lmc->pmu = (struct pmu) {
+		.task_ctx_nr    = perf_invalid_context,
+		.name		= name,
+		.event_init	= cvm_pmu_event_init,
+		.add		= cvm_pmu_lmc_add,
+		.del		= cvm_pmu_del,
+		.start		= cvm_pmu_start,
+		.stop		= cvm_pmu_stop,
+		.read		= cvm_pmu_read,
+		.attr_groups	= cvm_pmu_lmc_attr_groups,
+	};
+
+	cpuhp_state_add_instance_nocalls(CPUHP_AP_PERF_ARM_CVM_ONLINE,
+					 &lmc->cpuhp_node);
+
+	/*
+	 * perf PMU is CPU dependent so pick a random CPU and migrate away
+	 * if it goes offline.
+	 */
+	cpumask_set_cpu(smp_processor_id(), &lmc->active_mask);
+
+	list_add(&lmc->entry, &cvm_pmu_lmcs);
+	lmc->event_valid = cvm_pmu_lmc_event_valid;
+
+	ret = perf_pmu_register(&lmc->pmu, name, -1);
+	if (ret)
+		goto fail_pmu;
+
+	dev_info(&pdev->dev, "Enabled %s PMU with %d counters\n",
+		 name, lmc->num_counters);
+	return 0;
+
+fail_pmu:
+	list_del(&lmc->entry);
+	cpuhp_state_remove_instance(CPUHP_AP_PERF_ARM_CVM_ONLINE,
+				    &lmc->cpuhp_node);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cvm_lmc_pmu_probe);
+
+void cvm_lmc_pmu_remove(struct pci_dev *pdev)
+{
+	struct list_head *l, *tmp;
+	struct cvm_pmu_dev *lmc;
+
+	list_for_each_safe(l, tmp, &cvm_pmu_lmcs) {
+		lmc = list_entry(l, struct cvm_pmu_dev, entry);
+		if (pdev != lmc->pdev)
+			continue;
+
+		perf_pmu_unregister(&lmc->pmu);
+		cpuhp_state_remove_instance(CPUHP_AP_PERF_ARM_CVM_ONLINE,
+					    &lmc->cpuhp_node);
+		list_del(&lmc->entry);
+	}
+}
+EXPORT_SYMBOL_GPL(cvm_lmc_pmu_remove);
+
+static int __init cvm_pmu_init(void)
+{
+	INIT_LIST_HEAD(&cvm_pmu_lmcs);
+	INIT_LIST_HEAD(&cvm_pmu_tlks);
+
+	return cpuhp_setup_state_multi(CPUHP_AP_PERF_ARM_CVM_ONLINE,
+				       "perf/arm/cvm:online", NULL,
+				       cvm_pmu_offline_cpu);
+}
+
+static void __exit cvm_pmu_exit(void)
+{
+	cpuhp_remove_multi_state(CPUHP_AP_PERF_ARM_CVM_ONLINE);
+}
+
+module_init(cvm_pmu_init);
+module_exit(cvm_pmu_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Cavium, Inc.");
+MODULE_DESCRIPTION("PMU Driver for Cavium ThunderX SOC");
diff --git a/drivers/soc/cavium/cavium_lmc.c b/drivers/soc/cavium/cavium_lmc.c
index 87248e83c55b..d21d59c24321 100644
--- a/drivers/soc/cavium/cavium_lmc.c
+++ b/drivers/soc/cavium/cavium_lmc.c
@@ -17,6 +17,8 @@
 static int cvm_lmc_probe(struct pci_dev *pdev,
 			 const struct pci_device_id *ent)
 {
+	if (IS_ENABLED(CONFIG_CAVIUM_PMU_LMC))
+		cvm_lmc_pmu_probe(pdev, ent);
 	if (IS_ENABLED(CONFIG_EDAC_THUNDERX))
 		thunderx_edac_lmc_probe(pdev, ent);
 	return 0;
@@ -24,6 +26,8 @@ static int cvm_lmc_probe(struct pci_dev *pdev,
 
 static void cvm_lmc_remove(struct pci_dev *pdev)
 {
+	if (IS_ENABLED(CONFIG_CAVIUM_PMU_LMC))
+		cvm_lmc_pmu_remove(pdev);
 	if (IS_ENABLED(CONFIG_EDAC_THUNDERX))
 		thunderx_edac_lmc_remove(pdev);
 }
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index f24bfb2b9a2d..3362c158fe5c 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -134,6 +134,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_S390_SF_ONLINE,
 	CPUHP_AP_PERF_ARM_CCI_ONLINE,
 	CPUHP_AP_PERF_ARM_CCN_ONLINE,
+	CPUHP_AP_PERF_ARM_CVM_ONLINE,
 	CPUHP_AP_PERF_ARM_L2X0_ONLINE,
 	CPUHP_AP_PERF_ARM_QCOM_L2_ONLINE,
 	CPUHP_AP_PERF_ARM_QCOM_L3_ONLINE,
diff --git a/include/linux/soc/cavium/lmc.h b/include/linux/soc/cavium/lmc.h
index 336f467e154f..e5ad6507fd36 100644
--- a/include/linux/soc/cavium/lmc.h
+++ b/include/linux/soc/cavium/lmc.h
@@ -3,6 +3,9 @@
 
 #include <linux/pci.h>
 
+int cvm_lmc_pmu_probe(struct pci_dev *pdev, const struct pci_device_id *ent);
+void cvm_lmc_pmu_remove(struct pci_dev *pdev);
+
 int thunderx_edac_lmc_probe(struct pci_dev *pdev, const struct pci_device_id *ent);
 void thunderx_edac_lmc_remove(struct pci_dev *pdev);
 
-- 
2.9.0.rc0.21.g7777322
