From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed,  9 Dec 2015 17:26:56 +0000
Subject: [PATCH 1/2] arm64: Improve error reporting on set_pte_at() checks
In-Reply-To: <1449682017-23729-1-git-send-email-catalin.marinas@arm.com>
References: <1449682017-23729-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1449682017-23729-2-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the BUG_ON() checks do not give enough information about the
PTEs being set. This patch changes BUG_ON to WARN_ONCE and dumps the
values of the old and new PTEs.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 7e074f93f383..002dc61a4dff 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -276,10 +276,13 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 	 * hardware updates of the pte (ptep_set_access_flags safely changes
 	 * valid ptes without going through an invalid entry).
 	 */
-	if (IS_ENABLED(CONFIG_DEBUG_VM) && IS_ENABLED(CONFIG_ARM64_HW_AFDBM) &&
-	    pte_valid(*ptep)) {
-		BUG_ON(!pte_young(pte));
-		BUG_ON(pte_write(*ptep) && !pte_dirty(pte));
+	if (IS_ENABLED(CONFIG_ARM64_HW_AFDBM) && pte_valid(*ptep)) {
+		VM_WARN_ONCE(!pte_young(pte),
+			     "%s: racy access flag clearing: %016llx -> %016llx",
+			     __func__, pte_val(*ptep), pte_val(pte));
+		VM_WARN_ONCE(pte_write(*ptep) && !pte_dirty(pte),
+			     "%s: racy dirty state clearing: %016llx -> %016llx",
+			     __func__, pte_val(*ptep), pte_val(pte));
 	}
 
 	set_pte(ptep, pte);
