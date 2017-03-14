From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 14 Mar 2017 14:52:32 +0000
Subject: [PATCH 1/3] kvm: arm/arm64: Take mmap_sem in stage2_unmap_vm
In-Reply-To: <1489503154-20705-1-git-send-email-suzuki.poulose@arm.com>
References: <1489503154-20705-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1489503154-20705-2-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

We don't hold the mmap_sem while searching for the VMAs when
we try to unmap each memslot for a VM. Fix this properly to
avoid unexpected results.

Fixes: commit 957db105c997 ("arm/arm64: KVM: Introduce stage2_unmap_vm")
Cc: stable at vger.kernel.org # v3.19+
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm/kvm/mmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 962616f..f2e2e0c 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -803,6 +803,7 @@ void stage2_unmap_vm(struct kvm *kvm)
 	int idx;
 
 	idx = srcu_read_lock(&kvm->srcu);
+	down_read(&current->mm->mmap_sem);
 	spin_lock(&kvm->mmu_lock);
 
 	slots = kvm_memslots(kvm);
@@ -810,6 +811,7 @@ void stage2_unmap_vm(struct kvm *kvm)
 		stage2_unmap_memslot(kvm, memslot);
 
 	spin_unlock(&kvm->mmu_lock);
+	up_read(&current->mm->mmap_sem);
 	srcu_read_unlock(&kvm->srcu, idx);
 }
 
-- 
2.7.4
