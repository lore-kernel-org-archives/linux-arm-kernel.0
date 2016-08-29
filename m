From: jeremy.linton@arm.com (Jeremy Linton)
Date: Mon, 29 Aug 2016 16:48:15 -0500
Subject: [PATCH v8 4/9] arm64: Rename the common MADT parse routine
In-Reply-To: <1472507300-9844-1-git-send-email-jeremy.linton@arm.com>
References: <1472507300-9844-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <1472507300-9844-5-git-send-email-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MADT parser in smp.c is now being used to parse
out NUMA, PMU and ACPI parking protocol information as
well as the GIC information for which it was originally
created. Rename it to avoid a misleading name.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/kernel/smp.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index d93d433..a6552fe 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -506,13 +506,14 @@ static unsigned int cpu_count = 1;
 
 #ifdef CONFIG_ACPI
 /*
- * acpi_map_gic_cpu_interface - parse processor MADT entry
+ * acpi_verify_and_map_madt - parse processor MADT entry
  *
  * Carry out sanity checks on MADT processor entry and initialize
- * cpu_logical_map on success
+ * cpu_logical_map, the ACPI parking protocol, NUMA mapping
+ * and the PMU interrupts on success
  */
 static void __init
-acpi_map_gic_cpu_interface(struct acpi_madt_generic_interrupt *processor)
+acpi_verify_and_map_madt(struct acpi_madt_generic_interrupt *processor)
 {
 	u64 hwid = processor->arm_mpidr;
 
@@ -565,7 +566,7 @@ acpi_map_gic_cpu_interface(struct acpi_madt_generic_interrupt *processor)
 }
 
 static int __init
-acpi_parse_gic_cpu_interface(struct acpi_subtable_header *header,
+acpi_parse_madt_common(struct acpi_subtable_header *header,
 			     const unsigned long end)
 {
 	struct acpi_madt_generic_interrupt *processor;
@@ -576,7 +577,7 @@ acpi_parse_gic_cpu_interface(struct acpi_subtable_header *header,
 
 	acpi_table_print_madt_entry(header);
 
-	acpi_map_gic_cpu_interface(processor);
+	acpi_verify_and_map_madt(processor);
 
 	return 0;
 }
@@ -659,7 +660,7 @@ void __init smp_init_cpus(void)
 		 * we need for SMP init
 		 */
 		acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_INTERRUPT,
-				      acpi_parse_gic_cpu_interface, 0);
+				      acpi_parse_madt_common, 0);
 
 	if (cpu_count > nr_cpu_ids)
 		pr_warn("Number of cores (%d) exceeds configured maximum of %d - clipping\n",
-- 
2.5.5
