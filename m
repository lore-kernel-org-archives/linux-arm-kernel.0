From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 18 Oct 2014 12:57:00 +0100
Subject: [PATCH 10/12] arm/arm64: KVM: Ensure memslots are within KVM_PHYS_SIZE
In-Reply-To: <1413633422-14907-1-git-send-email-marc.zyngier@arm.com>
References: <1413633422-14907-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1413633422-14907-11-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoffer Dall <christoffer.dall@linaro.org>

When creating or moving a memslot, make sure the IPA space is within the
addressable range of the guest.  Otherwise, user space can create too
large a memslot and KVM would try to access potentially unallocated page
table entries when inserting entries in the Stage-2 page tables.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/mmu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index ee142ed..8c40829 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -1003,6 +1003,9 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		goto out_unlock;
 	}
 
+	/* Userspace should not be able to register out-of-bounds IPAs */
+	VM_BUG_ON(fault_ipa >= KVM_PHYS_SIZE);
+
 	ret = user_mem_abort(vcpu, fault_ipa, memslot, hva, fault_status);
 	if (ret == 0)
 		ret = 1;
@@ -1229,6 +1232,14 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 		return 0;
 
 	/*
+	 * Prevent userspace from creating a memory region outside of the IPA
+	 * space addressable by the KVM guest IPA space.
+	 */
+	if (memslot->base_gfn + memslot->npages >=
+	    (KVM_PHYS_SIZE >> PAGE_SHIFT))
+		return -EFAULT;
+
+	/*
 	 * A memory region could potentially cover multiple VMAs, and any holes
 	 * between them, so iterate over all of them to find out if we can map
 	 * any of them right now.
-- 
2.1.1
