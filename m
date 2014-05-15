From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 15 May 2014 18:58:39 +0100
Subject: [PATCH v4 20/20] arm64: KVM: vgic: add GICv3 world switch
In-Reply-To: <1400176719-31275-1-git-send-email-marc.zyngier@arm.com>
References: <1400176719-31275-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1400176719-31275-21-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce the GICv3 world switch code and helper functions, enabling
GICv2 emulation on GICv3 hardware.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/kvm_asm.h  |   4 +
 arch/arm64/include/asm/kvm_host.h |   7 +
 arch/arm64/kernel/asm-offsets.c   |   8 ++
 arch/arm64/kvm/Makefile           |   2 +
 arch/arm64/kvm/vgic-v3-switch.S   | 271 ++++++++++++++++++++++++++++++++++++++
 virt/kvm/arm/vgic.c               |   1 +
 6 files changed, 293 insertions(+)
 create mode 100644 arch/arm64/kvm/vgic-v3-switch.S

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 6252264..a28c35b 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -106,8 +106,12 @@ extern void __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa);
 
 extern int __kvm_vcpu_run(struct kvm_vcpu *vcpu);
 
+extern u64 __vgic_v3_get_ich_vtr_el2(void);
+
 extern char __save_vgic_v2_state[];
 extern char __restore_vgic_v2_state[];
+extern char __save_vgic_v3_state[];
+extern char __restore_vgic_v3_state[];
 
 #endif
 
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 65f0c43..a10803c 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -216,6 +216,13 @@ static inline void vgic_arch_setup(const struct vgic_params *vgic)
 		__vgic_sr_vectors.restore_vgic	= __restore_vgic_v2_state;
 		break;
 
+#ifdef CONFIG_ARM_GIC_V3
+	case VGIC_V3:
+		__vgic_sr_vectors.save_vgic	= __save_vgic_v3_state;
+		__vgic_sr_vectors.restore_vgic	= __restore_vgic_v3_state;
+		break;
+#endif
+
 	default:
 		BUG();
 	}
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index dafc415..e74654c 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -139,6 +139,14 @@ int main(void)
   DEFINE(VGIC_V2_CPU_ELRSR,	offsetof(struct vgic_cpu, vgic_v2.vgic_elrsr));
   DEFINE(VGIC_V2_CPU_APR,	offsetof(struct vgic_cpu, vgic_v2.vgic_apr));
   DEFINE(VGIC_V2_CPU_LR,	offsetof(struct vgic_cpu, vgic_v2.vgic_lr));
+  DEFINE(VGIC_V3_CPU_HCR,	offsetof(struct vgic_cpu, vgic_v3.vgic_hcr));
+  DEFINE(VGIC_V3_CPU_VMCR,	offsetof(struct vgic_cpu, vgic_v3.vgic_vmcr));
+  DEFINE(VGIC_V3_CPU_MISR,	offsetof(struct vgic_cpu, vgic_v3.vgic_misr));
+  DEFINE(VGIC_V3_CPU_EISR,	offsetof(struct vgic_cpu, vgic_v3.vgic_eisr));
+  DEFINE(VGIC_V3_CPU_ELRSR,	offsetof(struct vgic_cpu, vgic_v3.vgic_elrsr));
+  DEFINE(VGIC_V3_CPU_AP0R,	offsetof(struct vgic_cpu, vgic_v3.vgic_ap0r));
+  DEFINE(VGIC_V3_CPU_AP1R,	offsetof(struct vgic_cpu, vgic_v3.vgic_ap1r));
+  DEFINE(VGIC_V3_CPU_LR,	offsetof(struct vgic_cpu, vgic_v3.vgic_lr));
   DEFINE(VGIC_CPU_NR_LR,	offsetof(struct vgic_cpu, nr_lr));
   DEFINE(KVM_VTTBR,		offsetof(struct kvm, arch.vttbr));
   DEFINE(KVM_VGIC_VCTRL,	offsetof(struct kvm, arch.vgic.vctrl_base));
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index daf24dc..32a0961 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -22,4 +22,6 @@ kvm-$(CONFIG_KVM_ARM_HOST) += guest.o reset.o sys_regs.o sys_regs_generic_v8.o
 kvm-$(CONFIG_KVM_ARM_VGIC) += $(KVM)/arm/vgic.o
 kvm-$(CONFIG_KVM_ARM_VGIC) += $(KVM)/arm/vgic-v2.o
 kvm-$(CONFIG_KVM_ARM_VGIC) += vgic-v2-switch.o
