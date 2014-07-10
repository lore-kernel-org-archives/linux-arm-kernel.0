From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 10 Jul 2014 07:39:53 -0700
Subject: [PATCH 3/6] arm/arm64: KVM: vgic: Clear queued flags on unqueue
In-Reply-To: <1405003196-12403-1-git-send-email-christoffer.dall@linaro.org>
References: <1405003196-12403-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1405003196-12403-4-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we unqueue a level-triggered interrupt completely, and the LR does
not stick around in the active state (and will therefore no longer
generate a maintenance interrupt), then we should clear the queued flag
so that the vgic can actually queue this level-triggered interrupt at a
later time and deal with its pending state then.

Note: This should actually be properly fixed to handle the active state
on the distributor.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index c5b1ad7..1b85f42 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -662,8 +662,10 @@ static void vgic_unqueue_irqs(struct kvm_vcpu *vcpu)
 		 * active), then the LR does not hold any useful info and can
 		 * be marked as free for other use.
 		 */
-		if (!(lr.state & LR_STATE_MASK))
+		if (!(lr.state & LR_STATE_MASK)) {
 			vgic_retire_lr(i, lr.irq, vcpu);
+			vgic_irq_clear_queued(vcpu, lr.irq);
+		}
 
 		/* Finally update the VGIC state. */
 		vgic_update_state(vcpu->kvm);
-- 
2.0.0
