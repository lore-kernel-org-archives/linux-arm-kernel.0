From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Tue, 08 Jan 2013 13:42:24 -0500
Subject: [PATCH v5 09/12] ARM: KVM: VGIC interrupt injection
In-Reply-To: <20130108184116.46558.3558.stgit@ubuntu>
References: <20130108184116.46558.3558.stgit@ubuntu>
Message-ID: <20130108184224.46558.45178.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

Plug the interrupt injection code. Interrupts can now be generated
from user space.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 arch/arm/include/asm/kvm_vgic.h |    8 +++
 arch/arm/kvm/arm.c              |   55 +++++++++++++++---
 arch/arm/kvm/vgic.c             |  117 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 170 insertions(+), 10 deletions(-)

diff --git a/arch/arm/include/asm/kvm_vgic.h b/arch/arm/include/asm/kvm_vgic.h
index b3133c4..9ff0e52 100644
--- a/arch/arm/include/asm/kvm_vgic.h
+++ b/arch/arm/include/asm/kvm_vgic.h
@@ -146,6 +146,8 @@ struct kvm_exit_mmio;
 int kvm_vgic_set_addr(struct kvm *kvm, unsigned long type, u64 addr);
 void kvm_vgic_sync_to_cpu(struct kvm_vcpu *vcpu);
 void kvm_vgic_sync_from_cpu(struct kvm_vcpu *vcpu);
+int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid, unsigned int irq_num,
+			bool level);
 int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu);
 bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		      struct kvm_exit_mmio *mmio);
@@ -181,6 +183,12 @@ static inline int kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu)
 static inline void kvm_vgic_sync_to_cpu(struct kvm_vcpu *vcpu) {}
 static inline void kvm_vgic_sync_from_cpu(struct kvm_vcpu *vcpu) {}
 
+static inline int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid,
+				      unsigned int irq_num, bool level)
+{
+	return 0;
+}
+
 static inline int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu)
 {
 	return 0;
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 4c2b057..8dd949c 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -788,20 +788,49 @@ int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irq_level)
 
 	trace_kvm_irq_line(irq_type, vcpu_idx, irq_num, irq_level->level);
 
