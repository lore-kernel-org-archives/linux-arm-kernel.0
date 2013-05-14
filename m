From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 14 May 2013 15:13:46 +0100
Subject: [PATCH v4 18/32] arm64: KVM: Plug the VGIC
In-Reply-To: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
References: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1368540840-26750-19-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the in-kernel GIC emulation.

Reviewed-by: Christopher Covington <cov@codeaurora.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/hyp.S | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
index e6884d3..06a69af4 100644
--- a/arch/arm64/kvm/hyp.S
+++ b/arch/arm64/kvm/hyp.S
@@ -306,6 +306,90 @@ __kvm_hyp_code_start:
 	msr	vttbr_el2, xzr
 .endm
 
+/*
+ * Save the VGIC CPU state into memory
+ * x0: Register pointing to VCPU struct
+ * Do not corrupt x1!!!
+ */
+.macro save_vgic_state
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
+
+	str	w4, [x3, #VGIC_CPU_HCR]
+	str	w5, [x3, #VGIC_CPU_VMCR]
+	str	w6, [x3, #VGIC_CPU_MISR]
+	str	w7, [x3, #VGIC_CPU_EISR]
+	str	w8, [x3, #(VGIC_CPU_EISR + 4)]
+	str	w9, [x3, #VGIC_CPU_ELRSR]
+	str	w10, [x3, #(VGIC_CPU_ELRSR + 4)]
+	str	w11, [x3, #VGIC_CPU_APR]
+
+	/* Clear GICH_HCR */
+	str	wzr, [x2, #GICH_HCR]
+
+	/* Save list registers */
+	add	x2, x2, #GICH_LR0
+	ldr	w4, [x3, #VGIC_CPU_NR_LR]
+	add	x3, x3, #VGIC_CPU_LR
+1:	ldr	w5, [x2], #4
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
+.macro restore_vgic_state
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
+	ldr	w4, [x3, #VGIC_CPU_HCR]
+	ldr	w5, [x3, #VGIC_CPU_VMCR]
+	ldr	w6, [x3, #VGIC_CPU_APR]
+
+	str	w4, [x2, #GICH_HCR]
+	str	w5, [x2, #GICH_VMCR]
+	str	w6, [x2, #GICH_APR]
+
+	/* Restore list registers */
+	add	x2, x2, #GICH_LR0
+	ldr	w4, [x3, #VGIC_CPU_NR_LR]
+	add	x3, x3, #VGIC_CPU_LR
+1:	ldr	w5, [x3], #4
+	str	w5, [x2], #4
+	sub	w4, w4, #1
+	cbnz	w4, 1b
+2:
+.endm
+
 __save_sysregs:
 	save_sysregs
 	ret
@@ -348,6 +432,8 @@ ENTRY(__kvm_vcpu_run)
 	activate_traps
 	activate_vm
 
+	restore_vgic_state
+
 	// Guest context
 	add	x2, x0, #VCPU_CONTEXT
 
@@ -370,6 +456,8 @@ __kvm_vcpu_return:
 	bl __save_fpsimd
 	bl __save_sysregs
 
+	save_vgic_state
+
 	deactivate_traps
 	deactivate_vm
 
-- 
1.8.2.3
