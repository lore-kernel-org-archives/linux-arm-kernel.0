From: jglauber@cavium.com (Jan Glauber)
Date: Thu, 20 Oct 2016 11:30:37 +0200
Subject: [PATCH v3 1/5] arm64: perf: Basic uncore counter support for Cavium
 ThunderX SOC
In-Reply-To: <1476955841-27898-1-git-send-email-jglauber@cavium.com>
References: <1476955841-27898-1-git-send-email-jglauber@cavium.com>
Message-ID: <1476955841-27898-2-git-send-email-jglauber@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide "uncore" facilities for different non-CPU performance
counter units.

The uncore PMUs can be found under /sys/bus/event_source/devices.
All counters are exported via sysfs in the corresponding events
files under the PMU directory so the perf tool can list the event names.

There are some points that are special in this implementation:

1) The PMU detection relies on PCI device detection. If a
   matching PCI device is found the PMU is created. The code can deal
   with multiple units of the same type, e.g. more than one memory
   controller.

2) Counters are summarized across different units of the same type
   on one NUMA node but not across NUMA nodes.
   For instance L2C TAD 0..7 are presented as a single counter
   (adding the values from TAD 0 to 7). Although losing the ability
   to read a single value the merged values are easier to use.

3) The counters are not CPU related. A random CPU is picked regardless
   of the NUMA node. There is a small performance penalty for accessing
   counters on a remote note but reading a performance counter is a
   slow operation anyway.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/perf/Kconfig                |  13 ++
 drivers/perf/Makefile               |   1 +
 drivers/perf/uncore/Makefile        |   1 +
 drivers/perf/uncore/uncore_cavium.c | 351 ++++++++++++++++++++++++++++++++++++
 drivers/perf/uncore/uncore_cavium.h |  71 ++++++++
 include/linux/cpuhotplug.h          |   1 +
 6 files changed, 438 insertions(+)
 create mode 100644 drivers/perf/uncore/Makefile
 create mode 100644 drivers/perf/uncore/uncore_cavium.c
 create mode 100644 drivers/perf/uncore/uncore_cavium.h

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 4d5c5f9..3266c87 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -19,4 +19,17 @@ config XGENE_PMU
         help
           Say y if you want to use APM X-Gene SoC performance monitors.
 
+config UNCORE_PMU
+	bool
+
+config UNCORE_PMU_CAVIUM
+	depends on PERF_EVENTS && NUMA && ARM64
+	bool "Cavium uncore PMU support"
+	select UNCORE_PMU
+	default y
+	help
+	  Say y if you want to access performance counters of subsystems
+	  on a Cavium SOC like cache controller, memory controller or
+	  processor interconnect.
+
 endmenu
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index b116e98..144374b 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_ARM_PMU) += arm_pmu.o
+obj-y += uncore/
 obj-$(CONFIG_XGENE_PMU) += xgene_pmu.o
