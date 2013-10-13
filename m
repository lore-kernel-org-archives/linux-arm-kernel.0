From: liuj97@gmail.com (Jiang Liu)
Date: Sun, 13 Oct 2013 22:20:20 +0800
Subject: [RFT PATCH v2 4/4] arm64: reuse FPSIMD hardware context if possible
In-Reply-To: <1381674029-430-1-git-send-email-liuj97@gmail.com>
References: <1381674029-430-1-git-send-email-liuj97@gmail.com>
Message-ID: <1381674029-430-4-git-send-email-liuj97@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jiang Liu <jiang.liu@huawei.com>

Reuse FPSIMD hardware context if it hasn't been touched by other thread
yet, so we can get rid of unnecessary FPSIMD context restores. This is
especially useful when switching between kernel thread and user thread
because kernel thread usaually doesn't touch FPSIMD registers.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Cc: Jiang Liu <liuj97@gmail.com>
---
 arch/arm64/include/asm/fpsimd.h |  2 ++
 arch/arm64/kernel/fpsimd.c      | 35 +++++++++++++++++++++++++++++++++--
 arch/arm64/kernel/smp.c         |  1 +
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 6f034082f..ab7bf61 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -35,6 +35,7 @@ struct fpsimd_state {
 			__uint128_t vregs[32];
 			u32 fpsr;
 			u32 fpcr;
+			int last_cpu;
 		};
 	};
 };
@@ -56,6 +57,7 @@ struct task_struct;
 
 extern void fpsimd_save_state(struct fpsimd_state *state);
 extern void fpsimd_load_state(struct fpsimd_state *state);
+extern void fpsimd_reset_lazy_restore(void);
 
 extern void fpsimd_dup_task_struct(struct task_struct *dst,
 				   struct task_struct *src);
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 604fe9f..b1b3b0e 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -22,6 +22,7 @@
 #include <linux/sched.h>
 #include <linux/signal.h>
 #include <linux/hardirq.h>
+#include <linux/percpu.h>
 
 #include <asm/fpsimd.h>
 #include <asm/cputype.h>
@@ -33,6 +34,13 @@
 #define FPEXC_IXF	(1 << 4)
 #define FPEXC_IDF	(1 << 7)
 
+static DEFINE_PER_CPU(struct fpsimd_state *, fpsimd_owner);
+
+static inline void fpsimd_set_last_cpu(struct fpsimd_state *state, int cpu)
+{
+	state->last_cpu = cpu;
+}
+
 static inline void fpsimd_init_hw_state(void)
 {
 	int val = AARCH64_FPCR_DEFAULT_VAL;
@@ -83,19 +91,41 @@ void do_fpsimd_exc(unsigned int esr, struct pt_regs *regs)
 	send_sig_info(SIGFPE, &info, current);
 }
 
+static void fpsimd_load_state_lazy(struct fpsimd_state *state)
+{
+	/* Could we reuse the hardware context? */
+	if (state->last_cpu == smp_processor_id() &&
+	    __this_cpu_read(fpsimd_owner) == state)
+		return;
+	fpsimd_load_state(state);
+}
+
+static void fpsimd_save_state_lazy(struct fpsimd_state *state)
+{
+	fpsimd_save_state(state);
+	fpsimd_set_last_cpu(state, smp_processor_id());
+	__this_cpu_write(fpsimd_owner, state);
+}
+
+void fpsimd_reset_lazy_restore(void)
+{
+	this_cpu_write(fpsimd_owner, NULL);
+}
+
 void fpsimd_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 {
 	fpsimd_save_state(&src->thread.fpsimd_state);
 	*dst = *src;
+	fpsimd_set_last_cpu(&dst->thread.fpsimd_state, -1);
 }
 
 void fpsimd_thread_switch(struct task_struct *next)
 {
 	/* check if not kernel threads */
 	if (current->mm)
-		fpsimd_save_state(&current->thread.fpsimd_state);
+		fpsimd_save_state_lazy(&current->thread.fpsimd_state);
 	if (next->mm)
-		fpsimd_load_state(&next->thread.fpsimd_state);
+		fpsimd_load_state_lazy(&next->thread.fpsimd_state);
 }
 
 void fpsimd_flush_thread(void)
@@ -107,6 +137,7 @@ void fpsimd_flush_thread(void)
 #if (AARCH64_FPCR_DEFAULT_VAL != 0)
 	state->fpcr = AARCH64_FPCR_DEFAULT_VAL;
 #endif
+	fpsimd_set_last_cpu(state, -1);
 	fpsimd_load_state(state);
 	preempt_enable();
 }
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 78db90d..aae15c4 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -183,6 +183,7 @@ asmlinkage void secondary_start_kernel(void)
 	 */
 	cpu_set_reserved_ttbr0();
 	flush_tlb_all();
+	fpsimd_reset_lazy_restore();
 
 	preempt_disable();
 	trace_hardirqs_off();
-- 
1.8.1.2
