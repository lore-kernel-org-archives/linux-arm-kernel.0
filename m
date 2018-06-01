From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  1 Jun 2018 16:27:23 +0100
Subject: [PATCH 09/33] arm64: fpsimd: Eliminate task->mm checks
In-Reply-To: <20180601152747.23613-1-marc.zyngier@arm.com>
References: <20180601152747.23613-1-marc.zyngier@arm.com>
Message-ID: <20180601152747.23613-10-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dave Martin <Dave.Martin@arm.com>

Currently the FPSIMD handling code uses the condition task->mm ==
NULL as a hint that task has no FPSIMD register context.

The ->mm check is only there to filter out tasks that cannot
possibly have FPSIMD context loaded, for optimisation purposes.
Also, TIF_FOREIGN_FPSTATE must always be checked anyway before
saving FPSIMD context back to memory.  For these reasons, the ->mm
checks are not useful, providing that TIF_FOREIGN_FPSTATE is
maintained in a consistent way for all threads.

The context switch logic is already deliberately optimised to defer
reloads of the regs until ret_to_user (or sigreturn as a special
case), and save them only if they have been previously loaded.
These paths are the only places where the wrong_task and wrong_cpu
conditions can be made false, by calling fpsimd_bind_task_to_cpu().
Kernel threads by definition never reach these paths.  As a result,
the wrong_task and wrong_cpu tests in fpsimd_thread_switch() will
always yield true for kernel threads.

This patch removes the redundant checks and special-case code,
ensuring that TIF_FOREIGN_FPSTATE is set whenever a kernel thread
is scheduled in, and ensures that this flag is set for the init
task.  The fpsimd_flush_task_state() call already present in
copy_thread() ensures the same for any new task.

With TIF_FOREIGN_FPSTATE always set for kernel threads, this patch
ensures that no extra context save work is added for kernel
threads, and eliminates the redundant context saving that may
currently occur for kernel threads that have acquired an mm via
use_mm().

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>
Reviewed-by: Christoffer Dall <christoffer.dall@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/processor.h |  4 ++-
 arch/arm64/kernel/fpsimd.c         | 40 ++++++++++++------------------
 2 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 767598932549..36d64f83cdfb 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -156,7 +156,9 @@ static inline void arch_thread_struct_whitelist(unsigned long *offset,
 /* Sync TPIDR_EL0 back to thread_struct for current */
 void tls_preserve_current_state(void);
 
-#define INIT_THREAD  {	}
+#define INIT_THREAD {				\
+	.fpsimd_cpu = NR_CPUS,			\
+}
 
 static inline void start_thread_common(struct pt_regs *regs, unsigned long pc)
 {
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 2d9a9e8ed826..d736b6c412ef 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -892,31 +892,25 @@ asmlinkage void do_fpsimd_exc(unsigned int esr, struct pt_regs *regs)
 
 void fpsimd_thread_switch(struct task_struct *next)
 {
+	bool wrong_task, wrong_cpu;
+
 	if (!system_supports_fpsimd())
 		return;
+
+	/* Save unsaved fpsimd state, if any: */
+	fpsimd_save();
+
 	/*
-	 * Save the current FPSIMD state to memory, but only if whatever is in
-	 * the registers is in fact the most recent userland FPSIMD state of
-	 * 'current'.
+	 * Fix up TIF_FOREIGN_FPSTATE to correctly describe next's
+	 * state.  For kernel threads, FPSIMD registers are never loaded
+	 * and wrong_task and wrong_cpu will always be true.
 	 */
-	if (current->mm)
-		fpsimd_save();
-
-	if (next->mm) {
-		/*
-		 * If we are switching to a task whose most recent userland
-		 * FPSIMD state is already in the registers of *this* cpu,
-		 * we can skip loading the state from memory. Otherwise, set
-		 * the TIF_FOREIGN_FPSTATE flag so the state will be loaded
-		 * upon the next return to userland.
-		 */
-		bool wrong_task = __this_cpu_read(fpsimd_last_state.st) !=
+	wrong_task = __this_cpu_read(fpsimd_last_state.st) !=
 					&next->thread.uw.fpsimd_state;
-		bool wrong_cpu = next->thread.fpsimd_cpu != smp_processor_id();
+	wrong_cpu = next->thread.fpsimd_cpu != smp_processor_id();
 
-		update_tsk_thread_flag(next, TIF_FOREIGN_FPSTATE,
-				       wrong_task || wrong_cpu);
-	}
+	update_tsk_thread_flag(next, TIF_FOREIGN_FPSTATE,
+			       wrong_task || wrong_cpu);
 }
 
 void fpsimd_flush_thread(void)
@@ -1121,9 +1115,8 @@ void kernel_neon_begin(void)
 
 	__this_cpu_write(kernel_neon_busy, true);
 
-	/* Save unsaved task fpsimd state, if any: */
-	if (current->mm)
-		fpsimd_save();
+	/* Save unsaved fpsimd state, if any: */
+	fpsimd_save();
 
 	/* Invalidate any task state remaining in the fpsimd regs: */
 	fpsimd_flush_cpu_state();
@@ -1245,8 +1238,7 @@ static int fpsimd_cpu_pm_notifier(struct notifier_block *self,
 {
 	switch (cmd) {
 	case CPU_PM_ENTER:
-		if (current->mm)
-			fpsimd_save();
+		fpsimd_save();
 		fpsimd_flush_cpu_state();
 		break;
 	case CPU_PM_EXIT:
-- 
2.17.1
