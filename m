From: jeremy.linton@arm.com (Jeremy Linton)
Date: Tue, 21 Jun 2016 12:11:42 -0500
Subject: [PATCH 04/11] arm64: Rename the common MADT parse routine
In-Reply-To: <1466529109-21715-1-git-send-email-jeremy.linton@arm.com>
References: <1466529109-21715-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <1466529109-21715-5-git-send-email-jeremy.linton@arm.com>
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
index d099306..319f48b 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -507,13 +507,14 @@ static unsigned int cpu_count = 1;
 
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
 
@@ -566,7 +567,7 @@ acpi_map_gic_cpu_interface(struct acpi_madt_generic_interrupt *processor)
 }
 
 static int __init
-acpi_parse_gic_cpu_interface(struct acpi_subtable_header *header,
+acpi_parse_madt_common(struct acpi_subtable_header *header,
 			     const unsigned long end)
 {
 	struct acpi_madt_generic_interrupt *processor;
@@ -577,7 +578,7 @@ acpi_parse_gic_cpu_interface(struct acpi_subtable_header *header,
 
 	acpi_table_print_madt_entry(header);
 
-	acpi_map_gic_cpu_interface(processor);
+	acpi_verify_and_map_madt(processor);
 
 	return 0;
 }
@@ -660,7 +661,7 @@ void __init smp_init_cpus(void)
 		 * we need for SMP init
 		 */
 		acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_INTERRUPT,
-				      acpi_parse_gic_cpu_interface, 0);
+				      acpi_parse_madt_common, 0);
 
 	if (cpu_count > NR_CPUS)
 		pr_warn("no. of cores (%d) greater than configured maximum of %d - clipping\n",
-- 
2.5.5
