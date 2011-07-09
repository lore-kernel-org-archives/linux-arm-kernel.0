From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 09 Jul 2011 17:33:31 +0100
Subject: [PATCH 3/3] ARM: vfp: fix a hole in VFP thread migration
In-Reply-To: <20110709163207.GN4812@n2100.arm.linux.org.uk>
References: <20110709163207.GN4812@n2100.arm.linux.org.uk>
Message-ID: <E1QfaTD-0006QO-SR@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix a hole in the VFP thread migration.  Lets define two threads.

Thread 1, we'll call 'interesting_thread' which is a thread which is
running on CPU0, using VFP (so vfp_current_hw_state[0] =
&interesting_thread->vfpstate) and gets migrated off to CPU1, where
it continues execution of VFP instructions.

Thread 2, we'll call 'new_cpu0_thread' which is the thread which takes
over on CPU0.  This has also been using VFP, and last used VFP on CPU0,
but doesn't use it again.

The following code will be executed twice:

		cpu = thread->cpu;

		/*
		 * On SMP, if VFP is enabled, save the old state in
		 * case the thread migrates to a different CPU. The
		 * restoring is done lazily.
		 */
		if ((fpexc & FPEXC_EN) && vfp_current_hw_state[cpu]) {
			vfp_save_state(vfp_current_hw_state[cpu], fpexc);
			vfp_current_hw_state[cpu]->hard.cpu = cpu;
		}
		/*
		 * Thread migration, just force the reloading of the
		 * state on the new CPU in case the VFP registers
		 * contain stale data.
		 */
		if (thread->vfpstate.hard.cpu != cpu)
			vfp_current_hw_state[cpu] = NULL;

The first execution will be on CPU0 to switch away from 'interesting_thread'.
interesting_thread->cpu will be 0.

So, vfp_current_hw_state[0] points at interesting_thread->vfpstate.
The hardware state will be saved, along with the CPU number (0) that
it was executing on.

'thread' will be 'new_cpu0_thread' with new_cpu0_thread->cpu = 0.
Also, because it was executing on CPU0, new_cpu0_thread->vfpstate.hard.cpu = 0,
and so the thread migration check is not triggered.

This means that vfp_current_hw_state[0] remains pointing at interesting_thread.

The second execution will be on CPU1 to switch _to_ 'interesting_thread'.
So, 'thread' will be 'interesting_thread' and interesting_thread->cpu now
will be 1.  The previous thread executing on CPU1 is not relevant to this
so we shall ignore that.

We get to the thread migration check.  Here, we discover that
interesting_thread->vfpstate.hard.cpu = 0, yet interesting_thread->cpu is
now 1, indicating thread migration.  We set vfp_current_hw_state[1] to
NULL.

So, at this point vfp_current_hw_state[] contains the following:

[0] = &interesting_thread->vfpstate
[1] = NULL

Our interesting thread now executes a VFP instruction, takes a fault
which loads the state into the VFP hardware.  Now, through the assembly
we now have:

[0] = &interesting_thread->vfpstate
[1] = &interesting_thread->vfpstate

