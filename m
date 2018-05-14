From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 14 May 2018 10:46:33 +0100
Subject: [PATCH 11/18] arm64: zero GPRs upon entry from EL0
In-Reply-To: <20180514094640.27569-1-mark.rutland@arm.com>
References: <20180514094640.27569-1-mark.rutland@arm.com>
Message-ID: <20180514094640.27569-12-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can zero GPRs x0 - x29 upon entry from EL0 to make it harder for
userspace to control values consumed by speculative gadgets.

We don't blat x30, since this is stashed much later, and we'll blat it
before invoking C code.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/entry.S | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 13afefbf608f..4dd529fd03fd 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -62,6 +62,12 @@
 #endif
 	.endm
 
+	.macro	clear_gp_regs
+	.irp	n,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29
+	mov	x\n, xzr
+	.endr
+	.endm
+
 /*
  * Bad Abort numbers
  *-----------------
@@ -158,12 +164,11 @@ alternative_else_nop_endif
 	stp	x28, x29, [sp, #16 * 14]
 
 	.if	\el == 0
+	clear_gp_regs
 	mrs	x21, sp_el0
 	ldr_this_cpu	tsk, __entry_task, x20	// Ensure MDSCR_EL1.SS is clear,
 	ldr	x19, [tsk, #TSK_TI_FLAGS]	// since we can unmask debug
 	disable_step_tsk x19, x20		// exceptions when scheduling.
-
-	mov	x29, xzr			// fp pointed to user-space
 	.else
 	add	x21, sp, #S_FRAME_SIZE
 	get_thread_info tsk
-- 
2.11.0
