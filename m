From: steve.capper@linaro.org (Steve Capper)
Date: Mon, 24 Feb 2014 15:33:24 +0000
Subject: [RFC PATCH 1/2] arm: mm: Introduce pte_isset(pte,flag)
In-Reply-To: <1393256005-2206-1-git-send-email-steve.capper@linaro.org>
References: <1393256005-2206-1-git-send-email-steve.capper@linaro.org>
Message-ID: <1393256005-2206-2-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Long descriptors on ARM are 64 bits, and some pte functions such as
pte_dirty return a bitwise-and of a flag with the pte value. If the
flag to be tested resides in the upper 32 bits of the pte, then we run
into the danger of the result being dropped if downcast.

For example:
	gather_stats(page, md, pte_dirty(*pte), 1);
where pte_dirty(*pte) is downcast to an int.

This patch introduces a new macro pte_isset which performs the bitwise
and, then performs a double logical invert to ensure predictable
downcasting.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
 arch/arm/include/asm/pgtable.h | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 7d59b52..13626b8 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -214,12 +214,14 @@ static inline pte_t *pmd_page_vaddr(pmd_t pmd)
 
 #define pte_clear(mm,addr,ptep)	set_pte_ext(ptep, __pte(0), 0)
 
+#define pte_isset(pte, val)	(!!(pte_val(pte) & (val)))
+
 #define pte_none(pte)		(!pte_val(pte))
-#define pte_present(pte)	(pte_val(pte) & L_PTE_PRESENT)
-#define pte_write(pte)		(!(pte_val(pte) & L_PTE_RDONLY))
-#define pte_dirty(pte)		(pte_val(pte) & L_PTE_DIRTY)
-#define pte_young(pte)		(pte_val(pte) & L_PTE_YOUNG)
-#define pte_exec(pte)		(!(pte_val(pte) & L_PTE_XN))
+#define pte_present(pte)	(pte_isset((pte), L_PTE_PRESENT))
+#define pte_write(pte)		(!pte_isset((pte), L_PTE_RDONLY))
+#define pte_dirty(pte)		(pte_isset((pte), L_PTE_DIRTY))
+#define pte_young(pte)		(pte_isset((pte), L_PTE_YOUNG))
+#define pte_exec(pte)		(!pte_isset((pte), L_PTE_XN))
 #define pte_special(pte)	(0)
 
 #define pte_present_user(pte)  (pte_present(pte) && (pte_val(pte) & L_PTE_USER))
-- 
1.8.1.4
