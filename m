From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Tue, 22 Sep 2015 12:11:58 +0000
Subject: [PATCH v3] arm64: Introduce IRQ stack
Message-ID: <1442923918-11289-1-git-send-email-jungseoklee85@gmail.com>
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

Tested-by: James Morse <james.morse@arm.com>
Signed-off-by: Jungseok Lee <jungseoklee85@gmail.com>
---
Changes since v2:
- Optmised current_thread_info function as removing masking operation
  and volatile keyword per James and Catalin
- Reworked irq re-enterance check logic using top-bit comparison of
  stacks per James
- Added sp_el0 update in cpu_resume per James
- Selected HAVE_IRQ_EXIT_ON_IRQ_STACK to expose this feature explicitly
- Added a Tested-by tag from James
- Added comments on sp_el0 as a helper messeage

Changes since v1:
- Rebased on top of v4.3-rc1
- Removed Kconfig about IRQ stack, per James
- Used PERCPU for IRQ stack, per James
- Tried to allocate IRQ stack when CPU is about to start up, per James
- Moved sp_el0 update into kernel_entry macro, per James
- Dropped S_SP removal patch, per Mark and James

 arch/arm64/Kconfig                   |  1 +
 arch/arm64/include/asm/irq.h         |  2 +
 arch/arm64/include/asm/thread_info.h | 10 ++++-
 arch/arm64/kernel/entry.S            | 35 +++++++++++++---
 arch/arm64/kernel/head.S             |  5 +++
 arch/arm64/kernel/irq.c              | 21 ++++++++++
 arch/arm64/kernel/sleep.S            |  3 ++
 arch/arm64/kernel/smp.c              |  6 +++
 8 files changed, 76 insertions(+), 7 deletions(-)

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
index bbb251b..ba12725 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -10,6 +10,8 @@ struct pt_regs;
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
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 4306c93..e5b8482 100644
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
@@ -105,6 +106,7 @@
 	.if	\el == 0
 	mvn	x21, xzr
 	str	x21, [sp, #S_SYSCALLNO]
+	msr	sp_el0, tsk
 	.endif
 
 	/*
@@ -164,8 +166,28 @@ alternative_endif
 	.endm
 
 	.macro	get_thread_info, rd
-	mov	\rd, sp
-	and	\rd, \rd, #~(THREAD_SIZE - 1)	// top of stack
+	mrs	\rd, sp_el0
+	.endm
+
+	.macro	irq_stack_entry
+	adr_l	x21, irq_stack
+	mrs	x22, tpidr_el1
+	add	x21, x21, x22
+	ldr	x22, [x21]
+	and	x21, x22, #~(THREAD_SIZE - 1)
+	mov	x23, sp
+	and	x23, x23, #~(THREAD_SIZE - 1)
+	cmp	x21, x23			// check irq re-enterance
+	mov	x21, sp
+	csel	x23, x21, x22, eq		// x22 = top of irq stack
+	mov	sp, x23
+	.endm
+
+	/*
+	 * x21 is preserved between irq_stack_entry and irq_stack_exit.
+	 */
+	.macro	irq_stack_exit
+	mov	sp, x21
 	.endm
 
 /*
@@ -183,10 +205,11 @@ tsk	.req	x28		// current thread_info
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
@@ -597,6 +620,8 @@ ENTRY(cpu_switch_to)
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
index 11dc3fd..5272bfd 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -31,6 +31,8 @@
 
 unsigned long irq_err_count;
 
+DEFINE_PER_CPU(void *, irq_stack);
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
+	if (per_cpu(irq_stack, cpu))
+		return 0;
+
+	stack = (void *)__get_free_pages(THREADINFO_GFP, THREAD_SIZE_ORDER);
+	if (!stack)
+		return -ENOMEM;
+
+	per_cpu(irq_stack, cpu) = stack + THREAD_START_SP;
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
-- 
2.5.0
