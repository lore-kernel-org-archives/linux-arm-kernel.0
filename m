From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 27 Nov 2018 17:59:12 +0000
Subject: [RESEND PATCH] arm64: acpi: Prepare for longer MADTs
Message-ID: <20181127175912.2651-1-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jeremy Linton <jeremy.linton@arm.com>

The BAD_MADT_GICC_ENTRY check is a little too strict because
it rejects MADT entries that don't match the currently known
lengths. We should remove this restriction to avoid problems
if the table length changes. Future code which might depend on
additional fields should be written to validate those fields
before using them, rather than trying to globally check
known MADT version lengths.

Link: https://lkml.kernel.org/r/20181012192937.3819951-1-jeremy.linton at arm.com
Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
[lorenzo.pieralisi at arm.com: added MADT macro comments]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Al Stone <ahs3@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
---
Hi Will, Catalin,

resending a patch already posted on public mailing lists[1], I have
just added a comment to the existing patch for future reference as
discussed in [1], please consider merging it.

Thanks,
Lorenzo

[1] https://lore.kernel.org/lkml/20181012192937.3819951-1-jeremy.linton at arm.com/T/#u

 arch/arm64/include/asm/acpi.h | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index 709208dfdc8b..2def77ec14be 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -22,12 +22,23 @@
 #include <asm/tlbflush.h>
 
 /* Macros for consistency checks of the GICC subtable of MADT */
-#define ACPI_MADT_GICC_LENGTH	\
-	(acpi_gbl_FADT.header.revision < 6 ? 76 : 80)
+
+/*
+ * MADT GICC minimum length refers to the MADT GICC structure table length as
+ * defined in the earliest ACPI version supported on arm64, ie ACPI 5.1.
+ *
+ * The efficiency_class member was added to the
+ * struct acpi_madt_generic_interrupt to represent the MADT GICC structure
+ * "Processor Power Efficiency Class" field, added in ACPI 6.0 whose offset
+ * is therefore used to delimit the MADT GICC structure minimum length
+ * appropriately.
+ */
+#define ACPI_MADT_GICC_MIN_LENGTH   ACPI_OFFSET(  \
+	struct acpi_madt_generic_interrupt, efficiency_class)
 
 #define BAD_MADT_GICC_ENTRY(entry, end)					\
-	(!(entry) || (entry)->header.length != ACPI_MADT_GICC_LENGTH ||	\
-	(unsigned long)(entry) + ACPI_MADT_GICC_LENGTH > (end))
+	(!(entry) || (entry)->header.length < ACPI_MADT_GICC_MIN_LENGTH || \
+	(unsigned long)(entry) + (entry)->header.length > (end))
 
 /* Basic configuration for ACPI */
 #ifdef	CONFIG_ACPI
-- 
2.19.2
