From: gkulkarni@caviumnetworks.com (Ganapatrao Kulkarni)
Date: Tue, 17 Nov 2015 23:55:32 +0530
Subject: [PATCH v2 3/4] arm64, acpi, numa: NUMA support based on SRAT and SLIT
In-Reply-To: <1447784733-10419-1-git-send-email-gkulkarni@caviumnetworks.com>
References: <1447784733-10419-1-git-send-email-gkulkarni@caviumnetworks.com>
Message-ID: <1447784733-10419-4-git-send-email-gkulkarni@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce a new file to hold ACPI based NUMA information
parsing from SRAT and SLIT.

SRAT includes the CPU ACPI ID to Proximity Domain mappings
and memory ranges to Proximity Domain mapping.
SLIT has the information of inter node
distances(relative number for access latency).

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
---
 arch/arm64/include/asm/acpi.h |   4 +
 arch/arm64/kernel/Makefile    |   1 +
 arch/arm64/kernel/acpi_numa.c | 215 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/mm/numa.c          |   7 +-
 4 files changed, 226 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/kernel/acpi_numa.c

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index caafd63..e171a18 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -83,6 +83,10 @@ static inline bool acpi_has_cpu_in_madt(void)
 static inline void arch_fix_phys_package_id(int num, u32 slot) { }
 void __init acpi_init_cpus(void);
 
+#ifdef CONFIG_ACPI_NUMA
+int arm64_acpi_numa_init(void);
+#endif /* CONFIG_ACPI_NUMA */
+
 #else
 static inline void acpi_init_cpus(void) { }
 #endif /* CONFIG_ACPI */
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 7987763..555c4a5 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -42,6 +42,7 @@ arm64-obj-$(CONFIG_PCI)			+= pci.o
 arm64-obj-$(CONFIG_ARMV8_DEPRECATED)	+= armv8_deprecated.o
 arm64-obj-$(CONFIG_ACPI)		+= acpi.o
 arm64-obj-$(CONFIG_OF_NUMA)		+= of_numa.o
+arm64-obj-$(CONFIG_ACPI_NUMA)		+= acpi_numa.o
 
 obj-y					+= $(arm64-obj-y) vdso/
 obj-m					+= $(arm64-obj-m)
