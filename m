From: ganapatrao.kulkarni@cavium.com (Ganapatrao Kulkarni)
Date: Tue,  6 Jun 2017 18:26:27 +0530
Subject: [PATCH 2/2] acpi, gicv3-its,
 numa: Adding numa node mapping for gic-its units
In-Reply-To: <1496753787-27735-1-git-send-email-ganapatrao.kulkarni@cavium.com>
References: <1496753787-27735-1-git-send-email-ganapatrao.kulkarni@cavium.com>
Message-ID: <1496753787-27735-3-git-send-email-ganapatrao.kulkarni@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add code to parse SRAT ITS Affinity sub table as defined in ACPI 6.2
Later in driver probe, its devices are mapped to numa node
using its id to proximity domain mapping.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
---
 arch/arm64/include/asm/acpi.h    |  2 ++
 arch/arm64/kernel/acpi_numa.c    | 59 ++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/numa.c              | 32 +++++++++++++++++++++-
 drivers/irqchip/irq-gic-v3-its.c |  3 +-
 include/linux/acpi.h             |  3 ++
 5 files changed, 97 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index 0e99978..60ea7d1 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -143,9 +143,11 @@ static inline void arch_apei_flush_tlb_one(unsigned long addr)
 #ifdef CONFIG_ACPI_NUMA
 int arm64_acpi_numa_init(void);
 int acpi_numa_get_nid(unsigned int cpu, u64 hwid);
+int acpi_numa_get_its_nid(u32 its_id);
 #else
 static inline int arm64_acpi_numa_init(void) { return -ENOSYS; }
 static inline int acpi_numa_get_nid(unsigned int cpu, u64 hwid) { return NUMA_NO_NODE; }
+static inline int acpi_numa_get_its_nid(u32 its_id) { return NUMA_NO_NODE; }
 #endif /* CONFIG_ACPI_NUMA */
 
 #define ACPI_TABLE_UPGRADE_MAX_PHYS MEMBLOCK_ALLOC_ACCESSIBLE
diff --git a/arch/arm64/kernel/acpi_numa.c b/arch/arm64/kernel/acpi_numa.c
index f01fab6..f7b2ea6 100644
--- a/arch/arm64/kernel/acpi_numa.c
+++ b/arch/arm64/kernel/acpi_numa.c
@@ -29,15 +29,24 @@
 #include <asm/numa.h>
 
 static int cpus_in_srat;
+static int its_in_srat;
 
 struct __node_cpu_hwid {
 	u32 node_id;    /* logical node containing this CPU */
 	u64 cpu_hwid;   /* MPIDR for this CPU */
 };
 
+struct __node_its_id {
+	u32 node_id;    /* numa node id */
+	u32 its_id ;   /* GIC ITS ID */
+};
+
 static struct __node_cpu_hwid early_node_cpu_hwid[NR_CPUS] = {
 [0 ... NR_CPUS - 1] = {NUMA_NO_NODE, PHYS_CPUID_INVALID} };
 
+static struct __node_its_id early_node_its_id[MAX_NUMNODES] = {
+[0 ... MAX_NUMNODES - 1] = {NUMA_NO_NODE, UINT_MAX} };
+
 int acpi_numa_get_nid(unsigned int cpu, u64 hwid)
 {
 	int i;
@@ -50,6 +59,18 @@ int acpi_numa_get_nid(unsigned int cpu, u64 hwid)
 	return NUMA_NO_NODE;
 }
 
+int acpi_numa_get_its_nid(u32 its_id)
+{
+	int i;
+
+	for (i = 0; i < its_in_srat; i++) {
+		if (its_id == early_node_its_id[i].its_id)
+			return early_node_its_id[i].node_id;
+	}
+
+	return NUMA_NO_NODE;
+}
+
 /* Callback for Proximity Domain -> ACPI processor UID mapping */
 void __init acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa)
 {
@@ -100,6 +121,44 @@ void __init acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa)
 		pxm, mpidr, node);
 }
 
