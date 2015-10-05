From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Tue, 6 Oct 2015 05:03:57 +0900
Subject: [PATCH v3] arm64: Introduce IRQ stack
In-Reply-To: <5612B239.102@arm.com>
References: <1442923918-11289-1-git-send-email-jungseoklee85@gmail.com>
 <560EAF9F.6090604@arm.com> <67E35231-C136-49B9-B0EF-CD0A2B21752A@gmail.com>
 <56121A97.7000600@linaro.org> <5612B239.102@arm.com>
Message-ID: <A66B7FD7-F495-40A8-8856-0FB3E79C089E@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Oct 6, 2015, at 2:24 AM, James Morse wrote:

Hi James,

> On 05/10/15 07:37, AKASHI Takahiro wrote:
>> On 10/04/2015 11:32 PM, Jungseok Lee wrote:
>>> On Oct 3, 2015, at 1:23 AM, James Morse wrote:
>>>> One observed change in behaviour:
>>>> Any stack-unwinding now stops at el1_irq(), which is the bottom of the irq
>>>> stack. This shows up with perf (using incantation [0]), and with any calls
>>>> to dump_stack() (which actually stops the frame before el1_irq()).
>>>> 
>>>> I don't know if this will break something, (perf still seems to work) - but
>>>> it makes the panic() output less useful, as all the 'other' cpus print:
>>> 
>>> Agreed. A process stack should be walked to deliver useful information.
>>> 
>>> There are two approaches I've tried as experimental.
>>> 
>>> 1) Link IRQ stack to a process one via frame pointer
>>> As saving x29 and elr_el1 into IRQ stack and then updating x29, IRQ stack
>>> could be linked to a process one. It is similar to your patch except some
>>> points. However, it might complicate "stack tracer on ftrace" issue.
>> 
>> Well, as far as object_is_on_stack() works correctly, stack tracer will not
>> follow an interrupt stack even if unwind_frame() might traverse from
>> an interrupt stack to a process stack. See check_stack().
>> 
>> Under this assumption, I'm going to simplify my "stack tracer" bugfix
>> by removing interrupt-related nasty hacks that I described in RFC.
>> 
>> Thanks,
>> -Takahiro AKASHI
>> 
>> 
>>> 2) Walk a process stack followed by IRQ one
>>> This idea, which is straightforward, comes from x86 implementation [1]. The
>>> approach might be orthogonal to "stack tracer on ftrace" issue. In this
>>> case,
> 
> x86 has to walk interrupt/exception stacks because the order may be:
> process -> hw_irq -> debug_exception -> double_fault.
> Where each of these could have its own stack, the code needs to determine
> the correct order to produce a correct stack trace.
> 
> Our case is a lot simpler, as we could only ever have two, and know the
> order. We only need to walk the irq stack if we are currently using it, and
> we always know the process stack is last.

Right. The below hunk is written under this assumption.

> I would go with the first option, being careful of stack corruption when
> stepping between them.

I've struggled with unwind_frame() for this approach, but I don't figure out
a solid solution yet. "stack tracer on ftrace" issue would be worse if the
function, unwind_frame(), which is shared with ftrace, is not carefully changed.
In addition, as mentioned earlier in other threads, I've failed to understand two
constants, 0x10 and 0x18. Especially, I'm not confident of the former, 0x10. AFAIU,
the value cannot be retrieved exactly without a helper such as a function prologue
analyzer described in [1].

> 
>>> unfortunately, a top bit comparison of stack pointer cannot be adopted
>>> due to
>>> a necessity of a final snapshot of a process stack pointer, which is struct
>>> irq_stack::thread_sp in v2 patch.
> 
> I'm not sure I follow you here.
> 
> We can check if regs->sp is an irq stack by comparing it with the per-cpu
> irq_stack value, (top bits comparison). Then we know that the last
> frame-pointer (in your (1) above), will point to the process stack, at
> which point we can walk onto that stack.

You're right. The top bits comparison method is still valid in this approach
as utilizing more registers. For clear communication, the code I've played with
is attached. I've squashed all changes for convenience. I will split the change
to two commits when posting them. It is a shame to load the same info, top of IRQ
stack, twice in the below hunk. Any ideas are always welcome.

----8<----
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 07d1811..9767bd9 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -68,6 +68,7 @@ config ARM64
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS
+	select HAVE_IRQ_EXIT_ON_IRQ_STACK
 	select HAVE_MEMBLOCK
 	select HAVE_PATA_PLATFORM
 	select HAVE_PERF_EVENTS
diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index bbb251b..e5904a1 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -2,14 +2,32 @@
 #define __ASM_IRQ_H
 
 #include <linux/irqchip/arm-gic-acpi.h>
+#include <asm/stacktrace.h>
 
 #include <asm-generic/irq.h>
 
+struct irq_stack {
+	void *stack;
+	struct stackframe frame;
+};
+
+DECLARE_PER_CPU(struct irq_stack, irq_stacks);
+
+static inline bool in_irq_stack(unsigned int cpu)
+{
+	unsigned long high = (unsigned long)per_cpu(irq_stacks, cpu).stack;
+
+	return (current_stack_pointer >= round_down(high, THREAD_SIZE)) &&
+		current_stack_pointer < high;
+}
+
 struct pt_regs;
 
 extern void migrate_irqs(void);
 extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));
 
