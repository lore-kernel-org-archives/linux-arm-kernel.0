From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon,  6 Mar 2017 01:56:39 -0800
Subject: [PATCH] KVM: arm/arm64: Let vcpu thread modify its own active state
Message-ID: <1488794199-22397-1-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jintack Lim <jintack@cs.columbia.edu>

Currently, if a vcpu thread tries to change its own active state when
the irq is already in AP list, it'll loop forever. Since the VCPU thread
has already synced back LR state to the struct vgic_irq, let it modify
its own state safely.

Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>
---
 virt/kvm/arm/vgic/vgic-mmio.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-mmio.c b/virt/kvm/arm/vgic/vgic-mmio.c
index 3654b4c..29101ab 100644
--- a/virt/kvm/arm/vgic/vgic-mmio.c
+++ b/virt/kvm/arm/vgic/vgic-mmio.c
@@ -185,9 +185,9 @@ static void vgic_mmio_change_active(struct kvm_vcpu *vcpu, struct vgic_irq *irq,
 	 * If this virtual IRQ was written into a list register, we
 	 * have to make sure the CPU that runs the VCPU thread has
 	 * synced back LR state to the struct vgic_irq.  We can only
-	 * know this for sure, when either this irq is not assigned to
+	 * know this for sure, when this irq is not assigned to
 	 * anyone's AP list anymore, or the VCPU thread is not
-	 * running on any CPUs.
+	 * running on any CPUs, or current thread is the VCPU thread.
 	 *
 	 * In the opposite case, we know the VCPU thread may be on its
 	 * way back from the guest and still has to sync back this
@@ -195,6 +195,7 @@ static void vgic_mmio_change_active(struct kvm_vcpu *vcpu, struct vgic_irq *irq,
 	 * other thread sync back the IRQ.
 	 */
 	while (irq->vcpu && /* IRQ may have state in an LR somewhere */
+	       irq->vcpu != vcpu && /* Current thread is not the VCPU thread */
 	       irq->vcpu->cpu != -1) /* VCPU thread is running */
 		cond_resched_lock(&irq->irq_lock);
 
-- 
2.5.0
