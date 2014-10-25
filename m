From: js07.lee@gmail.com (Jungseung Lee)
Date: Sun, 26 Oct 2014 02:59:57 +0900
Subject: [PATCH] arm: Support for the PXN CPU feature on ARMv7.
Message-ID: <1414259997-9350-1-git-send-email-js07.lee@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Modern ARMv7-A/R cores can optionally implement below new
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
 arch/arm/include/asm/pgalloc.h              | 12 +++++++++++-
 arch/arm/include/asm/pgtable-2level-hwdef.h |  2 ++
 arch/arm/kernel/setup.c                     |  7 +++++++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/pgalloc.h b/arch/arm/include/asm/pgalloc.h
index 78a7793..a931544 100644
--- a/arch/arm/include/asm/pgalloc.h
+++ b/arch/arm/include/asm/pgalloc.h
@@ -25,6 +25,10 @@
 #define _PAGE_USER_TABLE	(PMD_TYPE_TABLE | PMD_BIT4 | PMD_DOMAIN(DOMAIN_USER))
 #define _PAGE_KERNEL_TABLE	(PMD_TYPE_TABLE | PMD_BIT4 | PMD_DOMAIN(DOMAIN_KERNEL))
 
+#ifdef CONFIG_CPU_V7
+extern bool cpu_has_pxn;
+#endif
+
 #ifdef CONFIG_ARM_LPAE
 
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
@@ -157,7 +161,13 @@ pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp, pte_t *ptep)
 static inline void
 pmd_populate(struct mm_struct *mm, pmd_t *pmdp, pgtable_t ptep)
 {
-	__pmd_populate(pmdp, page_to_phys(ptep), _PAGE_USER_TABLE);
+#ifdef CONFIG_CPU_V7
+	if (cpu_has_pxn)
+		__pmd_populate(pmdp, page_to_phys(ptep),
+				_PAGE_USER_TABLE | PMD_PXNTABLE);
+	else
+#endif
+		__pmd_populate(pmdp, page_to_phys(ptep), _PAGE_USER_TABLE);
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
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index c031063..8556044 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -104,6 +104,9 @@ EXPORT_SYMBOL(elf_hwcap);
 unsigned int elf_hwcap2 __read_mostly;
 EXPORT_SYMBOL(elf_hwcap2);
 
+#ifdef CONFIG_CPU_V7
+bool cpu_has_pxn;
+#endif
 
 #ifdef MULTI_CPU
 struct processor processor __read_mostly;
@@ -390,6 +393,10 @@ static void __init cpuid_init_hwcaps(void)
 
 	/* LPAE implies atomic ldrd/strd instructions */
 	vmsa = (read_cpuid_ext(CPUID_EXT_MMFR0) & 0xf) >> 0;
+#ifdef CONFIG_CPU_V7
+	if (vmsa >= 4)
+		cpu_has_pxn = 1;
+#endif
 	if (vmsa >= 5)
 		elf_hwcap |= HWCAP_LPAE;
 }
-- 
1.9.1
