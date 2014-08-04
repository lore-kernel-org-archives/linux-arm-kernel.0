From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon,  4 Aug 2014 10:46:21 +0200
Subject: [GIT PULL 04/51] ARM: KVM: Unmap IPA on memslot delete/move
In-Reply-To: <1407142028-31105-1-git-send-email-christoffer.dall@linaro.org>
References: <1407142028-31105-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1407142028-31105-5-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Auger <eric.auger@linaro.org>

Currently when a KVM region is deleted or moved after
KVM_SET_USER_MEMORY_REGION ioctl, the corresponding
intermediate physical memory is not unmapped.

This patch corrects this and unmaps the region's IPA range
in kvm_arch_commit_memory_region using unmap_stage2_range.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/arm.c | 37 -------------------------------------
 arch/arm/kvm/mmu.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 37 deletions(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 3c82b37..d7424ef 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -155,16 +155,6 @@ int kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf)
 	return VM_FAULT_SIGBUS;
 }
 
-void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *free,
-			   struct kvm_memory_slot *dont)
-{
-}
-
-int kvm_arch_create_memslot(struct kvm *kvm, struct kvm_memory_slot *slot,
-			    unsigned long npages)
-{
-	return 0;
-}
 
 /**
  * kvm_arch_destroy_vm - destroy the VM data structure
@@ -225,33 +215,6 @@ long kvm_arch_dev_ioctl(struct file *filp,
 	return -EINVAL;
 }
 
-void kvm_arch_memslots_updated(struct kvm *kvm)
-{
-}
-
-int kvm_arch_prepare_memory_region(struct kvm *kvm,
-				   struct kvm_memory_slot *memslot,
-				   struct kvm_userspace_memory_region *mem,
-				   enum kvm_mr_change change)
-{
-	return 0;
-}
-
-void kvm_arch_commit_memory_region(struct kvm *kvm,
-				   struct kvm_userspace_memory_region *mem,
-				   const struct kvm_memory_slot *old,
-				   enum kvm_mr_change change)
-{
-}
-
-void kvm_arch_flush_shadow_all(struct kvm *kvm)
-{
-}
-
-void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
-				   struct kvm_memory_slot *slot)
-{
-}
 
 struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)
 {
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 2336061..b2a708b 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -1111,3 +1111,49 @@ out:
 	free_hyp_pgds();
 	return err;
 }
+
+void kvm_arch_commit_memory_region(struct kvm *kvm,
+				   struct kvm_userspace_memory_region *mem,
+				   const struct kvm_memory_slot *old,
+				   enum kvm_mr_change change)
+{
+	gpa_t gpa = old->base_gfn << PAGE_SHIFT;
+	phys_addr_t size = old->npages << PAGE_SHIFT;
+	if (change == KVM_MR_DELETE || change == KVM_MR_MOVE) {
+		spin_lock(&kvm->mmu_lock);
+		unmap_stage2_range(kvm, gpa, size);
+		spin_unlock(&kvm->mmu_lock);
+	}
+}
+
+int kvm_arch_prepare_memory_region(struct kvm *kvm,
+				   struct kvm_memory_slot *memslot,
+				   struct kvm_userspace_memory_region *mem,
+				   enum kvm_mr_change change)
+{
+	return 0;
+}
+
+void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *free,
+			   struct kvm_memory_slot *dont)
+{
+}
+
+int kvm_arch_create_memslot(struct kvm *kvm, struct kvm_memory_slot *slot,
+			    unsigned long npages)
+{
+	return 0;
+}
+
+void kvm_arch_memslots_updated(struct kvm *kvm)
+{
+}
+
+void kvm_arch_flush_shadow_all(struct kvm *kvm)
+{
+}
+
+void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
+				   struct kvm_memory_slot *slot)
+{
+}
-- 
2.0.0
