From: will.deacon@arm.com (Will Deacon)
Date: Tue, 27 Nov 2018 12:41:56 +0000
Subject: [PATCH 2/3] arm64: entry: Place an SB sequence following an ERET
 instruction
In-Reply-To: <1543322517-470-1-git-send-email-will.deacon@arm.com>
References: <1543322517-470-1-git-send-email-will.deacon@arm.com>
Message-ID: <1543322517-470-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some CPUs can speculate past an ERET instruction and potentially perform
speculative accesses to memory before processing the exception return.
Since the register state is often controlled by a lower privilege level
at the point of an ERET, this could potentially be used as part of a
side-channel attack.

This patch emits an SB sequence after each ERET so that speculation is
held up on exception return.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/entry.S      | 2 ++
 arch/arm64/kvm/hyp/entry.S     | 1 +
 arch/arm64/kvm/hyp/hyp-entry.S | 4 ++++
 3 files changed, 7 insertions(+)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 039144ecbcb2..a7fc77ab4a0a 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -363,6 +363,7 @@ alternative_insn eret, nop, ARM64_UNMAP_KERNEL_AT_EL0
 	.else
 	eret
 	.endif
+	sb
 	.endm
 
 	.macro	irq_stack_entry
@@ -1006,6 +1007,7 @@ alternative_insn isb, nop, ARM64_WORKAROUND_QCOM_FALKOR_E1003
 	mrs	x30, far_el1
 	.endif
 	eret
+	sb
 	.endm
 
 	.align	11
diff --git a/arch/arm64/kvm/hyp/entry.S b/arch/arm64/kvm/hyp/entry.S
index fad1e164fe48..675fdc186e3b 100644
--- a/arch/arm64/kvm/hyp/entry.S
+++ b/arch/arm64/kvm/hyp/entry.S
@@ -83,6 +83,7 @@ ENTRY(__guest_enter)
 
 	// Do not touch any register after this!
 	eret
+	sb
 ENDPROC(__guest_enter)
 
 ENTRY(__guest_exit)
diff --git a/arch/arm64/kvm/hyp/hyp-entry.S b/arch/arm64/kvm/hyp/hyp-entry.S
index b1f14f736962..73c1b483ec39 100644
--- a/arch/arm64/kvm/hyp/hyp-entry.S
+++ b/arch/arm64/kvm/hyp/hyp-entry.S
@@ -96,6 +96,7 @@ el1_sync:				// Guest trapped into EL2
 	do_el2_call
 
 	eret
+	sb
 
 el1_hvc_guest:
 	/*
@@ -146,6 +147,7 @@ wa_epilogue:
 	mov	x0, xzr
 	add	sp, sp, #16
 	eret
+	sb
 
 el1_trap:
 	get_vcpu_ptr	x1, x0
@@ -199,6 +201,7 @@ el2_error:
 	b.ne	__hyp_panic
 	mov	x0, #(1 << ARM_EXIT_WITH_SERROR_BIT)
 	eret
+	sb
 
 ENTRY(__hyp_do_panic)
 	mov	lr, #(PSR_F_BIT | PSR_I_BIT | PSR_A_BIT | PSR_D_BIT |\
@@ -207,6 +210,7 @@ ENTRY(__hyp_do_panic)
 	ldr	lr, =panic
 	msr	elr_el2, lr
 	eret
+	sb
 ENDPROC(__hyp_do_panic)
 
 ENTRY(__hyp_panic)
-- 
2.1.4
