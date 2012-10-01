From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Mon, 01 Oct 2012 05:10:49 -0400
Subject: [PATCH v2 07/14] KVM: ARM: Inject IRQs and FIQs from userspace
In-Reply-To: <20121001090945.49198.68950.stgit@ubuntu>
References: <20121001090945.49198.68950.stgit@ubuntu>
Message-ID: <20121001091049.49198.29650.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoffer Dall <cdall@cs.columbia.edu>

All interrupt injection is now based on the VM ioctl KVM_IRQ_LINE.  This
works semantically well for the GIC as we in fact raise/lower a line on
a machine component (the gic).  The IOCTL uses the follwing struct.

struct kvm_irq_level {
	union {
		__u32 irq;     /* GSI */
		__s32 status;  /* not used for KVM_IRQ_LEVEL */
	};
	__u32 level;           /* 0 or 1 */
};

ARM can signal an interrupt either at the CPU level, or at the in-kernel irqchip
(GIC), and for in-kernel irqchip can tell the GIC to use PPIs designated for
specific cpus.  The irq field is interpreted like this:

 ?bits:  | 31 ... 24 | 23  ... 16 | 15    ...    0 |
  field: | irq_type  | vcpu_index |   irq_number   |

The irq_type field has the following values:
- irq_type[0]: out-of-kernel GIC: irq_number 0 is IRQ, irq_number 1 is FIQ
- irq_type[1]: in-kernel GIC: SPI, irq_number between 32 and 1019 (incl.)
               (the vcpu_index field is ignored)
- irq_type[2]: in-kernel GIC: PPI, irq_number between 16 and 31 (incl.)

The irq_number thus corresponds to the irq ID in as in the GICv2 specs.

This is documented in Documentation/kvm/api.txt.

Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 Documentation/virtual/kvm/api.txt |   25 +++++++++++--
 arch/arm/include/asm/kvm.h        |   21 +++++++++++
 arch/arm/include/asm/kvm_arm.h    |    1 +
 arch/arm/kvm/arm.c                |   70 +++++++++++++++++++++++++++++++++++++
 arch/arm/kvm/trace.h              |   25 +++++++++++++
 include/linux/kvm.h               |    1 +
 6 files changed, 139 insertions(+), 4 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 599b1e7..fd1c1bc 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -615,15 +615,32 @@ created.
 4.25 KVM_IRQ_LINE
 
 Capability: KVM_CAP_IRQCHIP
-Architectures: x86, ia64
+Architectures: x86, ia64, arm
 Type: vm ioctl
 Parameters: struct kvm_irq_level
 Returns: 0 on success, -1 on error
 
 Sets the level of a GSI input to the interrupt controller model in the kernel.
