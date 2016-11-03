From: mark.rutland@arm.com (Mark Rutland)
Date: Thu,  3 Nov 2016 20:23:09 +0000
Subject: [PATCHv2 07/11] arm64: move sp_el0 and tpidr_el1 into cpu_suspend_ctx
In-Reply-To: <1478204593-29145-1-git-send-email-mark.rutland@arm.com>
References: <1478204593-29145-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1478204593-29145-8-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When returning from idle, we rely on the fact that thread_info lives at
the end of the kernel stack, and restore this by masking the saved stack
pointer. Subsequent patches will sever the relationship between the
stack and thread_info, and to cater for this we must save/restore sp_el0
explicitly, storing it in cpu_suspend_ctx.

As cpu_suspend_ctx must be doubleword aligned, this leaves us with an
extra slot in cpu_suspend_ctx. We can use this to save/restore tpidr_el1
in the same way, which simplifies the code, avoiding pointer chasing on
the restore path (as we no longer need to load thread_info::cpu followed
by the relevant slot in __per_cpu_offset based on this).

This patch stashes both registers in cpu_suspend_ctx.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/suspend.h | 2 +-
 arch/arm64/kernel/sleep.S        | 3 ---
 arch/arm64/kernel/suspend.c      | 6 ------
 arch/arm64/mm/proc.S             | 6 ++++++
 4 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/suspend.h b/arch/arm64/include/asm/suspend.h
index b8a313f..de5600f 100644
--- a/arch/arm64/include/asm/suspend.h
+++ b/arch/arm64/include/asm/suspend.h
@@ -1,7 +1,7 @@
 #ifndef __ASM_SUSPEND_H
 #define __ASM_SUSPEND_H
 
-#define NR_CTX_REGS 10
+#define NR_CTX_REGS 12
 #define NR_CALLEE_SAVED_REGS 12
 
 /*
diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
index 1bec41b..df67652 100644
--- a/arch/arm64/kernel/sleep.S
+++ b/arch/arm64/kernel/sleep.S
@@ -125,9 +125,6 @@ ENTRY(_cpu_resume)
 	/* load sp from context */
 	ldr	x2, [x0, #CPU_CTX_SP]
 	mov	sp, x2
-	/* save thread_info */
-	and	x2, x2, #~(THREAD_SIZE - 1)
-	msr	sp_el0, x2
 	/*
 	 * cpu_do_resume expects x0 to contain context address pointer
 	 */
diff --git a/arch/arm64/kernel/suspend.c b/arch/arm64/kernel/suspend.c
index bb0cd78..1e3be90 100644
--- a/arch/arm64/kernel/suspend.c
+++ b/arch/arm64/kernel/suspend.c
@@ -47,12 +47,6 @@ void notrace __cpu_suspend_exit(void)
 	cpu_uninstall_idmap();
 
 	/*
-	 * Restore per-cpu offset before any kernel
-	 * subsystem relying on it has a chance to run.
-	 */
-	set_my_cpu_offset(per_cpu_offset(cpu));
-
-	/*
 	 * PSTATE was not saved over suspend/resume, re-enable any detected
 	 * features that might not have been set correctly.
 	 */
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 352c73b..6a853a8 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -70,11 +70,14 @@ ENTRY(cpu_do_suspend)
 	mrs	x8, mdscr_el1
 	mrs	x9, oslsr_el1
 	mrs	x10, sctlr_el1
+	mrs	x11, tpidr_el1
+	mrs	x12, sp_el0
 	stp	x2, x3, [x0]
 	stp	x4, xzr, [x0, #16]
 	stp	x5, x6, [x0, #32]
 	stp	x7, x8, [x0, #48]
 	stp	x9, x10, [x0, #64]
+	stp	x11, x12, [x0, #80]
 	ret
 ENDPROC(cpu_do_suspend)
 
@@ -90,6 +93,7 @@ ENTRY(cpu_do_resume)
 	ldp	x6, x8, [x0, #32]
 	ldp	x9, x10, [x0, #48]
 	ldp	x11, x12, [x0, #64]
+	ldp	x13, x14, [x0, #80]
 	msr	tpidr_el0, x2
 	msr	tpidrro_el0, x3
 	msr	contextidr_el1, x4
@@ -112,6 +116,8 @@ ENTRY(cpu_do_resume)
 	msr	mdscr_el1, x10
 
 	msr	sctlr_el1, x12
+	msr	tpidr_el1, x13
+	msr	sp_el0, x14
 	/*
 	 * Restore oslsr_el1 by writing oslar_el1
 	 */
-- 
2.7.4
