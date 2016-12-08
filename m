From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu,  8 Dec 2016 16:49:39 +0000
Subject: [PATCH v3] arm64: fpsimd: improve stacking logic in non-interruptible
 context
Message-ID: <1481215779-23432-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, we allow kernel mode NEON in softirq or hardirq context by
stacking and unstacking a slice of the NEON register file for each call
to kernel_neon_begin() and kernel_neon_end(), respectively.

Given that
a) a CPU typically spends most of its time in userland, during which time
   no kernel mode NEON in process context is in progress,
b) a CPU spends most of its time in the kernel doing other things than
   kernel mode NEON when it gets interrupted to perform kernel mode NEON
   in softirq context

the stacking and subsequent unstacking is only necessary if we are
interrupting a thread while it is performing kernel mode NEON in process
context, which means that in all other cases, we can simply preserve the
userland FPSIMD state once, and only restore it upon return to userland,
even if we are being invoked from softirq or hardirq context.

So instead of checking whether we are running in interrupt context, keep
track of the level of nested kernel mode NEON calls in progress, and only
perform the eager stack/unstack if the level exceeds 1.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
v3:
- avoid corruption by concurrent invocations of kernel_neon_begin()/_end()

v2:
- BUG() on unexpected values of the nesting level
- relax the BUG() on num_regs>32 to a WARN, given that nothing actually
  breaks in that case

 arch/arm64/kernel/fpsimd.c | 47 ++++++++++++++------
 1 file changed, 33 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 394c61db5566..536ddab9316d 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -220,20 +220,35 @@ void fpsimd_flush_task_state(struct task_struct *t)
 
 #ifdef CONFIG_KERNEL_MODE_NEON
 
-static DEFINE_PER_CPU(struct fpsimd_partial_state, hardirq_fpsimdstate);
-static DEFINE_PER_CPU(struct fpsimd_partial_state, softirq_fpsimdstate);
+/*
+ * Although unlikely, it is possible for three kernel mode NEON contexts to
+ * be live at the same time: process context, softirq context and hardirq
+ * context. So while the userland context is stashed in the thread's fpsimd
+ * state structure, we need two additional levels of storage.
+ */
+static DEFINE_PER_CPU(struct fpsimd_partial_state, nested_fpsimdstate[2]);
+static DEFINE_PER_CPU(atomic_t, kernel_neon_nesting_level);
 
 /*
  * Kernel-side NEON support functions
  */
 void kernel_neon_begin_partial(u32 num_regs)
 {
-	if (in_interrupt()) {
-		struct fpsimd_partial_state *s = this_cpu_ptr(
-			in_irq() ? &hardirq_fpsimdstate : &softirq_fpsimdstate);
+	struct fpsimd_partial_state *s;
+	int level;
+
+	preempt_disable();
+
+	level = atomic_inc_return(this_cpu_ptr(&kernel_neon_nesting_level));
+	BUG_ON(level > 3);
+
+	if (level > 1) {
+		s = this_cpu_ptr(nested_fpsimdstate);
 
-		BUG_ON(num_regs > 32);
-		fpsimd_save_partial_state(s, roundup(num_regs, 2));
+		WARN_ON_ONCE(num_regs > 32);
+		num_regs = min(roundup(num_regs, 2), 32U);
+
+		fpsimd_save_partial_state(&s[level - 2], num_regs);
 	} else {
 		/*
 		 * Save the userland FPSIMD state if we have one and if we
@@ -241,7 +256,6 @@ void kernel_neon_begin_partial(u32 num_regs)
 		 * that there is no longer userland FPSIMD state in the
 		 * registers.
 		 */
-		preempt_disable();
 		if (current->mm &&
 		    !test_and_set_thread_flag(TIF_FOREIGN_FPSTATE))
 			fpsimd_save_state(&current->thread.fpsimd_state);
@@ -252,13 +266,18 @@ EXPORT_SYMBOL(kernel_neon_begin_partial);
 
 void kernel_neon_end(void)
 {
-	if (in_interrupt()) {
-		struct fpsimd_partial_state *s = this_cpu_ptr(
-			in_irq() ? &hardirq_fpsimdstate : &softirq_fpsimdstate);
-		fpsimd_load_partial_state(s);
-	} else {
-		preempt_enable();
+	struct fpsimd_partial_state *s;
+	int level;
+
+	level = atomic_read(this_cpu_ptr(&kernel_neon_nesting_level));
+	BUG_ON(level < 1);
+
+	if (level > 1) {
+		s = this_cpu_ptr(nested_fpsimdstate);
+		fpsimd_load_partial_state(&s[level - 2]);
 	}
+	atomic_dec(this_cpu_ptr(&kernel_neon_nesting_level));
+	preempt_enable();
 }
 EXPORT_SYMBOL(kernel_neon_end);
 
-- 
2.7.4
