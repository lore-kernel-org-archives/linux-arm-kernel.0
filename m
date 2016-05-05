From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu,  5 May 2016 10:44:02 +0100
Subject: [PATCH 4/4] arm64: Ensure pmd_present() returns false after
 pmd_mknotpresent()
In-Reply-To: <1462441442-6996-1-git-send-email-catalin.marinas@arm.com>
References: <1462441442-6996-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1462441442-6996-5-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, pmd_present() only checks for a non-zero value, returning
true even after pmd_mknotpresent() (which only clears the type bits).
This patch converts pmd_present() to using pte_present(), similar to the
other pmd_*() checks. As a side effect, it will return true for
PROT_NONE mappings, though they are not yet used by the kernel with
transparent huge pages.

For consistency, also change pmd_mknotpresent() to only clear the
PMD_SECT_VALID bit, even though the PMD_TABLE_BIT is already 0 for block
mappings (no functional change). The unused PMD_SECT_PROT_NONE
definition is removed as transparent huge pages use the pte page prot
values.

Fixes: 9c7e535fcc17 ("arm64: mm: Route pmd thp functions through pte equivalents")
Cc: <stable@vger.kernel.org> # 3.15+
Reviewed-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/pgtable-hwdef.h | 1 -
 arch/arm64/include/asm/pgtable.h       | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index 5c25b831273d..9786f770088d 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -133,7 +133,6 @@
  * Section
  */
 #define PMD_SECT_VALID		(_AT(pmdval_t, 1) << 0)
-#define PMD_SECT_PROT_NONE	(_AT(pmdval_t, 1) << 58)
 #define PMD_SECT_USER		(_AT(pmdval_t, 1) << 6)		/* AP[1] */
 #define PMD_SECT_RDONLY		(_AT(pmdval_t, 1) << 7)		/* AP[2] */
 #define PMD_SECT_S		(_AT(pmdval_t, 3) << 8)
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index a8b8f4eb7bff..7b2806812d95 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -300,6 +300,7 @@ static inline int pmd_protnone(pmd_t pmd)
 #define pmd_trans_huge(pmd)	(pmd_val(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT))
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
+#define pmd_present(pmd)	pte_present(pmd_pte(pmd))
 #define pmd_dirty(pmd)		pte_dirty(pmd_pte(pmd))
 #define pmd_young(pmd)		pte_young(pmd_pte(pmd))
 #define pmd_wrprotect(pmd)	pte_pmd(pte_wrprotect(pmd_pte(pmd)))
@@ -308,7 +309,7 @@ static inline int pmd_protnone(pmd_t pmd)
 #define pmd_mkclean(pmd)	pte_pmd(pte_mkclean(pmd_pte(pmd)))
 #define pmd_mkdirty(pmd)	pte_pmd(pte_mkdirty(pmd_pte(pmd)))
 #define pmd_mkyoung(pmd)	pte_pmd(pte_mkyoung(pmd_pte(pmd)))
-#define pmd_mknotpresent(pmd)	(__pmd(pmd_val(pmd) & ~PMD_TYPE_MASK))
+#define pmd_mknotpresent(pmd)	(__pmd(pmd_val(pmd) & ~PMD_SECT_VALID))
 
 #define __HAVE_ARCH_PMD_WRITE
 #define pmd_write(pmd)		pte_write(pmd_pte(pmd))
@@ -347,7 +348,6 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 				     unsigned long size, pgprot_t vma_prot);
 
 #define pmd_none(pmd)		(!pmd_val(pmd))
-#define pmd_present(pmd)	(pmd_val(pmd))
 
 #define pmd_bad(pmd)		(!(pmd_val(pmd) & PMD_TABLE_BIT))
 
