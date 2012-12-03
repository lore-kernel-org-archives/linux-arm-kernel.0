From: b29396@freescale.com (Dong Aisheng)
Date: Mon, 3 Dec 2012 18:36:59 +0800
Subject: [RFC PATCH 1/1] KVM: ARM: add vgic state save and restore support
Message-ID: <1354531019-9335-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Aisheng <dong.aisheng@linaro.org>

Add vgic state save and retore via KVM_SET_IRQCHIP/KVM_GET_IRQCHIP.

Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
---
The patch is mainly for implementing the vgic state save and retore function.
I'm not sure the current implementation method is the most proper way.
So i'd like to send out the patch for RFC on the direction and issues i met
during the implementation.

There're mainly two ways to implement such function while it looks different
ways have different issues respectively.
1) Firstly i tried using ONE_REG interfaces that user spaces could
read all virtual gic dist registers and gic virtual interfaces control
registers for saving gic states. (The vitural cpu interfaces registers
are not exported since it's state could be got from GICH_VMCR register which
already reflects the basic cpu interface states.)
The way to do this could be to mannually emulate MMIO access in
kernel to re-use vgic_handle_mmio code since the vgic code in kernel does
not maintain gic state in registers format and we can not simply memcpy
the kernel gic registers to user spaces.

For this way, the problem is that it looks a bit low efficiency for emulate
register access and via current ONE_REG interface we do not know which CPU
is performing the register access, so the banked registers are not suppported
well,
e.g. some banked dist registers and banked cpu virtual interfaces
control registers.
So i'm not sure we should still go follow this way.

2) Another way is, as x86, to use standard KVM_SET_IRQCHIP/KVM_GET_IRQCHIP
ioctl to save and restore irq chip state. e.g. arch/x86/kvm/x86.c.
This method does not have banked registers issue since it could all be
handled by SW and it looks simpler than the first way.
The problem is that the x86 kvm irqchip driver are using almost the same data
structure as user space to represent irqchip states which then can be easily
copied to user spaces. But arm vgic driver are using different data structure,
e.g. qemu gic common code is using gic_state while in kernel vgic code is using
a number of vgic_bitmaps.
We could either read all the in-kernel vgic_bitmaps from user space and
mannually convert it to git_state for user space to use to re-use the exist
common state handle codes in qemu or convert to git_state format in kernel
and then export to user space, but neither way looks good and they also
look low efficiency, so i can not see enough reasons to do so.

The current implementation in this patch does not do any convertion
between the two different state formats and it just simply export what we have
in kernel to represent gic state to user space via KVM_GET_IRQCHIP,
that means we does not use much common state handle code in arm_gic_common.c
in qemu.

However, by comparing to first method, the disadvantage of second method
is that it has side effect. Once the kernel vgic state code changes, it may
also need change the user space code accordingly since the user space
are using the kernel state definition.
And another known issue in current patch, VGIC_MAX_CPUS, defined the
size of CPU data in dist state, used is in headfile
arch/arm/include/asm/kvm.h which will also be used by qemu, is dynamically
defined in kernel, it looks we should not export it to user space and need
find a way to fix. Besides that, there're aslo some headfiles cross-inclusion
issue also need to resolved.

I'd like to know your suggestions on which way is better and your comments
on the issues i metioned above.
---
 Documentation/virtual/kvm/api.txt |    6 +-
 arch/arm/include/asm/kvm.h        |   11 +++
 arch/arm/include/asm/kvm_vgic.h   |   47 +++++++++----
 arch/arm/kernel/asm-offsets.c     |   16 ++--
 arch/arm/kvm/arm.c                |   83 ++++++++++++++++++++++-
 arch/arm/kvm/interrupts_head.S    |    6 +-
 arch/arm/kvm/vgic.c               |  134 ++++++++++++++++++------------------
 include/linux/kvm.h               |    3 +
 include/linux/kvm_host.h          |    3 +-
 9 files changed, 213 insertions(+), 96 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 7695425..e736689 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -654,7 +654,7 @@ struct kvm_irq_level {
 4.26 KVM_GET_IRQCHIP
 
 Capability: KVM_CAP_IRQCHIP
-Architectures: x86, ia64
+Architectures: x86, ia64, arm
 Type: vm ioctl
 Parameters: struct kvm_irqchip (in/out)
 Returns: 0 on success, -1 on error
@@ -669,6 +669,7 @@ struct kvm_irqchip {
 		char dummy[512];  /* reserving space */
 		struct kvm_pic_state pic;
 		struct kvm_ioapic_state ioapic;
+		struct kvm_vgic_state vgic;
 	} chip;
 };
 
@@ -676,7 +677,7 @@ struct kvm_irqchip {
 4.27 KVM_SET_IRQCHIP
 
 Capability: KVM_CAP_IRQCHIP
-Architectures: x86, ia64
+Architectures: x86, ia64, arm
 Type: vm ioctl
 Parameters: struct kvm_irqchip (in)
 Returns: 0 on success, -1 on error
@@ -691,6 +692,7 @@ struct kvm_irqchip {
 		char dummy[512];  /* reserving space */
 		struct kvm_pic_state pic;
 		struct kvm_ioapic_state ioapic;
+		struct kvm_vgic_state vgic;
 	} chip;
 };
 
