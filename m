From: lauraa@codeaurora.org (Laura Abbott)
Date: Tue, 12 Aug 2014 16:37:46 -0700
Subject: [PATCHv3 1/2] arm64: Introduce {set,clear}_pte_bit
In-Reply-To: <1407886667-16919-1-git-send-email-lauraa@codeaurora.org>
References: <1407886667-16919-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <1407886667-16919-2-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's useful to be able to change individual bits in ptes at times.
Introduce functions for this and update existing pte_mk* functions
to use these primatives.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm64/include/asm/pgtable.h | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index ffe1ba0..ca41449 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -149,46 +149,51 @@ extern struct page *empty_zero_page;
 #define pte_valid_not_user(pte) \
 	((pte_val(pte) & (PTE_VALID | PTE_USER)) == PTE_VALID)
 
-static inline pte_t pte_wrprotect(pte_t pte)
+static pte_t clear_pte_bit(pte_t pte, pgprot_t prot)
 {
-	pte_val(pte) &= ~PTE_WRITE;
+	pte_val(pte) &= ~pgprot_val(prot);
 	return pte;
 }
 
-static inline pte_t pte_mkwrite(pte_t pte)
+static pte_t set_pte_bit(pte_t pte, pgprot_t prot)
 {
-	pte_val(pte) |= PTE_WRITE;
+	pte_val(pte) |= pgprot_val(prot);
 	return pte;
 }
 
+static inline pte_t pte_wrprotect(pte_t pte)
+{
+	return clear_pte_bit(pte, __pgprot(PTE_WRITE));
+}
+
+static inline pte_t pte_mkwrite(pte_t pte)
+{
+	return set_pte_bit(pte, __pgprot(PTE_WRITE));
+}
+
 static inline pte_t pte_mkclean(pte_t pte)
 {
-	pte_val(pte) &= ~PTE_DIRTY;
-	return pte;
+	return clear_pte_bit(pte, __pgprot(PTE_DIRTY));
 }
 
 static inline pte_t pte_mkdirty(pte_t pte)
 {
-	pte_val(pte) |= PTE_DIRTY;
-	return pte;
+	return set_pte_bit(pte, __pgprot(PTE_DIRTY));
 }
 
 static inline pte_t pte_mkold(pte_t pte)
 {
-	pte_val(pte) &= ~PTE_AF;
-	return pte;
+	return clear_pte_bit(pte, __pgprot(PTE_AF));
 }
 
 static inline pte_t pte_mkyoung(pte_t pte)
 {
-	pte_val(pte) |= PTE_AF;
-	return pte;
+	return set_pte_bit(pte, __pgprot(PTE_AF));
 }
 
 static inline pte_t pte_mkspecial(pte_t pte)
 {
-	pte_val(pte) |= PTE_SPECIAL;
-	return pte;
+	return set_pte_bit(pte, __pgprot(PTE_SPECIAL));
 }
 
 static inline void set_pte(pte_t *ptep, pte_t pte)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
