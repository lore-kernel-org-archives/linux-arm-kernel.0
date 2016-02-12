From: jglauber@cavium.com (Jan Glauber)
Date: Fri, 12 Feb 2016 17:55:06 +0100
Subject: [RFC PATCH 1/7] arm64/perf: Basic uncore counter support for Cavium
 ThunderX
In-Reply-To: <cover.1455295032.git.jglauber@cavium.com>
References: <cover.1455295032.git.jglauber@cavium.com>
Message-ID: <8bd93a25e069ed6428bc6c21fc53270962ccafcc.1455295032.git.jglauber@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide uncore facilities for non-CPU performance counter units.
Based on Intel/AMD uncore pmu support.

The uncore PMUs can be found under /sys/bus/event_source/devices.
All counters are exported via sysfs in the corresponding events
files under the PMU directory so the perf tool can list the event names.

There are 2 points that are special in this implementation:

1) The PMU detection solely relies on PCI device detection. If a
   matching PCI device is found the PMU is created. The code can deal
   with multiple units of the same type, e.g. more than one memory
   controller.

2) Counters are summarized across the different units of the same type,
   e.g. L2C TAD 0..7 is presented as a single counter (adding the
   values from TAD 0 to 7). Although losing the ability to read a
   single value the merged values are easier to use and yield
   enough information.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 arch/arm64/kernel/Makefile               |   1 +
 arch/arm64/kernel/uncore/Makefile        |   1 +
 arch/arm64/kernel/uncore/uncore_cavium.c | 210 +++++++++++++++++++++++++++++++
 arch/arm64/kernel/uncore/uncore_cavium.h |  73 +++++++++++
 4 files changed, 285 insertions(+)
 create mode 100644 arch/arm64/kernel/uncore/Makefile
 create mode 100644 arch/arm64/kernel/uncore/uncore_cavium.c
 create mode 100644 arch/arm64/kernel/uncore/uncore_cavium.h

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 83cd7e6..c2d2810 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -42,6 +42,7 @@ arm64-obj-$(CONFIG_PCI)			+= pci.o
 arm64-obj-$(CONFIG_ARMV8_DEPRECATED)	+= armv8_deprecated.o
 arm64-obj-$(CONFIG_ACPI)		+= acpi.o
 arm64-obj-$(CONFIG_PARAVIRT)		+= paravirt.o
+arm64-obj-$(CONFIG_ARCH_THUNDER)	+= uncore/
 
 obj-y					+= $(arm64-obj-y) vdso/
 obj-m					+= $(arm64-obj-m)
