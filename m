From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Sun, 13 Sep 2015 14:42:17 +0000
Subject: [PATCH v2] arm64: Introduce IRQ stack
Message-ID: <1442155337-7020-1-git-send-email-jungseoklee85@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, kernel context and interrupts are handled using a single
kernel stack navigated by sp_el1. This forces many systems to use
16KB stack, not 8KB one. Low memory platforms naturally suffer from
memory pressure accompanied by performance degradation.

This patch addresses the issue as introducing a separate percpu IRQ
stack to handle both hard and soft interrupts with two ground rules:

  - Utilize sp_el0 in EL1 context, which is not used currently
  - Do not complicate current_thread_info calculation

It is a core concept to trace struct thread_info using sp_el0 instead
of sp_el1. This approach helps arm64 align with other architectures
regarding object_is_on_stack() without additional complexity.

Cc: James Morse <james.morse@arm.com>
Signed-off-by: Jungseok Lee <jungseoklee85@gmail.com>
---
Changes since v1:
- Rebased on top of v4.3-rc1
- Removed Kconfig about IRQ stack, per James
- Used PERCPU for IRQ stack, per James
- Tried to allocate IRQ stack when CPU is about to start up, per James
- Moved sp_el0 update into kernel_entry macro, per James
- Dropped S_SP removal patch, per Mark and James

 arch/arm64/include/asm/irq.h         |  8 +++
 arch/arm64/include/asm/thread_info.h |  7 +-
 arch/arm64/kernel/asm-offsets.c      |  5 ++
 arch/arm64/kernel/entry.S            | 54 ++++++++++++++--
 arch/arm64/kernel/head.S             |  3 +
 arch/arm64/kernel/irq.c              | 21 ++++++
 arch/arm64/kernel/smp.c              |  6 ++
 7 files changed, 95 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index bbb251b..67975a2 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -5,11 +5,19 @@
 
 #include <asm-generic/irq.h>
 
+struct irq_stack {
+	void *stack;
+	unsigned long thread_sp;
+	unsigned int count;
+};
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
index dcd06d1..44839c0 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -73,8 +73,11 @@ static inline struct thread_info *current_thread_info(void) __attribute_const__;
 
 static inline struct thread_info *current_thread_info(void)
 {
-	return (struct thread_info *)
-		(current_stack_pointer & ~(THREAD_SIZE - 1));
+	unsigned long sp_el0;
+
+	asm volatile("mrs %0, sp_el0" : "=r" (sp_el0));
+
+	return (struct thread_info *)(sp_el0 & ~(THREAD_SIZE - 1));
 }
 
 #define thread_saved_pc(tsk)	\
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 8d89cf8..3bb5ce0 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -22,6 +22,7 @@
 #include <linux/mm.h>
 #include <linux/dma-mapping.h>
 #include <linux/kvm_host.h>
+#include <asm/irq.h>
 #include <asm/thread_info.h>
 #include <asm/memory.h>
 #include <asm/smp_plat.h>
@@ -41,6 +42,10 @@ int main(void)
   BLANK();
   DEFINE(THREAD_CPU_CONTEXT,	offsetof(struct task_struct, thread.cpu_context));
   BLANK();
+  DEFINE(IRQ_STACK,		offsetof(struct irq_stack, stack));
+  DEFINE(IRQ_THREAD_SP,		offsetof(struct irq_stack, thread_sp));
+  DEFINE(IRQ_COUNT,		offsetof(struct irq_stack, count));
+  BLANK();
   DEFINE(S_X0,			offsetof(struct pt_regs, regs[0]));
   DEFINE(S_X1,			offsetof(struct pt_regs, regs[1]));
   DEFINE(S_X2,			offsetof(struct pt_regs, regs[2]));
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 4306c93..c156540 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -88,7 +88,7 @@
 
 	.if	\el == 0
 	mrs	x21, sp_el0
