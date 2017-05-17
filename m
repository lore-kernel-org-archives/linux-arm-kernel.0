From: jglauber@cavium.com (Jan Glauber)
Date: Wed, 17 May 2017 10:31:21 +0200
Subject: [PATCH v5 2/3] perf: cavium: Support memory controller PMU counters
In-Reply-To: <20170517083122.5050-1-jglauber@cavium.com>
References: <20170517083122.5050-1-jglauber@cavium.com>
Message-ID: <20170517083122.5050-3-jglauber@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the PMU counters on Cavium SOC memory controllers.

This patch also adds generic functions to allow supporting more
devices with PMU counters.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/edac/thunderx_edac.c    |  12 +-
 drivers/perf/Kconfig            |   8 +
 drivers/perf/Makefile           |   1 +
 drivers/perf/cavium_pmu.c       | 408 ++++++++++++++++++++++++++++++++++++++++
 include/linux/cpuhotplug.h      |   1 +
 include/linux/perf/cavium_pmu.h |  34 ++++
 6 files changed, 463 insertions(+), 1 deletion(-)
 create mode 100644 drivers/perf/cavium_pmu.c
 create mode 100644 include/linux/perf/cavium_pmu.h

diff --git a/drivers/edac/thunderx_edac.c b/drivers/edac/thunderx_edac.c
index 86d585c..8de4faf 100644
--- a/drivers/edac/thunderx_edac.c
+++ b/drivers/edac/thunderx_edac.c
@@ -20,7 +20,7 @@
 #include <linux/atomic.h>
 #include <linux/bitfield.h>
 #include <linux/circ_buf.h>
-
+#include <linux/perf/cavium_pmu.h>
 #include <asm/page.h>
 
 #include "edac_module.h"
@@ -209,6 +209,8 @@ struct thunderx_lmc {
 	struct lmc_err_ctx err_ctx[RING_ENTRIES];
 	unsigned long ring_head;
 	unsigned long ring_tail;
+
+	void *pmu_data;
 };
 
 #define ring_pos(pos, size) ((pos) & (size - 1))
@@ -810,6 +812,9 @@ static int thunderx_lmc_probe(struct pci_dev *pdev,
 		}
 	}
 
+	if (IS_ENABLED(CONFIG_CAVIUM_PMU))
+		lmc->pmu_data = cvm_pmu_probe(pdev, lmc->regs, CVM_PMU_LMC);
+
 	return 0;
 
 err_free:
@@ -824,6 +829,9 @@ static void thunderx_lmc_remove(struct pci_dev *pdev)
 	struct mem_ctl_info *mci = pci_get_drvdata(pdev);
 	struct thunderx_lmc *lmc = mci->pvt_info;
 
+	if (IS_ENABLED(CONFIG_CAVIUM_PMU))
+		cvm_pmu_remove(pdev, lmc->pmu_data, CVM_PMU_LMC);
+
 	writeq(LMC_INT_ENA_ALL, lmc->regs + LMC_INT_ENA_W1C);
 
 	edac_mc_del_mc(&pdev->dev);
@@ -1089,6 +1097,8 @@ struct thunderx_ocx {
 
 	unsigned long link_ring_head;
 	unsigned long link_ring_tail;
+
+	void *pmu_data;
 };
 
 #define OCX_MESSAGE_SIZE	SZ_1K
diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index aa587ed..984a1b9 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -42,4 +42,12 @@ config XGENE_PMU
         help
           Say y if you want to use APM X-Gene SoC performance monitors.
 
+config CAVIUM_PMU
+	tristate "Cavium ThunderX PMU"
+	depends on ARCH_THUNDER && PCI && EDAC_THUNDERX && PERF_EVENTS
+	help
+	  Provides access to various performance counters on Caviums
+	  ARM64 SOCs. Adds support for memory controller (LMC) and
+	  interconnect link (OCX TLK) counters.
+
 endmenu
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index 6420bd4..b304646 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -3,3 +3,4 @@ obj-$(CONFIG_ARM_PMU_ACPI) += arm_pmu_acpi.o
 obj-$(CONFIG_QCOM_L2_PMU)	+= qcom_l2_pmu.o
 obj-$(CONFIG_QCOM_L3_PMU) += qcom_l3_pmu.o
 obj-$(CONFIG_XGENE_PMU) += xgene_pmu.o
