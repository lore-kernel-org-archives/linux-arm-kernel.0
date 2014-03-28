From: steve.capper@linaro.org (Steve Capper)
Date: Fri, 28 Mar 2014 14:22:33 +0000
Subject: [PATCH V3 1/2] arm: mm: Introduce pte_isset and pte_isclear
In-Reply-To: <1396016554-5843-1-git-send-email-steve.capper@linaro.org>
References: <1396016554-5843-1-git-send-email-steve.capper@linaro.org>
Message-ID: <1396016554-5843-2-git-send-email-steve.capper@linaro.org>
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
and, then performs a double logical invert (where needed) to ensure
predictable downcasting.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
Changes in V3: back to pte_isset macro. Added (u32)(val) == (val) as
recommended by Russell to simplify cases where we do not need to
perform a double logical invert. Also added pte_isclear as recommended,
as this makes the pte accessors look a lot cleaner.

I have experimented with multiple implementations of pte_isclear in an
attempt to simplify things for LPAE where (u32)val == val, but have
been unable to come up with any convincing schemes.
---
 arch/arm/include/asm/pgtable.h | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 7d59b52..8790444 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -214,15 +214,19 @@ static inline pte_t *pmd_page_vaddr(pmd_t pmd)
 
 #define pte_clear(mm,addr,ptep)	set_pte_ext(ptep, __pte(0), 0)
 
+#define pte_isset(pte, val)	((u32)(val) == (val) ? pte_val(pte) & (val) \
+						: !!(pte_val(pte) & (val)))
+#define pte_isclear(pte, val)	(!(pte_val(pte) & (val)))
+
 #define pte_none(pte)		(!pte_val(pte))
-#define pte_present(pte)	(pte_val(pte) & L_PTE_PRESENT)
-#define pte_write(pte)		(!(pte_val(pte) & L_PTE_RDONLY))
-#define pte_dirty(pte)		(pte_val(pte) & L_PTE_DIRTY)
-#define pte_young(pte)		(pte_val(pte) & L_PTE_YOUNG)
-#define pte_exec(pte)		(!(pte_val(pte) & L_PTE_XN))
+#define pte_present(pte)	(pte_isset((pte), L_PTE_PRESENT))
+#define pte_write(pte)		(pte_isclear((pte), L_PTE_RDONLY))
+#define pte_dirty(pte)		(pte_isset((pte), L_PTE_DIRTY))
+#define pte_young(pte)		(pte_isset((pte), L_PTE_YOUNG))
+#define pte_exec(pte)		(pte_isclear((pte), L_PTE_XN))
 #define pte_special(pte)	(0)
 
-#define pte_present_user(pte)  (pte_present(pte) && (pte_val(pte) & L_PTE_USER))
+#define pte_present_user(pte)	(pte_present(pte) && pte_isset((pte), L_PTE_USER))
 
 #if __LINUX_ARM_ARCH__ < 6
 static inline void __sync_icache_dcache(pte_t pteval)
-- 
1.8.1.4