diff --git a/arch/arm/include/asm/kvm.h b/arch/arm/include/asm/kvm.h
index 8101812..59e3ad6 100644
--- a/arch/arm/include/asm/kvm.h
+++ b/arch/arm/include/asm/kvm.h
@@ -20,9 +20,11 @@
 #define __ARM_KVM_H__
 
 #include <asm/types.h>
+#include <asm/kvm_vgic.h>
 
 #define __KVM_HAVE_GUEST_DEBUG
 #define __KVM_HAVE_IRQ_LINE
+#define __KVM_HAVE_VIGC
 
 #define KVM_REG_SIZE(id)						\
 	(1U << (((id) & KVM_REG_SIZE_MASK) >> KVM_REG_SIZE_SHIFT))
@@ -47,6 +49,15 @@ struct kvm_vcpu_init {
 	__u32 features[7];
 };
 
+#define KVM_IRQCHIP_VGIC	0
+
+/* for KVM_GET_IRQCHIP and KVM_SET_IRQCHIP */
+
+struct kvm_vgic_state {
+	struct kvm_vgic_dist_state dist;
+	struct kvm_vgic_vcpu_state vcpu[VGIC_MAX_CPUS];
+};
+
 struct kvm_sregs {
 };
 
diff --git a/arch/arm/include/asm/kvm_vgic.h b/arch/arm/include/asm/kvm_vgic.h
index d722541..ef26d3b 100644
--- a/arch/arm/include/asm/kvm_vgic.h
+++ b/arch/arm/include/asm/kvm_vgic.h
@@ -20,14 +20,15 @@
 #define __ASM_ARM_KVM_VGIC_H
 
 #include <linux/kernel.h>
-#include <linux/kvm.h>
 #include <linux/irqreturn.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
 
 #define VGIC_NR_IRQS		128
 #define VGIC_NR_SHARED_IRQS	(VGIC_NR_IRQS - 32)
-#define VGIC_MAX_CPUS		KVM_MAX_VCPUS
+
+/* Temporarily hack since kvm_host.h and kvm_vgic.h can not be cross included */
+#define VGIC_MAX_CPUS		8
 
 /* Sanity checks... */
 #if (VGIC_MAX_CPUS > 8)
@@ -150,17 +151,7 @@ static inline void vgic_bytemap_set_irq_val(struct vgic_bytemap *x,
 	*reg |= (val & 0xff) << shift;
 }
 
-struct vgic_dist {
-#ifdef CONFIG_KVM_ARM_VGIC
-	spinlock_t		lock;
-
-	/* Virtual control interface mapping */
-	void __iomem		*vctrl_base;
-
-	/* Distributor mapping in the guest */
-	unsigned long		vgic_dist_base;
-	unsigned long		vgic_dist_size;
-
+struct kvm_vgic_dist_state {
 	/* Distributor enabled */
 	u32			enabled;
 
@@ -188,6 +179,33 @@ struct vgic_dist {
 
 	/* Bitmap indicating which CPU has something pending */
 	unsigned long		irq_pending_on_cpu;
+
+};
+
+struct kvm_vgic_vcpu_state {
+	/* CPU vif control registers for world switch */
+	u32		vgic_hcr;
+	u32		vgic_vmcr;
+	u32		vgic_misr;	/* Saved only */
+	u32		vgic_eisr[2];	/* Saved only */
+	u32		vgic_elrsr[2];	/* Saved only */
+	u32		vgic_apr;
+	u32		vgic_lr[64];	/* A15 has only 4... */
+};
+
+
+struct vgic_dist {
+#ifdef CONFIG_KVM_ARM_VGIC
+	spinlock_t		lock;
+
+	/* Virtual control interface mapping */
+	void __iomem		*vctrl_base;
+
+	/* Distributor mapping in the guest */
+	unsigned long		vgic_dist_base;
+	unsigned long		vgic_dist_size;
+
+	struct kvm_vgic_dist_state state;
 #endif
 };
 
@@ -205,6 +223,8 @@ struct vgic_cpu {
 	/* Number of list registers on this CPU */
 	int		nr_lr;
 
+	struct kvm_vgic_vcpu_state state;
+
 	/* CPU vif control registers for world switch */
 	u32		vgic_hcr;
 	u32		vgic_vmcr;
@@ -250,6 +270,7 @@ int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid, unsigned int irq_num,
 int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu);
 bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		      struct kvm_exit_mmio *mmio);
+void vgic_update_state(struct kvm *kvm);
 
 #define irqchip_in_kernel(k)	(!!((k)->arch.vgic.vctrl_base))
 #define vgic_active_irq(v)	(atomic_read(&(v)->arch.vgic_cpu.irq_active_count) == 0)
diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index 1c4181e..37829e6 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -167,14 +167,14 @@ int main(void)
   DEFINE(VCPU_HPFAR,		offsetof(struct kvm_vcpu, arch.hpfar));
   DEFINE(VCPU_HYP_PC,		offsetof(struct kvm_vcpu, arch.hyp_pc));
 #ifdef CONFIG_KVM_ARM_VGIC
-  DEFINE(VCPU_VGIC_CPU,		offsetof(struct kvm_vcpu, arch.vgic_cpu));
-  DEFINE(VGIC_CPU_HCR,		offsetof(struct vgic_cpu, vgic_hcr));
-  DEFINE(VGIC_CPU_VMCR,		offsetof(struct vgic_cpu, vgic_vmcr));
-  DEFINE(VGIC_CPU_MISR,		offsetof(struct vgic_cpu, vgic_misr));
-  DEFINE(VGIC_CPU_EISR,		offsetof(struct vgic_cpu, vgic_eisr));
-  DEFINE(VGIC_CPU_ELRSR,	offsetof(struct vgic_cpu, vgic_elrsr));
-  DEFINE(VGIC_CPU_APR,		offsetof(struct vgic_cpu, vgic_apr));
-  DEFINE(VGIC_CPU_LR,		offsetof(struct vgic_cpu, vgic_lr));
+  DEFINE(VCPU_VGIC_CPU_STATE,	offsetof(struct kvm_vcpu, arch.vgic_cpu.state));
+  DEFINE(VGIC_CPU_HCR,		offsetof(struct kvm_vgic_vcpu_state, vgic_hcr));
+  DEFINE(VGIC_CPU_VMCR,		offsetof(struct kvm_vgic_vcpu_state, vgic_vmcr));
+  DEFINE(VGIC_CPU_MISR,		offsetof(struct kvm_vgic_vcpu_state, vgic_misr));
+  DEFINE(VGIC_CPU_EISR,		offsetof(struct kvm_vgic_vcpu_state, vgic_eisr));
+  DEFINE(VGIC_CPU_ELRSR,	offsetof(struct kvm_vgic_vcpu_state, vgic_elrsr));
+  DEFINE(VGIC_CPU_APR,		offsetof(struct kvm_vgic_vcpu_state, vgic_apr));
+  DEFINE(VGIC_CPU_LR,		offsetof(struct kvm_vgic_vcpu_state, vgic_lr));
   DEFINE(VGIC_CPU_NR_LR,	offsetof(struct vgic_cpu, nr_lr));
 #ifdef CONFIG_KVM_ARM_TIMER
   DEFINE(VCPU_TIMER_CNTV_CTL,	offsetof(struct kvm_vcpu, arch.timer_cpu.cntv_ctl));
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index d64ce2a..19b5cca 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -43,6 +43,7 @@
 #include <asm/kvm_mmu.h>
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_coproc.h>
+#include <asm/kvm_vgic.h>
 #include <asm/opcodes.h>
 
 #ifdef REQUIRES_VIRT
@@ -857,19 +858,99 @@ int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
 	return -EINVAL;
 }
 
