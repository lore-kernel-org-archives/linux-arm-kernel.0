From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Mon, 01 Oct 2012 05:14:26 -0400
Subject: [PATCH v2 08/10] ARM: KVM: VGIC initialisation code
In-Reply-To: <20121001091244.49503.96318.stgit@ubuntu>
References: <20121001091244.49503.96318.stgit@ubuntu>
Message-ID: <20121001091426.49503.94722.stgit@ubuntu>
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
 arch/arm/include/asm/kvm_vgic.h |    3 +
 arch/arm/kvm/arm.c              |    8 +-
 arch/arm/kvm/vgic.c             |  199 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 208 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/kvm_vgic.h b/arch/arm/include/asm/kvm_vgic.h
index 9740f1f..c8327f3 100644
--- a/arch/arm/include/asm/kvm_vgic.h
+++ b/arch/arm/include/asm/kvm_vgic.h
@@ -238,6 +238,9 @@ struct kvm_run;
 struct kvm_exit_mmio;
 
 #ifdef CONFIG_KVM_ARM_VGIC
+int kvm_vgic_hyp_init(void);
+int kvm_vgic_init(struct kvm *kvm);
+void kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu);
 void kvm_vgic_sync_to_cpu(struct kvm_vcpu *vcpu);
 void kvm_vgic_sync_from_cpu(struct kvm_vcpu *vcpu);
 int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid, unsigned int irq_num,
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index be593220..f88fd18 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -61,6 +61,8 @@ static atomic64_t kvm_vmid_gen = ATOMIC64_INIT(1);
 static u8 kvm_next_vmid;
 static DEFINE_SPINLOCK(kvm_vmid_lock);
 
+static bool vgic_present;
+
 static void kvm_arm_set_running_vcpu(struct kvm_vcpu *vcpu)
 {
 	BUG_ON(preemptible());
@@ -185,6 +187,8 @@ int kvm_dev_ioctl_check_extension(long ext)
 	switch (ext) {
 #ifdef CONFIG_KVM_ARM_VGIC
 	case KVM_CAP_IRQCHIP:
+		r = vgic_present;
+		break;
 #endif
 	case KVM_CAP_USER_MEMORY:
 	case KVM_CAP_DESTROY_MEMORY_REGION_WORKS:
@@ -992,8 +996,8 @@ static int init_hyp_mode(void)
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
index b52d4c2..fc2a138 100644
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
@@ -61,6 +68,13 @@
 /* Temporary hacks, need to be provided by userspace emulation */
 #define VGIC_DIST_BASE		0x2c001000
 #define VGIC_DIST_SIZE		0x1000
+#define VGIC_CPU_BASE		0x2c002000
+#define VGIC_CPU_SIZE		0x2000
+
+/* Virtual control interface base address */
+static void __iomem *vgic_vctrl_base;
+
+static struct device_node *vgic_node;
 
 #define ACCESS_READ_VALUE	(1 << 0)
 #define ACCESS_READ_RAZ		(0 << 0)
@@ -908,3 +922,188 @@ int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid, unsigned int irq_num,
 
 	return 0;
 }
+
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
+	int ret, i;
+	struct resource vcpu_res;
+
+	mutex_lock(&kvm->lock);
+
+	if (of_address_to_resource(vgic_node, 3, &vcpu_res)) {
+		kvm_err("Cannot obtain VCPU resource\n");
+		ret = -ENXIO;
+		goto out;
+	}
+
+	if (atomic_read(&kvm->online_vcpus) || kvm->arch.vgic.vctrl_base) {
+		ret = -EEXIST;
+		goto out;
+	}
+
+	spin_lock_init(&kvm->arch.vgic.lock);
+	kvm->arch.vgic.vctrl_base = vgic_vctrl_base;
+	kvm->arch.vgic.vgic_dist_base = VGIC_DIST_BASE;
+	kvm->arch.vgic.vgic_dist_size = VGIC_DIST_SIZE;
+
+	ret = kvm_phys_addr_ioremap(kvm, VGIC_CPU_BASE,
+				    vcpu_res.start, VGIC_CPU_SIZE);
+	if (ret) {
+		kvm_err("Unable to remap VGIC CPU to VCPU\n");
+		goto out;
+	}
+
+	for (i = 32; i < VGIC_NR_IRQS; i += 4)
+		vgic_set_target_reg(kvm, 0, i);
+
+out:
+	mutex_unlock(&kvm->lock);
+	return ret;
+}
