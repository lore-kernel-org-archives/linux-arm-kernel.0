From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Fri,  4 Sep 2015 14:23:06 +0000
Subject: [RFC PATCH 2/3] arm64: Introduce IRQ stack
In-Reply-To: <1441376587-12979-1-git-send-email-jungseoklee85@gmail.com>
References: <1441376587-12979-1-git-send-email-jungseoklee85@gmail.com>
Message-ID: <1441376587-12979-3-git-send-email-jungseoklee85@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, kernel context and interrupts are handled using a single
kernel stack navigated by sp_el1. This forces many systems to use
16KB stack, not 8KB one. Low memory platforms naturally suffer from
both memory pressure and performance degradation simultaneously as
VM page allocator falls into slowpath frequently.

This patch, thus, solves the problem as introducing a separate percpu
IRQ stack to handle both hard and soft interrupts with two ground rules:

  - Utilize sp_el0 in EL1 context, which is not used currently
  - Do *not* complicate current_thread_info calculation

struct thread_info can be tracked easily using sp_el0, not sp_el1 when
this feature is enabled.

Signed-off-by: Jungseok Lee <jungseoklee85@gmail.com>
---
 arch/arm64/Kconfig.debug             | 10 ++
 arch/arm64/include/asm/irq.h         |  8 ++
 arch/arm64/include/asm/thread_info.h | 11 ++
 arch/arm64/kernel/asm-offsets.c      |  8 ++
 arch/arm64/kernel/entry.S            | 83 +++++++++++++++-
 arch/arm64/kernel/head.S             |  7 ++
 arch/arm64/kernel/irq.c              | 18 ++++
 7 files changed, 142 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
index d6285ef..e16d91f 100644
--- a/arch/arm64/Kconfig.debug
+++ b/arch/arm64/Kconfig.debug
@@ -18,6 +18,16 @@ config ARM64_PTDUMP
 	  kernel.
 	  If in doubt, say "N"
 
+config IRQ_STACK
+	bool "Use separate kernel stack when handling interrupts"
+	depends on ARM64_4K_PAGES
+	help
+	  Say Y here if you want to use separate kernel stack to handle both
+	  hard and soft interrupts. As reduceing memory footprint regarding
+	  kernel stack, it benefits low memory platforms.
+
+	  If in doubt, say N.
+
 config STRICT_DEVMEM
 	bool "Filter access to /dev/mem"
 	depends on MMU
diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index bbb251b..3ec1fa2 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -5,6 +5,14 @@
 
 #include <asm-generic/irq.h>
 
+#ifdef CONFIG_IRQ_STACK
+struct irq_stack {
+	void *stack;
+	unsigned long thread_sp;
+	unsigned int count;
+};
+#endif
+
 struct pt_regs;
 
 extern void migrate_irqs(void);
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index dcd06d1..5345a67 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -71,11 +71,22 @@ register unsigned long current_stack_pointer asm ("sp");
  */
 static inline struct thread_info *current_thread_info(void) __attribute_const__;
 
+#ifndef CONFIG_IRQ_STACK
 static inline struct thread_info *current_thread_info(void)
 {
 	return (struct thread_info *)
 		(current_stack_pointer & ~(THREAD_SIZE - 1));
 }
+#else
+static inline struct thread_info *current_thread_info(void)
+{
+	unsigned long sp_el0;
+
+	asm volatile("mrs %0, sp_el0" : "=r" (sp_el0));
+
+	return (struct thread_info *)(sp_el0 & ~(THREAD_SIZE - 1));
+}
+#endif
 
 #define thread_saved_pc(tsk)	\
 	((unsigned long)(tsk->thread.cpu_context.pc))
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index c99701a..6feee0e 100644
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
@@ -41,6 +42,13 @@ int main(void)
   BLANK();
   DEFINE(THREAD_CPU_CONTEXT,	offsetof(struct task_struct, thread.cpu_context));
   BLANK();
