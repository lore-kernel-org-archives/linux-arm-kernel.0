From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 25 Jul 2017 14:53:07 +0100
Subject: [PATCH 5/6] arm64: Ignore hardware dirty bit updates in
 ptep_set_wrprotect()
In-Reply-To: <20170725135308.18173-1-catalin.marinas@arm.com>
References: <20170725135308.18173-1-catalin.marinas@arm.com>
Message-ID: <20170725135308.18173-6-catalin.marinas@arm.com>
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
 arch/arm64/include/asm/pgtable.h | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index a14e2120811c..3fefcc0182c7 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -632,23 +632,28 @@ static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
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
 	do {
-		pte = old_pte = READ_ONCE(*ptep);
-		/*
-		 * If hardware-dirty (PTE_WRITE/DBM bit set and PTE_RDONLY
-		 * clear), set the PTE_DIRTY bit.
-		 */
-		if (pte_hw_dirty(pte))
-			pte = pte_mkdirty(pte);
-		pte = pte_wrprotect(pte);
+		old_pte = READ_ONCE(*ptep);
+		pte = pte_wrprotect(old_pte);
 	} while (cmpxchg_relaxed(&pte_val(*ptep), pte_val(old_pte),
 				 pte_val(pte)) != pte_val(old_pte));
 }
