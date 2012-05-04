From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 May 2012 10:56:45 +0100
Subject: [RFC] Remove support for ARMv3 ARM610 and ARM710 CPUs
Message-ID: <20120504095645.GD26481@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes support for ARMv3 CPUs, which haven't worked properly
for quite some time (see the FIXME comment in arch/arm/mm/fault.c).  The
only V3 parts left is the cache model for ARMv3, which is needed for some
odd reason by ARM740T CPUs, and being able to build with -march=armv3,
which is required for the RiscPC platform due to its bus structure.

What this patch shows is how well abstracted the ARMv3 support is.
Apart from removing the multi-support selection conditionals in the
glue-*.h and similar files, and the ARM710 hack in entry-common.S,
ARMv3 support does not affect any other core code files.  That flies
directly in the face of people who whinge and moan about ARMv3 support
being painful in the kernel; if it's soo well abstracted then it isn't
being a problem.

So, after this commit, the only ARMv3 specific code left is
arch/arm/mm/cache-v3.S and its selection in asm/glue-cache.h.

Irrespective of the whingers, I think this is something we should do,
because it has been broken at runtime for quite some time and no one
has shown any interest in it.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Makefile                |    2 -
 arch/arm/configs/rpc_defconfig   |    2 -
 arch/arm/include/asm/glue-df.h   |    8 -
 arch/arm/include/asm/glue-proc.h |   18 --
 arch/arm/include/asm/page.h      |    9 -
 arch/arm/include/asm/tlbflush.h  |   15 -
 arch/arm/kernel/entry-armv.S     |    4 -
 arch/arm/kernel/entry-common.S   |   28 --
 arch/arm/lib/Makefile            |   23 +--
 arch/arm/lib/io-readsw-armv3.S   |  106 -------
 arch/arm/lib/io-writesw-armv3.S  |  126 ---------
 arch/arm/lib/uaccess.S           |  564 --------------------------------------
 arch/arm/mm/Kconfig              |   46 +---
 arch/arm/mm/Makefile             |    4 -
 arch/arm/mm/copypage-v3.c        |   81 ------
 arch/arm/mm/fault.c              |    3 -
 arch/arm/mm/proc-arm6_7.S        |  327 ----------------------
 arch/arm/mm/tlb-v3.S             |   48 ----
 18 files changed, 4 insertions(+), 1410 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 047a207..aaf96bc 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -70,8 +70,6 @@ arch-$(CONFIG_CPU_32v4)		:=-D__LINUX_ARM_ARCH__=4 -march=armv4
 arch-$(CONFIG_CPU_32v3)		:=-D__LINUX_ARM_ARCH__=3 -march=armv3
 
 # This selects how we optimise for the processor.
-tune-$(CONFIG_CPU_ARM610)	:=-mtune=arm610
-tune-$(CONFIG_CPU_ARM710)	:=-mtune=arm710
 tune-$(CONFIG_CPU_ARM7TDMI)	:=-mtune=arm7tdmi
 tune-$(CONFIG_CPU_ARM720T)	:=-mtune=arm7tdmi
 tune-$(CONFIG_CPU_ARM740T)	:=-mtune=arm7tdmi
diff --git a/arch/arm/configs/rpc_defconfig b/arch/arm/configs/rpc_defconfig
index af278f7..00515ef 100644
--- a/arch/arm/configs/rpc_defconfig
+++ b/arch/arm/configs/rpc_defconfig
@@ -8,8 +8,6 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_ARCH_RPC=y
-CONFIG_CPU_ARM610=y
-CONFIG_CPU_ARM710=y
 CONFIG_CPU_SA110=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
diff --git a/arch/arm/include/asm/glue-df.h b/arch/arm/include/asm/glue-df.h
index 354d571..8cacbcd 100644
--- a/arch/arm/include/asm/glue-df.h
+++ b/arch/arm/include/asm/glue-df.h
@@ -31,14 +31,6 @@
 #undef CPU_DABORT_HANDLER
 #undef MULTI_DABORT
 
-#if defined(CONFIG_CPU_ARM610)
-# ifdef CPU_DABORT_HANDLER
-#  define MULTI_DABORT 1
-# else
-#  define CPU_DABORT_HANDLER cpu_arm6_data_abort
-# endif
-#endif
-
 #if defined(CONFIG_CPU_ARM710)
 # ifdef CPU_DABORT_HANDLER
 #  define MULTI_DABORT 1
diff --git a/arch/arm/include/asm/glue-proc.h b/arch/arm/include/asm/glue-proc.h
index e2be7f1..ac1dd54 100644
--- a/arch/arm/include/asm/glue-proc.h
+++ b/arch/arm/include/asm/glue-proc.h
@@ -23,15 +23,6 @@
  * CPU_NAME - the prefix for CPU related functions
  */
 
-#ifdef CONFIG_CPU_ARM610
-# ifdef CPU_NAME
-#  undef  MULTI_CPU
-#  define MULTI_CPU
-# else
-#  define CPU_NAME cpu_arm6
-# endif
-#endif
-
 #ifdef CONFIG_CPU_ARM7TDMI
 # ifdef CPU_NAME
 #  undef  MULTI_CPU
@@ -41,15 +32,6 @@
 # endif
 #endif
 
-#ifdef CONFIG_CPU_ARM710
-# ifdef CPU_NAME
-#  undef  MULTI_CPU
-#  define MULTI_CPU
-# else
-#  define CPU_NAME cpu_arm7
-# endif
-#endif
-
 #ifdef CONFIG_CPU_ARM720T
 # ifdef CPU_NAME
 #  undef  MULTI_CPU
diff --git a/arch/arm/include/asm/page.h b/arch/arm/include/asm/page.h
index 5838361..ecf9019 100644
--- a/arch/arm/include/asm/page.h
+++ b/arch/arm/include/asm/page.h
@@ -34,7 +34,6 @@
  *	processor(s) we're building for.
  *
  *	We have the following to choose from:
- *	  v3		- ARMv3
  *	  v4wt		- ARMv4 with writethrough cache, without minicache
  *	  v4wb		- ARMv4 with writeback cache, without minicache
  *	  v4_mc		- ARMv4 with minicache
@@ -44,14 +43,6 @@
 #undef _USER
 #undef MULTI_USER
 
-#ifdef CONFIG_CPU_COPY_V3
-# ifdef _USER
-#  define MULTI_USER 1
-# else
-#  define _USER v3
-# endif
-#endif
-
 #ifdef CONFIG_CPU_COPY_V4WT
 # ifdef _USER
 #  define MULTI_USER 1
diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
index 85fe61e..984c70e 100644
--- a/arch/arm/include/asm/tlbflush.h
+++ b/arch/arm/include/asm/tlbflush.h
@@ -65,21 +65,6 @@
 #define MULTI_TLB 1
 #endif
 
-#define v3_tlb_flags	(TLB_V3_FULL | TLB_V3_PAGE)
-
-#ifdef CONFIG_CPU_TLB_V3
-# define v3_possible_flags	v3_tlb_flags
-# define v3_always_flags	v3_tlb_flags
-# ifdef _TLB
-#  define MULTI_TLB 1
-# else
-#  define _TLB v3
-# endif
-#else
-# define v3_possible_flags	0
-# define v3_always_flags	(-1UL)
-#endif
-
 #define v4_tlb_flags	(TLB_V4_U_FULL | TLB_V4_U_PAGE)
 
 #ifdef CONFIG_CPU_TLB_V4WT
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 7fd3ad0..437f0c4 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -556,10 +556,6 @@ call_fpe:
 #endif
 	tst	r0, #0x08000000			@ only CDP/CPRT/LDC/STC have bit 27
 	tstne	r0, #0x04000000			@ bit 26 set on both ARM and Thumb-2
-#if defined(CONFIG_CPU_ARM610) || defined(CONFIG_CPU_ARM710)
-	and	r8, r0, #0x0f000000		@ mask out op-code bits
-	teqne	r8, #0x0f000000			@ SWI (ARM6/7 bug)?
-#endif
 	moveq	pc, lr
 	get_thread_info r10			@ get current thread
 	and	r8, r0, #0x00000f00		@ mask out CP number
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 54ee265..7bd2d3c 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -335,20 +335,6 @@ ENDPROC(ftrace_stub)
  *-----------------------------------------------------------------------------
  */
 
-	/* If we're optimising for StrongARM the resulting code won't 
-	   run on an ARM7 and we can save a couple of instructions.  
-								--pb */
-#ifdef CONFIG_CPU_ARM710
-#define A710(code...) code
-.Larm710bug:
-	ldmia	sp, {r0 - lr}^			@ Get calling r0 - lr
-	mov	r0, r0
-	add	sp, sp, #S_FRAME_SIZE
-	subs	pc, lr, #4
-#else
-#define A710(code...)
-#endif
-
 	.align	5
 ENTRY(vector_swi)
 	sub	sp, sp, #S_FRAME_SIZE
