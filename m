From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 26 Oct 2012 15:48:45 +0100
Subject: [PATCH 2/2] ARM: Add functions to parse dt irq affinity
In-Reply-To: <1351262925-10306-1-git-send-email-mark.rutland@arm.com>
References: <1351262925-10306-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1351262925-10306-3-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds functions to handle parsing cpu affinity of interrupts
from devicetree. Devices using these functions are dealt with as
follows:

* If the device was not initialised from devicetree, it is considered to
  be affine to all CPUs, and interrupts are assumed to be in order of
  physical CPU id (MPIDR.Aff0).

* If the device was initialised from devicetree, but does not have an
  "affinity" value, the device is considered to be affine to all CPUs,
  and interupts are assumed to be in order of physical CPU id
  (MPIDR.Aff0).

* If the device was initialised from devicetree, and has an "affinity"
  value, then the interrupt at index i in the interrupts list is affine
  to the cpu or cluster pointed to by the entry in the affinity list at
  index i. Interrupts affine to a cluster are PPIs, and interrupts
  affine to a single cpu are SPIs.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm/include/asm/dt_irq.h |   64 ++++++++++++++++
 arch/arm/kernel/devtree.c     |  164 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 228 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/include/asm/dt_irq.h

diff --git a/arch/arm/include/asm/dt_irq.h b/arch/arm/include/asm/dt_irq.h
new file mode 100644
index 0000000..ed86ca8
--- /dev/null
+++ b/arch/arm/include/asm/dt_irq.h
@@ -0,0 +1,64 @@
+/*
+ *  arch/arm/include/asm/dt_irq.h
+ *
+ *  Copyright (C) 2009 ARM Ltd. <mark.rutland@arm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+#ifndef __ASMARM_DT_IRQ_H
+#define __ASMARM_DT_IRQ_H
+
+#include <linux/cpumask.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+#ifdef CONFIG_OF
+
+extern int count_cpus_in_cluster(struct device_node *cluster);
+extern struct device_node *of_get_cluster_cpu(struct device_node *cluster, int idx);
+extern int count_irq_affine_cpus(struct platform_device *pdev, int irq_idx);
+extern int of_get_logical_cpu_id(struct device_node *cpu);
+extern int get_irq_affine_cpu(struct platform_device *pdev, int irq_idx, int cpu_idx);
+extern int get_device_cpu_affinity(struct platform_device *pdev, cpumask_t *mask);
+
+#else /* CONFIG_OF */
+
+static int count_cpus_in_cluster(struct device_node *cluster)
+{
+	return -EINVAL;
+}
+
+static struct device_node *of_get_cluster_cpu(struct device_node *cluster, int idx)
+{
+	return NULL;
+}
+
+static int count_irq_affine_cpus(struct platform_device *pdev, int irq_idx)
+{
+	return 1;
+}
+
+static int of_get_logical_cpu_id(struct device_node *cpu)
+{
+	return -EINVAL;
+}
+
+static int get_irq_affine_cpu(struct platform_device *pdev, int irq_idx, int cpu_idx);
+{
+	if (cpu_idx != 0)
+		return -EINVAL;
+
+	return get_logical_index(irq_idx);
+}
+
+static int get_device_cpu_affinity(struct platform_device *pdev, cpumask_t *mask)
+{
+	cpumask_setall(mask);
+	return 0;
+}
+
+#endif /* CONFIG_OF */
+#endif /* ASMARM_DT_IRQ_H */
diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index bee7f9d..4026827 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -132,3 +132,167 @@ struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
 
 	return mdesc_best;
 }
