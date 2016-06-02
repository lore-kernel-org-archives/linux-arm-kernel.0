From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu,  2 Jun 2016 12:21:00 +0200
Subject: [PULL 8/8] KVM: arm/arm64: vgic-new: Removel harmful BUG_ON
In-Reply-To: <1464862860-1183-1-git-send-email-christoffer.dall@linaro.org>
References: <1464862860-1183-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1464862860-1183-9-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

When changing the active bit from an MMIO trap, we decide to
explode if the intid is that of a private interrupt.

This flawed logic comes from the fact that we were assuming that
kvm_vcpu_kick() as called by kvm_arm_halt_vcpu() would not return before
the called vcpu responded, but this is not the case, so we need to
perform this wait even for private interrupts.

Dropping the BUG_ON seems like the right thing to do.

 [ Commit message tweaked by Christoffer ]

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic/vgic-mmio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-mmio.c b/virt/kvm/arm/vgic/vgic-mmio.c
index 059595e..9f6fab7 100644
--- a/virt/kvm/arm/vgic/vgic-mmio.c
+++ b/virt/kvm/arm/vgic/vgic-mmio.c
@@ -191,10 +191,8 @@ static void vgic_mmio_change_active(struct kvm_vcpu *vcpu, struct vgic_irq *irq,
 	 * other thread sync back the IRQ.
 	 */
 	while (irq->vcpu && /* IRQ may have state in an LR somewhere */
-	       irq->vcpu->cpu != -1) { /* VCPU thread is running */
-		BUG_ON(irq->intid < VGIC_NR_PRIVATE_IRQS);
+	       irq->vcpu->cpu != -1) /* VCPU thread is running */
 		cond_resched_lock(&irq->irq_lock);
-	}
 
 	irq->active = new_active_state;
 	if (new_active_state)
-- 
2.1.2.330.g565301e.dirty
