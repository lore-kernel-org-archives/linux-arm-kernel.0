From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Wed, 16 Jan 2013 13:01:09 -0500
Subject: [PATCH v6 08/13] ARM: KVM: VGIC virtual CPU interface management
In-Reply-To: <20130116180013.29393.49165.stgit@ubuntu>
References: <20130116180013.29393.49165.stgit@ubuntu>
Message-ID: <20130116180109.29393.14500.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

Add VGIC virtual CPU interface code, picking pending interrupts
from the distributor and stashing them in the VGIC control interface
list registers.

Reviewed-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 arch/arm/include/asm/kvm_vgic.h |   31 ++++
 arch/arm/kvm/vgic.c             |  327 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 357 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/kvm_vgic.h b/arch/arm/include/asm/kvm_vgic.h
index b1ea1b6..1081649 100644
--- a/arch/arm/include/asm/kvm_vgic.h
+++ b/arch/arm/include/asm/kvm_vgic.h
@@ -33,6 +33,7 @@
 #define VGIC_NR_PRIVATE_IRQS	(VGIC_NR_SGIS + VGIC_NR_PPIS)
 #define VGIC_NR_SHARED_IRQS	(VGIC_NR_IRQS - VGIC_NR_PRIVATE_IRQS)
 #define VGIC_MAX_CPUS		KVM_MAX_VCPUS
+#define VGIC_MAX_LRS		(1 << 6)
 
 /* Sanity checks... */
 #if (VGIC_MAX_CPUS > 8)
@@ -110,8 +111,33 @@ struct vgic_dist {
 };
 
 struct vgic_cpu {
+#ifdef CONFIG_KVM_ARM_VGIC
+	/* per IRQ to LR mapping */
+	u8		vgic_irq_lr_map[VGIC_NR_IRQS];
+
+	/* Pending interrupts on this VCPU */
+	DECLARE_BITMAP(	pending_percpu, VGIC_NR_PRIVATE_IRQS);
+	DECLARE_BITMAP(	pending_shared, VGIC_NR_SHARED_IRQS);
+
+	/* Bitmap of used/free list registers */
+	DECLARE_BITMAP(	lr_used, VGIC_MAX_LRS);
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
+	u32		vgic_lr[VGIC_MAX_LRS];
+#endif
 };
 
+#define LR_EMPTY	0xff
+
 struct kvm;
 struct kvm_vcpu;
 struct kvm_run;
@@ -119,9 +145,14 @@ struct kvm_exit_mmio;
 
 #ifdef CONFIG_KVM_ARM_VGIC
 int kvm_vgic_set_addr(struct kvm *kvm, unsigned long type, u64 addr);
+void kvm_vgic_flush_hwstate(struct kvm_vcpu *vcpu);
+void kvm_vgic_sync_hwstate(struct kvm_vcpu *vcpu);
+int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu);
 bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		      struct kvm_exit_mmio *mmio);
 
+#define irqchip_in_kernel(k)	(!!((k)->arch.vgic.vctrl_base))
+
 #else
 static inline int kvm_vgic_hyp_init(void)
 {
diff --git a/arch/arm/kvm/vgic.c b/arch/arm/kvm/vgic.c
index 815069f..8f32702 100644
--- a/arch/arm/kvm/vgic.c
+++ b/arch/arm/kvm/vgic.c
@@ -152,6 +152,34 @@ static int vgic_irq_is_enabled(struct kvm_vcpu *vcpu, int irq)
 	return vgic_bitmap_get_irq_val(&dist->irq_enabled, vcpu->vcpu_id, irq);
 }
 
