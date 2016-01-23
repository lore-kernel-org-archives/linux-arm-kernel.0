From: guohanjun@huawei.com (Hanjun Guo)
Date: Sat, 23 Jan 2016 17:39:22 +0800
Subject: [PATCH v3 07/12] acpi,
 numa: move acpi_numa_slit_init() to common place
In-Reply-To: <1453541967-3744-1-git-send-email-guohanjun@huawei.com>
References: <1453541967-3744-1-git-send-email-guohanjun@huawei.com>
Message-ID: <1453541967-3744-8-git-send-email-guohanjun@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanjun Guo <hanjun.guo@linaro.org>

acpi_numa_slit_init() is used by both x86 and arm64, and
the code is the same, move it to common place to simplify
the code, and mark it as __weak because the different
implimentation for ia64.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/kernel/acpi_numa.c | 31 -------------------------------
 arch/x86/mm/srat.c            | 27 ---------------------------
 drivers/acpi/numa.c           | 30 ++++++++++++++++++++++++++++++
 3 files changed, 30 insertions(+), 58 deletions(-)

diff --git a/arch/arm64/kernel/acpi_numa.c b/arch/arm64/kernel/acpi_numa.c
index f7f7533..15fb935 100644
--- a/arch/arm64/kernel/acpi_numa.c
+++ b/arch/arm64/kernel/acpi_numa.c
@@ -64,37 +64,6 @@ void __init acpi_numa_set_node_info(unsigned int cpu, u64 hwid)
 	cpu_to_node_map[cpu] = nid;
 }
 
-/*
- * Callback for SLIT parsing.
- * It will get the distance information presented by SLIT
- * and init the distance matrix of numa nodes
- */
-void __init acpi_numa_slit_init(struct acpi_table_slit *slit)
-{
-	int i, j;
-
-	for (i = 0; i < slit->locality_count; i++) {
-		const int from_node = pxm_to_node(i);
-
-		if (from_node == NUMA_NO_NODE)
-			continue;
-
-		for (j = 0; j < slit->locality_count; j++) {
-			const int to_node = pxm_to_node(j);
-
-			if (to_node == NUMA_NO_NODE)
-				continue;
-
-			pr_debug("SLIT: Distance[%d][%d] = %d\n",
-					from_node, to_node,
-					slit->entry[
-					slit->locality_count * i + j]);
-			numa_set_distance(from_node, to_node,
-				slit->entry[slit->locality_count * i + j]);
-		}
-	}
-}
-
 static int __init get_mpidr_in_madt(int acpi_id, u64 *mpidr)
 {
 	unsigned long madt_end, entry;
diff --git a/arch/x86/mm/srat.c b/arch/x86/mm/srat.c
index 9fa1746..92a640a 100644
--- a/arch/x86/mm/srat.c
+++ b/arch/x86/mm/srat.c
@@ -42,33 +42,6 @@ static __init inline int srat_disabled(void)
 	return acpi_numa < 0;
 }
 
-/*
- * Callback for SLIT parsing.  pxm_to_node() returns NUMA_NO_NODE for
- * I/O localities since SRAT does not list them.  I/O localities are
- * not supported@this point.
- */
-void __init acpi_numa_slit_init(struct acpi_table_slit *slit)
-{
-	int i, j;
-
-	for (i = 0; i < slit->locality_count; i++) {
-		const int from_node = pxm_to_node(i);
-
-		if (from_node == NUMA_NO_NODE)
-			continue;
-
-		for (j = 0; j < slit->locality_count; j++) {
-			const int to_node = pxm_to_node(j);
-
-			if (to_node == NUMA_NO_NODE)
-				continue;
-
-			numa_set_distance(from_node, to_node,
-				slit->entry[slit->locality_count * i + j]);
-		}
-	}
-}
-
 /* Callback for Proximity Domain -> x2APIC mapping */
 void __init
 acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinity *pa)
diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index 4728525..b33915e 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -209,6 +209,36 @@ static int __init slit_valid(struct acpi_table_slit *slit)
 	return 1;
 }
 
+/*
+ * Callback for SLIT parsing. It will get the distance information
+ * presented by SLIT and init the distance matrix of numa nodes
+ */
+void __init __weak acpi_numa_slit_init(struct acpi_table_slit *slit)
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
+			numa_set_distance(from_node, to_node,
+				slit->entry[slit->locality_count * i + j]);
+
+			pr_debug("SLIT: Distance[%d][%d] = %d\n",
+				 from_node, to_node,
+				 slit->entry[slit->locality_count * i + j]);
+		}
+	}
+}
+
 static int __init acpi_parse_slit(struct acpi_table_header *table)
 {
 	struct acpi_table_slit *slit = (struct acpi_table_slit *)table;
-- 
1.9.1
