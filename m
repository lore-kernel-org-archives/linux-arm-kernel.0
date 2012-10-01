From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Mon, 01 Oct 2012 05:08:08 -0400
Subject: [PATCH v2 05/10] ARM: KVM: VGIC virtual CPU interface management
In-Reply-To: <20121001090716.49038.90056.stgit@ubuntu>
References: <20121001090716.49038.90056.stgit@ubuntu>
Message-ID: <20121001090808.49038.32377.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

Add VGIC virtual CPU interface code, picking pending interrupts
from the distributor and stashing them in the VGIC control interface
list registers.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 arch/arm/include/asm/kvm_vgic.h |   41 +++++++
 arch/arm/kvm/vgic.c             |  224 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 264 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/kvm_vgic.h b/arch/arm/include/asm/kvm_vgic.h
index a82699f..bb67076 100644
--- a/arch/arm/include/asm/kvm_vgic.h
+++ b/arch/arm/include/asm/kvm_vgic.h
@@ -193,17 +193,58 @@ struct vgic_dist {
 };
 
 struct vgic_cpu {
+#ifdef CONFIG_KVM_ARM_VGIC
+	/* per IRQ to LR mapping */
+	u8		vgic_irq_lr_map[VGIC_NR_IRQS];
+
+	/* Pending interrupts on this VCPU */
+	DECLARE_BITMAP(	pending, VGIC_NR_IRQS);
+
+	/* Bitmap of used/free list registers */
+	DECLARE_BITMAP(	lr_used, 64);
+
+	/* Number of list registers on this CPU */
+	int		nr_lr;
+
+	/* CPU vif control registers for world switch */
+	u32		vgic_hcr;
+	u32		vgic_vmcr;
+	u32		vgic_misr;	/* Saved only */
+	u32		vgic_eisr[2];	/* Saved only */
+	u32		vgic_elrsr[2];	/* Saved only */
+	u32		vgic_apr;
+	u32		vgic_lr[64];	/* A15 has only 4... */
+#endif
 };
 
+#define VGIC_HCR_EN		(1 << 0)
+#define VGIC_HCR_UIE		(1 << 1)
+
+#define VGIC_LR_VIRTUALID	(0x3ff << 0)
+#define VGIC_LR_PHYSID_CPUID	(7 << 10)
+#define VGIC_LR_STATE		(3 << 28)
+#define VGIC_LR_PENDING_BIT	(1 << 28)
+#define VGIC_LR_ACTIVE_BIT	(1 << 29)
+#define VGIC_LR_EOI		(1 << 19)
+
+#define VGIC_MISR_EOI		(1 << 0)
+#define VGIC_MISR_U		(1 << 1)
+
+#define LR_EMPTY	0xff
+
 struct kvm;
 struct kvm_vcpu;
 struct kvm_run;
 struct kvm_exit_mmio;
 
 #ifdef CONFIG_KVM_ARM_VGIC
+void kvm_vgic_sync_to_cpu(struct kvm_vcpu *vcpu);
+void kvm_vgic_sync_from_cpu(struct kvm_vcpu *vcpu);
+int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu);
 bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		      struct kvm_exit_mmio *mmio);
 
