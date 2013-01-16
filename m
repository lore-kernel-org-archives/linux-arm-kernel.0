From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Wed, 16 Jan 2013 13:01:36 -0500
Subject: [PATCH v6 12/13] ARM: KVM: VGIC initialisation code
In-Reply-To: <20130116180013.29393.49165.stgit@ubuntu>
References: <20130116180013.29393.49165.stgit@ubuntu>
Message-ID: <20130116180136.29393.67581.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

Add the init code for the hypervisor, the virtual machine, and
the virtual CPUs.

An interrupt handler is also wired to allow the VGIC maintenance
interrupts, used to deal with level triggered interrupts and LR
underflows.

A CPU hotplug notifier is registered to disable/enable the interrupt
as requested.

Reviewed-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 arch/arm/include/asm/kvm_vgic.h |   11 ++
 arch/arm/kvm/arm.c              |   15 +++
 arch/arm/kvm/vgic.c             |  223 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 249 insertions(+)

diff --git a/arch/arm/include/asm/kvm_vgic.h b/arch/arm/include/asm/kvm_vgic.h
index 8aea9df..3103ed3 100644
--- a/arch/arm/include/asm/kvm_vgic.h
+++ b/arch/arm/include/asm/kvm_vgic.h
@@ -72,6 +72,7 @@ struct vgic_bytemap {
 struct vgic_dist {
 #ifdef CONFIG_KVM_ARM_VGIC
 	spinlock_t		lock;
+	bool			ready;
 
 	/* Virtual control interface mapping */
 	void __iomem		*vctrl_base;
@@ -145,6 +146,10 @@ struct kvm_exit_mmio;
 
 #ifdef CONFIG_KVM_ARM_VGIC
 int kvm_vgic_set_addr(struct kvm *kvm, unsigned long type, u64 addr);
+int kvm_vgic_hyp_init(void);
+int kvm_vgic_init(struct kvm *kvm);
+int kvm_vgic_create(struct kvm *kvm);
+int kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu);
 void kvm_vgic_flush_hwstate(struct kvm_vcpu *vcpu);
 void kvm_vgic_sync_hwstate(struct kvm_vcpu *vcpu);
 int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid, unsigned int irq_num,
@@ -154,6 +159,7 @@ bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		      struct kvm_exit_mmio *mmio);
 
 #define irqchip_in_kernel(k)	(!!((k)->arch.vgic.vctrl_base))
+#define vgic_initialized(k)	((k)->arch.vgic.ready)
 
 #else
 static inline int kvm_vgic_hyp_init(void)
@@ -205,6 +211,11 @@ static inline int irqchip_in_kernel(struct kvm *kvm)
 {
 	return 0;
 }
+
+static inline bool vgic_initialized(struct kvm *kvm)
+{
+	return true;
+}
 #endif
 
 #endif
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index a0e93d3..68cb2b550 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -641,6 +641,17 @@ static int kvm_vcpu_first_run_init(struct kvm_vcpu *vcpu)
 	vcpu->arch.has_run_once = true;
 
 	/*
+	 * Initialize the VGIC before running a vcpu the first time on
+	 * this VM.
+	 */
+	if (irqchip_in_kernel(vcpu->kvm) &&
+	    unlikely(!vgic_initialized(vcpu->kvm))) {
+		int ret = kvm_vgic_init(vcpu->kvm);
+		if (ret)
+			return ret;
+	}
+
+	/*
 	 * Handle the "start in power-off" case by calling into the
 	 * PSCI code.
 	 */
@@ -1078,6 +1089,10 @@ static int init_hyp_mode(void)
 	if (err)
 		goto out_free_vfp;
 
+#ifdef CONFIG_KVM_ARM_VGIC
+		vgic_present = true;
+#endif
+
 	kvm_info("Hyp mode initialized successfully\n");
 	return 0;
 out_free_vfp:
diff --git a/arch/arm/kvm/vgic.c b/arch/arm/kvm/vgic.c
index 2e6a585..519cde1 100644
--- a/arch/arm/kvm/vgic.c
+++ b/arch/arm/kvm/vgic.c
@@ -16,11 +16,19 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
 
+#include <linux/cpu.h>
 #include <linux/kvm.h>
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
@@ -62,6 +70,14 @@
 #define VGIC_ADDR_UNDEF		(-1)
 #define IS_VGIC_ADDR_UNDEF(_x)  ((_x) == VGIC_ADDR_UNDEF)
 
+/* Physical address of vgic virtual cpu interface */
+static phys_addr_t vgic_vcpu_base;
+
+/* Virtual control interface base address */
+static void __iomem *vgic_vctrl_base;
+
+static struct device_node *vgic_node;
+
 #define ACCESS_READ_VALUE	(1 << 0)
 #define ACCESS_READ_RAZ		(0 << 0)
 #define ACCESS_READ_MASK(x)	((x) & (1 << 0))
@@ -75,6 +91,9 @@ static void vgic_retire_disabled_irqs(struct kvm_vcpu *vcpu);
 static void vgic_update_state(struct kvm *kvm);
 static void vgic_kick_vcpus(struct kvm *kvm);
 static void vgic_dispatch_sgi(struct kvm_vcpu *vcpu, u32 reg);
+static u32 vgic_nr_lr;
+
+static unsigned int vgic_maint_irq;
 
 static u32 *vgic_bitmap_get_reg(struct vgic_bitmap *x,
 				int cpuid, u32 offset)