+obj-$(CONFIG_CAVIUM_PMU) += cavium_pmu.o
diff --git a/drivers/perf/cavium_pmu.c b/drivers/perf/cavium_pmu.c
new file mode 100644
index 0000000..9881dc8
--- /dev/null
+++ b/drivers/perf/cavium_pmu.c
@@ -0,0 +1,408 @@
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
+#include <linux/cpumask.h>
+#include <linux/export.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pci.h>
+#include <linux/perf_event.h>
+#include <linux/slab.h>
+
+#include <linux/perf/cavium_pmu.h>
+
+struct list_head cvm_pmu_lmcs;
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
+	if (!pmu_dev)
+		return -ENODEV;
+	if (!pmu_dev->event_valid(event->attr.config))
+		return -EINVAL;
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
+	new = readq(hwc->event_base + pmu_dev->map);
+
+	prev = local64_read(&hwc->prev_count);
+	local64_set(&hwc->prev_count, new);
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
+static int cvm_pmu_add(struct perf_event *event, int flags, u64 config_base,
+		       u64 event_base)
+{
+	struct cvm_pmu_dev *pmu_dev = to_pmu_dev(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (!cmpxchg(&pmu_dev->events[hwc->config], NULL, event))
+		hwc->idx = hwc->config;
+
+	if (hwc->idx == -1)
+		return -EBUSY;
+
+	hwc->config_base = config_base;
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
+	int i;
+
+	event->pmu->stop(event, PERF_EF_UPDATE);
+
+	/*
+	 * For programmable counters we need to check where we installed it.
+	 * To keep this function generic always test the more complicated
+	 * case (free running counters won't need the loop).
+	 */
+	for (i = 0; i < pmu_dev->num_counters; i++)
+		if (cmpxchg(&pmu_dev->events[i], event, NULL) == event)
+			break;
+
+	perf_event_update_userpage(event);
+	hwc->idx = -1;
+}
+
+ssize_t cvm_pmu_event_sysfs_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *page)
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
+	perf_pmu_migrate_context(&pmu_dev->pmu, old_cpu, new_cpu);
+	cpumask_set_cpu(new_cpu, &pmu_dev->active_mask);
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
+struct attribute_group cvm_pmu_attr_group = {
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
+			0,								\
+			"lmc_event=" __stringify(_id),					\
+		}									\
+	})[0].attr.attr
+
+/* map counter numbers to register offsets */
+static int lmc_events[] = {
+	LMC_EVENT_IFB_CNT,
+	LMC_EVENT_OPS_CNT,
+	LMC_EVENT_DCLK_CNT,
+	LMC_EVENT_BANK_CONFLICT1,
+	LMC_EVENT_BANK_CONFLICT2,
+};
+
+static int cvm_pmu_lmc_add(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	return cvm_pmu_add(event, flags, LMC_CONFIG_OFFSET,
+			   lmc_events[hwc->config]);
+}
+
+PMU_FORMAT_ATTR(lmc_event, "config:0-2");
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
+	CVM_PMU_LMC_EVENT_ATTR(ifb_cnt,		0),
+	CVM_PMU_LMC_EVENT_ATTR(ops_cnt,		1),
+	CVM_PMU_LMC_EVENT_ATTR(dclk_cnt,	2),
+	CVM_PMU_LMC_EVENT_ATTR(bank_conflict1,	3),
+	CVM_PMU_LMC_EVENT_ATTR(bank_conflict2,	4),
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
+	if (config < ARRAY_SIZE(lmc_events))
+		return true;
+	return false;
+}
+
+static void *cvm_pmu_lmc_probe(struct pci_dev *pdev, void __iomem *regs)
+{
+	struct cvm_pmu_dev *next, *lmc;
+	int nr = 0, ret = -ENOMEM;
+	char name[8];
+
+	lmc = kzalloc(sizeof(*lmc), GFP_KERNEL);
+	if (!lmc)
+		goto fail_nomem;
+
+	list_for_each_entry(next, &cvm_pmu_lmcs, entry)
+		nr++;
+	memset(name, 0, 8);
+	snprintf(name, 8, "lmc%d", nr);
+
+	list_add(&lmc->entry, &cvm_pmu_lmcs);
+
+	lmc->pdev = pdev;
+	lmc->map = regs;
+	lmc->num_counters = ARRAY_SIZE(lmc_events);
+	lmc->pmu = (struct pmu) {
+		.name		= name,
+		.task_ctx_nr    = perf_invalid_context,
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
+	ret = perf_pmu_register(&lmc->pmu, lmc->pmu.name, -1);
+	if (ret)
+		goto fail_hp;
+
+	lmc->event_valid = cvm_pmu_lmc_event_valid;
+	dev_info(&pdev->dev, "Enabled %s PMU with %d counters\n",
+		 lmc->pmu.name, lmc->num_counters);
+	return lmc;
+
+fail_hp:
+	cpuhp_state_remove_instance(CPUHP_AP_PERF_ARM_CVM_ONLINE,
+				    &lmc->cpuhp_node);
+	kfree(lmc);
+fail_nomem:
+	return ERR_PTR(ret);
+}
+
+static void cvm_pmu_lmc_remove(struct pci_dev *pdev, void *pmu_data)
+{
+	struct cvm_pmu_dev *lmc = (struct cvm_pmu_dev *) pmu_data;
+
+	cpuhp_state_remove_instance(CPUHP_AP_PERF_ARM_CVM_ONLINE,
+				    &lmc->cpuhp_node);
+	list_del(&lmc->entry);
+	perf_pmu_unregister(&lmc->pmu);
+	kfree(lmc);
+}
+
+void *cvm_pmu_probe(struct pci_dev *pdev, void __iomem *regs, int type)
+{
+	switch (type) {
+	case CVM_PMU_LMC:
+		return cvm_pmu_lmc_probe(pdev, regs);
+	}
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(cvm_pmu_probe);
+
+void cvm_pmu_remove(struct pci_dev *pdev, void *pmu_data, int type)
+{
+	switch (type) {
+	case CVM_PMU_LMC:
+		return cvm_pmu_lmc_remove(pdev, pmu_data);
+	}
+}
+EXPORT_SYMBOL_GPL(cvm_pmu_remove);
+
+static int __init cvm_pmu_init(void)
+{
+	INIT_LIST_HEAD(&cvm_pmu_lmcs);
+
+	return cpuhp_setup_state_multi(CPUHP_AP_PERF_ARM_CVM_ONLINE,
+				       "perf/arm/cvm:online", NULL,
+				       cvm_pmu_offline_cpu);
+}
+
+static void __exit cvm_pmu_exit(void)
+{
+	if (list_empty(&cvm_pmu_lmcs))
+		cpuhp_remove_state(CPUHP_AP_PERF_ARM_CVM_ONLINE);
+}
+
+module_init(cvm_pmu_init);
+module_exit(cvm_pmu_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Cavium PMU support");
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 0f2a803..2fe906c 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -141,6 +141,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_ARM_QCOM_L3_ONLINE,
 	CPUHP_AP_WORKQUEUE_ONLINE,
 	CPUHP_AP_RCUTREE_ONLINE,
+	CPUHP_AP_PERF_ARM_CVM_ONLINE,
 	CPUHP_AP_ONLINE_DYN,
 	CPUHP_AP_ONLINE_DYN_END		= CPUHP_AP_ONLINE_DYN + 30,
 	CPUHP_AP_X86_HPET_ONLINE,
diff --git a/include/linux/perf/cavium_pmu.h b/include/linux/perf/cavium_pmu.h
new file mode 100644
index 0000000..7b13346
--- /dev/null
+++ b/include/linux/perf/cavium_pmu.h
@@ -0,0 +1,34 @@
+#ifndef _CAVIUM_PMU_H
+#define _CAVIUM_PMU_H
+
+#include <linux/cpumask.h>
+#include <linux/io.h>
+#include <linux/list.h>
+#include <linux/pci.h>
+#include <linux/perf_event.h>
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
+/* PMU interface used by EDAC driver */
+void *cvm_pmu_probe(struct pci_dev *pdev, void __iomem *regs, int type);
+void cvm_pmu_remove(struct pci_dev *pdev, void *pmu_data, int type);
+
+#endif
-- 
2.9.0.rc0.21.g7777322
