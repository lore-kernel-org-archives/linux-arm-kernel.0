From: js07.lee@gmail.com (Jungseung Lee)
Date: Fri, 24 Oct 2014 18:57:35 +0900
Subject: [PATCH 2/2] arm: Support for the PXN CPU feature on ARMv7.
In-Reply-To: <1414144655-25204-1-git-send-email-js07.lee@gmail.com>
References: <1414144655-25204-1-git-send-email-js07.lee@gmail.com>
Message-ID: <1414144655-25204-2-git-send-email-js07.lee@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- PXN:
Privileged execute-never(PXN) is a security feature. PXN bits
determines whether the processor can execute software from
the region. This is effective solution against ret2usr attack.

This patch set PXN bit on user page table for preventing
user code execution with privilege mode.

Signed-off-by: Jungseung Lee <js07.lee@gmail.com>
---
 arch/arm/include/asm/pgalloc.h              | 8 +++++++-
 arch/arm/include/asm/pgtable-2level-hwdef.h | 2 ++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/pgalloc.h b/arch/arm/include/asm/pgalloc.h
index 78a7793..f4f4fd3 100644
--- a/arch/arm/include/asm/pgalloc.h
+++ b/arch/arm/include/asm/pgalloc.h
@@ -157,7 +157,13 @@ pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp, pte_t *ptep)
 static inline void
 pmd_populate(struct mm_struct *mm, pmd_t *pmdp, pgtable_t ptep)
 {
-	__pmd_populate(pmdp, page_to_phys(ptep), _PAGE_USER_TABLE);
+#ifdef CONFIG_CPU_V7
+	if (elf_hwcap & HWCAP_PXN)
+		__pmd_populate(pmdp, page_to_phys(ptep),
+				_PAGE_USER_TABLE | PMD_PXNTABLE);
+	else
+#endif
+		__pmd_populate(pmdp, page_to_phys(ptep), _PAGE_USER_TABLE);
 }
 #define pmd_pgtable(pmd) pmd_page(pmd)
 
diff --git a/arch/arm/include/asm/pgtable-2level-hwdef.h b/arch/arm/include/asm/pgtable-2level-hwdef.h
index 5cfba15..89a620f 100644
--- a/arch/arm/include/asm/pgtable-2level-hwdef.h
+++ b/arch/arm/include/asm/pgtable-2level-hwdef.h
@@ -20,12 +20,14 @@
 #define PMD_TYPE_FAULT		(_AT(pmdval_t, 0) << 0)
 #define PMD_TYPE_TABLE		(_AT(pmdval_t, 1) << 0)
 #define PMD_TYPE_SECT		(_AT(pmdval_t, 2) << 0)
+#define PMD_PXNTABLE		(_AT(pmdval_t, 1) << 2)     /* v7 (optional) */
 #define PMD_BIT4		(_AT(pmdval_t, 1) << 4)
 #define PMD_DOMAIN(x)		(_AT(pmdval_t, (x)) << 5)
 #define PMD_PROTECTION		(_AT(pmdval_t, 1) << 9)		/* v5 */
 /*
  *   - section
  */
+#define PMD_SECT_PXN    (_AT(pmdval_t, 1) << 0)     /* v7 (optional) */
 #define PMD_SECT_BUFFERABLE	(_AT(pmdval_t, 1) << 2)
 #define PMD_SECT_CACHEABLE	(_AT(pmdval_t, 1) << 3)
 #define PMD_SECT_XN		(_AT(pmdval_t, 1) << 4)		/* v6 */
-- 
1.9.1
