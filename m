From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu,  5 Jun 2014 11:06:09 +0200
Subject: [PATCH 1/5] ARM: nommu: drop support for ARM740T,
 ARM940T and ARM946E-S processors
In-Reply-To: <1401959173-13117-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1401959173-13117-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1401959173-13117-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are no symbols selecting the corresponding processor symbols
(CPU_ARM740T, CPU_ARM940, CPU_ARM946E) and they are only user selectable
with ARCH_INTEGRATOR. But as the processor symbols depend on !MMU and
ARCH_INTEGRATOR selects ARM_PATCH_PHYS_VIRT which depends on MMU these
configurations are broken since at least Linux 3.13.

As a side effect this patch removes most usages of CONFIG_DRAM_SIZE.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 Documentation/devicetree/bindings/arm/cpus.txt |   3 -
 arch/arm/Kconfig                               |   5 +-
 arch/arm/Makefile                              |   3 -
 arch/arm/include/asm/glue-cache.h              |  16 -
 arch/arm/include/asm/glue-proc.h               |  27 --
 arch/arm/mm/Kconfig                            |  67 +---
 arch/arm/mm/Makefile                           |   3 -
 arch/arm/mm/proc-arm740.S                      | 151 ---------
 arch/arm/mm/proc-arm940.S                      | 374 ---------------------
 arch/arm/mm/proc-arm946.S                      | 429 -------------------------
 10 files changed, 9 insertions(+), 1069 deletions(-)
 delete mode 100644 arch/arm/mm/proc-arm740.S
 delete mode 100644 arch/arm/mm/proc-arm940.S
 delete mode 100644 arch/arm/mm/proc-arm946.S

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index 333f4aea3029..00fa2786396b 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -120,7 +120,6 @@ nodes to be present and contain the properties described below.
 		Definition: should be one of:
 			    "arm,arm710t"
 			    "arm,arm720t"
-			    "arm,arm740t"
 			    "arm,arm7ej-s"
 			    "arm,arm7tdmi"
 			    "arm,arm7tdmi-s"
@@ -131,8 +130,6 @@ nodes to be present and contain the properties described below.
 			    "arm,arm925"
 			    "arm,arm926e-s"
 			    "arm,arm926ej-s"
-			    "arm,arm940t"
-			    "arm,arm946e-s"
 			    "arm,arm966e-s"
 			    "arm,arm968e-s"
 			    "arm,arm9tdmi"
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index db3c5414223e..1c72e1932ab3 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -899,14 +899,13 @@ config ARCH_MULTI_V4T
 	depends on !ARCH_MULTI_V6_V7
 	select ARCH_MULTI_V4_V5
 	select CPU_ARM920T if !(CPU_ARM7TDMI || CPU_ARM720T || \
-		CPU_ARM740T || CPU_ARM9TDMI || CPU_ARM922T || \
-		CPU_ARM925T || CPU_ARM940T)
+		CPU_ARM9TDMI || CPU_ARM922T || CPU_ARM925T)
 
 config ARCH_MULTI_V5
 	bool "ARMv5 based platforms (ARM926T, XSCALE, PJ1, ...)"
 	depends on !ARCH_MULTI_V6_V7
 	select ARCH_MULTI_V4_V5
