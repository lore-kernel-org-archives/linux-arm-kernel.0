From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu,  8 Aug 2013 20:41:58 -0700
Subject: [PATCH] ARM: KVM: Fix kvm_set_pte assignment
Message-ID: <1376019718-19378-1-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

THe kvm_set_pte function was actually assigning the entire struct to the
structure member, which should work because the structure only has that
one member, but it is still not very nice.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/include/asm/kvm_mmu.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index 472ac70..9b28c41 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -64,7 +64,7 @@ void kvm_clear_hyp_idmap(void);
 
 static inline void kvm_set_pte(pte_t *pte, pte_t new_pte)
 {
-	pte_val(*pte) = new_pte;
+	*pte = new_pte;
 	/*
 	 * flush_pmd_entry just takes a void pointer and cleans the necessary
 	 * cache entries, so we can reuse the function for ptes.
-- 
1.7.10.4
