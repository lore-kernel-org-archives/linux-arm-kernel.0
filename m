From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 14 Dec 2016 11:20:16 +0000
Subject: [PATCH v7] arm64: fpsimd: improve stacking logic in non-interruptible
 context
Message-ID: <1481714416-19535-1-git-send-email-ard.biesheuvel@linaro.org>
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
userland FP/SIMD state once, and only restore it upon return to userland,
even if we are being invoked from softirq or hardirq context.

However, with support being added to teh arm64 kernel for Scalable Vector
Extensions (SVE), which shares the bottom 128 bits of each FP/SIMD register,
but could scale up to 2048 bits per register, the nested stacking and
unstacking that occurs in interrupt context is no longer sufficient, given
that the register contents will be truncated to 128 bits upon restore, unless
we add support for stacking/unstacking the entire SVE state, which does not
sound that appealing.

This means that the FP/SIMD save state operation that encounters the
userland state first *has* to be able to run to completion (since any
interruption could truncate the contents of the registers, which would
result in corrupted state to be restored once the interrupted context is
allowed to resume preserving the state)

Since executing all code involving the FP/SIMD state with interrupts
disabled is undesirable, let's ban kernel mode NEON in hardirq context
altogether. This is a small price to pay, given that the primary use
case of kernel mode NEON, crypto, can deal with this quite easily (and
simply falls back to generic scalar algorithms whose worse performance
should not matter in hardirq context anyway)

With hardirq context removed from the equation, we can modify the FP/SIMD
state manipulation code to execute with softirqs disable. This allows the
critical sections to complete without the risk of having the register
contents getting corrupted half way through.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
v7:
- ban kernel mode NEON in hardirq context, and execute all FP/SIMD state
  manipulations with softirqs disabled

v6:
- use a spinlock instead of disabling interrupts

v5:
- perform the test-and-set and the fpsimd_save_state with interrupts disabled,
  to prevent nested kernel_neon_begin()/_end() pairs to clobber the state
  while it is being preserved

v4:
- use this_cpu_inc/dec, which give sufficient guarantees regarding
  concurrency, but do not imply SMP barriers, which are not needed here

v3:
- avoid corruption by concurrent invocations of kernel_neon_begin()/_end()

v2:
- BUG() on unexpected values of the nesting level
- relax the BUG() on num_regs>32 to a WARN, given that nothing actually
  breaks in that case

 arch/arm64/include/asm/Kbuild |  1 -
 arch/arm64/include/asm/simd.h | 16 ++++
 arch/arm64/kernel/fpsimd.c    | 77 ++++++++++++++------
 3 files changed, 72 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
index 44e1d7f10add..39ca0409e157 100644
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@ -33,7 +33,6 @@ generic-y += segment.h
 generic-y += sembuf.h
 generic-y += serial.h
 generic-y += shmbuf.h
-generic-y += simd.h
 generic-y += sizes.h
 generic-y += socket.h
 generic-y += sockios.h
