From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 12 Feb 2013 18:25:50 +0000
Subject: [PATCH] arm: Preserve L_PTE_VALID in pte_modify()
Message-ID: <1360693550-31609-1-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following commit 26ffd0d4 (ARM: mm: introduce present, faulting entries
for PAGE_NONE), if a page has been mapped as PROT_NONE, the L_PTE_VALID
bit is cleared by the set_pte_ext() code. With LPAE the software and
hardware pte share the same location and subsequent modifications of pte
range (change_protection()) will leave the L_PTE_VALID bit cleared.

This patch adds the L_PTE_VALID bit to the newprot mask in pte_modify().

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Subash Patel <subash.rp@samsung.com>
Tested-by: Subash Patel <subash.rp@samsung.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/pgtable.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 9c82f988..c094749 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -240,7 +240,8 @@ static inline pte_t pte_mkspecial(pte_t pte) { return pte; }
 
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
-	const pteval_t mask = L_PTE_XN | L_PTE_RDONLY | L_PTE_USER | L_PTE_NONE;
+	const pteval_t mask = L_PTE_XN | L_PTE_RDONLY | L_PTE_USER |
+		L_PTE_NONE | L_PTE_VALID;
 	pte_val(pte) = (pte_val(pte) & ~mask) | (pgprot_val(newprot) & mask);
 	return pte;
 }
