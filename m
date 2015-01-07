From: mark.rutland@arm.com (Mark Rutland)
Date: Wed,  7 Jan 2015 12:04:15 +0000
Subject: [PATCH 2/7] arm64: move to ESR_ELx macros
In-Reply-To: <1420632260-8798-1-git-send-email-mark.rutland@arm.com>
References: <1420632260-8798-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1420632260-8798-3-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have common ESR_ELx_* macros, move the core arm64 code over
to them.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/entry.S    | 64 ++++++++++++++++++++++----------------------
 arch/arm64/kernel/signal32.c |  2 +-
 arch/arm64/mm/fault.c        |  2 +-
 3 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index fd4fa37..02e6af1 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -269,18 +269,18 @@ ENDPROC(el1_error_invalid)
 el1_sync:
 	kernel_entry 1
 	mrs	x1, esr_el1			// read the syndrome register
-	lsr	x24, x1, #ESR_EL1_EC_SHIFT	// exception class
-	cmp	x24, #ESR_EL1_EC_DABT_EL1	// data abort in EL1
+	lsr	x24, x1, #ESR_ELx_EC_SHIFT	// exception class
+	cmp	x24, #ESR_ELx_EC_DABT_CUR	// data abort in EL1
 	b.eq	el1_da
-	cmp	x24, #ESR_EL1_EC_SYS64		// configurable trap
+	cmp	x24, #ESR_ELx_EC_SYS64		// configurable trap
 	b.eq	el1_undef
-	cmp	x24, #ESR_EL1_EC_SP_ALIGN	// stack alignment exception
+	cmp	x24, #ESR_ELx_EC_SP_ALIGN	// stack alignment exception
 	b.eq	el1_sp_pc
-	cmp	x24, #ESR_EL1_EC_PC_ALIGN	// pc alignment exception
+	cmp	x24, #ESR_ELx_EC_PC_ALIGN	// pc alignment exception
 	b.eq	el1_sp_pc
-	cmp	x24, #ESR_EL1_EC_UNKNOWN	// unknown exception in EL1
+	cmp	x24, #ESR_ELx_EC_UNKNOWN	// unknown exception in EL1
 	b.eq	el1_undef
-	cmp	x24, #ESR_EL1_EC_BREAKPT_EL1	// debug exception in EL1
+	cmp	x24, #ESR_ELx_EC_BREAKPT_CUR	// debug exception in EL1
 	b.ge	el1_dbg
 	b	el1_inv
 el1_da:
@@ -318,7 +318,7 @@ el1_dbg:
 	/*
 	 * Debug exception handling
 	 */
-	cmp	x24, #ESR_EL1_EC_BRK64		// if BRK64
+	cmp	x24, #ESR_ELx_EC_BRK64		// if BRK64
 	cinc	x24, x24, eq			// set bit '0'
 	tbz	x24, #0, el1_inv		// EL1 only
 	mrs	x0, far_el1
@@ -375,26 +375,26 @@ el1_preempt:
 el0_sync:
 	kernel_entry 0
 	mrs	x25, esr_el1			// read the syndrome register
-	lsr	x24, x25, #ESR_EL1_EC_SHIFT	// exception class
-	cmp	x24, #ESR_EL1_EC_SVC64		// SVC in 64-bit state
+	lsr	x24, x25, #ESR_ELx_EC_SHIFT	// exception class
+	cmp	x24, #ESR_ELx_EC_SVC64		// SVC in 64-bit state
 	b.eq	el0_svc
-	cmp	x24, #ESR_EL1_EC_DABT_EL0	// data abort in EL0
+	cmp	x24, #ESR_ELx_EC_DABT_LOW	// data abort in EL0
 	b.eq	el0_da
-	cmp	x24, #ESR_EL1_EC_IABT_EL0	// instruction abort in EL0
+	cmp	x24, #ESR_ELx_EC_IABT_LOW	// instruction abort in EL0
 	b.eq	el0_ia
-	cmp	x24, #ESR_EL1_EC_FP_ASIMD	// FP/ASIMD access
+	cmp	x24, #ESR_ELx_EC_FP_ASIMD	// FP/ASIMD access
 	b.eq	el0_fpsimd_acc
-	cmp	x24, #ESR_EL1_EC_FP_EXC64	// FP/ASIMD exception
+	cmp	x24, #ESR_ELx_EC_FP_EXC64	// FP/ASIMD exception
 	b.eq	el0_fpsimd_exc
-	cmp	x24, #ESR_EL1_EC_SYS64		// configurable trap
+	cmp	x24, #ESR_ELx_EC_SYS64		// configurable trap
 	b.eq	el0_undef
-	cmp	x24, #ESR_EL1_EC_SP_ALIGN	// stack alignment exception
+	cmp	x24, #ESR_ELx_EC_SP_ALIGN	// stack alignment exception
 	b.eq	el0_sp_pc
-	cmp	x24, #ESR_EL1_EC_PC_ALIGN	// pc alignment exception
+	cmp	x24, #ESR_ELx_EC_PC_ALIGN	// pc alignment exception
 	b.eq	el0_sp_pc
