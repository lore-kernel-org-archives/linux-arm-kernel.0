From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Wed, 16 Jan 2013 13:01:15 -0500
Subject: [PATCH v6 09/13] ARM: KVM: vgic: retire queued, disabled interrupts
In-Reply-To: <20130116180013.29393.49165.stgit@ubuntu>
References: <20130116180013.29393.49165.stgit@ubuntu>
Message-ID: <20130116180115.29393.20261.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

An interrupt may have been disabled after being made pending on the
CPU interface (the classic case is a timer running while we're
rebooting the guest - the interrupt would kick as soon as the CPU
interface gets enabled, with deadly consequences).

The solution is to examine already active LRs, and check the
interrupt is still enabled. If not, just retire it.

Reviewed-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 arch/arm/kvm/vgic.c |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/kvm/vgic.c b/arch/arm/kvm/vgic.c
index 8f32702..2d5e29f 100644
--- a/arch/arm/kvm/vgic.c
+++ b/arch/arm/kvm/vgic.c
@@ -71,6 +71,7 @@
 #define ACCESS_WRITE_VALUE	(3 << 1)
 #define ACCESS_WRITE_MASK(x)	((x) & (3 << 1))
 
+static void vgic_retire_disabled_irqs(struct kvm_vcpu *vcpu);
 static void vgic_update_state(struct kvm *kvm);
 static void vgic_dispatch_sgi(struct kvm_vcpu *vcpu, u32 reg);
 
@@ -353,6 +354,7 @@ static bool handle_mmio_clear_enable_reg(struct kvm_vcpu *vcpu,
 	if (mmio->is_write) {
 		if (offset < 4) /* Force SGI enabled */
 			*reg |= 0xffff;
+		vgic_retire_disabled_irqs(vcpu);
 		vgic_update_state(vcpu->kvm);
 		return true;
 	}
@@ -804,6 +806,34 @@ static void vgic_update_state(struct kvm *kvm)
 	(((lr) & GICH_LR_PHYSID_CPUID) >> GICH_LR_PHYSID_CPUID_SHIFT)
 #define MK_LR_PEND(src, irq)	\
 	(GICH_LR_PENDING_BIT | ((src) << GICH_LR_PHYSID_CPUID_SHIFT) | (irq))
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
+	int lr;
+
+	for_each_set_bit(lr, vgic_cpu->lr_used, vgic_cpu->nr_lr) {
+		int irq = vgic_cpu->vgic_lr[lr] & GICH_LR_VIRTUALID;
+
+		if (!vgic_irq_is_enabled(vcpu, irq)) {
+			vgic_cpu->vgic_irq_lr_map[irq] = LR_EMPTY;
+			clear_bit(lr, vgic_cpu->lr_used);
+			vgic_cpu->vgic_lr[lr] &= ~GICH_LR_STATE;
+			if (vgic_irq_is_active(vcpu, irq))
+				vgic_irq_clear_active(vcpu, irq);
+		}
+	}
+}
+
 /*
  * Queue an interrupt to a CPU virtual interface. Return true on success,
  * or false if it wasn't possible to queue it.