-Requires that an interrupt controller model has been previously created with
-KVM_CREATE_IRQCHIP.  Note that edge-triggered interrupts require the level
-to be set to 1 and then back to 0.
+On some architectures it is required that an interrupt controller model has
+been previously created with KVM_CREATE_IRQCHIP.  Note that edge-triggered
+interrupts require the level to be set to 1 and then back to 0.
+
+ARM can signal an interrupt either at the CPU level, or at the in-kernel irqchip
+(GIC), and for in-kernel irqchip can tell the GIC to use PPIs designated for
+specific cpus.  The irq field is interpreted like this:
+
+ ?bits:  | 31 ... 24 | 23  ... 16 | 15    ...    0 |
+  field: | irq_type  | vcpu_index |     irq_id     |
+
+The irq_type field has the following values:
+- irq_type[0]: out-of-kernel GIC: irq_id 0 is IRQ, irq_id 1 is FIQ
+- irq_type[1]: in-kernel GIC: SPI, irq_id between 32 and 1019 (incl.)
+               (the vcpu_index field is ignored)
+- irq_type[2]: in-kernel GIC: PPI, irq_id between 16 and 31 (incl.)
+
+(The irq_id field thus corresponds nicely to the IRQ ID in the ARM GIC specs)
+
+In both cases, level is used to raise/lower the line.
 
 struct kvm_irq_level {
 	union {
diff --git a/arch/arm/include/asm/kvm.h b/arch/arm/include/asm/kvm.h
index 5918afe..eb5f528 100644
--- a/arch/arm/include/asm/kvm.h
+++ b/arch/arm/include/asm/kvm.h
@@ -22,6 +22,7 @@
 #include <asm/types.h>
 
 #define __KVM_HAVE_GUEST_DEBUG
+#define __KVM_HAVE_IRQ_LINE
 
 #define KVM_REG_SIZE(id)						\
 	(1U << (((id) & KVM_REG_SIZE_MASK) >> KVM_REG_SIZE_SHIFT))
@@ -86,4 +87,24 @@ struct kvm_reg_list {
 #define KVM_REG_ARM_CORE		(0x0010 << KVM_REG_ARM_COPROC_SHIFT)
 #define KVM_REG_ARM_CORE_REG(name)	(offsetof(struct kvm_regs, name) / 4)
 
+/* KVM_IRQ_LINE irq field index values */
+#define KVM_ARM_IRQ_TYPE_SHIFT		24
+#define KVM_ARM_IRQ_TYPE_MASK		0xff
+#define KVM_ARM_IRQ_VCPU_SHIFT		16
+#define KVM_ARM_IRQ_VCPU_MASK		0xff
+#define KVM_ARM_IRQ_NUM_SHIFT		0
+#define KVM_ARM_IRQ_NUM_MASK		0xffff
+
+/* irq_type field */
+#define KVM_ARM_IRQ_TYPE_CPU		0
+#define KVM_ARM_IRQ_TYPE_SPI		1
+#define KVM_ARM_IRQ_TYPE_PPI		2
+
+/* out-of-kernel GIC cpu interrupt injection irq_number field */
+#define KVM_ARM_IRQ_CPU_IRQ		0
+#define KVM_ARM_IRQ_CPU_FIQ		1
+
+/* Highest supported SPI, from VGIC_NR_IRQS */
+#define KVM_ARM_IRQ_GIC_MAX		127
+
 #endif /* __ARM_KVM_H__ */
diff --git a/arch/arm/include/asm/kvm_arm.h b/arch/arm/include/asm/kvm_arm.h
index f6e8f6f..4f54cda 100644
--- a/arch/arm/include/asm/kvm_arm.h
+++ b/arch/arm/include/asm/kvm_arm.h
@@ -68,6 +68,7 @@
 #define HCR_GUEST_MASK (HCR_TSC | HCR_TSW | HCR_TWI | HCR_VM | HCR_BSU_IS | \
 			HCR_FB | HCR_TAC | HCR_AMO | HCR_IMO | HCR_FMO | \
 			HCR_SWIO | HCR_TIDCP)
+#define HCR_VIRT_EXCP_MASK (HCR_VA | HCR_VI | HCR_VF)
 
 /* Hyp System Control Register (HSCTLR) bits */
 #define HSCTLR_TE	(1 << 30)
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 5ac3132..15e2ab1 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -24,6 +24,7 @@
 #include <linux/fs.h>
 #include <linux/mman.h>
 #include <linux/sched.h>
+#include <linux/kvm.h>
 #include <trace/events/kvm.h>
 
 #define CREATE_TRACE_POINTS
@@ -272,6 +273,7 @@ void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu)
 
 void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
+	vcpu->cpu = cpu;
 }
 
 void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
@@ -312,6 +314,74 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	return -EINVAL;
 }
 
