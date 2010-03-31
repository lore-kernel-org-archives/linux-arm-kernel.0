From: imre.deak@nokia.com (imre.deak at nokia.com)
Date: Thu,  1 Apr 2010 00:23:24 +0300
Subject: [RFC PATCH v4 1/3] ARM: VFP: fix the SMP versions of vfp_{sync,
	flush}_hwstate
In-Reply-To: <1269879460-1038-1-git-send-email-imre.deak@nokia.com>
References: <1269879460-1038-1-git-send-email-imre.deak@nokia.com>
Message-ID: <cd3af9e47c866f29d3b58958e041a5a46609c7dd.1270066971.git.imre.deak@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Imre Deak <imre.deak@nokia.com>

Recently the UP versions of these functions were refactored and as
a side effect it became possible to call them for the current thread.
This isn't true for the SMP versions however, so fix this up.

Signed-off-by: Imre Deak <imre.deak@nokia.com>
---
 arch/arm/vfp/vfpmodule.c |   31 ++++++++++---------------------
 1 files changed, 10 insertions(+), 21 deletions(-)

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 7f3f59f..477f240 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -428,26 +428,6 @@ static void vfp_pm_init(void)
 static inline void vfp_pm_init(void) { }
 #endif /* CONFIG_PM */
 
-/*
- * Synchronise the hardware VFP state of a thread other than current with the
- * saved one. This function is used by the ptrace mechanism.
- */
-#ifdef CONFIG_SMP
-void vfp_sync_hwstate(struct thread_info *thread)
-{
-}
-
-void vfp_flush_hwstate(struct thread_info *thread)
-{
-	/*
-	 * On SMP systems, the VFP state is automatically saved at every
-	 * context switch. We mark the thread VFP state as belonging to a
-	 * non-existent CPU so that the saved one will be reloaded when
-	 * needed.
-	 */
-	thread->vfpstate.hard.cpu = NR_CPUS;
-}
-#else
 void vfp_sync_hwstate(struct thread_info *thread)
 {
 	unsigned int cpu = get_cpu();
@@ -490,9 +470,18 @@ void vfp_flush_hwstate(struct thread_info *thread)
 		last_VFP_context[cpu] = NULL;
 	}
 
+#ifdef CONFIG_SMP
+	/*
+	 * For SMP we still have to take care of the case where the thread
+	 * migrates to another CPU and then back to the original CPU on which
+	 * the last VFP user is still the same thread. Mark the thread VFP
+	 * state as belonging to a non-existent CPU so that the saved one will
+	 * be reloaded in the above case.
+	 */
+	thread->vfpstate.hard.cpu = NR_CPUS;
+#endif
 	put_cpu();
 }
-#endif
 
 #include <linux/smp.h>
 
-- 
1.7.0.2
