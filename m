From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 14 May 2013 15:13:55 +0100
Subject: [PATCH v4 27/32] arm64: KVM: 32bit specific register world switch
In-Reply-To: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
References: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1368540840-26750-28-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow registers specific to 32bit guests to be saved/restored
during the world switch.

Reviewed-by: Christopher Covington <cov@codeaurora.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/hyp.S | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
index 926dc7e..e175f84 100644
--- a/arch/arm64/kvm/hyp.S
+++ b/arch/arm64/kvm/hyp.S
@@ -266,6 +266,74 @@ __kvm_hyp_code_start:
 	msr	cntkctl_el1,	x23
 .endm
 
+.macro skip_32bit_state tmp, target
+	// Skip 32bit state if not needed
+	mrs	\tmp, hcr_el2
+	tbnz	\tmp, #HCR_RW_SHIFT, \target
+.endm
+
+.macro skip_tee_state tmp, target
+	// Skip ThumbEE state if not needed
+	mrs	\tmp, id_pfr0_el1
+	tbz	\tmp, #12, \target
+.endm
+
+.macro save_guest_32bit_state
+	skip_32bit_state x3, 1f
+
+	add	x3, x2, #CPU_SPSR_OFFSET(KVM_SPSR_ABT)
+	mrs	x4, spsr_abt
+	mrs	x5, spsr_und
+	mrs	x6, spsr_irq
+	mrs	x7, spsr_fiq
+	stp	x4, x5, [x3]
+	stp	x6, x7, [x3, #16]
+
+	add	x3, x2, #CPU_SYSREG_OFFSET(DACR32_EL2)
+	mrs	x4, dacr32_el2
+	mrs	x5, ifsr32_el2
+	mrs	x6, fpexc32_el2
+	mrs	x7, dbgvcr32_el2
+	stp	x4, x5, [x3]
+	stp	x6, x7, [x3, #16]
+
+	skip_tee_state x8, 1f
+
+	add	x3, x2, #CPU_SYSREG_OFFSET(TEECR32_EL1)
+	mrs	x4, teecr32_el1
+	mrs	x5, teehbr32_el1
+	stp	x4, x5, [x3]
+1:
+.endm
+
+.macro restore_guest_32bit_state
+	skip_32bit_state x3, 1f
+
+	add	x3, x2, #CPU_SPSR_OFFSET(KVM_SPSR_ABT)
+	ldp	x4, x5, [x3]
+	ldp	x6, x7, [x3, #16]
+	msr	spsr_abt, x4
+	msr	spsr_und, x5
+	msr	spsr_irq, x6
+	msr	spsr_fiq, x7
+
+	add	x3, x2, #CPU_SYSREG_OFFSET(DACR32_EL2)
+	ldp	x4, x5, [x3]
+	ldp	x6, x7, [x3, #16]
+	msr	dacr32_el2, x4
+	msr	ifsr32_el2, x5
+	msr	fpexc32_el2, x6
+	msr	dbgvcr32_el2, x7
+
+	skip_tee_state x8, 1f
+
+	add	x3, x2, #CPU_SYSREG_OFFSET(TEECR32_EL1)
+	ldp	x4, x5, [x3]
+	msr	teecr32_el1, x4
+	msr	teehbr32_el1, x5
+1:
+.endm
+
 .macro activate_traps
 	ldr	x2, [x0, #VCPU_IRQ_LINES]
 	ldr	x1, [x0, #VCPU_HCR_EL2]
@@ -494,6 +562,7 @@ ENTRY(__kvm_vcpu_run)
 
 	bl __restore_sysregs
 	bl __restore_fpsimd
+	restore_guest_32bit_state
 	restore_guest_regs
 
 	// That's it, no more messing around.
@@ -510,6 +579,7 @@ __kvm_vcpu_return:
 	save_guest_regs
 	bl __save_fpsimd
 	bl __save_sysregs
+	save_guest_32bit_state
 
 	save_timer_state
 	save_vgic_state
-- 
1.8.2.3