CPU1 stops due to ptrace (and so saves its VFP state) using the thread
switch code above), and CPU0 calls vfp_sync_hwstate().

	if (vfp_current_hw_state[cpu] == &thread->vfpstate) {
		vfp_save_state(&thread->vfpstate, fpexc | FPEXC_EN);

BANG, we corrupt interesting_thread's VFP state by overwriting the
more up-to-date state saved by CPU1 with the old VFP state from CPU0.

Fix this by ensuring that we have sane semantics for the various state
describing variables:

1. vfp_current_hw_state[] points to the current owner of the context
   information stored in each CPUs hardware, or NULL if that state
   information is invalid.
2. thread->vfpstate.hard.cpu always contains the most recent CPU number
   which the state was loaded into or NR_CPUS if no CPU owns the state.

So, for a particular CPU to be a valid owner of the VFP state for a
particular thread t, two things must be true:

 vfp_current_hw_state[cpu] == &t->vfpstate && t->vfpstate.hard.cpu == cpu.

and that is valid from the moment a CPU loads the saved VFP context
into the hardware.  This gives clear and consistent semantics to
interpreting these variables.

This patch also fixes thread copying, ensuring that t->vfpstate.hard.cpu
is invalidated, otherwise CPU0 may believe it was the last owner.  The
hole can happen thus:

- thread1 runs on CPU2 using VFP, migrates to CPU3, exits and thread_info
  freed.
- New thread allocated from a previously running thread on CPU2, reusing
  memory for thread1 and copying vfp.hard.cpu.

At this point, the following are true:

	new_thread1->vfpstate.hard.cpu == 2
	&new_thread1->vfpstate == vfp_current_hw_state[2]

Lastly, this also addresses thread flushing in a similar way to thread
copying.  Hole is:

- thread runs on CPU0, using VFP, migrates to CPU1 but does not use VFP.
- thread calls execve(), so thread flush happens, leaving
  vfp_current_hw_state[0] intact.  This vfpstate is memset to 0 causing
  thread->vfpstate.hard.cpu = 0.
- thread migrates back to CPU0 before using VFP.

At this point, the following are true:

	thread->vfpstate.hard.cpu == 0
	&thread->vfpstate == vfp_current_hw_state[0]

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/asm-offsets.c |    3 +
 arch/arm/vfp/vfphw.S          |   43 ++++++++++++++----
 arch/arm/vfp/vfpmodule.c      |   98 ++++++++++++++++++++++-------------------
 3 files changed, 89 insertions(+), 55 deletions(-)

diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index 927522c..16baba2 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -59,6 +59,9 @@ int main(void)
   DEFINE(TI_TP_VALUE,		offsetof(struct thread_info, tp_value));
   DEFINE(TI_FPSTATE,		offsetof(struct thread_info, fpstate));
   DEFINE(TI_VFPSTATE,		offsetof(struct thread_info, vfpstate));
+#ifdef CONFIG_SMP
+  DEFINE(VFP_CPU,		offsetof(union vfp_state, hard.cpu));
+#endif
 #ifdef CONFIG_ARM_THUMBEE
   DEFINE(TI_THUMBEE_STATE,	offsetof(struct thread_info, thumbee_state));
 #endif
diff --git a/arch/arm/vfp/vfphw.S b/arch/arm/vfp/vfphw.S
index 404538a..2d30c7f 100644
--- a/arch/arm/vfp/vfphw.S
+++ b/arch/arm/vfp/vfphw.S
@@ -82,19 +82,22 @@ ENTRY(vfp_support_entry)
 	ldr	r4, [r3, r11, lsl #2]	@ vfp_current_hw_state pointer
 	bic	r5, r1, #FPEXC_EX	@ make sure exceptions are disabled
 	cmp	r4, r10			@ this thread owns the hw context?
+#ifndef CONFIG_SMP
+	@ For UP, checking that this thread owns the hw context is
+	@ sufficient to determine that the hardware state is valid.
 	beq	vfp_hw_state_valid
 
+	@ On UP, we lazily save the VFP context.  As a different
+	@ thread wants ownership of the VFP hardware, save the old
+	@ state if there was a previous (valid) owner.
+
 	VFPFMXR	FPEXC, r5		@ enable VFP, disable any pending
 					@ exceptions, so we can get at the
 					@ rest of it
 
-#ifndef CONFIG_SMP
-	@ Save out the current registers to the old thread state
-	@ No need for SMP since this is not done lazily
-
 	DBGSTR1	"save old state %p", r4
-	cmp	r4, #0
-	beq	no_old_VFP_process
+	cmp	r4, #0			@ if the vfp_current_hw_state is NULL
+	beq	vfp_reload_hw		@ then the hw state needs reloading
 	VFPFSTMIA r4, r5		@ save the working registers
 	VFPFMRX	r5, FPSCR		@ current status
 #ifndef CONFIG_CPU_FEROCEON
@@ -107,11 +110,33 @@ ENTRY(vfp_support_entry)
 1:
 #endif
 	stmia	r4, {r1, r5, r6, r8}	@ save FPEXC, FPSCR, FPINST, FPINST2
-					@ and point r4 at the word at the
-					@ start of the register dump
+vfp_reload_hw:
+
+#else
+	@ For SMP, if this thread does not own the hw context, then we
+	@ need to reload it.  No need to save the old state as on SMP,
+	@ we always save the state when we switch away from a thread.
+	bne	vfp_reload_hw
+
+	@ This thread has ownership of the current hardware context.
+	@ However, it may have been migrated to another CPU, in which
+	@ case the saved state is newer than the hardware context.
+	@ Check this by looking at the CPU number which the state was
+	@ last loaded onto.
+	ldr	ip, [r10, #VFP_CPU]
+	teq	ip, r11
+	beq	vfp_hw_state_valid
+
+vfp_reload_hw:
+	@ We're loading this threads state into the VFP hardware. Update
+	@ the CPU number which contains the most up to date VFP context.
+	str	r11, [r10, #VFP_CPU]
+
+	VFPFMXR	FPEXC, r5		@ enable VFP, disable any pending
+					@ exceptions, so we can get at the
+					@ rest of it
 #endif
 
-no_old_VFP_process:
 	DBGSTR1	"load state %p", r10
 	str	r10, [r3, r11, lsl #2]	@ update the vfp_current_hw_state pointer
 					@ Load the saved state back into the VFP
diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 36403511..08ff93f 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -35,18 +35,51 @@ void vfp_null_entry(void);
 void (*vfp_vector)(void) = vfp_null_entry;
 
 /*
+ * Dual-use variable.
+ * Used in startup: set to non-zero if VFP checks fail
+ * After startup, holds VFP architecture
+ */
+unsigned int VFP_arch;
+
+/*
  * The pointer to the vfpstate structure of the thread which currently
  * owns the context held in the VFP hardware, or NULL if the hardware
  * context is invalid.
+ *
+ * For UP, this is sufficient to tell which thread owns the VFP context.
+ * However, for SMP, we also need to check the CPU number stored in the
+ * saved state too to catch migrations.
  */
 union vfp_state *vfp_current_hw_state[NR_CPUS];
 
 /*
- * Dual-use variable.
- * Used in startup: set to non-zero if VFP checks fail
- * After startup, holds VFP architecture
+ * Is 'thread's most up to date state stored in this CPUs hardware?
+ * Must be called from non-preemptible context.
  */
-unsigned int VFP_arch;
+static bool vfp_state_in_hw(unsigned int cpu, struct thread_info *thread)
+{
+#ifdef CONFIG_SMP
+	if (thread->vfpstate.hard.cpu != cpu)
+		return false;
+#endif
+	return vfp_current_hw_state[cpu] == &thread->vfpstate;
+}
+
+/*
+ * Force a reload of the VFP context from the thread structure.  We do
+ * this by ensuring that access to the VFP hardware is disabled, and
+ * clear last_VFP_context.  Must be called from non-preemptible context.
+ */
+static void vfp_force_reload(unsigned int cpu, struct thread_info *thread)
+{
+	if (vfp_state_in_hw(cpu, thread)) {
+		fmxr(FPEXC, fmrx(FPEXC) & ~FPEXC_EN);
+		vfp_current_hw_state[cpu] = NULL;
+	}
+#ifdef CONFIG_SMP
+	thread->vfpstate.hard.cpu = NR_CPUS;
+#endif
+}
 
 /*
  * Per-thread VFP initialization.
@@ -60,6 +93,9 @@ static void vfp_thread_flush(struct thread_info *thread)
 
 	vfp->hard.fpexc = FPEXC_EN;
 	vfp->hard.fpscr = FPSCR_ROUND_NEAREST;
+#ifdef CONFIG_SMP
+	vfp->hard.cpu = NR_CPUS;
+#endif
 
 	/*
 	 * Disable VFP to ensure we initialize it first.  We must ensure
@@ -90,6 +126,9 @@ static void vfp_thread_copy(struct thread_info *thread)
 
 	vfp_sync_hwstate(parent);
 	thread->vfpstate = parent->vfpstate;
+#ifdef CONFIG_SMP
+	thread->vfpstate.hard.cpu = NR_CPUS;
+#endif
 }
 
 /*
@@ -135,17 +174,8 @@ static int vfp_notifier(struct notifier_block *self, unsigned long cmd, void *v)
 		 * case the thread migrates to a different CPU. The
 		 * restoring is done lazily.
 		 */
-		if ((fpexc & FPEXC_EN) && vfp_current_hw_state[cpu]) {
+		if ((fpexc & FPEXC_EN) && vfp_current_hw_state[cpu])
 			vfp_save_state(vfp_current_hw_state[cpu], fpexc);
-			vfp_current_hw_state[cpu]->hard.cpu = cpu;
-		}
-		/*
-		 * Thread migration, just force the reloading of the
-		 * state on the new CPU in case the VFP registers
-		 * contain stale data.
-		 */
-		if (thread->vfpstate.hard.cpu != cpu)
-			vfp_current_hw_state[cpu] = NULL;
 #endif
 
 		/*
@@ -449,15 +479,15 @@ static void vfp_pm_init(void)
 static inline void vfp_pm_init(void) { }
 #endif /* CONFIG_PM */
 
+/*
+ * Ensure that the VFP state stored in 'thread->vfpstate' is up to date
+ * with the hardware state.
+ */
 void vfp_sync_hwstate(struct thread_info *thread)
 {
 	unsigned int cpu = get_cpu();
 
-	/*
-	 * If the thread we're interested in is the current owner of the
-	 * hardware VFP state, then we need to save its state.
-	 */
-	if (vfp_current_hw_state[cpu] == &thread->vfpstate) {
+	if (vfp_state_in_hw(cpu, thread)) {
 		u32 fpexc = fmrx(FPEXC);
 
 		/*
@@ -471,36 +501,13 @@ void vfp_sync_hwstate(struct thread_info *thread)
 	put_cpu();
 }
 
+/* Ensure that the thread reloads the hardware VFP state on the next use. */
 void vfp_flush_hwstate(struct thread_info *thread)
 {
 	unsigned int cpu = get_cpu();
 
-	/*
-	 * If the thread we're interested in is the current owner of the
-	 * hardware VFP state, then we need to save its state.
-	 */
-	if (vfp_current_hw_state[cpu] == &thread->vfpstate) {
-		u32 fpexc = fmrx(FPEXC);
+	vfp_force_reload(cpu, thread);
 
-		fmxr(FPEXC, fpexc & ~FPEXC_EN);
-
-		/*
-		 * Set the context to NULL to force a reload the next time
-		 * the thread uses the VFP.
-		 */
-		vfp_current_hw_state[cpu] = NULL;
-	}
-
-#ifdef CONFIG_SMP
-	/*
-	 * For SMP we still have to take care of the case where the thread
-	 * migrates to another CPU and then back to the original CPU on which
-	 * the last VFP user is still the same thread. Mark the thread VFP
-	 * state as belonging to a non-existent CPU so that the saved one will
-	 * be reloaded in the above case.
-	 */
-	thread->vfpstate.hard.cpu = NR_CPUS;
-#endif
 	put_cpu();
 }
 
@@ -519,8 +526,7 @@ static int vfp_hotplug(struct notifier_block *b, unsigned long action,
 	void *hcpu)
 {
 	if (action == CPU_DYING || action == CPU_DYING_FROZEN) {
-		unsigned int cpu = (long)hcpu;
-		vfp_current_hw_state[cpu] = NULL;
+		vfp_force_reload((long)hcpu, current_thread_info());
 	} else if (action == CPU_STARTING || action == CPU_STARTING_FROZEN)
 		vfp_enable(NULL);
 	return NOTIFY_OK;
-- 
1.7.4.4