-	if (irq_type != KVM_ARM_IRQ_TYPE_CPU)
-		return -EINVAL;
+	switch (irq_type) {
+	case KVM_ARM_IRQ_TYPE_CPU:
+		if (irqchip_in_kernel(kvm))
+			return -ENXIO;
 
-	if (vcpu_idx >= nrcpus)
-		return -EINVAL;
+		if (vcpu_idx >= nrcpus)
+			return -EINVAL;
 
-	vcpu = kvm_get_vcpu(kvm, vcpu_idx);
-	if (!vcpu)
-		return -EINVAL;
+		vcpu = kvm_get_vcpu(kvm, vcpu_idx);
+		if (!vcpu)
+			return -EINVAL;
 
-	if (irq_num > KVM_ARM_IRQ_CPU_FIQ)
-		return -EINVAL;
+		if (irq_num > KVM_ARM_IRQ_CPU_FIQ)
+			return -EINVAL;
+
+		return vcpu_interrupt_line(vcpu, irq_num, level);
+	case KVM_ARM_IRQ_TYPE_PPI:
+		if (!irqchip_in_kernel(kvm))
+			return -ENXIO;
+
+		if (vcpu_idx >= nrcpus)
+			return -EINVAL;
+
+		vcpu = kvm_get_vcpu(kvm, vcpu_idx);
+		if (!vcpu)
+			return -EINVAL;
+
+		if (irq_num < VGIC_NR_SGIS || irq_num >= VGIC_NR_PRIVATE_IRQS)
+			return -EINVAL;
 
-	return vcpu_interrupt_line(vcpu, irq_num, level);
+		return kvm_vgic_inject_irq(kvm, vcpu->vcpu_id, irq_num, level);
+	case KVM_ARM_IRQ_TYPE_SPI:
+		if (!irqchip_in_kernel(kvm))
+			return -ENXIO;
+
+		if (irq_num < VGIC_NR_PRIVATE_IRQS ||
+		    irq_num > KVM_ARM_IRQ_GIC_MAX)
+			return -EINVAL;
+
+		return kvm_vgic_inject_irq(kvm, 0, irq_num, level);
+	}
+
+	return -EINVAL;
 }
 
 long kvm_arch_vcpu_ioctl(struct file *filp,
@@ -880,6 +909,12 @@ long kvm_arch_vm_ioctl(struct file *filp,
 	void __user *argp = (void __user *)arg;
 
 	switch (ioctl) {
+	case KVM_CREATE_IRQCHIP: {
+		if (vgic_present)
+			return kvm_vgic_create(kvm);
+		else
+			return -ENXIO;
+	}
 	case KVM_SET_DEVICE_ADDRESS: {
 		struct kvm_device_address dev_addr;
 
diff --git a/arch/arm/kvm/vgic.c b/arch/arm/kvm/vgic.c
index 49e8b27..65e5282 100644
--- a/arch/arm/kvm/vgic.c
+++ b/arch/arm/kvm/vgic.c
@@ -73,6 +73,7 @@
 
 static void vgic_retire_disabled_irqs(struct kvm_vcpu *vcpu);
 static void vgic_update_state(struct kvm *kvm);
+static void vgic_kick_vcpus(struct kvm *kvm);
 static void vgic_dispatch_sgi(struct kvm_vcpu *vcpu, u32 reg);
 
 static u32 *vgic_bitmap_get_reg(struct vgic_bitmap *x,
@@ -696,6 +697,9 @@ bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
 	kvm_prepare_mmio(run, mmio);
 	kvm_handle_mmio_return(vcpu, run);
 
+	if (updated_state)
+		vgic_kick_vcpus(vcpu->kvm);
+
 	return true;
 }
 
@@ -1092,6 +1096,119 @@ int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu)
 	return test_bit(vcpu->vcpu_id, &dist->irq_pending_on_cpu);
 }
 
+static void vgic_kick_vcpus(struct kvm *kvm)
+{
+	struct kvm_vcpu *vcpu;
+	int c;
+
+	/*
+	 * We've injected an interrupt, time to find out who deserves
+	 * a good kick...
+	 */
+	kvm_for_each_vcpu(c, vcpu, kvm) {
+		if (kvm_vgic_vcpu_pending_irq(vcpu))
+			kvm_vcpu_kick(vcpu);
+	}
+}
+
+static int vgic_validate_injection(struct kvm_vcpu *vcpu, int irq, int level)
+{
+	int is_edge = vgic_irq_is_edge(vcpu, irq);
+	int state = vgic_dist_irq_is_pending(vcpu, irq);
+
+	/*
+	 * Only inject an interrupt if:
+	 * - edge triggered and we have a rising edge
+	 * - level triggered and we change level
+	 */
+	if (is_edge)
+		return level > state;
+	else
+		return level != state;
+}
+
+static bool vgic_update_irq_state(struct kvm *kvm, int cpuid,
+				  unsigned int irq_num, bool level)
+{
+	struct vgic_dist *dist = &kvm->arch.vgic;
+	struct kvm_vcpu *vcpu;
+	int is_edge, is_level;
+	int enabled;
+	bool ret = true;
+
+	spin_lock(&dist->lock);
+
+	vcpu = kvm_get_vcpu(kvm, cpuid);
+	is_edge = vgic_irq_is_edge(vcpu, irq_num);
+	is_level = !is_edge;
+
+	if (!vgic_validate_injection(vcpu, irq_num, level)) {
+		ret = false;
+		goto out;
+	}
+
+	if (irq_num >= VGIC_NR_PRIVATE_IRQS) {
+		cpuid = dist->irq_spi_cpu[irq_num - VGIC_NR_PRIVATE_IRQS];
+		vcpu = kvm_get_vcpu(kvm, cpuid);
+	}
+
+	kvm_debug("Inject IRQ%d level %d CPU%d\n", irq_num, level, cpuid);
+
+	if (level)
+		vgic_dist_irq_set(vcpu, irq_num);
+	else
+		vgic_dist_irq_clear(vcpu, irq_num);
+
+	enabled = vgic_irq_is_enabled(vcpu, irq_num);
+
+	if (!enabled) {
+		ret = false;
+		goto out;
+	}
+
+	if (is_level && vgic_irq_is_active(vcpu, irq_num)) {
+		/*
+		 * Level interrupt in progress, will be picked up
+		 * when EOId.
+		 */
+		ret = false;
+		goto out;
+	}
+
+	if (level) {
+		vgic_cpu_irq_set(vcpu, irq_num);
+		set_bit(cpuid, &dist->irq_pending_on_cpu);
+	}
+
+out:
+	spin_unlock(&dist->lock);
+
+	return ret;
+}
+
+/**
+ * kvm_vgic_inject_irq - Inject an IRQ from a device to the vgic
+ * @kvm:     The VM structure pointer
+ * @cpuid:   The CPU for PPIs
+ * @irq_num: The IRQ number that is assigned to the device
+ * @level:   Edge-triggered:  true:  to trigger the interrupt
+ *			      false: to ignore the call
+ *	     Level-sensitive  true:  activates an interrupt
+ *			      false: deactivates an interrupt
+ *
+ * The GIC is not concerned with devices being active-LOW or active-HIGH for
+ * level-sensitive interrupts.  You can think of the level parameter as 1
+ * being HIGH and 0 being LOW and all devices being active-HIGH.
+ */
+int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid, unsigned int irq_num,
+			bool level)
+{
+	if (vgic_update_irq_state(kvm, cpuid, irq_num, level))
+		vgic_kick_vcpus(kvm);
+
+	return 0;
+}
+
 static bool vgic_ioaddr_overlap(struct kvm *kvm)
 {
 	phys_addr_t dist = kvm->arch.vgic.vgic_dist_base;
