From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 19 Jul 2013 17:45:29 +0100
Subject: [PATCH v2] arm: Fix deferred mm switch on VIVT processors
Message-ID: <1374252329-5345-1-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As of commit b9d4d42ad9 (ARM: Remove __ARCH_WANT_INTERRUPTS_ON_CTXSW on
pre-ARMv6 CPUs), the mm switching on VIVT processors is done in the
finish_arch_post_lock_switch() function to avoid whole cache flushing
with interrupts disabled. The need for deferred mm switch is stored as a
thread flag (TIF_SWITCH_MM). However, with preemption enabled, we can
have another thread switch before finish_arch_post_lock_switch(). If the
new thread has the same mm as the previous 'next' thread, the scheduler
will not call switch_mm() and the TIF_SWITCH_MM flag won't be set for
the new thread.

This patch moves the switch pending flag to the mm_context_t structure
since this is specific to the mm rather than thread.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: <stable@vger.kernel.org> # 3.5+
---

That's version 2 following Russell's comments. It now disables the
preemption around cpu_switch_mm(). The preempt enabling is done with
no_resched as we are already at the end of a thread switch.

Marc, I dropped your Tested-by since this is a modified patch. Please
let me know if it works for you.

Thanks.

 arch/arm/include/asm/mmu.h         |  2 ++
 arch/arm/include/asm/mmu_context.h | 20 ++++++++++++++++----
 arch/arm/include/asm/thread_info.h |  1 -
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/mmu.h b/arch/arm/include/asm/mmu.h
index e3d5554..d1b4998 100644
--- a/arch/arm/include/asm/mmu.h
+++ b/arch/arm/include/asm/mmu.h
@@ -6,6 +6,8 @@
 typedef struct {
 #ifdef CONFIG_CPU_HAS_ASID
 	atomic64_t	id;
+#else
+	int		switch_pending;
 #endif
 	unsigned int	vmalloc_seq;
 } mm_context_t;
diff --git a/arch/arm/include/asm/mmu_context.h b/arch/arm/include/asm/mmu_context.h
index b5792b7..9b32f76 100644
--- a/arch/arm/include/asm/mmu_context.h
+++ b/arch/arm/include/asm/mmu_context.h
@@ -56,7 +56,7 @@ static inline void check_and_switch_context(struct mm_struct *mm,
 		 * on non-ASID CPUs, the old mm will remain valid until the
 		 * finish_arch_post_lock_switch() call.
 		 */
-		set_ti_thread_flag(task_thread_info(tsk), TIF_SWITCH_MM);
+		mm->context.switch_pending = 1;
 	else
 		cpu_switch_mm(mm->pgd, mm);
 }
@@ -65,9 +65,21 @@ static inline void check_and_switch_context(struct mm_struct *mm,
 	finish_arch_post_lock_switch
 static inline void finish_arch_post_lock_switch(void)
 {
-	if (test_and_clear_thread_flag(TIF_SWITCH_MM)) {
-		struct mm_struct *mm = current->mm;
-		cpu_switch_mm(mm->pgd, mm);
+	struct mm_struct *mm = current->mm;
+
+	if (mm && mm->context.switch_pending) {
+		/*
+		 * Preemption must be disabled during cpu_switch_mm() as we
+		 * have some stateful cache flush implementations. Check
+		 * switch_pending again in case we were preempted and the
+		 * switch to this mm was already done.
+		 */
+		preempt_disable();
+		if (mm->context.switch_pending) {
+			mm->context.switch_pending = 0;
+			cpu_switch_mm(mm->pgd, mm);
+		}
+		preempt_enable_no_resched();
 	}
 }
 
diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index 214d415..2b8114f 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -156,7 +156,6 @@ extern int vfp_restore_user_hwstate(struct user_vfp __user *,
 #define TIF_USING_IWMMXT	17
 #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
 #define TIF_RESTORE_SIGMASK	20
-#define TIF_SWITCH_MM		22	/* deferred switch_mm */
 
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
