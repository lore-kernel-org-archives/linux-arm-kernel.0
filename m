From: andre.przywara@arm.com (Andre Przywara)
Date: Tue,  6 Mar 2018 09:21:06 +0000
Subject: [PATCH] KVM: arm/arm64: VGIC MMIO: add missing irq_lock
Message-ID: <20180306092106.13044-1-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our irq_is_pending() helper function accesses multiple members of the
vgic_irq struct, so we need to hold the lock when calling it.
Add that requirement as a comment to the definition and take the lock
around the call in vgic_mmio_read_pending(), where we were missing it
before.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 virt/kvm/arm/vgic/vgic-mmio.c | 3 +++
 virt/kvm/arm/vgic/vgic.h      | 1 +
 2 files changed, 4 insertions(+)

diff --git a/virt/kvm/arm/vgic/vgic-mmio.c b/virt/kvm/arm/vgic/vgic-mmio.c
index 83d82bd7dc4e..dbe99d635c80 100644
--- a/virt/kvm/arm/vgic/vgic-mmio.c
+++ b/virt/kvm/arm/vgic/vgic-mmio.c
@@ -113,9 +113,12 @@ unsigned long vgic_mmio_read_pending(struct kvm_vcpu *vcpu,
 	/* Loop over all IRQs affected by this read */
 	for (i = 0; i < len * 8; i++) {
 		struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, intid + i);
+		unsigned long flags;
 
+		spin_lock_irqsave(&irq->irq_lock, flags);
 		if (irq_is_pending(irq))
 			value |= (1U << i);
+		spin_unlock_irqrestore(&irq->irq_lock, flags);
 
 		vgic_put_irq(vcpu->kvm, irq);
 	}
diff --git a/virt/kvm/arm/vgic/vgic.h b/virt/kvm/arm/vgic/vgic.h
index 12c37b89f7a3..5b11859a1a1e 100644
--- a/virt/kvm/arm/vgic/vgic.h
+++ b/virt/kvm/arm/vgic/vgic.h
@@ -96,6 +96,7 @@
 /* we only support 64 kB translation table page size */
 #define KVM_ITS_L1E_ADDR_MASK		GENMASK_ULL(51, 16)
 
+/* Requires the irq_lock to be held by the caller. */
 static inline bool irq_is_pending(struct vgic_irq *irq)
 {
 	if (irq->config == VGIC_CONFIG_EDGE)
-- 
2.14.1
