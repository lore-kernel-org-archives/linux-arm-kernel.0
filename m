From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 16 Feb 2012 21:18:09 +0100
Subject: [PATCH 4/5] ARM: Cortex-M3: Add base support for Cortex-M3
In-Reply-To: <1329423490-15580-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20120216200143.GS14173@pengutronix.de>
 <1329423490-15580-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1329423490-15580-4-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Catalin Marinas <catalin.marinas@arm.com>

This patch adds the base support for the Cortex-M3 processor (ARMv7-M
architecture). It consists of the corresponding arch/arm/mm/ files and
various #ifdef's around the kernel. Exception handling is implemented by
a subsequent patch.

[ukleinek: squash in some changes originating from commit

b5717ba (Cortex-M3: Add support for the Microcontroller Prototyping System)

from the v2.6.33-arm1 patch stack, port to post 3.2, drop zImage
support, and a few cosmetic changes]

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/include/asm/assembler.h  |   13 +++-
 arch/arm/include/asm/cputype.h    |    3 +
 arch/arm/include/asm/glue-cache.h |   24 +++++
 arch/arm/include/asm/glue-df.h    |    8 ++
 arch/arm/include/asm/glue-proc.h  |    9 ++
 arch/arm/include/asm/irqflags.h   |   51 ++++++++++-
 arch/arm/include/asm/processor.h  |    8 ++
 arch/arm/include/asm/ptrace.h     |   43 +++++++++-
 arch/arm/include/asm/system.h     |    3 +
 arch/arm/kernel/asm-offsets.c     |    3 +
 arch/arm/kernel/head-common.S     |    2 +-
 arch/arm/kernel/head-nommu.S      |    9 ++-
 arch/arm/kernel/setup.c           |   13 +++-
 arch/arm/kernel/traps.c           |    2 +
 arch/arm/mm/nommu.c               |    2 +
 arch/arm/mm/proc-v7m.S            |  178 +++++++++++++++++++++++++++++++++++++
 16 files changed, 362 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm/mm/proc-v7m.S

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 62f8095..1bafa39 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -133,7 +133,11 @@
  * assumes FIQs are enabled, and that the processor is in SVC mode.
  */
 	.macro	save_and_disable_irqs, oldcpsr
+#ifdef CONFIG_CPU_V7M
+	mrs	\oldcpsr, primask
+#else
 	mrs	\oldcpsr, cpsr
+#endif
 	disable_irq
 	.endm
 
@@ -142,7 +146,11 @@
  * guarantee that this will preserve the flags.
  */
 	.macro	restore_irqs_notrace, oldcpsr
+#ifdef CONFIG_CPU_V7M
+	msr	primask, \oldcpsr
+#else
 	msr	cpsr_c, \oldcpsr
+#endif
 	.endm
 
 	.macro restore_irqs, oldcpsr
@@ -221,7 +229,10 @@
 #endif
 	.endm
 
-#ifdef CONFIG_THUMB2_KERNEL
+#if defined(CONFIG_CPU_V7M)
+	.macro	setmode, mode, reg
+	.endm
+#elif defined(CONFIG_THUMB2_KERNEL)
 	.macro	setmode, mode, reg
 	mov	\reg, #\mode
 	msr	cpsr_c, \reg
diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index cb47d28..5bd8cb6 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -46,6 +46,9 @@ extern unsigned int processor_id;
 		    : "cc");						\
 		__val;							\
 	})
+#elif defined(CONFIG_CPU_V7M)
+#define read_cpuid(reg) (*(unsigned int *)0xe000ed00)
+#define read_cpuid_ext(reg) 0
 #else
 #define read_cpuid(reg) (processor_id)
 #define read_cpuid_ext(reg) 0
diff --git a/arch/arm/include/asm/glue-cache.h b/arch/arm/include/asm/glue-cache.h
index 7e30874..6a5fd0b 100644
--- a/arch/arm/include/asm/glue-cache.h
+++ b/arch/arm/include/asm/glue-cache.h
@@ -125,10 +125,34 @@
 //# endif
 #endif
 
+#if defined(CONFIG_CPU_V7M)
+# ifdef _CACHE
+#  error "Multi-cache not supported on ARMv7-M"
+# else
+#  define _CACHE nop
+# endif
+#endif
+
 #if !defined(_CACHE) && !defined(MULTI_CACHE)
 #error Unknown cache maintenance model
 #endif
 
