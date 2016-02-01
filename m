From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  1 Feb 2016 11:54:49 +0100
Subject: [PATCH v5sub1 4/8] arm64: pgtable: implement static
 [pte|pmd|pud]_offset variants
In-Reply-To: <1454324093-15998-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1454324093-15998-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1454324093-15998-5-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The page table accessors pte_offset(), pud_offset() and pmd_offset()
rely on __va translations, so they can only be used after the linear
mapping has been installed. For the early fixmap and kasan init routines,
whose page tables are allocated statically in the kernel image, these
functions will return bogus values. So implement pte_offset_kimg(),
pmd_offset_kimg() and pud_offset_kimg(), which can be used instead
before any page tables have been allocated dynamically.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/pgtable.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 4229f75fd145..87355408d448 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -445,6 +445,9 @@ static inline phys_addr_t pmd_page_paddr(pmd_t pmd)
 
 #define pmd_page(pmd)		pfn_to_page(__phys_to_pfn(pmd_val(pmd) & PHYS_MASK))
 
+/* use ONLY for statically allocated translation tables */
+#define pte_offset_kimg(dir,addr)	((pte_t *)__phys_to_kimg(pte_offset_phys((dir), (addr))))
+
 /*
  * Conversion functions: convert a page and protection to a page entry,
  * and a page entry and page directory to the page they refer to.
@@ -488,6 +491,9 @@ static inline phys_addr_t pud_page_paddr(pud_t pud)
 
 #define pud_page(pud)		pfn_to_page(__phys_to_pfn(pud_val(pud) & PHYS_MASK))
 
+/* use ONLY for statically allocated translation tables */
+#define pmd_offset_kimg(dir,addr)	((pmd_t *)__phys_to_kimg(pmd_offset_phys((dir), (addr))))
+
 #else
 
 #define pud_page_paddr(pud)	({ BUILD_BUG(); 0; })
@@ -497,6 +503,8 @@ static inline phys_addr_t pud_page_paddr(pud_t pud)
 #define pmd_set_fixmap_offset(pudp, addr)	((pmd_t *)pudp)
 #define pmd_clear_fixmap()
 
+#define pmd_offset_kimg(dir,addr)	((pmd_t *)dir)
+
 #endif	/* CONFIG_PGTABLE_LEVELS > 2 */
 
 #if CONFIG_PGTABLE_LEVELS > 3
@@ -535,6 +543,9 @@ static inline phys_addr_t pgd_page_paddr(pgd_t pgd)
 
 #define pgd_page(pgd)		pfn_to_page(__phys_to_pfn(pgd_val(pgd) & PHYS_MASK))
 
+/* use ONLY for statically allocated translation tables */
+#define pud_offset_kimg(dir,addr)	((pud_t *)__phys_to_kimg(pud_offset_phys((dir), (addr))))
+
 #else
 
 #define pgd_page_paddr(pgd)	({ BUILD_BUG(); 0;})
@@ -544,6 +555,8 @@ static inline phys_addr_t pgd_page_paddr(pgd_t pgd)
 #define pud_set_fixmap_offset(pgdp, addr)	((pud_t *)pgdp)
 #define pud_clear_fixmap()
 
+#define pud_offset_kimg(dir,addr)	((pud_t *)dir)
+
 #endif  /* CONFIG_PGTABLE_LEVELS > 3 */
 
 #define pgd_ERROR(pgd)		__pgd_error(__FILE__, __LINE__, pgd_val(pgd))
-- 
2.5.0
