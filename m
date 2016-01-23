From: guohanjun@huawei.com (Hanjun Guo)
Date: Sat, 23 Jan 2016 17:39:27 +0800
Subject: [PATCH v3 12/12] acpi, numa: reuse acpi_numa_memory_affinity_init()
In-Reply-To: <1453541967-3744-1-git-send-email-guohanjun@huawei.com>
References: <1453541967-3744-1-git-send-email-guohanjun@huawei.com>
Message-ID: <1453541967-3744-13-git-send-email-guohanjun@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanjun Guo <hanjun.guo@linaro.org>

After the cleanup for acpi_numa_memory_affinity_init(),
it can be used for architetures both x86 and arm64, since
CONFIG_MEMORY_HOTPLUG is not enabled for arm64, so no
worry about that.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/kernel/acpi_numa.c | 42 -------------------------------
 arch/x86/mm/srat.c            | 54 ----------------------------------------
 drivers/acpi/numa.c           | 57 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 96 deletions(-)

diff --git a/arch/arm64/kernel/acpi_numa.c b/arch/arm64/kernel/acpi_numa.c
index 03ac1b9..5c01b06 100644
--- a/arch/arm64/kernel/acpi_numa.c
+++ b/arch/arm64/kernel/acpi_numa.c
@@ -137,48 +137,6 @@ void __init acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa)
 		pxm, mpidr, node, cpus_in_srat);
 }
 
