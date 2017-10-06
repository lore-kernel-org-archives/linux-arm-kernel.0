From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  6 Oct 2017 16:33:45 +0100
Subject: [PATCH v4 10/26] KVM: arm/arm64: GICv4: Handle INT command applied to
 a VLPI
In-Reply-To: <20171006153401.5481-1-marc.zyngier@arm.com>
References: <20171006153401.5481-1-marc.zyngier@arm.com>
Message-ID: <20171006153401.5481-11-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the guest issues an INT command targetting a VLPI, let's
call into the irq_set_irqchip_state() helper to make it pending
on the physical side.

This works just as well if userspace decides to inject an interrupt
using the normal userspace API...

Acked-by: Christoffer Dall <cdall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic/vgic-its.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index 89768d2b6a91..b2a678d131d0 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -578,6 +578,10 @@ static int vgic_its_trigger_msi(struct kvm *kvm, struct vgic_its *its,
 	if (err)
 		return err;
 
+	if (irq->hw)
+		return irq_set_irqchip_state(irq->host_irq,
+					     IRQCHIP_STATE_PENDING, true);
+
 	spin_lock(&irq->irq_lock);
 	irq->pending_latch = true;
 	vgic_queue_irq_unlock(kvm, irq);
-- 
2.14.1
