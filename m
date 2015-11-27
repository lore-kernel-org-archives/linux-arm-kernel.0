From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Sat, 28 Nov 2015 00:37:31 +0900
Subject: [PATCH v7 3/3] arm64: Add do_softirq_own_stack() and enable
 irq_stacks
In-Reply-To: <20151127114715.GA25499@e104818-lin.cambridge.arm.com>
References: <1447698128-8490-1-git-send-email-james.morse@arm.com>
 <1447698128-8490-4-git-send-email-james.morse@arm.com>
 <8F6484A9-18B9-4A81-B58D-528D81BC196D@gmail.com>
 <20151127114715.GA25499@e104818-lin.cambridge.arm.com>
Message-ID: <61333097-CD88-472C-8E59-A8FF0DBC1DC7@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Nov 27, 2015, at 8:47 PM, Catalin Marinas wrote:

Hi Catalin,

> On Thu, Nov 19, 2015 at 11:26:08PM +0900, Jungseok Lee wrote:
>>> +/*
>>> + * do_softirq_own_stack() is called from irq_exit() before __do_softirq()
>>> + * re-enables interrupts, at which point we may re-enter el?_irq(). We
>>> + * increase irq_count here so that el1_irq() knows that it is already on the
>>> + * irq stack.
>>> + *
>>> + * Called with interrupts disabled, so we don't worry about moving cpu, or
>>> + * being interrupted while modifying irq_count.
>>> + *
>>> + * This function doesn't actually switch stack.
>>> + */
>>> +void do_softirq_own_stack(void)
>>> +{
>>> +	int cpu = smp_processor_id();
>>> +
>>> +	WARN_ON_ONCE(!irqs_disabled());
>>> +
>>> +	if (on_irq_stack(current_stack_pointer, cpu)) {
>>> +		per_cpu(irq_count, cpu)++;
>>> +		__do_softirq();
>>> +		per_cpu(irq_count, cpu)--;
>>> +	} else {
>>> +		__do_softirq();
>>> +	}
>>> +}
>> 
>> I'm really interested in feedbacks from other folks since, as you know
>> well, softirq could be handled using a process stack under this design.
> 
> With this approach, we could run softirq either on the IRQ stack or on
> the process stack. One such process is softirqd, so there shouldn't be a
> problem since its goal is to run softirqs. But do_softirq() may be
> invoked from other contexts (network stack), I'm not sure what the stack
> looks like at that point.
> 
> We could just do like x86 and always switch to the IRQ stack before
> invoking __do_softirq(). I don't think we lose much.

The lazy update has an obvious advantage in case of softirqd as avoiding
stack switch cost. OTOH, debugging (e.g register dump from stack) would
be more difficult since we have to find out which stack was used at the
last snapshot. Another point is the network context you mentioned. I can't
get an answer on the following question: Could we cover all network
scenarios with this approach which differs from x86 one?

The below is "always switch" implementation for reference. A couple of
comments you've left have been already addressed. I will post it if
"always switch" method is picked up ;)

Best Regards
Jungseok Lee

----8<----

 arch/arm64/Kconfig              |  1 +
 arch/arm64/include/asm/irq.h    | 16 +++++++
 arch/arm64/kernel/asm-offsets.c |  2 +
 arch/arm64/kernel/entry.S       | 53 ++++++++++++++++++++-
 arch/arm64/kernel/irq.c         |  2 +
 arch/arm64/kernel/smp.c         |  4 +-
 6 files changed, 74 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 9ac16a4..a12f015 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -70,6 +70,7 @@ config ARM64
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS
+	select HAVE_IRQ_EXIT_ON_IRQ_STACK
 	select HAVE_MEMBLOCK
 	select HAVE_PATA_PLATFORM
 	select HAVE_PERF_EVENTS
diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index 23eb450..d4cbae6 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -1,10 +1,26 @@
 #ifndef __ASM_IRQ_H
 #define __ASM_IRQ_H
 
+#define IRQ_STACK_SIZE		16384
+
+#ifndef __ASSEMBLY__
+
 #include <asm-generic/irq.h>
 
+#define __ARCH_HAS_DO_SOFTIRQ
+
+struct irq_stack {
+	unsigned int count;
+	/*
+	 * The stack must be quad-word aligned according to '5.2.2 The stack'
+	 * of 'Procedure Call Standard for the ARM 64-bit Architecture'.
+	 */
+	char stack[IRQ_STACK_SIZE] __aligned(16);
+};
+
 struct pt_regs;
 
 extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));
 
 #endif
