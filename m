From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Dec 2009 14:47:28 +0000
Subject: [PATCH] ARM: Fix a race in the vfp_notifier() function on SMP
	systems
In-Reply-To: <20091218142503.GB32481@n2100.arm.linux.org.uk>
References: <20091218134423.21279.93962.stgit@pc1117.cambridge.arm.com>
	<20091218141100.GA32481@n2100.arm.linux.org.uk>
	<20091218142503.GB32481@n2100.arm.linux.org.uk>
Message-ID: <20091218144728.GC32481@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2009 at 02:25:03PM +0000, Russell King - ARM Linux wrote:
> On Fri, Dec 18, 2009 at 02:11:00PM +0000, Russell King - ARM Linux wrote:
> > On Fri, Dec 18, 2009 at 01:45:09PM +0000, Catalin Marinas wrote:
> > > 	(patch updated following Russell's changes to vfpmodule.c)
> > > 
> > > The vfp_notifier(THREAD_NOTIFY_RELEASE) maybe be called with thread->cpu
> > > different from the current one, causing a race condition with both the
> > > THREAD_NOTIFY_SWITCH path and vfp_support_entry().
> > 
> > How about we provide THREAD_NOTIFY_EXIT and call these hooks from
> > exit_thread() - we'll be calling the notifier when the thread is
> > still running, and so thread->cpu will be the local CPU.
> > 
> > This should be much safer all round, and give much simpler semantics
> > if we NULL out the current CPU's last_VFP_context pointer.  It also
> > means that each CPUs last_VFP_context pointer is only ever accessed
> > from the local CPU, which can only be a good thing.
> 
> Something like this:

Actually, I think we should go further and kill off THREAD_NOTIFY_RELEASE
completely.  Added a few more people because EP93xx and PXA (well,
Xscale) is now impacted by this change.

[PATCH] ARM: Convert VFP/Crunch/XscaleCP thread_release() to exit_thread()

This avoids races in the VFP code where the dead thread may have
state on another CPU.  By moving this code to exit_thread(), we
will be running as the thread, and therefore be running on the
current CPU.

This means that we can ensure that the only local state is accessed
in the thread notifiers.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/thread_notify.h |    2 +-
 arch/arm/kernel/crunch.c             |    2 +-
 arch/arm/kernel/process.c            |   12 +++++-------
 arch/arm/kernel/xscale-cp0.c         |    2 +-
 arch/arm/vfp/vfpmodule.c             |   21 ++++++++++++---------
 5 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/arch/arm/include/asm/thread_notify.h b/arch/arm/include/asm/thread_notify.h
index f27379d..c4391ba 100644
--- a/arch/arm/include/asm/thread_notify.h
+++ b/arch/arm/include/asm/thread_notify.h
@@ -41,7 +41,7 @@ static inline void thread_notify(unsigned long rc, struct thread_info *thread)
  * These are the reason codes for the thread notifier.
  */
 #define THREAD_NOTIFY_FLUSH	0
-#define THREAD_NOTIFY_RELEASE	1
+#define THREAD_NOTIFY_EXIT	1
 #define THREAD_NOTIFY_SWITCH	2
 
 #endif
diff --git a/arch/arm/kernel/crunch.c b/arch/arm/kernel/crunch.c
index 769abe1..25ef223 100644
--- a/arch/arm/kernel/crunch.c
+++ b/arch/arm/kernel/crunch.c
@@ -51,7 +51,7 @@ static int crunch_do(struct notifier_block *self, unsigned long cmd, void *t)
 		 * initialised state information on the first fault.
 		 */
 
-	case THREAD_NOTIFY_RELEASE:
+	case THREAD_NOTIFY_EXIT:
 		crunch_task_release(thread);
 		break;
 
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 0d96d01..6730413 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -274,17 +274,18 @@ void show_regs(struct pt_regs * regs)
 	__backtrace();
 }
 
+ATOMIC_NOTIFIER_HEAD(thread_notify_head);
+
+EXPORT_SYMBOL_GPL(thread_notify_head);
+
 /*
  * Free current thread data structures etc..
  */
 void exit_thread(void)
 {
+	thread_notify(THREAD_NOTIFY_EXIT, current_thread_info());
 }
 
-ATOMIC_NOTIFIER_HEAD(thread_notify_head);
-
-EXPORT_SYMBOL_GPL(thread_notify_head);
-
 void flush_thread(void)
 {
 	struct thread_info *thread = current_thread_info();
@@ -299,9 +300,6 @@ void flush_thread(void)
 
 void release_thread(struct task_struct *dead_task)
 {
-	struct thread_info *thread = task_thread_info(dead_task);
-
-	thread_notify(THREAD_NOTIFY_RELEASE, thread);
 }
 
 asmlinkage void ret_from_fork(void) __asm__("ret_from_fork");
diff --git a/arch/arm/kernel/xscale-cp0.c b/arch/arm/kernel/xscale-cp0.c
index 17127db..1796157 100644
--- a/arch/arm/kernel/xscale-cp0.c
+++ b/arch/arm/kernel/xscale-cp0.c
@@ -70,7 +70,7 @@ static int iwmmxt_do(struct notifier_block *self, unsigned long cmd, void *t)
 		 * initialised state information on the first fault.
 		 */
 
-	case THREAD_NOTIFY_RELEASE:
+	case THREAD_NOTIFY_EXIT:
 		iwmmxt_task_release(thread);
 		break;
 
diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index aed05bc..3b0a5dd 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -63,14 +63,15 @@ static void vfp_thread_flush(struct thread_info *thread)
 	put_cpu();
 }
 
-static void vfp_thread_release(struct thread_info *thread)
+static void vfp_thread_exit(struct thread_info *thread)
 {
 	/* release case: Per-thread VFP cleanup. */
 	union vfp_state *vfp = &thread->vfpstate;
-	unsigned int cpu = thread->cpu;
+	unsigned int cpu = get_cpu();
 
 	if (last_VFP_context[cpu] == vfp)
 		last_VFP_context[cpu] = NULL;
+	put_cpu();
 }
 
 /*
@@ -88,11 +89,13 @@ static void vfp_thread_release(struct thread_info *thread)
  *	but may change at any time.
  *   - we could be preempted if tree preempt rcu is enabled, so
  *	it is unsafe to use thread->cpu.
- *  THREAD_NOTIFY_RELEASE:
- *   - the thread (v) will not be running on any CPU; it is a dead thread.
- *   - thread->cpu will be the last CPU the thread ran on, which may not
- *	be the current CPU.
- *   - we could be preempted if tree preempt rcu is enabled.
+ *  THREAD_NOTIFY_EXIT
+ *   - the thread (v) will be running on the local CPU, so
+ *	v === current_thread_info()
+ *   - thread->cpu is the local CPU number at the time it is accessed,
+ *	but may change at any time.
+ *   - we could be preempted if tree preempt rcu is enabled, so
+ *	it is unsafe to use thread->cpu.
  */
 static int vfp_notifier(struct notifier_block *self, unsigned long cmd, void *v)
 {
@@ -132,8 +135,8 @@ static int vfp_notifier(struct notifier_block *self, unsigned long cmd, void *v)
 
 	if (cmd == THREAD_NOTIFY_FLUSH)
 		vfp_thread_flush(thread);
-	else
-		vfp_thread_release(thread);
+	else if (cmd == THREAD_NOTIFY_EXIT)
+		vfp_thread_exit(thread);
 
 	return NOTIFY_DONE;
 }
-- 
1.6.2.5
