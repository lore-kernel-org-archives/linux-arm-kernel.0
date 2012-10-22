From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Mon, 22 Oct 2012 02:52:29 -0400
Subject: [PATCH v3 11/13] ARM: KVM: VGIC initialisation code
In-Reply-To: <20121022065104.18672.52989.stgit@ubuntu>
References: <20121022065104.18672.52989.stgit@ubuntu>
Message-ID: <20121022065229.18672.82553.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

Add the init code for the hypervisor, the virtual machine, and
the virtual CPUs.

An interrupt handler is also wired to allow the VGIC maintenance
interrupts, used to deal with level triggered interrupts and LR
underflows.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 arch/arm/include/asm/kvm_vgic.h |   11 ++
 arch/arm/kvm/arm.c              |   14 ++
 arch/arm/kvm/vgic.c             |  237 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 258 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/kvm_vgic.h b/arch/arm/include/asm/kvm_vgic.h
index 6e3d303..1287f75 100644
--- a/arch/arm/include/asm/kvm_vgic.h
+++ b/arch/arm/include/asm/kvm_vgic.h
@@ -154,6 +154,7 @@ static inline void vgic_bytemap_set_irq_val(struct vgic_bytemap *x,
 struct vgic_dist {
 #ifdef CONFIG_KVM_ARM_VGIC
 	spinlock_t		lock;
+	bool			ready;
 
 	/* Virtual control interface mapping */
 	void __iomem		*vctrl_base;
@@ -239,6 +240,10 @@ struct kvm_exit_mmio;
 
 #ifdef CONFIG_KVM_ARM_VGIC
 int kvm_vgic_set_addr(struct kvm *kvm, unsigned long type, u64 addr);
+int kvm_vgic_hyp_init(void);
+int kvm_vgic_init(struct kvm *kvm);
+int kvm_vgic_create(struct kvm *kvm);
+void kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu);
 void kvm_vgic_sync_to_cpu(struct kvm_vcpu *vcpu);
 void kvm_vgic_sync_from_cpu(struct kvm_vcpu *vcpu);
 int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid, unsigned int irq_num,
@@ -248,6 +253,7 @@ bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		      struct kvm_exit_mmio *mmio);
 
 #define irqchip_in_kernel(k)	(!!((k)->arch.vgic.vctrl_base))
