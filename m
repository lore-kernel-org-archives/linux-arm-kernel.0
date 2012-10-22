From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Mon, 22 Oct 2012 02:52:10 -0400
Subject: [PATCH v3 08/13] ARM: KVM: vgic: retire queued, disabled interrupts
In-Reply-To: <20121022065104.18672.52989.stgit@ubuntu>
References: <20121022065104.18672.52989.stgit@ubuntu>
Message-ID: <20121022065209.18672.42742.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

An interrupt may have been disabled after being made pending on the
CPU interface (the classic case is a timer running while we're
rebooting the guest - the interrupt would kick as soon as the CPU
interface gets enabled, with deadly consequences).

The solution is to examine already active LRs, and check the
interrupt is still enabled. If not, just retire it.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 arch/arm/kvm/vgic.c |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/kvm/vgic.c b/arch/arm/kvm/vgic.c
index d7cdec5..dda5623 100644
--- a/arch/arm/kvm/vgic.c
+++ b/arch/arm/kvm/vgic.c
@@ -633,6 +633,34 @@ static void vgic_update_state(struct kvm *kvm)
 
 #define LR_PHYSID(lr) 		(((lr) & VGIC_LR_PHYSID_CPUID) >> 10)
 #define MK_LR_PEND(src, irq)	(VGIC_LR_PENDING_BIT | ((src) << 10) | (irq))
+
+/*
+ * An interrupt may have been disabled after being made pending on the
+ * CPU interface (the classic case is a timer running while we're
+ * rebooting the guest - the interrupt would kick as soon as the CPU
+ * interface gets enabled, with deadly consequences).
+ *
+ * The solution is to examine already active LRs, and check the
+ * interrupt is still enabled. If not, just retire it.
+ */
+static void vgic_retire_disabled_irqs(struct kvm_vcpu *vcpu)
+{
+	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
+	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
+	int lr;
+
+	for_each_set_bit(lr, vgic_cpu->lr_used, vgic_cpu->nr_lr) {
+		int irq = vgic_cpu->vgic_lr[lr] & VGIC_LR_VIRTUALID;
+
+		if (!vgic_bitmap_get_irq_val(&dist->irq_enabled,
+					     vcpu->vcpu_id, irq)) {
+			vgic_cpu->vgic_irq_lr_map[irq] = LR_EMPTY;
+			clear_bit(lr, vgic_cpu->lr_used);
+			vgic_cpu->vgic_lr[lr] &= ~VGIC_LR_STATE;
+		}
+	}
+}
+
 /*
  * Queue an interrupt to a CPU virtual interface. Return true on success,
  * or false if it wasn't possible to queue it.
@@ -696,6 +724,8 @@ static void __kvm_vgic_sync_to_cpu(struct kvm_vcpu *vcpu)
 
 	vcpu_id = vcpu->vcpu_id;
 
+	vgic_retire_disabled_irqs(vcpu);
+
 	/*
 	 * We may not have any pending interrupt, or the interrupts
 	 * may have been serviced from another vcpu. In all cases,
