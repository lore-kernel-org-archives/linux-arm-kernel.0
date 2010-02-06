From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 6 Feb 2010 11:41:03 +0000
Subject: [RFC PATCH v2 1/2] ARM: VFP: add support to sync the VFP state
	of the current thread
In-Reply-To: <20100206113249.GA17198@n2100.arm.linux.org.uk>
References: <b8a1d37c5f981cdd2e83c9fd98198832324cd57c.1265315249.git.imre.deak@nokia.com>
	<b8a1d37c5f981cdd2e83c9fd98198832324cd57d.1265315249.git.imre.deak@nokia.com>
	<20100206103230.GC1923@n2100.arm.linux.org.uk>
	<20100206112048.GD1923@n2100.arm.linux.org.uk>
	<20100206113249.GA17198@n2100.arm.linux.org.uk>
Message-ID: <20100206114103.GB17198@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 06, 2010 at 11:32:49AM +0000, Russell King - ARM Linux wrote:
> On Sat, Feb 06, 2010 at 11:20:48AM +0000, Russell King - ARM Linux wrote:
> > +		/*
> > +		 * Save the last VFP state on this CPU.
> > +		 */
> > +		fmxr(FPEXC, fpexc | FPEXC_EN);
> > +		vfp_save_state(&thread->vfpstate, fpexc | FPEXC_EN);
> > +		fmxr(FPEXC, fpexc);
> 
> Erm, slight correction here:
> 
> +		fmxr(FPEXC, fpexc & ~FPEXC_EN);

And finally... let's improve the ptrace code to allow more efficient
monitoring of VFP state.  There's no point invalidating the hardware
context just because we want to inspect the VFP state via ptrace.

diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index 2dfb7d7..b74970e 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -115,7 +115,8 @@ extern void iwmmxt_task_restore(struct thread_info *, void *);
 extern void iwmmxt_task_release(struct thread_info *);
 extern void iwmmxt_task_switch(struct thread_info *);
 
-extern void vfp_sync_state(struct thread_info *thread);
+extern void vfp_sync_hwstate(struct thread_info *);
+extern void vfp_flush_hwstate(struct thread_info *);
 
 #endif
 
diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index bdf002b..08f899f 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -700,7 +700,7 @@ static int ptrace_getvfpregs(struct task_struct *tsk, void __user *data)
 	union vfp_state *vfp = &thread->vfpstate;
 	struct user_vfp __user *ufp = data;
 
-	vfp_sync_state(thread);
+	vfp_sync_hwstate(thread);
 
 	/* copy the floating point registers */
 	if (copy_to_user(&ufp->fpregs, &vfp->hard.fpregs,
@@ -723,7 +723,7 @@ static int ptrace_setvfpregs(struct task_struct *tsk, void __user *data)
 	union vfp_state *vfp = &thread->vfpstate;
 	struct user_vfp __user *ufp = data;
 
-	vfp_sync_state(thread);
+	vfp_sync_hwstate(thread);
 
 	/* copy the floating point registers */
 	if (copy_from_user(&vfp->hard.fpregs, &ufp->fpregs,
@@ -734,6 +734,8 @@ static int ptrace_setvfpregs(struct task_struct *tsk, void __user *data)
 	if (get_user(vfp->hard.fpscr, &ufp->fpscr))
 		return -EFAULT;
 
+	vfp_flush_hwstate(thread);
+
 	return 0;
 }
 #endif
diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 86a57ae..f61c622 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -430,7 +430,11 @@ static inline void vfp_pm_init(void) { }
  * saved one. This function is used by the ptrace mechanism.
  */
 #ifdef CONFIG_SMP
-void vfp_sync_state(struct thread_info *thread)
+void vfp_sync_hwstate(struct thread_info *thread)
+{
+}
+
+void vfp_flush_hwstate(struct thread_info *thread)
 {
 	/*
 	 * On SMP systems, the VFP state is automatically saved at every
@@ -441,7 +445,7 @@ void vfp_sync_state(struct thread_info *thread)
 	thread->vfpstate.hard.cpu = NR_CPUS;
 }
 #else
-void vfp_sync_state(struct thread_info *thread)
+void vfp_sync_hwstate(struct thread_info *thread)
 {
 	unsigned int cpu = get_cpu();
 
@@ -457,6 +461,23 @@ void vfp_sync_state(struct thread_info *thread)
 		 */
 		fmxr(FPEXC, fpexc | FPEXC_EN);
 		vfp_save_state(&thread->vfpstate, fpexc | FPEXC_EN);
+		fmxr(FPEXC, fpexc);
+	}
+
+	put_cpu();
+}
+
+void vfp_flush_hwstate(struct thread_info *thread)
+{
+	unsigned int cpu = get_cpu();
+
+	/*
+	 * If the thread we're interested in is the current owner of the
+	 * hardware VFP state, then we need to save its state.
+	 */
+	if (last_VFP_context[cpu] == &thread->vfpstate) {
+		u32 fpexc = fmrx(FPEXC);
+
 		fmxr(FPEXC, fpexc & ~FPEXC_EN);
 
 		/*
