From: guohanjun@huawei.com (Hanjun Guo)
Date: Sat, 23 Jan 2016 17:39:24 +0800
Subject: [PATCH v3 09/12] x86, acpi,
 numa: cleanup acpi_numa_processor_affinity_init()
In-Reply-To: <1453541967-3744-1-git-send-email-guohanjun@huawei.com>
References: <1453541967-3744-1-git-send-email-guohanjun@huawei.com>
Message-ID: <1453541967-3744-10-git-send-email-guohanjun@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanjun Guo <hanjun.guo@linaro.org>

Cleanup acpi_numa_processor_affinity_init() and prepare
move it to common palce then it can be reused by other
arch, this should no functional change.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/x86/mm/srat.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/arch/x86/mm/srat.c b/arch/x86/mm/srat.c
index 92a640a..304cdf2 100644
--- a/arch/x86/mm/srat.c
+++ b/arch/x86/mm/srat.c
@@ -26,11 +26,6 @@
 
 int acpi_numa __initdata;
 
-static __init int setup_node(int pxm)
-{
-	return acpi_map_pxm_to_node(pxm);
-}
-
 static __init void bad_srat(void)
 {
 	printk(KERN_ERR "SRAT: SRAT not used.\n");
@@ -64,7 +59,7 @@ acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinity *pa)
 			 pxm, apic_id);
 		return;
 	}
-	node = setup_node(pxm);
+	node = acpi_map_pxm_to_node(pxm);
 	if (node < 0) {
 		printk(KERN_ERR "SRAT: Too many proximity domains %x\n", pxm);
 		bad_srat();
@@ -100,7 +95,7 @@ acpi_numa_processor_affinity_init(struct acpi_srat_cpu_affinity *pa)
 	pxm = pa->proximity_domain_lo;
 	if (acpi_srat_revision >= 2)
 		pxm |= *((unsigned int*)pa->proximity_domain_hi) << 8;
-	node = setup_node(pxm);
+	node = acpi_map_pxm_to_node(pxm);
 	if (node < 0) {
 		printk(KERN_ERR "SRAT: Too many proximity domains %x\n", pxm);
 		bad_srat();
@@ -124,12 +119,6 @@ acpi_numa_processor_affinity_init(struct acpi_srat_cpu_affinity *pa)
 	       pxm, apic_id, node);
 }
 
-#ifdef CONFIG_MEMORY_HOTPLUG
-static inline int save_add_info(void) {return 1;}
-#else
-static inline int save_add_info(void) {return 0;}
-#endif
-
 /* Callback for parsing of the Proximity Domain <-> Memory Area mappings */
 int __init
 acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
@@ -145,7 +134,7 @@ acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
 	if ((ma->flags & ACPI_SRAT_MEM_ENABLED) == 0)
 		goto out_err;
 	hotpluggable = ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE;
-	if (hotpluggable && !save_add_info())
+	if (hotpluggable && !IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
 		goto out_err;
 
 	start = ma->base_address;
@@ -154,7 +143,7 @@ acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
 	if (acpi_srat_revision <= 1)
 		pxm &= 0xff;
 
-	node = setup_node(pxm);
+	node = acpi_map_pxm_to_node(pxm);
 	if (node < 0) {
 		printk(KERN_ERR "SRAT: Too many proximity domains.\n");
 		goto out_err_bad_srat;
@@ -180,7 +169,7 @@ acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
 out_err_bad_srat:
 	bad_srat();
 out_err:
-	return -1;
+	return -EINVAL;
 }
 
 int __init x86_acpi_numa_init(void)
-- 
1.9.1
