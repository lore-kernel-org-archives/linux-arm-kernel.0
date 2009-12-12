From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 12 Dec 2009 13:57:37 +0000
Subject: [PATCH 3/6] Fix a race in the vfp_notifier() function on SMP
	systems
In-Reply-To: <20091212122447.GA30537@n2100.arm.linux.org.uk>
References: <20091207135603.30429.74812.stgit@pc1117.cambridge.arm.com>
	<20091207141325.30429.13315.stgit@pc1117.cambridge.arm.com>
	<20091212122447.GA30537@n2100.arm.linux.org.uk>
Message-ID: <20091212135737.GB30537@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 12, 2009 at 12:24:47PM +0000, Russell King - ARM Linux wrote:
> On Mon, Dec 07, 2009 at 02:13:34PM +0000, Catalin Marinas wrote:
> > The vfp_notifier(THREAD_NOTIFY_RELEASE) maybe be called with thread->cpu
> > different from the current one, causing a race condition with both the
> > THREAD_NOTIFY_SWITCH path and vfp_support_entry().
> 
> The only call where thread->cpu may not be the current CPU is in the
> THREAD_NOFTIFY_RELEASE case.
> 
> When called in the THREAD_NOTIFY_SWITCH case, we are switching to the
> specified thread, and thread->cpu better be smp_processor_id() or else
> we're saving our CPUs VFP state into some other CPUs currently running
> thread.
> 
> Not only that, but the thread we're switching away from will still be
> 'owned' by the CPU we're running on, and can't be scheduled onto another
> CPU without this function first completing, nor can it be flushed nor
> released.

Here's a patch which adds this documentation, and fixes the
THREAD_NOTIFY_FLUSH case - since that could be preempted.

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 2d7423a..aed05bc 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -38,16 +38,72 @@ union vfp_state *last_VFP_context[NR_CPUS];
  */
 unsigned int VFP_arch;
 
+/*
+ * Per-thread VFP initialization.
+ */
+static void vfp_thread_flush(struct thread_info *thread)
+{
+	union vfp_state *vfp = &thread->vfpstate;
+	unsigned int cpu;
+
+	memset(vfp, 0, sizeof(union vfp_state));
+
+	vfp->hard.fpexc = FPEXC_EN;
+	vfp->hard.fpscr = FPSCR_ROUND_NEAREST;
+
+	/*
+	 * Disable VFP to ensure we initialize it first.  We must ensure
+	 * that the modification of last_VFP_context[] and hardware disable
+	 * are done for the same CPU and without preemption.
+	 */
+	cpu = get_cpu();
+	if (last_VFP_context[cpu] == vfp)
+		last_VFP_context[cpu] = NULL;
+	fmxr(FPEXC, fmrx(FPEXC) & ~FPEXC_EN);
+	put_cpu();
+}
+
+static void vfp_thread_release(struct thread_info *thread)
+{
+	/* release case: Per-thread VFP cleanup. */
+	union vfp_state *vfp = &thread->vfpstate;
+	unsigned int cpu = thread->cpu;
+
+	if (last_VFP_context[cpu] == vfp)
+		last_VFP_context[cpu] = NULL;
+}
+
+/*
+ * When this function is called with the following 'cmd's, the following
+ * is true while this function is being run:
+ *  THREAD_NOFTIFY_SWTICH:
+ *   - the previously running thread will not be scheduled onto another CPU.
+ *   - the next thread to be run (v) will not be running on another CPU.
+ *   - thread->cpu is the local CPU number
+ *   - not preemptible as we're called in the middle of a thread switch
+ *  THREAD_NOTIFY_FLUSH:
+ *   - the thread (v) will be running on the local CPU, so
+ *	v === current_thread_info()
+ *   - thread->cpu is the local CPU number at the time it is accessed,
+ *	but may change at any time.
+ *   - we could be preempted if tree preempt rcu is enabled, so
+ *	it is unsafe to use thread->cpu.
+ *  THREAD_NOTIFY_RELEASE:
+ *   - the thread (v) will not be running on any CPU; it is a dead thread.
+ *   - thread->cpu will be the last CPU the thread ran on, which may not
+ *	be the current CPU.
+ *   - we could be preempted if tree preempt rcu is enabled.
+ */
 static int vfp_notifier(struct notifier_block *self, unsigned long cmd, void *v)
 {
 	struct thread_info *thread = v;
-	union vfp_state *vfp;
-	__u32 cpu = thread->cpu;
 
 	if (likely(cmd == THREAD_NOTIFY_SWITCH)) {
 		u32 fpexc = fmrx(FPEXC);
 
 #ifdef CONFIG_SMP
+		unsigned int cpu = thread->cpu;
+
 		/*
 		 * On SMP, if VFP is enabled, save the old state in
 		 * case the thread migrates to a different CPU. The
@@ -74,25 +130,10 @@ static int vfp_notifier(struct notifier_block *self, unsigned long cmd, void *v)
 		return NOTIFY_DONE;
 	}
 
-	vfp = &thread->vfpstate;
-	if (cmd == THREAD_NOTIFY_FLUSH) {
-		/*
-		 * Per-thread VFP initialisation.
-		 */
-		memset(vfp, 0, sizeof(union vfp_state));
-
-		vfp->hard.fpexc = FPEXC_EN;
-		vfp->hard.fpscr = FPSCR_ROUND_NEAREST;
-
-		/*
-		 * Disable VFP to ensure we initialise it first.
-		 */
-		fmxr(FPEXC, fmrx(FPEXC) & ~FPEXC_EN);
-	}
-
-	/* flush and release case: Per-thread VFP cleanup. */
-	if (last_VFP_context[cpu] == vfp)
-		last_VFP_context[cpu] = NULL;
+	if (cmd == THREAD_NOTIFY_FLUSH)
+		vfp_thread_flush(thread);
+	else
+		vfp_thread_release(thread);
 
 	return NOTIFY_DONE;
 }
