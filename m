From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 18 Aug 2017 18:26:01 +0100
Subject: [PATCH v2 4/5] arm64: Ignore hardware dirty bit updates in
 ptep_set_wrprotect()
In-Reply-To: <20170818172602.7624-1-catalin.marinas@arm.com>
References: <20170818172602.7624-1-catalin.marinas@arm.com>
Message-ID: <20170818172602.7624-5-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ptep_set_wrprotect() is only called on CoW mappings which are private
(!VM_SHARED) with the pte either read-only (!PTE_WRITE && PTE_RDONLY) or
writable and software-dirty (PTE_WRITE && !PTE_RDONLY && PTE_DIRTY).
There is no race with the hardware update of the dirty state: clearing
of PTE_RDONLY when PTE_WRITE (a.k.a. PTE_DBM) is set. This patch removes
the code setting the software PTE_DIRTY bit in ptep_set_wrprotect() as
superfluous. A VM_WARN_ONCE is introduced in case the above logic is
wrong or the core mm code changes its use of ptep_set_wrprotect().

Cc: Will Deacon <will.deacon@arm.com>
Acked-by: Steve Capper <steve.capper@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index a04bfb869a80..0117cbcd62d4 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -634,23 +634,28 @@ static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 /*
- * ptep_set_wrprotect - mark read-only while trasferring potential hardware
- * dirty status (PTE_DBM && !PTE_RDONLY) to the software PTE_DIRTY bit.
+ * ptep_set_wrprotect - mark read-only while preserving the hardware update of
+ * the Access Flag.
  */
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
 static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long address, pte_t *ptep)
 {
 	pte_t old_pte, pte;
 
+	/*
+	 * ptep_set_wrprotect() is only called on CoW mappings which are
+	 * private (!VM_SHARED) with the pte either read-only (!PTE_WRITE &&
+	 * PTE_RDONLY) or writable and software-dirty (PTE_WRITE &&
+	 * !PTE_RDONLY && PTE_DIRTY); see is_cow_mapping() and
+	 * protection_map[]. There is no race with the hardware update of the
+	 * dirty state: clearing of PTE_RDONLY when PTE_WRITE (a.k.a. PTE_DBM)
+	 * is set.
+	 */
+	VM_WARN_ONCE(pte_write(*ptep) && !pte_dirty(*ptep),
+		     "%s: potential race with hardware DBM", __func__);
 	pte = READ_ONCE(*ptep);
 	do {
 		old_pte = pte;
-		/*
-		 * If hardware-dirty (PTE_WRITE/DBM bit set and PTE_RDONLY
-		 * clear), set the PTE_DIRTY bit.
-		 */
-		if (pte_hw_dirty(pte))
-			pte = pte_mkdirty(pte);
 		pte = pte_wrprotect(pte);
 		pte_val(pte) = cmpxchg_relaxed(&pte_val(*ptep),
 					       pte_val(old_pte), pte_val(pte));
