From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 20 Jul 2016 17:46:58 +0100
Subject: [PATCH v15 04/10] arm64: Kprobes with single stepping support
In-Reply-To: <20160720162827.GF25890@e104818-lin.cambridge.arm.com>
References: <1467995754-32508-1-git-send-email-dave.long@linaro.org>
 <1467995754-32508-5-git-send-email-dave.long@linaro.org>
 <578FA238.3050206@arm.com>
 <20160720162827.GF25890@e104818-lin.cambridge.arm.com>
Message-ID: <578FAB02.90707@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/07/16 17:28, Catalin Marinas wrote:
> On Wed, Jul 20, 2016 at 05:09:28PM +0100, Marc Zyngier wrote:
>> +static inline unsigned long min_stack_size(unsigned long addr)
>> +{
>> +	unsigned long size;
>> +	struct kprobe_ctlblk *ctl;
>> +
>> +	if (on_irq_stack(addr, raw_smp_processor_id()))
>> +		size = IRQ_STACK_PTR(raw_smp_processor_id()) - addr;
>> +	else
>> +		size = (unsigned long)current_thread_info() + THREAD_START_SP - addr;
>> +
>> +	return min(size, sizeof(ctl->jprobes_stack));
>> +}
> 
> We could drop the local ctl pointer:
> 
> 	return min(size, sizeof(((struct kprobe_ctlblk *)0)->jprobes_stack));
> 
> If you add a log, I'll push the patch on top of the kprobes branch.

Here you go:

----8<----
>From 0d120f95b3348e1946d8a789c7147f316c27ea6b Mon Sep 17 00:00:00 2001
From: Marc Zyngier <marc.zyngier@arm.com>
Date: Wed, 20 Jul 2016 17:36:42 +0100
Subject: [PATCH] arm64: kprobes: Fix overflow when saving stack

The MIN_STACK_SIZE macro tries evaluate how much stack space needs
to be saved in the jprobes_stack array, sized at 128 bytes.

When using the IRQ stack, said macro can happily return up to
IRQ_STACK_SIZE, which is 16kB. Mayhem follows.

This patch fixes things by getting rid of the crazy macro and
limiting the copy to be at most the size of the jprobes_stack
array, no matter which stack we're on.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kernel/probes/kprobes.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index 823cf92..87a24f6 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -34,12 +34,6 @@
 
 #include "decode-insn.h"
 
-#define MIN_STACK_SIZE(addr)	(on_irq_stack(addr, raw_smp_processor_id()) ? \
-	min((unsigned long)IRQ_STACK_SIZE,	\
-	IRQ_STACK_PTR(raw_smp_processor_id()) - (addr)) : \
-	min((unsigned long)MAX_STACK_SIZE,	\
-	(unsigned long)current_thread_info() + THREAD_START_SP - (addr)))
-
 void jprobe_return_break(void);
 
 DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
@@ -48,6 +42,18 @@ DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
 static void __kprobes
 post_kprobe_handler(struct kprobe_ctlblk *, struct pt_regs *);
 
+static inline unsigned long min_stack_size(unsigned long addr)
+{
+	unsigned long size;
+
+	if (on_irq_stack(addr, raw_smp_processor_id()))
+		size = IRQ_STACK_PTR(raw_smp_processor_id()) - addr;
+	else
+		size = (unsigned long)current_thread_info() + THREAD_START_SP - addr;
+
+	return min(size, FIELD_SIZEOF(struct kprobe_ctlblk, jprobes_stack));
+}
+
 static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
 {
 	/* prepare insn slot */
@@ -495,7 +501,7 @@ int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
 	 * the argument area.
 	 */
 	memcpy(kcb->jprobes_stack, (void *)stack_ptr,
-	       MIN_STACK_SIZE(stack_ptr));
+	       min_stack_size(stack_ptr));
 
 	instruction_pointer_set(regs, (unsigned long) jp->entry);
 	preempt_disable();
@@ -547,7 +553,7 @@ int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
 	unpause_graph_tracing();
 	*regs = kcb->jprobe_saved_regs;
 	memcpy((void *)stack_addr, kcb->jprobes_stack,
-	       MIN_STACK_SIZE(stack_addr));
+	       min_stack_size(stack_addr));
 	preempt_enable_no_resched();
 	return 1;
 }
-- 
2.1.4

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