@@ -1221,6 +1240,210 @@ int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid, unsigned int irq_num,
 	return 0;
 }
 
+static irqreturn_t vgic_maintenance_handler(int irq, void *data)
+{
+	/*
+	 * We cannot rely on the vgic maintenance interrupt to be
+	 * delivered synchronously. This means we can only use it to
+	 * exit the VM, and we perform the handling of EOIed
+	 * interrupts on the exit path (see vgic_process_maintenance).
+	 */
+	return IRQ_HANDLED;
+}
+
+int kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu)
+{
+	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
+	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
+	int i;
+
+	if (!irqchip_in_kernel(vcpu->kvm))
+		return 0;
+
+	if (vcpu->vcpu_id >= VGIC_MAX_CPUS)
+		return -EBUSY;
+
+	for (i = 0; i < VGIC_NR_IRQS; i++) {
+		if (i < VGIC_NR_PPIS)
+			vgic_bitmap_set_irq_val(&dist->irq_enabled,
+						vcpu->vcpu_id, i, 1);
+		if (i < VGIC_NR_PRIVATE_IRQS)
+			vgic_bitmap_set_irq_val(&dist->irq_cfg,
+						vcpu->vcpu_id, i, VGIC_CFG_EDGE);
+
+		vgic_cpu->vgic_irq_lr_map[i] = LR_EMPTY;
+	}
+
+	/*
+	 * By forcing VMCR to zero, the GIC will restore the binary
+	 * points to their reset values. Anything else resets to zero
+	 * anyway.
+	 */
+	vgic_cpu->vgic_vmcr = 0;
+
+	vgic_cpu->nr_lr = vgic_nr_lr;
+	vgic_cpu->vgic_hcr = GICH_HCR_EN; /* Get the show on the road... */
+
+	return 0;
+}
+
+static void vgic_init_maintenance_interrupt(void *info)
+{
+	enable_percpu_irq(vgic_maint_irq, 0);
+}
+
+static int vgic_cpu_notify(struct notifier_block *self,
+			   unsigned long action, void *cpu)
+{
+	switch (action) {
+	case CPU_STARTING:
+	case CPU_STARTING_FROZEN:
+		vgic_init_maintenance_interrupt(NULL);
+		break;
+	case CPU_DYING:
+	case CPU_DYING_FROZEN:
+		disable_percpu_irq(vgic_maint_irq);
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block vgic_cpu_nb = {
+	.notifier_call = vgic_cpu_notify,
+};
+
+int kvm_vgic_hyp_init(void)
+{
+	int ret;
+	struct resource vctrl_res;
+	struct resource vcpu_res;
+
+	vgic_node = of_find_compatible_node(NULL, NULL, "arm,cortex-a15-gic");
+	if (!vgic_node) {
+		kvm_err("error: no compatible vgic node in DT\n");
+		return -ENODEV;
+	}
+
+	vgic_maint_irq = irq_of_parse_and_map(vgic_node, 0);
+	if (!vgic_maint_irq) {
+		kvm_err("error getting vgic maintenance irq from DT\n");
+		ret = -ENXIO;
+		goto out;
+	}
+
+	ret = request_percpu_irq(vgic_maint_irq, vgic_maintenance_handler,
+				 "vgic", kvm_get_running_vcpus());
+	if (ret) {
+		kvm_err("Cannot register interrupt %d\n", vgic_maint_irq);
+		goto out;
+	}
+
+	ret = register_cpu_notifier(&vgic_cpu_nb);
+	if (ret) {
+		kvm_err("Cannot register vgic CPU notifier\n");
+		goto out_free_irq;
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
+	vgic_nr_lr = readl_relaxed(vgic_vctrl_base + GICH_VTR);
+	vgic_nr_lr = (vgic_nr_lr & 0x3f) + 1;
+
+	ret = create_hyp_io_mappings(vgic_vctrl_base,
+				     vgic_vctrl_base + resource_size(&vctrl_res),
+				     vctrl_res.start);
+	if (ret) {
+		kvm_err("Cannot map VCTRL into hyp\n");
+		goto out_unmap;
+	}
+
+	kvm_info("%s@%llx IRQ%d\n", vgic_node->name,
+		 vctrl_res.start, vgic_maint_irq);
+	on_each_cpu(vgic_init_maintenance_interrupt, NULL, 1);
+
+	if (of_address_to_resource(vgic_node, 3, &vcpu_res)) {
+		kvm_err("Cannot obtain VCPU resource\n");
+		ret = -ENXIO;
+		goto out_unmap;
+	}
+	vgic_vcpu_base = vcpu_res.start;
+
+	goto out;
+
+out_unmap:
+	iounmap(vgic_vctrl_base);
+out_free_irq:
+	free_percpu_irq(vgic_maint_irq, kvm_get_running_vcpus());
+out:
+	of_node_put(vgic_node);
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
+				    vgic_vcpu_base, KVM_VGIC_V2_CPU_SIZE);
+	if (ret) {
+		kvm_err("Unable to remap VGIC CPU to VCPU\n");
+		goto out;
+	}
+
+	for (i = VGIC_NR_PRIVATE_IRQS; i < VGIC_NR_IRQS; i += 4)
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
+	int ret = 0;
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
+out:
+	mutex_unlock(&kvm->lock);
+	return ret;
+}
+
 static bool vgic_ioaddr_overlap(struct kvm *kvm)
 {
 	phys_addr_t dist = kvm->arch.vgic.vgic_dist_base;
