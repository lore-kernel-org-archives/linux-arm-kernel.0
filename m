From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 17 Apr 2013 18:14:57 +0200
Subject: [PATCH v11 1/3] ARM: Add base support for ARMv7-M
In-Reply-To: <1366215299-31969-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1366215299-31969-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1366215299-31969-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Catalin Marinas <catalin.marinas@arm.com>

This patch adds the base support for the ARMv7-M
architecture. It consists of the corresponding arch/arm/mm/ files and
various #ifdef's around the kernel. Exception handling is implemented by
a subsequent patch.

[ukleinek: squash in some changes originating from commit

b5717ba (Cortex-M3: Add support for the Microcontroller Prototyping System)

from the v2.6.33-arm1 patch stack, port to post 3.6, drop zImage
support, drop reorganisation of pt_regs, assert CONFIG_V7M doesn't leak
into installed headers and a few cosmetic changes]

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---

Notes:
    Changes since v9, sent with
    Message-id:1363901310-9474-2-git-send-email-u.kleine-koenig at pengutronix.de:
    
     - use relative offsets for V7M_SCB
     - drop unused constants for EXC_RET_... and add a comment instead
     - several new and expanded comments
     - drop HWCAP_SWP and HWCAP_EDSP, add HWCAP_IDIVT
    
    Changes since v10, sent with
    Message-id:1364381692-7955-2-git-send-email-u.kleine-koenig at pengutronix.de:
    
     - drop unneeded #includes from cache-nop.S
     - use define_processor_functions instead of hand coding it. This fixes a
       mismatch between struct processor and v7m_processor_functions. Noticed by
       Jonathan Austin.

 arch/arm/include/asm/assembler.h   |  17 +++-
 arch/arm/include/asm/cputype.h     |  12 ++-
 arch/arm/include/asm/glue-cache.h  |  27 +++++++
 arch/arm/include/asm/glue-df.h     |   8 ++
 arch/arm/include/asm/glue-proc.h   |   9 +++
 arch/arm/include/asm/irqflags.h    |  22 ++++--
 arch/arm/include/asm/ptrace.h      |   4 +
 arch/arm/include/asm/system_info.h |   1 +
 arch/arm/include/asm/v7m.h         |  44 +++++++++++
 arch/arm/include/uapi/asm/ptrace.h |  35 +++++++--
 arch/arm/kernel/head-nommu.S       |  10 ++-
 arch/arm/kernel/setup.c            |  17 +++-
 arch/arm/kernel/traps.c            |   8 ++
 arch/arm/mm/cache-nop.S            |  50 ++++++++++++
 arch/arm/mm/nommu.c                |   7 ++
 arch/arm/mm/proc-v7m.S             | 157 +++++++++++++++++++++++++++++++++++++
 16 files changed, 407 insertions(+), 21 deletions(-)
 create mode 100644 arch/arm/include/asm/v7m.h
 create mode 100644 arch/arm/mm/cache-nop.S
 create mode 100644 arch/arm/mm/proc-v7m.S

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 05ee9ee..a5fef71 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -136,7 +136,11 @@
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
 
@@ -150,7 +154,11 @@
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
@@ -229,7 +237,14 @@
 #endif
 	.endm
 
-#ifdef CONFIG_THUMB2_KERNEL
+#if defined(CONFIG_CPU_V7M)
+	/*
+	 * setmode is used to assert to be in svc mode during boot. For v7-M
+	 * this is done in __v7m_setup, so setmode can be empty here.
+	 */
+	.macro	setmode, mode, reg
+	.endm
+#elif defined(CONFIG_THUMB2_KERNEL)
 	.macro	setmode, mode, reg
 	mov	\reg, #\mode
 	msr	cpsr_c, \reg
diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index 7652712..4eb94a3 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -106,7 +106,17 @@ static inline unsigned int __attribute_const__ read_cpuid_id(void)
 	return read_cpuid(CPUID_ID);
 }
 
