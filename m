From: imre.deak@nokia.com (Imre Deak)
Date: Thu, 4 Feb 2010 23:38:02 +0200
Subject: [RFC PATCH v2 1/2] ARM: VFP: add support to sync the VFP state of
	the current thread
In-Reply-To: <b8a1d37c5f981cdd2e83c9fd98198832324cd57c.1265315249.git.imre.deak@nokia.com>
References: <b8a1d37c5f981cdd2e83c9fd98198832324cd57c.1265315249.git.imre.deak@nokia.com>
Message-ID: <b8a1d37c5f981cdd2e83c9fd98198832324cd57d.1265315249.git.imre.deak@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So far vfp_sync_state worked only for threads other than the current
one. This worked for tracing other threads, but not for PTRACE_TRACEME.
Syncing for the current thread will also be needed by an upcoming patch
adding support for VFP context save / restore around signal handlers.

For SMP we need get_cpu now, since we have to protect the FPEXC
register, other than this things remained the same for threads other
than the current.

Signed-off-by: Imre Deak <imre.deak@nokia.com>
---
 arch/arm/vfp/vfpmodule.c |   46 +++++++++++++++++++++++++++++++---------------
 1 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index f60a540..d0b6e98 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -426,12 +426,19 @@ static inline void vfp_pm_init(void) { }
 #endif /* CONFIG_PM */
 
 /*
- * Synchronise the hardware VFP state of a thread other than current with the
- * saved one. This function is used by the ptrace mechanism.
+ * Synchronise the hardware VFP state of a thread with the saved one.
+ * This function is used by the ptrace mechanism and the signal handler path.
  */
-#ifdef CONFIG_SMP
 void vfp_sync_state(struct thread_info *thread)
 {
+	unsigned int cpu = get_cpu();
+	u32 fpexc = fmrx(FPEXC);
+	int vfp_enabled;
+	int self;
+
+	vfp_enabled = fpexc & FPEXC_EN;
+	self = thread == current_thread_info();
+#ifdef CONFIG_SMP
 	/*
 	 * On SMP systems, the VFP state is automatically saved at every
 	 * context switch. We mark the thread VFP state as belonging to a
@@ -439,18 +446,22 @@ void vfp_sync_state(struct thread_info *thread)
 	 * needed.
 	 */
 	thread->vfpstate.hard.cpu = NR_CPUS;
-}
-#else
-void vfp_sync_state(struct thread_info *thread)
-{
-	unsigned int cpu = get_cpu();
-	u32 fpexc = fmrx(FPEXC);
-
 	/*
-	 * If VFP is enabled, the previous state was already saved and
-	 * last_VFP_context updated.
+	 * Only the current thread's saved VFP context can be out-of-date.
+	 * For others there is nothing else to do, since we already ensured
+	 * force loading above.
 	 */
-	if (fpexc & FPEXC_EN)
+	if (!self)
+		goto out;
+#endif
+	/*
+	 * If the VFP is enabled only the current thread's saved VFP
+	 * context can get out-of-date. For other threads the context
+	 * was updated when the current thread started to use the VFP.
+	 * This also means that the context will be reloaded next time
+	 * the thread uses the VFP, so no need to enforce it.
+	 */
+	if (vfp_enabled && !self)
 		goto out;
 
 	if (!last_VFP_context[cpu])
@@ -459,8 +470,14 @@ void vfp_sync_state(struct thread_info *thread)
 	/*
 	 * Save the last VFP state on this CPU.
 	 */
-	fmxr(FPEXC, fpexc | FPEXC_EN);
+	if (!vfp_enabled)
+		fmxr(FPEXC, fpexc | FPEXC_EN);
 	vfp_save_state(last_VFP_context[cpu], fpexc);
+	/*
+	 * Disable VFP in case it was enabled so that the force reload
+	 * can happen.
+	 */
+	fpexc &= ~FPEXC_EN;
 	fmxr(FPEXC, fpexc);
 
 	/*
@@ -472,7 +489,6 @@ void vfp_sync_state(struct thread_info *thread)
 out:
 	put_cpu();
 }
-#endif
 
 #include <linux/smp.h>
 
-- 
1.6.6
