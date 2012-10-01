From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Mon, 01 Oct 2012 05:14:14 -0400
Subject: [PATCH v2 07/10] ARM: KVM: VGIC control interface world switch
In-Reply-To: <20121001091244.49503.96318.stgit@ubuntu>
References: <20121001091244.49503.96318.stgit@ubuntu>
Message-ID: <20121001091414.49503.49410.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

Enable the VGIC control interface to be save-restored on world switch.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 arch/arm/include/asm/kvm_arm.h |   12 +++++++
 arch/arm/kernel/asm-offsets.c  |   12 +++++++
 arch/arm/kvm/interrupts_head.S |   68 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+)

diff --git a/arch/arm/include/asm/kvm_arm.h b/arch/arm/include/asm/kvm_arm.h
index 4f1bb01..e1e39d6 100644
--- a/arch/arm/include/asm/kvm_arm.h
+++ b/arch/arm/include/asm/kvm_arm.h
@@ -188,4 +188,16 @@
 #define HSR_EC_DABT	(0x24)
 #define HSR_EC_DABT_HYP	(0x25)
 
+/* GICH offsets */
+#define GICH_HCR	0x0
+#define GICH_VTR	0x4
+#define GICH_VMCR	0x8
+#define GICH_MISR	0x10
+#define GICH_EISR0 	0x20
+#define GICH_EISR1 	0x24
+#define GICH_ELRSR0 	0x30
+#define GICH_ELRSR1 	0x34
+#define GICH_APR	0xf0
+#define GICH_LR0	0x100
+
 #endif /* __ARM_KVM_ARM_H__ */
diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index d020e6aa..1f4a894 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -166,6 +166,18 @@ int main(void)
   DEFINE(VCPU_HIFAR,		offsetof(struct kvm_vcpu, arch.hifar));
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
index b29bd62..e44aea6 100644
--- a/arch/arm/kvm/interrupts_head.S
+++ b/arch/arm/kvm/interrupts_head.S
@@ -225,6 +225,45 @@
  * @vcpup: Register pointing to VCPU struct
  */
 .macro save_vgic_state	vcpup
+#ifdef CONFIG_KVM_ARM_VGIC
+	/* Get VGIC VCTRL base into r2 */
+	ldr	r2, [\vcpup, #VCPU_KVM]
+	ldr	r2, [r2, #KVM_VGIC_VCTRL]
+	cmp	r2, #0
+	beq	2f
+
+	/* Compute the address of struct vgic_cpu */
+	add	r11, \vcpup, #VCPU_VGIC_CPU
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
@@ -232,6 +271,35 @@
  * @vcpup: Register pointing to VCPU struct
  */
 .macro restore_vgic_state	vcpup
+#ifdef CONFIG_KVM_ARM_VGIC
+	/* Get VGIC VCTRL base into r2 */
+	ldr	r2, [\vcpup, #VCPU_KVM]
+	ldr	r2, [r2, #KVM_VGIC_VCTRL]
+	cmp	r2, #0
+	beq	2f
+
+	/* Compute the address of struct vgic_cpu */
+	add	r11, \vcpup, #VCPU_VGIC_CPU
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
 
 /* Configures the HSTR (Hyp System Trap Register) on entry/return