+#ifndef __ASSEMBLER__
+static inline void nop_flush_icache_all(void) { }
+static inline void nop_flush_kern_cache_all(void) { }
+static inline void nop_flush_user_cache_all(void) { }
+static inline void nop_flush_user_cache_range(unsigned long a, unsigned long b, unsigned int c) { }
+
+static inline void nop_coherent_kern_range(unsigned long a, unsigned long b) { }
+static inline void nop_coherent_user_range(unsigned long a, unsigned long b) { }
+static inline void nop_flush_kern_dcache_area(void *a, size_t s) { }
+
+static inline void nop_dma_flush_range(const void *a, const void *b) { }
+
+static inline void nop_dma_map_area(const void *s, size_t l, int f) { }
+static inline void nop_dma_unmap_area(const void *s, size_t l, int f) { }
+#endif
+
 #ifndef MULTI_CACHE
 #define __cpuc_flush_icache_all		__glue(_CACHE,_flush_icache_all)
 #define __cpuc_flush_kern_all		__glue(_CACHE,_flush_kern_cache_all)
diff --git a/arch/arm/include/asm/glue-df.h b/arch/arm/include/asm/glue-df.h
index 354d571..26be71c 100644
--- a/arch/arm/include/asm/glue-df.h
+++ b/arch/arm/include/asm/glue-df.h
@@ -103,6 +103,14 @@
 # endif
 #endif
 
+#ifdef CONFIG_CPU_ABRT_NOMMU
+# ifdef CPU_DABORT_HANDLER
+#  define MULTI_DABORT 1
+# else
+#  define CPU_DABORT_HANDLER nommu_early_abort
+# endif
+#endif
+
 #ifndef CPU_DABORT_HANDLER
 #error Unknown data abort handler type
 #endif
diff --git a/arch/arm/include/asm/glue-proc.h b/arch/arm/include/asm/glue-proc.h
index e2be7f1..8f9991b 100644
--- a/arch/arm/include/asm/glue-proc.h
+++ b/arch/arm/include/asm/glue-proc.h
@@ -248,6 +248,15 @@
 # endif
 #endif
 
+#ifdef CONFIG_CPU_V7M
+# ifdef CPU_NAME
+#  undef  MULTI_CPU
+#  define MULTI_CPU
+# else
+#  define CPU_NAME cpu_v7m
+# endif
+#endif
+
 #ifndef MULTI_CPU
 #define cpu_proc_init			__glue(CPU_NAME,_proc_init)
 #define cpu_proc_fin			__glue(CPU_NAME,_proc_fin)
diff --git a/arch/arm/include/asm/irqflags.h b/arch/arm/include/asm/irqflags.h
index 1e6cca5..ac4d548 100644
--- a/arch/arm/include/asm/irqflags.h
+++ b/arch/arm/include/asm/irqflags.h
@@ -10,6 +10,18 @@
  */
 #if __LINUX_ARM_ARCH__ >= 6
 
+#ifdef CONFIG_CPU_V7M
+static inline unsigned long arch_local_irq_save(void)
+{
+	unsigned long flags;
+
+	asm volatile(
+		"	mrs	%0, primask	@ arch_local_irq_save\n"
+		"	cpsid	i"
+		: "=r" (flags) : : "memory", "cc");
+	return flags;
+}
+#else
 static inline unsigned long arch_local_irq_save(void)
 {
 	unsigned long flags;
@@ -20,6 +32,7 @@ static inline unsigned long arch_local_irq_save(void)
 		: "=r" (flags) : : "memory", "cc");
 	return flags;
 }
+#endif
 
 static inline void arch_local_irq_enable(void)
 {
@@ -122,6 +135,38 @@ static inline void arch_local_irq_disable(void)
 
 #endif
 
+#ifdef CONFIG_CPU_V7M
+/*
+ * Save the current interrupt enable state.
+ */
+static inline unsigned long arch_local_save_flags(void)
+{
+	unsigned long flags;
+	asm volatile(
+		"	mrs	%0, primask	@ local_save_flags"
+		: "=r" (flags) : : "memory", "cc");
+	return flags;
+}
+
+/*
+ * restore saved IRQ & FIQ state
+ */
+static inline void arch_local_irq_restore(unsigned long flags)
+{
+	asm volatile(
+		"	msr	primask, %0	@ local_irq_restore"
+		:
+		: "r" (flags)
+		: "memory", "cc");
+}
+
+static inline int arch_irqs_disabled_flags(unsigned long flags)
+{
+	return flags & 1;
+}
+
+#else /* ifdef CONFIG_CPU_V7M */
+
 /*
  * Save the current interrupt enable state.
  */
@@ -151,5 +196,7 @@ static inline int arch_irqs_disabled_flags(unsigned long flags)
 	return flags & PSR_I_BIT;
 }
 