+extern int alloc_irq_stack(unsigned int cpu);
+
 static inline void acpi_irq_init(void)
 {
 	/*
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index dcd06d1..fa014df 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -71,10 +71,16 @@ register unsigned long current_stack_pointer asm ("sp");
  */
 static inline struct thread_info *current_thread_info(void) __attribute_const__;
 
+/*
+ * struct thread_info can be accessed directly via sp_el0.
+ */
 static inline struct thread_info *current_thread_info(void)
 {
-	return (struct thread_info *)
-		(current_stack_pointer & ~(THREAD_SIZE - 1));
+	unsigned long sp_el0;
+
+	asm ("mrs %0, sp_el0" : "=r" (sp_el0));
+
+	return (struct thread_info *)sp_el0;
 }
 
 #define thread_saved_pc(tsk)	\
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 8d89cf8..9a07e75 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -41,6 +41,11 @@ int main(void)
   BLANK();
   DEFINE(THREAD_CPU_CONTEXT,	offsetof(struct task_struct, thread.cpu_context));
   BLANK();
+  DEFINE(IRQ_STACK,		offsetof(struct irq_stack, stack));
+  DEFINE(IRQ_FRAME_FP,		offsetof(struct irq_stack, frame.fp));
+  DEFINE(IRQ_FRMAE_SP,		offsetof(struct irq_stack, frame.sp));
+  DEFINE(IRQ_FRAME_PC,		offsetof(struct irq_stack, frame.pc));
+  BLANK();
   DEFINE(S_X0,			offsetof(struct pt_regs, regs[0]));
   DEFINE(S_X1,			offsetof(struct pt_regs, regs[1]));
   DEFINE(S_X2,			offsetof(struct pt_regs, regs[2]));
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 4306c93..d5cae37 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -88,7 +88,8 @@
 
 	.if	\el == 0
 	mrs	x21, sp_el0
-	get_thread_info tsk			// Ensure MDSCR_EL1.SS is clear,
+	mov	tsk, sp
+	and	tsk, tsk, #~(THREAD_SIZE - 1)	// Ensure MDSCR_EL1.SS is clear,
 	ldr	x19, [tsk, #TI_FLAGS]		// since we can unmask debug
 	disable_step_tsk x19, x20		// exceptions when scheduling.
 	.else
@@ -96,6 +97,7 @@
 	.endif
 	mrs	x22, elr_el1
 	mrs	x23, spsr_el1
+	mov	x24, x29
 	stp	lr, x21, [sp, #S_LR]
 	stp	x22, x23, [sp, #S_PC]
 
@@ -108,12 +110,20 @@
 	.endif
 
 	/*
+	 * Set sp_el0 to current thread_info.
+	 */
+	.if	\el == 0
+	msr	sp_el0, tsk
+	.endif
+
+	/*
 	 * Registers that may be useful after this macro is invoked:
 	 *
 	 * x21 - aborted SP
 	 * x22 - aborted PC
 	 * x23 - aborted PSTATE
-	*/
+	 * x24 - aborted FP
+	 */
 	.endm
 
 	.macro	kernel_exit, el
@@ -164,8 +174,35 @@ alternative_endif
 	.endm
 
 	.macro	get_thread_info, rd
-	mov	\rd, sp
-	and	\rd, \rd, #~(THREAD_SIZE - 1)	// top of stack
+	mrs	\rd, sp_el0
+	.endm
+
+	.macro	irq_stack_entry
+	adr_l	x19, irq_stacks
+	mrs	x20, tpidr_el1
+	add	x19, x19, x20
+
+	ldr	x23, [x19, #IRQ_STACK]
+	and	x20, x23, #~(THREAD_SIZE - 1)
+	mov	x23, sp
+	and	x23, x23, #~(THREAD_SIZE - 1)
+	cmp	x20, x23			// check irq re-enterance
+	beq	1f
+
+	ldr	x20, [x19, #IRQ_STACK]
+	str	x24, [x19, #IRQ_FRAME_FP]
+	str	x21, [x19, #IRQ_FRMAE_SP]
+	str	x22, [x19, #IRQ_FRAME_PC]
+1:	mov	x19, sp
+	csel	x23, x19, x20, eq		// x20 = top of irq stack
+	mov	sp, x23
+	.endm
+
+	/*
+	 * x19 is preserved between irq_stack_entry and irq_stack_exit.
+	 */
+	.macro	irq_stack_exit
+	mov	sp, x19
 	.endm
 
 /*
@@ -183,10 +220,11 @@ tsk	.req	x28		// current thread_info
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
@@ -597,6 +635,8 @@ ENTRY(cpu_switch_to)
 	ldp	x29, x9, [x8], #16
 	ldr	lr, [x8]
 	mov	sp, x9
+	and	x9, x9, #~(THREAD_SIZE - 1)
+	msr	sp_el0, x9
 	ret
 ENDPROC(cpu_switch_to)
 
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 90d09ed..dab089b 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -441,6 +441,9 @@ __mmap_switched:
 	b	1b
 2:
 	adr_l	sp, initial_sp, x4
+	mov	x4, sp
+	and	x4, x4, #~(THREAD_SIZE - 1)
+	msr	sp_el0, x4			// Save thread_info
 	str_l	x21, __fdt_pointer, x5		// Save FDT pointer
 	str_l	x24, memstart_addr, x6		// Save PHYS_OFFSET
 	mov	x29, #0
@@ -618,6 +621,8 @@ ENDPROC(secondary_startup)
 ENTRY(__secondary_switched)
 	ldr	x0, [x21]			// get secondary_data.stack
 	mov	sp, x0
+	and	x0, x0, #~(THREAD_SIZE - 1)
+	msr	sp_el0, x0			// save thread_info
 	mov	x29, #0
 	b	secondary_start_kernel
 ENDPROC(__secondary_switched)
diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index 11dc3fd..88acb63 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -31,6 +31,8 @@
 
 unsigned long irq_err_count;
 
+DEFINE_PER_CPU(struct irq_stack, irq_stacks);
+
 int arch_show_interrupts(struct seq_file *p, int prec)
 {
 	show_ipi_list(p, prec);
@@ -50,6 +52,9 @@ void __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
 
 void __init init_IRQ(void)
 {
+	if (alloc_irq_stack(smp_processor_id()))
+		panic("Failed to allocate IRQ stack for boot cpu");
+
 	irqchip_init();
 	if (!handle_arch_irq)
 		panic("No interrupt controller found.");
@@ -115,3 +120,19 @@ void migrate_irqs(void)
 	local_irq_restore(flags);
 }
 #endif /* CONFIG_HOTPLUG_CPU */
+
+int alloc_irq_stack(unsigned int cpu)
+{
+	void *stack;
+
+	if (per_cpu(irq_stacks, cpu).stack)
+		return 0;
+
+	stack = (void *)__get_free_pages(THREADINFO_GFP, THREAD_SIZE_ORDER);
+	if (!stack)
+		return -ENOMEM;
+
+	per_cpu(irq_stacks, cpu).stack = stack + THREAD_START_SP;
+
+	return 0;
+}
diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
index f586f7c..e33fe33 100644
--- a/arch/arm64/kernel/sleep.S
+++ b/arch/arm64/kernel/sleep.S
@@ -173,6 +173,9 @@ ENTRY(cpu_resume)
 	/* load physical address of identity map page table in x1 */
 	adrp	x1, idmap_pg_dir
 	mov	sp, x2
+	/* save thread_info */
+	and	x2, x2, #~(THREAD_SIZE - 1)
+	msr	sp_el0, x2
 	/*
 	 * cpu_do_resume expects x0 to contain context physical address
 	 * pointer and x1 to contain physical address of 1:1 page tables
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index dbdaacd..0bd7049 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -97,6 +97,12 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
 	secondary_data.stack = task_stack_page(idle) + THREAD_START_SP;
 	__flush_dcache_area(&secondary_data, sizeof(secondary_data));
 
+	ret = alloc_irq_stack(cpu);
+	if (ret) {
+		pr_crit("CPU%u: failed to allocate IRQ stack\n", cpu);
+		return ret;
+	}
+
 	/*
 	 * Now bring the CPU into our world.
 	 */
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index f93aae5..fe10371 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -146,6 +146,8 @@ static void dump_instr(const char *lvl, struct pt_regs *regs)
 static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 {
 	struct stackframe frame;
+	unsigned int cpu = smp_processor_id();
+	bool in_irq = in_irq_stack(cpu);
 
 	pr_debug("%s(regs = %p tsk = %p)\n", __func__, regs, tsk);
 
@@ -170,6 +172,8 @@ static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 	}
 
 	pr_emerg("Call trace:\n");
+repeat:
+	pr_emerg("<%s>\n", in_irq ? "IRQ" : "Process");
 	while (1) {
 		unsigned long where = frame.pc;
 		int ret;
@@ -179,6 +183,12 @@ static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 			break;
 		dump_backtrace_entry(where, frame.sp);
 	}
+
+	if (in_irq) {
+		frame = per_cpu(irq_stacks, cpu).frame;
+		in_irq = false;
+		goto repeat;
+	}
 }
 
 void show_stack(struct task_struct *tsk, unsigned long *sp)
----8<----

> 
>>> BTW, I have another question. Is it reasonable to introduce THREAD_SIZE as a
>>> kernel configuration option like page size for the sake of convenience
>>> because
>>> a combination of ARM64 and a small ram is not unusual in real practice?
> 
> We want the smallest safe value. It's probably best leaving as it is for
> now - once we have this feature, we can collect maximum stack-usage sizes
> for different platforms and workloads, and decide on the smallest safe value.

Got it.

Thanks for the comments!

Best Regards
Jungseok Lee

[1] http://comments.gmane.org/gmane.linux.ports.arm.kernel/439260