+/* Callback for ITS ACPI Proximity Domain mapping */
+void __init acpi_numa_its_affinity_init(struct acpi_srat_its_affinity *pa)
+{
+	int pxm, node;
+
+	if (srat_disabled())
+		return;
+
+	if (pa->header.length < sizeof(struct acpi_srat_its_affinity)) {
+		pr_err("SRAT: Invalid SRAT header length: %d\n",
+			pa->header.length);
+		bad_srat();
+		return;
+	}
+
+	if (its_in_srat >= MAX_NUMNODES) {
+		pr_warn_once("SRAT: its count exceeding max count[%d]\n",
+			     MAX_NUMNODES);
+		return;
+	}
+
+	pxm = pa->proximity_domain;
+	node = acpi_map_pxm_to_node(pxm);
+
+	if (node == NUMA_NO_NODE || node >= MAX_NUMNODES) {
+		pr_err("SRAT: Too many proximity domains %d\n", pxm);
+		bad_srat();
+		return;
+	}
+
+	early_node_its_id[its_in_srat].node_id = node;
+	early_node_its_id[its_in_srat].its_id =  its_in_srat;
+	node_set(node, numa_nodes_parsed);
+	pr_info("SRAT: PXM %d -> ITS %d -> Node %d\n",
+		pxm, its_in_srat, node);
+	its_in_srat++;
+}
+
 int __init arm64_acpi_numa_init(void)
 {
 	int ret;
diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index edb0c79..9c04dba 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -182,6 +182,16 @@ int acpi_map_pxm_to_online_node(int pxm)
 		}
 		break;
 
+	case ACPI_SRAT_TYPE_GIC_ITS_AFFINITY:
+		{
+			struct acpi_srat_its_affinity *p =
+			    (struct acpi_srat_its_affinity *)header;
+			pr_debug("SRAT ITS [0x%04x]) in proximity domain %d\n",
+				 p->its_id,
+				 p->proximity_domain);
+		}
+		break;
+
 	default:
 		pr_warn("Found unsupported SRAT entry (type = 0x%x)\n",
 			header->type);
@@ -390,6 +400,24 @@ static int __init acpi_parse_slit(struct acpi_table_header *table)
 	return 0;
 }
 
+static int __init
+acpi_parse_its_affinity(struct acpi_subtable_header *header,
+			 const unsigned long end)
+{
+	struct acpi_srat_its_affinity *its_affinity;
+
+	its_affinity = (struct acpi_srat_its_affinity *)header;
+	if (!its_affinity)
+		return -EINVAL;
+
+	acpi_table_print_srat_entry(header);
+
+	/* let architecture-dependent part to do it */
+	acpi_numa_its_affinity_init(its_affinity);
+
+	return 0;
+}
+
 static int __initdata parsed_numa_memblks;
 
 static int __init
@@ -445,7 +473,7 @@ int __init acpi_numa_init(void)
 
 	/* SRAT: Static Resource Affinity Table */
 	if (!acpi_table_parse(ACPI_SIG_SRAT, acpi_parse_srat)) {
-		struct acpi_subtable_proc srat_proc[3];
+		struct acpi_subtable_proc srat_proc[4];
 
 		memset(srat_proc, 0, sizeof(srat_proc));
 		srat_proc[0].id = ACPI_SRAT_TYPE_CPU_AFFINITY;
@@ -454,6 +482,8 @@ int __init acpi_numa_init(void)
 		srat_proc[1].handler = acpi_parse_x2apic_affinity;
 		srat_proc[2].id = ACPI_SRAT_TYPE_GICC_AFFINITY;
 		srat_proc[2].handler = acpi_parse_gicc_affinity;
+		srat_proc[3].id = ACPI_SRAT_TYPE_GIC_ITS_AFFINITY;
+		srat_proc[3].handler = acpi_parse_its_affinity;
 
 		acpi_table_parse_entries_array(ACPI_SIG_SRAT,
 					sizeof(struct acpi_table_srat),
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 45ea1933..84936da 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1861,7 +1861,8 @@ static int __init gic_acpi_parse_madt_its(struct acpi_subtable_header *header,
 		goto dom_err;
 	}
 
-	err = its_probe_one(&res, dom_handle, NUMA_NO_NODE);
+	err = its_probe_one(&res, dom_handle,
+			acpi_numa_get_its_nid(its_entry->translation_id));
 	if (!err)
 		return 0;
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 137e4a3..e5e8ae3 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -260,9 +260,12 @@ int acpi_table_parse_madt(enum acpi_madt_type id,
 
 #ifdef CONFIG_ARM64
 void acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa);
+void acpi_numa_its_affinity_init(struct acpi_srat_its_affinity *pa);
 #else
 static inline void
 acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa) { }
+static inline void
+acpi_numa_its_affinity_init(struct acpi_srat_its_affinity *pa) { }
 #endif
 
 int acpi_numa_memory_affinity_init (struct acpi_srat_mem_affinity *ma);
-- 
1.8.1.4
