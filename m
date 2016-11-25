From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 25 Nov 2016 19:39:11 +0000
Subject: [RFC PATCH 23/29] arm64/sve: Move ZEN handling to the common
 task_fpsimd_load() path
In-Reply-To: <1480102762-23647-1-git-send-email-Dave.Martin@arm.com>
References: <1480102762-23647-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1480102762-23647-24-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, ZEN is handled only in fpsimd_restore_current_state(),
which is not sufficient since it applies only in certain
situations.

Since all the relevant paths call task_fpsimd_load(), this patch
moves the ZEN handling there.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/asm/thread_info.h |  1 +
 arch/arm64/kernel/fpsimd.c           | 48 +++++++++++++++++++-----------------
 2 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 2deac86..6819d08 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -133,6 +133,7 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
 #define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
+#define _TIF_SVE		(1 << TIF_SVE)
 #define _TIF_32BIT		(1 << TIF_32BIT)
 
 #define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index cad86e5..5834f81 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -102,21 +102,24 @@ void do_fpsimd_acc(unsigned int esr, struct pt_regs *regs)
 #ifdef CONFIG_ARM64_SVE
 
 static void task_fpsimd_to_sve(struct task_struct *task);
+static void task_fpsimd_load(struct task_struct *task);
 
 void do_sve_acc(unsigned int esr, struct pt_regs *regs)
 {
-	unsigned long tmp;
+	if (test_and_set_thread_flag(TIF_SVE)) {
+		unsigned long tmp;
+
+		asm ("mrs %0, cpacr_el1" : "=r" (tmp));
 
-	if (test_and_set_thread_flag(TIF_SVE))
+		printk(KERN_INFO "%s: Strange, ZEN=%u\n",
+		       __func__, (unsigned int)((tmp >> 16) & 3));
 		BUG();
+	}
 
 	BUG_ON(is_compat_task());
 
 	task_fpsimd_to_sve(current);
-
-	asm ("mrs %0, cpacr_el1" : "=r" (tmp));
-	asm volatile ("msr cpacr_el1, %0" :: "r" (tmp | (1 << 17)));
-	/* Serialised by exception return to user */
+	task_fpsimd_load(current);
 }
 
 #endif /* CONFIG_ARM64_SVE */
@@ -178,6 +181,23 @@ static void task_fpsimd_load(struct task_struct *task)
 			       &task->thread.fpsimd_state.fpsr);
 	else
 		fpsimd_load_state(&task->thread.fpsimd_state);
+
+	/*
+	 * Flip SVE enable for userspace if it doesn't match the
+	 * current_task.
+	 */
+	if (IS_ENABLED(CONFIG_ARM64_SVE) && (elf_hwcap & HWCAP_SVE)) {
+		unsigned int tmp, flags;
+
+		asm ("mrs %0, cpacr_el1" : "=r" (tmp));
+		flags = task_thread_info(task)->flags;
+		BUILD_BUG_ON(_TIF_SVE != CPACR_EL1_ZEN_EL0EN);
+		if ((tmp ^ (unsigned long)flags) & _TIF_SVE) {
+			tmp ^= _TIF_SVE;
+			asm volatile ("msr cpacr_el1, %0" :: "r" (tmp));
+			/* Serialised by exception return to user */
+		}
+	}
 }
 
 static void task_fpsimd_save(struct task_struct *task)
@@ -306,27 +326,11 @@ void fpsimd_restore_current_state(void)
 {
 	preempt_disable();
 	if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
-		unsigned long tmp;
-		unsigned long flags;
-
 		struct fpsimd_state *st = &current->thread.fpsimd_state;
 
 		task_fpsimd_load(current);
 		this_cpu_write(fpsimd_last_state, st);
 		st->cpu = smp_processor_id();
-
-		if (IS_ENABLED(CONFIG_ARM64_SVE)) {
-			/*
-			 * Flip SVE enable for userspace if it doesn't
-			 * match the current_task.
-			 */
-			asm ("mrs %0, cpacr_el1" : "=r" (tmp));
-			flags = current_thread_info()->flags;
-			if ((tmp ^ (unsigned long)flags) & (1 << 17)) {
-				tmp ^= 1 << 17;
-				asm volatile ("msr cpacr_el1, %0" :: "r" (tmp));
-			}
-		}
 	}
 	preempt_enable();
 }
-- 
2.1.4