+#define vgic_initialized(k)	((k)->arch.vgic.ready)
 #else
 static inline int kvm_vgic_hyp_init(void)
 {
@@ -294,6 +300,11 @@ static inline int irqchip_in_kernel(struct kvm *kvm)
 {
 	return 0;
 }
+
+static inline bool kvm_vgic_initialized(struct kvm *kvm)
+{
+	return true;
+}
 #endif
 
 #endif
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 877e285..d367831 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -187,6 +187,8 @@ int kvm_dev_ioctl_check_extension(long ext)
 	switch (ext) {
 #ifdef CONFIG_KVM_ARM_VGIC
 	case KVM_CAP_IRQCHIP:
+		r = vgic_present;
+		break;
 #endif
 	case KVM_CAP_USER_MEMORY:
 	case KVM_CAP_DESTROY_MEMORY_REGION_WORKS:
@@ -622,6 +624,14 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	if (unlikely(vcpu->arch.target < 0))
 		return -ENOEXEC;
 
+	/* Initalize the VGIC before running a vcpu the first time on this VM */
+	if (unlikely(irqchip_in_kernel(vcpu->kvm) &&
+		     !vgic_initialized(vcpu->kvm))) {
+		ret = kvm_vgic_init(vcpu->kvm);
+		if (ret)
+			return ret;
+	}
+
 	if (run->exit_reason == KVM_EXIT_MMIO) {
 		ret = kvm_handle_mmio_return(vcpu, vcpu->run);
 		if (ret)
@@ -1023,8 +1033,8 @@ static int init_hyp_mode(void)
 	 * Init HYP view of VGIC
 	 */
 	err = kvm_vgic_hyp_init();
-	if (err)
-		goto out_free_mappings;
+	if (!err)
+		vgic_present = true;
 
 	return 0;
 out_free_vfp:
diff --git a/arch/arm/kvm/vgic.c b/arch/arm/kvm/vgic.c
index 70040bb..415ddb8 100644
--- a/arch/arm/kvm/vgic.c
+++ b/arch/arm/kvm/vgic.c
@@ -20,7 +20,14 @@
 #include <linux/kvm_host.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
 #include <asm/kvm_emulate.h>
+#include <asm/hardware/gic.h>
+#include <asm/kvm_arm.h>
+#include <asm/kvm_mmu.h>
 
 /*
  * How the whole thing works (courtesy of Christoffer Dall):
@@ -59,11 +66,18 @@
  */
 
 #define VGIC_ADDR_UNDEF		(-1)
-#define IS_VGIC_ADDR_UNDEF(_x)  ((_x) == (typeof(_x))VGIC_ADDR_UNDEF)
+#define IS_VGIC_ADDR_UNDEF(_x)  ((_x) == VGIC_ADDR_UNDEF)
 
 #define VGIC_DIST_SIZE		0x1000
 #define VGIC_CPU_SIZE		0x2000
 
+/* Physical address of vgic virtual cpu interface */
+static phys_addr_t vgic_vcpu_base;
+
+/* Virtual control interface base address */
+static void __iomem *vgic_vctrl_base;
+
+static struct device_node *vgic_node;
 
 #define ACCESS_READ_VALUE	(1 << 0)
 #define ACCESS_READ_RAZ		(0 << 0)
@@ -527,7 +541,7 @@ bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run, struct kvm_exi
 
 	if (!irqchip_in_kernel(vcpu->kvm) ||
 	    mmio->phys_addr < base ||
-	    (mmio->phys_addr + mmio->len) > (base + dist->vgic_dist_size))
+	    (mmio->phys_addr + mmio->len) > (base + VGIC_DIST_SIZE))
 		return false;
 
 	range = find_matching_range(vgic_ranges, mmio, base);
@@ -957,6 +971,225 @@ int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid, unsigned int irq_num,
 	return 0;
 }
 
+static irqreturn_t vgic_maintenance_handler(int irq, void *data)
+{
+	struct kvm_vcpu *vcpu = *(struct kvm_vcpu **)data;
+	struct vgic_dist *dist;
+	struct vgic_cpu *vgic_cpu;
+
+	if (WARN(!vcpu,
+		 "VGIC interrupt on CPU %d with no vcpu\n", smp_processor_id()))
+		return IRQ_HANDLED;
+
+	vgic_cpu = &vcpu->arch.vgic_cpu;
+	dist = &vcpu->kvm->arch.vgic;
+	kvm_debug("MISR = %08x\n", vgic_cpu->vgic_misr);
+
+	/*
+	 * We do not need to take the distributor lock here, since the only
+	 * action we perform is clearing the irq_active_bit for an EOIed
+	 * level interrupt.  There is a potential race with
+	 * the queuing of an interrupt in __kvm_sync_to_cpu(), where we check
+	 * if the interrupt is already active. Two possibilities:
+	 *
+	 * - The queuing is occuring on the same vcpu: cannot happen, as we're
+	 *   already in the context of this vcpu, and executing the handler
+	 * - The interrupt has been migrated to another vcpu, and we ignore
+	 *   this interrupt for this run. Big deal. It is still pending though,
+	 *   and will get considered when this vcpu exits.
+	 */
+	if (vgic_cpu->vgic_misr & VGIC_MISR_EOI) {
+		/*
+		 * Some level interrupts have been EOIed. Clear their
+		 * active bit.
+		 */
+		int lr, irq;
+
+		for_each_set_bit(lr, (unsigned long *)vgic_cpu->vgic_eisr,
+				 vgic_cpu->nr_lr) {
+			irq = vgic_cpu->vgic_lr[lr] & VGIC_LR_VIRTUALID;
+
+			vgic_bitmap_set_irq_val(&dist->irq_active,
+						vcpu->vcpu_id, irq, 0);
+			vgic_cpu->vgic_lr[lr] &= ~VGIC_LR_EOI;
+			writel_relaxed(vgic_cpu->vgic_lr[lr],
+				       dist->vctrl_base + GICH_LR0 + (lr << 2));
+
+			/* Any additionnal pending interrupt? */
+			if (vgic_bitmap_get_irq_val(&dist->irq_state,
+						    vcpu->vcpu_id, irq)) {
+				set_bit(irq, vcpu->arch.vgic_cpu.pending);
+				set_bit(vcpu->vcpu_id,
+					&dist->irq_pending_on_cpu);
+			} else {
+				clear_bit(irq, vgic_cpu->pending);
+			}
+		}
+	}
+
+	if (vgic_cpu->vgic_misr & VGIC_MISR_U) {
+		vgic_cpu->vgic_hcr &= ~VGIC_HCR_UIE;
+		writel_relaxed(vgic_cpu->vgic_hcr, dist->vctrl_base + GICH_HCR);
+	}
+
+	return IRQ_HANDLED;
+}
+
+void kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu)
+{
+	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
+	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
+	u32 reg;
+	int i;
+
+	if (!irqchip_in_kernel(vcpu->kvm))
+		return;
+
+	for (i = 0; i < VGIC_NR_IRQS; i++) {
+		if (i < 16)
+			vgic_bitmap_set_irq_val(&dist->irq_enabled,
+						vcpu->vcpu_id, i, 1);
+		if (i < 32)
+			vgic_bitmap_set_irq_val(&dist->irq_cfg,
+						vcpu->vcpu_id, i, 1);
+
+		vgic_cpu->vgic_irq_lr_map[i] = LR_EMPTY;
+	}
+
+	BUG_ON(!vcpu->kvm->arch.vgic.vctrl_base);
+	reg = readl_relaxed(vcpu->kvm->arch.vgic.vctrl_base + GICH_VTR);
+	vgic_cpu->nr_lr = (reg & 0x1f) + 1;
+
+	reg = readl_relaxed(vcpu->kvm->arch.vgic.vctrl_base + GICH_VMCR);
+	vgic_cpu->vgic_vmcr = reg | (0x1f << 27); /* Priority */
+
+	vgic_cpu->vgic_hcr |= VGIC_HCR_EN; /* Get the show on the road... */
+}
+
+static void vgic_init_maintenance_interrupt(void *info)
+{
+	unsigned int *irqp = info;
+
+	enable_percpu_irq(*irqp, 0);
+}
+
+int kvm_vgic_hyp_init(void)
+{
+	int ret;
+	unsigned int irq;
+	struct resource vctrl_res;
+	struct resource vcpu_res;
+
+	vgic_node = of_find_compatible_node(NULL, NULL, "arm,cortex-a15-gic");
+	if (!vgic_node)
+		return -ENODEV;
+
+	irq = irq_of_parse_and_map(vgic_node, 0);
+	if (!irq)
+		return -ENXIO;
+
+	ret = request_percpu_irq(irq, vgic_maintenance_handler,
+				 "vgic", kvm_get_running_vcpus());
+	if (ret) {
+		kvm_err("Cannot register interrupt %d\n", irq);
+		return ret;
+	}
+
+	ret = of_address_to_resource(vgic_node, 2, &vctrl_res);
+	if (ret) {
+		kvm_err("Cannot obtain VCTRL resource\n");
+		goto out_free_irq;
+	}
+
+	vgic_vctrl_base = of_iomap(vgic_node, 2);
+	if (!vgic_vctrl_base) {
+		kvm_err("Cannot ioremap VCTRL\n");
+		ret = -ENOMEM;
+		goto out_free_irq;
+	}
+
+	ret = create_hyp_io_mappings(vgic_vctrl_base,
+				     vgic_vctrl_base + resource_size(&vctrl_res),
+				     vctrl_res.start);
+	if (ret) {
+		kvm_err("Cannot map VCTRL into hyp\n");
+		goto out_unmap;
+	}
+
+	kvm_info("%s@%llx IRQ%d\n", vgic_node->name, vctrl_res.start, irq);
+	on_each_cpu(vgic_init_maintenance_interrupt, &irq, 1);
+
+	if (of_address_to_resource(vgic_node, 3, &vcpu_res)) {
+		kvm_err("Cannot obtain VCPU resource\n");
+		ret = -ENXIO;
+		goto out_unmap;
+	}
+	vgic_vcpu_base = vcpu_res.start;
+
+	return 0;
+
+out_unmap:
+	iounmap(vgic_vctrl_base);
+out_free_irq:
+	free_percpu_irq(irq, kvm_get_running_vcpus());
+
+	return ret;
+}
+
+int kvm_vgic_init(struct kvm *kvm)
+{
+	int ret = 0, i;
+
+	mutex_lock(&kvm->lock);
+
+	if (vgic_initialized(kvm))
+		goto out;
+
+	if (IS_VGIC_ADDR_UNDEF(kvm->arch.vgic.vgic_dist_base) ||
+	    IS_VGIC_ADDR_UNDEF(kvm->arch.vgic.vgic_cpu_base)) {
+		kvm_err("Need to set vgic cpu and dist addresses first\n");
+		ret = -ENXIO;
+		goto out;
+	}
+
+	ret = kvm_phys_addr_ioremap(kvm, kvm->arch.vgic.vgic_cpu_base,
+				    vgic_vcpu_base, VGIC_CPU_SIZE);
+	if (ret) {
+		kvm_err("Unable to remap VGIC CPU to VCPU\n");
+		goto out;
+	}
+
+	for (i = 32; i < VGIC_NR_IRQS; i += 4)
+		vgic_set_target_reg(kvm, 0, i);
+
+	kvm->arch.vgic.ready = true;
+out:
+	mutex_unlock(&kvm->lock);
+	return ret;
+}
+
+int kvm_vgic_create(struct kvm *kvm)
+{
+	int ret;
+
+	mutex_lock(&kvm->lock);
+
+	if (atomic_read(&kvm->online_vcpus) || kvm->arch.vgic.vctrl_base) {
+		ret = -EEXIST;
+		goto out;
+	}
+
+	spin_lock_init(&kvm->arch.vgic.lock);
+	kvm->arch.vgic.vctrl_base = vgic_vctrl_base;
+	kvm->arch.vgic.vgic_dist_base = VGIC_ADDR_UNDEF;
+	kvm->arch.vgic.vgic_cpu_base = VGIC_ADDR_UNDEF;
+
+	ret = 0;
+out:
+	mutex_unlock(&kvm->lock);
+	return ret;
+}
+
 static bool vgic_ioaddr_overlap(struct kvm *kvm)
 {
 	phys_addr_t dist = kvm->arch.vgic.vgic_dist_base;
