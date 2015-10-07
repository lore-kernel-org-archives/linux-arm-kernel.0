From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Wed,  7 Oct 2015 15:28:11 +0000
Subject: [PATCH v4 1/2] arm64: Introduce IRQ stack
In-Reply-To: <1444231692-32722-1-git-send-email-jungseoklee85@gmail.com>
References: <1444231692-32722-1-git-send-email-jungseoklee85@gmail.com>
Message-ID: <1444231692-32722-2-git-send-email-jungseoklee85@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, kernel context and interrupts are handled using a single
kernel stack navigated by sp_el1. This forces a system to use 16KB
stack, not 8KB one. This restriction makes low memory platforms suffer
from memory pressure accompanied by performance degradation.

This patch addresses the issue as introducing a separate percpu IRQ
stack to handle both hard and soft interrupts with two ground rules:

  - Utilize sp_el0 in EL1 context, which is not used currently
  - Do not complicate current_thread_info calculation

It is a core concept to directly retrieve struct thread_info from
sp_el0. This approach helps to prevent text section size from being
increased largely as removing masking operation using THREAD_SIZE
in tons of places.

[Thanks to James Morse for his valuable feedbacks which greatly help
to figure out a better implementation. - Jungseok]

Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
Tested-by: James Morse <james.morse@arm.com>
Signed-off-by: Jungseok Lee <jungseoklee85@gmail.com>
---
 arch/arm64/Kconfig                   |  1 +
 arch/arm64/include/asm/irq.h         |  6 +++
 arch/arm64/include/asm/thread_info.h | 10 +++-
 arch/arm64/kernel/asm-offsets.c      |  2 +
 arch/arm64/kernel/entry.S            | 41 ++++++++++++++--
 arch/arm64/kernel/head.S             |  5 ++
 arch/arm64/kernel/irq.c              | 21 ++++++++
 arch/arm64/kernel/sleep.S            |  3 ++
 arch/arm64/kernel/smp.c              | 13 ++++-
 9 files changed, 93 insertions(+), 9 deletions(-)

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
index bbb251b..6ea82e8 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -5,11 +5,17 @@
 
 #include <asm-generic/irq.h>
 
+struct irq_stack {
+	void *stack;
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
index 8d89cf8..b16e3cf 100644
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
index 4306c93..6d4e8c5 100644
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
@@ -108,6 +109,13 @@
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
@@ -164,8 +172,28 @@ alternative_endif
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
+	ldr	x24, [x19, #IRQ_STACK]
+	and	x20, x24, #~(THREAD_SIZE - 1)
+	mov	x23, sp
+	and	x23, x23, #~(THREAD_SIZE - 1)
+	cmp	x20, x23			// check irq re-enterance
+	mov	x19, sp
+	csel	x23, x19, x24, eq		// x24 = top of irq stack
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
@@ -183,10 +211,11 @@ tsk	.req	x28		// current thread_info
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
@@ -597,6 +626,8 @@ ENTRY(cpu_switch_to)
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
index 11dc3fd..a6bdf4d 100644
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
+		panic("Failed to allocate IRQ stack for a boot cpu");
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
index dbdaacd..2b8e33d 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -91,13 +91,22 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
 	int ret;
 
 	/*
-	 * We need to tell the secondary core where to find its stack and the
-	 * page tables.
+	 * We need to tell the secondary core where to find its process stack
+	 * and the page tables.
 	 */
 	secondary_data.stack = task_stack_page(idle) + THREAD_START_SP;
 	__flush_dcache_area(&secondary_data, sizeof(secondary_data));
 
 	/*
+	 * Allocate IRQ stack to handle both hard and soft interrupts.
+	 */
+	ret = alloc_irq_stack(cpu);
+	if (ret) {
+		pr_crit("CPU%u: failed to allocate IRQ stack\n", cpu);
+		return ret;
+	}
+
+	/*
 	 * Now bring the CPU into our world.
 	 */
 	ret = boot_secondary(cpu, idle);
-- 
2.5.0