+static int vcpu_interrupt_line(struct kvm_vcpu *vcpu, int number, bool level)
+{
+	int bit_index;
+	bool set;
+	unsigned long *ptr;
+
+	if (number == KVM_ARM_IRQ_CPU_IRQ)
+		bit_index = __ffs(HCR_VI);
+	else /* KVM_ARM_IRQ_CPU_FIQ */
+		bit_index = __ffs(HCR_VF);
+
+	ptr = (unsigned long *)&vcpu->arch.irq_lines;
+	if (level)
+		set = test_and_set_bit(bit_index, ptr);
+	else
+		set = test_and_clear_bit(bit_index, ptr);
+
+	/*
+	 * If we didn't change anything, no need to wake up or kick other CPUs
+	 */
+	if (set == level)
+		return 0;
+
+	/*
+	 * The vcpu irq_lines field was updated, wake up sleeping VCPUs and
+	 * trigger a world-switch round on the running physical CPU to set the
+	 * virtual IRQ/FIQ fields in the HCR appropriately.
+	 */
+	kvm_vcpu_kick(vcpu);
+
+	return 0;
+}
+
+int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irq_level)
+{
+	u32 irq = irq_level->irq;
+	unsigned int irq_type, vcpu_idx, irq_num;
+	int nrcpus = atomic_read(&kvm->online_vcpus);
+	struct kvm_vcpu *vcpu = NULL;
+	bool level = irq_level->level;
+
+	irq_type = (irq >> KVM_ARM_IRQ_TYPE_SHIFT) & KVM_ARM_IRQ_TYPE_MASK;
+	vcpu_idx = (irq >> KVM_ARM_IRQ_VCPU_SHIFT) & KVM_ARM_IRQ_VCPU_MASK;
+	irq_num = (irq >> KVM_ARM_IRQ_NUM_SHIFT) & KVM_ARM_IRQ_NUM_MASK;
+
+	trace_kvm_irq_line(irq_type, vcpu_idx, irq_num, irq_level->level);
+
+	if (irq_type == KVM_ARM_IRQ_TYPE_CPU ||
+	    irq_type == KVM_ARM_IRQ_TYPE_PPI) {
+		if (vcpu_idx >= nrcpus)
+			return -EINVAL;
+
+		vcpu = kvm_get_vcpu(kvm, vcpu_idx);
+		if (!vcpu)
+			return -EINVAL;
+	}
+
+	switch (irq_type) {
+	case KVM_ARM_IRQ_TYPE_CPU:
+		if (irq_num > KVM_ARM_IRQ_CPU_FIQ)
+			return -EINVAL;
+
+		return vcpu_interrupt_line(vcpu, irq_num, level);
+	}
+
+	return -EINVAL;
+}
+
 long kvm_arch_vcpu_ioctl(struct file *filp,
 			 unsigned int ioctl, unsigned long arg)
 {
diff --git a/arch/arm/kvm/trace.h b/arch/arm/kvm/trace.h
index 862b2cc..105d1f7 100644
--- a/arch/arm/kvm/trace.h
+++ b/arch/arm/kvm/trace.h
@@ -39,6 +39,31 @@ TRACE_EVENT(kvm_exit,
 	TP_printk("PC: 0x%08lx", __entry->vcpu_pc)
 );
 
+TRACE_EVENT(kvm_irq_line,
+	TP_PROTO(unsigned int type, int vcpu_idx, int irq_num, int level),
+	TP_ARGS(type, vcpu_idx, irq_num, level),
+
+	TP_STRUCT__entry(
+		__field(	unsigned int,	type		)
+		__field(	int,		vcpu_idx	)
+		__field(	int,		irq_num		)
+		__field(	int,		level		)
+	),
+
+	TP_fast_assign(
+		__entry->type		= type;
+		__entry->vcpu_idx	= vcpu_idx;
+		__entry->irq_num	= irq_num;
+		__entry->level		= level;
+	),
+
+	TP_printk("Inject %s interrupt (%d), vcpu->idx: %d, num: %d, level: %d",
+		  (__entry->type == KVM_ARM_IRQ_TYPE_CPU) ? "CPU" :
+		  (__entry->type == KVM_ARM_IRQ_TYPE_PPI) ? "VGIC PPI" :
+		  (__entry->type == KVM_ARM_IRQ_TYPE_SPI) ? "VGIC SPI" : "UNKNOWN",
+		  __entry->type, __entry->vcpu_idx, __entry->irq_num, __entry->level)
+);
+
 TRACE_EVENT(kvm_unmap_hva,
 	TP_PROTO(unsigned long hva),
 	TP_ARGS(hva),
diff --git a/include/linux/kvm.h b/include/linux/kvm.h
index a960f66..8091b1d 100644
--- a/include/linux/kvm.h
+++ b/include/linux/kvm.h
@@ -115,6 +115,7 @@ struct kvm_irq_level {
 	 * ACPI gsi notion of irq.
 	 * For IA-64 (APIC model) IOAPIC0: irq 0-23; IOAPIC1: irq 24-47..
 	 * For X86 (standard AT mode) PIC0/1: irq 0-15. IOAPIC0: 0-23..
+	 * For ARM: IRQ: irq = (2*vcpu_index). FIQ: irq = (2*vcpu_indx + 1).
 	 */
 	union {
 		__u32 irq;
