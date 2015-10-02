From: jeremy.linton@arm.com (Jeremy Linton)
Date: Fri,  2 Oct 2015 15:47:41 -0500
Subject: [PATCH 3/7] arm64: Macros to check/set/unset the contiguous bit
In-Reply-To: <1443818865-19846-1-git-send-email-jeremy.linton@arm.com>
References: <1443818865-19846-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <1443818865-19846-4-git-send-email-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the supporting macros to check if the contiguous bit
is set, set the bit, or clear it in a PTE entry.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 6900b2d9..d43e1d1 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -144,6 +144,7 @@ extern struct page *empty_zero_page;
 #define pte_special(pte)	(!!(pte_val(pte) & PTE_SPECIAL))
 #define pte_write(pte)		(!!(pte_val(pte) & PTE_WRITE))
 #define pte_exec(pte)		(!(pte_val(pte) & PTE_UXN))
+#define pte_cont(pte)		(!!(pte_val(pte) & PTE_CONT))
 
 #ifdef CONFIG_ARM64_HW_AFDBM
 #define pte_hw_dirty(pte)	(!(pte_val(pte) & PTE_RDONLY))
@@ -206,6 +207,16 @@ static inline pte_t pte_mkspecial(pte_t pte)
 	return set_pte_bit(pte, __pgprot(PTE_SPECIAL));
 }
 
+static inline pte_t pte_mkcont(pte_t pte)
+{
+	return set_pte_bit(pte, __pgprot(PTE_CONT));
+}
+
+static inline pte_t pte_mknoncont(pte_t pte)
+{
+	return clear_pte_bit(pte, __pgprot(PTE_CONT));
+}
+
 static inline void set_pte(pte_t *ptep, pte_t pte)
 {
 	*ptep = pte;
-- 
2.4.3
