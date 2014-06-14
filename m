From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 14 Jun 2014 22:51:04 +0200
Subject: [RFC PATCH 3/6] arm/arm64: KVM: vgic: Clear queued flags on unqueue
In-Reply-To: <1402779067-34478-1-git-send-email-christoffer.dall@linaro.org>
References: <1402779067-34478-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1402779067-34478-4-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we unqueue a level-triggered interrupt completely, and the LR does
not stick around in the active state (and will therefore no longer
generate a maintenance interrupt), then we should clear the queued flag
so that the vgic can actually queue this level-triggered interrupt at a
later time and deal with its pending state then.

Note: This should actually be properly fixed to handle the active state
on the distributor.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 00e6bdd..87c977c 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -660,8 +660,10 @@ static void vgic_unqueue_irqs(struct kvm_vcpu *vcpu)
 		 * active), then the LR does not hold any useful info and can
 		 * be marked as free for other use.
 		 */
-		if (!(*lr & GICH_LR_STATE))
+		if (!(*lr & GICH_LR_STATE)) {
 			vgic_retire_lr(i, irq, vgic_cpu);
+			vgic_irq_clear_queued(vcpu, irq);
+		}
 
 		/* Finally update the VGIC state. */
 		vgic_update_state(vcpu->kvm);
-- 
1.8.5.2
