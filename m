From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 09 Jul 2011 17:32:51 +0100
Subject: [PATCH 1/3] ARM: vfp: rename last_VFP_context to vfp_current_hw_state
In-Reply-To: <20110709163207.GN4812@n2100.arm.linux.org.uk>
References: <20110709163207.GN4812@n2100.arm.linux.org.uk>
Message-ID: <E1QfaSZ-0006QF-HE@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rename the slightly confusing 'last_VFP_context' variable to be more
descriptive of what it actually is.  This variable stores a pointer
to the current owner's vfpstate structure for the context held in the
VFP hardware.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/vfp/vfphw.S     |   10 +++++-----
 arch/arm/vfp/vfpmodule.c |   36 +++++++++++++++++++++---------------
 2 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/arch/arm/vfp/vfphw.S b/arch/arm/vfp/vfphw.S
index 9897dcf..c75443e 100644
--- a/arch/arm/vfp/vfphw.S
+++ b/arch/arm/vfp/vfphw.S
@@ -77,9 +77,9 @@ ENTRY(vfp_support_entry)
 	bne	look_for_VFP_exceptions	@ VFP is already enabled
 
 	DBGSTR1 "enable %x", r10
-	ldr	r3, last_VFP_context_address
+	ldr	r3, vfp_current_hw_state_address
 	orr	r1, r1, #FPEXC_EN	@ user FPEXC has the enable bit set
