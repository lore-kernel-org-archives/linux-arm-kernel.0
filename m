From: james.morse@arm.com (James Morse)
Date: Mon, 16 Nov 2015 18:22:07 +0000
Subject: [PATCH v7 3/3] arm64: Add do_softirq_own_stack() and enable irq_stacks
In-Reply-To: <1447698128-8490-1-git-send-email-james.morse@arm.com>
References: <1447698128-8490-1-git-send-email-james.morse@arm.com>
Message-ID: <1447698128-8490-4-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

entry.S is modified to switch to the per_cpu irq_stack during el{0,1}_irq.
irq_count is used to detect recursive interrupts on the irq_stack, it is
updated late by do_softirq_own_stack(), when called on the irq_stack, before
__do_softirq() re-enabled interrupts to process softirqs.

This patch adds the dummy stack frame and data needed by the previous
stack tracing patches.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/irq.h |  2 ++
 arch/arm64/kernel/entry.S    | 30 ++++++++++++++++++++++++++++++
 arch/arm64/kernel/irq.c      | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+)

diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index bf823c5f8cbd..04aae95dee8d 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -6,6 +6,8 @@
 #include <asm-generic/irq.h>
 #include <asm/thread_info.h>
 
+#define __ARCH_HAS_DO_SOFTIRQ
+
 struct pt_regs;
 
 DECLARE_PER_CPU(unsigned long, irq_stack_ptr);
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 1971da98dfad..45473838fe21 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -175,6 +175,34 @@ alternative_endif
 	mrs	\rd, sp_el0
 	.endm
 
+	.macro	irq_stack_entry
+	mov	x19, sp			// preserve the original sp
+	adr_l   x25, irq_count		// incremented by do_softirq_own_stack()
+	mrs	x26, tpidr_el1
+	add	x25, x25, x26
+	ldr	w25, [x25]
+	cbnz	w25, 1f			// recursive use?
+
+	/* switch to the irq stack */
+	adr_l	x25, irq_stack_ptr
+	add	x25, x25, x26
+	ldr	x25, [x25]
+	mov	sp, x25
+
+	/* Add a dummy stack frame */
+	stp     x29, x22, [sp, #-16]!           // dummy stack frame
+	mov	x29, sp
+	stp     xzr, x19, [sp, #-16]!
+1:
+	.endm
+
+	/*
+	 * x19 is preserved between irq_stack_entry and irq_stack_exit.
+	 */
+	.macro	irq_stack_exit
+	mov	sp, x19
+	.endm
+
 /*
  * These are the registers used in the syscall handler, and allow us to
  * have in theory up to 7 arguments to a function - x0 to x6.
@@ -192,7 +220,9 @@ tsk	.req	x28		// current thread_info
 	.macro	irq_handler
 	ldr_l	x1, handle_arch_irq
 	mov	x0, sp
+	irq_stack_entry
 	blr	x1
+	irq_stack_exit
 	.endm
 
 	.text
diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index da752bb18bfb..838541cf5e5d 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -25,6 +25,7 @@
 #include <linux/irq.h>
 #include <linux/smp.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/irqchip.h>
 #include <linux/seq_file.h>
 
@@ -34,6 +35,13 @@ unsigned long irq_err_count;
 DEFINE_PER_CPU(unsigned long [IRQ_STACK_SIZE/sizeof(long)], irq_stack) __aligned(16);
 DEFINE_PER_CPU(unsigned long, irq_stack_ptr);
 
+/*
+ * irq_count is used to detect recursive use of the irq_stack, it is lazily
+ * incremented very late, by do_softirq_own_stack(), which is called on the
+ * irq_stack, before re-enabling interrupts to process softirqs.
+ */
+DEFINE_PER_CPU(unsigned int, irq_count);
+
 int arch_show_interrupts(struct seq_file *p, int prec)
 {
 	show_ipi_list(p, prec);
@@ -66,3 +74,29 @@ void init_irq_stack(unsigned int cpu)
 
 	per_cpu(irq_stack_ptr, cpu) = stack + IRQ_STACK_START_SP;
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
+		per_cpu(irq_count, cpu)++;
+		__do_softirq();
+		per_cpu(irq_count, cpu)--;
+	} else {
+		__do_softirq();
+	}
+}
-- 
2.1.4