-/* Callback for parsing of the Proximity Domain <-> Memory Area mappings */
-int __init acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
-{
-	u64 start, end;
-	int node, pxm;
-
-	if (srat_disabled())
-		return -EINVAL;
-
-	if (ma->header.length != sizeof(struct acpi_srat_mem_affinity)) {
-		bad_srat();
-		return -EINVAL;
-	}
-
-	/* Ignore disabled entries */
-	if (!(ma->flags & ACPI_SRAT_MEM_ENABLED))
-		return -EINVAL;
-
-	start = ma->base_address;
-	end = start + ma->length;
-	pxm = ma->proximity_domain;
-
-	node = acpi_map_pxm_to_node(pxm);
-
-	if (node == NUMA_NO_NODE || node >= MAX_NUMNODES) {
-		pr_err("SRAT: Too many proximity domains.\n");
-		bad_srat();
-		return -EINVAL;
-	}
-
-	pr_info("SRAT: Node %u PXM %u [mem %#010Lx-%#010Lx]\n",
-		node, pxm,
-		(unsigned long long) start, (unsigned long long) end - 1);
-
-	if (numa_add_memblk(node, start, end) < 0) {
-		bad_srat();
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 int __init arm64_acpi_numa_init(void)
 {
 	int ret;
diff --git a/arch/x86/mm/srat.c b/arch/x86/mm/srat.c
index af1dc14..cbd792f 100644
--- a/arch/x86/mm/srat.c
+++ b/arch/x86/mm/srat.c
@@ -16,7 +16,6 @@
 #include <linux/module.h>
 #include <linux/topology.h>
 #include <linux/bootmem.h>
-#include <linux/memblock.h>
 #include <linux/mm.h>
 #include <asm/proto.h>
 #include <asm/numa.h>
@@ -104,59 +103,6 @@ acpi_numa_processor_affinity_init(struct acpi_srat_cpu_affinity *pa)
 	       pxm, apic_id, node);
 }
 
-/* Callback for parsing of the Proximity Domain <-> Memory Area mappings */
-int __init
-acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
-{
-	u64 start, end;
-	u32 hotpluggable;
-	int node, pxm;
-
-	if (srat_disabled())
-		goto out_err;
-	if (ma->header.length != sizeof(struct acpi_srat_mem_affinity))
-		goto out_err_bad_srat;
-	if ((ma->flags & ACPI_SRAT_MEM_ENABLED) == 0)
-		goto out_err;
-	hotpluggable = ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE;
-	if (hotpluggable && !IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
-		goto out_err;
-
-	start = ma->base_address;
-	end = start + ma->length;
-	pxm = ma->proximity_domain;
-	if (acpi_srat_revision <= 1)
-		pxm &= 0xff;
-
-	node = acpi_map_pxm_to_node(pxm);
-	if (node < 0) {
-		printk(KERN_ERR "SRAT: Too many proximity domains.\n");
-		goto out_err_bad_srat;
-	}
-
-	if (numa_add_memblk(node, start, end) < 0)
-		goto out_err_bad_srat;
-
-	node_set(node, numa_nodes_parsed);
-
-	pr_info("SRAT: Node %u PXM %u [mem %#010Lx-%#010Lx]%s%s\n",
-		node, pxm,
-		(unsigned long long) start, (unsigned long long) end - 1,
-		hotpluggable ? " hotplug" : "",
-		ma->flags & ACPI_SRAT_MEM_NON_VOLATILE ? " non-volatile" : "");
-
-	/* Mark hotplug range in memblock. */
-	if (hotpluggable && memblock_mark_hotplug(start, ma->length))
-		pr_warn("SRAT: Failed to mark hotplug range [mem %#010Lx-%#010Lx] in memblock\n",
-			(unsigned long long)start, (unsigned long long)end - 1);
-
-	return 0;
-out_err_bad_srat:
-	bad_srat();
-out_err:
-	return -EINVAL;
-}
-
 int __init x86_acpi_numa_init(void)
 {
 	int ret;
diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index 05e3795..eb73fda 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -27,6 +27,7 @@
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/acpi.h>
+#include <linux/memblock.h>
 #include <linux/numa.h>
 #include <linux/nodemask.h>
 #include <linux/topology.h>
@@ -240,6 +241,62 @@ void __init __weak acpi_numa_slit_init(struct acpi_table_slit *slit)
 	}
 }
 
+/*
+ * Default callback for parsing of the Proximity Domain <-> Memory
+ * Area mappings
+ */
+int __init __weak
+acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
+{
+	u64 start, end;
+	u32 hotpluggable;
+	int node, pxm;
+
+	if (srat_disabled())
+		goto out_err;
+	if (ma->header.length != sizeof(struct acpi_srat_mem_affinity))
+		goto out_err_bad_srat;
+	if ((ma->flags & ACPI_SRAT_MEM_ENABLED) == 0)
+		goto out_err;
+	hotpluggable = ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE;
+	if (hotpluggable && !IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+		goto out_err;
+
+	start = ma->base_address;
+	end = start + ma->length;
+	pxm = ma->proximity_domain;
+	if (acpi_srat_revision <= 1)
+		pxm &= 0xff;
+
+	node = acpi_map_pxm_to_node(pxm);
+	if (node < 0) {
+		printk(KERN_ERR "SRAT: Too many proximity domains.\n");
+		goto out_err_bad_srat;
+	}
+
+	if (numa_add_memblk(node, start, end) < 0)
+		goto out_err_bad_srat;
+
+	node_set(node, numa_nodes_parsed);
+
+	pr_info("SRAT: Node %u PXM %u [mem %#010Lx-%#010Lx]%s%s\n",
+		node, pxm,
+		(unsigned long long) start, (unsigned long long) end - 1,
+		hotpluggable ? " hotplug" : "",
+		ma->flags & ACPI_SRAT_MEM_NON_VOLATILE ? " non-volatile" : "");
+
+	/* Mark hotplug range in memblock. */
+	if (hotpluggable && memblock_mark_hotplug(start, ma->length))
+		pr_warn("SRAT: Failed to mark hotplug range [mem %#010Lx-%#010Lx] in memblock\n",
+			(unsigned long long)start, (unsigned long long)end - 1);
+
+	return 0;
+out_err_bad_srat:
+	bad_srat();
+out_err:
+	return -EINVAL;
+}
+
 static int __init acpi_parse_slit(struct acpi_table_header *table)
 {
 	struct acpi_table_slit *slit = (struct acpi_table_slit *)table;
-- 
1.9.1
