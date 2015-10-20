From: gkulkarni@caviumnetworks.com (Ganapatrao Kulkarni)
Date: Tue, 20 Oct 2015 16:15:30 +0530
Subject: [PATCH v6 3/4] arm64/arm, numa,
 dt: adding numa dt binding implementation for arm64 platforms
In-Reply-To: <1445337931-11344-1-git-send-email-gkulkarni@caviumnetworks.com>
References: <1445337931-11344-1-git-send-email-gkulkarni@caviumnetworks.com>
Message-ID: <1445337931-11344-4-git-send-email-gkulkarni@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding numa dt binding support for arm64 based platforms.
dt node parsing for numa topology is done using device property
proximity and device node distance-map.

Reviewed-by: Robert Richter <rrichter@cavium.com>
Signed-off-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
---
 arch/arm64/Kconfig            |  10 ++
 arch/arm64/include/asm/numa.h |  10 ++
 arch/arm64/kernel/Makefile    |   1 +
 arch/arm64/kernel/of_numa.c   | 221 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/smp.c       |   1 +
 arch/arm64/mm/numa.c          |  10 +-
 6 files changed, 252 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/kernel/of_numa.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 0f9cdc7..6cf8d20 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -426,6 +426,16 @@ config NUMA
 	  local memory controller of the CPU and add some more
 	  NUMA awareness to the kernel.
 
+config OF_NUMA
+	bool "Device Tree NUMA support"
+	depends on NUMA
+	depends on OF
+	default y
+	help
+	  Enable Device Tree NUMA support.
+	  This enables the numa mapping of cpu, memory, io and
+	  inter node distances using dt bindings.
+
 config NODES_SHIFT
 	int "Maximum NUMA Nodes (as a power of 2)"
 	range 1 10
diff --git a/arch/arm64/include/asm/numa.h b/arch/arm64/include/asm/numa.h
index cadbd24..322da78 100644
--- a/arch/arm64/include/asm/numa.h
+++ b/arch/arm64/include/asm/numa.h
@@ -60,4 +60,14 @@ void numa_store_cpu_info(unsigned int cpu);
 static inline void numa_store_cpu_info(unsigned int cpu)		{ }
 static inline void arm64_numa_init(void)		{ }
 #endif	/* CONFIG_NUMA */
+
+struct device_node;
+#ifdef CONFIG_OF_NUMA
+int __init arm64_of_numa_init(void);
+void __init of_numa_set_node_info(unsigned int cpu,
+		u64 hwid, struct device_node *dn);
+#else
+static inline void of_numa_set_node_info(unsigned int cpu, u64 hwid,
+		struct device_node *dn) { }
+#endif
 #endif	/* _ASM_NUMA_H */
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 22dc9bc..ad1fd72 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -36,6 +36,7 @@ arm64-obj-$(CONFIG_EFI)			+= efi.o efi-stub.o efi-entry.o
 arm64-obj-$(CONFIG_PCI)			+= pci.o
 arm64-obj-$(CONFIG_ARMV8_DEPRECATED)	+= armv8_deprecated.o
 arm64-obj-$(CONFIG_ACPI)		+= acpi.o
+arm64-obj-$(CONFIG_OF_NUMA)		+= of_numa.o
 
 obj-y					+= $(arm64-obj-y) vdso/
 obj-m					+= $(arm64-obj-m)