diff --git a/arch/arm64/include/asm/simd.h b/arch/arm64/include/asm/simd.h
new file mode 100644
index 000000000000..142eca29125a
--- /dev/null
+++ b/arch/arm64/include/asm/simd.h
@@ -0,0 +1,16 @@
+
+#include <linux/hardirq.h>
+
+/*
+ * may_use_simd - whether it is allowable at this time to issue SIMD
+ *                instructions or access the SIMD register file
+ *
+ * On arm64, we allow kernel mode NEON in softirq context but not in hardirq
+ * context, due to the fact that the NEON register file may be shared with SVE,
+ * whose state may too large to preserve/restore efficiently at each invocation
+ * of kernel_neon_begin()/_end() in hardirq context.
+ */
+static __must_check inline bool may_use_simd(void)
+{
+	return !in_irq();
+}
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 394c61db5566..97344c94acae 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -127,6 +127,8 @@ void do_fpsimd_exc(unsigned int esr, struct pt_regs *regs)
 
 void fpsimd_thread_switch(struct task_struct *next)
 {
+	BUG_ON(!irqs_disabled());
+
 	/*
 	 * Save the current FPSIMD state to memory, but only if whatever is in
 	 * the registers is in fact the most recent userland FPSIMD state of
@@ -169,8 +171,10 @@ void fpsimd_flush_thread(void)
 void fpsimd_preserve_current_state(void)
 {
 	preempt_disable();
+	local_bh_disable();
 	if (!test_thread_flag(TIF_FOREIGN_FPSTATE))
 		fpsimd_save_state(&current->thread.fpsimd_state);
+	local_bh_enable();
 	preempt_enable();
 }
 
@@ -182,6 +186,7 @@ void fpsimd_preserve_current_state(void)
 void fpsimd_restore_current_state(void)
 {
 	preempt_disable();
+	local_bh_disable();
 	if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
 		struct fpsimd_state *st = &current->thread.fpsimd_state;
 
@@ -189,6 +194,7 @@ void fpsimd_restore_current_state(void)
 		this_cpu_write(fpsimd_last_state, st);
 		st->cpu = smp_processor_id();
 	}
+	local_bh_enable();
 	preempt_enable();
 }
 
@@ -200,6 +206,7 @@ void fpsimd_restore_current_state(void)
 void fpsimd_update_current_state(struct fpsimd_state *state)
 {
 	preempt_disable();
+	local_bh_disable();
 	fpsimd_load_state(state);
 	if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
 		struct fpsimd_state *st = &current->thread.fpsimd_state;
@@ -207,6 +214,7 @@ void fpsimd_update_current_state(struct fpsimd_state *state)
 		this_cpu_write(fpsimd_last_state, st);
 		st->cpu = smp_processor_id();
 	}
+	local_bh_enable();
 	preempt_enable();
 }
 
@@ -220,45 +228,68 @@ void fpsimd_flush_task_state(struct task_struct *t)
 
 #ifdef CONFIG_KERNEL_MODE_NEON
 
-static DEFINE_PER_CPU(struct fpsimd_partial_state, hardirq_fpsimdstate);
-static DEFINE_PER_CPU(struct fpsimd_partial_state, softirq_fpsimdstate);
+static DEFINE_PER_CPU(struct fpsimd_partial_state, nested_fpsimdstate);
+static DEFINE_PER_CPU(int, kernel_neon_nesting_level);
 
 /*
  * Kernel-side NEON support functions
  */
 void kernel_neon_begin_partial(u32 num_regs)
 {
-	if (in_interrupt()) {
-		struct fpsimd_partial_state *s = this_cpu_ptr(
-			in_irq() ? &hardirq_fpsimdstate : &softirq_fpsimdstate);
+	int level;
 
-		BUG_ON(num_regs > 32);
-		fpsimd_save_partial_state(s, roundup(num_regs, 2));
-	} else {
+	/*
+	 * We don't allow kernel mode NEON in hard IRQ context because we'd
+	 * have to assume that any sequence involving preserve/restore of the
+	 * FP/SIMD register file could be interrupted by nested use of the NEON.
+	 *
+	 * On SVE capable hardware, that would necessitate executing all
+	 * manipulation of the preserved FP/SIMD state with interrupts disabled,
+	 * unless we preserve/restore the *entire* SVE state in interrupt
+	 * context as well.
+	 */
+	BUG_ON(in_irq());
+
+	preempt_disable();
+	if (current->mm && !test_thread_flag(TIF_FOREIGN_FPSTATE)) {
 		/*
 		 * Save the userland FPSIMD state if we have one and if we
 		 * haven't done so already. Clear fpsimd_last_state to indicate
 		 * that there is no longer userland FPSIMD state in the
 		 * registers.
 		 */
-		preempt_disable();
-		if (current->mm &&
-		    !test_and_set_thread_flag(TIF_FOREIGN_FPSTATE))
+		local_bh_disable();
+		if (!test_and_set_thread_flag(TIF_FOREIGN_FPSTATE))
 			fpsimd_save_state(&current->thread.fpsimd_state);
-		this_cpu_write(fpsimd_last_state, NULL);
+		local_bh_enable();
+	}
+	this_cpu_write(fpsimd_last_state, NULL);
+
+	level = this_cpu_inc_return(kernel_neon_nesting_level);
+	BUG_ON(level > 2);
+
+	if (level > 1) {
+		WARN_ON_ONCE(num_regs > 32);
+		num_regs = max(roundup(num_regs, 2), 32U);
+
+		fpsimd_save_partial_state(this_cpu_ptr(&nested_fpsimdstate),
+					  num_regs);
 	}
 }
 EXPORT_SYMBOL(kernel_neon_begin_partial);
 
 void kernel_neon_end(void)
 {
-	if (in_interrupt()) {
-		struct fpsimd_partial_state *s = this_cpu_ptr(
-			in_irq() ? &hardirq_fpsimdstate : &softirq_fpsimdstate);
-		fpsimd_load_partial_state(s);
-	} else {
-		preempt_enable();
-	}
+	int level;
+
+	level = this_cpu_read(kernel_neon_nesting_level);
+	BUG_ON(level < 1);
+
+	if (level > 1)
+		fpsimd_load_partial_state(this_cpu_ptr(&nested_fpsimdstate));
+
+	this_cpu_dec(kernel_neon_nesting_level);
+	preempt_enable();
 }
 EXPORT_SYMBOL(kernel_neon_end);
 
@@ -270,8 +301,12 @@ static int fpsimd_cpu_pm_notifier(struct notifier_block *self,
 {
 	switch (cmd) {
 	case CPU_PM_ENTER:
-		if (current->mm && !test_thread_flag(TIF_FOREIGN_FPSTATE))
-			fpsimd_save_state(&current->thread.fpsimd_state);
+		if (current->mm) {
+			local_bh_disable();
+			if (!test_thread_flag(TIF_FOREIGN_FPSTATE))
+				fpsimd_save_state(&current->thread.fpsimd_state);
+			local_bh_enable();
+		}
 		this_cpu_write(fpsimd_last_state, NULL);
 		break;
 	case CPU_PM_EXIT:
-- 
2.7.4