+
+int count_cpus_in_cluster(struct device_node *cluster)
+{
+	struct device_node *cpus, *cpu, *cpu_cluster;
+	int count = 0;
+
+	cpus = of_find_node_by_path("/cpus");
+	if (!cpus)
+		return -EINVAL;
+
+	for_each_child_of_node(cpus, cpu) {
+		cpu_cluster = of_parse_phandle(cpu, "cluster", 0);
+		if (cpu_cluster == cluster)
+			count++;
+		of_node_put(cpu_cluster);
+	}
+
+	of_node_put(cpus);
+	return count;
+}
+
+struct device_node *of_get_cluster_cpu(struct device_node *cluster, int idx)
+{
+	struct device_node *cpus, *cpu, *cpu_cluster;
+
+	cpus = of_find_node_by_path("/cpus");
+	if (!cpus)
+		return NULL;
+
+	for_each_child_of_node(cpus, cpu) {
+		cpu_cluster = of_parse_phandle(cpu, "cluster", 0);
+		if (cpu_cluster == cluster && idx == 0) {
+			of_node_put(cpu_cluster);
+			break;
+		}
+
+		idx--;
+		of_node_put(cpu_cluster);
+	}
+
+	of_node_put(cpus);
+	return cpu;
+}
+
+int count_irq_affine_cpus(struct platform_device *pdev, int irq_idx)
+{
+	struct device_node *node, *affine;
+	int ret = -EINVAL;
+
+	if (!pdev)
+		return -EINVAL;
+
+	node = pdev->dev.of_node;
+
+	/*
+	 * For devices not initialised from devicetree, we only support sets of
+	 * SPIs.
+	 */
+	if (!node)
+		return 1;
+
+	affine = of_parse_phandle(node, "affinity", irq_idx);
+
+	/*
+	 * A device initialised from devicetree without an affinity parameter
+	 * is assumed to have a set of cpu-affine SPIs (so 1 cpu per irq).
+	 */
+	if (!affine)
+		return 1;
+
+	if (!of_node_cmp(affine->name, "cpu"))
+		ret = 1;
+	else if (!of_node_cmp(affine->name, "cluster"))
+		ret = count_cpus_in_cluster(affine);
+
+	of_node_put(affine);
+	return ret;
+}
+
+int of_get_logical_cpu_id(struct device_node *cpu)
+{
+	u32 mpidr;
+	if (of_property_read_u32(cpu, "reg", &mpidr))
+		return -EINVAL;
+
+	return get_logical_index(mpidr);
+}
+
+int get_irq_affine_cpu(struct platform_device *pdev, int irq_idx, int cpu_idx)
+{
+	struct device_node *node, *affine, *cpu;
+	int ret = -EINVAL;
+
+	if (!pdev)
+		return -EINVAL;
+
+	node = pdev->dev.of_node;
+
+	/*
+	 * Without devicetree, we only support single cluster systems.
+	 * We assume 1 SPI per CPU.
+	 * CPUs are assumed to be in increasing order of MPIDR.Aff{0},
+	 * starting at 0. MPIDR.Aff{2,1} are assumed to be 0.
+	 */
+	if (!node) {
+		if (cpu_idx != 0)
+			return -EINVAL;
+		return get_logical_index(irq_idx);
+	}
+
+	affine = of_parse_phandle(node, "affinity", irq_idx);
+	if (!affine) {
+		if (cpu_idx != 0)
+			return -EINVAL;
+		return get_logical_index(irq_idx);
+	}
+
+	if (!of_node_cmp(affine->name, "cluster")) {
+		cpu = of_get_cluster_cpu(affine, cpu_idx);
+		if (cpu) {
+			ret = of_get_logical_cpu_id(cpu);
+			of_node_put(cpu);
+		}
+	}
+	else if (!of_node_cmp(affine->name, "cpu")) {
+		ret = of_get_logical_cpu_id(affine);
+	}
+
+	of_node_put(affine);
+	return ret;
+}
+
+int get_device_cpu_affinity(struct platform_device *pdev, cpumask_t *mask)
+{
+	struct device_node *node;
+	int affines, a, cpus, c, cpu;
+
+	node = pdev->dev.of_node;
+
+	if (!node) {
+		cpumask_setall(mask);
+		return 0;
+	}
+
+	affines = of_property_count_phandles(node, "affinity");
+	if (affines == -ENOENT) {
+		cpumask_setall(mask);
+		return 0;
+	}
+
+	if (affines < 0)
+		return -EINVAL;
+
+	for (a = 0; a < affines; a++) {
+		cpus = count_irq_affine_cpus(pdev, a);
+		for (c = 0; c < cpus; c++) {
+			cpu = get_irq_affine_cpu(pdev, a, c);
+			if (cpu >= 0)
+				cpumask_set_cpu(cpu, mask);
+		}
+	}
+
+	return 0;
+}
-- 
1.7.0.4
