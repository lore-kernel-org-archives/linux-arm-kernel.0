From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 15 Feb 2013 19:20:08 +0000
Subject: [PATCH 3.9-rc1 3/3] ARM: KVM: fix compilation after removal of
 user_alloc from struct kvm_memory_slot
In-Reply-To: <1360956008-5925-1-git-send-email-marc.zyngier@arm.com>
References: <1360956008-5925-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1360956008-5925-4-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 7a905b1 (KVM: Remove user_alloc from struct kvm_memory_slot)
broke KVM/ARM by removing the user_alloc field from a public structure.

As we only used this field to alert the user that we didn't support
this operation mode, there is no harm in discarding this bit of code
without any remorse.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/mmu.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index f30e131..99e07c7 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -633,11 +633,6 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	}
 
 	memslot = gfn_to_memslot(vcpu->kvm, gfn);
-	if (!memslot->user_alloc) {
-		kvm_err("non user-alloc memslots not supported\n");
-		ret = -EINVAL;
-		goto out_unlock;
-	}
 
 	ret = user_mem_abort(vcpu, fault_ipa, gfn, memslot, fault_status);
 	if (ret == 0)
-- 
1.8.1.2
