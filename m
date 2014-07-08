From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  8 Jul 2014 12:09:01 +0100
Subject: [PATCH v3 2/9] arm/arm64: KVM: vgic: switch to dynamic allocation
In-Reply-To: <1404817748-31302-1-git-send-email-marc.zyngier@arm.com>
References: <1404817748-31302-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1404817748-31302-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So far, all the VGIC data structures are statically defined by the
*maximum* number of vcpus and interrupts it supports. It means that
we always have to oversize it to cater for the worse case.

Start by changing the data structures to be dynamically sizeable,
and allocate them at runtime.

The sizes are still very static though.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/arm.c     |   3 +
 include/kvm/arm_vgic.h |  44 ++++++----
 virt/kvm/arm/vgic.c    | 232 ++++++++++++++++++++++++++++++++++++++++++-------
 3 files changed, 231 insertions(+), 48 deletions(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 3c82b37..782632e 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -182,6 +182,8 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 			kvm->vcpus[i] = NULL;
 		}
 	}
+
+	kvm_vgic_destroy(kvm);
 }
 
 int kvm_dev_ioctl_check_extension(long ext)
@@ -290,6 +292,7 @@ void kvm_arch_vcpu_free(struct kvm_vcpu *vcpu)
 {
 	kvm_mmu_free_memory_caches(vcpu);
 	kvm_timer_vcpu_terminate(vcpu);
+	kvm_vgic_vcpu_destroy(vcpu);
 	kmem_cache_free(kvm_vcpu_cache, vcpu);
 }
 
diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index 35b0c12..2246f4c 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -54,19 +54,24 @@
  * - a bunch of shared interrupts (SPI)
  */
 struct vgic_bitmap {
-	union {
-		u32 reg[VGIC_NR_PRIVATE_IRQS / 32];
-		DECLARE_BITMAP(reg_ul, VGIC_NR_PRIVATE_IRQS);
-	} percpu[VGIC_MAX_CPUS];
-	union {
-		u32 reg[VGIC_NR_SHARED_IRQS / 32];
-		DECLARE_BITMAP(reg_ul, VGIC_NR_SHARED_IRQS);
-	} shared;
+	/*
+	 * - One UL per VCPU for private interrupts (assumes UL is at
+	 * least 32 bits)
+	 * - As many UL as necessary for shared interrupts.
+	 */
+	int nr_cpus;
+	unsigned long *private;
+	unsigned long *shared;
 };
 
 struct vgic_bytemap {
-	u32 percpu[VGIC_MAX_CPUS][VGIC_NR_PRIVATE_IRQS / 4];
-	u32 shared[VGIC_NR_SHARED_IRQS  / 4];
+	/*
+	 * - 8 u32 per VCPU for private interrupts
+	 * - As many u32 as necessary for shared interrupts.
+	 */
+	int nr_cpus;
+	u32 *private;
+	u32 *shared;
 };
 
 struct kvm_vcpu;
