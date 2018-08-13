From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 13 Aug 2018 15:57:34 +0100
Subject: [PATCH 16/37] KVM: arm/arm64: vgic: Signal IRQs using their
 configured group
In-Reply-To: <20180813145755.16566-1-marc.zyngier@arm.com>
References: <20180813145755.16566-1-marc.zyngier@arm.com>
Message-ID: <20180813145755.16566-17-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoffer Dall <christoffer.dall@arm.com>

Now when we have a group configuration on the struct IRQ, use this state
when populating the LR and signaling interrupts as either group 0 or
group 1 to the VM.  Depending on the model of the emulated GIC, and the
guest's configuration of the VMCR, interrupts may be signaled as IRQs or
FIQs to the VM.

Reviewed-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/linux/irqchip/arm-gic.h | 1 +
 virt/kvm/arm/vgic/vgic-v2.c     | 3 +++
 virt/kvm/arm/vgic/vgic-v3.c     | 6 +-----
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
index 484f5bfa9f3d..6c4aaf04046c 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -104,6 +104,7 @@
 #define GICH_LR_PENDING_BIT		(1 << 28)
 #define GICH_LR_ACTIVE_BIT		(1 << 29)
 #define GICH_LR_EOI			(1 << 19)
+#define GICH_LR_GROUP1			(1 << 30)
 #define GICH_LR_HW			(1 << 31)
 
 #define GICH_VMCR_ENABLE_GRP0_SHIFT	0
diff --git a/virt/kvm/arm/vgic/vgic-v2.c b/virt/kvm/arm/vgic/vgic-v2.c
index a5f2e44f1c33..df5e6a6e3186 100644
--- a/virt/kvm/arm/vgic/vgic-v2.c
+++ b/virt/kvm/arm/vgic/vgic-v2.c
@@ -159,6 +159,9 @@ void vgic_v2_populate_lr(struct kvm_vcpu *vcpu, struct vgic_irq *irq, int lr)
 		}
 	}
 
+	if (irq->group)
+		val |= GICH_LR_GROUP1;
+
 	if (irq->hw) {
 		val |= GICH_LR_HW;
 		val |= irq->hwintid << GICH_LR_PHYSID_CPUID_SHIFT;
diff --git a/virt/kvm/arm/vgic/vgic-v3.c b/virt/kvm/arm/vgic/vgic-v3.c
index cdce653e3c47..530b8491c892 100644
--- a/virt/kvm/arm/vgic/vgic-v3.c
+++ b/virt/kvm/arm/vgic/vgic-v3.c
@@ -197,11 +197,7 @@ void vgic_v3_populate_lr(struct kvm_vcpu *vcpu, struct vgic_irq *irq, int lr)
 	if (vgic_irq_is_mapped_level(irq) && (val & ICH_LR_PENDING_BIT))
 		irq->line_level = false;
 
-	/*
-	 * We currently only support Group1 interrupts, which is a
-	 * known defect. This needs to be addressed at some point.
-	 */
-	if (model == KVM_DEV_TYPE_ARM_VGIC_V3)
+	if (irq->group)
 		val |= ICH_LR_GROUP;
 
 	val |= (u64)irq->priority << ICH_LR_PRIORITY_SHIFT;
-- 
2.18.0
