From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 19 Jun 2014 10:21:25 +0100
Subject: [PATCH v2 1/9] KVM: ARM: vgic: plug irq injection race
In-Reply-To: <1403169693-13982-1-git-send-email-marc.zyngier@arm.com>
References: <1403169693-13982-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1403169693-13982-2-git-send-email-marc.zyngier@arm.com>
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
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 795ab48..c6da748 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1446,7 +1446,8 @@ out:
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
