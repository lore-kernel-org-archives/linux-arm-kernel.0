From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Mon, 22 Oct 2012 02:52:16 -0400
Subject: [PATCH v3 09/13] ARM: KVM: VGIC interrupt injection
In-Reply-To: <20121022065104.18672.52989.stgit@ubuntu>
References: <20121022065104.18672.52989.stgit@ubuntu>
Message-ID: <20121022065216.18672.36662.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

Plug the interrupt injection code. Interrupts can now be generated
from user space.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 arch/arm/include/asm/kvm_vgic.h |    8 +++
 arch/arm/kvm/arm.c              |   29 +++++++++++++
 arch/arm/kvm/vgic.c             |   90 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 127 insertions(+)

diff --git a/arch/arm/include/asm/kvm_vgic.h b/arch/arm/include/asm/kvm_vgic.h
index 7229324..6e3d303 100644
--- a/arch/arm/include/asm/kvm_vgic.h
+++ b/arch/arm/include/asm/kvm_vgic.h
@@ -241,6 +241,8 @@ struct kvm_exit_mmio;
 int kvm_vgic_set_addr(struct kvm *kvm, unsigned long type, u64 addr);
 void kvm_vgic_sync_to_cpu(struct kvm_vcpu *vcpu);
 void kvm_vgic_sync_from_cpu(struct kvm_vcpu *vcpu);
+int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid, unsigned int irq_num,
+			bool level);
 int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu);
 bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		      struct kvm_exit_mmio *mmio);
@@ -271,6 +273,12 @@ static inline void kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu) {}
 static inline void kvm_vgic_sync_to_cpu(struct kvm_vcpu *vcpu) {}
 static inline void kvm_vgic_sync_from_cpu(struct kvm_vcpu *vcpu) {}
 
+static inline int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid,
+				      const struct kvm_irq_level *irq)
+{
+	return 0;
+}
+
 static inline int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu)
 {
 	return 0;
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index f92b4ec..877e285 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -763,10 +763,31 @@ int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irq_level)
 
 	switch (irq_type) {
 	case KVM_ARM_IRQ_TYPE_CPU:
+		if (irqchip_in_kernel(kvm))
+			return -ENXIO;
+
 		if (irq_num > KVM_ARM_IRQ_CPU_FIQ)
 			return -EINVAL;
 
 		return vcpu_interrupt_line(vcpu, irq_num, level);
+#ifdef CONFIG_KVM_ARM_VGIC
+	case KVM_ARM_IRQ_TYPE_PPI:
+		if (!irqchip_in_kernel(kvm))
+			return -ENXIO;
+
+		if (irq_num < 16 || irq_num > 31)
+			return -EINVAL;
+
+		return kvm_vgic_inject_irq(kvm, vcpu->vcpu_id, irq_num, level);
+	case KVM_ARM_IRQ_TYPE_SPI:
+		if (!irqchip_in_kernel(kvm))
+			return -ENXIO;
+
+		if (irq_num < 32 || irq_num > KVM_ARM_IRQ_GIC_MAX)
+			return -EINVAL;
+
+		return kvm_vgic_inject_irq(kvm, 0, irq_num, level);
+#endif
 	}
 
 	return -EINVAL;
@@ -848,6 +869,14 @@ long kvm_arch_vm_ioctl(struct file *filp,
 	void __user *argp = (void __user *)arg;
 
 	switch (ioctl) {
+#ifdef CONFIG_KVM_ARM_VGIC
+	case KVM_CREATE_IRQCHIP: {
+		if (vgic_present)
+			return kvm_vgic_create(kvm);
+		else
+			return -EINVAL;
+	}
+#endif
 	case KVM_SET_DEVICE_ADDRESS: {
 		struct kvm_device_address dev_addr;
 
diff --git a/arch/arm/kvm/vgic.c b/arch/arm/kvm/vgic.c
index dda5623..70040bb 100644
--- a/arch/arm/kvm/vgic.c
+++ b/arch/arm/kvm/vgic.c
@@ -75,6 +75,7 @@
 #define ACCESS_WRITE_MASK(x)	((x) & (3 << 1))
 
 static void vgic_update_state(struct kvm *kvm);
+static void vgic_kick_vcpus(struct kvm *kvm);
 static void vgic_dispatch_sgi(struct kvm_vcpu *vcpu, u32 reg);
 
 static inline int vgic_irq_is_edge(struct vgic_dist *dist, int irq)
@@ -542,6 +543,9 @@ bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run, struct kvm_exi
 	kvm_prepare_mmio(run, mmio);
 	kvm_handle_mmio_return(vcpu, run);
 
+	if (updated_state)
+		vgic_kick_vcpus(vcpu->kvm);
+
 	return true;
 }
 
@@ -867,6 +871,92 @@ int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu)
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
+static bool vgic_update_irq_state(struct kvm *kvm, int cpuid,
+				  unsigned int irq_num, bool level)
+{
+	struct vgic_dist *dist = &kvm->arch.vgic;
+	struct kvm_vcpu *vcpu;
+	int is_edge, is_level, state;
+	int enabled;
+	bool ret = true;
+
+	spin_lock(&dist->lock);
+
+	is_edge = vgic_irq_is_edge(dist, irq_num);
+	is_level = !is_edge;
+	state = vgic_bitmap_get_irq_val(&dist->irq_state, cpuid, irq_num);
+
+	/*
+	 * Only inject an interrupt if:
+	 * - level triggered and we change level
+	 * - edge triggered and we have a rising edge
+	 */
+	if ((is_level && !(state ^ level)) || (is_edge && (state || !level))) {
+		ret = false;
+		goto out;
+	}
+
+	vgic_bitmap_set_irq_val(&dist->irq_state, cpuid, irq_num, level);
+
+	enabled = vgic_bitmap_get_irq_val(&dist->irq_enabled, cpuid, irq_num);
+
+	if (!enabled) {
+		ret = false;
+		goto out;
+	}
+
+	if (is_level && vgic_bitmap_get_irq_val(&dist->irq_active,
+						cpuid, irq_num)) {
+		/*
+		 * Level interrupt in progress, will be picked up
+		 * when EOId.
+		 */
+		ret = false;
+		goto out;
+	}
+
+	if (irq_num >= 32)
+		cpuid = dist->irq_spi_cpu[irq_num - 32];
+
+	kvm_debug("Inject IRQ%d level %d CPU%d\n", irq_num, level, cpuid);
+
+	vcpu = kvm_get_vcpu(kvm, cpuid);
+
+	if (level) {
+		set_bit(irq_num, vcpu->arch.vgic_cpu.pending);
+		set_bit(cpuid, &dist->irq_pending_on_cpu);
+	}
+
+out:
+	spin_unlock(&dist->lock);
+
+	return ret;
+}
+
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