diff --git a/arch/arm64/kernel/of_numa.c b/arch/arm64/kernel/of_numa.c
new file mode 100644
index 0000000..0a6b2cf
--- /dev/null
+++ b/arch/arm64/kernel/of_numa.c
@@ -0,0 +1,221 @@
+/*
+ * OF NUMA Parsing support.
+ *
+ * Copyright (C) 2015 Cavium Inc.
+ * Author: Ganapatrao Kulkarni <gkulkarni@cavium.com>
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
+
+#include <linux/memblock.h>
+#include <linux/ctype.h>
+#include <linux/module.h>
+#include <linux/nodemask.h>
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+#include <asm/smp_plat.h>
+
+/* define default numa node to 0 */
+#define DEFAULT_NODE 0
+
+/* Returns nid in the range [0..MAX_NUMNODES-1],
+ * or NUMA_NO_NODE if no valid proximity entry found
+ * or DEFAULT_NODE if no proximity entry exists
+ */
+static int proximity_to_nid(const __be32 *proximity, int length)
+{
+	int nid;
+
+	if (!proximity)
+		return DEFAULT_NODE;
+
+	if (length != sizeof(*proximity)) {
+		pr_warn("NUMA: Invalid proximity length %d found.\n", length);
+		return NUMA_NO_NODE;
+	}
+
+	nid = of_read_number(proximity, 1);
+	if (nid >= MAX_NUMNODES) {
+		pr_warn("NUMA: Invalid numa node %d found.\n", nid);
+		return NUMA_NO_NODE;
+	}
+
+	return nid;
+}
+
+/* Must hold reference to node during call */
+static int of_get_proximity(struct device_node *device)
+{
+	int length;
+	const __be32 *proximity;
+
+	proximity = of_get_property(device, "proximity", &length);
+
+	return proximity_to_nid(proximity, length);
+}
+
+static int early_init_of_get_proximity(unsigned long node)
+{
+	int length;
+	const __be32 *proximity;
+
+	proximity = of_get_flat_dt_prop(node, "proximity", &length);
+
+	return proximity_to_nid(proximity, length);
+}
+
+/* Walk the device tree upwards, looking for a proximity node */
+int of_node_to_nid(struct device_node *device)
+{
+	struct device_node *parent;
+	int nid = NUMA_NO_NODE;
+
+	of_node_get(device);
+	while (device) {
+		const __be32 *proximity;
+		int length;
+
+		proximity = of_get_property(device, "proximity", &length);
+		if (proximity) {
+			nid = proximity_to_nid(proximity, length);
+			break;
+		}
+
+		parent = device;
+		device = of_get_parent(parent);
+		of_node_put(parent);
+	}
+	of_node_put(device);
+
+	return nid;
+}
+
+void __init of_numa_set_node_info(unsigned int cpu,
+		u64 hwid, struct device_node *device)
+{
+	int nid = DEFAULT_NODE;
+
+	if (device)
+		nid = of_get_proximity(device);
+
+	node_cpu_hwid[cpu].node_id = nid;
+	node_cpu_hwid[cpu].cpu_hwid = hwid;
+	node_set(nid, numa_nodes_parsed);
+}
+
+static int __init early_init_parse_memory_node(unsigned long node)
+{
+	const __be32 *reg, *endp;
+	int length;
+	int nid;
+
+	const char *type = of_get_flat_dt_prop(node, "device_type", NULL);
+
+	/* We are scanning "memory" nodes only */
+	if (type == NULL)
+		return 0;
+	else if (strcmp(type, "memory") != 0)
+		return 0;
+
+	nid = early_init_of_get_proximity(node);
+
+	if (nid == NUMA_NO_NODE)
+		return -EINVAL;
+
+	reg = of_get_flat_dt_prop(node, "reg", &length);
+	endp = reg + (length / sizeof(__be32));
+
+	while ((endp - reg) >= (dt_root_addr_cells + dt_root_size_cells)) {
+		u64 base, size;
+		struct memblock_region *mblk;
+
+		base = dt_mem_next_cell(dt_root_addr_cells, &reg);
+		size = dt_mem_next_cell(dt_root_size_cells, &reg);
+		pr_debug("NUMA-DT:  base = %llx , node = %u\n",
+				base, nid);
+
+		for_each_memblock(memory, mblk) {
+			if (mblk->base == base) {
+				node_set(nid, numa_nodes_parsed);
+				numa_add_memblk(nid, mblk->base, mblk->size);
+				break;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int early_init_parse_distance_map(unsigned long node, const char *uname)
+{
+	const __be32 *prop_dist_matrix;
+	int length = 0, i, matrix_count;
+	int nr_size_cells = OF_ROOT_NODE_SIZE_CELLS_DEFAULT;
+
+	if (strcmp(uname, "distance-map") != 0)
+		return 0;
+
+	prop_dist_matrix =
+		of_get_flat_dt_prop(node, "distance-matrix", &length);
+
+	if (!length) {
+		pr_err("NUMA: failed to parse distance-matrix\n");
+		return  -ENODEV;
+	}
+
+	matrix_count = ((length / sizeof(__be32)) / (3 * nr_size_cells));
+
+	if ((matrix_count * sizeof(__be32) * 3 * nr_size_cells) !=  length) {
+		pr_warn("NUMA: invalid distance-matrix length %d\n", length);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < matrix_count; i++) {
+		u32 nodea, nodeb, distance;
+
+		nodea = dt_mem_next_cell(nr_size_cells, &prop_dist_matrix);
+		nodeb = dt_mem_next_cell(nr_size_cells, &prop_dist_matrix);
+		distance = dt_mem_next_cell(nr_size_cells, &prop_dist_matrix);
+		numa_set_distance(nodea, nodeb, distance);
+		pr_debug("NUMA-DT:  distance[node%d -> node%d] = %d\n",
+				nodea, nodeb, distance);
+
+		/* Set default distance of node B->A same as A->B */
+		if (nodeb > nodea)
+			numa_set_distance(nodeb, nodea, distance);
+	}
+
+	return 0;
+}
+
+/**
+ * early_init_of_scan_numa_map - parse memory node and map nid to memory range.
+ */
+int __init early_init_of_scan_numa_map(unsigned long node, const char *uname,
+				     int depth, void *data)
+{
+	int ret;
+
+	ret = early_init_parse_memory_node(node);
+
+	if (!ret)
+		ret = early_init_parse_distance_map(node, uname);
+
+	return ret;
+}
+
+/* DT node mapping is done already early_init_of_scan_memory */
+int __init arm64_of_numa_init(void)
+{
+	return of_scan_flat_dt(early_init_of_scan_numa_map, NULL);
+}
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 985ee04..a9d7f93 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -516,6 +516,7 @@ void __init of_parse_and_init_cpus(void)
 
 		pr_debug("cpu logical map 0x%llx\n", hwid);
 		cpu_logical_map(cpu_count) = hwid;
+		of_numa_set_node_info(cpu_count, hwid, dn);
 next:
 		cpu_count++;
 	}
diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
index 4dd7436..ab01551 100644
--- a/arch/arm64/mm/numa.c
+++ b/arch/arm64/mm/numa.c
@@ -527,5 +527,13 @@ static int __init dummy_numa_init(void)
  */
 void __init arm64_numa_init(void)
 {
-	numa_init(dummy_numa_init);
+	int ret = -ENODEV;
+
+#ifdef CONFIG_OF_NUMA
+	if (!numa_off)
+		ret = numa_init(arm64_of_numa_init);
+#endif
+
+	if (ret)
+		numa_init(dummy_numa_init);
 }
-- 
1.8.1.4
