From: shannon.zhao@linaro.org (shannon.zhao at linaro.org)
Date: Tue, 17 Nov 2015 17:40:05 +0800
Subject: [PATCH v3 06/62] acpi: Refactor acpi_os_map_memory to be
 architecturally independent
In-Reply-To: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
Message-ID: <1447753261-7552-7-git-send-email-shannon.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shannon Zhao <shannon.zhao@linaro.org>

Current acpi_os_map_memory is specific to x86. Refactor it to be
architecturally independent.

Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 xen/arch/x86/acpi/lib.c | 16 ++++++++++++++++
 xen/drivers/acpi/osl.c  | 12 +-----------
 xen/include/xen/acpi.h  |  2 ++
 3 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/xen/arch/x86/acpi/lib.c b/xen/arch/x86/acpi/lib.c
index cc15ea3..1e2e124 100644
--- a/xen/arch/x86/acpi/lib.c
+++ b/xen/arch/x86/acpi/lib.c
@@ -33,6 +33,22 @@ u8 __read_mostly acpi_disable_value;
 u32 __read_mostly x86_acpiid_to_apicid[MAX_MADT_ENTRIES] =
     {[0 ... MAX_MADT_ENTRIES - 1] = BAD_APICID };
 
+void __iomem *
+arch_acpi_os_map_memory(acpi_physical_address phys, acpi_size size)
+{
+	if (system_state >= SYS_STATE_active) {
+		mfn_t mfn = _mfn(PFN_DOWN(phys));
+		unsigned int offs = phys & (PAGE_SIZE - 1);
+
+		/* The low first Mb is always mapped. */
+		if ( !((phys + size - 1) >> 20) )
+			return __va(phys);
+		return __vmap(&mfn, PFN_UP(offs + size), 1, 1,
+			      PAGE_HYPERVISOR_NOCACHE) + offs;
+	}
+	return __acpi_map_table(phys, size);
+}
+
 /*
  * Important Safety Note:  The fixed ACPI page numbers are *subtracted*
  * from the fixed base.  That's why we start at FIX_ACPI_END and
diff --git a/xen/drivers/acpi/osl.c b/xen/drivers/acpi/osl.c
index db74a90..54fb0f0 100644
--- a/xen/drivers/acpi/osl.c
+++ b/xen/drivers/acpi/osl.c
@@ -88,17 +88,7 @@ acpi_physical_address __init acpi_os_get_root_pointer(void)
 void __iomem *
 acpi_os_map_memory(acpi_physical_address phys, acpi_size size)
 {
-	if (system_state >= SYS_STATE_active) {
-		mfn_t mfn = _mfn(PFN_DOWN(phys));
-		unsigned int offs = phys & (PAGE_SIZE - 1);
-
-		/* The low first Mb is always mapped. */
-		if ( !((phys + size - 1) >> 20) )
-			return __va(phys);
-		return __vmap(&mfn, PFN_UP(offs + size), 1, 1,
-			      PAGE_HYPERVISOR_NOCACHE) + offs;
-	}
-	return __acpi_map_table(phys, size);
+	return arch_acpi_os_map_memory(phys, size);
 }
 
 void acpi_os_unmap_memory(void __iomem * virt, acpi_size size)
diff --git a/xen/include/xen/acpi.h b/xen/include/xen/acpi.h
index 0f1077d..48d7810 100644
--- a/xen/include/xen/acpi.h
+++ b/xen/include/xen/acpi.h
@@ -54,6 +54,8 @@ typedef int (*acpi_table_handler) (struct acpi_table_header *table);
 
 typedef int (*acpi_table_entry_handler) (struct acpi_subtable_header *header, const unsigned long end);
 
+void __iomem *
+arch_acpi_os_map_memory(acpi_physical_address phys, acpi_size size);
 unsigned int acpi_get_processor_id (unsigned int cpu);
 char * __acpi_map_table (paddr_t phys_addr, unsigned long size);
 int acpi_boot_init (void);
-- 
2.1.0
