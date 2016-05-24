From: ddaney.cavm@gmail.com (David Daney)
Date: Tue, 24 May 2016 15:35:41 -0700
Subject: [PATCH v7 11/15] acpi,
 numa: Move acpi_numa_memory_affinity_init() to drivers/acpi/numa.c
In-Reply-To: <1464129345-18985-1-git-send-email-ddaney.cavm@gmail.com>
References: <1464129345-18985-1-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <1464129345-18985-12-git-send-email-ddaney.cavm@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanjun Guo <hanjun.guo@linaro.org>

acpi_numa_memory_affinity_init() will be reused by arm64.  Move it to
drivers/acpi/numa.c to facilitate reuse.

No code change.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Robert Richter <rrichter@cavium.com>
Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/x86/mm/srat.c  | 57 --------------------------------------------------
 drivers/acpi/numa.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 57 deletions(-)

diff --git a/arch/x86/mm/srat.c b/arch/x86/mm/srat.c
index 30460f5..b1ecff4 100644
--- a/arch/x86/mm/srat.c
+++ b/arch/x86/mm/srat.c
@@ -15,8 +15,6 @@
 #include <linux/bitmap.h>
 #include <linux/module.h>
 #include <linux/topology.h>
-#include <linux/bootmem.h>
-#include <linux/memblock.h>
 #include <linux/mm.h>
 #include <asm/proto.h>
 #include <asm/numa.h>
@@ -104,61 +102,6 @@ acpi_numa_processor_affinity_init(struct acpi_srat_cpu_affinity *pa)
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
-	max_possible_pfn = max(max_possible_pfn, PFN_UP(end - 1));
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
index af0c8d5..811f90a 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -27,6 +27,8 @@
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/acpi.h>
+#include <linux/bootmem.h>
+#include <linux/memblock.h>
 #include <linux/numa.h>
 #include <linux/nodemask.h>
 #include <linux/topology.h>
@@ -236,6 +238,64 @@ void __init acpi_numa_slit_init(struct acpi_table_slit *slit)
 		}
 	}
 }
+
+/*
+ * Default callback for parsing of the Proximity Domain <-> Memory
+ * Area mappings
+ */
+int __init
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
+	max_possible_pfn = max(max_possible_pfn, PFN_UP(end - 1));
+
+	return 0;
+out_err_bad_srat:
+	bad_srat();
+out_err:
+	return -EINVAL;
+}
 #endif /* defined(CONFIG_X86) || defined (CONFIG_ARM64) */
 
 static int __init acpi_parse_slit(struct acpi_table_header *table)
-- 
1.7.11.7
