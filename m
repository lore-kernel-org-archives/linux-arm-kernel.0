From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu, 14 Apr 2016 14:20:54 +0100
Subject: [PATCH v2 06/17] kvm-arm: Remove kvm_pud_huge()
In-Reply-To: <1460640065-27658-1-git-send-email-suzuki.poulose@arm.com>
References: <1460640065-27658-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1460640065-27658-7-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Get rid of kvm_pud_huge() which falls back to pud_huge. Use
pud_huge instead.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm/kvm/mmu.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 7837f0a..d0c0ee9 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -45,8 +45,6 @@ static phys_addr_t hyp_idmap_vector;
 
 #define hyp_pgd_order get_order(PTRS_PER_PGD * sizeof(pgd_t))
 
-#define kvm_pud_huge(_x)	pud_huge(_x)
-
 #define KVM_S2PTE_FLAG_IS_IOMAP		(1UL << 0)
 #define KVM_S2_FLAG_LOGGING_ACTIVE	(1UL << 1)
 
@@ -1077,7 +1075,7 @@ static void  stage2_wp_puds(pgd_t *pgd, phys_addr_t addr, phys_addr_t end)
 		next = kvm_pud_addr_end(addr, end);
 		if (!pud_none(*pud)) {
 			/* TODO:PUD not supported, revisit later if supported */
-			BUG_ON(kvm_pud_huge(*pud));
+			BUG_ON(pud_huge(*pud));
 			stage2_wp_pmds(pud, addr, next);
 		}
 	} while (pud++, addr = next, addr != end);
-- 
1.7.9.5