+#endif
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 25de8b2..f8b4df7 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -41,6 +41,8 @@ int main(void)
   BLANK();
   DEFINE(THREAD_CPU_CONTEXT,	offsetof(struct task_struct, thread.cpu_context));
   BLANK();
+  DEFINE(IRQ_STACK,		offsetof(struct irq_stack, stack));
+  BLANK();
   DEFINE(S_X0,			offsetof(struct pt_regs, regs[0]));
   DEFINE(S_X1,			offsetof(struct pt_regs, regs[1]));
   DEFINE(S_X2,			offsetof(struct pt_regs, regs[2]));
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index fc87373..bc01102 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -27,9 +27,12 @@
 #include <asm/cpufeature.h>
 #include <asm/errno.h>
 #include <asm/esr.h>
+#include <asm/irq.h>
 #include <asm/thread_info.h>
 #include <asm/unistd.h>
 
+#define IRQ_STACK_START_SP	(IRQ_STACK + IRQ_STACK_SIZE - 16)
+
 /*
  * Context tracking subsystem.  Used to instrument transitions
  * between user and kernel mode.
@@ -175,6 +178,29 @@ alternative_endif
 	mrs	\rd, sp_el0
 	.endm
 
+	.macro	irq_stack_entry
+	adr_l	x19, irq_stacks
+	mrs	x20, tpidr_el1
+	add	x20, x19, x20
+	mov	x19, sp
+	ldr	w23, [x20]
+	cbnz	w23, 1f				// check irq re-entrance
+	mov	x24, #IRQ_STACK_START_SP
+	add	x24, x20, x24			// x24 = top of irq stack
+	mov	sp, x24
+1:	add	w23, w23, #1
+	str	w23, [x20]
+	.endm
+
+	/*
+	 * x19, x20, w23 are preserved between irq_stack_{entry|exit}.
+	 */
+	.macro	irq_stack_exit
+	sub	w23, w23, #1
+	str	w23, [x20]
+	mov	sp, x19
+	.endm
+
 /*
  * These are the registers used in the syscall handler, and allow us to
  * have in theory up to 7 arguments to a function - x0 to x6.
@@ -190,10 +216,11 @@ tsk	.req	x28		// current thread_info
  * Interrupt handling.
  */
 	.macro	irq_handler
-	adrp	x1, handle_arch_irq
-	ldr	x1, [x1, #:lo12:handle_arch_irq]
+	ldr_l	x1, handle_arch_irq
 	mov	x0, sp
+	irq_stack_entry
 	blr	x1
+	irq_stack_exit
 	.endm
 
 	.text
@@ -741,3 +768,25 @@ ENTRY(sys_rt_sigreturn_wrapper)
 	mov	x0, sp
 	b	sys_rt_sigreturn
 ENDPROC(sys_rt_sigreturn_wrapper)
+
+/*
+ * Softirq is handled on IRQ stack.
+ */
+ENTRY(do_softirq_own_stack)
+	stp	x29, lr, [sp, #-96]!
+	stp	x19, x20, [sp, #16]
+	stp	x21, x22, [sp, #32]
+	stp	x23, x24, [sp, #48]
+	stp	x25, x26, [sp, #64]
+	stp	x27, x28, [sp, #80]
+	irq_stack_entry
+	bl	__do_softirq
+	irq_stack_exit
+	ldp	x19, x20, [sp, #16]
+	ldp	x21, x22, [sp, #32]
+	ldp	x23, x24, [sp, #48]
+	ldp	x25, x26, [sp, #64]
+	ldp	x27, x28, [sp, #80]
+	ldp	x29, lr, [sp], #96
+	ret
+ENDPROC(do_softirq_own_stack)
diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index 9f17ec0..6094ec8 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -30,6 +30,8 @@
 
 unsigned long irq_err_count;
 
+DEFINE_PER_CPU(struct irq_stack, irq_stacks);
+
 int arch_show_interrupts(struct seq_file *p, int prec)
 {
 	show_ipi_list(p, prec);
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index b1adc51..532a11f 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -91,8 +91,8 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
 	int ret;
 
 	/*
-	 * We need to tell the secondary core where to find its stack and the
-	 * page tables.
+	 * We need to tell the secondary core where to find its process stack
+	 * and the page tables.
 	 */
 	secondary_data.stack = task_stack_page(idle) + THREAD_START_SP;
 	__flush_dcache_area(&secondary_data, sizeof(secondary_data));
-- 
2.5.0
