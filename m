From: shannon.zhao@linaro.org (shannon.zhao at linaro.org)
Date: Tue, 17 Nov 2015 17:40:40 +0800
Subject: [PATCH v3 41/62] arm/acpi: Add a helper function to get the acpi
 table offset
In-Reply-To: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
Message-ID: <1447753261-7552-42-git-send-email-shannon.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shannon Zhao <shannon.zhao@linaro.org>

Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 xen/arch/arm/acpi/lib.c    | 13 +++++++++++++
 xen/include/asm-arm/acpi.h |  6 ++++++
 2 files changed, 19 insertions(+)

diff --git a/xen/arch/arm/acpi/lib.c b/xen/arch/arm/acpi/lib.c
index 47f4c6a..d6044ef 100644
--- a/xen/arch/arm/acpi/lib.c
+++ b/xen/arch/arm/acpi/lib.c
@@ -70,3 +70,16 @@ unsigned int acpi_get_irq_type(u32 flags)
         return ACPI_IRQ_TYPE_NONE;
     }
 }
+
+unsigned int acpi_get_table_offset(struct membank tbl_add[], EFI_MEM_RES index)
+{
+    int i;
+    unsigned int offset = 0;
+
+    for ( i = 0; i < index; i++ )
+    {
+        offset += PAGE_ALIGN(tbl_add[i].size);
+    }
+
+    return offset;
+}
diff --git a/xen/include/asm-arm/acpi.h b/xen/include/asm-arm/acpi.h
index f159d51..628f3c8 100644
--- a/xen/include/asm-arm/acpi.h
+++ b/xen/include/asm-arm/acpi.h
@@ -24,6 +24,7 @@
 #define _ASM_ARM_ACPI_H
 
 #include <xen/init.h>
+#include <asm/setup.h>
 
 #define COMPILER_DEPENDENT_INT64   long long
 #define COMPILER_DEPENDENT_UINT64  unsigned long long
@@ -47,11 +48,16 @@ bool_t __init acpi_psci_present(void);
 bool_t __init acpi_psci_hvc_present(void);
 void __init acpi_smp_init_cpus(void);
 unsigned int acpi_get_irq_type(u32 flags);
+unsigned int acpi_get_table_offset(struct membank tbl_add[], EFI_MEM_RES index);
 #else
 static inline bool_t acpi_psci_present(void) { return false; }
 static inline bool_t acpi_psci_hvc_present(void) {return false; }
 static inline void acpi_smp_init_cpus(void) { }
 static inline unsigned int acpi_get_irq_type(u32 flags) { return 0; }
+unsigned int acpi_get_table_offset(struct membank tbl_add[], EFI_MEM_RES index)
+{
+    return 0;
+}
 #endif /* CONFIG_ACPI */
 
 /* Basic configuration for ACPI */
-- 
2.1.0