+#ifdef CONFIG_IRQ_STACK
+  DEFINE(IRQ_STACK,		offsetof(struct irq_stack, stack));
+  DEFINE(IRQ_THREAD_SP,		offsetof(struct irq_stack, thread_sp));
+  DEFINE(IRQ_COUNT,		offsetof(struct irq_stack, count));
+  DEFINE(IRQ_STACK_SIZE,	sizeof(struct irq_stack));
+  BLANK();
+#endif
   DEFINE(S_X0,			offsetof(struct pt_regs, regs[0]));
   DEFINE(S_X1,			offsetof(struct pt_regs, regs[1]));
   DEFINE(S_X2,			offsetof(struct pt_regs, regs[2]));
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index d23ca0d..f1fdfa9 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -88,7 +88,11 @@
 
 	.if	\el == 0
 	mrs	x21, sp_el0
+#ifndef CONFIG_IRQ_STACK
 	get_thread_info tsk			// Ensure MDSCR_EL1.SS is clear,
+#else
+	get_thread_info \el, tsk
+#endif
 	ldr	x19, [tsk, #TI_FLAGS]		// since we can unmask debug
 	disable_step_tsk x19, x20		// exceptions when scheduling.
 	.endif
@@ -168,11 +172,56 @@
 	eret					// return to kernel
 	.endm
 
+#ifndef CONFIG_IRQ_STACK
 	.macro	get_thread_info, rd
 	mov	\rd, sp
-	and	\rd, \rd, #~(THREAD_SIZE - 1)	// top of stack
+	and	\rd, \rd, #~(THREAD_SIZE - 1)	// bottom of stack
+	.endm
+#else
+	.macro	get_thread_info, el, rd
+	.if	\el == 0
+	mov	\rd, sp
+	.else
+	mrs	\rd, sp_el0
+	.endif
+	and	\rd, \rd, #~(THREAD_SIZE - 1)	// bottom of thread stack
+	.endm
+
+	.macro	get_irq_stack
+	get_thread_info 1, tsk
+	ldr	w22, [tsk, #TI_CPU]
+	adr_l	x21, irq_stacks
+	mov	x23, #IRQ_STACK_SIZE
+	madd	x21, x22, x23, x21
 	.endm
 
+	.macro	irq_stack_entry
+	get_irq_stack
+	ldr	w23, [x21, #IRQ_COUNT]
+	cbnz	w23, 1f
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
+	cbnz	w23, 1f
+	mov	x23, sp
+	str	x23, [x21, #IRQ_STACK]
+	ldr	x23, [x21, #IRQ_THREAD_SP]
+	mov	sp, x23
+	mov	x23, xzr
+1:	str	w23, [x21, #IRQ_COUNT]
+	.endm
+#endif
+
 /*
  * These are the registers used in the syscall handler, and allow us to
  * have in theory up to 7 arguments to a function - x0 to x6.
@@ -188,10 +237,15 @@ tsk	.req	x28		// current thread_info
  * Interrupt handling.
  */
 	.macro	irq_handler
-	adrp	x1, handle_arch_irq
-	ldr	x1, [x1, #:lo12:handle_arch_irq]
+	ldr_l	x1, handle_arch_irq
 	mov	x0, sp
+#ifdef CONFIG_IRQ_STACK
+	irq_stack_entry
+#endif
 	blr	x1
+#ifdef CONFIG_IRQ_STACK
+	irq_stack_exit
+#endif
 	.endm
 
 	.text
@@ -366,7 +420,11 @@ el1_irq:
 	irq_handler
 
 #ifdef CONFIG_PREEMPT
+#ifndef CONFIG_IRQ_STACK
 	get_thread_info tsk
+#else
+	get_thread_info 1, tsk
+#endif
 	ldr	w24, [tsk, #TI_PREEMPT]		// get preempt count
 	cbnz	w24, 1f				// preempt count != 0
 	ldr	x0, [tsk, #TI_FLAGS]		// get flags
@@ -395,6 +453,10 @@ el1_preempt:
 	.align	6
 el0_sync:
 	kernel_entry 0
+#ifdef CONFIG_IRQ_STACK
+	mov	x25, sp
+	msr	sp_el0, x25
+#endif
 	mrs	x25, esr_el1			// read the syndrome register
 	lsr	x24, x25, #ESR_ELx_EC_SHIFT	// exception class
 	cmp	x24, #ESR_ELx_EC_SVC64		// SVC in 64-bit state
@@ -423,6 +485,10 @@ el0_sync:
 	.align	6
 el0_sync_compat:
 	kernel_entry 0, 32
+#ifdef CONFIG_IRQ_STACK
+	mov	x25, sp
+	msr	sp_el0, x25
+#endif
 	mrs	x25, esr_el1			// read the syndrome register
 	lsr	x24, x25, #ESR_ELx_EC_SHIFT	// exception class
 	cmp	x24, #ESR_ELx_EC_SVC32		// SVC in 32-bit state
@@ -560,6 +626,10 @@ ENDPROC(el0_sync)
 el0_irq:
 	kernel_entry 0
 el0_irq_naked:
+#ifdef CONFIG_IRQ_STACK
+	mov	x22, sp
+	msr	sp_el0, x22
+#endif
 	enable_dbg
 #ifdef CONFIG_TRACE_IRQFLAGS
 	bl	trace_hardirqs_off
@@ -602,6 +672,9 @@ ENTRY(cpu_switch_to)
 	ldp	x29, x9, [x8], #16
 	ldr	lr, [x8]
 	mov	sp, x9
+#ifdef CONFIG_IRQ_STACK
+	msr	sp_el0, x9
+#endif
 	ret
 ENDPROC(cpu_switch_to)
 
@@ -661,7 +734,11 @@ ENTRY(ret_from_fork)
 	cbz	x19, 1f				// not a kernel thread
 	mov	x0, x20
 	blr	x19
+#ifndef CONFIG_IRQ_STACK
 1:	get_thread_info tsk
+#else
+1:	get_thread_info 1, tsk
+#endif
 	b	ret_to_user
 ENDPROC(ret_from_fork)
 
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index c0ff3ce..3142766 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -446,6 +446,10 @@ __mmap_switched:
 	b	1b
 2:
 	adr_l	sp, initial_sp, x4
+#ifdef CONFIG_IRQ_STACK
+	mov	x4, sp
+	msr	sp_el0, x4
+#endif
 	str_l	x21, __fdt_pointer, x5		// Save FDT pointer
 	str_l	x24, memstart_addr, x6		// Save PHYS_OFFSET
 	mov	x29, #0
@@ -619,6 +623,9 @@ ENDPROC(secondary_startup)
 ENTRY(__secondary_switched)
 	ldr	x0, [x21]			// get secondary_data.stack
 	mov	sp, x0
+#ifdef CONFIG_IRQ_STACK
+	msr	sp_el0, x0
+#endif
 	mov	x29, #0
 	b	secondary_start_kernel
 ENDPROC(__secondary_switched)
diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index 463fa2e..fb0f522 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -31,6 +31,10 @@
 
 unsigned long irq_err_count;
 
+#ifdef CONFIG_IRQ_STACK
+struct irq_stack irq_stacks[NR_CPUS];
+#endif
+
 int arch_show_interrupts(struct seq_file *p, int prec)
 {
 #ifdef CONFIG_SMP
@@ -52,6 +56,20 @@ void __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
 
 void __init init_IRQ(void)
 {
+#ifdef CONFIG_IRQ_STACK
+	unsigned int cpu;
+
+	for_each_possible_cpu(cpu) {
+		void *stack = (void *)__get_free_pages(THREADINFO_GFP,
+							THREAD_SIZE_ORDER);
+		if (!stack)
+			panic("CPU%u: No IRQ stack", cpu);
+
+		irq_stacks[cpu].stack = stack + THREAD_START_SP;
+	}
+	pr_info("IRQ: Allocated IRQ stack successfully\n");
+#endif
+
 	irqchip_init();
 	if (!handle_arch_irq)
 		panic("No interrupt controller found.");
-- 
1.9.1
