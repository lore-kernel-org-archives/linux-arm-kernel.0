From: cdall@linaro.org (Christoffer Dall)
Date: Thu, 18 May 2017 11:47:13 +0200
Subject: [PULL 04/13] KVM: arm/arm64: vgic-v2: Do not use Active+Pending state
 for a HW interrupt
In-Reply-To: <20170518094722.9926-1-cdall@linaro.org>
References: <20170518094722.9926-1-cdall@linaro.org>
Message-ID: <20170518094722.9926-5-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

When an interrupt is injected with the HW bit set (indicating that
deactivation should be propagated to the physical distributor),
special care must be taken so that we never mark the corresponding
LR with the Active+Pending state (as the pending state is kept in
the physycal distributor).

Cc: stable at vger.kernel.org
Fixes: 140b086dd197 ("KVM: arm/arm64: vgic-new: Add GICv2 world switch backend")
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Christoffer Dall <cdall@linaro.org>
Signed-off-by: Christoffer Dall <cdall@linaro.org>
---
 virt/kvm/arm/vgic/vgic-v2.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/virt/kvm/arm/vgic/vgic-v2.c b/virt/kvm/arm/vgic/vgic-v2.c
index a65757a..504b4bd 100644
--- a/virt/kvm/arm/vgic/vgic-v2.c
+++ b/virt/kvm/arm/vgic/vgic-v2.c
@@ -149,6 +149,13 @@ void vgic_v2_populate_lr(struct kvm_vcpu *vcpu, struct vgic_irq *irq, int lr)
 	if (irq->hw) {
 		val |= GICH_LR_HW;
 		val |= irq->hwintid << GICH_LR_PHYSID_CPUID_SHIFT;
+		/*
+		 * Never set pending+active on a HW interrupt, as the
+		 * pending state is kept@the physical distributor
+		 * level.
+		 */
+		if (irq->active && irq_is_pending(irq))
+			val &= ~GICH_LR_PENDING_BIT;
 	} else {
 		if (irq->config == VGIC_CONFIG_LEVEL)
 			val |= GICH_LR_EOI;
-- 
2.9.0
