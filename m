From: james.morse@arm.com (James Morse)
Date: Fri,  4 Dec 2015 11:02:27 +0000
Subject: [PATCH v8 3/4] arm64: Add do_softirq_own_stack() and enable irq_stacks
In-Reply-To: <1449226948-14251-1-git-send-email-james.morse@arm.com>
References: <1449226948-14251-1-git-send-email-james.morse@arm.com>
Message-ID: <1449226948-14251-4-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

entry.S is modified to switch to the per_cpu irq_stack during el{0,1}_irq.
irq_count is used to detect recursive interrupts on the irq_stack, it is
updated late by do_softirq_own_stack(), when called on the irq_stack, before
__do_softirq() re-enables interrupts to process softirqs.

do_softirq_own_stack() is added by this patch, but does not yet switch
stack.

This patch adds the dummy stack frame and data needed by the previous
stack tracing patches.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/irq.h |  2 ++
 arch/arm64/kernel/entry.S    | 42 ++++++++++++++++++++++++++++++++++++++++--
 arch/arm64/kernel/irq.c      | 38 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 79 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index e2f3f135a3bc..fa2a8d0e4792 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -11,6 +11,8 @@
 #include <asm-generic/irq.h>
 #include <asm/thread_info.h>
 
+#define __ARCH_HAS_DO_SOFTIRQ
+
 struct pt_regs;
 
 DECLARE_PER_CPU(unsigned long [IRQ_STACK_SIZE/sizeof(long)], irq_stack);
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index fc87373d3f88..81cc5380977d 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -27,6 +27,7 @@
 #include <asm/cpufeature.h>
 #include <asm/errno.h>
 #include <asm/esr.h>
+#include <asm/irq.h>
 #include <asm/thread_info.h>
 #include <asm/unistd.h>
 
@@ -175,6 +176,42 @@ alternative_endif
 	mrs	\rd, sp_el0
 	.endm
 
+	.macro	irq_stack_entry, dummy_lr
+	mov	x19, sp			// preserve the original sp
+
+	adr_l	x25, irq_stack
+	mrs	x26, tpidr_el1
+	add	x25, x25, x26
+
+	/*
+	 * Check the lowest address on irq_stack for the irq_count value,
+	 * incremented by do_softirq_own_stack if we have re-enabled irqs
+	 * while on the irq_stack.
+	 */
+	ldr	x26, [x25]
+	cbnz	x26, 9998f		// recursive use?
+
+	/* switch to the irq stack */
+	mov	x26, #IRQ_STACK_START_SP
+	add	x26, x25, x26
+	mov	sp, x26
+
+	/* Add a dummy stack frame */
+	stp     x29, \dummy_lr, [sp, #-16]!           // dummy stack frame
+	mov	x29, sp
+	stp     xzr, x19, [sp, #-16]!
+
+9998:
+	.endm
+
+	/*
+	 * x19 should be preserved between irq_stack_entry and
+	 * irq_stack_exit.
+	 */
+	.macro	irq_stack_exit
+	mov	sp, x19
+	.endm
+
 /*
  * These are the registers used in the syscall handler, and allow us to
  * have in theory up to 7 arguments to a function - x0 to x6.
@@ -190,10 +227,11 @@ tsk	.req	x28		// current thread_info
  * Interrupt handling.
  */
 	.macro	irq_handler
-	adrp	x1, handle_arch_irq
-	ldr	x1, [x1, #:lo12:handle_arch_irq]
+	ldr_l	x1, handle_arch_irq
 	mov	x0, sp
+	irq_stack_entry x22
 	blr	x1
+	irq_stack_exit
 	.endm
 
 	.text
diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index 1e3cef578e21..ff7ebb710e51 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -25,14 +25,24 @@
 #include <linux/irq.h>
 #include <linux/smp.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/irqchip.h>
 #include <linux/seq_file.h>
 
 unsigned long irq_err_count;
 
-/* irq stack only needs to be 16 byte aligned - not IRQ_STACK_SIZE aligned */
+/*
+ * irq stack only needs to be 16 byte aligned - not IRQ_STACK_SIZE aligned.
+ * irq_stack[0] is used as irq_count, a non-zero value indicates the stack
+ * is in use, and el?_irq() shouldn't switch to it. This is used to detect
+ * recursive use of the irq_stack, it is lazily updated by
+ * do_softirq_own_stack(), which is called on the irq_stack, before
+ * re-enabling interrupts to process softirqs.
+ */
 DEFINE_PER_CPU(unsigned long [IRQ_STACK_SIZE/sizeof(long)], irq_stack) __aligned(16);
 
+#define IRQ_COUNT()	(*per_cpu(irq_stack, smp_processor_id()))
+
 int arch_show_interrupts(struct seq_file *p, int prec)
 {
 	show_ipi_list(p, prec);
@@ -56,3 +66,29 @@ void __init init_IRQ(void)
 	if (!handle_arch_irq)
 		panic("No interrupt controller found.");
 }
+
+/*
+ * do_softirq_own_stack() is called from irq_exit() before __do_softirq()
+ * re-enables interrupts, at which point we may re-enter el?_irq(). We
+ * increase irq_count here so that el1_irq() knows that it is already on the
+ * irq stack.
+ *
+ * Called with interrupts disabled, so we don't worry about moving cpu, or
+ * being interrupted while modifying irq_count.
+ *
+ * This function doesn't actually switch stack.
+ */
+void do_softirq_own_stack(void)
+{
+	int cpu = smp_processor_id();
+
+	WARN_ON_ONCE(!irqs_disabled());
+
+	if (on_irq_stack(current_stack_pointer, cpu)) {
+		IRQ_COUNT()++;
+		__do_softirq();
+		IRQ_COUNT()--;
+	} else {
+		__do_softirq();
+	}
+}
-- 
2.6.2