-	ldr	r4, [r3, r11, lsl #2]	@ last_VFP_context pointer
+	ldr	r4, [r3, r11, lsl #2]	@ vfp_current_hw_state pointer
 	bic	r5, r1, #FPEXC_EX	@ make sure exceptions are disabled
 	cmp	r4, r10
 	beq	check_for_exception	@ we are returning to the same
@@ -116,7 +116,7 @@ ENTRY(vfp_support_entry)
 
 no_old_VFP_process:
 	DBGSTR1	"load state %p", r10
-	str	r10, [r3, r11, lsl #2]	@ update the last_VFP_context pointer
+	str	r10, [r3, r11, lsl #2]	@ update the vfp_current_hw_state pointer
 					@ Load the saved state back into the VFP
 	VFPFLDMIA r10, r5		@ reload the working registers while
 					@ FPEXC is in a safe state
@@ -207,8 +207,8 @@ ENTRY(vfp_save_state)
 ENDPROC(vfp_save_state)
 
 	.align
-last_VFP_context_address:
-	.word	last_VFP_context
+vfp_current_hw_state_address:
+	.word	vfp_current_hw_state
 
 	.macro	tbl_branch, base, tmp, shift
 #ifdef CONFIG_THUMB2_KERNEL
diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index f25e7ec..36403511 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -33,7 +33,13 @@ void vfp_support_entry(void);
 void vfp_null_entry(void);
 
 void (*vfp_vector)(void) = vfp_null_entry;
-union vfp_state *last_VFP_context[NR_CPUS];
+
+/*
+ * The pointer to the vfpstate structure of the thread which currently
+ * owns the context held in the VFP hardware, or NULL if the hardware
+ * context is invalid.
+ */
+union vfp_state *vfp_current_hw_state[NR_CPUS];
 
 /*
  * Dual-use variable.
@@ -57,12 +63,12 @@ static void vfp_thread_flush(struct thread_info *thread)
 
 	/*
 	 * Disable VFP to ensure we initialize it first.  We must ensure
-	 * that the modification of last_VFP_context[] and hardware disable
+	 * that the modification of vfp_current_hw_state[] and hardware disable
 	 * are done for the same CPU and without preemption.
 	 */
 	cpu = get_cpu();
-	if (last_VFP_context[cpu] == vfp)
-		last_VFP_context[cpu] = NULL;
+	if (vfp_current_hw_state[cpu] == vfp)
+		vfp_current_hw_state[cpu] = NULL;
 	fmxr(FPEXC, fmrx(FPEXC) & ~FPEXC_EN);
 	put_cpu();
 }
@@ -73,8 +79,8 @@ static void vfp_thread_exit(struct thread_info *thread)
 	union vfp_state *vfp = &thread->vfpstate;
 	unsigned int cpu = get_cpu();
 
-	if (last_VFP_context[cpu] == vfp)
-		last_VFP_context[cpu] = NULL;
+	if (vfp_current_hw_state[cpu] == vfp)
+		vfp_current_hw_state[cpu] = NULL;
 	put_cpu();
 }
 
@@ -129,9 +135,9 @@ static int vfp_notifier(struct notifier_block *self, unsigned long cmd, void *v)
 		 * case the thread migrates to a different CPU. The
 		 * restoring is done lazily.
 		 */
-		if ((fpexc & FPEXC_EN) && last_VFP_context[cpu]) {
-			vfp_save_state(last_VFP_context[cpu], fpexc);
-			last_VFP_context[cpu]->hard.cpu = cpu;
+		if ((fpexc & FPEXC_EN) && vfp_current_hw_state[cpu]) {
+			vfp_save_state(vfp_current_hw_state[cpu], fpexc);
+			vfp_current_hw_state[cpu]->hard.cpu = cpu;
 		}
 		/*
 		 * Thread migration, just force the reloading of the
@@ -139,7 +145,7 @@ static int vfp_notifier(struct notifier_block *self, unsigned long cmd, void *v)
 		 * contain stale data.
 		 */
 		if (thread->vfpstate.hard.cpu != cpu)
-			last_VFP_context[cpu] = NULL;
+			vfp_current_hw_state[cpu] = NULL;
 #endif
 
 		/*
@@ -415,7 +421,7 @@ static int vfp_pm_suspend(void)
 	}
 
 	/* clear any information we had about last context state */
-	memset(last_VFP_context, 0, sizeof(last_VFP_context));
+	memset(vfp_current_hw_state, 0, sizeof(vfp_current_hw_state));
 
 	return 0;
 }
@@ -451,7 +457,7 @@ void vfp_sync_hwstate(struct thread_info *thread)
 	 * If the thread we're interested in is the current owner of the
 	 * hardware VFP state, then we need to save its state.
 	 */
-	if (last_VFP_context[cpu] == &thread->vfpstate) {
+	if (vfp_current_hw_state[cpu] == &thread->vfpstate) {
 		u32 fpexc = fmrx(FPEXC);
 
 		/*
@@ -473,7 +479,7 @@ void vfp_flush_hwstate(struct thread_info *thread)
 	 * If the thread we're interested in is the current owner of the
 	 * hardware VFP state, then we need to save its state.
 	 */
-	if (last_VFP_context[cpu] == &thread->vfpstate) {
+	if (vfp_current_hw_state[cpu] == &thread->vfpstate) {
 		u32 fpexc = fmrx(FPEXC);
 
 		fmxr(FPEXC, fpexc & ~FPEXC_EN);
@@ -482,7 +488,7 @@ void vfp_flush_hwstate(struct thread_info *thread)
 		 * Set the context to NULL to force a reload the next time
 		 * the thread uses the VFP.
 		 */
-		last_VFP_context[cpu] = NULL;
+		vfp_current_hw_state[cpu] = NULL;
 	}
 
 #ifdef CONFIG_SMP
@@ -514,7 +520,7 @@ static int vfp_hotplug(struct notifier_block *b, unsigned long action,
 {
 	if (action == CPU_DYING || action == CPU_DYING_FROZEN) {
 		unsigned int cpu = (long)hcpu;
-		last_VFP_context[cpu] = NULL;
+		vfp_current_hw_state[cpu] = NULL;
 	} else if (action == CPU_STARTING || action == CPU_STARTING_FROZEN)
 		vfp_enable(NULL);
 	return NOTIFY_OK;
-- 
1.7.4.4
