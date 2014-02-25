From: steve.capper@linaro.org (Steve Capper)
Date: Tue, 25 Feb 2014 11:38:52 +0000
Subject: [PATCH V2 1/3] arm: mm: Double logical invert for pte accessors
In-Reply-To: <1393328334-27285-1-git-send-email-steve.capper@linaro.org>
References: <1393328334-27285-1-git-send-email-steve.capper@linaro.org>
Message-ID: <1393328334-27285-2-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Long descriptors on ARM are 64 bits, and some pte functions such as
pte_dirty return a bitwise-and of a flag with the pte value. If the
flag to be tested resides in the upper 32 bits of the pte, then we run
into the danger of the result being dropped if downcast.

For example:
        gather_stats(page, md, pte_dirty(*pte), 1);
where pte_dirty(*pte) is downcast to an int.

Functions such as huge_pte_write also perform a downcast to unsigned
long (which is 32 bits).

This patch adds a double logical invert to all the pte_ accessors to
ensure predictable downcasting.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
Changes in V2: drop the pte_isset macro, just add the !!
---
 arch/arm/include/asm/pgtable.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 7d59b52..02ee408 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -215,10 +215,10 @@ static inline pte_t *pmd_page_vaddr(pmd_t pmd)
 #define pte_clear(mm,addr,ptep)	set_pte_ext(ptep, __pte(0), 0)
 
 #define pte_none(pte)		(!pte_val(pte))
-#define pte_present(pte)	(pte_val(pte) & L_PTE_PRESENT)
+#define pte_present(pte)	(!!(pte_val(pte) & L_PTE_PRESENT))
 #define pte_write(pte)		(!(pte_val(pte) & L_PTE_RDONLY))
-#define pte_dirty(pte)		(pte_val(pte) & L_PTE_DIRTY)
-#define pte_young(pte)		(pte_val(pte) & L_PTE_YOUNG)
+#define pte_dirty(pte)		(!!(pte_val(pte) & L_PTE_DIRTY))
+#define pte_young(pte)		(!!(pte_val(pte) & L_PTE_YOUNG))
 #define pte_exec(pte)		(!(pte_val(pte) & L_PTE_XN))
 #define pte_special(pte)	(0)
 
-- 
1.8.1.4
