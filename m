From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu, 16 Mar 2017 18:20:50 +0000
Subject: [PATCH v2 2/3] kvm: arm/arm64: Take mmap_sem in
 kvm_arch_prepare_memory_region
In-Reply-To: <1489688451-17520-1-git-send-email-suzuki.poulose@arm.com>
References: <1489688451-17520-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1489688451-17520-3-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

We don't hold the mmap_sem while searching for VMAs (via find_vma), in
kvm_arch_prepare_memory_region, which can end up in expected failures.

Fixes: commit 8eef91239e57 ("arm/arm64: KVM: map MMIO regions at creation time")
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Eric Auger <eric.auger@rehat.com>
Cc: stable at vger.kernel.org # v3.18+
Reviewed-by: Christoffer Dall <cdall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
[ Handle dirty page logging failure case ]
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm/kvm/mmu.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index f2e2e0c..13b9c1f 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -1803,6 +1803,7 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 	    (KVM_PHYS_SIZE >> PAGE_SHIFT))
 		return -EFAULT;
 
+	down_read(&current->mm->mmap_sem);
 	/*
 	 * A memory region could potentially cover multiple VMAs, and any holes
 	 * between them, so iterate over all of them to find out if we can map
@@ -1846,8 +1847,10 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 			pa += vm_start - vma->vm_start;
 
 			/* IO region dirty page logging not allowed */
-			if (memslot->flags & KVM_MEM_LOG_DIRTY_PAGES)
-				return -EINVAL;
+			if (memslot->flags & KVM_MEM_LOG_DIRTY_PAGES) {
+				ret = -EINVAL;
+				goto out;
+			}
 
 			ret = kvm_phys_addr_ioremap(kvm, gpa, pa,
 						    vm_end - vm_start,
@@ -1859,7 +1862,7 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 	} while (hva < reg_end);
 
 	if (change == KVM_MR_FLAGS_ONLY)
-		return ret;
+		goto out;
 
 	spin_lock(&kvm->mmu_lock);
 	if (ret)
@@ -1867,6 +1870,8 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 	else
 		stage2_flush_memslot(kvm, memslot);
 	spin_unlock(&kvm->mmu_lock);
+out:
+	up_read(&current->mm->mmap_sem);
 	return ret;
 }
 
-- 
2.7.4
