From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu,  5 May 2016 10:44:01 +0100
Subject: [PATCH 3/4] arm64: Replace hard-coded values in the pmd/pud_bad()
 macros
In-Reply-To: <1462441442-6996-1-git-send-email-catalin.marinas@arm.com>
References: <1462441442-6996-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1462441442-6996-4-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch replaces the hard-coded value 2 with PMD_TABLE_BIT in the
pmd/pud_bad() macros. Note that using these macros on pmd_trans_huge()
entries is giving incorrect results
(pmd_none_or_trans_huge_or_clear_bad() correctly checks for
pmd_trans_huge before pmd_bad).

Additionally, white-space clean-up for pmd_mkclean().

Reviewed-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index bdfbaf96b426..a8b8f4eb7bff 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -305,7 +305,7 @@ static inline int pmd_protnone(pmd_t pmd)
 #define pmd_wrprotect(pmd)	pte_pmd(pte_wrprotect(pmd_pte(pmd)))
 #define pmd_mkold(pmd)		pte_pmd(pte_mkold(pmd_pte(pmd)))
 #define pmd_mkwrite(pmd)	pte_pmd(pte_mkwrite(pmd_pte(pmd)))
-#define pmd_mkclean(pmd)       pte_pmd(pte_mkclean(pmd_pte(pmd)))
+#define pmd_mkclean(pmd)	pte_pmd(pte_mkclean(pmd_pte(pmd)))
 #define pmd_mkdirty(pmd)	pte_pmd(pte_mkdirty(pmd_pte(pmd)))
 #define pmd_mkyoung(pmd)	pte_pmd(pte_mkyoung(pmd_pte(pmd)))
 #define pmd_mknotpresent(pmd)	(__pmd(pmd_val(pmd) & ~PMD_TYPE_MASK))
@@ -349,7 +349,7 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 #define pmd_none(pmd)		(!pmd_val(pmd))
 #define pmd_present(pmd)	(pmd_val(pmd))
 
-#define pmd_bad(pmd)		(!(pmd_val(pmd) & 2))
+#define pmd_bad(pmd)		(!(pmd_val(pmd) & PMD_TABLE_BIT))
 
 #define pmd_table(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == \
 				 PMD_TYPE_TABLE)
@@ -415,7 +415,7 @@ static inline phys_addr_t pmd_page_paddr(pmd_t pmd)
 #define pmd_ERROR(pmd)		__pmd_error(__FILE__, __LINE__, pmd_val(pmd))
 
 #define pud_none(pud)		(!pud_val(pud))
-#define pud_bad(pud)		(!(pud_val(pud) & 2))
+#define pud_bad(pud)		(!(pud_val(pud) & PUD_TABLE_BIT))
 #define pud_present(pud)	(pud_val(pud))
 
 static inline void set_pud(pud_t *pudp, pud_t pud)
