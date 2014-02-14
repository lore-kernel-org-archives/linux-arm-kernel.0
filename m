From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 14 Feb 2014 14:28:06 +0000
Subject: [PATCH] KVM: ARM: vgic: plug irq injection race
Message-ID: <1392388086-24730-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As it stands, nothing prevents userspace from injecting an interrupt
before the guest's GIC is actually initialized.

This goes unnoticed so far (as everything is pretty much statically
allocated), but ends up exploding in a spectacular way once we switch
to a more dynamic allocation (the GIC data structure isn't there yet).

The fix is to test for the "ready" flag in the VGIC distributor before
trying to inject the interrupt. Note that in order to avoid breaking
userspace, we have to ignore what is essentially an error.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index be456ce..d40fe61 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1386,7 +1386,8 @@ out:
 int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid, unsigned int irq_num,
 			bool level)
 {
-	if (vgic_update_irq_state(kvm, cpuid, irq_num, level))
+	if (likely(vgic_initialized(kvm)) &&
+	    vgic_update_irq_state(kvm, cpuid, irq_num, level))
 		vgic_kick_vcpus(kvm);
 
 	return 0;
-- 
1.8.3.4