diff --git a/arch/arm64/kernel/acpi_numa.c b/arch/arm64/kernel/acpi_numa.c
new file mode 100644
index 0000000..8aee205
--- /dev/null
+++ b/arch/arm64/kernel/acpi_numa.c
@@ -0,0 +1,215 @@
+/*
+ * ACPI 5.1 based NUMA setup for ARM64
+ * Lots of code was borrowed from arch/x86/mm/srat.c
+ *
+ * Copyright 2004 Andi Kleen, SuSE Labs.
+ * Copyright (C) 2013-2014, Linaro Ltd.
+ *		Author: Hanjun Guo <hanjun.guo@linaro.org>
+ *
+ * Reads the ACPI SRAT table to figure out what memory belongs to which CPUs.
+ *
+ * Called from acpi_numa_init while reading the SRAT and SLIT tables.
+ * Assumes all memory regions belonging to a single proximity domain
+ * are in one chunk. Holes between them will be included in the node.
+ */
+
+#define pr_fmt(fmt) "ACPI: NUMA: " fmt
+
+#include <linux/acpi.h>
+#include <linux/bitmap.h>
+#include <linux/bootmem.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/memblock.h>
+#include <linux/mmzone.h>
+#include <linux/module.h>
+#include <linux/topology.h>
+
+#include <acpi/processor.h>
+#include <asm/numa.h>
+
+int acpi_numa __initdata;
+
+static __init int setup_node(int pxm)
+{
+	return acpi_map_pxm_to_node(pxm);
+}
+
+static __init void bad_srat(void)
+{
+	pr_err("SRAT not used.\n");
+	acpi_numa = -1;
+}
+
+static __init inline int srat_disabled(void)
+{
+	return acpi_numa < 0;
+}
+
+/*
+ * Callback for SLIT parsing.
+ * It will get the distance information presented by SLIT
+ * and init the distance matrix of numa nodes
+ */
+void __init acpi_numa_slit_init(struct acpi_table_slit *slit)
+{
+	int i, j;
+
+	for (i = 0; i < slit->locality_count; i++) {
+		const int from_node = pxm_to_node(i);
+
+		if (from_node == NUMA_NO_NODE)
+			continue;
+
+		for (j = 0; j < slit->locality_count; j++) {
+			const int to_node = pxm_to_node(j);
+
+			if (to_node == NUMA_NO_NODE)
+				continue;
+
+			pr_info("SLIT: Distance[%d][%d] = %d\n",
+					from_node, to_node,
+					slit->entry[
+					slit->locality_count * i + j]);
+			numa_set_distance(from_node, to_node,
+				slit->entry[slit->locality_count * i + j]);
+		}
+	}
+}
+
+static int __init get_mpidr_in_madt(int acpi_id, u64 *mpidr)
+{
+	unsigned long madt_end, entry;
+	struct acpi_table_madt *madt;
+	acpi_size tbl_size;
+
+	if (ACPI_FAILURE(acpi_get_table_with_size(ACPI_SIG_MADT, 0,
+			(struct acpi_table_header **)&madt, &tbl_size)))
+		return -ENODEV;
+
+	entry = (unsigned long)madt;
+	madt_end = entry + madt->header.length;
+
+	/* Parse all entries looking for a match. */
+	entry += sizeof(struct acpi_table_madt);
+	while (entry + sizeof(struct acpi_subtable_header) < madt_end) {
+		struct acpi_subtable_header *header =
+			(struct acpi_subtable_header *)entry;
+
+		if (header->type == ACPI_MADT_TYPE_GENERIC_INTERRUPT) {
+			struct acpi_madt_generic_interrupt *gicc =
+				container_of(header,
+				struct acpi_madt_generic_interrupt, header);
+
+			if ((gicc->flags & ACPI_MADT_ENABLED) &&
+			    (gicc->uid == acpi_id)) {
+				*mpidr = gicc->arm_mpidr;
+				early_acpi_os_unmap_memory(madt, tbl_size);
+				return 0;
+			}
+		}
+		entry += header->length;
+	}
+
+	early_acpi_os_unmap_memory(madt, tbl_size);
+	return -ENODEV;
+}
+
+/* Callback for Proximity Domain -> ACPI processor UID mapping */
+void __init acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa)
+{
+	int pxm, node;
+	u64 mpidr;
+	static int cpus_in_srat;
+
+	if (srat_disabled())
+		return;
+
+	if (pa->header.length < sizeof(struct acpi_srat_gicc_affinity)) {
+		bad_srat();
+		return;
+	}
+
+	if (!(pa->flags & ACPI_SRAT_GICC_ENABLED))
+		return;
+
+	if (cpus_in_srat >= NR_CPUS) {
+		pr_warn_once("SRAT: cpu_to_node_map[%ld] is too small, may not be able to use all cpus\n",
+			     NR_CPUS);
+		return;
+	}
+
+	pxm = pa->proximity_domain;
+	node = setup_node(pxm);
+
+	if (node == NUMA_NO_NODE || node >= MAX_NUMNODES) {
+		pr_err("SRAT: Too many proximity domains %d\n", pxm);
+		bad_srat();
+		return;
+	}
+
+	if (get_mpidr_in_madt(pa->acpi_processor_uid, &mpidr)) {
+		pr_warn("SRAT: PXM %d with ACPI ID %d has no valid MPIDR in MADT\n",
+			pxm, pa->acpi_processor_uid);
+		bad_srat();
+		return;
+	}
+
+	cpu_to_node_map[cpus_in_srat] = node;
+	node_set(node, numa_nodes_parsed);
+	acpi_numa = 1;
+	cpus_in_srat++;
+	pr_info("SRAT: PXM %d -> MPIDR 0x%Lx -> Node %d cpu %d\n",
+			pxm, mpidr, node, cpus_in_srat);
+}
+
+/* Callback for parsing of the Proximity Domain <-> Memory Area mappings */
+int __init acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
+{
+	u64 start, end;
+	int node, pxm;
+
+	if (srat_disabled())
+		return -EINVAL;
+
+	if (ma->header.length != sizeof(struct acpi_srat_mem_affinity)) {
+		bad_srat();
+		return -EINVAL;
+	}
+
+	start = ma->base_address;
+	end = start + ma->length;
+	pxm = ma->proximity_domain;
+
+	node = setup_node(pxm);
+
+	if (node == NUMA_NO_NODE || node >= MAX_NUMNODES) {
+		pr_err("SRAT: Too many proximity domains.\n");
+		bad_srat();
+		return -EINVAL;
+	}
+
+	pr_info("SRAT: Node %u PXM %u [mem %#010Lx-%#010Lx]\n",
+		node, pxm,
+		(unsigned long long) start, (unsigned long long) end - 1);
+
+	if (numa_add_memblk(node, start, (end - start)) < 0) {
+		bad_srat();
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+void __init acpi_numa_arch_fixup(void) { }
+
+int __init arm64_acpi_numa_init(void)
+{
+	int ret;
+
+	ret = acpi_numa_init();
+	if (ret < 0)
+		return ret;
+
+	return srat_disabled() ? -EINVAL : 0;
+}
diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
index 209c7a9..c2950fc 100644
--- a/arch/arm64/mm/numa.c
+++ b/arch/arm64/mm/numa.c
@@ -17,6 +17,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/acpi.h>
 #include <linux/bootmem.h>
 #include <linux/ctype.h>
 #include <linux/init.h>
@@ -383,9 +384,13 @@ void __init arm64_numa_init(void)
 	int ret = -ENODEV;
 
 #ifdef CONFIG_OF_NUMA
-	if (!numa_off)
+	if (!numa_off && acpi_disabled)
 		ret = numa_init(arm64_of_numa_init);
 #endif
+#ifdef CONFIG_ACPI_NUMA
+	if (!numa_off && !acpi_disabled)
+		ret = numa_init(arm64_acpi_numa_init);
+#endif
 
 	if (ret)
 		numa_init(dummy_numa_init);
-- 
1.8.1.4