+#define irqchip_in_kernel(k)	(!!((k)->arch.vgic.vctrl_base))
 #else
 static inline int kvm_vgic_hyp_init(void)
 {
diff --git a/arch/arm/kvm/vgic.c b/arch/arm/kvm/vgic.c
index a870596..2b90785 100644
--- a/arch/arm/kvm/vgic.c
+++ b/arch/arm/kvm/vgic.c
@@ -584,7 +584,25 @@ static void vgic_dispatch_sgi(struct kvm_vcpu *vcpu, u32 reg)
 
 static int compute_pending_for_cpu(struct kvm_vcpu *vcpu)
 {
-	return 0;
+	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
+	unsigned long *pending, *enabled, *pend;
+	int vcpu_id;
+
+	vcpu_id = vcpu->vcpu_id;
+	pend = vcpu->arch.vgic_cpu.pending;
+
+	pending = vgic_bitmap_get_cpu_map(&dist->irq_state, vcpu_id);
+	enabled = vgic_bitmap_get_cpu_map(&dist->irq_enabled, vcpu_id);
+	bitmap_and(pend, pending, enabled, 32);
+
+	pending = vgic_bitmap_get_shared_map(&dist->irq_state);
+	enabled = vgic_bitmap_get_shared_map(&dist->irq_enabled);
+	bitmap_and(pend + 1, pending, enabled, VGIC_NR_SHARED_IRQS);
+	bitmap_and(pend + 1, pend + 1,
+		   vgic_bitmap_get_shared_map(&dist->irq_spi_target[vcpu_id]),
+		   VGIC_NR_SHARED_IRQS);
+
+	return (find_first_bit(pend, VGIC_NR_IRQS) < VGIC_NR_IRQS);
 }
 
 /*
@@ -609,3 +627,207 @@ static void vgic_update_state(struct kvm *kvm)
 		}
 	}
 }
+
+#define LR_PHYSID(lr) 		(((lr) & VGIC_LR_PHYSID_CPUID) >> 10)
+#define MK_LR_PEND(src, irq)	(VGIC_LR_PENDING_BIT | ((src) << 10) | (irq))
+/*
+ * Queue an interrupt to a CPU virtual interface. Return true on success,
+ * or false if it wasn't possible to queue it.
+ */
+static bool vgic_queue_irq(struct kvm_vcpu *vcpu, u8 sgi_source_id, int irq)
+{
+	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
+	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
+	int lr, is_level;
+
+	/* Sanitize the input... */
+	BUG_ON(sgi_source_id & ~7);
+	BUG_ON(sgi_source_id && irq > 15);
+	BUG_ON(irq >= VGIC_NR_IRQS);
+
+	kvm_debug("Queue IRQ%d\n", irq);
+
+	lr = vgic_cpu->vgic_irq_lr_map[irq];
+	is_level = !vgic_irq_is_edge(dist, irq);
+
+	/* Do we have an active interrupt for the same CPUID? */
+	if (lr != LR_EMPTY &&
+	    (LR_PHYSID(vgic_cpu->vgic_lr[lr]) == sgi_source_id)) {
+		kvm_debug("LR%d piggyback for IRQ%d %x\n", lr, irq, vgic_cpu->vgic_lr[lr]);
+		BUG_ON(!test_bit(lr, vgic_cpu->lr_used));
+		vgic_cpu->vgic_lr[lr] |= VGIC_LR_PENDING_BIT;
+		if (is_level)
+			vgic_cpu->vgic_lr[lr] |= VGIC_LR_EOI;
+		return true;
+	}
+
+	/* Try to use another LR for this interrupt */
+	lr = find_first_bit((unsigned long *)vgic_cpu->vgic_elrsr,
+			       vgic_cpu->nr_lr);
+	if (lr >= vgic_cpu->nr_lr)
+		return false;
+
+	kvm_debug("LR%d allocated for IRQ%d %x\n", lr, irq, sgi_source_id);
+	vgic_cpu->vgic_lr[lr] = MK_LR_PEND(sgi_source_id, irq);
+	if (is_level)
+		vgic_cpu->vgic_lr[lr] |= VGIC_LR_EOI;
+
+	vgic_cpu->vgic_irq_lr_map[irq] = lr;
+	clear_bit(lr, (unsigned long *)vgic_cpu->vgic_elrsr);
+	set_bit(lr, vgic_cpu->lr_used);
+
+	return true;
+}
+
+/*
+ * Fill the list registers with pending interrupts before running the
+ * guest.
+ */
+static void __kvm_vgic_sync_to_cpu(struct kvm_vcpu *vcpu)
+{
+	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
+	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
+	unsigned long *pending;
+	int i, c, vcpu_id;
+	int overflow = 0;
+
+	vcpu_id = vcpu->vcpu_id;
+
+	/*
+	 * We may not have any pending interrupt, or the interrupts
+	 * may have been serviced from another vcpu. In all cases,
+	 * move along.
+	 */
+	if (!kvm_vgic_vcpu_pending_irq(vcpu)) {
+		pr_debug("CPU%d has no pending interrupt\n", vcpu_id);
+		goto epilog;
+	}
+
+	/* SGIs */
+	pending = vgic_bitmap_get_cpu_map(&dist->irq_state, vcpu_id);
+	for_each_set_bit(i, vgic_cpu->pending, 16) {
+		unsigned long sources;
+
+		sources = dist->irq_sgi_sources[vcpu_id][i];
+		for_each_set_bit(c, &sources, 8) {
+			if (!vgic_queue_irq(vcpu, c, i)) {
+				overflow = 1;
+				continue;
+			}
+
+			clear_bit(c, &sources);
+		}
+
+		if (!sources)
+			clear_bit(i, pending);
+
+		dist->irq_sgi_sources[vcpu_id][i] = sources;
+	}
+
+	/* PPIs */
+	for_each_set_bit_from(i, vgic_cpu->pending, 32) {
+		if (!vgic_queue_irq(vcpu, 0, i)) {
+			overflow = 1;
+			continue;
+		}
+
+		clear_bit(i, pending);
+	}
+
+
+	/* SPIs */
+	pending = vgic_bitmap_get_shared_map(&dist->irq_state);
+	for_each_set_bit_from(i, vgic_cpu->pending, VGIC_NR_IRQS) {
+		if (vgic_bitmap_get_irq_val(&dist->irq_active, 0, i))
+			continue; /* level interrupt, already queued */
+
+		if (!vgic_queue_irq(vcpu, 0, i)) {
+			overflow = 1;
+			continue;
+		}
+
+		/* Immediate clear on edge, set active on level */
+		if (vgic_irq_is_edge(dist, i))
+			clear_bit(i - 32, pending);
+		else
+			vgic_bitmap_set_irq_val(&dist->irq_active, 0, i, 1);
+	}
+
+epilog:
+	if (overflow)
+		vgic_cpu->vgic_hcr |= VGIC_HCR_UIE;
+	else {
+		vgic_cpu->vgic_hcr &= ~VGIC_HCR_UIE;
+		/*
+		 * We're about to run this VCPU, and we've consumed
+		 * everything the distributor had in store for
+		 * us. Claim we don't have anything pending. We'll
+		 * adjust that if needed while exiting.
+		 */
+		clear_bit(vcpu_id, &dist->irq_pending_on_cpu);
+	}
+}
+
+/*
+ * Sync back the VGIC state after a guest run. We do not really touch
+ * the distributor here (the irq_pending_on_cpu bit is safe to set),
+ * so there is no need for taking its lock.
+ */
+static void __kvm_vgic_sync_from_cpu(struct kvm_vcpu *vcpu)
+{
+	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
+	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
+	int lr, pending;
+
+	/* Clear mappings for empty LRs */
+	for_each_set_bit(lr, (unsigned long *)vgic_cpu->vgic_elrsr,
+			 vgic_cpu->nr_lr) {
+		int irq;
+
+		if (!test_and_clear_bit(lr, vgic_cpu->lr_used))
+			continue;
+
+		irq = vgic_cpu->vgic_lr[lr] & VGIC_LR_VIRTUALID;
+
+		BUG_ON(irq >= VGIC_NR_IRQS);
+		vgic_cpu->vgic_irq_lr_map[irq] = LR_EMPTY;
+	}
+
+	/* Check if we still have something up our sleeve... */
+	pending = find_first_zero_bit((unsigned long *)vgic_cpu->vgic_elrsr,
+				      vgic_cpu->nr_lr);
+	if (pending < vgic_cpu->nr_lr) {
+		set_bit(vcpu->vcpu_id, &dist->irq_pending_on_cpu);
+		smp_mb();
+	}
+}
+
+void kvm_vgic_sync_to_cpu(struct kvm_vcpu *vcpu)
+{
+	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
+
+	if (!irqchip_in_kernel(vcpu->kvm))
+		return;
+
+	spin_lock(&dist->lock);
+	__kvm_vgic_sync_to_cpu(vcpu);
+	spin_unlock(&dist->lock);
+}
+
+void kvm_vgic_sync_from_cpu(struct kvm_vcpu *vcpu)
+{
+	if (!irqchip_in_kernel(vcpu->kvm))
+		return;
+
+	__kvm_vgic_sync_from_cpu(vcpu);
+}
+
+int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu)
+{
+	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
+
+	if (!irqchip_in_kernel(vcpu->kvm))
+		return 0;
+
+	return test_bit(vcpu->vcpu_id, &dist->irq_pending_on_cpu);
+}