@@ -127,6 +132,9 @@ struct vgic_dist {
 	bool			in_kernel;
 	bool			ready;
 
+	int			nr_cpus;
+	int			nr_irqs;
+
 	/* Virtual control interface mapping */
 	void __iomem		*vctrl_base;
 
@@ -152,15 +160,15 @@ struct vgic_dist {
 	/* Level/edge triggered */
 	struct vgic_bitmap	irq_cfg;
 
-	/* Source CPU per SGI and target CPU */
-	u8			irq_sgi_sources[VGIC_MAX_CPUS][VGIC_NR_SGIS];
+	/* Source CPU per SGI and target CPU : 16 bytes per CPU */
+	u8			*irq_sgi_sources;
 
 	/* Target CPU for each IRQ */
-	u8			irq_spi_cpu[VGIC_NR_SHARED_IRQS];
-	struct vgic_bitmap	irq_spi_target[VGIC_MAX_CPUS];
+	u8			*irq_spi_cpu;
+	struct vgic_bitmap	*irq_spi_target;
 
 	/* Bitmap indicating which CPU has something pending */
-	unsigned long		irq_pending_on_cpu;
+	unsigned long		*irq_pending_on_cpu;
 #endif
 };
 
@@ -190,11 +198,11 @@ struct vgic_v3_cpu_if {
 struct vgic_cpu {
 #ifdef CONFIG_KVM_ARM_VGIC
 	/* per IRQ to LR mapping */
-	u8		vgic_irq_lr_map[VGIC_NR_IRQS];
+	u8		*vgic_irq_lr_map;
 
 	/* Pending interrupts on this VCPU */
 	DECLARE_BITMAP(	pending_percpu, VGIC_NR_PRIVATE_IRQS);
-	DECLARE_BITMAP(	pending_shared, VGIC_NR_SHARED_IRQS);
+	unsigned long	*pending_shared;
 
 	/* Bitmap of used/free list registers */
 	DECLARE_BITMAP(	lr_used, VGIC_V2_MAX_LRS);
@@ -225,7 +233,9 @@ int kvm_vgic_addr(struct kvm *kvm, unsigned long type, u64 *addr, bool write);
 int kvm_vgic_hyp_init(void);
 int kvm_vgic_init(struct kvm *kvm);
 int kvm_vgic_create(struct kvm *kvm);
+void kvm_vgic_destroy(struct kvm *kvm);
 int kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu);
+void kvm_vgic_vcpu_destroy(struct kvm_vcpu *vcpu);
 void kvm_vgic_flush_hwstate(struct kvm_vcpu *vcpu);
 void kvm_vgic_sync_hwstate(struct kvm_vcpu *vcpu);
 int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid, unsigned int irq_num,
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index eebaf54..754d1cd 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -89,6 +89,7 @@ static void vgic_retire_disabled_irqs(struct kvm_vcpu *vcpu);
 static void vgic_retire_lr(int lr_nr, int irq, struct kvm_vcpu *vcpu);
 static void vgic_update_state(struct kvm *kvm);
 static void vgic_kick_vcpus(struct kvm *kvm);
+static u8 *vgic_get_sgi_sources(struct vgic_dist *dist, int vcpu_id, int sgi);
 static void vgic_dispatch_sgi(struct kvm_vcpu *vcpu, u32 reg);
 static struct vgic_lr vgic_get_lr(const struct kvm_vcpu *vcpu, int lr);
 static void vgic_set_lr(struct kvm_vcpu *vcpu, int lr, struct vgic_lr lr_desc);
@@ -118,23 +119,45 @@ static const struct vgic_params *vgic;
 #define REG_OFFSET_SWIZZLE	0
 #endif
 
+static int vgic_init_bitmap(struct vgic_bitmap *b, int nr_cpus, int nr_irqs)
+{
+	int nr_longs;
+
+	nr_longs = nr_cpus + BITS_TO_LONGS(nr_irqs - VGIC_NR_PRIVATE_IRQS);
+
+	b->private = kzalloc(sizeof(unsigned long) * nr_longs, GFP_KERNEL);
+	if (!b->private)
+		return -ENOMEM;
+
+	b->shared = b->private + nr_cpus;
+
+	b->nr_cpus = nr_cpus;
+	return 0;
+}
+
+static void vgic_free_bitmap(struct vgic_bitmap *b)
+{
+	kfree(b->private);
+	b->private = NULL;
+}
+
 static u32 *vgic_bitmap_get_reg(struct vgic_bitmap *x,
 				int cpuid, u32 offset)
 {
 	offset >>= 2;
 	if (!offset)
-		return x->percpu[cpuid].reg + (offset ^ REG_OFFSET_SWIZZLE);
+		return (u32 *)(x->private + cpuid) + REG_OFFSET_SWIZZLE;
 	else
-		return x->shared.reg + ((offset - 1) ^ REG_OFFSET_SWIZZLE);
+		return (u32 *)(x->shared) + ((offset - 1) ^ REG_OFFSET_SWIZZLE);
 }
 
 static int vgic_bitmap_get_irq_val(struct vgic_bitmap *x,
 				   int cpuid, int irq)
 {
 	if (irq < VGIC_NR_PRIVATE_IRQS)
-		return test_bit(irq, x->percpu[cpuid].reg_ul);
+		return test_bit(irq, x->private + cpuid);
 
-	return test_bit(irq - VGIC_NR_PRIVATE_IRQS, x->shared.reg_ul);
+	return test_bit(irq - VGIC_NR_PRIVATE_IRQS, x->shared);
 }
 
 static void vgic_bitmap_set_irq_val(struct vgic_bitmap *x, int cpuid,
@@ -143,9 +166,9 @@ static void vgic_bitmap_set_irq_val(struct vgic_bitmap *x, int cpuid,
 	unsigned long *reg;
 
 	if (irq < VGIC_NR_PRIVATE_IRQS) {
-		reg = x->percpu[cpuid].reg_ul;
+		reg = x->private + cpuid;
 	} else {
-		reg =  x->shared.reg_ul;
+		reg = x->shared;
 		irq -= VGIC_NR_PRIVATE_IRQS;
 	}
 
@@ -157,24 +180,49 @@ static void vgic_bitmap_set_irq_val(struct vgic_bitmap *x, int cpuid,
 
 static unsigned long *vgic_bitmap_get_cpu_map(struct vgic_bitmap *x, int cpuid)
 {
-	if (unlikely(cpuid >= VGIC_MAX_CPUS))
-		return NULL;
-	return x->percpu[cpuid].reg_ul;
+	return x->private + cpuid;
 }
 
 static unsigned long *vgic_bitmap_get_shared_map(struct vgic_bitmap *x)
 {
-	return x->shared.reg_ul;
+	return x->shared;
+}
+
+static int vgic_init_bytemap(struct vgic_bytemap *x, int nr_cpus, int nr_irqs)
+{
+	int size;
+
+	size  = nr_cpus * VGIC_NR_PRIVATE_IRQS;
+	size += nr_irqs - VGIC_NR_PRIVATE_IRQS;
+
+	x->private = kzalloc(size, GFP_KERNEL);
+	if (!x->private)
+		return -ENOMEM;
+
+	x->shared = x->private + nr_cpus * VGIC_NR_PRIVATE_IRQS / sizeof(u32);
+	x->nr_cpus = nr_cpus;
+	return 0;
+}
+
+static void vgic_free_bytemap(struct vgic_bytemap *b)
+{
+	kfree(b->private);
+	b->private = NULL;
 }
 
 static u32 *vgic_bytemap_get_reg(struct vgic_bytemap *x, int cpuid, u32 offset)
 {
-	offset >>= 2;
-	BUG_ON(offset > (VGIC_NR_IRQS / 4));
-	if (offset < 8)
-		return x->percpu[cpuid] + offset;
-	else
-		return x->shared + offset - 8;
+	u32 *reg;
+
+	if (offset < 32) {
+		reg = x->private;
+		offset += cpuid * VGIC_NR_PRIVATE_IRQS;
+	} else {
+		reg = x->shared;
+		offset -= VGIC_NR_PRIVATE_IRQS;
+	}
+
+	return reg + (offset / sizeof(u32));
 }
 
 #define VGIC_CFG_LEVEL	0
@@ -653,7 +701,7 @@ static void vgic_unqueue_irqs(struct kvm_vcpu *vcpu)
 		 */
 		vgic_dist_irq_set(vcpu, lr.irq);
 		if (lr.irq < VGIC_NR_SGIS)
-			dist->irq_sgi_sources[vcpu_id][lr.irq] |= 1 << lr.source;
+			*vgic_get_sgi_sources(dist, vcpu_id, lr.irq) |= 1 << lr.source;
 		lr.state &= ~LR_STATE_PENDING;
 		vgic_set_lr(vcpu, i, lr);
 
@@ -685,7 +733,7 @@ static bool read_set_clear_sgi_pend_reg(struct kvm_vcpu *vcpu,
 	/* Copy source SGIs from distributor side */
 	for (sgi = min_sgi; sgi <= max_sgi; sgi++) {
 		int shift = 8 * (sgi - min_sgi);
-		reg |= (u32)dist->irq_sgi_sources[vcpu_id][sgi] << shift;
+		reg |= ((u32)*vgic_get_sgi_sources(dist, vcpu_id, sgi)) << shift;
 	}
 
 	mmio_data_write(mmio, ~0, reg);
@@ -709,14 +757,15 @@ static bool write_set_clear_sgi_pend_reg(struct kvm_vcpu *vcpu,
 	/* Clear pending SGIs on the distributor */
 	for (sgi = min_sgi; sgi <= max_sgi; sgi++) {
 		u8 mask = reg >> (8 * (sgi - min_sgi));
+		u8 *src = vgic_get_sgi_sources(dist, vcpu_id, sgi);
 		if (set) {
-			if ((dist->irq_sgi_sources[vcpu_id][sgi] & mask) != mask)
+			if ((*src & mask) != mask)
 				updated = true;
-			dist->irq_sgi_sources[vcpu_id][sgi] |= mask;
+			*src |= mask;
 		} else {
-			if (dist->irq_sgi_sources[vcpu_id][sgi] & mask)
+			if (*src & mask)
 				updated = true;
-			dist->irq_sgi_sources[vcpu_id][sgi] &= ~mask;
+			*src &= ~mask;
 		}
 	}
 
@@ -900,6 +949,11 @@ bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
 	return true;
 }
 
+static u8 *vgic_get_sgi_sources(struct vgic_dist *dist, int vcpu_id, int sgi)
+{
+	return dist->irq_sgi_sources + vcpu_id * VGIC_NR_SGIS + sgi;
+}
+
 static void vgic_dispatch_sgi(struct kvm_vcpu *vcpu, u32 reg)
 {
 	struct kvm *kvm = vcpu->kvm;
@@ -933,7 +987,7 @@ static void vgic_dispatch_sgi(struct kvm_vcpu *vcpu, u32 reg)
 		if (target_cpus & 1) {
 			/* Flag the SGI as pending */
 			vgic_dist_irq_set(vcpu, sgi);
-			dist->irq_sgi_sources[c][sgi] |= 1 << vcpu_id;
+			*vgic_get_sgi_sources(dist, c, sgi) |= 1 << vcpu_id;
 			kvm_debug("SGI%d from CPU%d to CPU%d\n", sgi, vcpu_id, c);
 		}
 
@@ -980,14 +1034,14 @@ static void vgic_update_state(struct kvm *kvm)
 	int c;
 
 	if (!dist->enabled) {
-		set_bit(0, &dist->irq_pending_on_cpu);
+		set_bit(0, dist->irq_pending_on_cpu);
 		return;
 	}
 
 	kvm_for_each_vcpu(c, vcpu, kvm) {
 		if (compute_pending_for_cpu(vcpu)) {
 			pr_debug("CPU%d has pending interrupts\n", c);
-			set_bit(c, &dist->irq_pending_on_cpu);
+			set_bit(c, dist->irq_pending_on_cpu);
 		}
 	}
 }
@@ -1144,14 +1198,14 @@ static bool vgic_queue_sgi(struct kvm_vcpu *vcpu, int irq)
 	int vcpu_id = vcpu->vcpu_id;
 	int c;
 
-	sources = dist->irq_sgi_sources[vcpu_id][irq];
+	sources = *vgic_get_sgi_sources(dist, vcpu_id, irq);
 
 	for_each_set_bit(c, &sources, VGIC_MAX_CPUS) {
 		if (vgic_queue_irq(vcpu, c, irq))
 			clear_bit(c, &sources);
 	}
 
-	dist->irq_sgi_sources[vcpu_id][irq] = sources;
+	*vgic_get_sgi_sources(dist, vcpu_id, irq) = sources;
 
 	/*
 	 * If the sources bitmap has been cleared it means that we
@@ -1239,7 +1293,7 @@ epilog:
 		 * us. Claim we don't have anything pending. We'll
 		 * adjust that if needed while exiting.
 		 */
-		clear_bit(vcpu_id, &dist->irq_pending_on_cpu);
+		clear_bit(vcpu_id, dist->irq_pending_on_cpu);
 	}
 }
 
@@ -1322,7 +1376,7 @@ static void __kvm_vgic_sync_hwstate(struct kvm_vcpu *vcpu)
 	/* Check if we still have something up our sleeve... */
 	pending = find_first_zero_bit(elrsr_ptr, vgic->nr_lr);
 	if (level_pending || pending < vgic->nr_lr)
-		set_bit(vcpu->vcpu_id, &dist->irq_pending_on_cpu);
+		set_bit(vcpu->vcpu_id, dist->irq_pending_on_cpu);
 }
 
 void kvm_vgic_flush_hwstate(struct kvm_vcpu *vcpu)
@@ -1356,7 +1410,7 @@ int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu)
 	if (!irqchip_in_kernel(vcpu->kvm))
 		return 0;
 
-	return test_bit(vcpu->vcpu_id, &dist->irq_pending_on_cpu);
+	return test_bit(vcpu->vcpu_id, dist->irq_pending_on_cpu);
 }
 
 static void vgic_kick_vcpus(struct kvm *kvm)
@@ -1440,7 +1494,7 @@ static bool vgic_update_irq_state(struct kvm *kvm, int cpuid,
 
 	if (level) {
 		vgic_cpu_irq_set(vcpu, irq_num);
-		set_bit(cpuid, &dist->irq_pending_on_cpu);
+		set_bit(cpuid, dist->irq_pending_on_cpu);
 	}
 
 out:
@@ -1484,6 +1538,32 @@ static irqreturn_t vgic_maintenance_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+void kvm_vgic_vcpu_destroy(struct kvm_vcpu *vcpu)
+{
+	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
+
+	kfree(vgic_cpu->pending_shared);
+	kfree(vgic_cpu->vgic_irq_lr_map);
+	vgic_cpu->pending_shared = NULL;
+	vgic_cpu->vgic_irq_lr_map = NULL;
+}
+
+static int vgic_vcpu_init_maps(struct kvm_vcpu *vcpu, int nr_irqs)
+{
+	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
+
+	int sz = (nr_irqs - VGIC_NR_PRIVATE_IRQS) / 8;
+	vgic_cpu->pending_shared = kzalloc(sz, GFP_KERNEL);
+	vgic_cpu->vgic_irq_lr_map = kzalloc(nr_irqs, GFP_KERNEL);
+
+	if (!vgic_cpu->pending_shared || !vgic_cpu->vgic_irq_lr_map) {
+		kvm_vgic_vcpu_destroy(vcpu);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
 /**
  * kvm_vgic_vcpu_init - Initialize per-vcpu VGIC state
  * @vcpu: pointer to the vcpu struct
@@ -1600,6 +1680,92 @@ out_free_irq:
 	return ret;
 }
 
+void kvm_vgic_destroy(struct kvm *kvm)
+{
+	struct vgic_dist *dist = &kvm->arch.vgic;
+	struct kvm_vcpu *vcpu;
+	int i;
+
+	kvm_for_each_vcpu(i, vcpu, kvm)
+		kvm_vgic_vcpu_destroy(vcpu);
+
+	vgic_free_bitmap(&dist->irq_enabled);
+	vgic_free_bitmap(&dist->irq_state);
+	vgic_free_bitmap(&dist->irq_active);
+	vgic_free_bitmap(&dist->irq_cfg);
+	vgic_free_bytemap(&dist->irq_priority);
+	if (dist->irq_spi_target)
+		for (i = 0; i < dist->nr_cpus; i++)
+			vgic_free_bitmap(&dist->irq_spi_target[i]);
+	kfree(dist->irq_sgi_sources);
+	kfree(dist->irq_spi_cpu);
+	kfree(dist->irq_spi_target);
+	kfree(dist->irq_pending_on_cpu);
+	dist->irq_sgi_sources = NULL;
+	dist->irq_spi_cpu = NULL;
+	dist->irq_spi_target = NULL;
+	dist->irq_pending_on_cpu = NULL;
+}
+
+/*
+ * Allocate and initialize the various data structures. Must be called
+ * with kvm->lock held!
+ */
+static int vgic_init_maps(struct kvm *kvm)
+{
+	struct vgic_dist *dist = &kvm->arch.vgic;
+	struct kvm_vcpu *vcpu;
+	int nr_cpus, nr_irqs;
+	int ret, i;
+
+	nr_cpus = dist->nr_cpus = VGIC_MAX_CPUS;
+	nr_irqs = dist->nr_irqs = VGIC_NR_IRQS;
+
+	ret  = vgic_init_bitmap(&dist->irq_enabled, nr_cpus, nr_irqs);
+	ret |= vgic_init_bitmap(&dist->irq_state, nr_cpus, nr_irqs);
+	ret |= vgic_init_bitmap(&dist->irq_active, nr_cpus, nr_irqs);
+	ret |= vgic_init_bitmap(&dist->irq_cfg, nr_cpus, nr_irqs);
+	ret |= vgic_init_bytemap(&dist->irq_priority, nr_cpus, nr_irqs);
+
+	if (ret)
+		goto out;
+
+	dist->irq_sgi_sources = kzalloc(nr_cpus * VGIC_NR_SGIS,	GFP_KERNEL);
+	dist->irq_spi_cpu = kzalloc(nr_irqs - VGIC_NR_PRIVATE_IRQS, GFP_KERNEL);
+	dist->irq_spi_target = kzalloc(sizeof(*dist->irq_spi_target) * nr_cpus,
+				       GFP_KERNEL);
+	dist->irq_pending_on_cpu = kzalloc(BITS_TO_LONGS(nr_cpus) * sizeof(unsigned long),
+					   GFP_KERNEL);
+	if (!dist->irq_sgi_sources ||
+	    !dist->irq_spi_cpu ||
+	    !dist->irq_spi_target ||
+	    !dist->irq_pending_on_cpu) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	for (i = 0; i < nr_cpus; i++)
+		ret |= vgic_init_bitmap(&dist->irq_spi_target[i],
+					nr_cpus, nr_irqs);
+
+	if (ret)
+		goto out;
+
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		ret = vgic_vcpu_init_maps(vcpu, nr_irqs);
+		if (ret) {
+			kvm_err("Failed to allocate vcpu memory\n");
+			break;
+		}
+	}
+
+out:
+	if (ret)
+		kvm_vgic_destroy(kvm);
+
+	return ret;
+}
+
 /**
  * kvm_vgic_init - Initialize global VGIC state before running any VCPUs
  * @kvm: pointer to the kvm struct
@@ -1680,6 +1846,10 @@ int kvm_vgic_create(struct kvm *kvm)
 	kvm->arch.vgic.vgic_dist_base = VGIC_ADDR_UNDEF;
 	kvm->arch.vgic.vgic_cpu_base = VGIC_ADDR_UNDEF;
 
+	ret = vgic_init_maps(kvm);
+	if (ret)
+		kvm_err("Unable to allocate maps\n");
+
 out_unlock:
 	for (; vcpu_lock_idx >= 0; vcpu_lock_idx--) {
 		vcpu = kvm_get_vcpu(kvm, vcpu_lock_idx);
-- 
2.0.0