-#endif
-#endif
+#endif /* ifdef CONFIG_CPU_V7M / else */
+
+#endif /* ifdef __KERNEL__ */
+#endif /* ifndef __ASM_ARM_IRQFLAGS_H */
diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
index ce280b8..aa4c8a2 100644
--- a/arch/arm/include/asm/processor.h
+++ b/arch/arm/include/asm/processor.h
@@ -49,7 +49,15 @@ struct thread_struct {
 #ifdef CONFIG_MMU
 #define nommu_start_thread(regs) do { } while (0)
 #else
+#ifndef CONFIG_CPU_V7M
 #define nommu_start_thread(regs) regs->ARM_r10 = current->mm->start_data
+#else
+#define nommu_start_thread(regs) do {					\
+	regs->ARM_r10 = current->mm->start_data;			\
+	regs->ARM_sp -= 32;		/* exception return state */	\
+	regs->ARM_EXC_lr = 0xfffffffdL;	/* exception lr */		\
+} while (0)
+#endif
 #endif
 
 #define start_thread(regs,pc,sp)					\
diff --git a/arch/arm/include/asm/ptrace.h b/arch/arm/include/asm/ptrace.h
index 451808b..1feb9a0 100644
--- a/arch/arm/include/asm/ptrace.h
+++ b/arch/arm/include/asm/ptrace.h
@@ -39,16 +39,25 @@
 #define FIQ26_MODE	0x00000001
 #define IRQ26_MODE	0x00000002
 #define SVC26_MODE	0x00000003
+#ifndef CONFIG_CPU_V7M
 #define USR_MODE	0x00000010
+#define SVC_MODE	0x00000013
+#else
+#define USR_MODE	0x00000000
+#define SVC_MODE	0x00000000
+#endif
 #define FIQ_MODE	0x00000011
 #define IRQ_MODE	0x00000012
-#define SVC_MODE	0x00000013
 #define ABT_MODE	0x00000017
 #define UND_MODE	0x0000001b
 #define SYSTEM_MODE	0x0000001f
 #define MODE32_BIT	0x00000010
 #define MODE_MASK	0x0000001f
+#ifndef CONFIG_CPU_V7M
 #define PSR_T_BIT	0x00000020
+#else
+#define PSR_T_BIT	0x01000000
+#endif
 #define PSR_F_BIT	0x00000040
 #define PSR_I_BIT	0x00000080
 #define PSR_A_BIT	0x00000100
@@ -106,10 +115,37 @@ struct pt_regs {
 };
 #else /* __KERNEL__ */
 struct pt_regs {
+#ifdef CONFIG_CPU_V7M
+	unsigned long uregs[20];
+#else
 	unsigned long uregs[18];
+#endif
 };
 #endif /* __KERNEL__ */
 
+#ifdef CONFIG_CPU_V7M
+/* Automatically saved registers */
+#define ARM_cpsr	uregs[17]
+#define ARM_pc		uregs[16]
+#define ARM_lr		uregs[15]
+#define ARM_ip		uregs[14]
+#define ARM_r3		uregs[13]
+#define ARM_r2		uregs[12]
+#define ARM_r1		uregs[11]
+#define ARM_r0		uregs[10]
+/* saved by the exception entry code */
+#define ARM_EXC_lr	uregs[9]
+#define ARM_sp		uregs[8]
+#define ARM_fp		uregs[7]
+#define ARM_r10		uregs[6]
+#define ARM_r9		uregs[5]
+#define ARM_r8		uregs[4]
+#define ARM_r7		uregs[3]
+#define ARM_r6		uregs[2]
+#define ARM_r5		uregs[1]
+#define ARM_r4		uregs[0]
+#define ARM_ORIG_r0	uregs[18]
+#else
 #define ARM_cpsr	uregs[16]
 #define ARM_pc		uregs[15]
 #define ARM_lr		uregs[14]
