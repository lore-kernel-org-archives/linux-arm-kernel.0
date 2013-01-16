From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Wed, 16 Jan 2013 13:01:29 -0500
Subject: [PATCH v6 11/13] ARM: KVM: VGIC control interface world switch
In-Reply-To: <20130116180013.29393.49165.stgit@ubuntu>
References: <20130116180013.29393.49165.stgit@ubuntu>
Message-ID: <20130116180129.29393.24683.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

Enable the VGIC control interface to be save-restored on world switch.

Reviewed-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 arch/arm/kernel/asm-offsets.c  |   12 ++++++
 arch/arm/kvm/interrupts_head.S |   74 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index c8b3272..17cea2e 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -169,6 +169,18 @@ int main(void)
   DEFINE(VCPU_HxFAR,		offsetof(struct kvm_vcpu, arch.hxfar));
   DEFINE(VCPU_HPFAR,		offsetof(struct kvm_vcpu, arch.hpfar));
   DEFINE(VCPU_HYP_PC,		offsetof(struct kvm_vcpu, arch.hyp_pc));
+#ifdef CONFIG_KVM_ARM_VGIC
+  DEFINE(VCPU_VGIC_CPU,		offsetof(struct kvm_vcpu, arch.vgic_cpu));
+  DEFINE(VGIC_CPU_HCR,		offsetof(struct vgic_cpu, vgic_hcr));
+  DEFINE(VGIC_CPU_VMCR,		offsetof(struct vgic_cpu, vgic_vmcr));
+  DEFINE(VGIC_CPU_MISR,		offsetof(struct vgic_cpu, vgic_misr));
+  DEFINE(VGIC_CPU_EISR,		offsetof(struct vgic_cpu, vgic_eisr));
+  DEFINE(VGIC_CPU_ELRSR,	offsetof(struct vgic_cpu, vgic_elrsr));
+  DEFINE(VGIC_CPU_APR,		offsetof(struct vgic_cpu, vgic_apr));
+  DEFINE(VGIC_CPU_LR,		offsetof(struct vgic_cpu, vgic_lr));
+  DEFINE(VGIC_CPU_NR_LR,	offsetof(struct vgic_cpu, nr_lr));
+  DEFINE(KVM_VGIC_VCTRL,	offsetof(struct kvm, arch.vgic.vctrl_base));
+#endif
   DEFINE(KVM_VTTBR,		offsetof(struct kvm, arch.vttbr));
 #endif
   return 0; 
diff --git a/arch/arm/kvm/interrupts_head.S b/arch/arm/kvm/interrupts_head.S
index 6a95d34..9e815a5 100644
--- a/arch/arm/kvm/interrupts_head.S
+++ b/arch/arm/kvm/interrupts_head.S
@@ -1,3 +1,5 @@
+#include <asm/hardware/gic.h>
+
 #define VCPU_USR_REG(_reg_nr)	(VCPU_USR_REGS + (_reg_nr * 4))
 #define VCPU_USR_SP		(VCPU_USR_REG(13))
 #define VCPU_USR_LR		(VCPU_USR_REG(14))
@@ -369,6 +371,49 @@ vcpu	.req	r0		@ vcpu pointer always in r0
  * Assumes vcpu pointer in vcpu reg
  */
 .macro save_vgic_state
+#ifdef CONFIG_KVM_ARM_VGIC
+	/* Get VGIC VCTRL base into r2 */
+	ldr	r2, [vcpu, #VCPU_KVM]
+	ldr	r2, [r2, #KVM_VGIC_VCTRL]
+	cmp	r2, #0
+	beq	2f
+
+	/* Compute the address of struct vgic_cpu */
+	add	r11, vcpu, #VCPU_VGIC_CPU
+
+	/* Save all interesting registers */
+	ldr	r3, [r2, #GICH_HCR]
+	ldr	r4, [r2, #GICH_VMCR]
+	ldr	r5, [r2, #GICH_MISR]
+	ldr	r6, [r2, #GICH_EISR0]
+	ldr	r7, [r2, #GICH_EISR1]
+	ldr	r8, [r2, #GICH_ELRSR0]
+	ldr	r9, [r2, #GICH_ELRSR1]
+	ldr	r10, [r2, #GICH_APR]
+
+	str	r3, [r11, #VGIC_CPU_HCR]
+	str	r4, [r11, #VGIC_CPU_VMCR]
+	str	r5, [r11, #VGIC_CPU_MISR]
+	str	r6, [r11, #VGIC_CPU_EISR]
+	str	r7, [r11, #(VGIC_CPU_EISR + 4)]
+	str	r8, [r11, #VGIC_CPU_ELRSR]
+	str	r9, [r11, #(VGIC_CPU_ELRSR + 4)]
+	str	r10, [r11, #VGIC_CPU_APR]
+
+	/* Clear GICH_HCR */
+	mov	r5, #0
+	str	r5, [r2, #GICH_HCR]
+
+	/* Save list registers */
+	add	r2, r2, #GICH_LR0
+	add	r3, r11, #VGIC_CPU_LR
+	ldr	r4, [r11, #VGIC_CPU_NR_LR]
+1:	ldr	r6, [r2], #4
+	str	r6, [r3], #4
+	subs	r4, r4, #1
+	bne	1b
+2:
+#endif
 .endm
 
 /*
@@ -377,6 +422,35 @@ vcpu	.req	r0		@ vcpu pointer always in r0
  * Assumes vcpu pointer in vcpu reg
  */
 .macro restore_vgic_state
+#ifdef CONFIG_KVM_ARM_VGIC
+	/* Get VGIC VCTRL base into r2 */
+	ldr	r2, [vcpu, #VCPU_KVM]
+	ldr	r2, [r2, #KVM_VGIC_VCTRL]
+	cmp	r2, #0
+	beq	2f
+
+	/* Compute the address of struct vgic_cpu */
+	add	r11, vcpu, #VCPU_VGIC_CPU
+
+	/* We only restore a minimal set of registers */
+	ldr	r3, [r11, #VGIC_CPU_HCR]
+	ldr	r4, [r11, #VGIC_CPU_VMCR]
+	ldr	r8, [r11, #VGIC_CPU_APR]
+
+	str	r3, [r2, #GICH_HCR]
+	str	r4, [r2, #GICH_VMCR]
+	str	r8, [r2, #GICH_APR]
+
+	/* Restore list registers */
+	add	r2, r2, #GICH_LR0
+	add	r3, r11, #VGIC_CPU_LR
+	ldr	r4, [r11, #VGIC_CPU_NR_LR]
+1:	ldr	r6, [r3], #4
+	str	r6, [r2], #4
+	subs	r4, r4, #1
+	bne	1b
+2:
+#endif
 .endm
 
 .equ vmentry,	0
