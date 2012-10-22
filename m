From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Mon, 22 Oct 2012 02:52:36 -0400
Subject: [PATCH v3 12/13] ARM: KVM: vgic: reduce the number of vcpu kick
In-Reply-To: <20121022065104.18672.52989.stgit@ubuntu>
References: <20121022065104.18672.52989.stgit@ubuntu>
Message-ID: <20121022065236.18672.65199.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

If we have level interrupts already programmed to fire on a vcpu,
there is no reason to kick it after injecting a new interrupt,
as we're guaranteed that we'll exit when the level interrupt will
be EOId (VGIC_LR_EOI is set).

The exit will force a reload of the VGIC, injecting the new interrupts.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 arch/arm/include/asm/kvm_vgic.h |   10 ++++++++++
 arch/arm/kvm/arm.c              |   10 +++++++++-
 arch/arm/kvm/vgic.c             |   10 ++++++++--
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/kvm_vgic.h b/arch/arm/include/asm/kvm_vgic.h
index 1287f75..447ec7a 100644
--- a/arch/arm/include/asm/kvm_vgic.h
+++ b/arch/arm/include/asm/kvm_vgic.h
@@ -215,6 +215,9 @@ struct vgic_cpu {
 	u32		vgic_elrsr[2];	/* Saved only */
 	u32		vgic_apr;
 	u32		vgic_lr[64];	/* A15 has only 4... */
+
+	/* Number of level-triggered interrupt in progress */
+	atomic_t	irq_active_count;
 #endif
 };
 
@@ -254,6 +257,8 @@ bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
 
 #define irqchip_in_kernel(k)	(!!((k)->arch.vgic.vctrl_base))
 #define vgic_initialized(k)	((k)->arch.vgic.ready)
+#define vgic_active_irq(v)	(atomic_read(&(v)->arch.vgic_cpu.irq_active_count) == 0)
+
 #else
 static inline int kvm_vgic_hyp_init(void)
 {
@@ -305,6 +310,11 @@ static inline bool kvm_vgic_initialized(struct kvm *kvm)
 {
 	return true;
 }
+
+static inline int vgic_active_irq(struct kvm_vcpu *vcpu)
+{
+	return 0;
+}
 #endif
 
 #endif
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index d367831..cab9cb7 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -94,7 +94,15 @@ int kvm_arch_hardware_enable(void *garbage)
 
 int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
 {
-	return kvm_vcpu_exiting_guest_mode(vcpu) == IN_GUEST_MODE;
+	if (kvm_vcpu_exiting_guest_mode(vcpu) == IN_GUEST_MODE) {
+		if (vgic_active_irq(vcpu) &&
+		    cmpxchg(&vcpu->mode, EXITING_GUEST_MODE, IN_GUEST_MODE) == EXITING_GUEST_MODE)
+			return 0;
+
+		return 1;
+	}
+
+	return 0;
 }
 
 void kvm_arch_hardware_disable(void *garbage)
diff --git a/arch/arm/kvm/vgic.c b/arch/arm/kvm/vgic.c
index 415ddb8..146de1d 100644
--- a/arch/arm/kvm/vgic.c
+++ b/arch/arm/kvm/vgic.c
@@ -705,8 +705,10 @@ static bool vgic_queue_irq(struct kvm_vcpu *vcpu, u8 sgi_source_id, int irq)
 		kvm_debug("LR%d piggyback for IRQ%d %x\n", lr, irq, vgic_cpu->vgic_lr[lr]);
 		BUG_ON(!test_bit(lr, vgic_cpu->lr_used));
 		vgic_cpu->vgic_lr[lr] |= VGIC_LR_PENDING_BIT;
-		if (is_level)
+		if (is_level) {
 			vgic_cpu->vgic_lr[lr] |= VGIC_LR_EOI;
+			atomic_inc(&vgic_cpu->irq_active_count);
+		}
 		return true;
 	}
 
@@ -718,8 +720,10 @@ static bool vgic_queue_irq(struct kvm_vcpu *vcpu, u8 sgi_source_id, int irq)
 
 	kvm_debug("LR%d allocated for IRQ%d %x\n", lr, irq, sgi_source_id);
 	vgic_cpu->vgic_lr[lr] = MK_LR_PEND(sgi_source_id, irq);
-	if (is_level)
+	if (is_level) {
 		vgic_cpu->vgic_lr[lr] |= VGIC_LR_EOI;
+		atomic_inc(&vgic_cpu->irq_active_count);
+	}
 
 	vgic_cpu->vgic_irq_lr_map[irq] = lr;
 	clear_bit(lr, (unsigned long *)vgic_cpu->vgic_elrsr);
@@ -1011,6 +1015,8 @@ static irqreturn_t vgic_maintenance_handler(int irq, void *data)
 
 			vgic_bitmap_set_irq_val(&dist->irq_active,
 						vcpu->vcpu_id, irq, 0);
+			atomic_dec(&vgic_cpu->irq_active_count);
+			smp_mb();
 			vgic_cpu->vgic_lr[lr] &= ~VGIC_LR_EOI;
 			writel_relaxed(vgic_cpu->vgic_lr[lr],
 				       dist->vctrl_base + GICH_LR0 + (lr << 2));
