From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  4 Oct 2013 13:16:14 +0100
Subject: [RFC PATCH 1/5] arm/arm64: KVM: vgic: switch to dynamic allocation
In-Reply-To: <1380888978-27725-1-git-send-email-marc.zyngier@arm.com>
References: <1380888978-27725-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1380888978-27725-2-git-send-email-marc.zyngier@arm.com>
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
 include/kvm/arm_vgic.h |  38 ++++++-----
 virt/kvm/arm/vgic.c    | 180 +++++++++++++++++++++++++++++++++++++++++++------
 3 files changed, 184 insertions(+), 39 deletions(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 9c697db..f0f7a8a 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -178,6 +178,8 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 			kvm->vcpus[i] = NULL;
 		}
 	}
+
+	kvm_vgic_destroy(kvm);
 }
 
 int kvm_dev_ioctl_check_extension(long ext)
@@ -284,6 +286,7 @@ void kvm_arch_vcpu_free(struct kvm_vcpu *vcpu)
 {
 	kvm_mmu_free_memory_caches(vcpu);
 	kvm_timer_vcpu_terminate(vcpu);
+	kvm_vgic_vcpu_destroy(vcpu);
 	kmem_cache_free(kvm_vcpu_cache, vcpu);
 }
 
@@ -786,7 +789,7 @@ long kvm_arch_vm_ioctl(struct file *filp,
 	switch (ioctl) {
 	case KVM_CREATE_IRQCHIP: {
 		if (vgic_present)
-			return kvm_vgic_create(kvm);
+			return kvm_vgic_create(kvm, VGIC_MAX_CPUS, VGIC_NR_IRQS);
 		else
 			return -ENXIO;
 	}
diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index 7e2d158..3cc3a9f 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -53,19 +53,18 @@
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
+	unsigned long *bits;
 };
 
 struct vgic_bytemap {
-	u32 percpu[VGIC_MAX_CPUS][VGIC_NR_PRIVATE_IRQS / 4];
-	u32 shared[VGIC_NR_SHARED_IRQS  / 4];
+	int nr_cpus;
+	u32 *regs;
 };
 
 struct vgic_dist {
@@ -73,6 +72,9 @@ struct vgic_dist {
 	spinlock_t		lock;
 	bool			ready;
 
+	int			nr_cpus;
+	int			nr_irqs;
+
 	/* Virtual control interface mapping */
 	void __iomem		*vctrl_base;
 
@@ -98,12 +100,12 @@ struct vgic_dist {
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
@@ -113,11 +115,11 @@ struct vgic_dist {
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
 	DECLARE_BITMAP(	lr_used, VGIC_MAX_LRS);
@@ -147,8 +149,10 @@ struct kvm_exit_mmio;
 int kvm_vgic_set_addr(struct kvm *kvm, unsigned long type, u64 addr);
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
index 685fc72..f16c848 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -96,34 +96,54 @@ static u32 vgic_nr_lr;
 
 static unsigned int vgic_maint_irq;
 
+static int vgic_init_bitmap(struct vgic_bitmap *b, int nr_cpus, int nr_irqs)
+{
+	int nr_longs;
+
+	nr_longs = nr_cpus + BITS_TO_LONGS(nr_irqs - VGIC_NR_PRIVATE_IRQS);
+
+	b->bits = kzalloc(sizeof(unsigned long) * nr_longs, GFP_KERNEL);
+	if (!b->bits)
+		return -ENOMEM;
+
+	b->nr_cpus = nr_cpus;
+	return 0;
+}
+
+static void vgic_free_bitmap(struct vgic_bitmap *b)
+{
+	kfree(b->bits);
+}
+
 static u32 *vgic_bitmap_get_reg(struct vgic_bitmap *x,
 				int cpuid, u32 offset)
 {
 	offset >>= 2;
 	if (!offset)
-		return x->percpu[cpuid].reg;
+		return (u32 *)(x->bits + cpuid);
 	else
-		return x->shared.reg + offset - 1;
+		return (u32 *)(x->bits + x->nr_cpus) + offset - 1;
 }
 
 static int vgic_bitmap_get_irq_val(struct vgic_bitmap *x,
 				   int cpuid, int irq)
 {
 	if (irq < VGIC_NR_PRIVATE_IRQS)
-		return test_bit(irq, x->percpu[cpuid].reg_ul);
+		return test_bit(irq, x->bits + cpuid);
 
-	return test_bit(irq - VGIC_NR_PRIVATE_IRQS, x->shared.reg_ul);
+	return test_bit(irq - VGIC_NR_PRIVATE_IRQS, x->bits + x->nr_cpus);
 }
 
 static void vgic_bitmap_set_irq_val(struct vgic_bitmap *x, int cpuid,
 				    int irq, int val)
 {
-	unsigned long *reg;
+	unsigned long *reg = x->bits;
 
+	BUG_ON(!reg);
 	if (irq < VGIC_NR_PRIVATE_IRQS) {
-		reg = x->percpu[cpuid].reg_ul;
+		reg += cpuid;
 	} else {
-		reg =  x->shared.reg_ul;
+		reg += x->nr_cpus;
 		irq -= VGIC_NR_PRIVATE_IRQS;
 	}
 
@@ -135,24 +155,42 @@ static void vgic_bitmap_set_irq_val(struct vgic_bitmap *x, int cpuid,
 
 static unsigned long *vgic_bitmap_get_cpu_map(struct vgic_bitmap *x, int cpuid)
 {
-	if (unlikely(cpuid >= VGIC_MAX_CPUS))
-		return NULL;
-	return x->percpu[cpuid].reg_ul;
+	return x->bits + cpuid;
 }
 
 static unsigned long *vgic_bitmap_get_shared_map(struct vgic_bitmap *x)
 {
-	return x->shared.reg_ul;
+	return x->bits + x->nr_cpus;
+}
+
+static int vgic_init_bytemap(struct vgic_bytemap *x, int nr_cpus, int nr_irqs)
+{
+	int size;
+
+	size  = nr_cpus * VGIC_NR_PRIVATE_IRQS;
+	size += nr_irqs - VGIC_NR_PRIVATE_IRQS;
+
+	x->regs = kzalloc(size, GFP_KERNEL);
+	if (!x->regs)
+		return -ENOMEM;
+
+	x->nr_cpus = nr_cpus;
+	return 0;
+}
+
+static void vgic_free_bytemap(struct vgic_bytemap *b)
+{
+	kfree(b->regs);
 }
 
 static u32 *vgic_bytemap_get_reg(struct vgic_bytemap *x, int cpuid, u32 offset)
 {
-	offset >>= 2;
-	BUG_ON(offset > (VGIC_NR_IRQS / 4));
-	if (offset < 8)
-		return x->percpu[cpuid] + offset;
+	if (offset < 32)
+		offset += cpuid * VGIC_NR_PRIVATE_IRQS;
 	else
-		return x->shared + offset - 8;
+		offset += (x->nr_cpus - 1) * VGIC_NR_PRIVATE_IRQS;
+
+	return x->regs + (offset / sizeof(u32));
 }
 
 #define VGIC_CFG_LEVEL	0
@@ -733,6 +771,11 @@ bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
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
@@ -765,7 +808,7 @@ static void vgic_dispatch_sgi(struct kvm_vcpu *vcpu, u32 reg)
 		if (target_cpus & 1) {
 			/* Flag the SGI as pending */
 			vgic_dist_irq_set(vcpu, sgi);
-			dist->irq_sgi_sources[c][sgi] |= 1 << vcpu_id;
+			*vgic_get_sgi_sources(dist, c, sgi) |= 1 << vcpu_id;
 			kvm_debug("SGI%d from CPU%d to CPU%d\n", sgi, vcpu_id, c);
 		}
 
@@ -908,14 +951,14 @@ static bool vgic_queue_sgi(struct kvm_vcpu *vcpu, int irq)
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
@@ -1243,15 +1286,44 @@ static irqreturn_t vgic_maintenance_handler(int irq, void *data)
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
+	vgic_cpu->pending_shared = kzalloc(nr_irqs - VGIC_NR_PRIVATE_IRQS,
+					   GFP_KERNEL);
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
 int kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu)
 {
 	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
 	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
-	int i;
+	int i, ret;
 
 	if (!irqchip_in_kernel(vcpu->kvm))
 		return 0;
 
+	ret = vgic_vcpu_init_maps(vgic_cpu, dist->nr_irqs);
+	if (ret)
+		return ret;
+
 	if (vcpu->vcpu_id >= VGIC_MAX_CPUS)
 		return -EBUSY;
 
@@ -1383,6 +1455,68 @@ out:
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
+	int ret = 0, i;
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
 int kvm_vgic_init(struct kvm *kvm)
 {
 	int ret = 0, i;
@@ -1416,7 +1550,7 @@ out:
 	return ret;
 }
 
-int kvm_vgic_create(struct kvm *kvm)
+int kvm_vgic_create(struct kvm *kvm, int nr_cpus, int nr_irqs)
 {
 	int ret = 0;
 
@@ -1432,6 +1566,10 @@ int kvm_vgic_create(struct kvm *kvm)
 	kvm->arch.vgic.vgic_dist_base = VGIC_ADDR_UNDEF;
 	kvm->arch.vgic.vgic_cpu_base = VGIC_ADDR_UNDEF;
 
+	ret = vgic_init_maps(&kvm->arch.vgic, nr_cpus, nr_irqs);
+	if (ret)
+		kvm_err("Unable to allocate maps\n");
+
 out:
 	mutex_unlock(&kvm->lock);
 	return ret;
-- 
1.8.2.3
