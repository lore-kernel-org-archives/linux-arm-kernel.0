From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 23 Jan 2015 11:02:48 +0100
Subject: [GIT PULL 19/36] arm/arm64: KVM: introduce per-VM ops
In-Reply-To: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
References: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1422007385-14730-20-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andre Przywara <andre.przywara@arm.com>

Currently we only have one virtual GIC model supported, so all guests
use the same emulation code. With the addition of another model we
end up with different guests using potentially different vGIC models,
so we have to split up some functions to be per VM.
Introduce a vgic_vm_ops struct to hold function pointers for those
functions that are different and provide the necessary code to
initialize them.
Also split up the vgic_init() function to separate out VGIC model
specific functionality into a separate function, which will later be
different for a GICv3 model.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 include/kvm/arm_vgic.h | 11 +++++++
 virt/kvm/arm/vgic.c    | 86 ++++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 87 insertions(+), 10 deletions(-)

diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index 525ce42..dd24396 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -134,6 +134,15 @@ struct vgic_params {
 	void __iomem	*vctrl_base;
 };
 
+struct vgic_vm_ops {
+	bool	(*handle_mmio)(struct kvm_vcpu *, struct kvm_run *,
+			       struct kvm_exit_mmio *);
+	bool	(*queue_sgi)(struct kvm_vcpu *, int irq);
+	void	(*add_sgi_source)(struct kvm_vcpu *, int irq, int source);
+	int	(*init_model)(struct kvm *);
+	int	(*map_resources)(struct kvm *, const struct vgic_params *);
+};
+
 struct vgic_dist {
 #ifdef CONFIG_KVM_ARM_VGIC
 	spinlock_t		lock;
@@ -215,6 +224,8 @@ struct vgic_dist {
 
 	/* Bitmap indicating which CPU has something pending */
 	unsigned long		*irq_pending_on_cpu;
+
+	struct vgic_vm_ops	vm_ops;
 #endif
 };
 
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index a1fda79..9b63141 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -106,6 +106,21 @@ static void vgic_set_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcr);
 static const struct vgic_ops *vgic_ops;
 static const struct vgic_params *vgic;
 
+static void add_sgi_source(struct kvm_vcpu *vcpu, int irq, int source)
+{
+	vcpu->kvm->arch.vgic.vm_ops.add_sgi_source(vcpu, irq, source);
+}
+
+static bool queue_sgi(struct kvm_vcpu *vcpu, int irq)
+{
+	return vcpu->kvm->arch.vgic.vm_ops.queue_sgi(vcpu, irq);
+}
+
+int kvm_vgic_map_resources(struct kvm *kvm)
+{
+	return kvm->arch.vgic.vm_ops.map_resources(kvm, vgic);
+}
+
 /*
  * struct vgic_bitmap contains a bitmap made of unsigned longs, but
  * extracts u32s out of them.
@@ -762,6 +777,13 @@ static bool handle_mmio_sgi_reg(struct kvm_vcpu *vcpu,
 	return false;
 }
 
+static void vgic_v2_add_sgi_source(struct kvm_vcpu *vcpu, int irq, int source)
+{
+	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
+
+	*vgic_get_sgi_sources(dist, vcpu->vcpu_id, irq) |= 1 << source;
+}
+
 /**
  * vgic_unqueue_irqs - move pending IRQs from LRs to the distributor
  * @vgic_cpu: Pointer to the vgic_cpu struct holding the LRs
@@ -776,9 +798,7 @@ static bool handle_mmio_sgi_reg(struct kvm_vcpu *vcpu,
  */
 static void vgic_unqueue_irqs(struct kvm_vcpu *vcpu)
 {
-	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
 	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
-	int vcpu_id = vcpu->vcpu_id;
 	int i;
 
 	for_each_set_bit(i, vgic_cpu->lr_used, vgic_cpu->nr_lr) {
@@ -805,7 +825,7 @@ static void vgic_unqueue_irqs(struct kvm_vcpu *vcpu)
 		 */
 		vgic_dist_irq_set_pending(vcpu, lr.irq);
 		if (lr.irq < VGIC_NR_SGIS)
-			*vgic_get_sgi_sources(dist, vcpu_id, lr.irq) |= 1 << lr.source;
+			add_sgi_source(vcpu, lr.irq, lr.source);
 		lr.state &= ~LR_STATE_PENDING;
 		vgic_set_lr(vcpu, i, lr);
 
@@ -1159,6 +1179,7 @@ static bool vgic_v2_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
  *
  * returns true if the MMIO access has been performed in kernel space,
  * and false if it needs to be emulated in user space.
+ * Calls the actual handling routine for the selected VGIC model.
  */
 bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		      struct kvm_exit_mmio *mmio)
@@ -1166,7 +1187,12 @@ bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
 	if (!irqchip_in_kernel(vcpu->kvm))
 		return false;
 
-	return vgic_v2_handle_mmio(vcpu, run, mmio);
+	/*
+	 * This will currently call either vgic_v2_handle_mmio() or
+	 * vgic_v3_handle_mmio(), which in turn will call
+	 * vgic_handle_mmio_range() defined above.
+	 */
+	return vcpu->kvm->arch.vgic.vm_ops.handle_mmio(vcpu, run, mmio);
 }
 
 static u8 *vgic_get_sgi_sources(struct vgic_dist *dist, int vcpu_id, int sgi)
