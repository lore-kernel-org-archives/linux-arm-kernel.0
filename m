From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 31 Jul 2017 18:26:20 +0100
Subject: [PATCH v3 42/59] KVM: arm/arm64: GICv4: Handle INT command applied to
 a VLPI
In-Reply-To: <20170731172637.29355-1-marc.zyngier@arm.com>
References: <20170731172637.29355-1-marc.zyngier@arm.com>
Message-ID: <20170731172637.29355-43-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the guest issues an INT command targetting a VLPI, let's
call into the irq_set_irqchip_state() helper to make it pending
on the physical side.

This works just as well if userspace decides to inject an interrupt
using the normal userspace API...

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic/vgic-its.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index a2217f53bbe5..40aeadef33fe 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -573,6 +573,10 @@ static int vgic_its_trigger_msi(struct kvm *kvm, struct vgic_its *its,
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
2.11.0
