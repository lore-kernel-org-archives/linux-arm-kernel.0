From: will.deacon@arm.com (Will Deacon)
Date: Tue,  7 Jul 2015 19:26:15 +0100
Subject: [RFC PATCH] arm64: force CONFIG_SMP=y and remove redundant #ifdefs
Message-ID: <1436293575-5101-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nobody seems to be producing !SMP systems anymore, so this is just
becoming a source of kernel bugs, particularly if people want to use
coherent DMA with non-shared pages.

This patch forces CONFIG_SMP=y for arm64, removing a modest amount of
code in the process.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---

I'd appreciate any comments on this. Anybody got a good reason for
CONFIG_SMP=n on arm64?

 arch/arm64/Kconfig                 | 26 ++++----------------------
 arch/arm64/include/asm/assembler.h |  2 --
 arch/arm64/include/asm/barrier.h   | 24 ------------------------
 arch/arm64/include/asm/hardirq.h   |  4 ----
 arch/arm64/include/asm/irq_work.h  | 11 -----------
 arch/arm64/include/asm/percpu.h    |  8 --------
 arch/arm64/include/asm/pgtable.h   |  5 -----
 arch/arm64/include/asm/ptrace.h    |  4 ----
 arch/arm64/include/asm/smp.h       |  4 ----
 arch/arm64/include/asm/topology.h  |  9 ---------
 arch/arm64/kernel/Makefile         |  4 ++--
 arch/arm64/kernel/cpu_ops.c        |  2 --
 arch/arm64/kernel/head.S           |  7 -------
 arch/arm64/kernel/irq.c            |  2 --
 arch/arm64/kernel/psci.c           |  5 -----
 arch/arm64/kernel/setup.c          |  6 ------
 arch/arm64/kernel/sleep.S          |  5 -----
 arch/arm64/kernel/time.c           |  2 --
 arch/arm64/kernel/traps.c          |  4 ----
 arch/arm64/mm/context.c            | 16 ----------------
 arch/arm64/mm/flush.c              |  4 ----
 arch/arm64/mm/proc.S               |  4 ----
 22 files changed, 6 insertions(+), 152 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 0f6edb14b7e4..7b07354bb50c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -28,7 +28,7 @@ config ARM64
 	select DCACHE_WORD_ACCESS
 	select GENERIC_ALLOCATOR
 	select GENERIC_CLOCKEVENTS
-	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
+	select GENERIC_CLOCKEVENTS_BROADCAST
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_EARLY_IOREMAP
 	select GENERIC_IRQ_PROBE
@@ -137,6 +137,9 @@ config NEED_DMA_MAP_STATE
 config NEED_SG_DMA_LENGTH
 	def_bool y
 
+config SMP
+	def_bool y
+
 config SWIOTLB
 	def_bool y
 
@@ -474,22 +477,8 @@ config CPU_BIG_ENDIAN
        help
          Say Y if you plan on running a kernel in big-endian mode.
 
-config SMP
-	bool "Symmetric Multi-Processing"
-	help
-	  This enables support for systems with more than one CPU.  If
-	  you say N here, the kernel will run on single and
-	  multiprocessor machines, but will use only one CPU of a
-	  multiprocessor machine. If you say Y here, the kernel will run
-	  on many, but not all, single processor machines. On a single
-	  processor machine, the kernel will run faster if you say N
-	  here.
-
-	  If you don't know what to do here, say N.
-
 config SCHED_MC
 	bool "Multi-core scheduler support"
-	depends on SMP
 	help
 	  Multi-core scheduler support improves the CPU scheduler's decision
 	  making when dealing with multi-core CPU chips at a cost of slightly
@@ -497,7 +486,6 @@ config SCHED_MC
 
 config SCHED_SMT
 	bool "SMT scheduler support"
-	depends on SMP
 	help
 	  Improves the CPU scheduler's decision making when dealing with
 	  MultiThreading at a cost of slightly increased overhead in some
@@ -506,23 +494,17 @@ config SCHED_SMT
 config NR_CPUS
 	int "Maximum number of CPUs (2-4096)"
 	range 2 4096
