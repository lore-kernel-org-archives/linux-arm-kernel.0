From: js07.lee@gmail.com (Jungseung Lee)
Date: Wed, 26 Nov 2014 22:34:00 +0900
Subject: [PATCH v3] arm: Support for the PXN CPU feature on ARMv7
Message-ID: <1417008840-27591-1-git-send-email-js07.lee@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Modern ARMv7-A/R cores optionally implement below new
hardware feature:

- PXN:
Privileged execute-never(PXN) is a security feature. PXN bit
determines whether the processor can execute software from
the region. This is effective solution against ret2usr attack.
On an implementation that does not include the LPAE, PXN is
optionally supported.

This patch set PXN bit on user page table for preventing
user code execution with privilege mode.

Signed-off-by: Jungseung Lee <js07.lee@gmail.com>
---
 arch/arm/include/asm/pgalloc.h              | 28 +++++++++++++++++++++++++++-
 arch/arm/include/asm/pgtable-2level-hwdef.h |  2 ++
 arch/arm/include/asm/pgtable-3level-hwdef.h |  1 +
 arch/arm/mm/mmu.c                           |  5 +++++
 4 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/pgalloc.h b/arch/arm/include/asm/pgalloc.h
index 78a7793..69e565e 100644
--- a/arch/arm/include/asm/pgalloc.h
+++ b/arch/arm/include/asm/pgalloc.h
@@ -17,6 +17,8 @@
 #include <asm/processor.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
+#include <asm/cputype.h>
+#include <asm/system_info.h>
 
 #define check_pgt_cache()		do { } while (0)
 
@@ -25,6 +27,26 @@
 #define _PAGE_USER_TABLE	(PMD_TYPE_TABLE | PMD_BIT4 | PMD_DOMAIN(DOMAIN_USER))
 #define _PAGE_KERNEL_TABLE	(PMD_TYPE_TABLE | PMD_BIT4 | PMD_DOMAIN(DOMAIN_KERNEL))
 
+/*
+ * Once this call has completed the variable @vmsa is set to 'VMSA support'
+ * in case of ARMv7.
+ */
+static inline bool cpu_has_classic_pxn(void)
+{
+	if (__LINUX_ARM_ARCH__ >= 6 && !IS_ENABLED(CONFIG_ARM_LPAE)) {
+		static unsigned int vmsa = ~0UL;
+
+		if (cpu_architecture() != CPU_ARCH_ARMv7)
+			return false;
+		if (vmsa == 4)
+			return true;
+
+		vmsa = (read_cpuid_ext(CPUID_EXT_MMFR0) & 0xf) >> 0;
+		return vmsa == 4;
+	} else
+		return false;
+}
+
 #ifdef CONFIG_ARM_LPAE
 
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
@@ -157,7 +179,11 @@ pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp, pte_t *ptep)
 static inline void
 pmd_populate(struct mm_struct *mm, pmd_t *pmdp, pgtable_t ptep)
 {
-	__pmd_populate(pmdp, page_to_phys(ptep), _PAGE_USER_TABLE);
+	pmdval_t pmdval = _PAGE_USER_TABLE;
+
+	if (cpu_has_classic_pxn())
+		pmdval |= PMD_PXNTABLE;
+	__pmd_populate(pmdp, page_to_phys(ptep), pmdval);
 }
 #define pmd_pgtable(pmd) pmd_page(pmd)
 
diff --git a/arch/arm/include/asm/pgtable-2level-hwdef.h b/arch/arm/include/asm/pgtable-2level-hwdef.h
index 5cfba15..5e68278 100644
--- a/arch/arm/include/asm/pgtable-2level-hwdef.h
+++ b/arch/arm/include/asm/pgtable-2level-hwdef.h
@@ -20,12 +20,14 @@
 #define PMD_TYPE_FAULT		(_AT(pmdval_t, 0) << 0)
 #define PMD_TYPE_TABLE		(_AT(pmdval_t, 1) << 0)
 #define PMD_TYPE_SECT		(_AT(pmdval_t, 2) << 0)
+#define PMD_PXNTABLE		(_AT(pmdval_t, 1) << 2)     /* v7 */
 #define PMD_BIT4		(_AT(pmdval_t, 1) << 4)
 #define PMD_DOMAIN(x)		(_AT(pmdval_t, (x)) << 5)
 #define PMD_PROTECTION		(_AT(pmdval_t, 1) << 9)		/* v5 */
 /*
  *   - section
  */
+#define PMD_SECT_PXN    (_AT(pmdval_t, 1) << 0)     /* v7 */
 #define PMD_SECT_BUFFERABLE	(_AT(pmdval_t, 1) << 2)
 #define PMD_SECT_CACHEABLE	(_AT(pmdval_t, 1) << 3)
 #define PMD_SECT_XN		(_AT(pmdval_t, 1) << 4)		/* v6 */
diff --git a/arch/arm/include/asm/pgtable-3level-hwdef.h b/arch/arm/include/asm/pgtable-3level-hwdef.h
index 9fd61c7..f8f1cff 100644
--- a/arch/arm/include/asm/pgtable-3level-hwdef.h
+++ b/arch/arm/include/asm/pgtable-3level-hwdef.h
@@ -76,6 +76,7 @@
 #define PTE_EXT_SHARED		(_AT(pteval_t, 3) << 8)		/* SH[1:0], inner shareable */
 #define PTE_EXT_AF		(_AT(pteval_t, 1) << 10)	/* Access Flag */
 #define PTE_EXT_NG		(_AT(pteval_t, 1) << 11)	/* nG */
+#define PTE_EXT_PXN		(_AT(pteval_t, 1) << 53)	/* PXN */
 #define PTE_EXT_XN		(_AT(pteval_t, 1) << 54)	/* XN */
 
 /*
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 9f98cec..5b0a047 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -605,6 +605,11 @@ static void __init build_mem_type_table(void)
 	}
 	kern_pgprot |= PTE_EXT_AF;
 	vecs_pgprot |= PTE_EXT_AF;
+
+	/*
+	 * Set PXN for user mappings
+	 */
+	user_pgprot |= PTE_EXT_PXN;
 #endif
 
 	for (i = 0; i < 16; i++) {
-- 
1.9.1