@@ -128,6 +164,7 @@ struct pt_regs {
 #define ARM_r1		uregs[1]
 #define ARM_r0		uregs[0]
 #define ARM_ORIG_r0	uregs[17]
+#endif
 
 /*
  * The size of the user-visible VFP state as seen by PTRACE_GET/SETVFPREGS
@@ -165,6 +202,7 @@ struct pt_regs {
  */
 static inline int valid_user_regs(struct pt_regs *regs)
 {
+#ifndef CONFIG_CPU_V7M
 	unsigned long mode = regs->ARM_cpsr & MODE_MASK;
 
 	/*
@@ -187,6 +225,9 @@ static inline int valid_user_regs(struct pt_regs *regs)
 		regs->ARM_cpsr |= USR_MODE;
 
 	return 0;
+#else /* ifndef CONFIG_CPU_V7M */
+	return 1;
+#endif
 }
 
 static inline long regs_return_value(struct pt_regs *regs)
diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index de46477..16117ed 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -13,6 +13,7 @@
 #define CPU_ARCH_ARMv5TEJ	7
 #define CPU_ARCH_ARMv6		8
 #define CPU_ARCH_ARMv7		9
+#define CPU_ARCH_ARMv7M		10
 
 /*
  * CR1 bits (CP#15 CR1)
@@ -232,7 +233,9 @@ static inline void set_copro_access(unsigned int val)
  * so enable interrupts over the context switch to avoid high
  * latency.
  */
+#ifndef CONFIG_CPU_V7M
 #define __ARCH_WANT_INTERRUPTS_ON_CTXSW
+#endif
 
 /*
  * switch_to(prev, next) should switch from task `prev' to `next'
diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index 1429d89..e861849 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -91,6 +91,9 @@ int main(void)
   DEFINE(S_PC,			offsetof(struct pt_regs, ARM_pc));
   DEFINE(S_PSR,			offsetof(struct pt_regs, ARM_cpsr));
   DEFINE(S_OLD_R0,		offsetof(struct pt_regs, ARM_ORIG_r0));
+#ifdef CONFIG_CPU_V7M
+  DEFINE(S_EXC_LR,		offsetof(struct pt_regs, ARM_EXC_lr));
+#endif
   DEFINE(S_FRAME_SIZE,		sizeof(struct pt_regs));
   BLANK();
 #ifdef CONFIG_CACHE_L2X0
diff --git a/arch/arm/kernel/head-common.S b/arch/arm/kernel/head-common.S
index 5ca01bb..efeb2d0 100644
--- a/arch/arm/kernel/head-common.S
+++ b/arch/arm/kernel/head-common.S
@@ -118,7 +118,7 @@ __mmap_switched_data:
 #ifdef CONFIG_CPU_CP15
 	.long	cr_alignment			@ r7
 #else
-	.long	0
+	.long	0				@ r7
 #endif
 	.long	init_thread_union + THREAD_START_SP @ sp
 	.size	__mmap_switched_data, . - __mmap_switched_data
diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
index 1aca35d..61ba029 100644
--- a/arch/arm/kernel/head-nommu.S
+++ b/arch/arm/kernel/head-nommu.S
@@ -44,10 +44,13 @@ ENTRY(stext)
 
 	setmode	PSR_F_BIT | PSR_I_BIT | SVC_MODE, r9 @ ensure svc mode
 						@ and irqs disabled
-#ifndef CONFIG_CPU_CP15
-	ldr	r9, =CONFIG_PROCESSOR_ID
-#else
+#if defined(CONFIG_CPU_CP15)
 	mrc	p15, 0, r9, c0, c0		@ get processor id
+#elif defined(CONFIG_CPU_V7M)
+	ldr	r9, =0xe000ed00			@ CPUID register address
+	ldr	r9, [r9]
+#else
+	ldr	r9, =CONFIG_PROCESSOR_ID
 #endif
 	bl	__lookup_processor_type		@ r5=procinfo r9=cpuid
 	movs	r10, r5				@ invalid processor (r5=0)?
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 23893b1..d0fc5b8 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -132,7 +132,9 @@ struct stack {
 	u32 und[3];
 } ____cacheline_aligned;
 
+#ifndef CONFIG_CPU_V7M
 static struct stack stacks[NR_CPUS];
+#endif
 
 char elf_platform[ELF_PLATFORM_SIZE];
 EXPORT_SYMBOL(elf_platform);
@@ -212,7 +214,7 @@ static const char *proc_arch[] = {
 	"5TEJ",
 	"6TEJ",
 	"7",
-	"?(11)",
+	"7M",
 	"?(12)",
 	"?(13)",
 	"?(14)",
@@ -221,6 +223,12 @@ static const char *proc_arch[] = {
 	"?(17)",
 };
 
+#ifdef CONFIG_CPU_V7M
+static int __get_cpu_architecture(void)
+{
+	return CPU_ARCH_ARMv7M;
+}
+#else
 static int __get_cpu_architecture(void)
 {
 	int cpu_arch;
@@ -253,6 +261,7 @@ static int __get_cpu_architecture(void)
 
 	return cpu_arch;
 }
+#endif
 
 int __pure cpu_architecture(void)
 {
@@ -380,6 +389,7 @@ static void __init feat_v6_fixup(void)
  */
 void cpu_init(void)
 {
+#ifndef CONFIG_CPU_V7M
 	unsigned int cpu = smp_processor_id();
 	struct stack *stk = &stacks[cpu];
 
@@ -424,6 +434,7 @@ void cpu_init(void)
 	      "I" (offsetof(struct stack, und[0])),
 	      PLC (PSR_F_BIT | PSR_I_BIT | SVC_MODE)
 	    : "r14");
+#endif
 }
 
 int __cpu_logical_map[NR_CPUS];
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 99a5727..8956d08 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -783,6 +783,7 @@ static void __init kuser_get_tls_init(unsigned long vectors)
 
 void __init early_trap_init(void)
 {
+#ifndef CONFIG_CPU_V7M
 #if defined(CONFIG_CPU_USE_DOMAINS)
 	unsigned long vectors = CONFIG_VECTORS_BASE;
 #else
@@ -818,4 +819,5 @@ void __init early_trap_init(void)
 
 	flush_icache_range(vectors, vectors + PAGE_SIZE);
 	modify_domain(DOMAIN_USER, DOMAIN_CLIENT);
+#endif
 }
diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index 4fc6794..fdd49ac 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -19,12 +19,14 @@
 
 void __init arm_mm_memblock_reserve(void)
 {
+#ifndef CONFIG_CPU_V7M
 	/*
 	 * Register the exception vector page.
 	 * some architectures which the DRAM is the exception vector to trap,
 	 * alloc_page breaks with error, although it is not NULL, but "0."
 	 */
 	memblock_reserve(CONFIG_VECTORS_BASE, PAGE_SIZE);
+#endif
 }
 
 void __init sanity_check_meminfo(void)
diff --git a/arch/arm/mm/proc-v7m.S b/arch/arm/mm/proc-v7m.S
new file mode 100644
index 0000000..a17653a
--- /dev/null
+++ b/arch/arm/mm/proc-v7m.S
@@ -0,0 +1,178 @@
+/*
+ *  linux/arch/arm/mm/proc-v7m.S
+ *
+ *  Copyright (C) 2008 ARM Ltd.
+ *  Copyright (C) 2001 Deep Blue Solutions Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ *  This is the "shell" of the ARMv7-M processor support.
+ */
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+
+ENTRY(cpu_v7m_proc_init)
+	mov	pc, lr
+ENDPROC(cpu_v7m_proc_init)
+
+ENTRY(cpu_v7m_proc_fin)
+	mov	pc, lr
+ENDPROC(cpu_v7m_proc_fin)
+
+/*
+ *	cpu_v7m_reset(loc)
+ *
+ *	Perform a soft reset of the system.  Put the CPU into the
+ *	same state as it would be if it had been reset, and branch
+ *	to what would be the reset vector.
+ *
+ *	- loc   - location to jump to for soft reset
+ */
+	.align	5
+ENTRY(cpu_v7m_reset)
+	mov	pc, r0
+ENDPROC(cpu_v7m_reset)
+
+/*
+ *	cpu_v7m_do_idle()
+ *
+ *	Idle the processor (eg, wait for interrupt).
+ *
+ *	IRQs are already disabled.
+ */
+ENTRY(cpu_v7m_do_idle)
+	wfi
+	mov	pc, lr
+ENDPROC(cpu_v7m_do_idle)
+
+ENTRY(cpu_v7m_dcache_clean_area)
+	mov	pc, lr
+ENDPROC(cpu_v7m_dcache_clean_area)
+
+/*
+ *	cpu_v7m_switch_mm(pgd_phys, tsk)
+ *
+ *	Set the translation table base pointer to be pgd_phys
+ *
+ *	- pgd_phys - physical address of new TTB
+ *
+ *	It is assumed that:
+ *	- we are not using split page tables
+ */
+ENTRY(cpu_v7m_switch_mm)
+	mov	pc, lr
+ENDPROC(cpu_v7m_switch_mm)
+
+cpu_v7m_name:
+	.ascii	"ARMv7-M Processor"
+	.align
+
+	.section ".text.init", #alloc, #execinstr
+
+/*
+ *	__v7m_setup
+ *
+ *	Initialise TLB, Caches, and MMU state ready to switch the MMU
+ *	on.  Return in r0 the new CP15 C1 control register setting.
+ *
+ *	We automatically detect if we have a Harvard cache, and use the
+ *	Harvard cache control instructions insead of the unified cache
+ *	control instructions.
+ *
+ *	This should be able to cover all ARMv7-M cores.
+ *
+ *	It is assumed that:
+ *	- cache type register is implemented
+ */
+__v7m_setup:
+	@ Configure the vector table base address
+	ldr	r0, =0xe000ed08		@ vector table base address
+	ldr	r12, =vector_table
+	str	r12, [r0]
+
+	@ Lower the priority of the SVC and PendSV exceptions
+	ldr	r0, =0xe000ed1c
+	mov	r5, #0x80000000
+	str	r5, [r0]		@ set SVC priority
+	ldr	r0, =0xe000ed20
+	mov	r5, #0x00800000
+	str	r5, [r0]		@ set PendSV priority
+
+	@ SVC to run the kernel in this mode
+	adr	r0, BSYM(1f)
+	ldr	r5, [r12, #11 * 4]	@ read the SVC vector entry
+	str	r0, [r12, #11 * 4]	@ write the temporary SVC vector entry
+	mov	r6, lr			@ save LR
+	mov	r7, sp			@ save SP
+	ldr	sp, =__v7m_setup_stack_top
+	cpsie	i
+	svc	#0
+1:	cpsid	i
+	str	r5, [r12, #11 * 4]	@ restore the original SVC vector entry
+	mov	lr, r6			@ restore LR
+	mov	sp, r7			@ restore SP
+
+	@ Special-purpose control register
+	mov	r0, #1
+	msr	control, r0		@ Thread mode has unpriviledged access
+
+	@ Configure the System Control Register
+	ldr	r0, =0xe000ed14		@ system control register
+	ldr	r12, [r0]
+	orr	r12, #1 << 9		@ STKALIGN
+	str	r12, [r0]
+	mov	pc, lr
+ENDPROC(__v7m_setup)
+
+	.align	2
+	.type	v7m_processor_functions, #object
+ENTRY(v7m_processor_functions)
+	.word	nommu_early_abort
+	.word	cpu_v7m_proc_init
+	.word	cpu_v7m_proc_fin
+	.word	cpu_v7m_reset
+	.word	cpu_v7m_do_idle
+	.word	cpu_v7m_dcache_clean_area
+	.word	cpu_v7m_switch_mm
+	.word	0			@ cpu_v7m_set_pte_ext
+	.word	legacy_pabort
+	.size	v7m_processor_functions, . - v7m_processor_functions
+
+	.type	cpu_arch_name, #object
+cpu_arch_name:
+	.asciz	"armv7m"
+	.size	cpu_arch_name, . - cpu_arch_name
+
+	.type	cpu_elf_name, #object
+cpu_elf_name:
+	.asciz	"v7m"
+	.size	cpu_elf_name, . - cpu_elf_name
+	.align
+
+	.section ".proc.info.init", #alloc, #execinstr
+
+	/*
+	 * Match any ARMv7-M processor core.
+	 */
+	.type	__v7m_proc_info, #object
+__v7m_proc_info:
+	.long	0x000f0000		@ Required ID value
+	.long	0x000f0000		@ Mask for ID
+	.long   0			@ proc_info_list.__cpu_mm_mmu_flags
+	.long   0			@ proc_info_list.__cpu_io_mmu_flags
+	b	__v7m_setup		@ proc_info_list.__cpu_flush
+	.long	cpu_arch_name
+	.long	cpu_elf_name
+	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP
+	.long	cpu_v7m_name
+	.long	v7m_processor_functions	@ proc_info_list.proc
+	.long	0			@ proc_info_list.tlb
+	.long	0			@ proc_info_list.user
+	.long	0			@ proc_info_list.cache
+	.size	__v7m_proc_info, . - __v7m_proc_info
+
+__v7m_setup_stack:
+	.space	4 * 8				@ 8 registers
+__v7m_setup_stack_top:
-- 
1.7.9
