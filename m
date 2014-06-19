From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 19 Jun 2014 10:21:31 +0100
Subject: [PATCH v2 7/9] arm/arm64: KVM: vgic: delay vgic allocation until init
 time
In-Reply-To: <1403169693-13982-1-git-send-email-marc.zyngier@arm.com>
References: <1403169693-13982-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1403169693-13982-8-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is now quite easy to delay the allocation of the vgic tables
until we actually require it to be up and running (when the first
starting to kick around).

This allow us to allocate memory for the exact number of CPUs we
have. As nobody configures the number of interrupts just yet,
use a fallback to VGIC_NR_IRQS_LEGACY.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/arm.c     |  9 +-------
 include/kvm/arm_vgic.h |  3 +--
 virt/kvm/arm/vgic.c    | 56 ++++++++++++++++++++++++++++++++++----------------
 3 files changed, 40 insertions(+), 28 deletions(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 66c14ef..9b3957d 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -308,16 +308,9 @@ int kvm_cpu_has_pending_timer(struct kvm_vcpu *vcpu)
 
 int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
 {
-	int ret;
-
 	/* Force users to call KVM_ARM_VCPU_INIT */
 	vcpu->arch.target = -1;
 
-	/* Set up VGIC */
-	ret = kvm_vgic_vcpu_init(vcpu);
-	if (ret)
-		return ret;
-
 	/* Set up the timer */
 	kvm_timer_vcpu_init(vcpu);
 
@@ -811,7 +804,7 @@ long kvm_arch_vm_ioctl(struct file *filp,
 	switch (ioctl) {
 	case KVM_CREATE_IRQCHIP: {
 		if (vgic_present)
-			return kvm_vgic_create(kvm, KVM_MAX_VCPUS, VGIC_NR_IRQS_LEGACY);
+			return kvm_vgic_create(kvm);
 		else
 			return -ENXIO;
 	}
diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index cf17b68..f5788cf 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -231,9 +231,8 @@ struct kvm_exit_mmio;
 int kvm_vgic_addr(struct kvm *kvm, unsigned long type, u64 *addr, bool write);
 int kvm_vgic_hyp_init(void);
 int kvm_vgic_init(struct kvm *kvm);
-int kvm_vgic_create(struct kvm *kvm, int nr_cpus, int nr_irqs);
+int kvm_vgic_create(struct kvm *kvm);
 void kvm_vgic_destroy(struct kvm *kvm);
-int kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu);
 void kvm_vgic_vcpu_destroy(struct kvm_vcpu *vcpu);
 void kvm_vgic_flush_hwstate(struct kvm_vcpu *vcpu);
 void kvm_vgic_sync_hwstate(struct kvm_vcpu *vcpu);
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 17ceb8a..6e13ff9 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1589,7 +1589,7 @@ void kvm_vgic_vcpu_destroy(struct kvm_vcpu *vcpu)
  * Initialize the vgic_cpu struct and vgic_dist struct fields pertaining to
  * this vcpu and enable the VGIC for this VCPU
  */
-int kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu)
+static int kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu)
 {
 	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
 	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
@@ -1599,9 +1599,6 @@ int kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu)
 	if (ret)
 		return ret;
 
-	if (vcpu->vcpu_id >= dist->nr_cpus)
-		return -EBUSY;
-
 	for (i = 0; i < dist->nr_irqs; i++) {
 		if (i < VGIC_NR_PPIS)
 			vgic_bitmap_set_irq_val(&dist->irq_enabled,
@@ -1723,9 +1720,6 @@ static int vgic_init_maps(struct vgic_dist *dist, int nr_cpus, int nr_irqs)
 {
 	int ret, i;
 
-	dist->nr_cpus = nr_cpus;
-	dist->nr_irqs = nr_irqs;
-
 	ret  = vgic_init_bitmap(&dist->irq_enabled, nr_cpus, nr_irqs);
 	ret |= vgic_init_bitmap(&dist->irq_state, nr_cpus, nr_irqs);
 	ret |= vgic_init_bitmap(&dist->irq_active, nr_cpus, nr_irqs);
@@ -1775,7 +1769,9 @@ void kvm_vgic_destroy(struct kvm *kvm)
  */
 int kvm_vgic_init(struct kvm *kvm)
 {
-	int ret = 0, i;
+	struct vgic_dist *dist = &kvm->arch.vgic;
+	struct kvm_vcpu *vcpu;
+	int ret = 0, i, v;
 
 	if (!irqchip_in_kernel(kvm))
 		return 0;
@@ -1785,30 +1781,58 @@ int kvm_vgic_init(struct kvm *kvm)
 	if (vgic_initialized(kvm))
 		goto out;
 
-	if (IS_VGIC_ADDR_UNDEF(kvm->arch.vgic.vgic_dist_base) ||
-	    IS_VGIC_ADDR_UNDEF(kvm->arch.vgic.vgic_cpu_base)) {
+	dist->nr_cpus = atomic_read(&kvm->online_vcpus);
+
+	/*
+	 * If nobody configured the number of interrupts, use the
+	 * legacy one.
+	 */
+	if (!dist->nr_irqs)
+		dist->nr_irqs = VGIC_NR_IRQS_LEGACY;
+
+	if (IS_VGIC_ADDR_UNDEF(dist->vgic_dist_base) ||
+	    IS_VGIC_ADDR_UNDEF(dist->vgic_cpu_base)) {
 		kvm_err("Need to set vgic cpu and dist addresses first\n");
 		ret = -ENXIO;
 		goto out;
 	}
 
-	ret = kvm_phys_addr_ioremap(kvm, kvm->arch.vgic.vgic_cpu_base,
+	ret = vgic_init_maps(dist, dist->nr_cpus, dist->nr_irqs);
+	if (ret) {
+		kvm_err("Unable to allocate maps\n");
+		goto out;
+	}
+
+	ret = kvm_phys_addr_ioremap(kvm, dist->vgic_cpu_base,
 				    vgic->vcpu_base, KVM_VGIC_V2_CPU_SIZE);
 	if (ret) {
 		kvm_err("Unable to remap VGIC CPU to VCPU\n");
 		goto out;
 	}
 
-	for (i = VGIC_NR_PRIVATE_IRQS; i < kvm->arch.vgic.nr_irqs; i += 4)
+	for (i = VGIC_NR_PRIVATE_IRQS; i < dist->nr_irqs; i += 4)
 		vgic_set_target_reg(kvm, 0, i);
 
+	kvm_for_each_vcpu(v, vcpu, kvm) {
+		ret = kvm_vgic_vcpu_init(vcpu);
+		if (ret) {
+			kvm_err("Failed to allocate vcpu memory\n");
+			break;
+		}
+	}
+
 	kvm->arch.vgic.ready = true;
 out:
+	if (ret) {
+		kvm_for_each_vcpu(v, vcpu, kvm)
+			kvm_vgic_vcpu_destroy(vcpu);
+		vgic_free_maps(dist);
+	}
 	mutex_unlock(&kvm->lock);
 	return ret;
 }
 
-int kvm_vgic_create(struct kvm *kvm, int nr_cpus, int nr_irqs)
+int kvm_vgic_create(struct kvm *kvm)
 {
 	int i, vcpu_lock_idx = -1, ret = 0;
 	struct kvm_vcpu *vcpu;
@@ -1844,10 +1868,6 @@ int kvm_vgic_create(struct kvm *kvm, int nr_cpus, int nr_irqs)
 	kvm->arch.vgic.vgic_dist_base = VGIC_ADDR_UNDEF;
 	kvm->arch.vgic.vgic_cpu_base = VGIC_ADDR_UNDEF;
 
-	ret = vgic_init_maps(&kvm->arch.vgic, nr_cpus, nr_irqs);
-	if (ret)
-		kvm_err("Unable to allocate maps\n");
-
 out_unlock:
 	for (; vcpu_lock_idx >= 0; vcpu_lock_idx--) {
 		vcpu = kvm_get_vcpu(kvm, vcpu_lock_idx);
@@ -2228,7 +2248,7 @@ static void vgic_destroy(struct kvm_device *dev)
 
 static int vgic_create(struct kvm_device *dev, u32 type)
 {
-	return kvm_vgic_create(dev->kvm, KVM_MAX_VCPUS, VGIC_NR_IRQS_LEGACY);
+	return kvm_vgic_create(dev->kvm);
 }
 
 struct kvm_device_ops kvm_arm_vgic_v2_ops = {
-- 
1.8.3.4