-	select CPU_ARM926T if !(CPU_ARM946E || CPU_ARM1020 || \
+	select CPU_ARM926T if !(CPU_ARM1020 || \
 		CPU_ARM1020E || CPU_ARM1022 || CPU_ARM1026 || \
 		CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_FEROCEON)
 
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 41c1931f0155..824999bca9c6 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -75,10 +75,7 @@ arch-y := $(arch-y)
 # This selects how we optimise for the processor.
 tune-$(CONFIG_CPU_ARM7TDMI)	=-mtune=arm7tdmi
 tune-$(CONFIG_CPU_ARM720T)	=-mtune=arm7tdmi
-tune-$(CONFIG_CPU_ARM740T)	=-mtune=arm7tdmi
 tune-$(CONFIG_CPU_ARM9TDMI)	=-mtune=arm9tdmi
-tune-$(CONFIG_CPU_ARM940T)	=-mtune=arm9tdmi
-tune-$(CONFIG_CPU_ARM946E)	=$(call cc-option,-mtune=arm9e,-mtune=arm9tdmi)
 tune-$(CONFIG_CPU_ARM920T)	=-mtune=arm9tdmi
 tune-$(CONFIG_CPU_ARM922T)	=-mtune=arm9tdmi
 tune-$(CONFIG_CPU_ARM925T)	=-mtune=arm9tdmi
diff --git a/arch/arm/include/asm/glue-cache.h b/arch/arm/include/asm/glue-cache.h
index c81adc08b3fb..33fabcdb23d5 100644
--- a/arch/arm/include/asm/glue-cache.h
+++ b/arch/arm/include/asm/glue-cache.h
@@ -49,22 +49,6 @@
 # endif
 #endif
 
-#if defined(CONFIG_CPU_ARM940T)
-# ifdef _CACHE
-#  define MULTI_CACHE 1
-# else
-#  define _CACHE arm940
-# endif
-#endif
-
-#if defined(CONFIG_CPU_ARM946E)
-# ifdef _CACHE
-#  define MULTI_CACHE 1
-# else
-#  define _CACHE arm946
-# endif
-#endif
-
 #if defined(CONFIG_CPU_CACHE_V4WB)
 # ifdef _CACHE
 #  define MULTI_CACHE 1
diff --git a/arch/arm/include/asm/glue-proc.h b/arch/arm/include/asm/glue-proc.h
index 74a8b84f3cb1..66e73726a7db 100644
--- a/arch/arm/include/asm/glue-proc.h
+++ b/arch/arm/include/asm/glue-proc.h
@@ -41,15 +41,6 @@
 # endif
 #endif
 
-#ifdef CONFIG_CPU_ARM740T
-# ifdef CPU_NAME
-#  undef  MULTI_CPU
-#  define MULTI_CPU
-# else
-#  define CPU_NAME cpu_arm740
-# endif
-#endif
-
 #ifdef CONFIG_CPU_ARM9TDMI
 # ifdef CPU_NAME
 #  undef  MULTI_CPU
@@ -104,24 +95,6 @@
 # endif
 #endif
 
-#ifdef CONFIG_CPU_ARM940T
-# ifdef CPU_NAME
-#  undef  MULTI_CPU
-#  define MULTI_CPU
-# else
-#  define CPU_NAME cpu_arm940
-# endif
-#endif
-
-#ifdef CONFIG_CPU_ARM946E
-# ifdef CPU_NAME
-#  undef  MULTI_CPU
-#  define MULTI_CPU
-# else
-#  define CPU_NAME cpu_arm946
-# endif
-#endif
-
 #ifdef CONFIG_CPU_SA110
 # ifdef CPU_NAME
 #  undef  MULTI_CPU
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 5bf7c3c3b301..5769591fb6e4 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -37,23 +37,6 @@ config CPU_ARM720T
 	  Say Y if you want support for the ARM720T processor.
 	  Otherwise, say N.
 
-# ARM740T
-config CPU_ARM740T
-	bool "Support ARM740T processor" if ARCH_INTEGRATOR
-	depends on !MMU
-	select CPU_32v4T
-	select CPU_ABRT_LV4T
-	select CPU_CACHE_V4
-	select CPU_CP15_MPU
-	select CPU_PABRT_LEGACY
-	help
-	  A 32-bit RISC processor with 8KB cache or 4KB variants,
-	  write buffer and MPU(Protection Unit) built around
-	  an ARM7TDMI core.
-
-	  Say Y if you want support for the ARM740T processor.
-	  Otherwise, say N.
-
 # ARM9TDMI
 config CPU_ARM9TDMI
 	bool "Support ARM9TDMI processor"
@@ -161,41 +144,6 @@ config CPU_FA526
 	  Say Y if you want support for the FA526 processor.
 	  Otherwise, say N.
 
-# ARM940T
-config CPU_ARM940T
-	bool "Support ARM940T processor" if ARCH_INTEGRATOR
-	depends on !MMU
-	select CPU_32v4T
-	select CPU_ABRT_NOMMU
-	select CPU_CACHE_VIVT
-	select CPU_CP15_MPU
-	select CPU_PABRT_LEGACY
-	help
-	  ARM940T is a member of the ARM9TDMI family of general-
-	  purpose microprocessors with MPU and separate 4KB
-	  instruction and 4KB data cases, each with a 4-word line
-	  length.
-
-	  Say Y if you want support for the ARM940T processor.
-	  Otherwise, say N.
-
-# ARM946E-S
-config CPU_ARM946E
-	bool "Support ARM946E-S processor" if ARCH_INTEGRATOR
-	depends on !MMU
-	select CPU_32v5
-	select CPU_ABRT_NOMMU
-	select CPU_CACHE_VIVT
-	select CPU_CP15_MPU
-	select CPU_PABRT_LEGACY
-	help
-	  ARM946E-S is a member of the ARM9E-S family of high-
-	  performance, 32-bit system-on-chip processor solutions.
-	  The TCM and ARMv5TE 32-bit instruction set is supported.
-
-	  Say Y if you want support for the ARM946E-S processor.
-	  Otherwise, say N.
-
 # ARM1020 - needs validating
 config CPU_ARM1020
 	bool "Support ARM1020T (rev 0) processor" if ARCH_INTEGRATOR
@@ -632,8 +580,8 @@ config ARCH_DMA_ADDR_T_64BIT
 
 config ARM_THUMB
 	bool "Support Thumb user binaries" if !CPU_THUMBONLY
-	depends on CPU_ARM720T || CPU_ARM740T || CPU_ARM920T || CPU_ARM922T || \
-		CPU_ARM925T || CPU_ARM926T || CPU_ARM940T || CPU_ARM946E || \
+	depends on CPU_ARM720T || CPU_ARM920T || CPU_ARM922T || \
+		CPU_ARM925T || CPU_ARM926T || \
 		CPU_ARM1020 || CPU_ARM1020E || CPU_ARM1022 || CPU_ARM1026 || \
 		CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_V6 || CPU_V6K || \
 		CPU_V7 || CPU_FEROCEON || CPU_V7M
@@ -719,7 +667,7 @@ config CPU_ENDIAN_BE32
 	  Support for the BE-32 (big-endian) mode on pre-ARMv6 processors.
 
 config CPU_HIGH_VECTOR
-	depends on !MMU && CPU_CP15 && !CPU_ARM740T
+	depends on !MMU && CPU_CP15
 	bool "Select the High exception vector"
 	help
 	  Say Y here to select high exception vector(0xFFFF0000~).
@@ -731,7 +679,7 @@ config CPU_HIGH_VECTOR
 
 config CPU_ICACHE_DISABLE
 	bool "Disable I-Cache (I-bit)"
-	depends on CPU_CP15 && !(CPU_ARM720T || CPU_ARM740T || CPU_XSCALE || CPU_XSC3)
+	depends on CPU_CP15 && !(CPU_ARM720T || CPU_XSCALE || CPU_XSC3)
 	help
 	  Say Y here to disable the processor instruction cache. Unless
 	  you have a reason not to or are unsure, say N.
@@ -745,9 +693,8 @@ config CPU_DCACHE_DISABLE
 
 config CPU_DCACHE_SIZE
 	hex
-	depends on CPU_ARM740T || CPU_ARM946E
-	default 0x00001000 if CPU_ARM740T
-	default 0x00002000 # default size for ARM946E-S
+	depends on CPU_ARM946E
+	default 0x00002000
 	help
 	  Some cores are synthesizable to have various sized cache. For
 	  ARM946E-S case, it can vary from 0KB to 1MB.
@@ -758,7 +705,7 @@ config CPU_DCACHE_SIZE
 
 config CPU_DCACHE_WRITETHROUGH
 	bool "Force write through D-cache"
-	depends on (CPU_ARM740T || CPU_ARM920T || CPU_ARM922T || CPU_ARM925T || CPU_ARM926T || CPU_ARM940T || CPU_ARM946E || CPU_ARM1020 || CPU_FA526) && !CPU_DCACHE_DISABLE
+	depends on (CPU_ARM920T || CPU_ARM922T || CPU_ARM925T || CPU_ARM926T || CPU_ARM940T || CPU_ARM946E || CPU_ARM1020 || CPU_FA526) && !CPU_DCACHE_DISABLE
 	default y if CPU_ARM925T
 	help
 	  Say Y here to use the data cache in writethrough mode. Unless you
diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
index 7f39ce2f841f..eab01c3c9068 100644
--- a/arch/arm/mm/Makefile
+++ b/arch/arm/mm/Makefile
@@ -68,14 +68,11 @@ AFLAGS_tlb-v7.o		:=-Wa,-march=armv7-a
 
 obj-$(CONFIG_CPU_ARM7TDMI)	+= proc-arm7tdmi.o
 obj-$(CONFIG_CPU_ARM720T)	+= proc-arm720.o
-obj-$(CONFIG_CPU_ARM740T)	+= proc-arm740.o
 obj-$(CONFIG_CPU_ARM9TDMI)	+= proc-arm9tdmi.o
 obj-$(CONFIG_CPU_ARM920T)	+= proc-arm920.o
 obj-$(CONFIG_CPU_ARM922T)	+= proc-arm922.o
 obj-$(CONFIG_CPU_ARM925T)	+= proc-arm925.o
 obj-$(CONFIG_CPU_ARM926T)	+= proc-arm926.o
-obj-$(CONFIG_CPU_ARM940T)	+= proc-arm940.o
-obj-$(CONFIG_CPU_ARM946E)	+= proc-arm946.o
 obj-$(CONFIG_CPU_FA526)		+= proc-fa526.o
 obj-$(CONFIG_CPU_ARM1020)	+= proc-arm1020.o
 obj-$(CONFIG_CPU_ARM1020E)	+= proc-arm1020e.o
diff --git a/arch/arm/mm/proc-arm740.S b/arch/arm/mm/proc-arm740.S
deleted file mode 100644
index 9b0ae90cbf17..000000000000
--- a/arch/arm/mm/proc-arm740.S
+++ /dev/null
@@ -1,151 +0,0 @@
-/*
- *  linux/arch/arm/mm/arm740.S: utility functions for ARM740
- *
- *  Copyright (C) 2004-2006 Hyok S. Choi (hyok.choi at samsung.com)
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- */
-#include <linux/linkage.h>
-#include <linux/init.h>
-#include <asm/assembler.h>
-#include <asm/asm-offsets.h>
-#include <asm/hwcap.h>
-#include <asm/pgtable-hwdef.h>
-#include <asm/pgtable.h>
-#include <asm/ptrace.h>
-
-#include "proc-macros.S"
-
-	.text
-/*
- * cpu_arm740_proc_init()
- * cpu_arm740_do_idle()
- * cpu_arm740_dcache_clean_area()
- * cpu_arm740_switch_mm()
- *
- * These are not required.
- */
-ENTRY(cpu_arm740_proc_init)
-ENTRY(cpu_arm740_do_idle)
-ENTRY(cpu_arm740_dcache_clean_area)
-ENTRY(cpu_arm740_switch_mm)
-	mov	pc, lr
-
-/*
- * cpu_arm740_proc_fin()
- */
-ENTRY(cpu_arm740_proc_fin)
-	mrc	p15, 0, r0, c1, c0, 0
-	bic	r0, r0, #0x3f000000		@ bank/f/lock/s
-	bic	r0, r0, #0x0000000c		@ w-buffer/cache
-	mcr	p15, 0, r0, c1, c0, 0		@ disable caches
-	mov	pc, lr
-
-/*
- * cpu_arm740_reset(loc)
- * Params  : r0 = address to jump to
- * Notes   : This sets up everything for a reset
- */
-	.pushsection	.idmap.text, "ax"
-ENTRY(cpu_arm740_reset)
-	mov	ip, #0
-	mcr	p15, 0, ip, c7, c0, 0		@ invalidate cache
-	mrc	p15, 0, ip, c1, c0, 0		@ get ctrl register
-	bic	ip, ip, #0x0000000c		@ ............wc..
-	mcr	p15, 0, ip, c1, c0, 0		@ ctrl register
-	mov	pc, r0
-ENDPROC(cpu_arm740_reset)
-	.popsection
-
-	.type	__arm740_setup, #function
-__arm740_setup:
-	mov	r0, #0
-	mcr	p15, 0, r0, c7, c0, 0		@ invalidate caches
-
-	mcr	p15, 0, r0, c6, c3		@ disable area 3~7
-	mcr	p15, 0, r0, c6, c4
-	mcr	p15, 0, r0, c6, c5
-	mcr	p15, 0, r0, c6, c6
-	mcr	p15, 0, r0, c6, c7
-
-	mov	r0, #0x0000003F			@ base = 0, size = 4GB
-	mcr	p15, 0, r0, c6,	c0		@ set area 0, default
-
-	ldr	r0, =(CONFIG_DRAM_BASE & 0xFFFFF000) @ base[31:12] of RAM
-	ldr	r3, =(CONFIG_DRAM_SIZE >> 12)	@ size of RAM (must be >= 4KB)
-	mov	r4, #10				@ 11 is the minimum (4KB)
-1:	add	r4, r4, #1			@ area size *= 2
-	movs	r3, r3, lsr #1
-	bne	1b				@ count not zero r-shift
-	orr	r0, r0, r4, lsl #1		@ the area register value
-	orr	r0, r0, #1			@ set enable bit
-	mcr	p15, 0, r0, c6,	c1		@ set area 1, RAM
-
-	ldr	r0, =(CONFIG_FLASH_MEM_BASE & 0xFFFFF000) @ base[31:12] of FLASH
-	ldr	r3, =(CONFIG_FLASH_SIZE >> 12)	@ size of FLASH (must be >= 4KB)
-	cmp	r3, #0
-	moveq	r0, #0
-	beq	2f
-	mov	r4, #10				@ 11 is the minimum (4KB)
-1:	add	r4, r4, #1			@ area size *= 2
-	movs	r3, r3, lsr #1
-	bne	1b				@ count not zero r-shift
-	orr	r0, r0, r4, lsl #1		@ the area register value
-	orr	r0, r0, #1			@ set enable bit
-2:	mcr	p15, 0, r0, c6,	c2		@ set area 2, ROM/FLASH
-
-	mov	r0, #0x06
-	mcr	p15, 0, r0, c2, c0		@ Region 1&2 cacheable
-#ifdef CONFIG_CPU_DCACHE_WRITETHROUGH
-	mov	r0, #0x00			@ disable whole write buffer
-#else
-	mov	r0, #0x02			@ Region 1 write bufferred
-#endif
-	mcr	p15, 0, r0, c3, c0
-
-	mov	r0, #0x10000
-	sub	r0, r0, #1			@ r0 = 0xffff
-	mcr	p15, 0, r0, c5, c0		@ all read/write access
-
-	mrc	p15, 0, r0, c1, c0		@ get control register
-	bic	r0, r0, #0x3F000000		@ set to standard caching mode
-						@ need some benchmark
-	orr	r0, r0, #0x0000000d		@ MPU/Cache/WB
-
-	mov	pc, lr
-
-	.size	__arm740_setup, . - __arm740_setup
-
-	__INITDATA
-
-	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
-	define_processor_functions arm740, dabort=v4t_late_abort, pabort=legacy_pabort, nommu=1
-
-	.section ".rodata"
-
-	string	cpu_arch_name, "armv4"
-	string	cpu_elf_name, "v4"
-	string	cpu_arm740_name, "ARM740T"
-
-	.align
-
-	.section ".proc.info.init", #alloc, #execinstr
-	.type	__arm740_proc_info,#object
-__arm740_proc_info:
-	.long	0x41807400
-	.long	0xfffffff0
-	.long	0
-	.long	0
-	b	__arm740_setup
-	.long	cpu_arch_name
-	.long	cpu_elf_name
-	.long	HWCAP_SWP | HWCAP_HALF | HWCAP_THUMB | HWCAP_26BIT
-	.long	cpu_arm740_name
-	.long	arm740_processor_functions
-	.long	0
-	.long	0
-	.long	v4_cache_fns			@ cache model
-	.size	__arm740_proc_info, . - __arm740_proc_info
diff --git a/arch/arm/mm/proc-arm940.S b/arch/arm/mm/proc-arm940.S
deleted file mode 100644
index 1c39a704ff6e..000000000000
--- a/arch/arm/mm/proc-arm940.S
+++ /dev/null
@@ -1,374 +0,0 @@
-/*
- *  linux/arch/arm/mm/arm940.S: utility functions for ARM940T
- *
- *  Copyright (C) 2004-2006 Hyok S. Choi (hyok.choi at samsung.com)
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- */
-#include <linux/linkage.h>
-#include <linux/init.h>
-#include <asm/assembler.h>
-#include <asm/hwcap.h>
-#include <asm/pgtable-hwdef.h>
-#include <asm/pgtable.h>
-#include <asm/ptrace.h>
-#include "proc-macros.S"
-
-/* ARM940T has a 4KB DCache comprising 256 lines of 4 words */
-#define CACHE_DLINESIZE	16
-#define CACHE_DSEGMENTS	4
-#define CACHE_DENTRIES	64
-
-	.text
-/*
- * cpu_arm940_proc_init()
- * cpu_arm940_switch_mm()
- *
- * These are not required.
- */
-ENTRY(cpu_arm940_proc_init)
-ENTRY(cpu_arm940_switch_mm)
-	mov	pc, lr
-
-/*
- * cpu_arm940_proc_fin()
- */
-ENTRY(cpu_arm940_proc_fin)
-	mrc	p15, 0, r0, c1, c0, 0		@ ctrl register
-	bic	r0, r0, #0x00001000		@ i-cache
-	bic	r0, r0, #0x00000004		@ d-cache
-	mcr	p15, 0, r0, c1, c0, 0		@ disable caches
-	mov	pc, lr
-
-/*
- * cpu_arm940_reset(loc)
- * Params  : r0 = address to jump to
- * Notes   : This sets up everything for a reset
- */
-	.pushsection	.idmap.text, "ax"
-ENTRY(cpu_arm940_reset)
-	mov	ip, #0
-	mcr	p15, 0, ip, c7, c5, 0		@ flush I cache
-	mcr	p15, 0, ip, c7, c6, 0		@ flush D cache
-	mcr	p15, 0, ip, c7, c10, 4		@ drain WB
-	mrc	p15, 0, ip, c1, c0, 0		@ ctrl register
-	bic	ip, ip, #0x00000005		@ .............c.p
-	bic	ip, ip, #0x00001000		@ i-cache
-	mcr	p15, 0, ip, c1, c0, 0		@ ctrl register
-	mov	pc, r0
-ENDPROC(cpu_arm940_reset)
-	.popsection
-
-/*
- * cpu_arm940_do_idle()
- */
-	.align	5
-ENTRY(cpu_arm940_do_idle)
-	mcr	p15, 0, r0, c7, c0, 4		@ Wait for interrupt
-	mov	pc, lr
-
-/*
- *	flush_icache_all()
- *
- *	Unconditionally clean and invalidate the entire icache.
- */
-ENTRY(arm940_flush_icache_all)
-	mov	r0, #0
-	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I cache
-	mov	pc, lr
-ENDPROC(arm940_flush_icache_all)
-
-/*
- *	flush_user_cache_all()
- */
-ENTRY(arm940_flush_user_cache_all)
-	/* FALLTHROUGH */
-
-/*
- *	flush_kern_cache_all()
- *
- *	Clean and invalidate the entire cache.
- */
-ENTRY(arm940_flush_kern_cache_all)
-	mov	r2, #VM_EXEC
-	/* FALLTHROUGH */
-
-/*
- *	flush_user_cache_range(start, end, flags)
- *
- *	There is no efficient way to flush a range of cache entries
- *	in the specified address range. Thus, flushes all.
- *
- *	- start	- start address (inclusive)
- *	- end	- end address (exclusive)
- *	- flags	- vm_flags describing address space
- */
-ENTRY(arm940_flush_user_cache_range)
-	mov	ip, #0
-#ifdef CONFIG_CPU_DCACHE_WRITETHROUGH
-	mcr	p15, 0, ip, c7, c6, 0		@ flush D cache
-#else
-	mov	r1, #(CACHE_DSEGMENTS - 1) << 4	@ 4 segments
-1:	orr	r3, r1, #(CACHE_DENTRIES - 1) << 26 @ 64 entries
-2:	mcr	p15, 0, r3, c7, c14, 2		@ clean/flush D index
-	subs	r3, r3, #1 << 26
-	bcs	2b				@ entries 63 to 0
-	subs	r1, r1, #1 << 4
-	bcs	1b				@ segments 3 to 0
-#endif
-	tst	r2, #VM_EXEC
-	mcrne	p15, 0, ip, c7, c5, 0		@ invalidate I cache
-	mcrne	p15, 0, ip, c7, c10, 4		@ drain WB
-	mov	pc, lr
-
-/*
- *	coherent_kern_range(start, end)
- *
- *	Ensure coherency between the Icache and the Dcache in the
- *	region described by start, end.  If you have non-snooping
- *	Harvard caches, you need to implement this function.
- *
- *	- start	- virtual start address
- *	- end	- virtual end address
- */
-ENTRY(arm940_coherent_kern_range)
-	/* FALLTHROUGH */
-
-/*
- *	coherent_user_range(start, end)
- *
- *	Ensure coherency between the Icache and the Dcache in the
- *	region described by start, end.  If you have non-snooping
- *	Harvard caches, you need to implement this function.
- *
- *	- start	- virtual start address
- *	- end	- virtual end address
- */
-ENTRY(arm940_coherent_user_range)
-	/* FALLTHROUGH */
-
-/*
- *	flush_kern_dcache_area(void *addr, size_t size)
- *
- *	Ensure no D cache aliasing occurs, either with itself or
- *	the I cache
- *
- *	- addr	- kernel address
- *	- size	- region size
- */
-ENTRY(arm940_flush_kern_dcache_area)
-	mov	r0, #0
-	mov	r1, #(CACHE_DSEGMENTS - 1) << 4	@ 4 segments
-1:	orr	r3, r1, #(CACHE_DENTRIES - 1) << 26 @ 64 entries
-2:	mcr	p15, 0, r3, c7, c14, 2		@ clean/flush D index
-	subs	r3, r3, #1 << 26
-	bcs	2b				@ entries 63 to 0
-	subs	r1, r1, #1 << 4
-	bcs	1b				@ segments 7 to 0
-	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I cache
-	mcr	p15, 0, r0, c7, c10, 4		@ drain WB
-	mov	pc, lr
-
-/*
- *	dma_inv_range(start, end)
- *
- *	There is no efficient way to invalidate a specifid virtual
- *	address range. Thus, invalidates all.
- *
- *	- start	- virtual start address
- *	- end	- virtual end address
- */
-arm940_dma_inv_range:
-	mov	ip, #0
-	mov	r1, #(CACHE_DSEGMENTS - 1) << 4	@ 4 segments
-1:	orr	r3, r1, #(CACHE_DENTRIES - 1) << 26 @ 64 entries
-2:	mcr	p15, 0, r3, c7, c6, 2		@ flush D entry
-	subs	r3, r3, #1 << 26
-	bcs	2b				@ entries 63 to 0
-	subs	r1, r1, #1 << 4
-	bcs	1b				@ segments 7 to 0
-	mcr	p15, 0, ip, c7, c10, 4		@ drain WB
-	mov	pc, lr
-
-/*
- *	dma_clean_range(start, end)
- *
- *	There is no efficient way to clean a specifid virtual
- *	address range. Thus, cleans all.
- *
- *	- start	- virtual start address
- *	- end	- virtual end address
- */
-arm940_dma_clean_range:
-ENTRY(cpu_arm940_dcache_clean_area)
-	mov	ip, #0
-#ifndef CONFIG_CPU_DCACHE_WRITETHROUGH
-	mov	r1, #(CACHE_DSEGMENTS - 1) << 4	@ 4 segments
-1:	orr	r3, r1, #(CACHE_DENTRIES - 1) << 26 @ 64 entries
-2:	mcr	p15, 0, r3, c7, c10, 2		@ clean D entry
-	subs	r3, r3, #1 << 26
-	bcs	2b				@ entries 63 to 0
-	subs	r1, r1, #1 << 4
-	bcs	1b				@ segments 7 to 0
-#endif
-	mcr	p15, 0, ip, c7, c10, 4		@ drain WB
-	mov	pc, lr
-
-/*
- *	dma_flush_range(start, end)
- *
- *	There is no efficient way to clean and invalidate a specifid
- *	virtual address range.
- *
- *	- start	- virtual start address
- *	- end	- virtual end address
- */
-ENTRY(arm940_dma_flush_range)
-	mov	ip, #0
-	mov	r1, #(CACHE_DSEGMENTS - 1) << 4	@ 4 segments
-1:	orr	r3, r1, #(CACHE_DENTRIES - 1) << 26 @ 64 entries
-2:
-#ifndef CONFIG_CPU_DCACHE_WRITETHROUGH
-	mcr	p15, 0, r3, c7, c14, 2		@ clean/flush D entry
-#else
-	mcr	p15, 0, r3, c7, c6, 2		@ invalidate D entry
-#endif
-	subs	r3, r3, #1 << 26
-	bcs	2b				@ entries 63 to 0
-	subs	r1, r1, #1 << 4
-	bcs	1b				@ segments 7 to 0
-	mcr	p15, 0, ip, c7, c10, 4		@ drain WB
-	mov	pc, lr
-
-/*
- *	dma_map_area(start, size, dir)
- *	- start	- kernel virtual start address
- *	- size	- size of region
- *	- dir	- DMA direction
- */
-ENTRY(arm940_dma_map_area)
-	add	r1, r1, r0
-	cmp	r2, #DMA_TO_DEVICE
-	beq	arm940_dma_clean_range
-	bcs	arm940_dma_inv_range
-	b	arm940_dma_flush_range
-ENDPROC(arm940_dma_map_area)
-
-/*
- *	dma_unmap_area(start, size, dir)
- *	- start	- kernel virtual start address
- *	- size	- size of region
- *	- dir	- DMA direction
- */
-ENTRY(arm940_dma_unmap_area)
-	mov	pc, lr
-ENDPROC(arm940_dma_unmap_area)
-
-	.globl	arm940_flush_kern_cache_louis
-	.equ	arm940_flush_kern_cache_louis, arm940_flush_kern_cache_all
-
-	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
-	define_cache_functions arm940
-
-	.type	__arm940_setup, #function
-__arm940_setup:
-	mov	r0, #0
-	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I cache
-	mcr	p15, 0, r0, c7, c6, 0		@ invalidate D cache
-	mcr	p15, 0, r0, c7, c10, 4		@ drain WB
-
-	mcr	p15, 0, r0, c6, c3, 0		@ disable data area 3~7
-	mcr	p15, 0, r0, c6, c4, 0
-	mcr	p15, 0, r0, c6, c5, 0
-	mcr	p15, 0, r0, c6, c6, 0
-	mcr	p15, 0, r0, c6, c7, 0
-
-	mcr	p15, 0, r0, c6, c3, 1		@ disable instruction area 3~7
-	mcr	p15, 0, r0, c6, c4, 1
-	mcr	p15, 0, r0, c6, c5, 1
-	mcr	p15, 0, r0, c6, c6, 1
-	mcr	p15, 0, r0, c6, c7, 1
-
-	mov	r0, #0x0000003F			@ base = 0, size = 4GB
-	mcr	p15, 0, r0, c6,	c0, 0		@ set area 0, default
-	mcr	p15, 0, r0, c6,	c0, 1
-
-	ldr	r0, =(CONFIG_DRAM_BASE & 0xFFFFF000) @ base[31:12] of RAM
-	ldr	r1, =(CONFIG_DRAM_SIZE >> 12)	@ size of RAM (must be >= 4KB)
-	mov	r2, #10				@ 11 is the minimum (4KB)
-1:	add	r2, r2, #1			@ area size *= 2
-	mov	r1, r1, lsr #1
-	bne	1b				@ count not zero r-shift
-	orr	r0, r0, r2, lsl #1		@ the area register value
-	orr	r0, r0, #1			@ set enable bit
-	mcr	p15, 0, r0, c6,	c1, 0		@ set area 1, RAM
-	mcr	p15, 0, r0, c6,	c1, 1
-
-	ldr	r0, =(CONFIG_FLASH_MEM_BASE & 0xFFFFF000) @ base[31:12] of FLASH
-	ldr	r1, =(CONFIG_FLASH_SIZE >> 12)	@ size of FLASH (must be >= 4KB)
-	mov	r2, #10				@ 11 is the minimum (4KB)
-1:	add	r2, r2, #1			@ area size *= 2
-	mov	r1, r1, lsr #1
-	bne	1b				@ count not zero r-shift
-	orr	r0, r0, r2, lsl #1		@ the area register value
-	orr	r0, r0, #1			@ set enable bit
-	mcr	p15, 0, r0, c6,	c2, 0		@ set area 2, ROM/FLASH
-	mcr	p15, 0, r0, c6,	c2, 1
-
-	mov	r0, #0x06
-	mcr	p15, 0, r0, c2, c0, 0		@ Region 1&2 cacheable
-	mcr	p15, 0, r0, c2, c0, 1
-#ifdef CONFIG_CPU_DCACHE_WRITETHROUGH
-	mov	r0, #0x00			@ disable whole write buffer
-#else
-	mov	r0, #0x02			@ Region 1 write bufferred
-#endif
-	mcr	p15, 0, r0, c3, c0, 0
-
-	mov	r0, #0x10000
-	sub	r0, r0, #1			@ r0 = 0xffff
-	mcr	p15, 0, r0, c5, c0, 0		@ all read/write access
-	mcr	p15, 0, r0, c5, c0, 1
-
-	mrc	p15, 0, r0, c1, c0		@ get control register
-	orr	r0, r0, #0x00001000		@ I-cache
-	orr	r0, r0, #0x00000005		@ MPU/D-cache
-
-	mov	pc, lr
-
-	.size	__arm940_setup, . - __arm940_setup
-
-	__INITDATA
-
-	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
-	define_processor_functions arm940, dabort=nommu_early_abort, pabort=legacy_pabort, nommu=1
-
-	.section ".rodata"
-
-	string	cpu_arch_name, "armv4t"
-	string	cpu_elf_name, "v4"
-	string	cpu_arm940_name, "ARM940T"
-
-	.align
-
-	.section ".proc.info.init", #alloc, #execinstr
-
-	.type	__arm940_proc_info,#object
-__arm940_proc_info:
-	.long	0x41009400
-	.long	0xff00fff0
-	.long	0
-	b	__arm940_setup
-	.long	cpu_arch_name
-	.long	cpu_elf_name
-	.long	HWCAP_SWP | HWCAP_HALF | HWCAP_THUMB
-	.long	cpu_arm940_name
-	.long	arm940_processor_functions
-	.long	0
-	.long	0
-	.long	arm940_cache_fns
-	.size	__arm940_proc_info, . - __arm940_proc_info
-
diff --git a/arch/arm/mm/proc-arm946.S b/arch/arm/mm/proc-arm946.S
deleted file mode 100644
index 0289cd905e73..000000000000
--- a/arch/arm/mm/proc-arm946.S
+++ /dev/null
@@ -1,429 +0,0 @@
-/*
- *  linux/arch/arm/mm/arm946.S: utility functions for ARM946E-S
- *
- *  Copyright (C) 2004-2006 Hyok S. Choi (hyok.choi at samsung.com)
- *
- *  (Many of cache codes are from proc-arm926.S)
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- */
-#include <linux/linkage.h>
-#include <linux/init.h>
-#include <asm/assembler.h>
-#include <asm/hwcap.h>
-#include <asm/pgtable-hwdef.h>
-#include <asm/pgtable.h>
-#include <asm/ptrace.h>
-#include "proc-macros.S"
-
-/*
- * ARM946E-S is synthesizable to have 0KB to 1MB sized D-Cache,
- * comprising 256 lines of 32 bytes (8 words).
- */
-#define CACHE_DSIZE	(CONFIG_CPU_DCACHE_SIZE) /* typically 8KB. */
-#define CACHE_DLINESIZE	32			/* fixed */
-#define CACHE_DSEGMENTS	4			/* fixed */
-#define CACHE_DENTRIES	(CACHE_DSIZE / CACHE_DSEGMENTS / CACHE_DLINESIZE)
-#define CACHE_DLIMIT	(CACHE_DSIZE * 4)	/* benchmark needed */
-
-	.text
-/*
- * cpu_arm946_proc_init()
- * cpu_arm946_switch_mm()
- *
- * These are not required.
- */
-ENTRY(cpu_arm946_proc_init)
-ENTRY(cpu_arm946_switch_mm)
-	mov	pc, lr
-
-/*
- * cpu_arm946_proc_fin()
- */
-ENTRY(cpu_arm946_proc_fin)
-	mrc	p15, 0, r0, c1, c0, 0		@ ctrl register
-	bic	r0, r0, #0x00001000		@ i-cache
-	bic	r0, r0, #0x00000004		@ d-cache
-	mcr	p15, 0, r0, c1, c0, 0		@ disable caches
-	mov	pc, lr
-
-/*
- * cpu_arm946_reset(loc)
- * Params  : r0 = address to jump to
- * Notes   : This sets up everything for a reset
- */
-	.pushsection	.idmap.text, "ax"
-ENTRY(cpu_arm946_reset)
-	mov	ip, #0
-	mcr	p15, 0, ip, c7, c5, 0		@ flush I cache
-	mcr	p15, 0, ip, c7, c6, 0		@ flush D cache
-	mcr	p15, 0, ip, c7, c10, 4		@ drain WB
-	mrc	p15, 0, ip, c1, c0, 0		@ ctrl register
-	bic	ip, ip, #0x00000005		@ .............c.p
-	bic	ip, ip, #0x00001000		@ i-cache
-	mcr	p15, 0, ip, c1, c0, 0		@ ctrl register
-	mov	pc, r0
-ENDPROC(cpu_arm946_reset)
-	.popsection
-
-/*
- * cpu_arm946_do_idle()
- */
-	.align	5
-ENTRY(cpu_arm946_do_idle)
-	mcr	p15, 0, r0, c7, c0, 4		@ Wait for interrupt
-	mov	pc, lr
-
-/*
- *	flush_icache_all()
- *
- *	Unconditionally clean and invalidate the entire icache.
- */
-ENTRY(arm946_flush_icache_all)
-	mov	r0, #0
-	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I cache
-	mov	pc, lr
-ENDPROC(arm946_flush_icache_all)
-
-/*
- *	flush_user_cache_all()
- */
-ENTRY(arm946_flush_user_cache_all)
-	/* FALLTHROUGH */
-
-/*
- *	flush_kern_cache_all()
- *
- *	Clean and invalidate the entire cache.
- */
-ENTRY(arm946_flush_kern_cache_all)
-	mov	r2, #VM_EXEC
-	mov	ip, #0
-__flush_whole_cache:
-#ifdef CONFIG_CPU_DCACHE_WRITETHROUGH
-	mcr	p15, 0, ip, c7, c6, 0		@ flush D cache
-#else
-	mov	r1, #(CACHE_DSEGMENTS - 1) << 29 @ 4 segments
-1:	orr	r3, r1, #(CACHE_DENTRIES - 1) << 4 @ n entries
-2:	mcr	p15, 0, r3, c7, c14, 2		@ clean/flush D index
-	subs	r3, r3, #1 << 4
-	bcs	2b				@ entries n to 0
-	subs	r1, r1, #1 << 29
-	bcs	1b				@ segments 3 to 0
-#endif
-	tst	r2, #VM_EXEC
-	mcrne	p15, 0, ip, c7, c5, 0		@ flush I cache
-	mcrne	p15, 0, ip, c7, c10, 4		@ drain WB
-	mov	pc, lr
-
-/*
- *	flush_user_cache_range(start, end, flags)
- *
- *	Clean and invalidate a range of cache entries in the
- *	specified address range.
- *
- *	- start	- start address (inclusive)
- *	- end	- end address (exclusive)
- *	- flags	- vm_flags describing address space
- * (same as arm926)
- */
-ENTRY(arm946_flush_user_cache_range)
-	mov	ip, #0
-	sub	r3, r1, r0			@ calculate total size
-	cmp	r3, #CACHE_DLIMIT
-	bhs	__flush_whole_cache
-
-1:	tst	r2, #VM_EXEC
-#ifdef CONFIG_CPU_DCACHE_WRITETHROUGH
-	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D entry
-	mcrne	p15, 0, r0, c7, c5, 1		@ invalidate I entry
-	add	r0, r0, #CACHE_DLINESIZE
-	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D entry
-	mcrne	p15, 0, r0, c7, c5, 1		@ invalidate I entry
-	add	r0, r0, #CACHE_DLINESIZE
-#else
-	mcr	p15, 0, r0, c7, c14, 1		@ clean and invalidate D entry
-	mcrne	p15, 0, r0, c7, c5, 1		@ invalidate I entry
-	add	r0, r0, #CACHE_DLINESIZE
-	mcr	p15, 0, r0, c7, c14, 1		@ clean and invalidate D entry
-	mcrne	p15, 0, r0, c7, c5, 1		@ invalidate I entry
-	add	r0, r0, #CACHE_DLINESIZE
-#endif
-	cmp	r0, r1
-	blo	1b
-	tst	r2, #VM_EXEC
-	mcrne	p15, 0, ip, c7, c10, 4		@ drain WB
-	mov	pc, lr
-
-/*
- *	coherent_kern_range(start, end)
- *
- *	Ensure coherency between the Icache and the Dcache in the
- *	region described by start, end.  If you have non-snooping
- *	Harvard caches, you need to implement this function.
- *
- *	- start	- virtual start address
- *	- end	- virtual end address
- */
-ENTRY(arm946_coherent_kern_range)
-	/* FALLTHROUGH */
-
-/*
- *	coherent_user_range(start, end)
- *
- *	Ensure coherency between the Icache and the Dcache in the
- *	region described by start, end.  If you have non-snooping
- *	Harvard caches, you need to implement this function.
- *
- *	- start	- virtual start address
- *	- end	- virtual end address
- * (same as arm926)
- */
-ENTRY(arm946_coherent_user_range)
-	bic	r0, r0, #CACHE_DLINESIZE - 1
-1:	mcr	p15, 0, r0, c7, c10, 1		@ clean D entry
-	mcr	p15, 0, r0, c7, c5, 1		@ invalidate I entry
-	add	r0, r0, #CACHE_DLINESIZE
-	cmp	r0, r1
-	blo	1b
-	mcr	p15, 0, r0, c7, c10, 4		@ drain WB
-	mov	r0, #0
-	mov	pc, lr
-
-/*
- *	flush_kern_dcache_area(void *addr, size_t size)
- *
- *	Ensure no D cache aliasing occurs, either with itself or
- *	the I cache
- *
- *	- addr	- kernel address
- *	- size	- region size
- * (same as arm926)
- */
-ENTRY(arm946_flush_kern_dcache_area)
-	add	r1, r0, r1
-1:	mcr	p15, 0, r0, c7, c14, 1		@ clean+invalidate D entry
-	add	r0, r0, #CACHE_DLINESIZE
-	cmp	r0, r1
-	blo	1b
-	mov	r0, #0
-	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I cache
-	mcr	p15, 0, r0, c7, c10, 4		@ drain WB
-	mov	pc, lr
-
-/*
- *	dma_inv_range(start, end)
- *
- *	Invalidate (discard) the specified virtual address range.
- *	May not write back any entries.  If 'start' or 'end'
- *	are not cache line aligned, those lines must be written
- *	back.
- *
- *	- start	- virtual start address
- *	- end	- virtual end address
- * (same as arm926)
- */
-arm946_dma_inv_range:
-#ifndef CONFIG_CPU_DCACHE_WRITETHROUGH
-	tst	r0, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r0, c7, c10, 1		@ clean D entry
-	tst	r1, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r1, c7, c10, 1		@ clean D entry
-#endif
-	bic	r0, r0, #CACHE_DLINESIZE - 1
-1:	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D entry
-	add	r0, r0, #CACHE_DLINESIZE
-	cmp	r0, r1
-	blo	1b
-	mcr	p15, 0, r0, c7, c10, 4		@ drain WB
-	mov	pc, lr
-
-/*
- *	dma_clean_range(start, end)
- *
- *	Clean the specified virtual address range.
- *
- *	- start	- virtual start address
- *	- end	- virtual end address
- *
- * (same as arm926)
- */
-arm946_dma_clean_range:
-#ifndef CONFIG_CPU_DCACHE_WRITETHROUGH
-	bic	r0, r0, #CACHE_DLINESIZE - 1
-1:	mcr	p15, 0, r0, c7, c10, 1		@ clean D entry
-	add	r0, r0, #CACHE_DLINESIZE
-	cmp	r0, r1
-	blo	1b
-#endif
-	mcr	p15, 0, r0, c7, c10, 4		@ drain WB
-	mov	pc, lr
-
-/*
- *	dma_flush_range(start, end)
- *
- *	Clean and invalidate the specified virtual address range.
- *
- *	- start	- virtual start address
- *	- end	- virtual end address
- *
- * (same as arm926)
- */
-ENTRY(arm946_dma_flush_range)
-	bic	r0, r0, #CACHE_DLINESIZE - 1
-1:
-#ifndef CONFIG_CPU_DCACHE_WRITETHROUGH
-	mcr	p15, 0, r0, c7, c14, 1		@ clean+invalidate D entry
-#else
-	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D entry
-#endif
-	add	r0, r0, #CACHE_DLINESIZE
-	cmp	r0, r1
-	blo	1b
-	mcr	p15, 0, r0, c7, c10, 4		@ drain WB
-	mov	pc, lr
-
-/*
- *	dma_map_area(start, size, dir)
- *	- start	- kernel virtual start address
- *	- size	- size of region
- *	- dir	- DMA direction
- */
-ENTRY(arm946_dma_map_area)
-	add	r1, r1, r0
-	cmp	r2, #DMA_TO_DEVICE
-	beq	arm946_dma_clean_range
-	bcs	arm946_dma_inv_range
-	b	arm946_dma_flush_range
-ENDPROC(arm946_dma_map_area)
-
-/*
- *	dma_unmap_area(start, size, dir)
- *	- start	- kernel virtual start address
- *	- size	- size of region
- *	- dir	- DMA direction
- */
-ENTRY(arm946_dma_unmap_area)
-	mov	pc, lr
-ENDPROC(arm946_dma_unmap_area)
-
-	.globl	arm946_flush_kern_cache_louis
-	.equ	arm946_flush_kern_cache_louis, arm946_flush_kern_cache_all
-
-	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
-	define_cache_functions arm946
-
-ENTRY(cpu_arm946_dcache_clean_area)
-#ifndef CONFIG_CPU_DCACHE_WRITETHROUGH
-1:	mcr	p15, 0, r0, c7, c10, 1		@ clean D entry
-	add	r0, r0, #CACHE_DLINESIZE
-	subs	r1, r1, #CACHE_DLINESIZE
-	bhi	1b
-#endif
-	mcr	p15, 0, r0, c7, c10, 4		@ drain WB
-	mov	pc, lr
-
-	.type	__arm946_setup, #function
-__arm946_setup:
-	mov	r0, #0
-	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I cache
-	mcr	p15, 0, r0, c7, c6, 0		@ invalidate D cache
-	mcr	p15, 0, r0, c7, c10, 4		@ drain WB
-
-	mcr	p15, 0, r0, c6, c3, 0		@ disable memory region 3~7
-	mcr	p15, 0, r0, c6, c4, 0
-	mcr	p15, 0, r0, c6, c5, 0
-	mcr	p15, 0, r0, c6, c6, 0
-	mcr	p15, 0, r0, c6, c7, 0
-
-	mov	r0, #0x0000003F			@ base = 0, size = 4GB
-	mcr	p15, 0, r0, c6,	c0, 0		@ set region 0, default
-
-	ldr	r0, =(CONFIG_DRAM_BASE & 0xFFFFF000) @ base[31:12] of RAM
-	ldr	r1, =(CONFIG_DRAM_SIZE >> 12)	@ size of RAM (must be >= 4KB)
-	mov	r2, #10				@ 11 is the minimum (4KB)
-1:	add	r2, r2, #1			@ area size *= 2
-	mov	r1, r1, lsr #1
-	bne	1b				@ count not zero r-shift
-	orr	r0, r0, r2, lsl #1		@ the region register value
-	orr	r0, r0, #1			@ set enable bit
-	mcr	p15, 0, r0, c6,	c1, 0		@ set region 1, RAM
-
-	ldr	r0, =(CONFIG_FLASH_MEM_BASE & 0xFFFFF000) @ base[31:12] of FLASH
-	ldr	r1, =(CONFIG_FLASH_SIZE >> 12)	@ size of FLASH (must be >= 4KB)
-	mov	r2, #10				@ 11 is the minimum (4KB)
-1:	add	r2, r2, #1			@ area size *= 2
-	mov	r1, r1, lsr #1
-	bne	1b				@ count not zero r-shift
-	orr	r0, r0, r2, lsl #1		@ the region register value
-	orr	r0, r0, #1			@ set enable bit
-	mcr	p15, 0, r0, c6,	c2, 0		@ set region 2, ROM/FLASH
-
-	mov	r0, #0x06
-	mcr	p15, 0, r0, c2, c0, 0		@ region 1,2 d-cacheable
-	mcr	p15, 0, r0, c2, c0, 1		@ region 1,2 i-cacheable
-#ifdef CONFIG_CPU_DCACHE_WRITETHROUGH
-	mov	r0, #0x00			@ disable whole write buffer
-#else
-	mov	r0, #0x02			@ region 1 write bufferred
-#endif
-	mcr	p15, 0, r0, c3, c0, 0
-
-/*
- *  Access Permission Settings for future permission control by PU.
- *
- *				priv.	user
- * 	region 0 (whole)	rw	--	: b0001
- * 	region 1 (RAM)		rw	rw	: b0011
- * 	region 2 (FLASH)	rw	r-	: b0010
- *	region 3~7 (none)	--	--	: b0000
- */
-	mov	r0, #0x00000031
-	orr	r0, r0, #0x00000200
-	mcr	p15, 0, r0, c5, c0, 2		@ set data access permission
-	mcr	p15, 0, r0, c5, c0, 3		@ set inst. access permission
-
-	mrc	p15, 0, r0, c1, c0		@ get control register
-	orr	r0, r0, #0x00001000		@ I-cache
-	orr	r0, r0, #0x00000005		@ MPU/D-cache
-#ifdef CONFIG_CPU_CACHE_ROUND_ROBIN
-	orr	r0, r0, #0x00004000		@ .1.. .... .... ....
-#endif
-	mov	pc, lr
-
-	.size	__arm946_setup, . - __arm946_setup
-
-	__INITDATA
-
-	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
-	define_processor_functions arm946, dabort=nommu_early_abort, pabort=legacy_pabort, nommu=1
-
-	.section ".rodata"
-
-	string	cpu_arch_name, "armv5te"
-	string	cpu_elf_name, "v5t"
-	string	cpu_arm946_name, "ARM946E-S"
-
-	.align
-
-	.section ".proc.info.init", #alloc, #execinstr
-	.type	__arm946_proc_info,#object
-__arm946_proc_info:
-	.long	0x41009460
-	.long	0xff00fff0
-	.long	0
-	.long	0
-	b	__arm946_setup
-	.long	cpu_arch_name
-	.long	cpu_elf_name
-	.long	HWCAP_SWP | HWCAP_HALF | HWCAP_THUMB
-	.long	cpu_arm946_name
-	.long	arm946_processor_functions
-	.long	0
-	.long	0
-	.long	arm946_cache_fns
-	.size	__arm946_proc_info, . - __arm946_proc_info
-
-- 
2.0.0.rc2