-	depends on SMP
 	# These have to remain sorted largest to smallest
 	default "64"
 
 config HOTPLUG_CPU
 	bool "Support for hot-pluggable CPUs"
-	depends on SMP
 	help
 	  Say Y here to experiment with turning CPUs off and on.  CPUs
 	  can be controlled through /sys/devices/system/cpu.
 
 source kernel/Kconfig.preempt
 
-config UP_LATE_INIT
-       def_bool y
-       depends on !SMP
-
 config HZ
 	int
 	default 100
diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 144b64ad96c3..706ceaf2577a 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -103,9 +103,7 @@
  * SMP data memory barrier
  */
 	.macro	smp_dmb, opt
-#ifdef CONFIG_SMP
 	dmb	\opt
-#endif
 	.endm
 
 #define USER(l, x...)				\
diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 0fa47c4275cb..624f9679f4b0 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -35,28 +35,6 @@
 #define dma_rmb()	dmb(oshld)
 #define dma_wmb()	dmb(oshst)
 
-#ifndef CONFIG_SMP
-#define smp_mb()	barrier()
-#define smp_rmb()	barrier()
-#define smp_wmb()	barrier()
-
-#define smp_store_release(p, v)						\
-do {									\
-	compiletime_assert_atomic_type(*p);				\
-	barrier();							\
-	ACCESS_ONCE(*p) = (v);						\
-} while (0)
-
-#define smp_load_acquire(p)						\
-({									\
-	typeof(*p) ___p1 = ACCESS_ONCE(*p);				\
-	compiletime_assert_atomic_type(*p);				\
-	barrier();							\
-	___p1;								\
-})
-
-#else
-
 #define smp_mb()	dmb(ish)
 #define smp_rmb()	dmb(ishld)
 #define smp_wmb()	dmb(ishst)
@@ -109,8 +87,6 @@ do {									\
 	___p1;								\
 })
 
-#endif
-
 #define read_barrier_depends()		do { } while(0)
 #define smp_read_barrier_depends()	do { } while(0)
 
diff --git a/arch/arm64/include/asm/hardirq.h b/arch/arm64/include/asm/hardirq.h
index 6aae421f4d73..2bb7009bdac7 100644
--- a/arch/arm64/include/asm/hardirq.h
+++ b/arch/arm64/include/asm/hardirq.h
@@ -24,9 +24,7 @@
 
 typedef struct {
 	unsigned int __softirq_pending;
-#ifdef CONFIG_SMP
 	unsigned int ipi_irqs[NR_IPI];
-#endif
 } ____cacheline_aligned irq_cpustat_t;
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
@@ -34,10 +32,8 @@ typedef struct {
 #define __inc_irq_stat(cpu, member)	__IRQ_STAT(cpu, member)++
 #define __get_irq_stat(cpu, member)	__IRQ_STAT(cpu, member)
 
-#ifdef CONFIG_SMP
 u64 smp_irq_stat_cpu(unsigned int cpu);
 #define arch_irq_stat_cpu	smp_irq_stat_cpu
-#endif
 
 #define __ARCH_IRQ_EXIT_IRQS_DISABLED	1
 
diff --git a/arch/arm64/include/asm/irq_work.h b/arch/arm64/include/asm/irq_work.h
index b4f6b19a8a68..8e24ef3f7c82 100644
--- a/arch/arm64/include/asm/irq_work.h
+++ b/arch/arm64/include/asm/irq_work.h
@@ -1,8 +1,6 @@
 #ifndef __ASM_IRQ_WORK_H
 #define __ASM_IRQ_WORK_H
 
-#ifdef CONFIG_SMP
-
 #include <asm/smp.h>
 
 static inline bool arch_irq_work_has_interrupt(void)
@@ -10,13 +8,4 @@ static inline bool arch_irq_work_has_interrupt(void)
 	return !!__smp_cross_call;
 }
 
-#else
-
-static inline bool arch_irq_work_has_interrupt(void)
-{
-	return false;
-}
-
-#endif
-
 #endif /* __ASM_IRQ_WORK_H */
diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
index 4fde8c1df97f..0a456bef8c79 100644
--- a/arch/arm64/include/asm/percpu.h
+++ b/arch/arm64/include/asm/percpu.h
@@ -16,8 +16,6 @@
 #ifndef __ASM_PERCPU_H
 #define __ASM_PERCPU_H
 
-#ifdef CONFIG_SMP
-
 static inline void set_my_cpu_offset(unsigned long off)
 {
 	asm volatile("msr tpidr_el1, %0" :: "r" (off) : "memory");
@@ -38,12 +36,6 @@ static inline unsigned long __my_cpu_offset(void)
 }
 #define __my_cpu_offset __my_cpu_offset()
 
-#else	/* !CONFIG_SMP */
-
-#define set_my_cpu_offset(x)	do { } while (0)
-
-#endif /* CONFIG_SMP */
-
 #define PERCPU_OP(op, asm_op)						\
 static inline unsigned long __percpu_##op(void *ptr,			\
 			unsigned long val, int size)			\
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 17aa3d625499..1c2cb73de1d2 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -54,13 +54,8 @@ extern void __pmd_error(const char *file, int line, unsigned long val);
 extern void __pud_error(const char *file, int line, unsigned long val);
 extern void __pgd_error(const char *file, int line, unsigned long val);
 
-#ifdef CONFIG_SMP
 #define PROT_DEFAULT		(PTE_TYPE_PAGE | PTE_AF | PTE_SHARED)
 #define PROT_SECT_DEFAULT	(PMD_TYPE_SECT | PMD_SECT_AF | PMD_SECT_S)
-#else
-#define PROT_DEFAULT		(PTE_TYPE_PAGE | PTE_AF)
-#define PROT_SECT_DEFAULT	(PMD_TYPE_SECT | PMD_SECT_AF)
-#endif
 
 #define PROT_DEVICE_nGnRE	(PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_ATTRINDX(MT_DEVICE_nGnRE))
 #define PROT_NORMAL_NC		(PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_ATTRINDX(MT_NORMAL_NC))
diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index d6dd9fdbc3be..536274ed292e 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -183,11 +183,7 @@ static inline int valid_user_regs(struct user_pt_regs *regs)
 
 #define instruction_pointer(regs)	((unsigned long)(regs)->pc)
 
-#ifdef CONFIG_SMP
 extern unsigned long profile_pc(struct pt_regs *regs);
-#else
-#define profile_pc(regs) instruction_pointer(regs)
-#endif
 
 #endif /* __ASSEMBLY__ */
 #endif
diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index db02be81b90a..d9c3d6a6100a 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -20,10 +20,6 @@
 #include <linux/cpumask.h>
 #include <linux/thread_info.h>
 
-#ifndef CONFIG_SMP
-# error "<asm/smp.h> included in non-SMP build"
-#endif
-
 #define raw_smp_processor_id() (current_thread_info()->cpu)
 
 struct seq_file;
diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
index 225ec3524fbf..a3e9d6fdbf21 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -1,8 +1,6 @@
 #ifndef __ASM_TOPOLOGY_H
 #define __ASM_TOPOLOGY_H
 
