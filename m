From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  5 Mar 2013 03:47:43 +0000
Subject: [PATCH 27/29] arm64: KVM: 32bit specific register world switch
In-Reply-To: <1362455265-24165-1-git-send-email-marc.zyngier@arm.com>
References: <1362455265-24165-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1362455265-24165-28-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow registers specific to 32bit guests to be saved/restored
during the world switch.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/hyp.S | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
index cd7506d..1d4b0a7 100644
--- a/arch/arm64/kvm/hyp.S
+++ b/arch/arm64/kvm/hyp.S
@@ -312,6 +312,74 @@ __kvm_hyp_code_start:
 	load_sysregs
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
+	skip_32bit_state x2, 1f
+
+	add	x2, x0, #SPSR_OFFSET(KVM_SPSR_ABT)
+	mrs	x4, spsr_abt
+	mrs	x5, spsr_und
+	mrs	x6, spsr_irq
+	mrs	x7, spsr_fiq
+	stp	x4, x5, [x2], #16
+	stp	x6, x7, [x2]
+
+	add	x2, x0, #SYSREG_OFFSET(DACR32_EL2)
+	mrs	x4, dacr32_el2
+	mrs	x5, ifsr32_el2
+	mrs	x6, fpexc32_el2
+	mrs	x7, dbgvcr32_el2
+	stp	x4, x5, [x2], #16
+	stp	x6, x7, [x2]
+
+	skip_tee_state x8, 1f
+
+	add	x2, x0, #SYSREG_OFFSET(TEECR32_EL1)
+	mrs	x4, teecr32_el1
+	mrs	x5, teehbr32_el1
+	stp	x4, x5, [x2]
+1:
+.endm
+
+.macro restore_guest_32bit_state
+	skip_32bit_state x2, 1f
+
+	add	x2, x0, #SPSR_OFFSET(KVM_SPSR_ABT)
+	ldp	x4, x5, [x2], #16
+	ldp	x6, x7, [x2]
+	msr	spsr_abt, x4
+	msr	spsr_und, x5
+	msr	spsr_irq, x6
+	msr	spsr_fiq, x7
+
+	add	x2, x0, #SYSREG_OFFSET(DACR32_EL2)
+	ldp	x4, x5, [x2], #16
+	ldp	x6, x7, [x2]
+	msr	dacr32_el2, x4
+	msr	ifsr32_el2, x5
+	msr	fpexc32_el2, x6
+	msr	dbgvcr32_el2, x7
+
+	skip_tee_state x8, 1f
+
+	add	x2, x0, #SYSREG_OFFSET(TEECR32_EL1)
+	ldp	x4, x5, [x2]
+	msr	teecr32_el1, x4
+	msr	teehbr32_el1, x5
+1:
+.endm
+
 .macro activate_traps
 	ldr	x2, [x0, #VCPU_IRQ_LINES]
 	ldr	x1, [x0, #VCPU_HCR_EL2]
@@ -513,6 +581,7 @@ ENTRY(__kvm_vcpu_run)
 	restore_timer_state
 	restore_guest_sysregs
 	restore_guest_fpsimd
+	restore_guest_32bit_state
 	restore_guest_regs
 
 	// That's it, no more messing around.
@@ -523,6 +592,7 @@ __kvm_vcpu_return:
 	// Assume x0 is the vcpu pointer, x1 the return code
 	// Guest's x0-x3 are on the stack
 	save_guest_regs
+	save_guest_32bit_state
 	save_guest_fpsimd
 	save_guest_sysregs
 	save_timer_state
-- 
1.7.12.4
