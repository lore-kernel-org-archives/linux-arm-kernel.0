From: steve.capper@arm.com (Steve Capper)
Date: Wed, 15 Jan 2014 14:07:12 +0000
Subject: [PATCH 1/2] arm64: mm: Remove PTE_BIT_FUNC macro
In-Reply-To: <1389794833-7505-1-git-send-email-steve.capper@arm.com>
References: <1389794833-7505-1-git-send-email-steve.capper@arm.com>
Message-ID: <1389794833-7505-2-git-send-email-steve.capper@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Expand out the pte manipulation functions. This makes our life easier
when using things like tags and cscope.

Signed-off-by: Steve Capper <steve.capper@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 51 ++++++++++++++++++++++++++++++++--------
 1 file changed, 41 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 7f2b60a..27c7839 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -146,16 +146,47 @@ extern struct page *empty_zero_page;
 #define pte_valid_user(pte) \
 	((pte_val(pte) & (PTE_VALID | PTE_USER)) == (PTE_VALID | PTE_USER))
 
-#define PTE_BIT_FUNC(fn,op) \
-static inline pte_t pte_##fn(pte_t pte) { pte_val(pte) op; return pte; }
-
-PTE_BIT_FUNC(wrprotect, |= PTE_RDONLY);
-PTE_BIT_FUNC(mkwrite,   &= ~PTE_RDONLY);
-PTE_BIT_FUNC(mkclean,   &= ~PTE_DIRTY);
-PTE_BIT_FUNC(mkdirty,   |= PTE_DIRTY);
-PTE_BIT_FUNC(mkold,     &= ~PTE_AF);
-PTE_BIT_FUNC(mkyoung,   |= PTE_AF);
-PTE_BIT_FUNC(mkspecial, |= PTE_SPECIAL);
+static inline pte_t pte_wrprotect(pte_t pte)
+{
+	pte_val(pte) |= PTE_RDONLY;
+	return pte;
+}
+
+static inline pte_t pte_mkwrite(pte_t pte)
+{
+	pte_val(pte) &= ~PTE_RDONLY;
+	return pte;
+}
+
+static inline pte_t pte_mkclean(pte_t pte)
+{
+	pte_val(pte) &= ~PTE_DIRTY;
+	return pte;
+}
+
+static inline pte_t pte_mkdirty(pte_t pte)
+{
+	pte_val(pte) |= PTE_DIRTY;
+	return pte;
+}
+
+static inline pte_t pte_mkold(pte_t pte)
+{
+	pte_val(pte) &= ~PTE_AF;
+	return pte;
+}
+
+static inline pte_t pte_mkyoung(pte_t pte)
+{
+	pte_val(pte) |= PTE_AF;
+	return pte;
+}
+
+static inline pte_t pte_mkspecial(pte_t pte)
+{
+	pte_val(pte) |= PTE_SPECIAL;
+	return pte;
+}
 
 static inline void set_pte(pte_t *ptep, pte_t pte)
 {
-- 
1.8.1.4
