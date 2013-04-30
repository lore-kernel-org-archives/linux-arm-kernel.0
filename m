From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 30 Apr 2013 15:17:26 +0100
Subject: [PATCH 4/4] ARM: KVM: fix use of S2_PGD_SIZE
In-Reply-To: <1367331446-28030-1-git-send-email-marc.zyngier@arm.com>
References: <1367331446-28030-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1367331446-28030-5-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

S2_PGD_SIZE describe the number of pages a used by a stage-2 PGD,
not the size of the PGD.

Fix the VM_BUG_ON() call that doesn't check much when S2_PGD_SIZE
is equal to 1.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index b978ebe..09ece5c 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -377,7 +377,7 @@ int kvm_alloc_stage2_pgd(struct kvm *kvm)
 		return -ENOMEM;
 
 	/* stage-2 pgd must be aligned to its size */
-	VM_BUG_ON((unsigned long)pgd & (S2_PGD_SIZE - 1));
+	VM_BUG_ON((unsigned long)pgd & (PAGE_SIZE * S2_PGD_SIZE - 1));
 
 	memset(pgd, 0, PTRS_PER_S2_PGD * sizeof(pgd_t));
 	kvm_clean_pgd(pgd);
-- 
1.8.2.1
