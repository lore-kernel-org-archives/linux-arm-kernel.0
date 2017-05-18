From: cdall@linaro.org (Christoffer Dall)
Date: Thu, 18 May 2017 11:47:19 +0200
Subject: [PULL 10/13] kvm: arm/arm64: Force reading uncached stage2 PGD
In-Reply-To: <20170518094722.9926-1-cdall@linaro.org>
References: <20170518094722.9926-1-cdall@linaro.org>
Message-ID: <20170518094722.9926-11-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Make sure we don't use a cached value of the KVM stage2 PGD while
resetting the PGD.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: stable at vger.kernel.org
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: Christoffer Dall <cdall@linaro.org>
Signed-off-by: Christoffer Dall <cdall@linaro.org>
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
2.9.0
