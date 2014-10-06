From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon,  6 Oct 2014 22:30:26 +0200
Subject: [PATCH v2 2/3] arm/arm64: KVM: Ensure memslots are within
 KVM_PHYS_SIZE
In-Reply-To: <1412627427-28629-1-git-send-email-christoffer.dall@linaro.org>
References: <1412627427-28629-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1412627427-28629-3-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When creating or moving a memslot, make sure the IPA space is within the
addressable range of the guest.  Otherwise, user space can create too
large a memslot and KVM would try to access potentially unallocated page
table entries when inserting entries in the Stage-2 page tables.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/mmu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 3b3e18f..123508d 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -992,6 +992,9 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		goto out_unlock;
 	}
 
+	/* Userspace should not be able to register out-of-bounds IPAs */
+	VM_BUG_ON(fault_ipa >= KVM_PHYS_SIZE);
+
 	ret = user_mem_abort(vcpu, fault_ipa, memslot, hva, fault_status);
 	if (ret == 0)
 		ret = 1;
@@ -1216,6 +1219,11 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 				   struct kvm_userspace_memory_region *mem,
 				   enum kvm_mr_change change)
 {
+	if (change == KVM_MR_CREATE || change == KVM_MR_MOVE) {
+		if (memslot->base_gfn + memslot->npages >=
+		    (KVM_PHYS_SIZE >> PAGE_SHIFT))
+			return -EFAULT;
+	}
 	return 0;
 }
 
-- 
2.1.2.330.g565301e.dirty
