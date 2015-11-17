From: gkulkarni@caviumnetworks.com (Ganapatrao Kulkarni)
Date: Tue, 17 Nov 2015 23:55:31 +0530
Subject: [PATCH v2 2/4] acpi, numa: Replace ACPI_DEBUG_PRINT() with pr_debug()
In-Reply-To: <1447784733-10419-1-git-send-email-gkulkarni@caviumnetworks.com>
References: <1447784733-10419-1-git-send-email-gkulkarni@caviumnetworks.com>
Message-ID: <1447784733-10419-3-git-send-email-gkulkarni@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace ACPI_DEBUG_PRINT() with pr_debug() in this patch as
ACPI_DEBUG_OUTPUT is controlled by ACPICA.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/numa.c | 54 +++++++++++++++++++++--------------------------------
 1 file changed, 21 insertions(+), 33 deletions(-)

diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index 4e427fc..36683d0 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -129,64 +129,52 @@ EXPORT_SYMBOL(acpi_map_pxm_to_online_node);
 static void __init
 acpi_table_print_srat_entry(struct acpi_subtable_header *header)
 {
-
-	ACPI_FUNCTION_NAME("acpi_table_print_srat_entry");
-
 	if (!header)
 		return;
 
 	switch (header->type) {
 
 	case ACPI_SRAT_TYPE_CPU_AFFINITY:
-#ifdef ACPI_DEBUG_OUTPUT
 		{
 			struct acpi_srat_cpu_affinity *p =
 			    (struct acpi_srat_cpu_affinity *)header;
-			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-					  "SRAT Processor (id[0x%02x] eid[0x%02x]) in proximity domain %d %s\n",
-					  p->apic_id, p->local_sapic_eid,
-					  p->proximity_domain_lo,
-					  (p->flags & ACPI_SRAT_CPU_ENABLED)?
-					  "enabled" : "disabled"));
+			pr_debug("SRAT Processor (id[0x%02x] eid[0x%02x]) in proximity domain %d %s\n",
+				 p->apic_id, p->local_sapic_eid,
+				 p->proximity_domain_lo,
+				 (p->flags & ACPI_SRAT_CPU_ENABLED) ?
+				 "enabled" : "disabled");
 		}
-#endif				/* ACPI_DEBUG_OUTPUT */
 		break;
 
 	case ACPI_SRAT_TYPE_MEMORY_AFFINITY:
-#ifdef ACPI_DEBUG_OUTPUT
 		{
 			struct acpi_srat_mem_affinity *p =
 			    (struct acpi_srat_mem_affinity *)header;
-			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-					  "SRAT Memory (0x%lx length 0x%lx) in proximity domain %d %s%s%s\n",
-					  (unsigned long)p->base_address,
-					  (unsigned long)p->length,
-					  p->proximity_domain,
-					  (p->flags & ACPI_SRAT_MEM_ENABLED)?
-					  "enabled" : "disabled",
-					  (p->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE)?
-					  " hot-pluggable" : "",
-					  (p->flags & ACPI_SRAT_MEM_NON_VOLATILE)?
-					  " non-volatile" : ""));
+			pr_debug("SRAT Memory (0x%lx length 0x%lx) in proximity domain %d %s%s%s\n",
+				 (unsigned long)p->base_address,
+				 (unsigned long)p->length,
+				 p->proximity_domain,
+				 (p->flags & ACPI_SRAT_MEM_ENABLED) ?
+				 "enabled" : "disabled",
+				 (p->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE) ?
+				 " hot-pluggable" : "",
+				 (p->flags & ACPI_SRAT_MEM_NON_VOLATILE) ?
+				 " non-volatile" : "");
 		}
-#endif				/* ACPI_DEBUG_OUTPUT */
 		break;
 
 	case ACPI_SRAT_TYPE_X2APIC_CPU_AFFINITY:
-#ifdef ACPI_DEBUG_OUTPUT
 		{
 			struct acpi_srat_x2apic_cpu_affinity *p =
 			    (struct acpi_srat_x2apic_cpu_affinity *)header;
-			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-					  "SRAT Processor (x2apicid[0x%08x]) in"
-					  " proximity domain %d %s\n",
-					  p->apic_id,
-					  p->proximity_domain,
-					  (p->flags & ACPI_SRAT_CPU_ENABLED) ?
-					  "enabled" : "disabled"));
+			pr_debug("SRAT Processor (x2apicid[0x%08x]) in proximity domain %d %s\n",
+				 p->apic_id,
+				 p->proximity_domain,
+				 (p->flags & ACPI_SRAT_CPU_ENABLED) ?
+				 "enabled" : "disabled");
 		}
-#endif				/* ACPI_DEBUG_OUTPUT */
 		break;
+
 	default:
 		pr_warn("Found unsupported SRAT entry (type = 0x%x)\n",
 			header->type);
-- 
1.8.1.4