@@ -379,9 +365,6 @@ ENTRY(vector_swi)
 	ldreq	r10, [lr, #-4]			@ get SWI instruction
 #else
 	ldr	r10, [lr, #-4]			@ get SWI instruction
-  A710(	and	ip, r10, #0x0f000000		@ check for SWI		)
-  A710(	teq	ip, #0x0f000000						)
-  A710(	bne	.Larm710bug						)
 #endif
 #ifdef CONFIG_CPU_ENDIAN_BE8
 	rev	r10, r10			@ little endian instruction
@@ -392,26 +375,15 @@ ENTRY(vector_swi)
 	/*
 	 * Pure EABI user space always put syscall number into scno (r7).
 	 */
-  A710(	ldr	ip, [lr, #-4]			@ get SWI instruction	)
-  A710(	and	ip, ip, #0x0f000000		@ check for SWI		)
-  A710(	teq	ip, #0x0f000000						)
-  A710(	bne	.Larm710bug						)
-
 #elif defined(CONFIG_ARM_THUMB)
-
 	/* Legacy ABI only, possibly thumb mode. */
 	tst	r8, #PSR_T_BIT			@ this is SPSR from save_user_regs
 	addne	scno, r7, #__NR_SYSCALL_BASE	@ put OS number in
 	ldreq	scno, [lr, #-4]
 
 #else
-
 	/* Legacy ABI only. */
 	ldr	scno, [lr, #-4]			@ get SWI instruction
-  A710(	and	ip, scno, #0x0f000000		@ check for SWI		)
-  A710(	teq	ip, #0x0f000000						)
-  A710(	bne	.Larm710bug						)
-
 #endif
 
 #ifdef CONFIG_ALIGNMENT_TRAP
diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index 0ade0ac..992769a 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -17,30 +17,13 @@ lib-y		:= backtrace.o changebit.o csumipv6.o csumpartial.o   \
 		   call_with_stack.o
 
 mmu-y	:= clear_user.o copy_page.o getuser.o putuser.o
-
-# the code in uaccess.S is not preemption safe and
-# probably faster on ARMv3 only
-ifeq ($(CONFIG_PREEMPT),y)
-  mmu-y	+= copy_from_user.o copy_to_user.o
-else
-ifneq ($(CONFIG_CPU_32v3),y)
-  mmu-y	+= copy_from_user.o copy_to_user.o
-else
-  mmu-y	+= uaccess.o
-endif
-endif
+mmu-y	+= copy_from_user.o copy_to_user.o
 
 # using lib_ here won't override already available weak symbols
 obj-$(CONFIG_UACCESS_WITH_MEMCPY) += uaccess_with_memcpy.o
 
-lib-$(CONFIG_MMU) += $(mmu-y)
-
-ifeq ($(CONFIG_CPU_32v3),y)
-  lib-y	+= io-readsw-armv3.o io-writesw-armv3.o
-else
-  lib-y	+= io-readsw-armv4.o io-writesw-armv4.o
-endif
-
+lib-$(CONFIG_MMU)		+= $(mmu-y)
+lib-y				+= io-readsw-armv4.o io-writesw-armv4.o
 lib-$(CONFIG_ARCH_RPC)		+= ecard.o io-acorn.o floppydma.o
 lib-$(CONFIG_ARCH_SHARK)	+= io-shark.o
 
diff --git a/arch/arm/lib/io-readsw-armv3.S b/arch/arm/lib/io-readsw-armv3.S
deleted file mode 100644
index 88487c8..0000000
--- a/arch/arm/lib/io-readsw-armv3.S
+++ /dev/null
@@ -1,106 +0,0 @@
-/*
- *  linux/arch/arm/lib/io-readsw-armv3.S
- *
- *  Copyright (C) 1995-2000 Russell King
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/linkage.h>
-#include <asm/assembler.h>
-
-.Linsw_bad_alignment:
-		adr	r0, .Linsw_bad_align_msg
-		mov	r2, lr
-		b	panic
-.Linsw_bad_align_msg:
-		.asciz	"insw: bad buffer alignment (0x%p, lr=0x%08lX)\n"
-		.align
-
-.Linsw_align:	tst	r1, #1
-		bne	.Linsw_bad_alignment
-
-		ldr	r3, [r0]
-		strb	r3, [r1], #1
-		mov	r3, r3, lsr #8
-		strb	r3, [r1], #1
-
-		subs	r2, r2, #1
-		moveq	pc, lr
-
-ENTRY(__raw_readsw)
-		teq	r2, #0		@ do we have to check for the zero len?
-		moveq	pc, lr
-		tst	r1, #3
-		bne	.Linsw_align
-
-.Linsw_aligned:	mov	ip, #0xff
-		orr	ip, ip, ip, lsl #8
-		stmfd	sp!, {r4, r5, r6, lr}
-
-		subs	r2, r2, #8
-		bmi	.Lno_insw_8
-
-.Linsw_8_lp:	ldr	r3, [r0]
-		and	r3, r3, ip
-		ldr	r4, [r0]
-		orr	r3, r3, r4, lsl #16
-
-		ldr	r4, [r0]
-		and	r4, r4, ip
-		ldr	r5, [r0]
-		orr	r4, r4, r5, lsl #16
-
-		ldr	r5, [r0]
-		and	r5, r5, ip
-		ldr	r6, [r0]
-		orr	r5, r5, r6, lsl #16
-
-		ldr	r6, [r0]
-		and	r6, r6, ip
-		ldr	lr, [r0]
-		orr	r6, r6, lr, lsl #16
-
-		stmia	r1!, {r3 - r6}
-
-		subs	r2, r2, #8
-		bpl	.Linsw_8_lp
-
-		tst	r2, #7
-		ldmeqfd	sp!, {r4, r5, r6, pc}
-
-.Lno_insw_8:	tst	r2, #4
-		beq	.Lno_insw_4
-
-		ldr	r3, [r0]
-		and	r3, r3, ip
-		ldr	r4, [r0]
-		orr	r3, r3, r4, lsl #16
-
-		ldr	r4, [r0]
-		and	r4, r4, ip
-		ldr	r5, [r0]
-		orr	r4, r4, r5, lsl #16
-
-		stmia	r1!, {r3, r4}
-
-.Lno_insw_4:	tst	r2, #2
-		beq	.Lno_insw_2
-
-		ldr	r3, [r0]
-		and	r3, r3, ip
-		ldr	r4, [r0]
-		orr	r3, r3, r4, lsl #16
-
-		str	r3, [r1], #4
-
-.Lno_insw_2:	tst	r2, #1
-		ldrne	r3, [r0]
-		strneb	r3, [r1], #1
-		movne	r3, r3, lsr #8
-		strneb	r3, [r1]
-
-		ldmfd	sp!, {r4, r5, r6, pc}
-
-
diff --git a/arch/arm/lib/io-writesw-armv3.S b/arch/arm/lib/io-writesw-armv3.S
deleted file mode 100644
index 49b8004..0000000
--- a/arch/arm/lib/io-writesw-armv3.S
+++ /dev/null
@@ -1,126 +0,0 @@
-/*
- *  linux/arch/arm/lib/io-writesw-armv3.S
- *
- *  Copyright (C) 1995-2000 Russell King
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/linkage.h>
-#include <asm/assembler.h>
-
-.Loutsw_bad_alignment:
-		adr	r0, .Loutsw_bad_align_msg
-		mov	r2, lr
-		b	panic
-.Loutsw_bad_align_msg:
-		.asciz	"outsw: bad buffer alignment (0x%p, lr=0x%08lX)\n"
-		.align
-
-.Loutsw_align:	tst	r1, #1
-		bne	.Loutsw_bad_alignment
-
-		add	r1, r1, #2
-
-		ldr	r3, [r1, #-4]
-		mov	r3, r3, lsr #16
-		orr	r3, r3, r3, lsl #16
-		str	r3, [r0]
-		subs	r2, r2, #1
-		moveq	pc, lr
-
-ENTRY(__raw_writesw)
-		teq	r2, #0		@ do we have to check for the zero len?
-		moveq	pc, lr
-		tst	r1, #3
-		bne	.Loutsw_align
-
-		stmfd	sp!, {r4, r5, r6, lr}
-
-		subs	r2, r2, #8
-		bmi	.Lno_outsw_8
-
-.Loutsw_8_lp:	ldmia	r1!, {r3, r4, r5, r6}
-
-		mov	ip, r3, lsl #16
-		orr	ip, ip, ip, lsr #16
-		str	ip, [r0]
-
-		mov	ip, r3, lsr #16
-		orr	ip, ip, ip, lsl #16
-		str	ip, [r0]
-
-		mov	ip, r4, lsl #16
-		orr	ip, ip, ip, lsr #16
-		str	ip, [r0]
-
-		mov	ip, r4, lsr #16
-		orr	ip, ip, ip, lsl #16
-		str	ip, [r0]
-
-		mov	ip, r5, lsl #16
-		orr	ip, ip, ip, lsr #16
-		str	ip, [r0]
-
-		mov	ip, r5, lsr #16
-		orr	ip, ip, ip, lsl #16
-		str	ip, [r0]
-
-		mov	ip, r6, lsl #16
-		orr	ip, ip, ip, lsr #16
-		str	ip, [r0]
-
-		mov	ip, r6, lsr #16
-		orr	ip, ip, ip, lsl #16
-		str	ip, [r0]
-
-		subs	r2, r2, #8
-		bpl	.Loutsw_8_lp
-
-		tst	r2, #7
-		ldmeqfd	sp!, {r4, r5, r6, pc}
-
-.Lno_outsw_8:	tst	r2, #4
-		beq	.Lno_outsw_4
-
-		ldmia	r1!, {r3, r4}
-
-		mov	ip, r3, lsl #16
-		orr	ip, ip, ip, lsr #16
-		str	ip, [r0]
-
-		mov	ip, r3, lsr #16
-		orr	ip, ip, ip, lsl #16
-		str	ip, [r0]
-
-		mov	ip, r4, lsl #16
-		orr	ip, ip, ip, lsr #16
-		str	ip, [r0]
-
-		mov	ip, r4, lsr #16
-		orr	ip, ip, ip, lsl #16
-		str	ip, [r0]
-
-.Lno_outsw_4:	tst	r2, #2
-		beq	.Lno_outsw_2
-
-		ldr	r3, [r1], #4
-
-		mov	ip, r3, lsl #16
-		orr	ip, ip, ip, lsr #16
-		str	ip, [r0]
-
-		mov	ip, r3, lsr #16
-		orr	ip, ip, ip, lsl #16
-		str	ip, [r0]
-
-.Lno_outsw_2:	tst	r2, #1
-
-		ldrne	r3, [r1]
-
-		movne	ip, r3, lsl #16
-		orrne	ip, ip, ip, lsr #16
-		strne	ip, [r0]
-
-		ldmfd	sp!, {r4, r5, r6, pc}
diff --git a/arch/arm/lib/uaccess.S b/arch/arm/lib/uaccess.S
deleted file mode 100644
index 5c908b1..0000000
--- a/arch/arm/lib/uaccess.S
+++ /dev/null
@@ -1,564 +0,0 @@
-/*
- *  linux/arch/arm/lib/uaccess.S
- *
- *  Copyright (C) 1995, 1996,1997,1998 Russell King
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- *  Routines to block copy data to/from user memory
- *   These are highly optimised both for the 4k page size
- *   and for various alignments.
- */
-#include <linux/linkage.h>
-#include <asm/assembler.h>
-#include <asm/errno.h>
-#include <asm/domain.h>
-
-		.text
-
-#define PAGE_SHIFT 12
-
-/* Prototype: int __copy_to_user(void *to, const char *from, size_t n)
- * Purpose  : copy a block to user memory from kernel memory
- * Params   : to   - user memory
- *          : from - kernel memory
- *          : n    - number of bytes to copy
- * Returns  : Number of bytes NOT copied.
- */
-
-.Lc2u_dest_not_aligned:
-		rsb	ip, ip, #4
-		cmp	ip, #2
-		ldrb	r3, [r1], #1
-USER(	TUSER(	strb)	r3, [r0], #1)			@ May fault
-		ldrgeb	r3, [r1], #1
-USER(	TUSER(	strgeb) r3, [r0], #1)			@ May fault
-		ldrgtb	r3, [r1], #1
-USER(	TUSER(	strgtb) r3, [r0], #1)			@ May fault
-		sub	r2, r2, ip
-		b	.Lc2u_dest_aligned
-
-ENTRY(__copy_to_user)
-		stmfd	sp!, {r2, r4 - r7, lr}
-		cmp	r2, #4
-		blt	.Lc2u_not_enough
-		ands	ip, r0, #3
-		bne	.Lc2u_dest_not_aligned
-.Lc2u_dest_aligned:
-
-		ands	ip, r1, #3
-		bne	.Lc2u_src_not_aligned
-/*
- * Seeing as there has to be at least 8 bytes to copy, we can
- * copy one word, and force a user-mode page fault...
- */
-
-.Lc2u_0fupi:	subs	r2, r2, #4
-		addmi	ip, r2, #4
-		bmi	.Lc2u_0nowords
-		ldr	r3, [r1], #4
-USER(	TUSER(	str)	r3, [r0], #4)			@ May fault
-		mov	ip, r0, lsl #32 - PAGE_SHIFT	@ On each page, use a ld/st??t instruction
-		rsb	ip, ip, #0
-		movs	ip, ip, lsr #32 - PAGE_SHIFT
-		beq	.Lc2u_0fupi
-/*
- * ip = max no. of bytes to copy before needing another "strt" insn
- */
-		cmp	r2, ip
-		movlt	ip, r2
-		sub	r2, r2, ip
-		subs	ip, ip, #32
-		blt	.Lc2u_0rem8lp
-
-.Lc2u_0cpy8lp:	ldmia	r1!, {r3 - r6}
-		stmia	r0!, {r3 - r6}			@ Shouldnt fault
-		ldmia	r1!, {r3 - r6}
-		subs	ip, ip, #32
-		stmia	r0!, {r3 - r6}			@ Shouldnt fault
-		bpl	.Lc2u_0cpy8lp
-
-.Lc2u_0rem8lp:	cmn	ip, #16
-		ldmgeia	r1!, {r3 - r6}
-		stmgeia	r0!, {r3 - r6}			@ Shouldnt fault
-		tst	ip, #8
-		ldmneia	r1!, {r3 - r4}
-		stmneia	r0!, {r3 - r4}			@ Shouldnt fault
-		tst	ip, #4
-		ldrne	r3, [r1], #4
-	TUSER(	strne) r3, [r0], #4			@ Shouldnt fault
-		ands	ip, ip, #3
-		beq	.Lc2u_0fupi
-.Lc2u_0nowords:	teq	ip, #0
-		beq	.Lc2u_finished
-.Lc2u_nowords:	cmp	ip, #2
-		ldrb	r3, [r1], #1
-USER(	TUSER(	strb)	r3, [r0], #1)			@ May fault
-		ldrgeb	r3, [r1], #1
-USER(	TUSER(	strgeb) r3, [r0], #1)			@ May fault
-		ldrgtb	r3, [r1], #1
-USER(	TUSER(	strgtb) r3, [r0], #1)			@ May fault
-		b	.Lc2u_finished
-
-.Lc2u_not_enough:
-		movs	ip, r2
-		bne	.Lc2u_nowords
-.Lc2u_finished:	mov	r0, #0
-		ldmfd	sp!, {r2, r4 - r7, pc}
-
-.Lc2u_src_not_aligned:
-		bic	r1, r1, #3
-		ldr	r7, [r1], #4
-		cmp	ip, #2
-		bgt	.Lc2u_3fupi
-		beq	.Lc2u_2fupi
-.Lc2u_1fupi:	subs	r2, r2, #4
-		addmi	ip, r2, #4
-		bmi	.Lc2u_1nowords
-		mov	r3, r7, pull #8
-		ldr	r7, [r1], #4
-		orr	r3, r3, r7, push #24
-USER(	TUSER(	str)	r3, [r0], #4)			@ May fault
-		mov	ip, r0, lsl #32 - PAGE_SHIFT
-		rsb	ip, ip, #0
-		movs	ip, ip, lsr #32 - PAGE_SHIFT
-		beq	.Lc2u_1fupi
-		cmp	r2, ip
-		movlt	ip, r2
-		sub	r2, r2, ip
-		subs	ip, ip, #16
-		blt	.Lc2u_1rem8lp
-
-.Lc2u_1cpy8lp:	mov	r3, r7, pull #8
-		ldmia	r1!, {r4 - r7}
-		subs	ip, ip, #16
-		orr	r3, r3, r4, push #24
-		mov	r4, r4, pull #8
-		orr	r4, r4, r5, push #24
-		mov	r5, r5, pull #8
-		orr	r5, r5, r6, push #24
-		mov	r6, r6, pull #8
-		orr	r6, r6, r7, push #24
-		stmia	r0!, {r3 - r6}			@ Shouldnt fault
-		bpl	.Lc2u_1cpy8lp
-
-.Lc2u_1rem8lp:	tst	ip, #8
-		movne	r3, r7, pull #8
-		ldmneia	r1!, {r4, r7}
-		orrne	r3, r3, r4, push #24
-		movne	r4, r4, pull #8
-		orrne	r4, r4, r7, push #24
-		stmneia	r0!, {r3 - r4}			@ Shouldnt fault
-		tst	ip, #4
-		movne	r3, r7, pull #8
-		ldrne	r7, [r1], #4
-		orrne	r3, r3, r7, push #24
-	TUSER(	strne) r3, [r0], #4			@ Shouldnt fault
-		ands	ip, ip, #3
-		beq	.Lc2u_1fupi
-.Lc2u_1nowords:	mov	r3, r7, get_byte_1
-		teq	ip, #0
-		beq	.Lc2u_finished
-		cmp	ip, #2
-USER(	TUSER(	strb)	r3, [r0], #1)			@ May fault
-		movge	r3, r7, get_byte_2
-USER(	TUSER(	strgeb) r3, [r0], #1)			@ May fault
-		movgt	r3, r7, get_byte_3
-USER(	TUSER(	strgtb) r3, [r0], #1)			@ May fault
-		b	.Lc2u_finished
-
-.Lc2u_2fupi:	subs	r2, r2, #4
-		addmi	ip, r2, #4
-		bmi	.Lc2u_2nowords
-		mov	r3, r7, pull #16
-		ldr	r7, [r1], #4
-		orr	r3, r3, r7, push #16
-USER(	TUSER(	str)	r3, [r0], #4)			@ May fault
-		mov	ip, r0, lsl #32 - PAGE_SHIFT
-		rsb	ip, ip, #0
-		movs	ip, ip, lsr #32 - PAGE_SHIFT
-		beq	.Lc2u_2fupi
-		cmp	r2, ip
-		movlt	ip, r2
-		sub	r2, r2, ip
-		subs	ip, ip, #16
-		blt	.Lc2u_2rem8lp
-
-.Lc2u_2cpy8lp:	mov	r3, r7, pull #16
-		ldmia	r1!, {r4 - r7}
-		subs	ip, ip, #16
-		orr	r3, r3, r4, push #16
-		mov	r4, r4, pull #16
-		orr	r4, r4, r5, push #16
-		mov	r5, r5, pull #16
-		orr	r5, r5, r6, push #16
-		mov	r6, r6, pull #16
-		orr	r6, r6, r7, push #16
-		stmia	r0!, {r3 - r6}			@ Shouldnt fault
-		bpl	.Lc2u_2cpy8lp
-
-.Lc2u_2rem8lp:	tst	ip, #8
-		movne	r3, r7, pull #16
-		ldmneia	r1!, {r4, r7}
-		orrne	r3, r3, r4, push #16
-		movne	r4, r4, pull #16
-		orrne	r4, r4, r7, push #16
-		stmneia	r0!, {r3 - r4}			@ Shouldnt fault
-		tst	ip, #4
-		movne	r3, r7, pull #16
-		ldrne	r7, [r1], #4
-		orrne	r3, r3, r7, push #16
-	TUSER(	strne) r3, [r0], #4			@ Shouldnt fault
-		ands	ip, ip, #3
-		beq	.Lc2u_2fupi
-.Lc2u_2nowords:	mov	r3, r7, get_byte_2
-		teq	ip, #0
-		beq	.Lc2u_finished
-		cmp	ip, #2
-USER(	TUSER(	strb)	r3, [r0], #1)			@ May fault
-		movge	r3, r7, get_byte_3
-USER(	TUSER(	strgeb) r3, [r0], #1)			@ May fault
-		ldrgtb	r3, [r1], #0
-USER(	TUSER(	strgtb) r3, [r0], #1)			@ May fault
-		b	.Lc2u_finished
-
-.Lc2u_3fupi:	subs	r2, r2, #4
-		addmi	ip, r2, #4
-		bmi	.Lc2u_3nowords
-		mov	r3, r7, pull #24
-		ldr	r7, [r1], #4
-		orr	r3, r3, r7, push #8
-USER(	TUSER(	str)	r3, [r0], #4)			@ May fault
-		mov	ip, r0, lsl #32 - PAGE_SHIFT
-		rsb	ip, ip, #0
-		movs	ip, ip, lsr #32 - PAGE_SHIFT
-		beq	.Lc2u_3fupi
-		cmp	r2, ip
-		movlt	ip, r2
-		sub	r2, r2, ip
-		subs	ip, ip, #16
-		blt	.Lc2u_3rem8lp
-
-.Lc2u_3cpy8lp:	mov	r3, r7, pull #24
-		ldmia	r1!, {r4 - r7}
-		subs	ip, ip, #16
-		orr	r3, r3, r4, push #8
-		mov	r4, r4, pull #24
-		orr	r4, r4, r5, push #8
-		mov	r5, r5, pull #24
-		orr	r5, r5, r6, push #8
-		mov	r6, r6, pull #24
-		orr	r6, r6, r7, push #8
-		stmia	r0!, {r3 - r6}			@ Shouldnt fault
-		bpl	.Lc2u_3cpy8lp
-
-.Lc2u_3rem8lp:	tst	ip, #8
-		movne	r3, r7, pull #24
-		ldmneia	r1!, {r4, r7}
-		orrne	r3, r3, r4, push #8
-		movne	r4, r4, pull #24
-		orrne	r4, r4, r7, push #8
-		stmneia	r0!, {r3 - r4}			@ Shouldnt fault
-		tst	ip, #4
-		movne	r3, r7, pull #24
-		ldrne	r7, [r1], #4
-		orrne	r3, r3, r7, push #8
-	TUSER(	strne) r3, [r0], #4			@ Shouldnt fault
-		ands	ip, ip, #3
-		beq	.Lc2u_3fupi
-.Lc2u_3nowords:	mov	r3, r7, get_byte_3
-		teq	ip, #0
-		beq	.Lc2u_finished
-		cmp	ip, #2
-USER(	TUSER(	strb)	r3, [r0], #1)			@ May fault
-		ldrgeb	r3, [r1], #1
-USER(	TUSER(	strgeb) r3, [r0], #1)			@ May fault
-		ldrgtb	r3, [r1], #0
-USER(	TUSER(	strgtb) r3, [r0], #1)			@ May fault
-		b	.Lc2u_finished
-ENDPROC(__copy_to_user)
-
-		.pushsection .fixup,"ax"
-		.align	0
-9001:		ldmfd	sp!, {r0, r4 - r7, pc}
-		.popsection
-
-/* Prototype: unsigned long __copy_from_user(void *to,const void *from,unsigned long n);
- * Purpose  : copy a block from user memory to kernel memory
- * Params   : to   - kernel memory
- *          : from - user memory
- *          : n    - number of bytes to copy
- * Returns  : Number of bytes NOT copied.
- */
-.Lcfu_dest_not_aligned:
-		rsb	ip, ip, #4
-		cmp	ip, #2
-USER(	TUSER(	ldrb)	r3, [r1], #1)			@ May fault
-		strb	r3, [r0], #1
-USER(	TUSER(	ldrgeb) r3, [r1], #1)			@ May fault
-		strgeb	r3, [r0], #1
-USER(	TUSER(	ldrgtb) r3, [r1], #1)			@ May fault
-		strgtb	r3, [r0], #1
-		sub	r2, r2, ip
-		b	.Lcfu_dest_aligned
-
-ENTRY(__copy_from_user)
-		stmfd	sp!, {r0, r2, r4 - r7, lr}
-		cmp	r2, #4
-		blt	.Lcfu_not_enough
-		ands	ip, r0, #3
-		bne	.Lcfu_dest_not_aligned
-.Lcfu_dest_aligned:
-		ands	ip, r1, #3
-		bne	.Lcfu_src_not_aligned
-
-/*
- * Seeing as there has to be at least 8 bytes to copy, we can
- * copy one word, and force a user-mode page fault...
- */
-
-.Lcfu_0fupi:	subs	r2, r2, #4
-		addmi	ip, r2, #4
-		bmi	.Lcfu_0nowords
-USER(	TUSER(	ldr)	r3, [r1], #4)
-		str	r3, [r0], #4
-		mov	ip, r1, lsl #32 - PAGE_SHIFT	@ On each page, use a ld/st??t instruction
-		rsb	ip, ip, #0
-		movs	ip, ip, lsr #32 - PAGE_SHIFT
-		beq	.Lcfu_0fupi
-/*
- * ip = max no. of bytes to copy before needing another "strt" insn
- */
-		cmp	r2, ip
-		movlt	ip, r2
-		sub	r2, r2, ip
-		subs	ip, ip, #32
-		blt	.Lcfu_0rem8lp
-
-.Lcfu_0cpy8lp:	ldmia	r1!, {r3 - r6}			@ Shouldnt fault
-		stmia	r0!, {r3 - r6}
-		ldmia	r1!, {r3 - r6}			@ Shouldnt fault
-		subs	ip, ip, #32
-		stmia	r0!, {r3 - r6}
-		bpl	.Lcfu_0cpy8lp
-
-.Lcfu_0rem8lp:	cmn	ip, #16
-		ldmgeia	r1!, {r3 - r6}			@ Shouldnt fault
-		stmgeia	r0!, {r3 - r6}
-		tst	ip, #8
-		ldmneia	r1!, {r3 - r4}			@ Shouldnt fault
-		stmneia	r0!, {r3 - r4}
-		tst	ip, #4
-	TUSER(	ldrne) r3, [r1], #4			@ Shouldnt fault
-		strne	r3, [r0], #4
-		ands	ip, ip, #3
-		beq	.Lcfu_0fupi
-.Lcfu_0nowords:	teq	ip, #0
-		beq	.Lcfu_finished
-.Lcfu_nowords:	cmp	ip, #2
-USER(	TUSER(	ldrb)	r3, [r1], #1)			@ May fault
-		strb	r3, [r0], #1
-USER(	TUSER(	ldrgeb) r3, [r1], #1)			@ May fault
-		strgeb	r3, [r0], #1
-USER(	TUSER(	ldrgtb) r3, [r1], #1)			@ May fault
-		strgtb	r3, [r0], #1
-		b	.Lcfu_finished
-
-.Lcfu_not_enough:
-		movs	ip, r2
-		bne	.Lcfu_nowords
-.Lcfu_finished:	mov	r0, #0
-		add	sp, sp, #8
-		ldmfd	sp!, {r4 - r7, pc}
-
-.Lcfu_src_not_aligned:
-		bic	r1, r1, #3
-USER(	TUSER(	ldr)	r7, [r1], #4)			@ May fault
-		cmp	ip, #2
-		bgt	.Lcfu_3fupi
-		beq	.Lcfu_2fupi
-.Lcfu_1fupi:	subs	r2, r2, #4
-		addmi	ip, r2, #4
-		bmi	.Lcfu_1nowords
-		mov	r3, r7, pull #8
-USER(	TUSER(	ldr)	r7, [r1], #4)			@ May fault
-		orr	r3, r3, r7, push #24
-		str	r3, [r0], #4
-		mov	ip, r1, lsl #32 - PAGE_SHIFT
-		rsb	ip, ip, #0
-		movs	ip, ip, lsr #32 - PAGE_SHIFT
-		beq	.Lcfu_1fupi
-		cmp	r2, ip
-		movlt	ip, r2
-		sub	r2, r2, ip
-		subs	ip, ip, #16
-		blt	.Lcfu_1rem8lp
-
-.Lcfu_1cpy8lp:	mov	r3, r7, pull #8
-		ldmia	r1!, {r4 - r7}			@ Shouldnt fault
-		subs	ip, ip, #16
-		orr	r3, r3, r4, push #24
-		mov	r4, r4, pull #8
-		orr	r4, r4, r5, push #24
-		mov	r5, r5, pull #8
-		orr	r5, r5, r6, push #24
-		mov	r6, r6, pull #8
-		orr	r6, r6, r7, push #24
-		stmia	r0!, {r3 - r6}
-		bpl	.Lcfu_1cpy8lp
-
-.Lcfu_1rem8lp:	tst	ip, #8
-		movne	r3, r7, pull #8
-		ldmneia	r1!, {r4, r7}			@ Shouldnt fault
-		orrne	r3, r3, r4, push #24
-		movne	r4, r4, pull #8
-		orrne	r4, r4, r7, push #24
-		stmneia	r0!, {r3 - r4}
-		tst	ip, #4
-		movne	r3, r7, pull #8
-USER(	TUSER(	ldrne) r7, [r1], #4)			@ May fault
-		orrne	r3, r3, r7, push #24
-		strne	r3, [r0], #4
-		ands	ip, ip, #3
-		beq	.Lcfu_1fupi
-.Lcfu_1nowords:	mov	r3, r7, get_byte_1
-		teq	ip, #0
-		beq	.Lcfu_finished
-		cmp	ip, #2
-		strb	r3, [r0], #1
-		movge	r3, r7, get_byte_2
-		strgeb	r3, [r0], #1
-		movgt	r3, r7, get_byte_3
-		strgtb	r3, [r0], #1
-		b	.Lcfu_finished
-
-.Lcfu_2fupi:	subs	r2, r2, #4
-		addmi	ip, r2, #4
-		bmi	.Lcfu_2nowords
-		mov	r3, r7, pull #16
-USER(	TUSER(	ldr)	r7, [r1], #4)			@ May fault
-		orr	r3, r3, r7, push #16
-		str	r3, [r0], #4
-		mov	ip, r1, lsl #32 - PAGE_SHIFT
-		rsb	ip, ip, #0
-		movs	ip, ip, lsr #32 - PAGE_SHIFT
-		beq	.Lcfu_2fupi
-		cmp	r2, ip
-		movlt	ip, r2
-		sub	r2, r2, ip
-		subs	ip, ip, #16
-		blt	.Lcfu_2rem8lp
-
-
-.Lcfu_2cpy8lp:	mov	r3, r7, pull #16
-		ldmia	r1!, {r4 - r7}			@ Shouldnt fault
-		subs	ip, ip, #16
-		orr	r3, r3, r4, push #16
-		mov	r4, r4, pull #16
-		orr	r4, r4, r5, push #16
-		mov	r5, r5, pull #16
-		orr	r5, r5, r6, push #16
-		mov	r6, r6, pull #16
-		orr	r6, r6, r7, push #16
-		stmia	r0!, {r3 - r6}
-		bpl	.Lcfu_2cpy8lp
-
-.Lcfu_2rem8lp:	tst	ip, #8
-		movne	r3, r7, pull #16
-		ldmneia	r1!, {r4, r7}			@ Shouldnt fault
-		orrne	r3, r3, r4, push #16
-		movne	r4, r4, pull #16
-		orrne	r4, r4, r7, push #16
-		stmneia	r0!, {r3 - r4}
-		tst	ip, #4
-		movne	r3, r7, pull #16
-USER(	TUSER(	ldrne) r7, [r1], #4)			@ May fault
-		orrne	r3, r3, r7, push #16
-		strne	r3, [r0], #4
-		ands	ip, ip, #3
-		beq	.Lcfu_2fupi
-.Lcfu_2nowords:	mov	r3, r7, get_byte_2
-		teq	ip, #0
-		beq	.Lcfu_finished
-		cmp	ip, #2
-		strb	r3, [r0], #1
-		movge	r3, r7, get_byte_3
-		strgeb	r3, [r0], #1
-USER(	TUSER(	ldrgtb) r3, [r1], #0)			@ May fault
-		strgtb	r3, [r0], #1
-		b	.Lcfu_finished
-
-.Lcfu_3fupi:	subs	r2, r2, #4
-		addmi	ip, r2, #4
-		bmi	.Lcfu_3nowords
-		mov	r3, r7, pull #24
-USER(	TUSER(	ldr)	r7, [r1], #4)			@ May fault
-		orr	r3, r3, r7, push #8
-		str	r3, [r0], #4
-		mov	ip, r1, lsl #32 - PAGE_SHIFT
-		rsb	ip, ip, #0
-		movs	ip, ip, lsr #32 - PAGE_SHIFT
-		beq	.Lcfu_3fupi
-		cmp	r2, ip
-		movlt	ip, r2
-		sub	r2, r2, ip
-		subs	ip, ip, #16
-		blt	.Lcfu_3rem8lp
-
-.Lcfu_3cpy8lp:	mov	r3, r7, pull #24
-		ldmia	r1!, {r4 - r7}			@ Shouldnt fault
-		orr	r3, r3, r4, push #8
-		mov	r4, r4, pull #24
-		orr	r4, r4, r5, push #8
-		mov	r5, r5, pull #24
-		orr	r5, r5, r6, push #8
-		mov	r6, r6, pull #24
-		orr	r6, r6, r7, push #8
-		stmia	r0!, {r3 - r6}
-		subs	ip, ip, #16
-		bpl	.Lcfu_3cpy8lp
-
-.Lcfu_3rem8lp:	tst	ip, #8
-		movne	r3, r7, pull #24
-		ldmneia	r1!, {r4, r7}			@ Shouldnt fault
-		orrne	r3, r3, r4, push #8
-		movne	r4, r4, pull #24
-		orrne	r4, r4, r7, push #8
-		stmneia	r0!, {r3 - r4}
-		tst	ip, #4
-		movne	r3, r7, pull #24
-USER(	TUSER(	ldrne) r7, [r1], #4)			@ May fault
-		orrne	r3, r3, r7, push #8
-		strne	r3, [r0], #4
-		ands	ip, ip, #3
-		beq	.Lcfu_3fupi
-.Lcfu_3nowords:	mov	r3, r7, get_byte_3
-		teq	ip, #0
-		beq	.Lcfu_finished
-		cmp	ip, #2
-		strb	r3, [r0], #1
-USER(	TUSER(	ldrgeb) r3, [r1], #1)			@ May fault
-		strgeb	r3, [r0], #1
-USER(	TUSER(	ldrgtb) r3, [r1], #1)			@ May fault
-		strgtb	r3, [r0], #1
-		b	.Lcfu_finished
-ENDPROC(__copy_from_user)
-
-		.pushsection .fixup,"ax"
-		.align	0
-		/*
-		 * We took an exception.  r0 contains a pointer to
-		 * the byte not copied.
-		 */
-9001:		ldr	r2, [sp], #4			@ void *to
-		sub	r2, r0, r2			@ bytes copied
-		ldr	r1, [sp], #4			@ unsigned long count
-		subs	r4, r1, r2			@ bytes left to copy
-		movne	r1, r4
-		blne	__memzero
-		mov	r0, r4
-		ldmfd	sp!, {r4 - r7, pc}
-		.popsection
-
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 7c8a7d8..101b968 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -4,23 +4,6 @@ comment "Processor Type"
 # which CPUs we support in the kernel image, and the compiler instruction
 # optimiser behaviour.
 
-# ARM610
-config CPU_ARM610
-	bool "Support ARM610 processor" if ARCH_RPC
-	select CPU_32v3
-	select CPU_CACHE_V3
-	select CPU_CACHE_VIVT
-	select CPU_CP15_MMU
-	select CPU_COPY_V3 if MMU
-	select CPU_TLB_V3 if MMU
-	select CPU_PABRT_LEGACY
-	help
-	  The ARM610 is the successor to the ARM3 processor
-	  and was produced by VLSI Technology Inc.
-
-	  Say Y if you want support for the ARM610 processor.
-	  Otherwise, say N.
-
 # ARM7TDMI
 config CPU_ARM7TDMI
 	bool "Support ARM7TDMI processor"
@@ -36,25 +19,6 @@ config CPU_ARM7TDMI
 	  Say Y if you want support for the ARM7TDMI processor.
 	  Otherwise, say N.
 
-# ARM710
-config CPU_ARM710
-	bool "Support ARM710 processor" if ARCH_RPC
-	select CPU_32v3
-	select CPU_CACHE_V3
-	select CPU_CACHE_VIVT
-	select CPU_CP15_MMU
-	select CPU_COPY_V3 if MMU
-	select CPU_TLB_V3 if MMU
-	select CPU_PABRT_LEGACY
-	help
-	  A 32-bit RISC microprocessor based on the ARM7 processor core
-	  designed by Advanced RISC Machines Ltd. The ARM710 is the
-	  successor to the ARM610 processor. It was released in
-	  July 1994 by VLSI Technology Inc.
-
-	  Say Y if you want support for the ARM710 processor.
-	  Otherwise, say N.
-
 # ARM720T
 config CPU_ARM720T
 	bool "Support ARM720T processor" if ARCH_INTEGRATOR
@@ -530,9 +494,6 @@ config CPU_CACHE_FA
 
 if MMU
 # The copy-page model
-config CPU_COPY_V3
-	bool
-
 config CPU_COPY_V4WT
 	bool
 
@@ -549,11 +510,6 @@ config CPU_COPY_V6
 	bool
 
 # This selects the TLB model
-config CPU_TLB_V3
-	bool
-	help
-	  ARM Architecture Version 3 TLB.
-
 config CPU_TLB_V4WT
 	bool
 	help
@@ -731,7 +687,7 @@ config CPU_HIGH_VECTOR
 
 config CPU_ICACHE_DISABLE
 	bool "Disable I-Cache (I-bit)"
-	depends on CPU_CP15 && !(CPU_ARM610 || CPU_ARM710 || CPU_ARM720T || CPU_ARM740T || CPU_XSCALE || CPU_XSC3)
+	depends on CPU_CP15 && !(CPU_ARM720T || CPU_ARM740T || CPU_XSCALE || CPU_XSC3)
 	help
 	  Say Y here to disable the processor instruction cache. Unless
 	  you have a reason not to or are unsure, say N.
diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
index bca7e61..8a9c4cb 100644
--- a/arch/arm/mm/Makefile
+++ b/arch/arm/mm/Makefile
@@ -44,7 +44,6 @@ obj-$(CONFIG_CPU_CACHE_FA)	+= cache-fa.o
 AFLAGS_cache-v6.o	:=-Wa,-march=armv6
 AFLAGS_cache-v7.o	:=-Wa,-march=armv7-a
 
-obj-$(CONFIG_CPU_COPY_V3)	+= copypage-v3.o
 obj-$(CONFIG_CPU_COPY_V4WT)	+= copypage-v4wt.o
 obj-$(CONFIG_CPU_COPY_V4WB)	+= copypage-v4wb.o
 obj-$(CONFIG_CPU_COPY_FEROCEON)	+= copypage-feroceon.o
@@ -54,7 +53,6 @@ obj-$(CONFIG_CPU_XSCALE)	+= copypage-xscale.o
 obj-$(CONFIG_CPU_XSC3)		+= copypage-xsc3.o
 obj-$(CONFIG_CPU_COPY_FA)	+= copypage-fa.o
 
-obj-$(CONFIG_CPU_TLB_V3)	+= tlb-v3.o
 obj-$(CONFIG_CPU_TLB_V4WT)	+= tlb-v4.o
 obj-$(CONFIG_CPU_TLB_V4WB)	+= tlb-v4wb.o
 obj-$(CONFIG_CPU_TLB_V4WBI)	+= tlb-v4wbi.o
@@ -66,8 +64,6 @@ obj-$(CONFIG_CPU_TLB_FA)	+= tlb-fa.o
 AFLAGS_tlb-v6.o		:=-Wa,-march=armv6
 AFLAGS_tlb-v7.o		:=-Wa,-march=armv7-a
 
-obj-$(CONFIG_CPU_ARM610)	+= proc-arm6_7.o
-obj-$(CONFIG_CPU_ARM710)	+= proc-arm6_7.o
 obj-$(CONFIG_CPU_ARM7TDMI)	+= proc-arm7tdmi.o
 obj-$(CONFIG_CPU_ARM720T)	+= proc-arm720.o
 obj-$(CONFIG_CPU_ARM740T)	+= proc-arm740.o
diff --git a/arch/arm/mm/copypage-v3.c b/arch/arm/mm/copypage-v3.c
deleted file mode 100644
index 3935bdd..0000000
--- a/arch/arm/mm/copypage-v3.c
+++ /dev/null
@@ -1,81 +0,0 @@
-/*
- *  linux/arch/arm/mm/copypage-v3.c
- *
- *  Copyright (C) 1995-1999 Russell King
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/init.h>
-#include <linux/highmem.h>
-
-/*
- * ARMv3 optimised copy_user_highpage
- *
- * FIXME: do we need to handle cache stuff...
- */
-static void __naked
-v3_copy_user_page(void *kto, const void *kfrom)
-{
-	asm("\n\
-	stmfd	sp!, {r4, lr}			@	2\n\
-	mov	r2, %2				@	1\n\
-	ldmia	%0!, {r3, r4, ip, lr}		@	4+1\n\
-1:	stmia	%1!, {r3, r4, ip, lr}		@	4\n\
-	ldmia	%0!, {r3, r4, ip, lr}		@	4+1\n\
-	stmia	%1!, {r3, r4, ip, lr}		@	4\n\
-	ldmia	%0!, {r3, r4, ip, lr}		@	4+1\n\
-	stmia	%1!, {r3, r4, ip, lr}		@	4\n\
-	ldmia	%0!, {r3, r4, ip, lr}		@	4\n\
-	subs	r2, r2, #1			@	1\n\
-	stmia	%1!, {r3, r4, ip, lr}		@	4\n\
-	ldmneia	%0!, {r3, r4, ip, lr}		@	4\n\
-	bne	1b				@	1\n\
-	ldmfd	sp!, {r4, pc}			@	3"
-	:
-	: "r" (kfrom), "r" (kto), "I" (PAGE_SIZE / 64));
-}
-
-void v3_copy_user_highpage(struct page *to, struct page *from,
-	unsigned long vaddr, struct vm_area_struct *vma)
-{
-	void *kto, *kfrom;
-
-	kto = kmap_atomic(to);
-	kfrom = kmap_atomic(from);
-	v3_copy_user_page(kto, kfrom);
-	kunmap_atomic(kfrom);
-	kunmap_atomic(kto);
-}
-
-/*
- * ARMv3 optimised clear_user_page
- *
- * FIXME: do we need to handle cache stuff...
- */
-void v3_clear_user_highpage(struct page *page, unsigned long vaddr)
-{
-	void *ptr, *kaddr = kmap_atomic(page);
-	asm volatile("\n\
-	mov	r1, %2				@ 1\n\
-	mov	r2, #0				@ 1\n\
-	mov	r3, #0				@ 1\n\
-	mov	ip, #0				@ 1\n\
-	mov	lr, #0				@ 1\n\
-1:	stmia	%0!, {r2, r3, ip, lr}		@ 4\n\
-	stmia	%0!, {r2, r3, ip, lr}		@ 4\n\
-	stmia	%0!, {r2, r3, ip, lr}		@ 4\n\
-	stmia	%0!, {r2, r3, ip, lr}		@ 4\n\
-	subs	r1, r1, #1			@ 1\n\
-	bne	1b				@ 1"
-	: "=r" (ptr)
-	: "0" (kaddr), "I" (PAGE_SIZE / 64)
-	: "r1", "r2", "r3", "ip", "lr");
-	kunmap_atomic(kaddr);
-}
-
-struct cpu_user_fns v3_user_fns __initdata = {
-	.cpu_clear_user_highpage = v3_clear_user_highpage,
-	.cpu_copy_user_highpage	= v3_copy_user_highpage,
-};
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index f074675..84aec37 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -430,9 +430,6 @@ do_translation_fault(unsigned long addr, unsigned int fsr,
 
 	index = pgd_index(addr);
 
-	/*
-	 * FIXME: CP15 C1 is write only on ARMv3 architectures.
-	 */
 	pgd = cpu_get_pgd() + index;
 	pgd_k = init_mm.pgd + index;
 
diff --git a/arch/arm/mm/proc-arm6_7.S b/arch/arm/mm/proc-arm6_7.S
deleted file mode 100644
index 4fbeb5b..0000000
--- a/arch/arm/mm/proc-arm6_7.S
+++ /dev/null
@@ -1,327 +0,0 @@
-/*
- *  linux/arch/arm/mm/proc-arm6,7.S
- *
- *  Copyright (C) 1997-2000 Russell King
- *  hacked for non-paged-MM by Hyok S. Choi, 2003.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- *  These are the low level assembler for performing cache and TLB
- *  functions on the ARM610 & ARM710.
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
-ENTRY(cpu_arm6_dcache_clean_area)
-ENTRY(cpu_arm7_dcache_clean_area)
-		mov	pc, lr
-
-/*
- * Function: arm6_7_data_abort ()
- *
- * Params  : r2 = pt_regs
- *	   : r4 = aborted context pc
- *	   : r5 = aborted context psr
- *
- * Purpose : obtain information about current aborted instruction
- *
- * Returns : r4-r5, r10-r11, r13 preserved
- */
-
-ENTRY(cpu_arm7_data_abort)
-	mrc	p15, 0, r1, c5, c0, 0		@ get FSR
-	mrc	p15, 0, r0, c6, c0, 0		@ get FAR
-	ldr	r8, [r4]			@ read arm instruction
-	tst	r8, #1 << 20			@ L = 0 -> write?
-	orreq	r1, r1, #1 << 11		@ yes.
-	and	r7, r8, #15 << 24
-	add	pc, pc, r7, lsr #22		@ Now branch to the relevant processing routine
-	nop
-
-/* 0 */	b	.data_unknown
-/* 1 */	b	do_DataAbort			@ swp
-/* 2 */	b	.data_unknown
-/* 3 */	b	.data_unknown
-/* 4 */	b	.data_arm_lateldrpostconst	@ ldr	rd, [rn], #m
-/* 5 */	b	.data_arm_lateldrpreconst	@ ldr	rd, [rn, #m]
-/* 6 */	b	.data_arm_lateldrpostreg	@ ldr	rd, [rn], rm
-/* 7 */	b	.data_arm_lateldrprereg		@ ldr	rd, [rn, rm]
-/* 8 */	b	.data_arm_ldmstm		@ ldm*a	rn, <rlist>
-/* 9 */	b	.data_arm_ldmstm		@ ldm*b	rn, <rlist>
-/* a */	b	.data_unknown
-/* b */	b	.data_unknown
-/* c */	b	do_DataAbort			@ ldc	rd, [rn], #m	@ Same as ldr	rd, [rn], #m
-/* d */	b	do_DataAbort			@ ldc	rd, [rn, #m]
-/* e */	b	.data_unknown
-/* f */
-.data_unknown:	@ Part of jumptable
-	mov	r0, r4
-	mov	r1, r8
-	b	baddataabort
-
-ENTRY(cpu_arm6_data_abort)
-	mrc	p15, 0, r1, c5, c0, 0		@ get FSR
-	mrc	p15, 0, r0, c6, c0, 0		@ get FAR
-	ldr	r8, [r4]			@ read arm instruction
-	tst	r8, #1 << 20			@ L = 0 -> write?
-	orreq	r1, r1, #1 << 11		@ yes.
-	and	r7, r8, #14 << 24
-	teq	r7, #8 << 24			@ was it ldm/stm
-	bne	do_DataAbort
-
-.data_arm_ldmstm:
-	tst	r8, #1 << 21			@ check writeback bit
-	beq	do_DataAbort			@ no writeback -> no fixup
-	mov	r7, #0x11
-	orr	r7, r7, #0x1100
-	and	r6, r8, r7
-	and	r9, r8, r7, lsl #1
-	add	r6, r6, r9, lsr #1
-	and	r9, r8, r7, lsl #2
-	add	r6, r6, r9, lsr #2
-	and	r9, r8, r7, lsl #3
-	add	r6, r6, r9, lsr #3
-	add	r6, r6, r6, lsr #8
-	add	r6, r6, r6, lsr #4
-	and	r6, r6, #15			@ r6 = no. of registers to transfer.
-	and	r9, r8, #15 << 16		@ Extract 'n' from instruction
-	ldr	r7, [r2, r9, lsr #14]		@ Get register 'Rn'
-	tst	r8, #1 << 23			@ Check U bit
-	subne	r7, r7, r6, lsl #2		@ Undo increment
-	addeq	r7, r7, r6, lsl #2		@ Undo decrement
-	str	r7, [r2, r9, lsr #14]		@ Put register 'Rn'
-	b	do_DataAbort
-
-.data_arm_apply_r6_and_rn:
-	and	r9, r8, #15 << 16		@ Extract 'n' from instruction
-	ldr	r7, [r2, r9, lsr #14]		@ Get register 'Rn'
-	tst	r8, #1 << 23			@ Check U bit
-	subne	r7, r7, r6			@ Undo incrmenet
-	addeq	r7, r7, r6			@ Undo decrement
-	str	r7, [r2, r9, lsr #14]		@ Put register 'Rn'
-	b	do_DataAbort
-
-.data_arm_lateldrpreconst:
-	tst	r8, #1 << 21			@ check writeback bit
-	beq	do_DataAbort			@ no writeback -> no fixup
-.data_arm_lateldrpostconst:
-	movs	r6, r8, lsl #20			@ Get offset
-	beq	do_DataAbort			@ zero -> no fixup
-	and	r9, r8, #15 << 16		@ Extract 'n' from instruction
-	ldr	r7, [r2, r9, lsr #14]		@ Get register 'Rn'
-	tst	r8, #1 << 23			@ Check U bit
-	subne	r7, r7, r6, lsr #20		@ Undo increment
-	addeq	r7, r7, r6, lsr #20		@ Undo decrement
-	str	r7, [r2, r9, lsr #14]		@ Put register 'Rn'
-	b	do_DataAbort
-
-.data_arm_lateldrprereg:
-	tst	r8, #1 << 21			@ check writeback bit
-	beq	do_DataAbort			@ no writeback -> no fixup
-.data_arm_lateldrpostreg:
-	and	r7, r8, #15			@ Extract 'm' from instruction
-	ldr	r6, [r2, r7, lsl #2]		@ Get register 'Rm'
-	mov	r9, r8, lsr #7			@ get shift count
-	ands	r9, r9, #31
-	and	r7, r8, #0x70			@ get shift type
-	orreq	r7, r7, #8			@ shift count = 0
-	add	pc, pc, r7
-	nop
-
-	mov	r6, r6, lsl r9			@ 0: LSL #!0
-	b	.data_arm_apply_r6_and_rn
-	b	.data_arm_apply_r6_and_rn	@ 1: LSL #0
-	nop
-	b	.data_unknown			@ 2: MUL?
-	nop
-	b	.data_unknown			@ 3: MUL?
-	nop
-	mov	r6, r6, lsr r9			@ 4: LSR #!0
-	b	.data_arm_apply_r6_and_rn
-	mov	r6, r6, lsr #32			@ 5: LSR #32
-	b	.data_arm_apply_r6_and_rn
-	b	.data_unknown			@ 6: MUL?
-	nop
-	b	.data_unknown			@ 7: MUL?
-	nop
-	mov	r6, r6, asr r9			@ 8: ASR #!0
-	b	.data_arm_apply_r6_and_rn
-	mov	r6, r6, asr #32			@ 9: ASR #32
-	b	.data_arm_apply_r6_and_rn
-	b	.data_unknown			@ A: MUL?
-	nop
-	b	.data_unknown			@ B: MUL?
-	nop
-	mov	r6, r6, ror r9			@ C: ROR #!0
-	b	.data_arm_apply_r6_and_rn
-	mov	r6, r6, rrx			@ D: RRX
-	b	.data_arm_apply_r6_and_rn
-	b	.data_unknown			@ E: MUL?
-	nop
-	b	.data_unknown			@ F: MUL?
-
-/*
- * Function: arm6_7_proc_init (void)
- *	   : arm6_7_proc_fin (void)
- *
- * Notes   : This processor does not require these
- */
-ENTRY(cpu_arm6_proc_init)
-ENTRY(cpu_arm7_proc_init)
-		mov	pc, lr
-
-ENTRY(cpu_arm6_proc_fin)
-ENTRY(cpu_arm7_proc_fin)
-		mov	r0, #0x31			@ ....S..DP...M
-		mcr	p15, 0, r0, c1, c0, 0		@ disable caches
-		mov	pc, lr
-
-ENTRY(cpu_arm6_do_idle)
-ENTRY(cpu_arm7_do_idle)
-		mov	pc, lr
-
-/*
- * Function: arm6_7_switch_mm(unsigned long pgd_phys)
- * Params  : pgd_phys	Physical address of page table
- * Purpose : Perform a task switch, saving the old processes state, and restoring
- *	     the new.
- */
-ENTRY(cpu_arm6_switch_mm)
-ENTRY(cpu_arm7_switch_mm)
-#ifdef CONFIG_MMU
-		mov	r1, #0
-		mcr	p15, 0, r1, c7, c0, 0		@ flush cache
-		mcr	p15, 0, r0, c2, c0, 0		@ update page table ptr
-		mcr	p15, 0, r1, c5, c0, 0		@ flush TLBs
-#endif
-		mov	pc, lr
-
-/*
- * Function: arm6_7_set_pte_ext(pte_t *ptep, pte_t pte, unsigned int ext)
- * Params  : r0 = Address to set
- *	   : r1 = value to set
- * Purpose : Set a PTE and flush it out of any WB cache
- */
-	.align	5
-ENTRY(cpu_arm6_set_pte_ext)
-ENTRY(cpu_arm7_set_pte_ext)
-#ifdef CONFIG_MMU
-	armv3_set_pte_ext wc_disable=0
-#endif /* CONFIG_MMU */
-	mov	pc, lr
-
-/*
- * Function: _arm6_7_reset
- * Params  : r0 = address to jump to
- * Notes   : This sets up everything for a reset
- */
-		.pushsection	.idmap.text, "ax"
-ENTRY(cpu_arm6_reset)
-ENTRY(cpu_arm7_reset)
-		mov	r1, #0
-		mcr	p15, 0, r1, c7, c0, 0		@ flush cache
-#ifdef CONFIG_MMU
-		mcr	p15, 0, r1, c5, c0, 0		@ flush TLB
-#endif
-		mov	r1, #0x30
-		mcr	p15, 0, r1, c1, c0, 0		@ turn off MMU etc
-		mov	pc, r0
-ENDPROC(cpu_arm6_reset)
-ENDPROC(cpu_arm7_reset)
-		.popsection
-
-		__CPUINIT
-
-		.type	__arm6_setup, #function
-__arm6_setup:	mov	r0, #0
-		mcr	p15, 0, r0, c7, c0		@ flush caches on v3
-#ifdef CONFIG_MMU
-		mcr	p15, 0, r0, c5, c0		@ flush TLBs on v3
-		mov	r0, #0x3d			@ . ..RS BLDP WCAM
-		orr	r0, r0, #0x100			@ . ..01 0011 1101
-#else
-		mov	r0, #0x3c			@ . ..RS BLDP WCA.
-#endif
-		mov	pc, lr
-		.size	__arm6_setup, . - __arm6_setup
-
-		.type	__arm7_setup, #function
-__arm7_setup:	mov	r0, #0
-		mcr	p15, 0, r0, c7, c0		@ flush caches on v3
-#ifdef CONFIG_MMU
-		mcr	p15, 0, r0, c5, c0		@ flush TLBs on v3
-		mcr	p15, 0, r0, c3, c0		@ load domain access register
-		mov	r0, #0x7d			@ . ..RS BLDP WCAM
-		orr	r0, r0, #0x100			@ . ..01 0111 1101
-#else
-		mov	r0, #0x7c			@ . ..RS BLDP WCA.
-#endif
-		mov	pc, lr
-		.size	__arm7_setup, . - __arm7_setup
-
-		__INITDATA
-
-		@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
-		define_processor_functions arm6, dabort=cpu_arm6_data_abort, pabort=legacy_pabort
-		define_processor_functions arm7, dabort=cpu_arm7_data_abort, pabort=legacy_pabort
-
-		.section ".rodata"
-
-		string	cpu_arch_name, "armv3"
-		string	cpu_elf_name, "v3"
-		string	cpu_arm6_name, "ARM6"
-		string	cpu_arm610_name, "ARM610"
-		string	cpu_arm7_name, "ARM7"
-		string	cpu_arm710_name, "ARM710"
-
-		.align
-
-		.section ".proc.info.init", #alloc, #execinstr
-
-.macro arm67_proc_info name:req, cpu_val:req, cpu_mask:req, cpu_name:req, \
-	cpu_mm_mmu_flags:req, cpu_flush:req, cpu_proc_funcs:req
-		.type	__\name\()_proc_info, #object
-__\name\()_proc_info:
-		.long	\cpu_val
-		.long	\cpu_mask
-		.long	\cpu_mm_mmu_flags
-		.long   PMD_TYPE_SECT | \
-			PMD_BIT4 | \
-			PMD_SECT_AP_WRITE | \
-			PMD_SECT_AP_READ
-		b	\cpu_flush
-		.long	cpu_arch_name
-		.long	cpu_elf_name
-		.long	HWCAP_SWP | HWCAP_26BIT
-		.long	\cpu_name
-		.long	\cpu_proc_funcs
-		.long	v3_tlb_fns
-		.long	v3_user_fns
-		.long	v3_cache_fns
-		.size	__\name\()_proc_info, . - __\name\()_proc_info
-.endm
-
-	arm67_proc_info	arm6,	0x41560600, 0xfffffff0, cpu_arm6_name, \
-		0x00000c1e, __arm6_setup, arm6_processor_functions
-	arm67_proc_info	arm610,	0x41560610, 0xfffffff0, cpu_arm610_name, \
-		0x00000c1e, __arm6_setup, arm6_processor_functions
-	arm67_proc_info	arm7,	0x41007000, 0xffffff00, cpu_arm7_name, \
-		0x00000c1e, __arm7_setup, arm7_processor_functions
-	arm67_proc_info	arm710,	0x41007100, 0xfff8ff00, cpu_arm710_name, \
-			PMD_TYPE_SECT | \
-			PMD_SECT_BUFFERABLE | \
-			PMD_SECT_CACHEABLE | \
-			PMD_BIT4 | \
-			PMD_SECT_AP_WRITE | \
-			PMD_SECT_AP_READ, \
-		__arm7_setup, arm7_processor_functions
diff --git a/arch/arm/mm/tlb-v3.S b/arch/arm/mm/tlb-v3.S
deleted file mode 100644
index d253995..0000000
--- a/arch/arm/mm/tlb-v3.S
+++ /dev/null
@@ -1,48 +0,0 @@
-/*
- *  linux/arch/arm/mm/tlbv3.S
- *
- *  Copyright (C) 1997-2002 Russell King
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- *  ARM architecture version 3 TLB handling functions.
- *
- * Processors: ARM610, ARM710.
- */
-#include <linux/linkage.h>
-#include <linux/init.h>
-#include <asm/asm-offsets.h>
-#include <asm/tlbflush.h>
-#include "proc-macros.S"
-
-	.align	5
-/*
- *	v3_flush_user_tlb_range(start, end, mm)
- *
- *	Invalidate a range of TLB entries in the specified address space.
- *
- *	- start - range start address
- *	- end   - range end address
- *	- mm    - mm_struct describing address space
- */
-	.align	5
-ENTRY(v3_flush_user_tlb_range)
-	vma_vm_mm r2, r2
-	act_mm	r3				@ get current->active_mm
-	teq	r2, r3				@ == mm ?
-	movne	pc, lr				@ no, we dont do anything
-ENTRY(v3_flush_kern_tlb_range)
-	bic	r0, r0, #0x0ff
-	bic	r0, r0, #0xf00
-1:	mcr	p15, 0, r0, c6, c0, 0		@ invalidate TLB entry
-	add	r0, r0, #PAGE_SZ
-	cmp	r0, r1
-	blo	1b
-	mov	pc, lr
-
-	__INITDATA
-
-	/* define struct cpu_tlb_fns (see <asm/tlbflush.h> and proc-macros.S) */
-	define_tlb_functions v3, v3_tlb_flags
