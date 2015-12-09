From: mark.rutland@arm.com (Mark Rutland)
Date: Wed,  9 Dec 2015 12:44:46 +0000
Subject: [RFC PATCH 11/20] arm64: mm: move pte_* macros
In-Reply-To: <1449665095-20774-1-git-send-email-mark.rutland@arm.com>
References: <1449665095-20774-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1449665095-20774-12-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For pmd, pud, and pgd levels of table, functions including p?d_index and
p?d_offset are defined after the p?d_page_vaddr function for the
immediately higher level of table.

The pte functions however are defined much earlier, even though several
rely on the later definition of pmd_page_vaddr. While this isn't
currently a problem as these are macros, it prevents the logical
grouping of later C functions (which cannot rely on prototypes for
functions not yet defined).

Move these definitions after pmd_page_vaddr, for consistency with the
placement of these functions for other levels of table.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jeremy Linton <jeremy.linton@arm.com>
Cc: Laura Abbott <labbott@fedoraproject.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 00f5a4b8..738cc37 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -134,16 +134,6 @@ extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
 #define pte_clear(mm,addr,ptep)	set_pte(ptep, __pte(0))
 #define pte_page(pte)		(pfn_to_page(pte_pfn(pte)))
 
-/* Find an entry in the third-level page table. */
-#define pte_index(addr)		(((addr) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
-
-#define pte_offset_kernel(dir,addr)	(pmd_page_vaddr(*(dir)) + pte_index(addr))
-
-#define pte_offset_map(dir,addr)	pte_offset_kernel((dir), (addr))
-#define pte_offset_map_nested(dir,addr)	pte_offset_kernel((dir), (addr))
-#define pte_unmap(pte)			do { } while (0)
-#define pte_unmap_nested(pte)		do { } while (0)
-
 /*
  * The following only work if pte_present(). Undefined behaviour otherwise.
  */
@@ -425,6 +415,16 @@ static inline pte_t *pmd_page_vaddr(pmd_t pmd)
 	return __va(pmd_val(pmd) & PHYS_MASK & (s32)PAGE_MASK);
 }
 
+/* Find an entry in the third-level page table. */
+#define pte_index(addr)		(((addr) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
+
+#define pte_offset_kernel(dir,addr)	(pmd_page_vaddr(*(dir)) + pte_index(addr))
+
+#define pte_offset_map(dir,addr)	pte_offset_kernel((dir), (addr))
+#define pte_offset_map_nested(dir,addr)	pte_offset_kernel((dir), (addr))
+#define pte_unmap(pte)			do { } while (0)
+#define pte_unmap_nested(pte)		do { } while (0)
+
 #define pmd_page(pmd)		pfn_to_page(__phys_to_pfn(pmd_val(pmd) & PHYS_MASK))
 
 /*
-- 
1.9.1
