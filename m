From: will.deacon@arm.com (Will Deacon)
Date: Mon, 10 Jun 2013 19:34:41 +0100
Subject: [PATCH 5/9] arm64: pgtable: use pte_index instead of __pte_index
In-Reply-To: <1370889285-22799-1-git-send-email-will.deacon@arm.com>
References: <1370889285-22799-1-git-send-email-will.deacon@arm.com>
Message-ID: <1370889285-22799-6-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pte_index is a useful helper outside of arch/arm64, for things like the
ARM SMMU driver, so rename __pte_index to pte_index to be consistent
with both arch/arm/ and also the definitions of pmd_index and pgd_index.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index e333a24..b93bc23 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -119,7 +119,7 @@ extern struct page *empty_zero_page;
 #define pte_none(pte)		(!pte_val(pte))
 #define pte_clear(mm,addr,ptep)	set_pte(ptep, __pte(0))
 #define pte_page(pte)		(pfn_to_page(pte_pfn(pte)))
-#define pte_offset_kernel(dir,addr)	(pmd_page_vaddr(*(dir)) + __pte_index(addr))
+#define pte_offset_kernel(dir,addr)	(pmd_page_vaddr(*(dir)) + pte_index(addr))
 
 #define pte_offset_map(dir,addr)	pte_offset_kernel((dir), (addr))
 #define pte_offset_map_nested(dir,addr)	pte_offset_kernel((dir), (addr))
@@ -263,7 +263,7 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
 #endif
 
 /* Find an entry in the third-level page table.. */
-#define __pte_index(addr)	(((addr) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
+#define pte_index(addr)		(((addr) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
 
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
-- 
1.8.2.2
