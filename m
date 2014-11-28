From: js07.lee@gmail.com (Jungseung Lee)
Date: Sat, 29 Nov 2014 00:44:51 +0900
Subject: [PATCH v5] arm: Support for the PXN CPU feature on ARMv7
Message-ID: <1417189491-4619-1-git-send-email-js07.lee@gmail.com>
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

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Jungseung Lee <js07.lee@gmail.com>
---
 arch/arm/include/asm/pgalloc.h              | 10 +++++++++-
 arch/arm/include/asm/pgtable-2level-hwdef.h |  2 ++
 arch/arm/include/asm/pgtable-3level-hwdef.h |  1 +
 arch/arm/mm/mmu.c                           | 18 +++++++++++++++++-
 4 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/pgalloc.h b/arch/arm/include/asm/pgalloc.h
index 78a7793..19cfab5 100644
--- a/arch/arm/include/asm/pgalloc.h
+++ b/arch/arm/include/asm/pgalloc.h
@@ -157,7 +157,15 @@ pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp, pte_t *ptep)
 static inline void
 pmd_populate(struct mm_struct *mm, pmd_t *pmdp, pgtable_t ptep)
 {
-	__pmd_populate(pmdp, page_to_phys(ptep), _PAGE_USER_TABLE);
+	extern pmdval_t user_pmd_table;
+	pmdval_t prot;
+
+	if (__LINUX_ARM_ARCH__ >= 6 && !IS_ENABLED(CONFIG_ARM_LPAE))
+		prot = user_pmd_table;
+	else
+		prot = _PAGE_USER_TABLE;
+
+	__pmd_populate(pmdp, page_to_phys(ptep), prot);
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
index 9f98cec..1dd0dd5 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -52,6 +52,8 @@ EXPORT_SYMBOL(empty_zero_page);
  */
 pmd_t *top_pmd;
 
+pmdval_t user_pmd_table = _PAGE_USER_TABLE;
+
 #define CPOLICY_UNCACHED	0
 #define CPOLICY_BUFFERED	1
 #define CPOLICY_WRITETHROUGH	2
@@ -528,14 +530,23 @@ static void __init build_mem_type_table(void)
 	hyp_device_pgprot = mem_types[MT_DEVICE].prot_pte;
 	s2_device_pgprot = mem_types[MT_DEVICE].prot_pte_s2;
 
+#ifndef CONFIG_ARM_LPAE
 	/*
 	 * We don't use domains on ARMv6 (since this causes problems with
 	 * v6/v7 kernels), so we must use a separate memory type for user
 	 * r/o, kernel r/w to map the vectors page.
 	 */
-#ifndef CONFIG_ARM_LPAE
 	if (cpu_arch == CPU_ARCH_ARMv6)
 		vecs_pgprot |= L_PTE_MT_VECTORS;
+
+	/*
+	 * Check is it with support for the PXN bit
+	 * in the Short-descriptor translation table format descriptors.
+	 */
+	if (cpu_arch == CPU_ARCH_ARMv7 &&
+		(read_cpuid_ext(CPUID_EXT_MMFR0) & 0xF) == 4) {
+		user_pmd_table |= PMD_PXNTABLE;
+	}
 #endif
 
 	/*
@@ -605,6 +616,11 @@ static void __init build_mem_type_table(void)
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
