From: js07.lee@gmail.com (Jungseung Lee)
Date: Tue, 21 Oct 2014 20:00:36 +0900
Subject: [PATCH 1/2] arm: Introduce {set,clear}_pte_bit
Message-ID: <1413889237-6933-1-git-send-email-js07.lee@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce helper functions for pte_mk* functions and it would be
used to change individual bits in ptes at times.

Signed-off-by: Jungseung Lee <js07.lee@gmail.com>
---
 arch/arm/include/asm/pgtable.h | 62 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 51 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 3b30062..d5cac54 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -252,17 +252,57 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 	set_pte_ext(ptep, pteval, ext);
 }
 
-#define PTE_BIT_FUNC(fn,op) \
-static inline pte_t pte_##fn(pte_t pte) { pte_val(pte) op; return pte; }
-
-PTE_BIT_FUNC(wrprotect, |= L_PTE_RDONLY);
-PTE_BIT_FUNC(mkwrite,   &= ~L_PTE_RDONLY);
-PTE_BIT_FUNC(mkclean,   &= ~L_PTE_DIRTY);
-PTE_BIT_FUNC(mkdirty,   |= L_PTE_DIRTY);
-PTE_BIT_FUNC(mkold,     &= ~L_PTE_YOUNG);
-PTE_BIT_FUNC(mkyoung,   |= L_PTE_YOUNG);
-PTE_BIT_FUNC(mkexec,   &= ~L_PTE_XN);
-PTE_BIT_FUNC(mknexec,   |= L_PTE_XN);
+static inline pte_t clear_pte_bit(pte_t pte, pgprot_t prot)
+{
+	pte_val(pte) &= ~pgprot_val(prot);
+	return pte;
+}
+
+static inline pte_t set_pte_bit(pte_t pte, pgprot_t prot)
+{
+	pte_val(pte) |= pgprot_val(prot);
+	return pte;
+}
+
+static inline pte_t pte_wrprotect(pte_t pte)
+{
+	return set_pte_bit(pte, __pgprot(L_PTE_RDONLY));
+}
+
+static inline pte_t pte_mkwrite(pte_t pte)
+{
+	return clear_pte_bit(pte, __pgprot(L_PTE_RDONLY));
+}
+
+static inline pte_t pte_mkclean(pte_t pte)
+{
+	return clear_pte_bit(pte, __pgprot(L_PTE_DIRTY));
+}
+
+static inline pte_t pte_mkdirty(pte_t pte)
+{
+	return set_pte_bit(pte, __pgprot(L_PTE_DIRTY));
+}
+
+static inline pte_t pte_mkold(pte_t pte)
+{
+	return clear_pte_bit(pte, __pgprot(L_PTE_YOUNG));
+}
+
+static inline pte_t pte_mkyoung(pte_t pte)
+{
+	return set_pte_bit(pte, __pgprot(L_PTE_YOUNG));
+}
+
+static inline pte_t pte_mkexec(pte_t pte)
+{
+	return clear_pte_bit(pte, __pgprot(L_PTE_XN));
+}
+
+static inline pte_t pte_mknexec(pte_t pte)
+{
+	return set_pte_bit(pte, __pgprot(L_PTE_XN));
+}
 
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
-- 
1.9.1
