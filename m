From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 16 May 2017 10:34:54 +0100
Subject: [PATCH v3 1/2] kvm: arm/arm64: Force reading uncached stage2 PGD
In-Reply-To: <1494927295-29369-1-git-send-email-suzuki.poulose@arm.com>
References: <1494927295-29369-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1494927295-29369-2-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure we don't use a cached value of the KVM stage2 PGD while
resetting the PGD.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <cdall@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 virt/kvm/arm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 909a1a7..704e35f 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -837,7 +837,7 @@ void kvm_free_stage2_pgd(struct kvm *kvm)
 	spin_lock(&kvm->mmu_lock);
 	if (kvm->arch.pgd) {
 		unmap_stage2_range(kvm, 0, KVM_PHYS_SIZE);
-		pgd = kvm->arch.pgd;
+		pgd = READ_ONCE(kvm->arch.pgd);
 		kvm->arch.pgd = NULL;
 	}
 	spin_unlock(&kvm->mmu_lock);
-- 
2.7.4
