From: imre.deak@nokia.com (imre.deak at nokia.com)
Date: Mon, 29 Mar 2010 19:17:38 +0300
Subject: [RFC PATCH v3 1/3] ARM: VFP: add support to sync the VFP state of the
	current thread
In-Reply-To: <b8a1d37c5f981cdd2e83c9fd98198832324cd57c.1265315249.git.imre.deak@nokia.com>
References: <b8a1d37c5f981cdd2e83c9fd98198832324cd57c.1265315249.git.imre.deak@nokia.com>
Message-ID: <fe02173137c086adc6f8ad5372441898864b0815.1269878482.git.imre.deak@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Imre Deak <imre.deak@nokia.com>

So far vfp_sync_state worked only for threads other than the current
one. This worked for tracing other threads, but not for PTRACE_TRACEME.
Syncing for the current thread will also be needed by an upcoming patch
adding support for VFP context save / restore around signal handlers.

Also break the current vfp_sync_state into vfp_{save/restore}_hwstate
to make things more efficient.

Based on a patch from Russell King.

Signed-off-by: Imre Deak <imre.deak@nokia.com>
---
 arch/arm/include/asm/thread_info.h |    3 +-
 arch/arm/kernel/ptrace.c           |    6 ++-
 arch/arm/vfp/vfpmodule.c           |   71 +++++++++++++++++++-----------------
 3 files changed, 44 insertions(+), 36 deletions(-)

diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index 2dfb7d7..1d7f4d5 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -115,7 +115,8 @@ extern void iwmmxt_task_restore(struct thread_info *, void *);
 extern void iwmmxt_task_release(struct thread_info *);
 extern void iwmmxt_task_switch(struct thread_info *);
 
-extern void vfp_sync_state(struct thread_info *thread);
+extern void vfp_save_hwstate(struct thread_info *);
+extern void vfp_restore_hwstate(struct thread_info *);
 
 #endif
 
diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index a2ea385..1b1096e 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -669,7 +669,7 @@ static int ptrace_getvfpregs(struct task_struct *tsk, void __user *data)
 	union vfp_state *vfp = &thread->vfpstate;
 	struct user_vfp __user *ufp = data;
 
-	vfp_sync_state(thread);
+	vfp_save_hwstate(thread);
 
 	/* copy the floating point registers */
 	if (copy_to_user(&ufp->fpregs, &vfp->hard.fpregs,
@@ -692,7 +692,7 @@ static int ptrace_setvfpregs(struct task_struct *tsk, void __user *data)
 	union vfp_state *vfp = &thread->vfpstate;
 	struct user_vfp __user *ufp = data;
 
-	vfp_sync_state(thread);
+	vfp_save_hwstate(thread);
 
 	/* copy the floating point registers */
 	if (copy_from_user(&vfp->hard.fpregs, &ufp->fpregs,
@@ -703,6 +703,8 @@ static int ptrace_setvfpregs(struct task_struct *tsk, void __user *data)
 	if (get_user(vfp->hard.fpscr, &ufp->fpscr))
 		return -EFAULT;
 
+	vfp_restore_hwstate(thread);
+
 	return 0;
 }
 #endif
diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 96abd0f..760cbb2 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -393,54 +393,59 @@ static void vfp_pm_init(void)
 static inline void vfp_pm_init(void) { }
 #endif /* CONFIG_PM */
 
-/*
- * Synchronise the hardware VFP state of a thread other than current with the
- * saved one. This function is used by the ptrace mechanism.
- */
-#ifdef CONFIG_SMP
-void vfp_sync_state(struct thread_info *thread)
+void vfp_save_hwstate(struct thread_info *thread)
 {
+	unsigned int cpu = get_cpu();
+
 	/*
-	 * On SMP systems, the VFP state is automatically saved at every
-	 * context switch. We mark the thread VFP state as belonging to a
-	 * non-existent CPU so that the saved one will be reloaded when
-	 * needed.
+	 * If the thread we're interested in is the current owner of the
+	 * hardware VFP state, then we need to save its state.
 	 */
-	thread->vfpstate.hard.cpu = NR_CPUS;
+	if (last_VFP_context[cpu] == &thread->vfpstate) {
+		u32 fpexc = fmrx(FPEXC);
+
+		/*
+		 * Save the last VFP state on this CPU.
+		 */
+		fmxr(FPEXC, fpexc | FPEXC_EN);
+		vfp_save_state(&thread->vfpstate, fpexc | FPEXC_EN);
+		fmxr(FPEXC, fpexc);
+	}
+
+	put_cpu();
 }
-#else
-void vfp_sync_state(struct thread_info *thread)
+
+void vfp_restore_hwstate(struct thread_info *thread)
 {
 	unsigned int cpu = get_cpu();
-	u32 fpexc = fmrx(FPEXC);
 
 	/*
-	 * If VFP is enabled, the previous state was already saved and
-	 * last_VFP_context updated.
+	 * If the thread we're interested in is the current owner of the
+	 * hardware VFP state, then we need to restore its state.
 	 */
-	if (fpexc & FPEXC_EN)
-		goto out;
-
-	if (!last_VFP_context[cpu])
-		goto out;
+	if (last_VFP_context[cpu] == &thread->vfpstate) {
+		u32 fpexc = fmrx(FPEXC);
 
-	/*
-	 * Save the last VFP state on this CPU.
-	 */
-	fmxr(FPEXC, fpexc | FPEXC_EN);
-	vfp_save_state(last_VFP_context[cpu], fpexc);
-	fmxr(FPEXC, fpexc);
+		fmxr(FPEXC, fpexc & ~FPEXC_EN);
 
+		/*
+		 * Set the context to NULL to force a reload the next time the
+		 * thread uses the VFP.
+		 */
+		last_VFP_context[cpu] = NULL;
+	}
+#ifdef CONFIG_SMP
 	/*
-	 * Set the context to NULL to force a reload the next time the thread
-	 * uses the VFP.
+	 * For SMP we still have to take care of the case where the thread
+	 * migrates to another CPU and then back to the original CPU on which
+	 * the last VFP user is still the same thread. Mark the thread VFP
+	 * state as belonging to a non-existent CPU so that the saved one will
+	 * be reloaded in the above case.
 	 */
-	last_VFP_context[cpu] = NULL;
-
-out:
+	thread->vfpstate.hard.cpu = NR_CPUS;
+#endif
 	put_cpu();
 }
-#endif
 
 #include <linux/smp.h>
 
-- 
1.7.0.2