diff --git a/arch/arm64/kernel/uncore/Makefile b/arch/arm64/kernel/uncore/Makefile
new file mode 100644
index 0000000..b9c72c2
--- /dev/null
+++ b/arch/arm64/kernel/uncore/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_ARCH_THUNDER) += uncore_cavium.o
diff --git a/arch/arm64/kernel/uncore/uncore_cavium.c b/arch/arm64/kernel/uncore/uncore_cavium.c
new file mode 100644
index 0000000..0cfcc83
--- /dev/null
+++ b/arch/arm64/kernel/uncore/uncore_cavium.c
@@ -0,0 +1,210 @@
+/*
+ * Cavium Thunder uncore PMU support. Derived from Intel and AMD uncore code.
+ *
+ * Copyright (C) 2015,2016 Cavium Inc.
+ * Author: Jan Glauber <jan.glauber@cavium.com>
+ */
+
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/cpu.h>
+#include <linux/io.h>
+#include <linux/perf_event.h>
+#include <linux/pci.h>
+
+#include <asm/cpufeature.h>
+#include <asm/cputype.h>
+
+#include "uncore_cavium.h"
+
+int thunder_uncore_version;
+
+struct thunder_uncore *event_to_thunder_uncore(struct perf_event *event)
+{
+	return NULL;
+}
+
+void thunder_uncore_read(struct perf_event *event)
+{
+	struct thunder_uncore *uncore = event_to_thunder_uncore(event);
+	struct hw_perf_event *hwc = &event->hw;
+	u64 prev, new = 0;
+	s64 delta;
+	int i;
+
+	/*
+	 * since we do not enable counter overflow interrupts,
+	 * we do not have to worry about prev_count changing on us
+	 */
+
+	prev = local64_read(&hwc->prev_count);
+
+	/* read counter values from all units */
+	for (i = 0; i < uncore->nr_units; i++)
+		new += readq(map_offset(hwc->event_base, uncore, i));
+
+	local64_set(&hwc->prev_count, new);
+	delta = new - prev;
+	local64_add(delta, &event->count);
+}
+
+void thunder_uncore_del(struct perf_event *event, int flags)
+{
+	struct thunder_uncore *uncore = event_to_thunder_uncore(event);
+	struct hw_perf_event *hwc = &event->hw;
+	int i;
+
+	event->pmu->stop(event, PERF_EF_UPDATE);
+
+	for (i = 0; i < uncore->num_counters; i++) {
+		if (cmpxchg(&uncore->events[i], event, NULL) == event)
+			break;
+	}
+	hwc->idx = -1;
+}
+
+int thunder_uncore_event_init(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
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
+	/* and we do not enable counter overflow interrupts */
+
+	uncore = event_to_thunder_uncore(event);
+	if (!uncore)
+		return -ENODEV;
+	if (!uncore->event_valid(event->attr.config))
+		return -EINVAL;
+
+	hwc->config = event->attr.config;
+	hwc->idx = -1;
+
+	/* and we don't care about CPU */
+
+	return 0;
+}
+
+static cpumask_t thunder_active_mask;
+
+static ssize_t thunder_uncore_attr_show_cpumask(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	cpumask_t *active_mask = &thunder_active_mask;
+
+	/*
+	 * Thunder uncore events are independent from CPUs. Provide a cpumask
+	 * nevertheless to prevent perf from adding the event per-cpu and just
+	 * set the mask to one online CPU.
+	 */
+	cpumask_set_cpu(cpumask_first(cpu_online_mask), active_mask);
+
+	return cpumap_print_to_pagebuf(true, buf, active_mask);
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
+int __init thunder_uncore_setup(struct thunder_uncore *uncore, int id,
+			 unsigned long offset, unsigned long size,
+			 struct pmu *pmu)
+{
+	struct pci_dev *pdev = NULL;
+	pci_bus_addr_t start;
+	int ret, node = 0;
+
+	/* detect PCI devices */
+	do {
+		pdev = pci_get_device(PCI_VENDOR_ID_CAVIUM, id, pdev);
+		if (!pdev)
+			break;
+		start = pci_resource_start(pdev, 0);
+		uncore->pdevs[node].pdev = pdev;
+		uncore->pdevs[node].base = start;
+		uncore->pdevs[node].map = ioremap(start + offset, size);
+		node++;
+		if (node >= MAX_NR_UNCORE_PDEVS) {
+			pr_err("reached pdev limit\n");
+			break;
+		}
+	} while (1);
+
+	if (!node)
+		return -ENODEV;
+
+	uncore->nr_units = node;
+
+	ret = perf_pmu_register(pmu, pmu->name, -1);
+	if (ret)
+		goto fail;
+
+	uncore->pmu = pmu;
+	return 0;
+
+fail:
+	for (node = 0; node < MAX_NR_UNCORE_PDEVS; node++) {
+		pdev = uncore->pdevs[node].pdev;
+		if (!pdev)
+			break;
+		iounmap(uncore->pdevs[node].map);
+		pci_dev_put(pdev);
+	}
+	return ret;
+}
+
+static int __init thunder_uncore_init(void)
+{
+	unsigned long implementor = read_cpuid_implementor();
+	unsigned long part_number = read_cpuid_part_number();
+	u32 variant;
+
+	if (implementor != ARM_CPU_IMP_CAVIUM ||
+	    part_number != CAVIUM_CPU_PART_THUNDERX)
+		return -ENODEV;
+
+	/* detect pass2 which contains different counters */
+	variant = MIDR_VARIANT(read_cpuid_id());
+	if (variant == 1)
+		thunder_uncore_version = 1;
+	pr_info("PMU version: %d\n", thunder_uncore_version);
+
+	return 0;
+}
+late_initcall(thunder_uncore_init);
diff --git a/arch/arm64/kernel/uncore/uncore_cavium.h b/arch/arm64/kernel/uncore/uncore_cavium.h
new file mode 100644
index 0000000..acd121d
--- /dev/null
+++ b/arch/arm64/kernel/uncore/uncore_cavium.h
@@ -0,0 +1,73 @@
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/cpu.h>
+#include <linux/io.h>
+#include <linux/perf_event.h>
+#include <linux/pci.h>
+
+#include <asm/cpufeature.h>
+#include <asm/cputype.h>
+
+#undef pr_fmt
+#define pr_fmt(fmt)     "thunderx_uncore: " fmt
+
+enum uncore_type {
+	NOP_TYPE,
+};
+
+extern int thunder_uncore_version;
+
+#define MAX_NR_UNCORE_PDEVS		16
+
+/* maximum number of parallel hardware counters for all uncore parts */
+#define MAX_COUNTERS			64
+
+/* generic uncore struct for different pmu types */
+struct thunder_uncore {
+	int num_counters;
+	int nr_units;
+	int type;
+	struct pmu *pmu;
+	int (*event_valid)(u64);
+	struct {
+		unsigned long base;
+		void __iomem *map;
+		struct pci_dev *pdev;
+	} pdevs[MAX_NR_UNCORE_PDEVS];
+	struct perf_event *events[MAX_COUNTERS];
+};
+
+#define EVENT_PTR(_id) (&event_attr_##_id.attr.attr)
+
+#define EVENT_ATTR(_name, _val)						   \
+static struct perf_pmu_events_attr event_attr_##_name = {		   \
+	.attr	   = __ATTR(_name, 0444, thunder_events_sysfs_show, NULL), \
+	.event_str = "event=" __stringify(_val),			   \
+};
+
+#define EVENT_ATTR_STR(_name, _str)					   \
+static struct perf_pmu_events_attr event_attr_##_name = {		   \
+	.attr	   = __ATTR(_name, 0444, thunder_events_sysfs_show, NULL), \
+	.event_str = _str,						   \
+};
+
+static inline void __iomem *map_offset(unsigned long addr,
+				struct thunder_uncore *uncore, int unit)
+{
+	return (void __iomem *) (addr + uncore->pdevs[unit].map);
+}
+
+extern struct attribute_group thunder_uncore_attr_group;
+
+/* Prototypes */
+struct thunder_uncore *event_to_thunder_uncore(struct perf_event *event);
+void thunder_uncore_del(struct perf_event *event, int flags);
+int thunder_uncore_event_init(struct perf_event *event);
+void thunder_uncore_read(struct perf_event *event);
+int thunder_uncore_setup(struct thunder_uncore *uncore, int id,
+			 unsigned long offset, unsigned long size,
+			 struct pmu *pmu);
+ssize_t thunder_events_sysfs_show(struct device *dev,
+				  struct device_attribute *attr,
+				  char *page);
-- 
1.9.1