-#ifdef CONFIG_SMP
-
 #include <linux/cpumask.h>
 
 struct cpu_topology {
@@ -24,13 +22,6 @@ void init_cpu_topology(void);
 void store_cpu_topology(unsigned int cpuid);
 const struct cpumask *cpu_coregroup_mask(int cpu);
 
-#else
-
-static inline void init_cpu_topology(void) { }
-static inline void store_cpu_topology(unsigned int cpuid) { }
-
-#endif
-
 #include <asm-generic/topology.h>
 
 #endif /* _ASM_ARM_TOPOLOGY_H */
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 426d0763c81b..c6fef2f36163 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -17,14 +17,14 @@ arm64-obj-y		:= debug-monitors.o entry.o irq.o fpsimd.o		\
 			   sys.o stacktrace.o time.o traps.o io.o vdso.o	\
 			   hyp-stub.o psci.o psci-call.o cpu_ops.o insn.o	\
 			   return_address.o cpuinfo.o cpu_errata.o		\
-			   cpufeature.o alternative.o cacheinfo.o
+			   cpufeature.o alternative.o cacheinfo.o		\
+			   smp.o smp_spin_table.o topology.o
 
 arm64-obj-$(CONFIG_COMPAT)		+= sys32.o kuser32.o signal32.o 	\
 					   sys_compat.o entry32.o		\
 					   ../../arm/kernel/opcodes.o
 arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
 arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
-arm64-obj-$(CONFIG_SMP)			+= smp.o smp_spin_table.o topology.o
 arm64-obj-$(CONFIG_PERF_EVENTS)		+= perf_regs.o
 arm64-obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o
 arm64-obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
diff --git a/arch/arm64/kernel/cpu_ops.c b/arch/arm64/kernel/cpu_ops.c
index 5ea337dd2f15..b6bd7d447768 100644
--- a/arch/arm64/kernel/cpu_ops.c
+++ b/arch/arm64/kernel/cpu_ops.c
@@ -30,9 +30,7 @@ extern const struct cpu_operations cpu_psci_ops;
 const struct cpu_operations *cpu_ops[NR_CPUS];
 
 static const struct cpu_operations *supported_cpu_ops[] __initconst = {
-#ifdef CONFIG_SMP
 	&smp_spin_table_ops,
-#endif
 	&cpu_psci_ops,
 	NULL,
 };
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index c0ff3ce4299e..3a0654173997 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -62,13 +62,8 @@
 /*
  * Initial memory map attributes.
  */
-#ifndef CONFIG_SMP
-#define PTE_FLAGS	PTE_TYPE_PAGE | PTE_AF
-#define PMD_FLAGS	PMD_TYPE_SECT | PMD_SECT_AF
-#else
 #define PTE_FLAGS	PTE_TYPE_PAGE | PTE_AF | PTE_SHARED
 #define PMD_FLAGS	PMD_TYPE_SECT | PMD_SECT_AF | PMD_SECT_S
-#endif
 
 #ifdef CONFIG_ARM64_64K_PAGES
 #define MM_MMUFLAGS	PTE_ATTRINDX(MT_NORMAL) | PTE_FLAGS
@@ -574,7 +569,6 @@ ENTRY(__boot_cpu_mode)
 	.long	BOOT_CPU_MODE_EL1
 	.popsection
 
-#ifdef CONFIG_SMP
 	/*
 	 * This provides a "holding pen" for platforms to hold all secondary
 	 * cores are held until we're ready for them to initialise.
@@ -622,7 +616,6 @@ ENTRY(__secondary_switched)
 	mov	x29, #0
 	b	secondary_start_kernel
 ENDPROC(__secondary_switched)
-#endif	/* CONFIG_SMP */
 
 /*
  * Enable the MMU.
diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index 240b75c0e94f..de99d4bd31bb 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -33,9 +33,7 @@ unsigned long irq_err_count;
 
 int arch_show_interrupts(struct seq_file *p, int prec)
 {
-#ifdef CONFIG_SMP
 	show_ipi_list(p, prec);
-#endif
 	seq_printf(p, "%*s: %10lu\n", prec, "Err", irq_err_count);
 	return 0;
 }
diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index 869f202748e8..ec30152090ae 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -462,8 +462,6 @@ int __init psci_acpi_init(void)
 }
 #endif
 
-#ifdef CONFIG_SMP
-
 static int __init cpu_psci_cpu_init(unsigned int cpu)
 {
 	return 0;
@@ -550,7 +548,6 @@ static int cpu_psci_cpu_kill(unsigned int cpu)
 	return -ETIMEDOUT;
 }
 #endif
-#endif
 
 static int psci_suspend_finisher(unsigned long index)
 {
@@ -585,7 +582,6 @@ const struct cpu_operations cpu_psci_ops = {
 	.cpu_init_idle	= cpu_psci_cpu_init_idle,
 	.cpu_suspend	= cpu_psci_cpu_suspend,
 #endif
-#ifdef CONFIG_SMP
 	.cpu_init	= cpu_psci_cpu_init,
 	.cpu_prepare	= cpu_psci_cpu_prepare,
 	.cpu_boot	= cpu_psci_cpu_boot,
@@ -594,6 +590,5 @@ const struct cpu_operations cpu_psci_ops = {
 	.cpu_die	= cpu_psci_cpu_die,
 	.cpu_kill	= cpu_psci_cpu_kill,
 #endif
-#endif
 };
 
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index f3067d4d4e35..cf609cf3fcb5 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -131,7 +131,6 @@ bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
 }
 
 struct mpidr_hash mpidr_hash;
-#ifdef CONFIG_SMP
 /**
  * smp_build_mpidr_hash - Pre-compute shifts required at each affinity
  *			  level in order to build a linear index from an
@@ -197,7 +196,6 @@ static void __init smp_build_mpidr_hash(void)
 		pr_warn("Large number of MPIDR hash buckets detected\n");
 	__flush_dcache_area(&mpidr_hash, sizeof(struct mpidr_hash));
 }
-#endif
 
 static void __init hyp_mode_check(void)
 {
@@ -405,10 +403,8 @@ void __init setup_arch(char **cmdline_p)
 	xen_early_init();
 
 	cpu_read_bootcpu_ops();
-#ifdef CONFIG_SMP
 	smp_init_cpus();
 	smp_build_mpidr_hash();
-#endif
 
 #ifdef CONFIG_VT
 #if defined(CONFIG_VGA_CONSOLE)
@@ -508,9 +504,7 @@ static int c_show(struct seq_file *m, void *v)
 		 * online processors, looking for lines beginning with
 		 * "processor".  Give glibc what it expects.
 		 */
-#ifdef CONFIG_SMP
 		seq_printf(m, "processor\t: %d\n", i);
-#endif
 
 		/*
 		 * Dump out the common processor features in a single line.
diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
index 803cfea41962..5686a3ae3940 100644
--- a/arch/arm64/kernel/sleep.S
+++ b/arch/arm64/kernel/sleep.S
@@ -82,7 +82,6 @@ ENTRY(__cpu_suspend_enter)
 	str	x2, [x0, #CPU_CTX_SP]
 	ldr	x1, =sleep_save_sp
 	ldr	x1, [x1, #SLEEP_SAVE_SP_VIRT]
-#ifdef CONFIG_SMP
 	mrs	x7, mpidr_el1
 	ldr	x9, =mpidr_hash
 	ldr	x10, [x9, #MPIDR_HASH_MASK]
@@ -94,7 +93,6 @@ ENTRY(__cpu_suspend_enter)
 	ldp	w5, w6, [x9, #(MPIDR_HASH_SHIFTS + 8)]
 	compute_mpidr_hash x8, x3, x4, x5, x6, x7, x10
 	add	x1, x1, x8, lsl #3
-#endif
 	bl	__cpu_suspend_save
 	/*
 	 * Grab suspend finisher in x20 and its argument in x19
@@ -151,7 +149,6 @@ ENDPROC(cpu_resume_after_mmu)
 
 ENTRY(cpu_resume)
 	bl	el2_setup		// if in EL2 drop to EL1 cleanly
-#ifdef CONFIG_SMP
 	mrs	x1, mpidr_el1
 	adrp	x8, mpidr_hash
 	add x8, x8, #:lo12:mpidr_hash // x8 = struct mpidr_hash phys address
@@ -161,9 +158,7 @@ ENTRY(cpu_resume)
 	ldp	w5, w6, [x8, #(MPIDR_HASH_SHIFTS + 8)]
 	compute_mpidr_hash x7, x3, x4, x5, x6, x1, x2
         /* x7 contains hash index, let's use it to grab context pointer */
-#else
 	mov	x7, xzr
-#endif
 	ldr_l	x0, sleep_save_sp + SLEEP_SAVE_SP_PHYS
 	ldr	x0, [x0, x7, lsl #3]
 	/* load sp from context */
diff --git a/arch/arm64/kernel/time.c b/arch/arm64/kernel/time.c
index 42f9195cf2f8..149151fb42bb 100644
--- a/arch/arm64/kernel/time.c
+++ b/arch/arm64/kernel/time.c
@@ -42,7 +42,6 @@
 #include <asm/thread_info.h>
 #include <asm/stacktrace.h>
 
-#ifdef CONFIG_SMP
 unsigned long profile_pc(struct pt_regs *regs)
 {
 	struct stackframe frame;
@@ -62,7 +61,6 @@ unsigned long profile_pc(struct pt_regs *regs)
 	return frame.pc;
 }
 EXPORT_SYMBOL(profile_pc);
-#endif
 
 void __init time_init(void)
 {
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 566bc4c35040..443e68e6923b 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -179,11 +179,7 @@ void show_stack(struct task_struct *tsk, unsigned long *sp)
 #else
 #define S_PREEMPT ""
 #endif
-#ifdef CONFIG_SMP
 #define S_SMP " SMP"
-#else
-#define S_SMP ""
-#endif
 
 static int __die(const char *str, int err, struct thread_info *thread,
 		 struct pt_regs *regs)
diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index 76c1e6cd36fc..d70ff14dbdbd 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -53,8 +53,6 @@ static void flush_context(void)
 		__flush_icache_all();
 }
 
-#ifdef CONFIG_SMP
-
 static void set_mm_context(struct mm_struct *mm, unsigned int asid)
 {
 	unsigned long flags;
@@ -110,23 +108,12 @@ static void reset_context(void *info)
 	cpu_switch_mm(mm->pgd, mm);
 }
 
-#else
-
-static inline void set_mm_context(struct mm_struct *mm, unsigned int asid)
-{
-	mm->context.id = asid;
-	cpumask_copy(mm_cpumask(mm), cpumask_of(smp_processor_id()));
-}
-
-#endif
-
 void __new_context(struct mm_struct *mm)
 {
 	unsigned int asid;
 	unsigned int bits = asid_bits();
 
 	raw_spin_lock(&cpu_asid_lock);
-#ifdef CONFIG_SMP
 	/*
 	 * Check the ASID again, in case the change was broadcast from another
 	 * CPU before we acquired the lock.
@@ -136,7 +123,6 @@ void __new_context(struct mm_struct *mm)
 		raw_spin_unlock(&cpu_asid_lock);
 		return;
 	}
-#endif
 	/*
 	 * At this point, it is guaranteed that the current mm (with an old
 	 * ASID) isn't active on any other CPU since the ASIDs are changed
@@ -155,10 +141,8 @@ void __new_context(struct mm_struct *mm)
 			cpu_last_asid = ASID_FIRST_VERSION;
 		asid = cpu_last_asid + smp_processor_id();
 		flush_context();
-#ifdef CONFIG_SMP
 		smp_wmb();
 		smp_call_function(reset_context, NULL, 1);
-#endif
 		cpu_last_asid += NR_CPUS - 1;
 	}
 
diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
index 4dfa3975ce5b..c26b804015e8 100644
--- a/arch/arm64/mm/flush.c
+++ b/arch/arm64/mm/flush.c
@@ -60,14 +60,10 @@ void copy_to_user_page(struct vm_area_struct *vma, struct page *page,
 		       unsigned long uaddr, void *dst, const void *src,
 		       unsigned long len)
 {
-#ifdef CONFIG_SMP
 	preempt_disable();
-#endif
 	memcpy(dst, src, len);
 	flush_ptrace_access(vma, page, uaddr, dst, len);
-#ifdef CONFIG_SMP
 	preempt_enable();
-#endif
 }
 
 void __sync_icache_dcache(pte_t pte, unsigned long addr)
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 39139a3aa16d..eff4f627358a 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -34,11 +34,7 @@
 #define TCR_TG_FLAGS	TCR_TG0_4K | TCR_TG1_4K
 #endif
 
-#ifdef CONFIG_SMP
 #define TCR_SMP_FLAGS	TCR_SHARED
-#else
-#define TCR_SMP_FLAGS	0
-#endif
 
 /* PTWs cacheable, inner/outer WBWA */
 #define TCR_CACHE_FLAGS	TCR_IRGN_WBWA | TCR_ORGN_WBWA
-- 
2.1.4