-	cmp	x24, #ESR_EL1_EC_UNKNOWN	// unknown exception in EL0
+	cmp	x24, #ESR_ELx_EC_UNKNOWN	// unknown exception in EL0
 	b.eq	el0_undef
-	cmp	x24, #ESR_EL1_EC_BREAKPT_EL0	// debug exception in EL0
+	cmp	x24, #ESR_ELx_EC_BREAKPT_LOW	// debug exception in EL0
 	b.ge	el0_dbg
 	b	el0_inv
 
@@ -403,30 +403,30 @@ el0_sync:
 el0_sync_compat:
 	kernel_entry 0, 32
 	mrs	x25, esr_el1			// read the syndrome register
-	lsr	x24, x25, #ESR_EL1_EC_SHIFT	// exception class
-	cmp	x24, #ESR_EL1_EC_SVC32		// SVC in 32-bit state
+	lsr	x24, x25, #ESR_ELx_EC_SHIFT	// exception class
+	cmp	x24, #ESR_ELx_EC_SVC32		// SVC in 32-bit state
 	b.eq	el0_svc_compat
-	cmp	x24, #ESR_EL1_EC_DABT_EL0	// data abort in EL0
+	cmp	x24, #ESR_ELx_EC_DABT_LOW	// data abort in EL0
 	b.eq	el0_da
-	cmp	x24, #ESR_EL1_EC_IABT_EL0	// instruction abort in EL0
+	cmp	x24, #ESR_ELx_EC_IABT_LOW	// instruction abort in EL0
 	b.eq	el0_ia
-	cmp	x24, #ESR_EL1_EC_FP_ASIMD	// FP/ASIMD access
+	cmp	x24, #ESR_ELx_EC_FP_ASIMD	// FP/ASIMD access
 	b.eq	el0_fpsimd_acc
-	cmp	x24, #ESR_EL1_EC_FP_EXC32	// FP/ASIMD exception
+	cmp	x24, #ESR_ELx_EC_FP_EXC32	// FP/ASIMD exception
 	b.eq	el0_fpsimd_exc
-	cmp	x24, #ESR_EL1_EC_UNKNOWN	// unknown exception in EL0
+	cmp	x24, #ESR_ELx_EC_UNKNOWN	// unknown exception in EL0
 	b.eq	el0_undef
-	cmp	x24, #ESR_EL1_EC_CP15_32	// CP15 MRC/MCR trap
+	cmp	x24, #ESR_ELx_EC_CP15_32	// CP15 MRC/MCR trap
 	b.eq	el0_undef
-	cmp	x24, #ESR_EL1_EC_CP15_64	// CP15 MRRC/MCRR trap
+	cmp	x24, #ESR_ELx_EC_CP15_64	// CP15 MRRC/MCRR trap
 	b.eq	el0_undef
-	cmp	x24, #ESR_EL1_EC_CP14_MR	// CP14 MRC/MCR trap
+	cmp	x24, #ESR_ELx_EC_CP14_MR	// CP14 MRC/MCR trap
 	b.eq	el0_undef
-	cmp	x24, #ESR_EL1_EC_CP14_LS	// CP14 LDC/STC trap
+	cmp	x24, #ESR_ELx_EC_CP14_LS	// CP14 LDC/STC trap
 	b.eq	el0_undef
-	cmp	x24, #ESR_EL1_EC_CP14_64	// CP14 MRRC/MCRR trap
+	cmp	x24, #ESR_ELx_EC_CP14_64	// CP14 MRRC/MCRR trap
 	b.eq	el0_undef
-	cmp	x24, #ESR_EL1_EC_BREAKPT_EL0	// debug exception in EL0
+	cmp	x24, #ESR_ELx_EC_BREAKPT_LOW	// debug exception in EL0
 	b.ge	el0_dbg
 	b	el0_inv
 el0_svc_compat:
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index 5a1ba6e..192d900 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -501,7 +501,7 @@ static int compat_setup_sigframe(struct compat_sigframe __user *sf,
 
 	__put_user_error((compat_ulong_t)0, &sf->uc.uc_mcontext.trap_no, err);
 	/* set the compat FSR WnR */
-	__put_user_error(!!(current->thread.fault_code & ESR_EL1_WRITE) <<
+	__put_user_error(!!(current->thread.fault_code & ESR_ELx_WNR) <<
 			 FSR_WRITE_SHIFT, &sf->uc.uc_mcontext.error_code, err);
 	__put_user_error(current->thread.fault_address, &sf->uc.uc_mcontext.fault_address, err);
 	__put_user_error(set->sig[0], &sf->uc.uc_mcontext.oldmask, err);
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index c11cd27..96da131 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -219,7 +219,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 
 	if (esr & ESR_LNX_EXEC) {
 		vm_flags = VM_EXEC;
-	} else if ((esr & ESR_EL1_WRITE) && !(esr & ESR_EL1_CM)) {
+	} else if ((esr & ESR_ELx_WNR) && !(esr & ESR_ELx_CM)) {
 		vm_flags = VM_WRITE;
 		mm_flags |= FAULT_FLAG_WRITE;
 	}
-- 
1.9.1
