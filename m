From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon, 24 Apr 2017 11:10:24 +0100
Subject: [PATCH 2/2] kvm: arm/arm64: Fix race in resetting stage2 PGD
In-Reply-To: <1493028624-29837-1-git-send-email-suzuki.poulose@arm.com>
References: <1493028624-29837-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1493028624-29837-3-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In kvm_free_stage2_pgd() we check the stage2 PGD before holding
the lock and proceed to take the lock if it is valid. And we unmap
the page tables, followed by releasing the lock. We reset the PGD
only after dropping this lock, which could cause a race condition
where another thread waiting on the lock could potentially see that
the PGD is still valid and proceed to perform a stage2 operation.

This patch moves the stage2 PGD manipulation under the lock.

Reported-by: Alexander Graf <agraf@suse.de>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm/kvm/mmu.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 582a972..9c4026d 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -835,16 +835,18 @@ void stage2_unmap_vm(struct kvm *kvm)
  */
 void kvm_free_stage2_pgd(struct kvm *kvm)
 {
-	if (kvm->arch.pgd == NULL)
-		return;
+	void *pgd = NULL;
 
 	spin_lock(&kvm->mmu_lock);
-	unmap_stage2_range(kvm, 0, KVM_PHYS_SIZE);
+	if (kvm->arch.pgd) {
+		unmap_stage2_range(kvm, 0, KVM_PHYS_SIZE);
+		pgd = kvm->arch.pgd;
+		kvm->arch.pgd = NULL;
+	}
 	spin_unlock(&kvm->mmu_lock);
-
 	/* Free the HW pgd, one page at a time */
-	free_pages_exact(kvm->arch.pgd, S2_PGD_SIZE);
-	kvm->arch.pgd = NULL;
+	if (pgd)
+		free_pages_exact(pgd, S2_PGD_SIZE);
 }
 
 static pud_t *stage2_get_pud(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
-- 
2.7.4
