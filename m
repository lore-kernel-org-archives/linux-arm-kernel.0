From: dave.long@linaro.org (David Long)
Date: Wed, 10 Aug 2016 16:44:51 -0400
Subject: [PATCH 1/1] arm64: Remove stack duplicating code from jprobes
Message-ID: <1470861891-13315-1-git-send-email-dave.long@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "David A. Long" <dave.long@linaro.org>

Because the arm64 calling standard allows stacked function arguments to be
anywhere in the stack frame, do not attempt to duplicate the stack frame for
jprobes handler functions.

Documenation changes to describe this issue have been broken out into a
separate patch in order to simultaneously address them in other
architecture(s).

Signed-off-by: David A. Long <dave.long@linaro.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/arm64/include/asm/kprobes.h   |  2 --
 arch/arm64/kernel/probes/kprobes.c | 31 +++++--------------------------
 2 files changed, 5 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/include/asm/kprobes.h b/arch/arm64/include/asm/kprobes.h
index 61b4915..1737aec 100644
--- a/arch/arm64/include/asm/kprobes.h
+++ b/arch/arm64/include/asm/kprobes.h
@@ -22,7 +22,6 @@
 
 #define __ARCH_WANT_KPROBES_INSN_SLOT
 #define MAX_INSN_SIZE			1
-#define MAX_STACK_SIZE			128
 
 #define flush_insn_slot(p)		do { } while (0)
 #define kretprobe_blacklist_size	0
@@ -47,7 +46,6 @@ struct kprobe_ctlblk {
 	struct prev_kprobe prev_kprobe;
 	struct kprobe_step_ctx ss_ctx;
 	struct pt_regs jprobe_saved_regs;
-	char jprobes_stack[MAX_STACK_SIZE];
 };
 
 void arch_remove_kprobe(struct kprobe *);
diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index bf97685..c6b0f40 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -41,18 +41,6 @@ DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
 static void __kprobes
 post_kprobe_handler(struct kprobe_ctlblk *, struct pt_regs *);
 
-static inline unsigned long min_stack_size(unsigned long addr)
-{
-	unsigned long size;
-
-	if (on_irq_stack(addr, raw_smp_processor_id()))
-		size = IRQ_STACK_PTR(raw_smp_processor_id()) - addr;
-	else
-		size = (unsigned long)current_thread_info() + THREAD_START_SP - addr;
-
-	return min(size, FIELD_SIZEOF(struct kprobe_ctlblk, jprobes_stack));
-}
-
 static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
 {
 	/* prepare insn slot */
@@ -489,20 +477,15 @@ int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
 {
 	struct jprobe *jp = container_of(p, struct jprobe, kp);
 	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-	long stack_ptr = kernel_stack_pointer(regs);
 
 	kcb->jprobe_saved_regs = *regs;
 	/*
-	 * As Linus pointed out, gcc assumes that the callee
-	 * owns the argument space and could overwrite it, e.g.
-	 * tailcall optimization. So, to be absolutely safe
-	 * we also save and restore enough stack bytes to cover
-	 * the argument area.
+	 * Since we can't be sure where in the stack frame "stacked"
+	 * pass-by-value arguments are stored we just don't try to
+	 * duplicate any of the stack. Do not use jprobes on functions that
+	 * use more than 64 bytes (after padding each to an 8 byte boundary)
+	 * of arguments, or pass individual arguments larger than 16 bytes.
 	 */
-	kasan_disable_current();
-	memcpy(kcb->jprobes_stack, (void *)stack_ptr,
-	       min_stack_size(stack_ptr));
-	kasan_enable_current();
 
 	instruction_pointer_set(regs, (unsigned long) jp->entry);
 	preempt_disable();
@@ -554,10 +537,6 @@ int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
 	}
 	unpause_graph_tracing();
 	*regs = kcb->jprobe_saved_regs;
-	kasan_disable_current();
-	memcpy((void *)stack_addr, kcb->jprobes_stack,
-	       min_stack_size(stack_addr));
-	kasan_enable_current();
 	preempt_enable_no_resched();
 	return 1;
 }
-- 
2.5.0
