From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 25 Nov 2016 19:39:09 +0000
Subject: [RFC PATCH 21/29] arm64/sve: Enable SVE on demand for userspace
In-Reply-To: <1480102762-23647-1-git-send-email-Dave.Martin@arm.com>
References: <1480102762-23647-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1480102762-23647-22-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch tracks whether a task has ever attempted to use the
Scalable Vector Extension.  If and only if SVE is in use by a task,
it will be enabled for userspace when scheduling the task in.  For
other tasks, SVE is disabled when scheduling in.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/asm/thread_info.h |  1 +
 arch/arm64/kernel/entry.S            | 18 +++++++++++++++++-
 arch/arm64/kernel/fpsimd.c           | 30 ++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index e9ea5a6..2deac86 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -117,6 +117,7 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_SYSCALL_AUDIT	9
 #define TIF_SYSCALL_TRACEPOINT	10
 #define TIF_SECCOMP		11
+#define TIF_SVE			17	/* Scalable Vector Extension in use */
 #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
 #define TIF_FREEZE		19
 #define TIF_RESTORE_SIGMASK	20
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 223d54a..fe20560 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -465,6 +465,10 @@ el0_sync:
 	b.eq	el0_ia
 	cmp	x24, #ESR_ELx_EC_FP_ASIMD	// FP/ASIMD access
 	b.eq	el0_fpsimd_acc
+#ifdef CONFIG_ARM64_SVE
+	cmp	x24, #ESR_ELx_EC_SVE		// SVE access
+	b.eq	el0_sve_acc
+#endif
 	cmp	x24, #ESR_ELx_EC_FP_EXC64	// FP/ASIMD exception
 	b.eq	el0_fpsimd_exc
 	cmp	x24, #ESR_ELx_EC_SYS64		// configurable trap
@@ -563,9 +567,21 @@ el0_fpsimd_acc:
 	mov	x1, sp
 	bl	do_fpsimd_acc
 	b	ret_to_user
+#ifdef CONFIG_ARM64_SVE
+	/*
+	 * Scalable Vector Extension access
+	 */
+el0_sve_acc:
+	enable_dbg
+	ct_user_exit
+	mov	x0, x25
+	mov	x1, sp
+	bl	do_sve_acc
+	b	ret_to_user
+#endif
 el0_fpsimd_exc:
 	/*
-	 * Floating Point or Advanced SIMD exception
+	 * Floating Point, Advanced SIMD or SVE exception
 	 */
 	enable_dbg
 	ct_user_exit
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index cda079e..40566a9 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -99,6 +99,20 @@ void do_fpsimd_acc(unsigned int esr, struct pt_regs *regs)
 	WARN_ON(1);
 }
 
+#ifdef CONFIG_ARM64_SVE
+void do_sve_acc(unsigned int esr, struct pt_regs *regs)
+{
+	unsigned long tmp;
+
+	if (test_and_set_thread_flag(TIF_SVE))
+		BUG();
+
+	asm ("mrs %0, cpacr_el1" : "=r" (tmp));
+	asm volatile ("msr cpacr_el1, %0" :: "r" (tmp | (1 << 17)));
+	/* Serialised by exception return to user */
+}
+#endif
+
 /*
  * Raise a SIGFPE for the current process.
  */
@@ -283,11 +297,27 @@ void fpsimd_restore_current_state(void)
 {
 	preempt_disable();
 	if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
+		unsigned long tmp;
+		unsigned long flags;
+
 		struct fpsimd_state *st = &current->thread.fpsimd_state;
 
 		task_fpsimd_load(current);
 		this_cpu_write(fpsimd_last_state, st);
 		st->cpu = smp_processor_id();
+
+		if (IS_ENABLED(CONFIG_ARM64_SVE)) {
+			/*
+			 * Flip SVE enable for userspace if it doesn't
+			 * match the current_task.
+			 */
+			asm ("mrs %0, cpacr_el1" : "=r" (tmp));
+			flags = current_thread_info()->flags;
+			if ((tmp ^ (unsigned long)flags) & (1 << 17)) {
+				tmp ^= 1 << 17;
+				asm volatile ("msr cpacr_el1, %0" :: "r" (tmp));
+			}
+		}
 	}
 	preempt_enable();
 }
-- 
2.1.4
