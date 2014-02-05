From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  5 Feb 2014 13:30:47 +0000
Subject: [PATCH 15/18] arm64: KVM: split GICv2 world switch from hyp code
In-Reply-To: <1391607050-540-1-git-send-email-marc.zyngier@arm.com>
References: <1391607050-540-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1391607050-540-16-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the GICv2 world switch code into its own file, and add the
necessary indirection to the arm64 switch code.

Also introduce a new type field to the vgic_params structure.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_host.h   |   5 ++
 arch/arm64/include/asm/kvm_asm.h  |   8 +++
 arch/arm64/include/asm/kvm_host.h |  16 +++++
 arch/arm64/kvm/Makefile           |   4 +-
 arch/arm64/kvm/hyp.S              | 119 +++++---------------------------
 arch/arm64/kvm/vgic-v2-switch.S   | 141 ++++++++++++++++++++++++++++++++++++++
 include/kvm/arm_vgic.h            |   7 +-
 virt/kvm/arm/vgic-v2.c            |  15 ++--
 virt/kvm/arm/vgic.c               |   3 +
 9 files changed, 208 insertions(+), 110 deletions(-)
 create mode 100644 arch/arm64/kvm/vgic-v2-switch.S

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 098f7dd..228ae1c 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -222,6 +222,11 @@ static inline int kvm_arch_dev_ioctl_check_extension(long ext)
 	return 0;
 }
 
+static inline void vgic_arch_setup(const struct vgic_params *vgic)
+{
+	BUG_ON(vgic->type != VGIC_V2);
+}
+
 int kvm_perf_init(void);
 int kvm_perf_teardown(void);
 
diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index dddb345..e5fbdce 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -104,6 +104,14 @@ extern void __kvm_flush_vm_context(void);
 extern void __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa);
 
 extern int __kvm_vcpu_run(struct kvm_vcpu *vcpu);
+
+/*
+ * These are really code, but as they do not use the PCS we don't
+ * describe them as functions...
+ */
+extern char __save_vgic_v2_state[];
+extern char __restore_vgic_v2_state[];
+
 #endif
 
 #endif /* __ARM_KVM_ASM_H__ */
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 0a1d697..b562d67 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -200,4 +200,20 @@ static inline void __cpu_init_hyp_mode(phys_addr_t boot_pgd_ptr,
 		     hyp_stack_ptr, vector_ptr);
 }
 
+static inline void vgic_arch_setup(const struct vgic_params *vgic)
+{
+	extern char *__vgic_sr_vectors[2];
+
+	switch(vgic->type)
+	{
+	case VGIC_V2:
+		__vgic_sr_vectors[0] = __save_vgic_v2_state;
+		__vgic_sr_vectors[1] = __restore_vgic_v2_state;
+		break;
+
+	default:
+		BUG();
+	}
+}
+
 #endif /* __ARM64_KVM_HOST_H__ */
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index 7e92952..daf24dc 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -19,5 +19,7 @@ kvm-$(CONFIG_KVM_ARM_HOST) += emulate.o inject_fault.o regmap.o
 kvm-$(CONFIG_KVM_ARM_HOST) += hyp.o hyp-init.o handle_exit.o
 kvm-$(CONFIG_KVM_ARM_HOST) += guest.o reset.o sys_regs.o sys_regs_generic_v8.o
 
-kvm-$(CONFIG_KVM_ARM_VGIC) += $(KVM)/arm/vgic.o $(KVM)/arm/vgic-v2.o
+kvm-$(CONFIG_KVM_ARM_VGIC) += $(KVM)/arm/vgic.o
+kvm-$(CONFIG_KVM_ARM_VGIC) += $(KVM)/arm/vgic-v2.o
+kvm-$(CONFIG_KVM_ARM_VGIC) += vgic-v2-switch.o
 kvm-$(CONFIG_KVM_ARM_TIMER) += $(KVM)/arm/arch_timer.o
diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
index b57f286..5a868c0 100644
--- a/arch/arm64/kvm/hyp.S
+++ b/arch/arm64/kvm/hyp.S
@@ -16,7 +16,6 @@
  */
 
 #include <linux/linkage.h>
-#include <linux/irqchip/arm-gic.h>
 
 #include <asm/assembler.h>
 #include <asm/memory.h>
@@ -375,103 +374,6 @@
 	msr	vttbr_el2, xzr
 .endm
 
-/*
- * Save the VGIC CPU state into memory
- * x0: Register pointing to VCPU struct
- * Do not corrupt x1!!!
- */
-.macro save_vgic_state
-	/* Get VGIC VCTRL base into x2 */
-	ldr	x2, [x0, #VCPU_KVM]
-	kern_hyp_va	x2
-	ldr	x2, [x2, #KVM_VGIC_VCTRL]
-	kern_hyp_va	x2
-	cbz	x2, 2f		// disabled
-
-	/* Compute the address of struct vgic_cpu */
-	add	x3, x0, #VCPU_VGIC_CPU
-
-	/* Save all interesting registers */
-	ldr	w4, [x2, #GICH_HCR]
-	ldr	w5, [x2, #GICH_VMCR]
-	ldr	w6, [x2, #GICH_MISR]
-	ldr	w7, [x2, #GICH_EISR0]
-	ldr	w8, [x2, #GICH_EISR1]
-	ldr	w9, [x2, #GICH_ELRSR0]
-	ldr	w10, [x2, #GICH_ELRSR1]
-	ldr	w11, [x2, #GICH_APR]
-CPU_BE(	rev	w4,  w4  )
-CPU_BE(	rev	w5,  w5  )
-CPU_BE(	rev	w6,  w6  )
-CPU_BE(	rev	w7,  w7  )
-CPU_BE(	rev	w8,  w8  )
-CPU_BE(	rev	w9,  w9  )
-CPU_BE(	rev	w10, w10 )
-CPU_BE(	rev	w11, w11 )
-
-	str	w4, [x3, #VGIC_V2_CPU_HCR]
-	str	w5, [x3, #VGIC_V2_CPU_VMCR]
-	str	w6, [x3, #VGIC_V2_CPU_MISR]
-	str	w7, [x3, #VGIC_V2_CPU_EISR]
-	str	w8, [x3, #(VGIC_V2_CPU_EISR + 4)]
-	str	w9, [x3, #VGIC_V2_CPU_ELRSR]
-	str	w10, [x3, #(VGIC_V2_CPU_ELRSR + 4)]
-	str	w11, [x3, #VGIC_V2_CPU_APR]
-
-	/* Clear GICH_HCR */
-	str	wzr, [x2, #GICH_HCR]
-
-	/* Save list registers */
-	add	x2, x2, #GICH_LR0
-	ldr	w4, [x3, #VGIC_CPU_NR_LR]
-	add	x3, x3, #VGIC_V2_CPU_LR
-1:	ldr	w5, [x2], #4
-CPU_BE(	rev	w5, w5 )
-	str	w5, [x3], #4
-	sub	w4, w4, #1
-	cbnz	w4, 1b
-2:
-.endm
-
-/*
- * Restore the VGIC CPU state from memory
- * x0: Register pointing to VCPU struct
- */
-.macro restore_vgic_state
-	/* Get VGIC VCTRL base into x2 */
-	ldr	x2, [x0, #VCPU_KVM]
-	kern_hyp_va	x2
-	ldr	x2, [x2, #KVM_VGIC_VCTRL]
-	kern_hyp_va	x2
-	cbz	x2, 2f		// disabled
-
-	/* Compute the address of struct vgic_cpu */
-	add	x3, x0, #VCPU_VGIC_CPU
-
-	/* We only restore a minimal set of registers */
-	ldr	w4, [x3, #VGIC_V2_CPU_HCR]
-	ldr	w5, [x3, #VGIC_V2_CPU_VMCR]
-	ldr	w6, [x3, #VGIC_V2_CPU_APR]
-CPU_BE(	rev	w4, w4 )
-CPU_BE(	rev	w5, w5 )
-CPU_BE(	rev	w6, w6 )
-
-	str	w4, [x2, #GICH_HCR]
-	str	w5, [x2, #GICH_VMCR]
-	str	w6, [x2, #GICH_APR]
-
-	/* Restore list registers */
-	add	x2, x2, #GICH_LR0
-	ldr	w4, [x3, #VGIC_CPU_NR_LR]
-	add	x3, x3, #VGIC_V2_CPU_LR
-1:	ldr	w5, [x3], #4
-CPU_BE(	rev	w5, w5 )
-	str	w5, [x2], #4
-	sub	w4, w4, #1
-	cbnz	w4, 1b
-2:
-.endm
-
 .macro save_timer_state
 	// x0: vcpu pointer
 	ldr	x2, [x0, #VCPU_KVM]
@@ -568,7 +470,10 @@ ENTRY(__kvm_vcpu_run)
 	activate_traps
 	activate_vm
 
-	restore_vgic_state
+	adr	x24, __vgic_sr_vectors
+	ldr	x24, [x24, #8]
+	kern_hyp_va	x24
+	blr	x24
 	restore_timer_state
 
 	// Guest context
@@ -595,7 +500,10 @@ __kvm_vcpu_return:
 	save_guest_32bit_state
 
 	save_timer_state
-	save_vgic_state
+	adr	x24, __vgic_sr_vectors
+	ldr	x24, [x24]
+	kern_hyp_va	x24
+	blr	x24
 
 	deactivate_traps
 	deactivate_vm
@@ -644,6 +552,11 @@ ENTRY(__kvm_flush_vm_context)
 	ret
 ENDPROC(__kvm_flush_vm_context)
 
+ENTRY(__vgic_sr_vectors)
+	.quad	__save_vgic_v2_state
+	.quad	__restore_vgic_v2_state
+ENDPROC(__vgic_sr_vectors)
+
 __kvm_hyp_panic:
 	// Guess the context by looking at VTTBR:
 	// If zero, then we're already a host.
@@ -653,6 +566,12 @@ __kvm_hyp_panic:
 
 	mrs	x0, tpidr_el2
 
+	save_timer_state
+	adr	x24, __vgic_sr_vectors
+	ldr	x24, [x24]
+	kern_hyp_va	x24
+	blr	x24
+
 	deactivate_traps
 	deactivate_vm
 
diff --git a/arch/arm64/kvm/vgic-v2-switch.S b/arch/arm64/kvm/vgic-v2-switch.S
new file mode 100644
index 0000000..c5dc777
--- /dev/null
+++ b/arch/arm64/kvm/vgic-v2-switch.S
@@ -0,0 +1,141 @@
+/*
+ * Copyright (C) 2012,2013 - ARM Ltd
+ * Author: Marc Zyngier <marc.zyngier@arm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/linkage.h>
+#include <linux/irqchip/arm-gic.h>
+
+#include <asm/assembler.h>
+#include <asm/memory.h>
+#include <asm/asm-offsets.h>
+#include <asm/kvm.h>
+#include <asm/kvm_asm.h>
+#include <asm/kvm_arm.h>
+#include <asm/kvm_mmu.h>
+
+	.text
+	.pushsection	.hyp.text, "ax"
+
+/*
+ * Save the VGIC CPU state into memory
+ * x0: Register pointing to VCPU struct
+ * Do not corrupt x1!!!
+ */
+.macro save_vgic_v2_state
+	/* Get VGIC VCTRL base into x2 */
+	ldr	x2, [x0, #VCPU_KVM]
+	kern_hyp_va	x2
+	ldr	x2, [x2, #KVM_VGIC_VCTRL]
+	kern_hyp_va	x2
+	cbz	x2, 2f		// disabled
+
+	/* Compute the address of struct vgic_cpu */
+	add	x3, x0, #VCPU_VGIC_CPU
+
+	/* Save all interesting registers */
+	ldr	w4, [x2, #GICH_HCR]
+	ldr	w5, [x2, #GICH_VMCR]
+	ldr	w6, [x2, #GICH_MISR]
+	ldr	w7, [x2, #GICH_EISR0]
+	ldr	w8, [x2, #GICH_EISR1]
+	ldr	w9, [x2, #GICH_ELRSR0]
+	ldr	w10, [x2, #GICH_ELRSR1]
+	ldr	w11, [x2, #GICH_APR]
+CPU_BE(	rev	w4,  w4  )
+CPU_BE(	rev	w5,  w5  )
+CPU_BE(	rev	w6,  w6  )
+CPU_BE(	rev	w7,  w7  )
+CPU_BE(	rev	w8,  w8  )
+CPU_BE(	rev	w9,  w9  )
+CPU_BE(	rev	w10, w10 )
+CPU_BE(	rev	w11, w11 )
+
+	str	w4, [x3, #VGIC_V2_CPU_HCR]
+	str	w5, [x3, #VGIC_V2_CPU_VMCR]
+	str	w6, [x3, #VGIC_V2_CPU_MISR]
+	str	w7, [x3, #VGIC_V2_CPU_EISR]
+	str	w8, [x3, #(VGIC_V2_CPU_EISR + 4)]
+	str	w9, [x3, #VGIC_V2_CPU_ELRSR]
+	str	w10, [x3, #(VGIC_V2_CPU_ELRSR + 4)]
+	str	w11, [x3, #VGIC_V2_CPU_APR]
+
+	/* Clear GICH_HCR */
+	str	wzr, [x2, #GICH_HCR]
+
+	/* Save list registers */
+	add	x2, x2, #GICH_LR0
+	ldr	w4, [x3, #VGIC_CPU_NR_LR]
+	add	x3, x3, #VGIC_V2_CPU_LR
+1:	ldr	w5, [x2], #4
+CPU_BE(	rev	w5, w5 )
+	str	w5, [x3], #4
+	sub	w4, w4, #1
+	cbnz	w4, 1b
+2:
+.endm
+
+/*
+ * Restore the VGIC CPU state from memory
+ * x0: Register pointing to VCPU struct
+ */
+.macro restore_vgic_v2_state
+	/* Get VGIC VCTRL base into x2 */
+	ldr	x2, [x0, #VCPU_KVM]
+	kern_hyp_va	x2
+	ldr	x2, [x2, #KVM_VGIC_VCTRL]
+	kern_hyp_va	x2
+	cbz	x2, 2f		// disabled
+
+	/* Compute the address of struct vgic_cpu */
+	add	x3, x0, #VCPU_VGIC_CPU
+
+	/* We only restore a minimal set of registers */
+	ldr	w4, [x3, #VGIC_V2_CPU_HCR]
+	ldr	w5, [x3, #VGIC_V2_CPU_VMCR]
+	ldr	w6, [x3, #VGIC_V2_CPU_APR]
+CPU_BE(	rev	w4, w4 )
+CPU_BE(	rev	w5, w5 )
+CPU_BE(	rev	w6, w6 )
+
+	str	w4, [x2, #GICH_HCR]
+	str	w5, [x2, #GICH_VMCR]
+	str	w6, [x2, #GICH_APR]
+
+	/* Restore list registers */
+	add	x2, x2, #GICH_LR0
+	ldr	w4, [x3, #VGIC_CPU_NR_LR]
+	add	x3, x3, #VGIC_V2_CPU_LR
+1:	ldr	w5, [x3], #4
+CPU_BE(	rev	w5, w5 )
+	str	w5, [x2], #4
+	sub	w4, w4, #1
+	cbnz	w4, 1b
+2:
+.endm
+
+ENTRY(__save_vgic_v2_state)
+	save_vgic_v2_state
+	ret
+ENDPROC(__save_vgic_v2_state)
+
+ENTRY(__restore_vgic_v2_state)
+__restore_vgic_v2_state:
+	restore_vgic_v2_state
+	ret
+ENDPROC(__restore_vgic_v2_state)
+
+
+	.popsection
diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index 21eea24..c95039a 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -24,7 +24,6 @@
 #include <linux/irqreturn.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
-#include <linux/irqchip/arm-gic.h>
 
 #define VGIC_NR_IRQS		256
 #define VGIC_NR_SGIS		16
@@ -70,6 +69,10 @@ struct vgic_bytemap {
 
 struct kvm_vcpu;
 
+enum vgic_type {
+	VGIC_V2,		/* Good ol' GICv2 */
+};
+
 #define LR_STATE_PENDING	(1 << 0)
 #define LR_STATE_ACTIVE		(1 << 1)
 #define LR_STATE_MASK		(3 << 0)
@@ -102,6 +105,8 @@ struct vgic_ops {
 };
 
 struct vgic_params {
+	/* vgic type */
+	enum vgic_type	type;
 	/* Physical address of vgic virtual cpu interface */
 	phys_addr_t	vcpu_base;
 	/* Number of list registers */
diff --git a/virt/kvm/arm/vgic-v2.c b/virt/kvm/arm/vgic-v2.c
index 52f438f..4c6606e 100644
--- a/virt/kvm/arm/vgic-v2.c
+++ b/virt/kvm/arm/vgic-v2.c
@@ -170,7 +170,7 @@ int vgic_v2_probe(const struct vgic_ops **ops,
 
 	vgic_node = of_find_compatible_node(NULL, NULL, "arm,cortex-a15-gic");
 	if (!vgic_node) {
-		kvm_err("error: no compatible vgic node in DT\n");
+		kvm_err("error: no compatible GICv2 node in DT\n");
 		return -ENODEV;
 	}
 
@@ -183,15 +183,15 @@ int vgic_v2_probe(const struct vgic_ops **ops,
 
 	ret = of_address_to_resource(vgic_node, 2, &vctrl_res);
 	if (ret) {
-		kvm_err("Cannot obtain VCTRL resource\n");
-		goto out_free_irq;
+		kvm_err("Cannot obtain GICH resource\n");
+		goto out;
 	}
 
 	vgic->vctrl_base = of_iomap(vgic_node, 2);
 	if (!vgic->vctrl_base) {
-		kvm_err("Cannot ioremap VCTRL\n");
+		kvm_err("Cannot ioremap GICH\n");
 		ret = -ENOMEM;
-		goto out_free_irq;
+		goto out;
 	}
 
 	vgic->nr_lr = readl_relaxed(vgic->vctrl_base + GICH_VTR);
@@ -206,7 +206,7 @@ int vgic_v2_probe(const struct vgic_ops **ops,
 	}
 
 	if (of_address_to_resource(vgic_node, 3, &vcpu_res)) {
-		kvm_err("Cannot obtain VCPU resource\n");
+		kvm_err("Cannot obtain GICV resource\n");
 		ret = -ENXIO;
 		goto out_unmap;
 	}
@@ -215,14 +215,13 @@ int vgic_v2_probe(const struct vgic_ops **ops,
 	kvm_info("%s@%llx IRQ%d\n", vgic_node->name,
 		 vctrl_res.start, vgic->maint_irq);
 
+	vgic->type = VGIC_V2;
 	*ops = &vgic_v2_ops;
 	*params = vgic;
 	goto out;
 
 out_unmap:
 	iounmap(vgic->vctrl_base);
-out_free_irq:
-	free_percpu_irq(vgic->maint_irq, kvm_get_running_vcpus());
 out:
 	of_node_put(vgic_node);
 	return ret;
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 613b492..8365189 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1531,6 +1531,9 @@ int kvm_vgic_hyp_init(void)
 
 	on_each_cpu(vgic_init_maintenance_interrupt, NULL, 1);
 
+	/* Callback into for arch code for setup */
+	vgic_arch_setup(vgic);
+
 	return 0;
 
 out_free_irq:
-- 
1.8.3.4
