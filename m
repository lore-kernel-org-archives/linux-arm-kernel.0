From: james.morse@arm.com (James Morse)
Date: Fri, 12 Aug 2016 19:11:20 +0100
Subject: [stable:PATCH 2/2] arm64: kernel: Save and restore addr_limit on
 exception entry
In-Reply-To: <1471025480-10394-1-git-send-email-james.morse@arm.com>
References: <1471025480-10394-1-git-send-email-james.morse@arm.com>
Message-ID: <1471025480-10394-2-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit e19a6ee2460bdd0d0055a6029383422773f9999a upstream.

If we take an exception while at EL1, the exception handler inherits
the original context's addr_limit value. To be consistent always reset
addr_limit and PSTATE.UAO on (re-)entry to EL1. This prevents accidental
re-use of the original context's addr_limit.

Based on a similar patch for arm from Russell King.

Acked-by: Will Deacon <will.deacon@arm.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
[ backport to stop perf misusing inherited addr_limit.
  Removed code interacting with UAO and the irqstack ]
Link: https://bugs.chromium.org/p/project-zero/issues/detail?id=822
Signed-off-by: James Morse <james.morse@arm.com>
Cc: <stable@vger.kernel.org> #4.4
---
 arch/arm64/include/asm/ptrace.h |  2 ++
 arch/arm64/kernel/asm-offsets.c |  1 +
 arch/arm64/kernel/entry.S       | 15 ++++++++++++++-
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index a307eb6e7fa8..7f94755089e2 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -117,6 +117,8 @@ struct pt_regs {
 	};
 	u64 orig_x0;
 	u64 syscallno;
+	u64 orig_addr_limit;
+	u64 unused;	// maintain 16 byte alignment
 };
 
 #define arch_has_single_step()	(1)
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 25de8b244961..087cf9a65359 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -58,6 +58,7 @@ int main(void)
   DEFINE(S_PC,			offsetof(struct pt_regs, pc));
   DEFINE(S_ORIG_X0,		offsetof(struct pt_regs, orig_x0));
   DEFINE(S_SYSCALLNO,		offsetof(struct pt_regs, syscallno));
+  DEFINE(S_ORIG_ADDR_LIMIT,	offsetof(struct pt_regs, orig_addr_limit));
   DEFINE(S_FRAME_SIZE,		sizeof(struct pt_regs));
   BLANK();
   DEFINE(MM_CONTEXT_ID,		offsetof(struct mm_struct, context.id.counter));
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 7ed3d75f6304..5a3753d09e20 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -27,6 +27,7 @@
 #include <asm/cpufeature.h>
 #include <asm/errno.h>
 #include <asm/esr.h>
+#include <asm/memory.h>
 #include <asm/thread_info.h>
 #include <asm/unistd.h>
 
@@ -93,7 +94,13 @@
 	disable_step_tsk x19, x20		// exceptions when scheduling.
 	.else
 	add	x21, sp, #S_FRAME_SIZE
-	.endif
+	get_thread_info tsk
+	/* Save the task's original addr_limit and set USER_DS (TASK_SIZE_64) */
+	ldr	x20, [tsk, #TI_ADDR_LIMIT]
+	str	x20, [sp, #S_ORIG_ADDR_LIMIT]
+	mov	x20, #TASK_SIZE_64
+	str	x20, [tsk, #TI_ADDR_LIMIT]
+	.endif /* \el == 0 */
 	mrs	x22, elr_el1
 	mrs	x23, spsr_el1
 	stp	lr, x21, [sp, #S_LR]
@@ -117,6 +124,12 @@
 	.endm
 
 	.macro	kernel_exit, el
+	.if	\el != 0
+	/* Restore the task's original addr_limit. */
+	ldr	x20, [sp, #S_ORIG_ADDR_LIMIT]
+	str	x20, [tsk, #TI_ADDR_LIMIT]
+	.endif
+
 	ldp	x21, x22, [sp, #S_PC]		// load ELR, SPSR
 	.if	\el == 0
 	ct_user_enter
-- 
2.8.0.rc3
