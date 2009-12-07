From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 07 Dec 2009 14:13:34 +0000
Subject: [PATCH 3/6] Fix a race in the vfp_notifier() function on SMP systems
In-Reply-To: <20091207135603.30429.74812.stgit@pc1117.cambridge.arm.com>
References: <20091207135603.30429.74812.stgit@pc1117.cambridge.arm.com>
Message-ID: <20091207141325.30429.13315.stgit@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The vfp_notifier(THREAD_NOTIFY_RELEASE) maybe be called with thread->cpu
different from the current one, causing a race condition with both the
THREAD_NOTIFY_SWITCH path and vfp_support_entry().

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/vfp/vfpmodule.c |   25 ++++++++++++++++++++++---
 1 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 2d7423a..fa6692a 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -14,6 +14,7 @@
 #include <linux/signal.h>
 #include <linux/sched.h>
 #include <linux/init.h>
+#include <linux/rcupdate.h>
 
 #include <asm/thread_notify.h>
 #include <asm/vfp.h>
@@ -49,14 +50,21 @@ static int vfp_notifier(struct notifier_block *self, unsigned long cmd, void *v)
 
 #ifdef CONFIG_SMP
 		/*
+		 * RCU locking is needed in case last_VFP_context[cpu] is
+		 * released on a different CPU.
+		 */
+		rcu_read_lock();
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
+		rcu_read_unlock();
 		/*
 		 * Thread migration, just force the reloading of the
 		 * state on the new CPU in case the VFP registers
@@ -91,8 +99,19 @@ static int vfp_notifier(struct notifier_block *self, unsigned long cmd, void *v)
 	}
 
 	/* flush and release case: Per-thread VFP cleanup. */
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
 
 	return NOTIFY_DONE;
 }