@@ -1418,7 +1444,7 @@ static bool vgic_queue_irq(struct kvm_vcpu *vcpu, u8 sgi_source_id, int irq)
 	return true;
 }
 
-static bool vgic_queue_sgi(struct kvm_vcpu *vcpu, int irq)
+static bool vgic_v2_queue_sgi(struct kvm_vcpu *vcpu, int irq)
 {
 	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
 	unsigned long sources;
@@ -1493,7 +1519,7 @@ static void __kvm_vgic_flush_hwstate(struct kvm_vcpu *vcpu)
 
 	/* SGIs */
 	for_each_set_bit(i, vgic_cpu->pending_percpu, VGIC_NR_SGIS) {
-		if (!vgic_queue_sgi(vcpu, i))
+		if (!queue_sgi(vcpu, i))
 			overflow = 1;
 	}
 
@@ -1883,6 +1909,16 @@ void kvm_vgic_destroy(struct kvm *kvm)
 	dist->nr_cpus = 0;
 }
 
+static int vgic_v2_init_model(struct kvm *kvm)
+{
+	int i;
+
+	for (i = VGIC_NR_PRIVATE_IRQS; i < kvm->arch.vgic.nr_irqs; i += 4)
+		vgic_set_target_reg(kvm, 0, i);
+
+	return 0;
+}
+
 /*
  * Allocate and initialize the various data structures. Must be called
  * with kvm->lock held!
@@ -1942,8 +1978,9 @@ static int vgic_init(struct kvm *kvm)
 	if (ret)
 		goto out;
 
-	for (i = VGIC_NR_PRIVATE_IRQS; i < dist->nr_irqs; i += 4)
-		vgic_set_target_reg(kvm, 0, i);
+	ret = kvm->arch.vgic.vm_ops.init_model(kvm);
+	if (ret)
+		goto out;
 
 	kvm_for_each_vcpu(vcpu_id, vcpu, kvm) {
 		ret = vgic_vcpu_init_maps(vcpu, nr_irqs);
@@ -1980,7 +2017,8 @@ out:
  * can't do this at creation time, because user space must first set the
  * virtual CPU interface address in the guest physical address space.
  */
-int kvm_vgic_map_resources(struct kvm *kvm)
+static int vgic_v2_map_resources(struct kvm *kvm,
+				 const struct vgic_params *params)
 {
 	int ret = 0;
 
@@ -2010,7 +2048,7 @@ int kvm_vgic_map_resources(struct kvm *kvm)
 	}
 
 	ret = kvm_phys_addr_ioremap(kvm, kvm->arch.vgic.vgic_cpu_base,
-				    vgic->vcpu_base, KVM_VGIC_V2_CPU_SIZE,
+				    params->vcpu_base, KVM_VGIC_V2_CPU_SIZE,
 				    true);
 	if (ret) {
 		kvm_err("Unable to remap VGIC CPU to VCPU\n");
@@ -2025,6 +2063,30 @@ out:
 	return ret;
 }
 
+static void vgic_v2_init_emulation(struct kvm *kvm)
+{
+	struct vgic_dist *dist = &kvm->arch.vgic;
+
+	dist->vm_ops.handle_mmio = vgic_v2_handle_mmio;
+	dist->vm_ops.queue_sgi = vgic_v2_queue_sgi;
+	dist->vm_ops.add_sgi_source = vgic_v2_add_sgi_source;
+	dist->vm_ops.init_model = vgic_v2_init_model;
+	dist->vm_ops.map_resources = vgic_v2_map_resources;
+}
+
+static int init_vgic_model(struct kvm *kvm, int type)
+{
+	switch (type) {
+	case KVM_DEV_TYPE_ARM_VGIC_V2:
+		vgic_v2_init_emulation(kvm);
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
 int kvm_vgic_create(struct kvm *kvm, u32 type)
 {
 	int i, vcpu_lock_idx = -1, ret;
@@ -2055,6 +2117,10 @@ int kvm_vgic_create(struct kvm *kvm, u32 type)
 	}
 	ret = 0;
 
+	ret = init_vgic_model(kvm, type);
+	if (ret)
+		goto out_unlock;
+
 	spin_lock_init(&kvm->arch.vgic.lock);
 	kvm->arch.vgic.in_kernel = true;
 	kvm->arch.vgic.vgic_model = type;
-- 
2.1.2.330.g565301e.dirty
