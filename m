From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 14 Dec 2009 16:28:52 +0000
Subject: [PATCH 3/6] Fix a race in the vfp_notifier() function on
	SMPsystems
In-Reply-To: <1260792913.17159.66.camel@pc1117.cambridge.arm.com>
References: <20091207135603.30429.74812.stgit@pc1117.cambridge.arm.com>
	<20091207141325.30429.13315.stgit@pc1117.cambridge.arm.com>
	<20091212122447.GA30537@n2100.arm.linux.org.uk>
	<1260792913.17159.66.camel@pc1117.cambridge.arm.com>
Message-ID: <1260808132.17159.118.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2009-12-14 at 12:15 +0000, Catalin Marinas wrote:
> On Sat, 2009-12-12 at 12:24 +0000, Russell King - ARM Linux wrote:
> > On Mon, Dec 07, 2009 at 02:13:34PM +0000, Catalin Marinas wrote:
> > >             /*
> > > +            * RCU locking is needed in case last_VFP_context[cpu] is
> > > +            * released on a different CPU.
> > > +            */
> > > +           rcu_read_lock();
[...]
> > Not only that, but this notifier is already called under the RCU lock,
> > so this is a no-op.
[...]
> If the region is RCU locked anyway, we can simply add a comment but
> unless we change how last_CPU_context is set, we still need this check.

I updated patch below which doesn't take the RCU lock but adds a
comment.

Apart from the last hunk with which you are OK, the patch makes sure
that last_VFP_context[cpu] is only read once and stored to a local
variable otherwise you may have the surprise that it becomes NULL if the
thread that was using it is released on a different CPU (that's actually
the failure we were getting under stress testing).


Fix a race in the vfp_notifier() function on SMP systems

From: Catalin Marinas <catalin.marinas@arm.com>

The vfp_notifier(THREAD_NOTIFY_RELEASE) maybe be called with thread->cpu
different from the current one, causing a race condition with both the
THREAD_NOTIFY_SWITCH path and vfp_support_entry().

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/vfp/vfpmodule.c |   26 +++++++++++++++++++++++---
 1 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 2d7423a..8d1fe44 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -14,6 +14,7 @@
 #include <linux/signal.h>
 #include <linux/sched.h>
 #include <linux/init.h>
+#include <linux/rcupdate.h>
 
 #include <asm/thread_notify.h>
 #include <asm/vfp.h>
@@ -49,14 +50,22 @@ static int vfp_notifier(struct notifier_block *self, unsigned long cmd, void *v)
 
 #ifdef CONFIG_SMP
 		/*
+		 * The vfpstate structure pointed to by last_VFP_context[cpu]
+		 * may be released via call_rcu(delayed_put_task_struct) but
+		 * atomic_notifier_call_chain() already holds the RCU lock.
+		 */
+		vfp = last_VFP_context[cpu];
+
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
+
 		/*
 		 * Thread migration, just force the reloading of the
 		 * state on the new CPU in case the VFP registers
@@ -91,8 +100,19 @@ static int vfp_notifier(struct notifier_block *self, unsigned long cmd, void *v)
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

-- 
Catalin