+kvm-$(CONFIG_KVM_ARM_VGIC) += $(KVM)/arm/vgic-v3.o
+kvm-$(CONFIG_KVM_ARM_VGIC) += vgic-v3-switch.o
 kvm-$(CONFIG_KVM_ARM_TIMER) += $(KVM)/arm/arch_timer.o
diff --git a/arch/arm64/kvm/vgic-v3-switch.S b/arch/arm64/kvm/vgic-v3-switch.S
new file mode 100644
index 0000000..791a9ab
--- /dev/null
+++ b/arch/arm64/kvm/vgic-v3-switch.S
@@ -0,0 +1,271 @@
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
+#include <linux/irqchip/arm-gic-v3.h>
+
+#include <asm/assembler.h>
+#include <asm/memory.h>
+#include <asm/asm-offsets.h>
+#include <asm/kvm.h>
+#include <asm/kvm_asm.h>
+#include <asm/kvm_arm.h>
+
+	.text
+	.pushsection	.hyp.text, "ax"
+
+/*
+ * Save the VGIC CPU state into memory
+ * x0: Register pointing to VCPU struct
+ * Do not corrupt x1!!!
+ */
+.macro	save_vgic_v3_state
+	// Compute the address of struct vgic_cpu
+	add	x3, x0, #VCPU_VGIC_CPU
+
+	// Make sure stores to the GIC via the memory mapped interface
+	// are now visible to the system register interface
+	dsb	sy
+
+	// Save all interesting registers
+	mrs	x4, ICH_HCR_EL2
+	mrs	x5, ICH_VMCR_EL2
+	mrs	x6, ICH_MISR_EL2
+	mrs	x7, ICH_EISR_EL2
+	mrs	x8, ICH_ELSR_EL2
+
+	str	w4, [x3, #VGIC_V3_CPU_HCR]
+	str	w5, [x3, #VGIC_V3_CPU_VMCR]
+	str	w6, [x3, #VGIC_V3_CPU_MISR]
+	str	w7, [x3, #VGIC_V3_CPU_EISR]
+	str	w8, [x3, #VGIC_V3_CPU_ELRSR]
+
+	msr	ICH_HCR_EL2, xzr
+
+	mrs	x21, ICH_VTR_EL2
+	and	w22, w21, #0xf
+	mov	w23, #0xf
+	sub	w23, w23, w22	// How many regs we have to skip
+
+	adr	x24, 1f
+	add	x24, x24, x23, lsl #2
+	br	x24
+
+1:
+	mrs	x20, ICH_LR15_EL2
+	mrs	x19, ICH_LR14_EL2
+	mrs	x18, ICH_LR13_EL2
+	mrs	x17, ICH_LR12_EL2
+	mrs	x16, ICH_LR11_EL2
+	mrs	x15, ICH_LR10_EL2
+	mrs	x14, ICH_LR9_EL2
+	mrs	x13, ICH_LR8_EL2
+	mrs	x12, ICH_LR7_EL2
+	mrs	x11, ICH_LR6_EL2
+	mrs	x10, ICH_LR5_EL2
+	mrs	x9, ICH_LR4_EL2
+	mrs	x8, ICH_LR3_EL2
+	mrs	x7, ICH_LR2_EL2
+	mrs	x6, ICH_LR1_EL2
+	mrs	x5, ICH_LR0_EL2
+
+	adr	x24, 1f
+	add	x24, x24, x23, lsl #2	// adr(1f) + unimp_nr*4
+	br	x24
+
+1:
+	str	x20, [x3, #(VGIC_V3_CPU_LR + 15*8)]
+	str	x19, [x3, #(VGIC_V3_CPU_LR + 14*8)]
+	str	x18, [x3, #(VGIC_V3_CPU_LR + 13*8)]
+	str	x17, [x3, #(VGIC_V3_CPU_LR + 12*8)]
+	str	x16, [x3, #(VGIC_V3_CPU_LR + 11*8)]
+	str	x15, [x3, #(VGIC_V3_CPU_LR + 10*8)]
+	str	x14, [x3, #(VGIC_V3_CPU_LR + 9*8)]
+	str	x13, [x3, #(VGIC_V3_CPU_LR + 8*8)]
+	str	x12, [x3, #(VGIC_V3_CPU_LR + 7*8)]
+	str	x11, [x3, #(VGIC_V3_CPU_LR + 6*8)]
+	str	x10, [x3, #(VGIC_V3_CPU_LR + 5*8)]
+	str	x9, [x3, #(VGIC_V3_CPU_LR + 4*8)]
+	str	x8, [x3, #(VGIC_V3_CPU_LR + 3*8)]
+	str	x7, [x3, #(VGIC_V3_CPU_LR + 2*8)]
+	str	x6, [x3, #(VGIC_V3_CPU_LR + 1*8)]
+	str	x5, [x3, #VGIC_V3_CPU_LR]
+
+	lsr	w22, w21, #29	// Get PRIbits
+	cmp	w22, #4		// 5 bits
+	b.eq	5f
+	cmp	w22, #5		// 6 bits
+	b.eq	6f
+				// 7 bits
+	mrs	x20, ICH_AP0R3_EL2
+	str	w20, [x3, #(VGIC_V3_CPU_AP0R + 3*4)]
+	mrs	x19, ICH_AP0R2_EL2
+	str	w19, [x3, #(VGIC_V3_CPU_AP0R + 2*4)]
+6:	mrs	x18, ICH_AP0R1_EL2
+	str	w18, [x3, #(VGIC_V3_CPU_AP0R + 1*4)]
+5:	mrs	x17, ICH_AP0R0_EL2
+	str	w17, [x3, #VGIC_V3_CPU_AP0R]
+
+	cmp	w22, #4		// 5 bits
+	b.eq	5f
+	cmp	w22, #5		// 6 bits
+	b.eq	6f
+				// 7 bits
+	mrs	x20, ICH_AP1R3_EL2
+	str	w20, [x3, #(VGIC_V3_CPU_AP1R + 3*4)]
+	mrs	x19, ICH_AP1R2_EL2
+	str	w19, [x3, #(VGIC_V3_CPU_AP1R + 2*4)]
+6:	mrs	x18, ICH_AP1R1_EL2
+	str	w18, [x3, #(VGIC_V3_CPU_AP1R + 1*4)]
+5:	mrs	x17, ICH_AP1R0_EL2
+	str	w17, [x3, #VGIC_V3_CPU_AP1R]
+
+	// Restore SRE_EL1 access and re-enable SRE at EL1.
+	mrs	x5, ICC_SRE_EL2
+	orr	x5, x5, #ICC_SRE_EL2_ENABLE
+	msr	ICC_SRE_EL2, x5
+	isb
+	mov	x5, #1
+	msr	ICC_SRE_EL1, x5
+.endm
+
+/*
+ * Restore the VGIC CPU state from memory
+ * x0: Register pointing to VCPU struct
+ */
+.macro	restore_vgic_v3_state
+	// Disable SRE_EL1 access. Necessary, otherwise
+	// ICH_VMCR_EL2.VFIQEn becomes one, and FIQ happens...
+	msr	ICC_SRE_EL1, xzr
+	isb
+
+	// Compute the address of struct vgic_cpu
+	add	x3, x0, #VCPU_VGIC_CPU
+
+	// Restore all interesting registers
+	ldr	w4, [x3, #VGIC_V3_CPU_HCR]
+	ldr	w5, [x3, #VGIC_V3_CPU_VMCR]
+
+	msr	ICH_HCR_EL2, x4
+	msr	ICH_VMCR_EL2, x5
+
+	mrs	x21, ICH_VTR_EL2
+
+	lsr	w22, w21, #29	// Get PRIbits
+	cmp	w22, #4		// 5 bits
+	b.eq	5f
+	cmp	w22, #5		// 6 bits
+	b.eq	6f
+				// 7 bits
+	ldr	w20, [x3, #(VGIC_V3_CPU_AP1R + 3*4)]
+	msr	ICH_AP1R3_EL2, x20
+	ldr	w19, [x3, #(VGIC_V3_CPU_AP1R + 2*4)]
+	msr	ICH_AP1R2_EL2, x19
+6:	ldr	w18, [x3, #(VGIC_V3_CPU_AP1R + 1*4)]
+	msr	ICH_AP1R1_EL2, x18
+5:	ldr	w17, [x3, #VGIC_V3_CPU_AP1R]
+	msr	ICH_AP1R0_EL2, x17
+
+	cmp	w22, #4		// 5 bits
+	b.eq	5f
+	cmp	w22, #5		// 6 bits
+	b.eq	6f
+				// 7 bits
+	ldr	w20, [x3, #(VGIC_V3_CPU_AP0R + 3*4)]
+	msr	ICH_AP0R3_EL2, x20
+	ldr	w19, [x3, #(VGIC_V3_CPU_AP0R + 2*4)]
+	msr	ICH_AP0R2_EL2, x19
+6:	ldr	w18, [x3, #(VGIC_V3_CPU_AP0R + 1*4)]
+	msr	ICH_AP0R1_EL2, x18
+5:	ldr	w17, [x3, #VGIC_V3_CPU_AP0R]
+	msr	ICH_AP0R0_EL2, x17
+
+	and	w22, w21, #0xf
+	mov	w23, #0xf
+	sub	w23, w23, w22	// How many regs we have to skip
+
+	adr	x24, 1f
+	add	x24, x24, x23, lsl #2	// adr(1f) + unimp_nr*4
+	br	x24
+
+1:
+	ldr	x20, [x3, #(VGIC_V3_CPU_LR + 15*8)]
+	ldr	x19, [x3, #(VGIC_V3_CPU_LR + 14*8)]
+	ldr	x18, [x3, #(VGIC_V3_CPU_LR + 13*8)]
+	ldr	x17, [x3, #(VGIC_V3_CPU_LR + 12*8)]
+	ldr	x16, [x3, #(VGIC_V3_CPU_LR + 11*8)]
+	ldr	x15, [x3, #(VGIC_V3_CPU_LR + 10*8)]
+	ldr	x14, [x3, #(VGIC_V3_CPU_LR + 9*8)]
+	ldr	x13, [x3, #(VGIC_V3_CPU_LR + 8*8)]
+	ldr	x12, [x3, #(VGIC_V3_CPU_LR + 7*8)]
+	ldr	x11, [x3, #(VGIC_V3_CPU_LR + 6*8)]
+	ldr	x10, [x3, #(VGIC_V3_CPU_LR + 5*8)]
+	ldr	x9, [x3, #(VGIC_V3_CPU_LR + 4*8)]
+	ldr	x8, [x3, #(VGIC_V3_CPU_LR + 3*8)]
+	ldr	x7, [x3, #(VGIC_V3_CPU_LR + 2*8)]
+	ldr	x6, [x3, #(VGIC_V3_CPU_LR + 1*8)]
+	ldr	x5, [x3, #VGIC_V3_CPU_LR]
+
+	adr	x24, 1f
+	add	x24, x24, x23, lsl #2
+	br	x24
+
+1:
+	msr	ICH_LR15_EL2, x20
+	msr	ICH_LR14_EL2, x19
+	msr	ICH_LR13_EL2, x18
+	msr	ICH_LR12_EL2, x17
+	msr	ICH_LR11_EL2, x16
+	msr	ICH_LR10_EL2, x15
+	msr	ICH_LR9_EL2,  x14
+	msr	ICH_LR8_EL2,  x13
+	msr	ICH_LR7_EL2,  x12
+	msr	ICH_LR6_EL2,  x11
+	msr	ICH_LR5_EL2,  x10
+	msr	ICH_LR4_EL2,   x9
+	msr	ICH_LR3_EL2,   x8
+	msr	ICH_LR2_EL2,   x7
+	msr	ICH_LR1_EL2,   x6
+	msr	ICH_LR0_EL2,   x5
+
+	// Ensure that the above will be visible via the memory-mapped
+	// view of the CPU interface (GICV).
+	isb
+	dsb	sy
+
+	// Prevent the guest from touching the GIC system registers
+	mrs	x5, ICC_SRE_EL2
+	and	x5, x5, #~ICC_SRE_EL2_ENABLE
+	msr	ICC_SRE_EL2, x5
+.endm
+
+ENTRY(__save_vgic_v3_state)
+	save_vgic_v3_state
+	ret
+ENDPROC(__save_vgic_v3_state)
+
+ENTRY(__restore_vgic_v3_state)
+	restore_vgic_v3_state
+	ret
+ENDPROC(__restore_vgic_v3_state)
+
+ENTRY(__vgic_v3_get_ich_vtr_el2)
+	mrs	x0, ICH_VTR_EL2
+	ret
+ENDPROC(__vgic_v3_get_ich_vtr_el2)
+
+	.popsection
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 7867b9a..795ab48 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1530,6 +1530,7 @@ static struct notifier_block vgic_cpu_nb = {
 
 static const struct of_device_id vgic_ids[] = {
 	{ .compatible = "arm,cortex-a15-gic", .data = vgic_v2_probe, },
+	{ .compatible = "arm,gic-v3", .data = vgic_v3_probe, },
 	{},
 };
 
-- 
1.8.3.4
