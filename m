From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 27 Jan 2017 10:54:12 +0000
Subject: [PATCH] arm64: Improve detection of user/non-user mappings in
 set_pte(_at)
Message-ID: <1485514452-29785-1-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit cab15ce604e5 ("arm64: Introduce execute-only page access
permissions") allowed a valid user PTE to have the PTE_USER bit clear.
As a consequence, the pte_valid_not_user() macro in set_pte() was
replaced with pte_valid_global() under the assumption that only user
pages have the nG bit set. EFI mappings, however, also have the nG bit
set and set_pte() wrongly ignores issuing the DSB+ISB.

This patch reinstates the pte_valid_not_user() macro and adds the
PTE_UXN bit check since all kernel mappings have this bit set. For
clarity, pte_exec() is renamed to pte_user_exec() as it only checks for
the absence of PTE_UXN. Consequently, the user executable check in
set_pte_at() drops the pte_ng() test since pte_user_exec() is
sufficient.

Fixes: cab15ce604e5 ("arm64: Introduce execute-only page access permissions")
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index ffbb9a520563..61e214015b38 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -71,9 +71,8 @@ extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
 #define pte_young(pte)		(!!(pte_val(pte) & PTE_AF))
 #define pte_special(pte)	(!!(pte_val(pte) & PTE_SPECIAL))
 #define pte_write(pte)		(!!(pte_val(pte) & PTE_WRITE))
-#define pte_exec(pte)		(!(pte_val(pte) & PTE_UXN))
+#define pte_user_exec(pte)	(!(pte_val(pte) & PTE_UXN))
 #define pte_cont(pte)		(!!(pte_val(pte) & PTE_CONT))
-#define pte_ng(pte)		(!!(pte_val(pte) & PTE_NG))
 
 #ifdef CONFIG_ARM64_HW_AFDBM
 #define pte_hw_dirty(pte)	(pte_write(pte) && !(pte_val(pte) & PTE_RDONLY))
@@ -84,8 +83,12 @@ extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
 #define pte_dirty(pte)		(pte_sw_dirty(pte) || pte_hw_dirty(pte))
 
 #define pte_valid(pte)		(!!(pte_val(pte) & PTE_VALID))
-#define pte_valid_global(pte) \
-	((pte_val(pte) & (PTE_VALID | PTE_NG)) == PTE_VALID)
+/*
+ * Execute-only user mappings do not have the PTE_USER bit set. All valid
+ * kernel mappings have the PTE_UXN bit set.
+ */
+#define pte_valid_not_user(pte) \
+	((pte_val(pte) & (PTE_VALID | PTE_USER | PTE_UXN)) == (PTE_VALID | PTE_UXN))
 #define pte_valid_young(pte) \
 	((pte_val(pte) & (PTE_VALID | PTE_AF)) == (PTE_VALID | PTE_AF))
 
@@ -178,7 +181,7 @@ static inline void set_pte(pte_t *ptep, pte_t pte)
 	 * Only if the new pte is valid and kernel, otherwise TLB maintenance
 	 * or update_mmu_cache() have the necessary barriers.
 	 */
-	if (pte_valid_global(pte)) {
+	if (pte_valid_not_user(pte)) {
 		dsb(ishst);
 		isb();
 	}
@@ -212,7 +215,7 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 			pte_val(pte) &= ~PTE_RDONLY;
 		else
 			pte_val(pte) |= PTE_RDONLY;
-		if (pte_ng(pte) && pte_exec(pte) && !pte_special(pte))
+		if (pte_user_exec(pte) && !pte_special(pte))
 			__sync_icache_dcache(pte, addr);
 	}
 
