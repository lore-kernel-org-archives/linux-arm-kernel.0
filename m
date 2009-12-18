From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 18 Dec 2009 13:45:09 +0000
Subject: [PATCH] ARM: Fix a race in the vfp_notifier() function on SMP systems
Message-ID: <20091218134423.21279.93962.stgit@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	(patch updated following Russell's changes to vfpmodule.c)

The vfp_notifier(THREAD_NOTIFY_RELEASE) maybe be called with thread->cpu
different from the current one, causing a race condition with both the
THREAD_NOTIFY_SWITCH path and vfp_support_entry().

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/vfp/vfpmodule.c |   23 ++++++++++++++++++++---
 1 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index aed05bc..2828767 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -69,8 +69,19 @@ static void vfp_thread_release(struct thread_info *thread)
 	union vfp_state *vfp = &thread->vfpstate;
 	unsigned int cpu = thread->cpu;
 
+#ifndef CONFIG_SMP
 	if (last_VFP_context[cpu] == vfp)
 		last_VFP_context[cpu] = NULL;
+#else
+	/*
+	 * Since release_thread() may be called from a different CPU, we use
+	 * cmpxchg() here to avoid a race with the vfp_support_entry() code
+	 * which modifies last_VFP_context[cpu]. Note that on SMP systems, a
+	 * STR instruction on a different CPU clears the global exclusive
+	 * monitor state.
+	 */
+	(void)cmpxchg(&last_VFP_context[cpu], vfp, NULL);
+#endif
 }
 
 /*
@@ -105,13 +116,19 @@ static int vfp_notifier(struct notifier_block *self, unsigned long cmd, void *v)
 		unsigned int cpu = thread->cpu;
 
 		/*
+		 * The vfpstate structure pointed to by last_VFP_context[cpu]
+		 * may be released via call_rcu(delayed_put_task_struct) but
+		 * atomic_notifier_call_chain() already holds the RCU lock.
+		 */
+		vfp = last_VFP_context[cpu];
+		/*
 		 * On SMP, if VFP is enabled, save the old state in
 		 * case the thread migrates to a different CPU. The
 		 * restoring is done lazily.
 		 */
-		if ((fpexc & FPEXC_EN) && last_VFP_context[cpu]) {
-			vfp_save_state(last_VFP_context[cpu], fpexc);
-			last_VFP_context[cpu]->hard.cpu = cpu;
+		if ((fpexc & FPEXC_EN) && vfp) {
+			vfp_save_state(vfp, fpexc);
+			vfp->hard.cpu = cpu;
 		}
 		/*
 		 * Thread migration, just force the reloading of the