-#else /* ifdef CONFIG_CPU_CP15 */
+#elif defined(CONFIG_CPU_V7M)
+
+#include <asm/io.h>
+#include <asm/v7m.h>
+
+static inline unsigned int __attribute_const__ read_cpuid_id(void)
+{
+	return readl(BASEADDR_V7M_SCB + V7M_SCB_CPUID);
+}
+
+#else /* ifdef CONFIG_CPU_CP15 / elif defined(CONFIG_CPU_V7M) */
 
 static inline unsigned int __attribute_const__ read_cpuid_id(void)
 {
diff --git a/arch/arm/include/asm/glue-cache.h b/arch/arm/include/asm/glue-cache.h
index cca9f15..65c9faf 100644
--- a/arch/arm/include/asm/glue-cache.h
+++ b/arch/arm/include/asm/glue-cache.h
@@ -125,10 +125,37 @@
 # endif
 #endif
 
+#if defined(CONFIG_CPU_V7M)
+# ifdef _CACHE
+#  define MULTI_CACHE 1
+# else
+#  define _CACHE nop
+# endif
+#endif
+
 #if !defined(_CACHE) && !defined(MULTI_CACHE)
 #error Unknown cache maintenance model
 #endif
 
+#ifndef __ASSEMBLER__
+extern inline void nop_flush_icache_all(void) { }
+extern inline void nop_flush_kern_cache_all(void) { }
+extern inline void nop_flush_kern_cache_louis(void) { }
+extern inline void nop_flush_user_cache_all(void) { }
+extern inline void nop_flush_user_cache_range(unsigned long a,
+		unsigned long b, unsigned int c) { }
+
+extern inline void nop_coherent_kern_range(unsigned long a, unsigned long b) { }
+extern inline int nop_coherent_user_range(unsigned long a,
+		unsigned long b) { return 0; }
+extern inline void nop_flush_kern_dcache_area(void *a, size_t s) { }
+
+extern inline void nop_dma_flush_range(const void *a, const void *b) { }
+
+extern inline void nop_dma_map_area(const void *s, size_t l, int f) { }
+extern inline void nop_dma_unmap_area(const void *s, size_t l, int f) { }
+#endif
+
 #ifndef MULTI_CACHE
 #define __cpuc_flush_icache_all		__glue(_CACHE,_flush_icache_all)
 #define __cpuc_flush_kern_all		__glue(_CACHE,_flush_kern_cache_all)
diff --git a/arch/arm/include/asm/glue-df.h b/arch/arm/include/asm/glue-df.h
index b6e9f2c..6b70f1b 100644
--- a/arch/arm/include/asm/glue-df.h
+++ b/arch/arm/include/asm/glue-df.h
@@ -95,6 +95,14 @@
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
index ac1dd54..f2f39bc 100644
--- a/arch/arm/include/asm/glue-proc.h
+++ b/arch/arm/include/asm/glue-proc.h
@@ -230,6 +230,15 @@
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
index 1e6cca5..3b763d6 100644
--- a/arch/arm/include/asm/irqflags.h
+++ b/arch/arm/include/asm/irqflags.h
@@ -8,6 +8,16 @@
 /*
  * CPU interrupt mask handling.
  */
+#ifdef CONFIG_CPU_V7M
+#define IRQMASK_REG_NAME_R "primask"
+#define IRQMASK_REG_NAME_W "primask"
+#define IRQMASK_I_BIT	1
+#else
+#define IRQMASK_REG_NAME_R "cpsr"
+#define IRQMASK_REG_NAME_W "cpsr_c"
+#define IRQMASK_I_BIT	PSR_I_BIT
+#endif
+
 #if __LINUX_ARM_ARCH__ >= 6
 
 static inline unsigned long arch_local_irq_save(void)
@@ -15,7 +25,7 @@ static inline unsigned long arch_local_irq_save(void)
 	unsigned long flags;
 
 	asm volatile(
-		"	mrs	%0, cpsr	@ arch_local_irq_save\n"
+		"	mrs	%0, " IRQMASK_REG_NAME_R "	@ arch_local_irq_save\n"
 		"	cpsid	i"
 		: "=r" (flags) : : "memory", "cc");
 	return flags;
@@ -129,7 +139,7 @@ static inline unsigned long arch_local_save_flags(void)
 {
 	unsigned long flags;
 	asm volatile(
-		"	mrs	%0, cpsr	@ local_save_flags"
+		"	mrs	%0, " IRQMASK_REG_NAME_R "	@ local_save_flags"
 		: "=r" (flags) : : "memory", "cc");
 	return flags;
 }
@@ -140,7 +150,7 @@ static inline unsigned long arch_local_save_flags(void)
 static inline void arch_local_irq_restore(unsigned long flags)
 {
 	asm volatile(
-		"	msr	cpsr_c, %0	@ local_irq_restore"
+		"	msr	" IRQMASK_REG_NAME_W ", %0	@ local_irq_restore"
 		:
 		: "r" (flags)
 		: "memory", "cc");
@@ -148,8 +158,8 @@ static inline void arch_local_irq_restore(unsigned long flags)
 
 static inline int arch_irqs_disabled_flags(unsigned long flags)
 {
-	return flags & PSR_I_BIT;
+	return flags & IRQMASK_I_BIT;
 }
 
-#endif
-#endif
+#endif /* ifdef __KERNEL__ */
+#endif /* ifndef __ASM_ARM_IRQFLAGS_H */
diff --git a/arch/arm/include/asm/ptrace.h b/arch/arm/include/asm/ptrace.h
index 3d52ee1..04c99f3 100644
--- a/arch/arm/include/asm/ptrace.h
+++ b/arch/arm/include/asm/ptrace.h
@@ -45,6 +45,7 @@ struct pt_regs {
  */
 static inline int valid_user_regs(struct pt_regs *regs)
 {
+#ifndef CONFIG_CPU_V7M
 	unsigned long mode = regs->ARM_cpsr & MODE_MASK;
 
 	/*
@@ -67,6 +68,9 @@ static inline int valid_user_regs(struct pt_regs *regs)
 		regs->ARM_cpsr |= USR_MODE;
 
 	return 0;
+#else /* ifndef CONFIG_CPU_V7M */
+	return 1;
+#endif
 }
 
 static inline long regs_return_value(struct pt_regs *regs)
diff --git a/arch/arm/include/asm/system_info.h b/arch/arm/include/asm/system_info.h
index dfd386d..720ea03 100644
--- a/arch/arm/include/asm/system_info.h
+++ b/arch/arm/include/asm/system_info.h
@@ -11,6 +11,7 @@
 #define CPU_ARCH_ARMv5TEJ	7
 #define CPU_ARCH_ARMv6		8
 #define CPU_ARCH_ARMv7		9
+#define CPU_ARCH_ARMv7M		10
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm/include/asm/v7m.h b/arch/arm/include/asm/v7m.h
new file mode 100644
index 0000000..fa88d09
--- /dev/null
+++ b/arch/arm/include/asm/v7m.h
@@ -0,0 +1,44 @@
+/*
+ * Common defines for v7m cpus
+ */
+#define V7M_SCS_ICTR			IOMEM(0xe000e004)
+#define V7M_SCS_ICTR_INTLINESNUM_MASK		0x0000000f
+
+#define BASEADDR_V7M_SCB		IOMEM(0xe000ed00)
+
+#define V7M_SCB_CPUID			0x00
+
+#define V7M_SCB_ICSR			0x04
+#define V7M_SCB_ICSR_PENDSVSET			(1 << 28)
+#define V7M_SCB_ICSR_PENDSVCLR			(1 << 27)
+#define V7M_SCB_ICSR_RETTOBASE			(1 << 11)
+
+#define V7M_SCB_VTOR			0x08
+
+#define V7M_SCB_SCR			0x10
+#define V7M_SCB_SCR_SLEEPDEEP			(1 << 2)
+
+#define V7M_SCB_CCR			0x14
+#define V7M_SCB_CCR_STKALIGN			(1 << 9)
+
+#define V7M_SCB_SHPR2			0x1c
+#define V7M_SCB_SHPR3			0x20
+
+#define V7M_SCB_SHCSR			0x24
+#define V7M_SCB_SHCSR_USGFAULTENA		(1 << 18)
+#define V7M_SCB_SHCSR_BUSFAULTENA		(1 << 17)
+#define V7M_SCB_SHCSR_MEMFAULTENA		(1 << 16)
+
+#define V7M_xPSR_FRAMEPTRALIGN			0x00000200
+#define V7M_xPSR_EXCEPTIONNO			0x000001ff
+
+/*
+ * When branching to an address that has bits [31:28] == 0xf an exception return
+ * occurs. Bits [27:5] are reserved (SBOP). If the processor implements the FP
+ * extension Bit [4] defines if the exception frame has space allocated for FP
+ * state information, SBOP otherwise. Bit [3] defines the mode that is returned
+ * to (0 -> handler mode; 1 -> thread mode). Bit [2] defines which sp is used
+ * (0 -> msp; 1 -> psp). Bits [1:0] are fixed to 0b01.
+ */
+#define EXC_RET_STACK_MASK			0x00000004
+#define EXC_RET_THREADMODE_PROCESSSTACK		0xfffffffd
diff --git a/arch/arm/include/uapi/asm/ptrace.h b/arch/arm/include/uapi/asm/ptrace.h
index 96ee092..5af0ed1 100644
--- a/arch/arm/include/uapi/asm/ptrace.h
+++ b/arch/arm/include/uapi/asm/ptrace.h
@@ -34,28 +34,47 @@
 
 /*
  * PSR bits
+ * Note on V7M there is no mode contained in the PSR
  */
 #define USR26_MODE	0x00000000
 #define FIQ26_MODE	0x00000001
 #define IRQ26_MODE	0x00000002
 #define SVC26_MODE	0x00000003
+#if defined(__KERNEL__) && defined(CONFIG_CPU_V7M)
+/*
+ * Use 0 here to get code right that creates a userspace
+ * or kernel space thread.
+ */
+#define USR_MODE	0x00000000
+#define SVC_MODE	0x00000000
+#else
 #define USR_MODE	0x00000010
+#define SVC_MODE	0x00000013
+#endif
 #define FIQ_MODE	0x00000011
 #define IRQ_MODE	0x00000012
-#define SVC_MODE	0x00000013
 #define ABT_MODE	0x00000017
 #define HYP_MODE	0x0000001a
 #define UND_MODE	0x0000001b
 #define SYSTEM_MODE	0x0000001f
 #define MODE32_BIT	0x00000010
 #define MODE_MASK	0x0000001f
-#define PSR_T_BIT	0x00000020
-#define PSR_F_BIT	0x00000040
-#define PSR_I_BIT	0x00000080
-#define PSR_A_BIT	0x00000100
-#define PSR_E_BIT	0x00000200
-#define PSR_J_BIT	0x01000000
-#define PSR_Q_BIT	0x08000000
+
+#define V4_PSR_T_BIT	0x00000020	/* >= V4T, but not V7M */
+#define V7M_PSR_T_BIT	0x01000000
+#if defined(__KERNEL__) && defined(CONFIG_CPU_V7M)
+#define PSR_T_BIT	V7M_PSR_T_BIT
+#else
+/* for compatibility */
+#define PSR_T_BIT	V4_PSR_T_BIT
+#endif
+
+#define PSR_F_BIT	0x00000040	/* >= V4, but not V7M */
+#define PSR_I_BIT	0x00000080	/* >= V4, but not V7M */
+#define PSR_A_BIT	0x00000100	/* >= V6, but not V7M */
+#define PSR_E_BIT	0x00000200	/* >= V6, but not V7M */
+#define PSR_J_BIT	0x01000000	/* >= V5J, but not V7M */
+#define PSR_Q_BIT	0x08000000	/* >= V5E, including V7M */
 #define PSR_V_BIT	0x10000000
 #define PSR_C_BIT	0x20000000
 #define PSR_Z_BIT	0x40000000
diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
index 6a2e09c..8812ce8 100644
--- a/arch/arm/kernel/head-nommu.S
+++ b/arch/arm/kernel/head-nommu.S
@@ -19,6 +19,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/cp15.h>
 #include <asm/thread_info.h>
+#include <asm/v7m.h>
 
 /*
  * Kernel startup entry point.
@@ -50,10 +51,13 @@ ENTRY(stext)
 
 	setmode	PSR_F_BIT | PSR_I_BIT | SVC_MODE, r9 @ ensure svc mode
 						@ and irqs disabled
-#ifndef CONFIG_CPU_CP15
-	ldr	r9, =CONFIG_PROCESSOR_ID
-#else
+#if defined(CONFIG_CPU_CP15)
 	mrc	p15, 0, r9, c0, c0		@ get processor id
+#elif defined(CONFIG_CPU_V7M)
+	ldr	r9, =BASEADDR_V7M_SCB
+	ldr	r9, [r9, V7M_SCB_CPUID]
+#else
+	ldr	r9, =CONFIG_PROCESSOR_ID
 #endif
 	bl	__lookup_processor_type		@ r5=procinfo r9=cpuid
 	movs	r10, r5				@ invalid processor (r5=0)?
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 1cc9e17..8291245 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -128,7 +128,9 @@ struct stack {
 	u32 und[3];
 } ____cacheline_aligned;
 
+#ifndef CONFIG_CPU_V7M
 static struct stack stacks[NR_CPUS];
+#endif
 
 char elf_platform[ELF_PLATFORM_SIZE];
 EXPORT_SYMBOL(elf_platform);
@@ -207,7 +209,7 @@ static const char *proc_arch[] = {
 	"5TEJ",
 	"6TEJ",
 	"7",
-	"?(11)",
+	"7M",
 	"?(12)",
 	"?(13)",
 	"?(14)",
@@ -216,6 +218,12 @@ static const char *proc_arch[] = {
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
@@ -248,6 +256,7 @@ static int __get_cpu_architecture(void)
 
 	return cpu_arch;
 }
+#endif
 
 int __pure cpu_architecture(void)
 {
@@ -293,7 +302,9 @@ static void __init cacheid_init(void)
 {
 	unsigned int arch = cpu_architecture();
 
-	if (arch >= CPU_ARCH_ARMv6) {
+	if (arch == CPU_ARCH_ARMv7M) {
+		cacheid = 0;
+	} else if (arch >= CPU_ARCH_ARMv6) {
 		unsigned int cachetype = read_cpuid_cachetype();
 		if ((cachetype & (7 << 29)) == 4 << 29) {
 			/* ARMv7 register format */
@@ -375,6 +386,7 @@ static void __init feat_v6_fixup(void)
  */
 void cpu_init(void)
 {
+#ifndef CONFIG_CPU_V7M
 	unsigned int cpu = smp_processor_id();
 	struct stack *stk = &stacks[cpu];
 
@@ -425,6 +437,7 @@ void cpu_init(void)
 	      "I" (offsetof(struct stack, und[0])),
 	      PLC (PSR_F_BIT | PSR_I_BIT | SVC_MODE)
 	    : "r14");
+#endif
 }
 
 int __cpu_logical_map[NR_CPUS];
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 1c08911..ec645714 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -819,6 +819,7 @@ static void __init kuser_get_tls_init(unsigned long vectors)
 
 void __init early_trap_init(void *vectors_base)
 {
+#ifndef CONFIG_CPU_V7M
 	unsigned long vectors = (unsigned long)vectors_base;
 	extern char __stubs_start[], __stubs_end[];
 	extern char __vectors_start[], __vectors_end[];
@@ -850,4 +851,11 @@ void __init early_trap_init(void *vectors_base)
 
 	flush_icache_range(vectors, vectors + PAGE_SIZE);
 	modify_domain(DOMAIN_USER, DOMAIN_CLIENT);
+#else /* ifndef CONFIG_CPU_V7M */
+	/*
+	 * on V7-M there is no need to copy the vector table to a dedicated
+	 * memory area. The address is configurable and so a table in the kernel
+	 * image can be used.
+	 */
+#endif
 }
diff --git a/arch/arm/mm/cache-nop.S b/arch/arm/mm/cache-nop.S
new file mode 100644
index 0000000..8e12ddc
--- /dev/null
+++ b/arch/arm/mm/cache-nop.S
@@ -0,0 +1,50 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/linkage.h>
+#include <linux/init.h>
+
+#include "proc-macros.S"
+
+ENTRY(nop_flush_icache_all)
+	mov	pc, lr
+ENDPROC(nop_flush_icache_all)
+
+	.globl nop_flush_kern_cache_all
+	.equ nop_flush_kern_cache_all, nop_flush_icache_all
+
+	.globl nop_flush_kern_cache_louis
+	.equ nop_flush_kern_cache_louis, nop_flush_icache_all
+
+	.globl nop_flush_user_cache_all
+	.equ nop_flush_user_cache_all, nop_flush_icache_all
+
+	.globl nop_flush_user_cache_range
+	.equ nop_flush_user_cache_range, nop_flush_icache_all
+
+	.globl nop_coherent_kern_range
+	.equ nop_coherent_kern_range, nop_flush_icache_all
+
+ENTRY(nop_coherent_user_range)
+	mov	r0, 0
+	mov	pc, lr
+ENDPROC(nop_coherent_user_range)
+
+	.globl nop_flush_kern_dcache_area
+	.equ nop_flush_kern_dcache_area, nop_flush_icache_all
+
+	.globl nop_dma_flush_range
+	.equ nop_dma_flush_range, nop_flush_icache_all
+
+	.globl nop_dma_map_area
+	.equ nop_dma_map_area, nop_flush_icache_all
+
+	.globl nop_dma_unmap_area
+	.equ nop_dma_unmap_area, nop_flush_icache_all
+
+	__INITDATA
+
+	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
+	define_cache_functions nop
diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index d51225f..dd3a6c6 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -20,12 +20,19 @@
 
 void __init arm_mm_memblock_reserve(void)
 {
+#ifndef CONFIG_CPU_V7M
 	/*
 	 * Register the exception vector page.
 	 * some architectures which the DRAM is the exception vector to trap,
 	 * alloc_page breaks with error, although it is not NULL, but "0."
 	 */
 	memblock_reserve(CONFIG_VECTORS_BASE, PAGE_SIZE);
+#else /* ifndef CONFIG_CPU_V7M */
+	/*
+	 * There is no dedicated vector page on V7-M. So nothing needs to be
+	 * reserved here.
+	 */
+#endif
 }
 
 void __init sanity_check_meminfo(void)
diff --git a/arch/arm/mm/proc-v7m.S b/arch/arm/mm/proc-v7m.S
new file mode 100644
index 0000000..000499c
--- /dev/null
+++ b/arch/arm/mm/proc-v7m.S
@@ -0,0 +1,157 @@
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
+#include <asm/v7m.h>
+#include "proc-macros.S"
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
+ * There is no MMU, so here is nothing to do.
+ */
+ENTRY(cpu_v7m_switch_mm)
+	mov	pc, lr
+ENDPROC(cpu_v7m_switch_mm)
+
+.globl	cpu_v7m_suspend_size
+.equ	cpu_v7m_suspend_size, 0
+
+#ifdef CONFIG_ARM_CPU_SUSPEND
+ENTRY(cpu_v7m_do_suspend)
+	mov	pc, lr
+ENDPROC(cpu_v7m_do_suspend)
+
+ENTRY(cpu_v7m_do_resume)
+	mov	pc, lr
+ENDPROC(cpu_v7m_do_resume)
+#endif
+
+	.section ".text.init", #alloc, #execinstr
+
+/*
+ *	__v7m_setup
+ *
+ *	This should be able to cover all ARMv7-M cores.
+ */
+__v7m_setup:
+	@ Configure the vector table base address
+	ldr	r0, =BASEADDR_V7M_SCB
+	ldr	r12, =vector_table
+	str	r12, [r0, V7M_SCB_VTOR]
+
+	@ enable UsageFault, BusFault and MemManage fault.
+	ldr	r5, [r0, #V7M_SCB_SHCSR]
+	orr	r5, #(V7M_SCB_SHCSR_USGFAULTENA | V7M_SCB_SHCSR_BUSFAULTENA | V7M_SCB_SHCSR_MEMFAULTENA)
+	str	r5, [r0, #V7M_SCB_SHCSR]
+
+	@ Lower the priority of the SVC and PendSV exceptions
+	mov	r5, #0x80000000
+	str	r5, [r0, V7M_SCB_SHPR2]	@ set SVC priority
+	mov	r5, #0x00800000
+	str	r5, [r0, V7M_SCB_SHPR3]	@ set PendSV priority
+
+	@ SVC to run the kernel in this mode
+	adr	r1, BSYM(1f)
+	ldr	r5, [r12, #11 * 4]	@ read the SVC vector entry
+	str	r1, [r12, #11 * 4]	@ write the temporary SVC vector entry
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
+	mov	r1, #1
+	msr	control, r1		@ Thread mode has unpriviledged access
+
+	@ Configure the System Control Register to ensure 8-byte stack alignment
+	@ Note the STKALIGN bit is either RW or RAO.
+	ldr	r12, [r0, V7M_SCB_CCR]	@ system control register
+	orr	r12, #V7M_SCB_CCR_STKALIGN
+	str	r12, [r0, V7M_SCB_CCR]
+	mov	pc, lr
+ENDPROC(__v7m_setup)
+
+	define_processor_functions v7m, dabort=nommu_early_abort, pabort=legacy_pabort, nommu=1
+
+	.section ".rodata"
+	string cpu_arch_name, "armv7m"
+	string cpu_elf_name "v7m"
+	string cpu_v7m_name "ARMv7-M"
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
+	.long	HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_IDIVT
+	.long	cpu_v7m_name
+	.long	v7m_processor_functions	@ proc_info_list.proc
+	.long	0			@ proc_info_list.tlb
+	.long	0			@ proc_info_list.user
+	.long	nop_cache_fns		@ proc_info_list.cache
+	.size	__v7m_proc_info, . - __v7m_proc_info
+
+__v7m_setup_stack:
+	.space	4 * 8				@ 8 registers
+__v7m_setup_stack_top:
-- 
1.8.2.rc3