-	get_thread_info tsk			// Ensure MDSCR_EL1.SS is clear,
+	get_thread_info \el, tsk		// Ensure MDSCR_EL1.SS is clear,
 	ldr	x19, [tsk, #TI_FLAGS]		// since we can unmask debug
 	disable_step_tsk x19, x20		// exceptions when scheduling.
 	.else
@@ -105,6 +105,8 @@
 	.if	\el == 0
 	mvn	x21, xzr
 	str	x21, [sp, #S_SYSCALLNO]
+	mov	x25, sp
+	msr	sp_el0, x25
 	.endif
 
 	/*
@@ -163,9 +165,45 @@ alternative_endif
 	eret					// return to kernel
 	.endm
 
-	.macro	get_thread_info, rd
+	.macro	get_thread_info, el, rd
+	.if	\el == 0
 	mov	\rd, sp
-	and	\rd, \rd, #~(THREAD_SIZE - 1)	// top of stack
+	.else
+	mrs	\rd, sp_el0
+	.endif
+	and	\rd, \rd, #~(THREAD_SIZE - 1)	// bottom of thread stack
+	.endm
+
+	.macro	get_irq_stack
+	adr_l	x21, irq_stacks
+	mrs	x22, tpidr_el1
+	add	x21, x21, x22
+	.endm
+
+	.macro	irq_stack_entry
+	get_irq_stack
+	ldr	w23, [x21, #IRQ_COUNT]
+	cbnz	w23, 1f				// check irq recursion
+	mov	x23, sp
+	str	x23, [x21, #IRQ_THREAD_SP]
+	ldr	x23, [x21, #IRQ_STACK]
+	mov	sp, x23
+	mov	x23, xzr
+1:	add	w23, w23, #1
+	str	w23, [x21, #IRQ_COUNT]
+	.endm
+
+	.macro	irq_stack_exit
+	get_irq_stack
+	ldr	w23, [x21, #IRQ_COUNT]
+	sub	w23, w23, #1
+	cbnz	w23, 1f				// check irq recursion
+	mov	x23, sp
+	str	x23, [x21, #IRQ_STACK]
+	ldr	x23, [x21, #IRQ_THREAD_SP]
+	mov	sp, x23
+	mov	x23, xzr
+1:	str	w23, [x21, #IRQ_COUNT]
 	.endm
 
 /*
@@ -183,10 +221,11 @@ tsk	.req	x28		// current thread_info
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
@@ -361,7 +400,7 @@ el1_irq:
 	irq_handler
 
 #ifdef CONFIG_PREEMPT
-	get_thread_info tsk
+	get_thread_info 1, tsk
 	ldr	w24, [tsk, #TI_PREEMPT]		// get preempt count
 	cbnz	w24, 1f				// preempt count != 0
 	ldr	x0, [tsk, #TI_FLAGS]		// get flags
@@ -597,6 +636,7 @@ ENTRY(cpu_switch_to)
 	ldp	x29, x9, [x8], #16
 	ldr	lr, [x8]
 	mov	sp, x9
+	msr	sp_el0, x9
 	ret
 ENDPROC(cpu_switch_to)
 
@@ -655,7 +695,7 @@ ENTRY(ret_from_fork)
 	cbz	x19, 1f				// not a kernel thread
 	mov	x0, x20
 	blr	x19
-1:	get_thread_info tsk
+1:	get_thread_info 1, tsk
 	b	ret_to_user
 ENDPROC(ret_from_fork)
 
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index a055be6..cb13290 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -441,6 +441,8 @@ __mmap_switched:
 	b	1b
 2:
 	adr_l	sp, initial_sp, x4
+	mov	x4, sp
+	msr	sp_el0, x4
 	str_l	x21, __fdt_pointer, x5		// Save FDT pointer
 	str_l	x24, memstart_addr, x6		// Save PHYS_OFFSET
 	mov	x29, #0
@@ -613,6 +615,7 @@ ENDPROC(secondary_startup)
 ENTRY(__secondary_switched)
 	ldr	x0, [x21]			// get secondary_data.stack
 	mov	sp, x0
+	msr	sp_el0, x0
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
-- 
2.5.0