+static int vgic_irq_is_active(struct kvm_vcpu *vcpu, int irq)
+{
+	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
+
+	return vgic_bitmap_get_irq_val(&dist->irq_active, vcpu->vcpu_id, irq);
+}
+
+static void vgic_irq_set_active(struct kvm_vcpu *vcpu, int irq)
+{
+	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
+
+	vgic_bitmap_set_irq_val(&dist->irq_active, vcpu->vcpu_id, irq, 1);
+}
+
+static void vgic_irq_clear_active(struct kvm_vcpu *vcpu, int irq)
+{
+	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
+
+	vgic_bitmap_set_irq_val(&dist->irq_active, vcpu->vcpu_id, irq, 0);
+}
+
+static int vgic_dist_irq_is_pending(struct kvm_vcpu *vcpu, int irq)
+{
+	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
+
+	return vgic_bitmap_get_irq_val(&dist->irq_state, vcpu->vcpu_id, irq);
+}
+
 static void vgic_dist_irq_set(struct kvm_vcpu *vcpu, int irq)
 {
 	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
@@ -723,7 +751,30 @@ static void vgic_dispatch_sgi(struct kvm_vcpu *vcpu, u32 reg)
 
 static int compute_pending_for_cpu(struct kvm_vcpu *vcpu)
 {
-	return 0;
+	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
+	unsigned long *pending, *enabled, *pend_percpu, *pend_shared;
+	unsigned long pending_private, pending_shared;
+	int vcpu_id;
+
+	vcpu_id = vcpu->vcpu_id;
+	pend_percpu = vcpu->arch.vgic_cpu.pending_percpu;
+	pend_shared = vcpu->arch.vgic_cpu.pending_shared;
+
+	pending = vgic_bitmap_get_cpu_map(&dist->irq_state, vcpu_id);
+	enabled = vgic_bitmap_get_cpu_map(&dist->irq_enabled, vcpu_id);
+	bitmap_and(pend_percpu, pending, enabled, VGIC_NR_PRIVATE_IRQS);
+
+	pending = vgic_bitmap_get_shared_map(&dist->irq_state);
+	enabled = vgic_bitmap_get_shared_map(&dist->irq_enabled);
+	bitmap_and(pend_shared, pending, enabled, VGIC_NR_SHARED_IRQS);
+	bitmap_and(pend_shared, pend_shared,
+		   vgic_bitmap_get_shared_map(&dist->irq_spi_target[vcpu_id]),
+		   VGIC_NR_SHARED_IRQS);
+
+	pending_private = find_first_bit(pend_percpu, VGIC_NR_PRIVATE_IRQS);
+	pending_shared = find_first_bit(pend_shared, VGIC_NR_SHARED_IRQS);
+	return (pending_private < VGIC_NR_PRIVATE_IRQS ||
+		pending_shared < VGIC_NR_SHARED_IRQS);
 }
 
 /*
@@ -749,6 +800,280 @@ static void vgic_update_state(struct kvm *kvm)
 	}
 }
 
+#define LR_CPUID(lr)	\
+	(((lr) & GICH_LR_PHYSID_CPUID) >> GICH_LR_PHYSID_CPUID_SHIFT)
+#define MK_LR_PEND(src, irq)	\
+	(GICH_LR_PENDING_BIT | ((src) << GICH_LR_PHYSID_CPUID_SHIFT) | (irq))
+/*
+ * Queue an interrupt to a CPU virtual interface. Return true on success,
+ * or false if it wasn't possible to queue it.
+ */
+static bool vgic_queue_irq(struct kvm_vcpu *vcpu, u8 sgi_source_id, int irq)
+{
+	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
+	int lr;
+
+	/* Sanitize the input... */
+	BUG_ON(sgi_source_id & ~7);
+	BUG_ON(sgi_source_id && irq >= VGIC_NR_SGIS);
+	BUG_ON(irq >= VGIC_NR_IRQS);
+
+	kvm_debug("Queue IRQ%d\n", irq);
+
+	lr = vgic_cpu->vgic_irq_lr_map[irq];
+
+	/* Do we have an active interrupt for the same CPUID? */
+	if (lr != LR_EMPTY &&
+	    (LR_CPUID(vgic_cpu->vgic_lr[lr]) == sgi_source_id)) {
+		kvm_debug("LR%d piggyback for IRQ%d %x\n",
+			  lr, irq, vgic_cpu->vgic_lr[lr]);
+		BUG_ON(!test_bit(lr, vgic_cpu->lr_used));
+		vgic_cpu->vgic_lr[lr] |= GICH_LR_PENDING_BIT;
+
+		goto out;
+	}
+
+	/* Try to use another LR for this interrupt */
+	lr = find_first_zero_bit((unsigned long *)vgic_cpu->lr_used,
+			       vgic_cpu->nr_lr);
+	if (lr >= vgic_cpu->nr_lr)
+		return false;
+
+	kvm_debug("LR%d allocated for IRQ%d %x\n", lr, irq, sgi_source_id);
+	vgic_cpu->vgic_lr[lr] = MK_LR_PEND(sgi_source_id, irq);
+	vgic_cpu->vgic_irq_lr_map[irq] = lr;
+	set_bit(lr, vgic_cpu->lr_used);
+
+out:
+	if (!vgic_irq_is_edge(vcpu, irq))
+		vgic_cpu->vgic_lr[lr] |= GICH_LR_EOI;
+
+	return true;
+}
+
+static bool vgic_queue_sgi(struct kvm_vcpu *vcpu, int irq)
+{
+	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
+	unsigned long sources;
+	int vcpu_id = vcpu->vcpu_id;
+	int c;
+
+	sources = dist->irq_sgi_sources[vcpu_id][irq];
+
+	for_each_set_bit(c, &sources, VGIC_MAX_CPUS) {
+		if (vgic_queue_irq(vcpu, c, irq))
+			clear_bit(c, &sources);
+	}
+
+	dist->irq_sgi_sources[vcpu_id][irq] = sources;
+
+	/*
+	 * If the sources bitmap has been cleared it means that we
+	 * could queue all the SGIs onto link registers (see the
+	 * clear_bit above), and therefore we are done with them in
+	 * our emulated gic and can get rid of them.
+	 */
+	if (!sources) {
+		vgic_dist_irq_clear(vcpu, irq);
+		vgic_cpu_irq_clear(vcpu, irq);
+		return true;
+	}
+
+	return false;
+}
+
+static bool vgic_queue_hwirq(struct kvm_vcpu *vcpu, int irq)
+{
+	if (vgic_irq_is_active(vcpu, irq))
+		return true; /* level interrupt, already queued */
+
+	if (vgic_queue_irq(vcpu, 0, irq)) {
+		if (vgic_irq_is_edge(vcpu, irq)) {
+			vgic_dist_irq_clear(vcpu, irq);
+			vgic_cpu_irq_clear(vcpu, irq);
+		} else {
+			vgic_irq_set_active(vcpu, irq);
+		}
+
+		return true;
+	}
+
+	return false;
+}
+
+/*
+ * Fill the list registers with pending interrupts before running the
+ * guest.
+ */
+static void __kvm_vgic_flush_hwstate(struct kvm_vcpu *vcpu)
+{
+	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
+	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
+	int i, vcpu_id;
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
+	for_each_set_bit(i, vgic_cpu->pending_percpu, VGIC_NR_SGIS) {
+		if (!vgic_queue_sgi(vcpu, i))
+			overflow = 1;
+	}
+
+	/* PPIs */
+	for_each_set_bit_from(i, vgic_cpu->pending_percpu, VGIC_NR_PRIVATE_IRQS) {
+		if (!vgic_queue_hwirq(vcpu, i))
+			overflow = 1;
+	}
+
+	/* SPIs */
+	for_each_set_bit(i, vgic_cpu->pending_shared, VGIC_NR_SHARED_IRQS) {
+		if (!vgic_queue_hwirq(vcpu, i + VGIC_NR_PRIVATE_IRQS))
+			overflow = 1;
+	}
+
+epilog:
+	if (overflow) {
+		vgic_cpu->vgic_hcr |= GICH_HCR_UIE;
+	} else {
+		vgic_cpu->vgic_hcr &= ~GICH_HCR_UIE;
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
+static bool vgic_process_maintenance(struct kvm_vcpu *vcpu)
+{
+	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
+	bool level_pending = false;
+
+	kvm_debug("MISR = %08x\n", vgic_cpu->vgic_misr);
+
+	/*
+	 * We do not need to take the distributor lock here, since the only
+	 * action we perform is clearing the irq_active_bit for an EOIed
+	 * level interrupt.  There is a potential race with
+	 * the queuing of an interrupt in __kvm_vgic_flush_hwstate(), where we
+	 * check if the interrupt is already active. Two possibilities:
+	 *
+	 * - The queuing is occurring on the same vcpu: cannot happen,
+	 *   as we're already in the context of this vcpu, and
+	 *   executing the handler
+	 * - The interrupt has been migrated to another vcpu, and we
+	 *   ignore this interrupt for this run. Big deal. It is still
+	 *   pending though, and will get considered when this vcpu
+	 *   exits.
+	 */
+	if (vgic_cpu->vgic_misr & GICH_MISR_EOI) {
+		/*
+		 * Some level interrupts have been EOIed. Clear their
+		 * active bit.
+		 */
+		int lr, irq;
+
+		for_each_set_bit(lr, (unsigned long *)vgic_cpu->vgic_eisr,
+				 vgic_cpu->nr_lr) {
+			irq = vgic_cpu->vgic_lr[lr] & GICH_LR_VIRTUALID;
+
+			vgic_irq_clear_active(vcpu, irq);
+			vgic_cpu->vgic_lr[lr] &= ~GICH_LR_EOI;
+
+			/* Any additional pending interrupt? */
+			if (vgic_dist_irq_is_pending(vcpu, irq)) {
+				vgic_cpu_irq_set(vcpu, irq);
+				level_pending = true;
+			} else {
+				vgic_cpu_irq_clear(vcpu, irq);
+			}
+		}
+	}
+
+	if (vgic_cpu->vgic_misr & GICH_MISR_U)
+		vgic_cpu->vgic_hcr &= ~GICH_HCR_UIE;
+
+	return level_pending;
+}
+
+/*
+ * Sync back the VGIC state after a guest run. We do not really touch
+ * the distributor here (the irq_pending_on_cpu bit is safe to set),
+ * so there is no need for taking its lock.
+ */
+static void __kvm_vgic_sync_hwstate(struct kvm_vcpu *vcpu)
+{
+	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
+	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
+	int lr, pending;
+	bool level_pending;
+
+	level_pending = vgic_process_maintenance(vcpu);
+
+	/* Clear mappings for empty LRs */
+	for_each_set_bit(lr, (unsigned long *)vgic_cpu->vgic_elrsr,
+			 vgic_cpu->nr_lr) {
+		int irq;
+
+		if (!test_and_clear_bit(lr, vgic_cpu->lr_used))
+			continue;
+
+		irq = vgic_cpu->vgic_lr[lr] & GICH_LR_VIRTUALID;
+
+		BUG_ON(irq >= VGIC_NR_IRQS);
+		vgic_cpu->vgic_irq_lr_map[irq] = LR_EMPTY;
+	}
+
+	/* Check if we still have something up our sleeve... */
+	pending = find_first_zero_bit((unsigned long *)vgic_cpu->vgic_elrsr,
+				      vgic_cpu->nr_lr);
+	if (level_pending || pending < vgic_cpu->nr_lr)
+		set_bit(vcpu->vcpu_id, &dist->irq_pending_on_cpu);
+}
+
+void kvm_vgic_flush_hwstate(struct kvm_vcpu *vcpu)
+{
+	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
+
+	if (!irqchip_in_kernel(vcpu->kvm))
+		return;
+
+	spin_lock(&dist->lock);
+	__kvm_vgic_flush_hwstate(vcpu);
+	spin_unlock(&dist->lock);
+}
+
+void kvm_vgic_sync_hwstate(struct kvm_vcpu *vcpu)
+{
+	if (!irqchip_in_kernel(vcpu->kvm))
+		return;
+
+	__kvm_vgic_sync_hwstate(vcpu);
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
+
 static bool vgic_ioaddr_overlap(struct kvm *kvm)
 {
 	phys_addr_t dist = kvm->arch.vgic.vgic_dist_base;