+static int kvm_vm_ioctl_get_irqchip(struct kvm *kvm, struct kvm_irqchip *chip)
+{
+	struct vgic_dist *dist = &kvm->arch.vgic;
+	struct kvm_vcpu *vcpu;
+	int ret = 0;
+	int c;
+
+	switch (chip->chip_id) {
+	case KVM_IRQCHIP_VGIC:
+		memcpy(&chip->chip.vgic.dist,
+			&dist->state,
+			sizeof(struct kvm_vgic_dist_state));
+
+		kvm_for_each_vcpu(c, vcpu, kvm) {
+			memcpy(&chip->chip.vgic.vcpu[vcpu->vcpu_id],
+				&vcpu->arch.vgic_cpu.state,
+				sizeof(struct kvm_vgic_vcpu_state));
+		}
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int kvm_vm_ioctl_set_irqchip(struct kvm *kvm, struct kvm_irqchip *chip)
+{
+	int ret = 0;
+
+	switch (chip->chip_id) {
+	case KVM_IRQCHIP_VGIC:
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	vgic_update_state(kvm);
+
+	return ret;
+}
+
 long kvm_arch_vm_ioctl(struct file *filp,
 		       unsigned int ioctl, unsigned long arg)
 {
+	struct kvm *kvm = filp->private_data;
+	void __user *argp = (void __user *)arg;
+	int ret;
 
 	switch (ioctl) {
 #ifdef CONFIG_KVM_ARM_VGIC
 	case KVM_CREATE_IRQCHIP: {
-		struct kvm *kvm = filp->private_data;
 		if (vgic_present)
 			return kvm_vgic_init(kvm);
 		else
 			return -EINVAL;
 	}
+	case KVM_GET_IRQCHIP: {
+		struct kvm_irqchip *chip;
+
+		if (!irqchip_in_kernel(kvm))
+			return -ENXIO;
+
+		chip = memdup_user(argp, sizeof(*chip));
+		if (IS_ERR(chip))
+			return PTR_ERR(chip);
+
+		ret = kvm_vm_ioctl_get_irqchip(kvm, chip);
+		if (ret)
+			goto get_irqchip_out;
+
+		ret = copy_to_user(argp, chip, sizeof(*chip));
+get_irqchip_out:
+		kfree(chip);
+		return ret;
+	}
+	case KVM_SET_IRQCHIP: {
+		struct kvm_irqchip *chip;
+
+		if (!irqchip_in_kernel(kvm))
+			return -ENXIO;
+
+		chip = memdup_user(argp, sizeof(*chip));
+		if (IS_ERR(chip))
+			return PTR_ERR(chip);
+
+		ret = kvm_vm_ioctl_set_irqchip(kvm, chip);
+
+		kfree(chip);
+		return ret;
+	}
 #endif
 	default:
 		return -EINVAL;
diff --git a/arch/arm/kvm/interrupts_head.S b/arch/arm/kvm/interrupts_head.S
index 514a75a..8cd105c 100644
--- a/arch/arm/kvm/interrupts_head.S
+++ b/arch/arm/kvm/interrupts_head.S
@@ -232,8 +232,8 @@
 	cmp	r2, #0
 	beq	2f
 
-	/* Compute the address of struct vgic_cpu */
-	add	r11, \vcpup, #VCPU_VGIC_CPU
+	/* Compute the address of struct kvm_vgic_cpu_state */
+	add	r11, \vcpup, #VCPU_VGIC_CPU_STATE
 
 	/* Save all interesting registers */
 	ldr	r3, [r2, #GICH_HCR]
@@ -279,7 +279,7 @@
 	beq	2f
 
 	/* Compute the address of struct vgic_cpu */
-	add	r11, \vcpup, #VCPU_VGIC_CPU
+	add	r11, \vcpup, #VCPU_VGIC_CPU_STATE
 
 	/* We only restore a minimal set of registers */
 	ldr	r3, [r11, #VGIC_CPU_HCR]
diff --git a/arch/arm/kvm/vgic.c b/arch/arm/kvm/vgic.c
index 494d94d..68d0154 100644
--- a/arch/arm/kvm/vgic.c
+++ b/arch/arm/kvm/vgic.c
@@ -32,7 +32,7 @@
 /*
  * How the whole thing works (courtesy of Christoffer Dall):
  *
- * - At any time, the dist->irq_pending_on_cpu is the oracle that knows if
+ * - At any time, the dist->state.irq_pending_on_cpu is the oracle that knows if
  *   something is pending
  * - VGIC pending interrupts are stored on the vgic.irq_state vgic
  *   bitmap (this bitmap is updated by both user land ioctls and guest
@@ -41,8 +41,8 @@
  *   recalculated
  * - To calculate the oracle, we need info for each cpu from
  *   compute_pending_for_cpu, which considers:
- *   - PPI: dist->irq_state & dist->irq_enable
- *   - SPI: dist->irq_state & dist->irq_enable & dist->irq_spi_target
+ *   - PPI: dist->state.irq_state & dist->state.irq_enable
+ *   - SPI: dist->state.irq_state & dist->state.irq_enable & dist->state.irq_spi_target
  *   - irq_spi_target is a 'formatted' version of the GICD_ICFGR
  *     registers, stored on each vcpu. We only keep one bit of
  *     information per interrupt, making sure that only one vcpu can
@@ -85,13 +85,13 @@ static struct device_node *vgic_node;
 #define ACCESS_WRITE_VALUE	(3 << 1)
 #define ACCESS_WRITE_MASK(x)	((x) & (3 << 1))
 
-static void vgic_update_state(struct kvm *kvm);
+void vgic_update_state(struct kvm *kvm);
 static void vgic_kick_vcpus(struct kvm *kvm);
 static void vgic_dispatch_sgi(struct kvm_vcpu *vcpu, u32 reg);
 
 static inline int vgic_irq_is_edge(struct vgic_dist *dist, int irq)
 {
-	return vgic_bitmap_get_irq_val(&dist->irq_cfg, 0, irq);
+	return vgic_bitmap_get_irq_val(&dist->state.irq_cfg, 0, irq);
 }
 
 /**
@@ -165,11 +165,11 @@ static bool handle_mmio_misc(struct kvm_vcpu *vcpu,
 
 	switch (offset & ~3) {
 	case 0:			/* CTLR */
-		reg = vcpu->kvm->arch.vgic.enabled;
+		reg = vcpu->kvm->arch.vgic.state.enabled;
 		vgic_reg_access(mmio, &reg, u32off,
 				ACCESS_READ_VALUE | ACCESS_WRITE_VALUE);
 		if (mmio->is_write) {
-			vcpu->kvm->arch.vgic.enabled = reg & 1;
+			vcpu->kvm->arch.vgic.state.enabled = reg & 1;
 			vgic_update_state(vcpu->kvm);
 			return true;
 		}
@@ -203,7 +203,7 @@ static bool handle_mmio_raz_wi(struct kvm_vcpu *vcpu,
 static bool handle_mmio_set_enable_reg(struct kvm_vcpu *vcpu,
 				       struct kvm_exit_mmio *mmio, u32 offset)
 {
-	u32 *reg = vgic_bitmap_get_reg(&vcpu->kvm->arch.vgic.irq_enabled,
+	u32 *reg = vgic_bitmap_get_reg(&vcpu->kvm->arch.vgic.state.irq_enabled,
 				       vcpu->vcpu_id, offset);
 	vgic_reg_access(mmio, reg, offset,
 			ACCESS_READ_VALUE | ACCESS_WRITE_SETBIT);
@@ -218,7 +218,7 @@ static bool handle_mmio_set_enable_reg(struct kvm_vcpu *vcpu,
 static bool handle_mmio_clear_enable_reg(struct kvm_vcpu *vcpu,
 					 struct kvm_exit_mmio *mmio, u32 offset)
 {
-	u32 *reg = vgic_bitmap_get_reg(&vcpu->kvm->arch.vgic.irq_enabled,
+	u32 *reg = vgic_bitmap_get_reg(&vcpu->kvm->arch.vgic.state.irq_enabled,
 				       vcpu->vcpu_id, offset);
 	vgic_reg_access(mmio, reg, offset,
 			ACCESS_READ_VALUE | ACCESS_WRITE_CLEARBIT);
@@ -235,7 +235,7 @@ static bool handle_mmio_clear_enable_reg(struct kvm_vcpu *vcpu,
 static bool handle_mmio_set_pending_reg(struct kvm_vcpu *vcpu,
 					struct kvm_exit_mmio *mmio, u32 offset)
 {
-	u32 *reg = vgic_bitmap_get_reg(&vcpu->kvm->arch.vgic.irq_state,
+	u32 *reg = vgic_bitmap_get_reg(&vcpu->kvm->arch.vgic.state.irq_state,
 				       vcpu->vcpu_id, offset);
 	vgic_reg_access(mmio, reg, offset,
 			ACCESS_READ_VALUE | ACCESS_WRITE_SETBIT);
@@ -250,7 +250,7 @@ static bool handle_mmio_set_pending_reg(struct kvm_vcpu *vcpu,
 static bool handle_mmio_clear_pending_reg(struct kvm_vcpu *vcpu,
 					  struct kvm_exit_mmio *mmio, u32 offset)
 {
-	u32 *reg = vgic_bitmap_get_reg(&vcpu->kvm->arch.vgic.irq_state,
+	u32 *reg = vgic_bitmap_get_reg(&vcpu->kvm->arch.vgic.state.irq_state,
 				       vcpu->vcpu_id, offset);
 	vgic_reg_access(mmio, reg, offset,
 			ACCESS_READ_VALUE | ACCESS_WRITE_CLEARBIT);
@@ -265,7 +265,7 @@ static bool handle_mmio_clear_pending_reg(struct kvm_vcpu *vcpu,
 static bool handle_mmio_priority_reg(struct kvm_vcpu *vcpu,
 				     struct kvm_exit_mmio *mmio, u32 offset)
 {
-	u32 *reg = vgic_bytemap_get_reg(&vcpu->kvm->arch.vgic.irq_priority,
+	u32 *reg = vgic_bytemap_get_reg(&vcpu->kvm->arch.vgic.state.irq_priority,
 					vcpu->vcpu_id, offset);
 	vgic_reg_access(mmio, reg, offset,
 			ACCESS_READ_VALUE | ACCESS_WRITE_VALUE);
@@ -286,7 +286,7 @@ static u32 vgic_get_target_reg(struct kvm *kvm, int irq)
 	irq -= 32;
 
 	kvm_for_each_vcpu(c, vcpu, kvm) {
-		bmap = vgic_bitmap_get_shared_map(&dist->irq_spi_target[c]);
+		bmap = vgic_bitmap_get_shared_map(&dist->state.irq_spi_target[c]);
 		for (i = 0; i < 4; i++)
 			if (test_bit(irq + i, bmap))
 				val |= 1 << (c + i * 8);
@@ -317,9 +317,9 @@ static void vgic_set_target_reg(struct kvm *kvm, u32 val, int irq)
 		int shift = i * 8;
 		target = ffs((val >> shift) & 0xffU);
 		target = target ? (target - 1) : 0;
-		dist->irq_spi_cpu[irq + i] = target;
+		dist->state.irq_spi_cpu[irq + i] = target;
 		kvm_for_each_vcpu(c, vcpu, kvm) {
-			bmap = vgic_bitmap_get_shared_map(&dist->irq_spi_target[c]);
+			bmap = vgic_bitmap_get_shared_map(&dist->state.irq_spi_target[c]);
 			if (c == target)
 				set_bit(irq + i, bmap);
 			else
@@ -387,7 +387,7 @@ static bool handle_mmio_cfg_reg(struct kvm_vcpu *vcpu,
 				struct kvm_exit_mmio *mmio, u32 offset)
 {
 	u32 val;
-	u32 *reg = vgic_bitmap_get_reg(&vcpu->kvm->arch.vgic.irq_cfg,
+	u32 *reg = vgic_bitmap_get_reg(&vcpu->kvm->arch.vgic.state.irq_cfg,
 				       vcpu->vcpu_id, offset >> 1);
 	if (offset & 2)
 		val = *reg >> 16;
@@ -591,8 +591,8 @@ static void vgic_dispatch_sgi(struct kvm_vcpu *vcpu, u32 reg)
 	kvm_for_each_vcpu(c, vcpu, kvm) {
 		if (target_cpus & 1) {
 			/* Flag the SGI as pending */
-			vgic_bitmap_set_irq_val(&dist->irq_state, c, sgi, 1);
-			dist->irq_sgi_sources[c][sgi] |= 1 << vcpu_id;
+			vgic_bitmap_set_irq_val(&dist->state.irq_state, c, sgi, 1);
+			dist->state.irq_sgi_sources[c][sgi] |= 1 << vcpu_id;
 			kvm_debug("SGI%d from CPU%d to CPU%d\n", sgi, vcpu_id, c);
 		}
 
@@ -609,15 +609,15 @@ static int compute_pending_for_cpu(struct kvm_vcpu *vcpu)
 	vcpu_id = vcpu->vcpu_id;
 	pend = vcpu->arch.vgic_cpu.pending;
 
-	pending = vgic_bitmap_get_cpu_map(&dist->irq_state, vcpu_id);
-	enabled = vgic_bitmap_get_cpu_map(&dist->irq_enabled, vcpu_id);
+	pending = vgic_bitmap_get_cpu_map(&dist->state.irq_state, vcpu_id);
+	enabled = vgic_bitmap_get_cpu_map(&dist->state.irq_enabled, vcpu_id);
 	bitmap_and(pend, pending, enabled, 32);
 
-	pending = vgic_bitmap_get_shared_map(&dist->irq_state);
-	enabled = vgic_bitmap_get_shared_map(&dist->irq_enabled);
+	pending = vgic_bitmap_get_shared_map(&dist->state.irq_state);
+	enabled = vgic_bitmap_get_shared_map(&dist->state.irq_enabled);
 	bitmap_and(pend + 1, pending, enabled, VGIC_NR_SHARED_IRQS);
 	bitmap_and(pend + 1, pend + 1,
-		   vgic_bitmap_get_shared_map(&dist->irq_spi_target[vcpu_id]),
+		   vgic_bitmap_get_shared_map(&dist->state.irq_spi_target[vcpu_id]),
 		   VGIC_NR_SHARED_IRQS);
 
 	return (find_first_bit(pend, VGIC_NR_IRQS) < VGIC_NR_IRQS);
@@ -627,21 +627,21 @@ static int compute_pending_for_cpu(struct kvm_vcpu *vcpu)
  * Update the interrupt state and determine which CPUs have pending
  * interrupts. Must be called with distributor lock held.
  */
-static void vgic_update_state(struct kvm *kvm)
+void vgic_update_state(struct kvm *kvm)
 {
 	struct vgic_dist *dist = &kvm->arch.vgic;
 	struct kvm_vcpu *vcpu;
 	int c;
 
-	if (!dist->enabled) {
-		set_bit(0, &dist->irq_pending_on_cpu);
+	if (!dist->state.enabled) {
+		set_bit(0, &dist->state.irq_pending_on_cpu);
 		return;
 	}
 
 	kvm_for_each_vcpu(c, vcpu, kvm) {
 		if (compute_pending_for_cpu(vcpu)) {
 			pr_debug("CPU%d has pending interrupts\n", c);
-			set_bit(c, &dist->irq_pending_on_cpu);
+			set_bit(c, &dist->state.irq_pending_on_cpu);
 		}
 	}
 }
@@ -670,32 +670,32 @@ static bool vgic_queue_irq(struct kvm_vcpu *vcpu, u8 sgi_source_id, int irq)
 
 	/* Do we have an active interrupt for the same CPUID? */
 	if (lr != LR_EMPTY &&
-	    (LR_PHYSID(vgic_cpu->vgic_lr[lr]) == sgi_source_id)) {
-		kvm_debug("LR%d piggyback for IRQ%d %x\n", lr, irq, vgic_cpu->vgic_lr[lr]);
+	    (LR_PHYSID(vgic_cpu->state.vgic_lr[lr]) == sgi_source_id)) {
+		kvm_debug("LR%d piggyback for IRQ%d %x\n", lr, irq, vgic_cpu->state.vgic_lr[lr]);
 		BUG_ON(!test_bit(lr, vgic_cpu->lr_used));
-		vgic_cpu->vgic_lr[lr] |= VGIC_LR_PENDING_BIT;
+		vgic_cpu->state.vgic_lr[lr] |= VGIC_LR_PENDING_BIT;
 		if (is_level) {
-			vgic_cpu->vgic_lr[lr] |= VGIC_LR_EOI;
+			vgic_cpu->state.vgic_lr[lr] |= VGIC_LR_EOI;
 			atomic_inc(&vgic_cpu->irq_active_count);
 		}
 		return true;
 	}
 
 	/* Try to use another LR for this interrupt */
-	lr = find_first_bit((unsigned long *)vgic_cpu->vgic_elrsr,
+	lr = find_first_bit((unsigned long *)vgic_cpu->state.vgic_elrsr,
 			       vgic_cpu->nr_lr);
 	if (lr >= vgic_cpu->nr_lr)
 		return false;
 
 	kvm_debug("LR%d allocated for IRQ%d %x\n", lr, irq, sgi_source_id);
-	vgic_cpu->vgic_lr[lr] = MK_LR_PEND(sgi_source_id, irq);
+	vgic_cpu->state.vgic_lr[lr] = MK_LR_PEND(sgi_source_id, irq);
 	if (is_level) {
-		vgic_cpu->vgic_lr[lr] |= VGIC_LR_EOI;
+		vgic_cpu->state.vgic_lr[lr] |= VGIC_LR_EOI;
 		atomic_inc(&vgic_cpu->irq_active_count);
 	}
 
 	vgic_cpu->vgic_irq_lr_map[irq] = lr;
-	clear_bit(lr, (unsigned long *)vgic_cpu->vgic_elrsr);
+	clear_bit(lr, (unsigned long *)vgic_cpu->state.vgic_elrsr);
 	set_bit(lr, vgic_cpu->lr_used);
 
 	return true;
@@ -726,11 +726,11 @@ static void __kvm_vgic_sync_to_cpu(struct kvm_vcpu *vcpu)
 	}
 
 	/* SGIs */
-	pending = vgic_bitmap_get_cpu_map(&dist->irq_state, vcpu_id);
+	pending = vgic_bitmap_get_cpu_map(&dist->state.irq_state, vcpu_id);
 	for_each_set_bit(i, vgic_cpu->pending, 16) {
 		unsigned long sources;
 
-		sources = dist->irq_sgi_sources[vcpu_id][i];
+		sources = dist->state.irq_sgi_sources[vcpu_id][i];
 		for_each_set_bit(c, &sources, 8) {
 			if (!vgic_queue_irq(vcpu, c, i)) {
 				overflow = 1;
@@ -743,7 +743,7 @@ static void __kvm_vgic_sync_to_cpu(struct kvm_vcpu *vcpu)
 		if (!sources)
 			clear_bit(i, pending);
 
-		dist->irq_sgi_sources[vcpu_id][i] = sources;
+		dist->state.irq_sgi_sources[vcpu_id][i] = sources;
 	}
 
 	/* PPIs */
@@ -758,9 +758,9 @@ static void __kvm_vgic_sync_to_cpu(struct kvm_vcpu *vcpu)
 
 
 	/* SPIs */
-	pending = vgic_bitmap_get_shared_map(&dist->irq_state);
+	pending = vgic_bitmap_get_shared_map(&dist->state.irq_state);
 	for_each_set_bit_from(i, vgic_cpu->pending, VGIC_NR_IRQS) {
-		if (vgic_bitmap_get_irq_val(&dist->irq_active, 0, i))
+		if (vgic_bitmap_get_irq_val(&dist->state.irq_active, 0, i))
 			continue; /* level interrupt, already queued */
 
 		if (!vgic_queue_irq(vcpu, 0, i)) {
@@ -772,21 +772,21 @@ static void __kvm_vgic_sync_to_cpu(struct kvm_vcpu *vcpu)
 		if (vgic_irq_is_edge(dist, i))
 			clear_bit(i - 32, pending);
 		else
-			vgic_bitmap_set_irq_val(&dist->irq_active, 0, i, 1);
+			vgic_bitmap_set_irq_val(&dist->state.irq_active, 0, i, 1);
 	}
 
 epilog:
 	if (overflow)
-		vgic_cpu->vgic_hcr |= VGIC_HCR_UIE;
+		vgic_cpu->state.vgic_hcr |= VGIC_HCR_UIE;
 	else {
-		vgic_cpu->vgic_hcr &= ~VGIC_HCR_UIE;
+		vgic_cpu->state.vgic_hcr &= ~VGIC_HCR_UIE;
 		/*
 		 * We're about to run this VCPU, and we've consumed
 		 * everything the distributor had in store for
 		 * us. Claim we don't have anything pending. We'll
 		 * adjust that if needed while exiting.
 		 */
-		clear_bit(vcpu_id, &dist->irq_pending_on_cpu);
+		clear_bit(vcpu_id, &dist->state.irq_pending_on_cpu);
 	}
 }
 
@@ -816,10 +816,10 @@ static void __kvm_vgic_sync_from_cpu(struct kvm_vcpu *vcpu)
 	}
 
 	/* Check if we still have something up our sleeve... */
-	pending = find_first_zero_bit((unsigned long *)vgic_cpu->vgic_elrsr,
+	pending = find_first_zero_bit((unsigned long *)vgic_cpu->state.vgic_elrsr,
 				      vgic_cpu->nr_lr);
 	if (pending < vgic_cpu->nr_lr) {
-		set_bit(vcpu->vcpu_id, &dist->irq_pending_on_cpu);
+		set_bit(vcpu->vcpu_id, &dist->state.irq_pending_on_cpu);
 		smp_mb();
 	}
 }
@@ -851,7 +851,7 @@ int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu)
 	if (!irqchip_in_kernel(vcpu->kvm))
 		return 0;
 
-	return test_bit(vcpu->vcpu_id, &dist->irq_pending_on_cpu);
+	return test_bit(vcpu->vcpu_id, &dist->state.irq_pending_on_cpu);
 }
 
 static void vgic_kick_vcpus(struct kvm *kvm)
@@ -881,7 +881,7 @@ static bool vgic_update_irq_state(struct kvm *kvm, int cpuid,
 
 	is_edge = vgic_irq_is_edge(dist, irq_num);
 	is_level = !is_edge;
-	state = vgic_bitmap_get_irq_val(&dist->irq_state, cpuid, irq_num);
+	state = vgic_bitmap_get_irq_val(&dist->state.irq_state, cpuid, irq_num);
 
 	/*
 	 * Only inject an interrupt if:
@@ -893,14 +893,14 @@ static bool vgic_update_irq_state(struct kvm *kvm, int cpuid,
 		return false;
 	}
 
-	vgic_bitmap_set_irq_val(&dist->irq_state, cpuid, irq_num, level);
+	vgic_bitmap_set_irq_val(&dist->state.irq_state, cpuid, irq_num, level);
 
-	enabled = vgic_bitmap_get_irq_val(&dist->irq_enabled, cpuid, irq_num);
+	enabled = vgic_bitmap_get_irq_val(&dist->state.irq_enabled, cpuid, irq_num);
 	pend = level && enabled;
 
 	if (irq_num >= 32) {
-		cpuid = dist->irq_spi_cpu[irq_num - 32];
-		pend &= vgic_bitmap_get_irq_val(&dist->irq_spi_target[cpuid],
+		cpuid = dist->state.irq_spi_cpu[irq_num - 32];
+		pend &= vgic_bitmap_get_irq_val(&dist->state.irq_spi_target[cpuid],
 						0, irq_num);
 	}
 
@@ -909,7 +909,7 @@ static bool vgic_update_irq_state(struct kvm *kvm, int cpuid,
 	vcpu = kvm_get_vcpu(kvm, cpuid);
 	if (pend) {
 		set_bit(irq_num, vcpu->arch.vgic_cpu.pending);
-		set_bit(cpuid, &dist->irq_pending_on_cpu);
+		set_bit(cpuid, &dist->state.irq_pending_on_cpu);
 	} else
 		clear_bit(irq_num, vcpu->arch.vgic_cpu.pending);
 
@@ -939,7 +939,7 @@ static irqreturn_t vgic_maintenance_handler(int irq, void *data)
 
 	vgic_cpu = &vcpu->arch.vgic_cpu;
 	dist = &vcpu->kvm->arch.vgic;
-	kvm_debug("MISR = %08x\n", vgic_cpu->vgic_misr);
+	kvm_debug("MISR = %08x\n", vgic_cpu->state.vgic_misr);
 
 	/*
 	 * We do not need to take the distributor lock here, since the only
@@ -954,30 +954,30 @@ static irqreturn_t vgic_maintenance_handler(int irq, void *data)
 	 *   this interrupt for this run. Big deal. It is still pending though,
 	 *   and will get considered when this vcpu exits.
 	 */
-	if (vgic_cpu->vgic_misr & VGIC_MISR_EOI) {
+	if (vgic_cpu->state.vgic_misr & VGIC_MISR_EOI) {
 		/*
 		 * Some level interrupts have been EOIed. Clear their
 		 * active bit.
 		 */
 		int lr, irq;
 
-		for_each_set_bit(lr, (unsigned long *)vgic_cpu->vgic_eisr,
+		for_each_set_bit(lr, (unsigned long *)vgic_cpu->state.vgic_eisr,
 				 vgic_cpu->nr_lr) {
-			irq = vgic_cpu->vgic_lr[lr] & VGIC_LR_VIRTUALID;
+			irq = vgic_cpu->state.vgic_lr[lr] & VGIC_LR_VIRTUALID;
 
-			vgic_bitmap_set_irq_val(&dist->irq_active,
+			vgic_bitmap_set_irq_val(&dist->state.irq_active,
 						vcpu->vcpu_id, irq, 0);
 			atomic_dec(&vgic_cpu->irq_active_count);
 			smp_mb();
-			vgic_cpu->vgic_lr[lr] &= ~VGIC_LR_EOI;
-			writel_relaxed(vgic_cpu->vgic_lr[lr],
+			vgic_cpu->state.vgic_lr[lr] &= ~VGIC_LR_EOI;
+			writel_relaxed(vgic_cpu->state.vgic_lr[lr],
 				       dist->vctrl_base + GICH_LR0 + (lr << 2));
 		}
 	}
 
-	if (vgic_cpu->vgic_misr & VGIC_MISR_U) {
-		vgic_cpu->vgic_hcr &= ~VGIC_HCR_UIE;
-		writel_relaxed(vgic_cpu->vgic_hcr, dist->vctrl_base + GICH_HCR);
+	if (vgic_cpu->state.vgic_misr & VGIC_MISR_U) {
+		vgic_cpu->state.vgic_hcr &= ~VGIC_HCR_UIE;
+		writel_relaxed(vgic_cpu->state.vgic_hcr, dist->vctrl_base + GICH_HCR);
 	}
 
 	return IRQ_HANDLED;
@@ -995,10 +995,10 @@ void kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu)
 
 	for (i = 0; i < VGIC_NR_IRQS; i++) {
 		if (i < 16)
-			vgic_bitmap_set_irq_val(&dist->irq_enabled,
+			vgic_bitmap_set_irq_val(&dist->state.irq_enabled,
 						vcpu->vcpu_id, i, 1);
 		if (i < 32)
-			vgic_bitmap_set_irq_val(&dist->irq_cfg,
+			vgic_bitmap_set_irq_val(&dist->state.irq_cfg,
 						vcpu->vcpu_id, i, 1);
 
 		vgic_cpu->vgic_irq_lr_map[i] = LR_EMPTY;
@@ -1009,9 +1009,9 @@ void kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu)
 	vgic_cpu->nr_lr = (reg & 0x1f) + 1;
 
 	reg = readl_relaxed(vcpu->kvm->arch.vgic.vctrl_base + GICH_VMCR);
-	vgic_cpu->vgic_vmcr = reg | (0x1f << 27); /* Priority */
+	vgic_cpu->state.vgic_vmcr = reg | (0x1f << 27); /* Priority */
 
-	vgic_cpu->vgic_hcr |= VGIC_HCR_EN; /* Get the show on the road... */
+	vgic_cpu->state.vgic_hcr |= VGIC_HCR_EN; /* Get the show on the road... */
 }
 
 static void vgic_init_maintenance_interrupt(void *info)
diff --git a/include/linux/kvm.h b/include/linux/kvm.h
index 8091b1d..f3e7234 100644
--- a/include/linux/kvm.h
+++ b/include/linux/kvm.h
@@ -136,6 +136,9 @@ struct kvm_irqchip {
 #ifdef __KVM_HAVE_IOAPIC
 		struct kvm_ioapic_state ioapic;
 #endif
+#ifdef __KVM_HAVE_VIGC
+		struct kvm_vgic_state vgic;
+#endif
 	} chip;
 };
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 4079193..914357e 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -24,13 +24,12 @@
 #include <linux/err.h>
 #include <asm/signal.h>
 
+#include <asm/kvm_host.h>
 #include <linux/kvm.h>
 #include <linux/kvm_para.h>
 
 #include <linux/kvm_types.h>
 
-#include <asm/kvm_host.h>
-
 #ifndef KVM_MMIO_SIZE
 #define KVM_MMIO_SIZE 8
 #endif
-- 
1.7.5.4
