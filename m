From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 19 Jun 2014 10:21:26 +0100
Subject: [PATCH v2 2/9] arm/arm64: KVM: vgic: switch to dynamic allocation
In-Reply-To: <1403169693-13982-1-git-send-email-marc.zyngier@arm.com>
References: <1403169693-13982-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1403169693-13982-3-git-send-email-marc.zyngier@arm.com>
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
 arch/arm/kvm/arm.c     |   5 +-
 include/kvm/arm_vgic.h |  44 ++++++-----
 virt/kvm/arm/vgic.c    | 203 ++++++++++++++++++++++++++++++++++++++++++-------
 3 files changed, 206 insertions(+), 46 deletions(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 3c82b37..9548bc9 100644
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
 
@@ -808,7 +811,7 @@ long kvm_arch_vm_ioctl(struct file *filp,
 	switch (ioctl) {
 	case KVM_CREATE_IRQCHIP: {
 		if (vgic_present)
-			return kvm_vgic_create(kvm);
+			return kvm_vgic_create(kvm, VGIC_MAX_CPUS, VGIC_NR_IRQS);
 		else
 			return -ENXIO;
 	}
diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index 35b0c12..c57ffd0 100644
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
 
@@ -152,12 +160,12 @@ struct vgic_dist {
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
 	unsigned long		irq_pending_on_cpu;
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
@@ -224,8 +232,10 @@ struct kvm_exit_mmio;
 int kvm_vgic_addr(struct kvm *kvm, unsigned long type, u64 *addr, bool write);
 int kvm_vgic_hyp_init(void);
 int kvm_vgic_init(struct kvm *kvm);
-int kvm_vgic_create(struct kvm *kvm);
+int kvm_vgic_create(struct kvm *kvm, int nr_cpus, int nr_irqs);
+void kvm_vgic_destroy(struct kvm *kvm);
 int kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu);
+void kvm_vgic_vcpu_destroy(struct kvm_vcpu *vcpu);
 void kvm_vgic_flush_hwstate(struct kvm_vcpu *vcpu);
 void kvm_vgic_sync_hwstate(struct kvm_vcpu *vcpu);
 int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid, unsigned int irq_num,
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index c6da748..220b215 100644
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
@@ -98,23 +99,44 @@ static void vgic_set_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcr);
 static const struct vgic_ops *vgic_ops;
 static const struct vgic_params *vgic;
 
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
+}
+
 static u32 *vgic_bitmap_get_reg(struct vgic_bitmap *x,
 				int cpuid, u32 offset)
 {
 	offset >>= 2;
 	if (!offset)
-		return x->percpu[cpuid].reg;
+		return (u32 *)(x->private + cpuid);
 	else
-		return x->shared.reg + offset - 1;
+		return (u32 *)(x->shared) + offset - 1;
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
@@ -123,9 +145,9 @@ static void vgic_bitmap_set_irq_val(struct vgic_bitmap *x, int cpuid,
 	unsigned long *reg;
 
 	if (irq < VGIC_NR_PRIVATE_IRQS) {
-		reg = x->percpu[cpuid].reg_ul;
+		reg = x->private + cpuid;
 	} else {
-		reg =  x->shared.reg_ul;
+		reg = x->shared;
 		irq -= VGIC_NR_PRIVATE_IRQS;
 	}
 
@@ -137,24 +159,48 @@ static void vgic_bitmap_set_irq_val(struct vgic_bitmap *x, int cpuid,
 
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
@@ -633,7 +679,7 @@ static void vgic_unqueue_irqs(struct kvm_vcpu *vcpu)
 		 */
 		vgic_dist_irq_set(vcpu, lr.irq);
 		if (lr.irq < VGIC_NR_SGIS)
-			dist->irq_sgi_sources[vcpu_id][lr.irq] |= 1 << lr.source;
+			*vgic_get_sgi_sources(dist, vcpu_id, lr.irq) |= 1 << lr.source;
 		lr.state &= ~LR_STATE_PENDING;
 		vgic_set_lr(vcpu, i, lr);
 
@@ -665,7 +711,7 @@ static bool read_set_clear_sgi_pend_reg(struct kvm_vcpu *vcpu,
 	/* Copy source SGIs from distributor side */
 	for (sgi = min_sgi; sgi <= max_sgi; sgi++) {
 		int shift = 8 * (sgi - min_sgi);
-		reg |= (u32)dist->irq_sgi_sources[vcpu_id][sgi] << shift;
+		reg |= ((u32)*vgic_get_sgi_sources(dist, vcpu_id, sgi)) << shift;
 	}
 
 	mmio_data_write(mmio, ~0, reg);
@@ -689,14 +735,15 @@ static bool write_set_clear_sgi_pend_reg(struct kvm_vcpu *vcpu,
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
 
@@ -880,6 +927,11 @@ bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
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
@@ -913,7 +965,7 @@ static void vgic_dispatch_sgi(struct kvm_vcpu *vcpu, u32 reg)
 		if (target_cpus & 1) {
 			/* Flag the SGI as pending */
 			vgic_dist_irq_set(vcpu, sgi);
-			dist->irq_sgi_sources[c][sgi] |= 1 << vcpu_id;
+			*vgic_get_sgi_sources(dist, c, sgi) |= 1 << vcpu_id;
 			kvm_debug("SGI%d from CPU%d to CPU%d\n", sgi, vcpu_id, c);
 		}
 
@@ -1124,14 +1176,14 @@ static bool vgic_queue_sgi(struct kvm_vcpu *vcpu, int irq)
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
@@ -1464,6 +1516,31 @@ static irqreturn_t vgic_maintenance_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static void vgic_vcpu_free_maps(struct vgic_cpu *vgic_cpu)
+{
+	kfree(vgic_cpu->pending_shared);
+	kfree(vgic_cpu->vgic_irq_lr_map);
+}
+
+static int vgic_vcpu_init_maps(struct vgic_cpu *vgic_cpu, int nr_irqs)
+{
+	int sz = (nr_irqs - VGIC_NR_PRIVATE_IRQS) / 8;
+	vgic_cpu->pending_shared = kzalloc(sz, GFP_KERNEL);
+	vgic_cpu->vgic_irq_lr_map = kzalloc(nr_irqs, GFP_KERNEL);
+
+	if (!vgic_cpu->pending_shared || !vgic_cpu->vgic_irq_lr_map) {
+		vgic_vcpu_free_maps(vgic_cpu);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+void kvm_vgic_vcpu_destroy(struct kvm_vcpu *vcpu)
+{
+	vgic_vcpu_free_maps(&vcpu->arch.vgic_cpu);
+}
+
 /**
  * kvm_vgic_vcpu_init - Initialize per-vcpu VGIC state
  * @vcpu: pointer to the vcpu struct
@@ -1475,7 +1552,11 @@ int kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu)
 {
 	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
 	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
-	int i;
+	int i, ret;
+
+	ret = vgic_vcpu_init_maps(vgic_cpu, dist->nr_irqs);
+	if (ret)
+		return ret;
 
 	if (vcpu->vcpu_id >= VGIC_MAX_CPUS)
 		return -EBUSY;
@@ -1580,6 +1661,68 @@ out_free_irq:
 	return ret;
 }
 
+static void vgic_free_maps(struct vgic_dist *dist)
+{
+	int i;
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
+}
+
+static int vgic_init_maps(struct vgic_dist *dist, int nr_cpus, int nr_irqs)
+{
+	int ret, i;
+
+	dist->nr_cpus = nr_cpus;
+	dist->nr_irqs = nr_irqs;
+
+	ret  = vgic_init_bitmap(&dist->irq_enabled, nr_cpus, nr_irqs);
+	ret |= vgic_init_bitmap(&dist->irq_state, nr_cpus, nr_irqs);
+	ret |= vgic_init_bitmap(&dist->irq_active, nr_cpus, nr_irqs);
+	ret |= vgic_init_bitmap(&dist->irq_cfg, nr_cpus, nr_irqs);
+	ret |= vgic_init_bytemap(&dist->irq_priority, nr_cpus, nr_irqs);
+
+	if (!ret) {
+		dist->irq_sgi_sources = kzalloc(nr_cpus * VGIC_NR_SGIS,
+						GFP_KERNEL);
+		dist->irq_spi_cpu = kzalloc(nr_irqs - VGIC_NR_PRIVATE_IRQS,
+					    GFP_KERNEL);
+		dist->irq_spi_target = kzalloc(sizeof(*dist->irq_spi_target) * nr_cpus,
+					       GFP_KERNEL);
+		if (!dist->irq_sgi_sources ||
+		    !dist->irq_spi_cpu ||
+		    !dist->irq_spi_target) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		for (i = 0; i < nr_cpus; i++)
+			ret |= vgic_init_bitmap(&dist->irq_spi_target[i],
+						nr_cpus, nr_irqs);
+
+	}
+
+out:
+	if (ret)
+		vgic_free_maps(dist);
+
+	return ret;
+}
+
+void kvm_vgic_destroy(struct kvm *kvm)
+{
+	vgic_free_maps(&kvm->arch.vgic);
+}
+
 /**
  * kvm_vgic_init - Initialize global VGIC state before running any VCPUs
  * @kvm: pointer to the kvm struct
@@ -1624,7 +1767,7 @@ out:
 	return ret;
 }
 
-int kvm_vgic_create(struct kvm *kvm)
+int kvm_vgic_create(struct kvm *kvm, int nr_cpus, int nr_irqs)
 {
 	int i, vcpu_lock_idx = -1, ret = 0;
 	struct kvm_vcpu *vcpu;
@@ -1660,6 +1803,10 @@ int kvm_vgic_create(struct kvm *kvm)
 	kvm->arch.vgic.vgic_dist_base = VGIC_ADDR_UNDEF;
 	kvm->arch.vgic.vgic_cpu_base = VGIC_ADDR_UNDEF;
 
+	ret = vgic_init_maps(&kvm->arch.vgic, nr_cpus, nr_irqs);
+	if (ret)
+		kvm_err("Unable to allocate maps\n");
+
 out_unlock:
 	for (; vcpu_lock_idx >= 0; vcpu_lock_idx--) {
 		vcpu = kvm_get_vcpu(kvm, vcpu_lock_idx);
@@ -2040,7 +2187,7 @@ static void vgic_destroy(struct kvm_device *dev)
 
 static int vgic_create(struct kvm_device *dev, u32 type)
 {
-	return kvm_vgic_create(dev->kvm);
+	return kvm_vgic_create(dev->kvm, VGIC_MAX_CPUS, VGIC_NR_IRQS);
 }
 
 struct kvm_device_ops kvm_arm_vgic_v2_ops = {
-- 
1.8.3.4