diff --git a/drivers/perf/uncore/Makefile b/drivers/perf/uncore/Makefile
new file mode 100644
index 0000000..6130e18
--- /dev/null
+++ b/drivers/perf/uncore/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_UNCORE_PMU_CAVIUM) += uncore_cavium.o
diff --git a/drivers/perf/uncore/uncore_cavium.c b/drivers/perf/uncore/uncore_cavium.c
new file mode 100644
index 0000000..a7b4277
--- /dev/null
+++ b/drivers/perf/uncore/uncore_cavium.c
@@ -0,0 +1,351 @@
+/*
+ * Cavium Thunder uncore PMU support.
+ *
+ * Copyright (C) 2015,2016 Cavium Inc.
+ * Author: Jan Glauber <jan.glauber@cavium.com>
+ */
+
+#include <linux/cpufeature.h>
+#include <linux/numa.h>
+#include <linux/slab.h>
+
+#include "uncore_cavium.h"
+
+/*
+ * Some notes about the various counters supported by this "uncore" PMU
+ * and the design:
+ *
+ * All counters are 64 bit long.
+ * There are no overflow interrupts.
+ * Counters are summarized per node/socket.
+ * Most devices appear as separate PCI devices per socket with the exception
+ * of OCX TLK which appears as one PCI device per socket and contains several
+ * units with counters that are merged.
+ * Some counters are selected via a control register (L2C TAD) and read by
+ * a number of counter registers, others (L2C CBC, LMC & OCX TLK) have
+ * one dedicated counter per event.
+ * Some counters are not stoppable (L2C CBC & LMC).
+ * Some counters are read-only (LMC).
+ * All counters belong to PCI devices, the devices may have additional
+ * drivers but we assume we are the only user of the counter registers.
+ * We map the whole PCI BAR so we must be careful to forbid access to
+ * addresses that contain neither counters nor counter control registers.
+ */
+
+void thunder_uncore_read(struct perf_event *event)
+{
+	struct thunder_uncore *uncore = to_uncore(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	struct thunder_uncore_node *node;
+	struct thunder_uncore_unit *unit;
+	u64 prev, delta, new = 0;
+
+	node = get_node(hwc->config, uncore);
+
+	/* read counter values from all units on the node */
+	list_for_each_entry(unit, &node->unit_list, entry)
+		new += readq(hwc->event_base + unit->map);
+
+	prev = local64_read(&hwc->prev_count);
+	local64_set(&hwc->prev_count, new);
+	delta = new - prev;
+	local64_add(delta, &event->count);
+}
+
+int thunder_uncore_add(struct perf_event *event, int flags, u64 config_base,
+		       u64 event_base)
+{
+	struct thunder_uncore *uncore = to_uncore(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	struct thunder_uncore_node *node;
+	int id;
+
+	node = get_node(hwc->config, uncore);
+	id = get_id(hwc->config);
+
+	if (!cmpxchg(&node->events[id], NULL, event))
+		hwc->idx = id;
+
+	if (hwc->idx == -1)
+		return -EBUSY;
+
+	hwc->config_base = config_base;
+	hwc->event_base = event_base;
+	hwc->state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
+
+	if (flags & PERF_EF_START)
+		uncore->pmu.start(event, PERF_EF_RELOAD);
+
+	return 0;
+}
+
+void thunder_uncore_del(struct perf_event *event, int flags)
+{
+	struct thunder_uncore *uncore = to_uncore(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	struct thunder_uncore_node *node;
+	int i;
+
+	event->pmu->stop(event, PERF_EF_UPDATE);
+
+	/*
+	 * For programmable counters we need to check where we installed it.
+	 * To keep this function generic always test the more complicated
+	 * case (free running counters won't need the loop).
+	 */
+	node = get_node(hwc->config, uncore);
+	for (i = 0; i < node->num_counters; i++) {
+		if (cmpxchg(&node->events[i], event, NULL) == event)
+			break;
+	}
+	hwc->idx = -1;
+}
+
+void thunder_uncore_start(struct perf_event *event, int flags)
+{
+	struct thunder_uncore *uncore = to_uncore(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	struct thunder_uncore_node *node;
+	struct thunder_uncore_unit *unit;
+	u64 new = 0;
+
+	/* read counter values from all units on the node */
+	node = get_node(hwc->config, uncore);
+	list_for_each_entry(unit, &node->unit_list, entry)
+		new += readq(hwc->event_base + unit->map);
+	local64_set(&hwc->prev_count, new);
+
+	hwc->state = 0;
+	perf_event_update_userpage(event);
+}
+
+void thunder_uncore_stop(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	hwc->state |= PERF_HES_STOPPED;
+
+	if ((flags & PERF_EF_UPDATE) && !(hwc->state & PERF_HES_UPTODATE)) {
+		thunder_uncore_read(event);
+		hwc->state |= PERF_HES_UPTODATE;
+	}
+}
+
+int thunder_uncore_event_init(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct thunder_uncore_node *node;
+	struct thunder_uncore *uncore;
+
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	/* we do not support sampling */
+	if (is_sampling_event(event))
+		return -EINVAL;
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
+	uncore = to_uncore(event->pmu);
+	if (!uncore)
+		return -ENODEV;
+	if (!uncore->event_valid(event->attr.config & UNCORE_EVENT_ID_MASK))
+		return -EINVAL;
+
+	/* check NUMA node */
+	node = get_node(event->attr.config, uncore);
+	if (!node) {
+		pr_debug("Invalid NUMA node selected\n");
+		return -EINVAL;
+	}
+
+	hwc->config = event->attr.config;
+	hwc->idx = -1;
+	return 0;
+}
+
+static ssize_t thunder_uncore_attr_show_cpumask(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	struct pmu *pmu = dev_get_drvdata(dev);
+	struct thunder_uncore *uncore =
+		container_of(pmu, struct thunder_uncore, pmu);
+
+	return cpumap_print_to_pagebuf(true, buf, &uncore->active_mask);
+}
+static DEVICE_ATTR(cpumask, S_IRUGO, thunder_uncore_attr_show_cpumask, NULL);
+
+static struct attribute *thunder_uncore_attrs[] = {
+	&dev_attr_cpumask.attr,
+	NULL,
+};
+
+struct attribute_group thunder_uncore_attr_group = {
+	.attrs = thunder_uncore_attrs,
+};
+
+ssize_t thunder_events_sysfs_show(struct device *dev,
+				  struct device_attribute *attr,
+				  char *page)
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
+/* node attribute depending on number of NUMA nodes */
+static ssize_t node_show(struct device *dev, struct device_attribute *attr,
+			 char *page)
+{
+	if (NODES_SHIFT)
+		return sprintf(page, "config:16-%d\n", 16 + NODES_SHIFT - 1);
+	else
+		return sprintf(page, "config:16\n");
+}
+
+struct device_attribute format_attr_node = __ATTR_RO(node);
+
+/*
+ * Thunder uncore events are independent from CPUs. Provide a cpumask
+ * nevertheless to prevent perf from adding the event per-cpu and just
+ * set the mask to one online CPU. Use the same cpumask for all uncore
+ * devices.
+ *
+ * There is a performance penalty for accessing a device from a CPU on
+ * another socket, but we do not care (yet).
+ */
+static int thunder_uncore_offline_cpu(unsigned int old_cpu, struct hlist_node *node)
+{
+	struct thunder_uncore *uncore = hlist_entry_safe(node, struct thunder_uncore, node);
+	int new_cpu;
+
+	if (!cpumask_test_and_clear_cpu(old_cpu, &uncore->active_mask))
+		return 0;
+	new_cpu = cpumask_any_but(cpu_online_mask, old_cpu);
+	if (new_cpu >= nr_cpu_ids)
+		return 0;
+	perf_pmu_migrate_context(&uncore->pmu, old_cpu, new_cpu);
+	cpumask_set_cpu(new_cpu, &uncore->active_mask);
+	return 0;
+}
+
+static struct thunder_uncore_node * __init alloc_node(struct thunder_uncore *uncore,
+						      int node_id, int counters)
+{
+	struct thunder_uncore_node *node;
+
+	node = kzalloc(sizeof(*node), GFP_KERNEL);
+	if (!node)
+		return NULL;
+	node->num_counters = counters;
+	INIT_LIST_HEAD(&node->unit_list);
+	return node;
+}
+
+int __init thunder_uncore_setup(struct thunder_uncore *uncore, int device_id,
+				struct pmu *pmu, int counters)
+{
+	unsigned int vendor_id = PCI_VENDOR_ID_CAVIUM;
+	struct thunder_uncore_unit  *unit, *tmp;
+	struct thunder_uncore_node *node;
+	struct pci_dev *pdev = NULL;
+	int ret, node_id, found = 0;
+
+	/* detect PCI devices */
+	while ((pdev = pci_get_device(vendor_id, device_id, pdev))) {
+		if (!pdev)
+			break;
+
+		node_id = dev_to_node(&pdev->dev);
+
+		/* allocate node if necessary */
+		if (!uncore->nodes[node_id])
+			uncore->nodes[node_id] = alloc_node(uncore, node_id, counters);
+
+		node = uncore->nodes[node_id];
+		if (!node) {
+			ret = -ENOMEM;
+			goto fail;
+		}
+
+		unit = kzalloc(sizeof(*unit), GFP_KERNEL);
+		if (!unit) {
+			ret = -ENOMEM;
+			goto fail;
+		}
+
+		unit->pdev = pdev;
+		unit->map = ioremap(pci_resource_start(pdev, 0),
+				    pci_resource_len(pdev, 0));
+		list_add(&unit->entry, &node->unit_list);
+		node->nr_units++;
+		found++;
+	}
+
+	if (!found)
+		return -ENODEV;
+
+	cpuhp_state_add_instance_nocalls(CPUHP_AP_UNCORE_CAVIUM_ONLINE,
+                                         &uncore->node);
+
+	/*
+	 * perf PMU is CPU dependent in difference to our uncore devices.
+	 * Just pick a CPU and migrate away if it goes offline.
+	 */
+	cpumask_set_cpu(smp_processor_id(), &uncore->active_mask);
+
+	uncore->pmu = *pmu;
+	ret = perf_pmu_register(&uncore->pmu, uncore->pmu.name, -1);
+	if (ret)
+		goto fail;
+
+	return 0;
+
+fail:
+	node_id = 0;
+	while (uncore->nodes[node_id]) {
+		node = uncore->nodes[node_id];
+
+		list_for_each_entry_safe(unit, tmp, &node->unit_list, entry) {
+			if (unit->pdev) {
+				if (unit->map)
+					iounmap(unit->map);
+				pci_dev_put(unit->pdev);
+			}
+			kfree(unit);
+		}
+		kfree(uncore->nodes[node_id]);
+		node_id++;
+	}
+	return ret;
+}
+
+static int __init thunder_uncore_init(void)
+{
+	unsigned long implementor = read_cpuid_implementor();
+	int ret;
+
+	if (implementor != ARM_CPU_IMP_CAVIUM)
+		return -ENODEV;
+
+	ret = cpuhp_setup_state_multi(CPUHP_AP_UNCORE_CAVIUM_ONLINE,
+				      "AP_PERF_UNCORE_CAVIUM_ONLINE", NULL,
+				      thunder_uncore_offline_cpu);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+late_initcall(thunder_uncore_init);
diff --git a/drivers/perf/uncore/uncore_cavium.h b/drivers/perf/uncore/uncore_cavium.h
new file mode 100644
index 0000000..b5d64b5
--- /dev/null
+++ b/drivers/perf/uncore/uncore_cavium.h
@@ -0,0 +1,71 @@
+#include <linux/io.h>
+#include <linux/list.h>
+#include <linux/pci.h>
+#include <linux/perf_event.h>
+
+#undef pr_fmt
+#define pr_fmt(fmt)     "thunderx_uncore: " fmt
+
+#define to_uncore(x) container_of((x), struct thunder_uncore, pmu)
+
+#define UNCORE_EVENT_ID_MASK		0xffff
+#define UNCORE_EVENT_ID_SHIFT		16
+
+/* maximum number of parallel hardware counters for all uncore parts */
+#define MAX_COUNTERS			64
+
+struct thunder_uncore_unit {
+	struct list_head entry;
+	void __iomem *map;
+	struct pci_dev *pdev;
+};
+
+struct thunder_uncore_node {
+	int nr_units;
+	int num_counters;
+	struct list_head unit_list;
+	struct perf_event *events[MAX_COUNTERS];
+};
+
+/* generic uncore struct for different pmu types */
+struct thunder_uncore {
+	struct pmu pmu;
+	bool (*event_valid)(u64);
+	struct hlist_node node;
+	struct thunder_uncore_node *nodes[MAX_NUMNODES];
+	cpumask_t active_mask;
+};
+
+#define UC_EVENT_ENTRY(_name, _id)							\
+	&((struct perf_pmu_events_attr[]) {						\
+		{									\
+			__ATTR(_name, S_IRUGO, thunder_events_sysfs_show, NULL),	\
+			0,								\
+			"event=" __stringify(_id),					\
+		}									\
+	})[0].attr.attr
+
+static inline struct thunder_uncore_node *get_node(u64 config,
+				   struct thunder_uncore *uncore)
+{
+	return uncore->nodes[config >> UNCORE_EVENT_ID_SHIFT];
+}
+
+#define get_id(config) (config & UNCORE_EVENT_ID_MASK)
+
+extern struct attribute_group thunder_uncore_attr_group;
+extern struct device_attribute format_attr_node;
+
+/* Prototypes */
+void thunder_uncore_read(struct perf_event *event);
+int thunder_uncore_add(struct perf_event *event, int flags, u64 config_base,
+		       u64 event_base);
+void thunder_uncore_del(struct perf_event *event, int flags);
+void thunder_uncore_start(struct perf_event *event, int flags);
+void thunder_uncore_stop(struct perf_event *event, int flags);
+int thunder_uncore_event_init(struct perf_event *event);
+int thunder_uncore_setup(struct thunder_uncore *uncore, int id,
+			 struct pmu *pmu, int counters);
+ssize_t thunder_events_sysfs_show(struct device *dev,
+				  struct device_attribute *attr,
+				  char *page);
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 9b207a8..370a7a2 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -117,6 +117,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_ARM_CCI_ONLINE,
 	CPUHP_AP_PERF_ARM_CCN_ONLINE,
 	CPUHP_AP_PERF_ARM_L2X0_ONLINE,
+	CPUHP_AP_UNCORE_CAVIUM_ONLINE,
 	CPUHP_AP_WORKQUEUE_ONLINE,
 	CPUHP_AP_RCUTREE_ONLINE,
 	CPUHP_AP_NOTIFY_ONLINE,
-- 
1.9.1
