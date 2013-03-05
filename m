From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  5 Mar 2013 02:43:19 +0000
Subject: [PATCH 25/29] ARM: KVM: fix fault_ipa computing
In-Reply-To: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
References: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1362451403-23460-26-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM ARM says that HPFAR reports bits [39:12] of the faulting
IPA, and we need to complement it with the bottom 12 bits of the
faulting VA.

This is always 12 bits, irrespective of the page size. Makes it
clearer in the code.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/mmu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 71d15bc..f601e6f 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -614,8 +614,13 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run)
 			goto out_unlock;
 		}
 
-		/* Adjust page offset */
-		fault_ipa |= kvm_vcpu_get_hfar(vcpu) & ~PAGE_MASK;
+		/*
+		 * The IPA is reported as [MAX:12], so we need to
+		 * complement it with the bottom 12 bits from the
+		 * faulting VA. This is always 12 bits, irrespective
+		 * of the page size.
+		 */
+		fault_ipa |= kvm_vcpu_get_hfar(vcpu) & ((1 << 12) - 1);
 		ret = io_mem_abort(vcpu, run, fault_ipa);
 		goto out_unlock;
 	}
-- 
1.7.12.4
