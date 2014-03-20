From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 20 Mar 2014 16:47:15 +0000
Subject: [PATCH v2] KVM: ARM: vgic: plug irq injection race
Message-ID: <1395334035-15454-1-git-send-email-marc.zyngier@arm.com>
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

Also, move the setting of the flag out of the critical section,
which will ensure the visibility of the initialized data-structure
before the flag is actually set.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index f29761b..4850e87 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1431,7 +1431,8 @@ out:
 int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid, unsigned int irq_num,
 			bool level)
 {
-	if (vgic_update_irq_state(kvm, cpuid, irq_num, level))
+	if (likely(vgic_initialized(kvm)) &&
+	    vgic_update_irq_state(kvm, cpuid, irq_num, level))
 		vgic_kick_vcpus(kvm);
 
 	return 0;
@@ -1581,9 +1582,10 @@ int kvm_vgic_init(struct kvm *kvm)
 	for (i = VGIC_NR_PRIVATE_IRQS; i < VGIC_NR_IRQS; i += 4)
 		vgic_set_target_reg(kvm, 0, i);
 
-	kvm->arch.vgic.ready = true;
 out:
 	mutex_unlock(&kvm->lock);
+	if (!ret)
+		kvm->arch.vgic.ready = true;
 	return ret;
 }
 
-- 
1.8.3.4
