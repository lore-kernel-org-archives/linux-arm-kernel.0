From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 07 Dec 2009 14:16:33 +0000
Subject: [PATCH 6/6] Remove the domain switching on ARMv6k/v7 CPUs
In-Reply-To: <20091207135603.30429.74812.stgit@pc1117.cambridge.arm.com>
References: <20091207135603.30429.74812.stgit@pc1117.cambridge.arm.com>
Message-ID: <20091207141415.30429.93073.stgit@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes the domain switching functionality via the set_fs and
__switch_to functions on cores that have a TLS register.

Currently, the ioremap and vmalloc areas share the same level 1 page
tables and therefore have the same domain (DOMAIN_KERNEL). When the
kernel domain is modified from Client to Manager (via the __set_fs or in
the __switch_to function), the XN (eXecute Never) bit is overridden and
newer CPUs can speculatively prefetch the ioremap'ed memory.

Linux performs the kernel domain switching to allow user-specific
functions (copy_to/from_user, get/put_user etc.) to access kernel
memory. In order for these functions to work with the kernel domain set
to Client, the patch modifies the LDRT/STRT and related instructions to
the LDR/STR ones.

The user pages access rights are also modified for kernel read-only
access rather than read/write so that the copy-on-write mechanism still
works. CPU_USE_DOMAINS gets disabled only if HAS_TLS_REG is defined
since writing the TLS value to the high vectors page isn't possible.

The user addresses passed to the kernel are checked by the access_ok()
function so that they do not point to the kernel space.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

An additional note - prior to ARMv6 we cannot set the user R/O, kernel
R/O permission on a page hence we have to use STRT variant to write such
page from the kernel. Because of this, the T macro had to be introduced
to differentiate between the STRT and STR usages and build time.

A better name could be used instead of "T".


 arch/arm/include/asm/assembler.h |    9 ++--
 arch/arm/include/asm/domain.h    |   31 +++++++++++++-
 arch/arm/include/asm/futex.h     |    9 ++--
 arch/arm/include/asm/uaccess.h   |   16 ++++---
 arch/arm/kernel/entry-armv.S     |    4 +-
 arch/arm/kernel/traps.c          |   17 ++++++++
 arch/arm/lib/getuser.S           |   13 +++---
 arch/arm/lib/putuser.S           |   29 +++++++------
 arch/arm/lib/uaccess.S           |   83 +++++++++++++++++++-------------------
 arch/arm/mm/Kconfig              |    9 ++++
 arch/arm/mm/proc-v7.S            |    2 -
 11 files changed, 139 insertions(+), 83 deletions(-)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 00f46d9..4b82143 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -18,6 +18,7 @@
 #endif
 
 #include <asm/ptrace.h>
+#include <asm/domain.h>
 
 /*
  * Endian independent macros for shifting bytes within registers.
@@ -186,9 +187,9 @@
 	.macro	usraccoff, instr, reg, ptr, inc, off, cond, abort
 9999:
 	.if	\inc == 1
-	\instr\cond\()bt \reg, [\ptr, #\off]
+	T(\instr\cond\()b) \reg, [\ptr, #\off]
 	.elseif	\inc == 4
-	\instr\cond\()t \reg, [\ptr, #\off]
+	T(\instr\cond\()) \reg, [\ptr, #\off]
 	.else
 	.error	"Unsupported inc macro argument"
 	.endif
@@ -227,9 +228,9 @@
 	.rept	\rept
 9999:
 	.if	\inc == 1
-	\instr\cond\()bt \reg, [\ptr], #\inc
+	T(\instr\cond\()b) \reg, [\ptr], #\inc
 	.elseif	\inc == 4
-	\instr\cond\()t \reg, [\ptr], #\inc
+	T(\instr\cond\()) \reg, [\ptr], #\inc
 	.else
 	.error	"Unsupported inc macro argument"
 	.endif
diff --git a/arch/arm/include/asm/domain.h b/arch/arm/include/asm/domain.h
index cc7ef40..af18cea 100644
--- a/arch/arm/include/asm/domain.h
+++ b/arch/arm/include/asm/domain.h
@@ -45,13 +45,17 @@
  */
 #define DOMAIN_NOACCESS	0
 #define DOMAIN_CLIENT	1
+#ifdef CONFIG_CPU_USE_DOMAINS
 #define DOMAIN_MANAGER	3
+#else
+#define DOMAIN_MANAGER	1
+#endif
 
 #define domain_val(dom,type)	((type) << (2*(dom)))
 
 #ifndef __ASSEMBLY__
 
-#ifdef CONFIG_MMU
+#ifdef CONFIG_CPU_USE_DOMAINS
 #define set_domain(x)					\
 	do {						\
 	__asm__ __volatile__(				\
@@ -74,5 +78,28 @@
 #define modify_domain(dom,type)	do { } while (0)
 #endif
 
+/*
+ * Generate the T (user) versions of the LDR/STR and related
+ * instructions (inline assembly)
+ */
+#ifdef CONFIG_CPU_USE_DOMAINS
+#define T(instr)	#instr "t"
+#else
+#define T(instr)	#instr
 #endif
-#endif /* !__ASSEMBLY__ */
+
+#else /* __ASSEMBLY__ */
+
+/*
+ * Generate the T (user) versions of the LDR/STR and related
+ * instructions
+ */
+#ifdef CONFIG_CPU_USE_DOMAINS
+#define T(instr)	instr ## t
+#else
+#define T(instr)	instr
+#endif
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* !__ASM_PROC_DOMAIN_H */
diff --git a/arch/arm/include/asm/futex.h b/arch/arm/include/asm/futex.h
index bfcc159..8d868bd 100644
--- a/arch/arm/include/asm/futex.h
+++ b/arch/arm/include/asm/futex.h
@@ -13,12 +13,13 @@
 #include <linux/preempt.h>
 #include <linux/uaccess.h>
 #include <asm/errno.h>
+#include <asm/domain.h>
 
 #define __futex_atomic_op(insn, ret, oldval, uaddr, oparg)	\
 	__asm__ __volatile__(					\
-	"1:	ldrt	%1, [%2]\n"				\
+	"1:	" T(ldr) "	%1, [%2]\n"			\
 	"	" insn "\n"					\
-	"2:	strt	%0, [%2]\n"				\
+	"2:	" T(str) "	%0, [%2]\n"			\
 	"	mov	%0, #0\n"				\
 	"3:\n"							\
 	"	.section __ex_table,\"a\"\n"			\
@@ -97,10 +98,10 @@ futex_atomic_cmpxchg_inatomic(int __user *uaddr, int oldval, int newval)
 	pagefault_disable();	/* implies preempt_disable() */
 
 	__asm__ __volatile__("@futex_atomic_cmpxchg_inatomic\n"
-	"1:	ldrt	%0, [%3]\n"
+	"1:	" T(ldr) "	%0, [%3]\n"
 	"	teq	%0, %1\n"
 	"	it	eq	@ explicit IT needed for the 2b label\n"
-	"2:	streqt	%2, [%3]\n"
+	"2:	" T(streq) "	%2, [%3]\n"
 	"3:\n"
 	"	.section __ex_table,\"a\"\n"
 	"	.align	3\n"
diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index 1d6bd40..e4d0905 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -227,7 +227,7 @@ do {									\
 
 #define __get_user_asm_byte(x,addr,err)				\
 	__asm__ __volatile__(					\
-	"1:	ldrbt	%1,[%2]\n"				\
+	"1:	" T(ldrb) "	%1,[%2],#0\n"			\
 	"2:\n"							\
 	"	.section .fixup,\"ax\"\n"			\
 	"	.align	2\n"					\
@@ -263,7 +263,7 @@ do {									\
 
 #define __get_user_asm_word(x,addr,err)				\
 	__asm__ __volatile__(					\
-	"1:	ldrt	%1,[%2]\n"				\
+	"1:	" T(ldr) "	%1,[%2],#0\n"			\
 	"2:\n"							\
 	"	.section .fixup,\"ax\"\n"			\
 	"	.align	2\n"					\
@@ -308,7 +308,7 @@ do {									\
 
 #define __put_user_asm_byte(x,__pu_addr,err)			\
 	__asm__ __volatile__(					\
-	"1:	strbt	%1,[%2]\n"				\
+	"1:	" T(strb) "	%1,[%2],#0\n"			\
 	"2:\n"							\
 	"	.section .fixup,\"ax\"\n"			\
 	"	.align	2\n"					\
@@ -341,7 +341,7 @@ do {									\
 
 #define __put_user_asm_word(x,__pu_addr,err)			\
 	__asm__ __volatile__(					\
-	"1:	strt	%1,[%2]\n"				\
+	"1:	" T(str) "	%1,[%2],#0\n"			\
 	"2:\n"							\
 	"	.section .fixup,\"ax\"\n"			\
 	"	.align	2\n"					\
@@ -366,10 +366,10 @@ do {									\
 
 #define __put_user_asm_dword(x,__pu_addr,err)			\
 	__asm__ __volatile__(					\
- ARM(	"1:	strt	" __reg_oper1 ", [%1], #4\n"	)	\
- ARM(	"2:	strt	" __reg_oper0 ", [%1]\n"	)	\
- THUMB(	"1:	strt	" __reg_oper1 ", [%1]\n"	)	\
- THUMB(	"2:	strt	" __reg_oper0 ", [%1, #4]\n"	)	\
+ ARM(	"1:	" T(str) "	" __reg_oper1 ", [%1], #4\n"	)	\
+ ARM(	"2:	" T(str) "	" __reg_oper0 ", [%1]\n"	)	\
+ THUMB(	"1:	" T(str) "	" __reg_oper1 ", [%1]\n"	)	\
+ THUMB(	"2:	" T(str) "	" __reg_oper0 ", [%1, #4]\n"	)	\
 	"3:\n"							\
 	"	.section .fixup,\"ax\"\n"			\
 	"	.align	2\n"					\
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index d2903e3..1b31ecb 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -736,7 +736,7 @@ ENTRY(__switch_to)
  THUMB(	stmia	ip!, {r4 - sl, fp}	   )	@ Store most regs on stack
  THUMB(	str	sp, [ip], #4		   )
  THUMB(	str	lr, [ip], #4		   )
-#ifdef CONFIG_MMU
+#ifdef CONFIG_CPU_USE_DOMAINS
 	ldr	r6, [r2, #TI_CPU_DOMAIN]
 #endif
 #if defined(CONFIG_HAS_TLS_REG)
@@ -745,7 +745,7 @@ ENTRY(__switch_to)
 	mov	r4, #0xffff0fff
 	str	r3, [r4, #-15]			@ TLS val at 0xffff0ff0
 #endif
-#ifdef CONFIG_MMU
+#ifdef CONFIG_CPU_USE_DOMAINS
 	mcr	p15, 0, r6, c3, c0, 0		@ Set domain register
 #endif
 	mov	r5, r0
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 3f361a7..23d7673 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -28,6 +28,7 @@
 #include <asm/unistd.h>
 #include <asm/traps.h>
 #include <asm/unwind.h>
+#include <asm/tlbflush.h>
 
 #include "ptrace.h"
 #include "signal.h"
@@ -735,6 +736,16 @@ void __init early_trap_init(void)
 	extern char __vectors_start[], __vectors_end[];
 	extern char __kuser_helper_start[], __kuser_helper_end[];
 	int kuser_sz = __kuser_helper_end - __kuser_helper_start;
+#ifndef CONFIG_CPU_USE_DOMAINS
+	pgd_t *pgd = pgd_offset_k(vectors);
+	pmd_t *pmd = pmd_offset(pgd, vectors);
+	pte_t *pte = pte_offset_kernel(pmd, vectors);
+	pte_t entry = *pte;
+
+	/* allow writing to the vectors page */
+	set_pte_ext(pte, pte_mkwrite(entry), 0);
+	local_flush_tlb_kernel_page(vectors);
+#endif
 
 	/*
 	 * Copy the vectors, stubs and kuser helpers (in entry-armv.S)
@@ -754,6 +765,12 @@ void __init early_trap_init(void)
 	memcpy((void *)KERN_RESTART_CODE, syscall_restart_code,
 	       sizeof(syscall_restart_code));
 
+#ifndef CONFIG_CPU_USE_DOMAINS
+	/* restore the vectors page permissions */
+	set_pte_ext(pte, entry, 0);
+	local_flush_tlb_kernel_page(vectors);
+#endif
+
 	flush_icache_range(vectors, vectors + PAGE_SIZE);
 	modify_domain(DOMAIN_USER, DOMAIN_CLIENT);
 }
diff --git a/arch/arm/lib/getuser.S b/arch/arm/lib/getuser.S
index a1814d9..acc966b 100644
--- a/arch/arm/lib/getuser.S
+++ b/arch/arm/lib/getuser.S
@@ -28,20 +28,21 @@
  */
 #include <linux/linkage.h>
 #include <asm/errno.h>
+#include <asm/domain.h>
 
 ENTRY(__get_user_1)
-1:	ldrbt	r2, [r0]
+1:	T(ldrb)	r2, [r0]
 	mov	r0, #0
 	mov	pc, lr
 ENDPROC(__get_user_1)
 
 ENTRY(__get_user_2)
 #ifdef CONFIG_THUMB2_KERNEL
-2:	ldrbt	r2, [r0]
-3:	ldrbt	r3, [r0, #1]
+2:	T(ldrb)	r2, [r0]
+3:	T(ldrb)	r3, [r0, #1]
 #else
-2:	ldrbt	r2, [r0], #1
-3:	ldrbt	r3, [r0]
+2:	T(ldrb)	r2, [r0], #1
+3:	T(ldrb)	r3, [r0]
 #endif
 #ifndef __ARMEB__
 	orr	r2, r2, r3, lsl #8
@@ -53,7 +54,7 @@ ENTRY(__get_user_2)
 ENDPROC(__get_user_2)
 
 ENTRY(__get_user_4)
-4:	ldrt	r2, [r0]
+4:	T(ldr)	r2, [r0]
 	mov	r0, #0
 	mov	pc, lr
 ENDPROC(__get_user_4)
diff --git a/arch/arm/lib/putuser.S b/arch/arm/lib/putuser.S
index 02fedbf..95b3fe8 100644
--- a/arch/arm/lib/putuser.S
+++ b/arch/arm/lib/putuser.S
@@ -28,9 +28,10 @@
  */
 #include <linux/linkage.h>
 #include <asm/errno.h>
+#include <asm/domain.h>
 
 ENTRY(__put_user_1)
-1:	strbt	r2, [r0]
+1:	T(strb)	r2, [r0]
 	mov	r0, #0
 	mov	pc, lr
 ENDPROC(__put_user_1)
@@ -39,19 +40,19 @@ ENTRY(__put_user_2)
 	mov	ip, r2, lsr #8
 #ifdef CONFIG_THUMB2_KERNEL
 #ifndef __ARMEB__
-2:	strbt	r2, [r0]
-3:	strbt	ip, [r0, #1]
+2:	T(strb)	r2, [r0]
+3:	T(strb)	ip, [r0, #1]
 #else
-2:	strbt	ip, [r0]
-3:	strbt	r2, [r0, #1]
+2:	T(strb)	ip, [r0]
+3:	T(strb)	r2, [r0, #1]
 #endif
 #else	/* !CONFIG_THUMB2_KERNEL */
 #ifndef __ARMEB__
-2:	strbt	r2, [r0], #1
-3:	strbt	ip, [r0]
+2:	T(strb)	r2, [r0], #1
+3:	T(strb)	ip, [r0]
 #else
-2:	strbt	ip, [r0], #1
-3:	strbt	r2, [r0]
+2:	T(strb)	ip, [r0], #1
+3:	T(strb)	r2, [r0]
 #endif
 #endif	/* CONFIG_THUMB2_KERNEL */
 	mov	r0, #0
@@ -59,18 +60,18 @@ ENTRY(__put_user_2)
 ENDPROC(__put_user_2)
 
 ENTRY(__put_user_4)
-4:	strt	r2, [r0]
+4:	T(str)	r2, [r0]
 	mov	r0, #0
 	mov	pc, lr
 ENDPROC(__put_user_4)
 
 ENTRY(__put_user_8)
 #ifdef CONFIG_THUMB2_KERNEL
-5:	strt	r2, [r0]
-6:	strt	r3, [r0, #4]
+5:	T(str)	r2, [r0]
+6:	T(str)	r3, [r0, #4]
 #else
-5:	strt	r2, [r0], #4
-6:	strt	r3, [r0]
+5:	T(str)	r2, [r0], #4
+6:	T(str)	r3, [r0]
 #endif
 	mov	r0, #0
 	mov	pc, lr
diff --git a/arch/arm/lib/uaccess.S b/arch/arm/lib/uaccess.S
index ffdd274..e47cdfd 100644
--- a/arch/arm/lib/uaccess.S
+++ b/arch/arm/lib/uaccess.S
@@ -14,6 +14,7 @@
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/errno.h>
+#include <asm/domain.h>
 
 		.text
 
@@ -31,11 +32,11 @@
 		rsb	ip, ip, #4
 		cmp	ip, #2
 		ldrb	r3, [r1], #1
-USER(		strbt	r3, [r0], #1)			@ May fault
+USER(		T(strb)	r3, [r0], #1)			@ May fault
 		ldrgeb	r3, [r1], #1
-USER(		strgebt	r3, [r0], #1)			@ May fault
+USER(		T(strgeb) r3, [r0], #1)			@ May fault
 		ldrgtb	r3, [r1], #1
-USER(		strgtbt	r3, [r0], #1)			@ May fault
+USER(		T(strgtb) r3, [r0], #1)			@ May fault
 		sub	r2, r2, ip
 		b	.Lc2u_dest_aligned
 
@@ -58,7 +59,7 @@ ENTRY(__copy_to_user)
 		addmi	ip, r2, #4
 		bmi	.Lc2u_0nowords
 		ldr	r3, [r1], #4
-USER(		strt	r3, [r0], #4)			@ May fault
+USER(		T(str)	r3, [r0], #4)			@ May fault
 		mov	ip, r0, lsl #32 - PAGE_SHIFT	@ On each page, use a ld/st??t instruction
 		rsb	ip, ip, #0
 		movs	ip, ip, lsr #32 - PAGE_SHIFT
@@ -87,18 +88,18 @@ USER(		strt	r3, [r0], #4)			@ May fault
 		stmneia	r0!, {r3 - r4}			@ Shouldnt fault
 		tst	ip, #4
 		ldrne	r3, [r1], #4
-		strnet	r3, [r0], #4			@ Shouldnt fault
+		T(strne) r3, [r0], #4			@ Shouldnt fault
 		ands	ip, ip, #3
 		beq	.Lc2u_0fupi
 .Lc2u_0nowords:	teq	ip, #0
 		beq	.Lc2u_finished
 .Lc2u_nowords:	cmp	ip, #2
 		ldrb	r3, [r1], #1
-USER(		strbt	r3, [r0], #1)			@ May fault
+USER(		T(strb)	r3, [r0], #1)			@ May fault
 		ldrgeb	r3, [r1], #1
-USER(		strgebt	r3, [r0], #1)			@ May fault
+USER(		T(strgeb) r3, [r0], #1)			@ May fault
 		ldrgtb	r3, [r1], #1
-USER(		strgtbt	r3, [r0], #1)			@ May fault
+USER(		T(strgtb) r3, [r0], #1)			@ May fault
 		b	.Lc2u_finished
 
 .Lc2u_not_enough:
@@ -119,7 +120,7 @@ USER(		strgtbt	r3, [r0], #1)			@ May fault
 		mov	r3, r7, pull #8
 		ldr	r7, [r1], #4
 		orr	r3, r3, r7, push #24
-USER(		strt	r3, [r0], #4)			@ May fault
+USER(		T(str)	r3, [r0], #4)			@ May fault
 		mov	ip, r0, lsl #32 - PAGE_SHIFT
 		rsb	ip, ip, #0
 		movs	ip, ip, lsr #32 - PAGE_SHIFT
@@ -154,18 +155,18 @@ USER(		strt	r3, [r0], #4)			@ May fault
 		movne	r3, r7, pull #8
 		ldrne	r7, [r1], #4
 		orrne	r3, r3, r7, push #24
-		strnet	r3, [r0], #4			@ Shouldnt fault
+		T(strne) r3, [r0], #4			@ Shouldnt fault
 		ands	ip, ip, #3
 		beq	.Lc2u_1fupi
 .Lc2u_1nowords:	mov	r3, r7, get_byte_1
 		teq	ip, #0
 		beq	.Lc2u_finished
 		cmp	ip, #2
-USER(		strbt	r3, [r0], #1)			@ May fault
+USER(		T(strb)	r3, [r0], #1)			@ May fault
 		movge	r3, r7, get_byte_2
-USER(		strgebt	r3, [r0], #1)			@ May fault
+USER(		T(strgeb) r3, [r0], #1)			@ May fault
 		movgt	r3, r7, get_byte_3
-USER(		strgtbt	r3, [r0], #1)			@ May fault
+USER(		T(strgtb) r3, [r0], #1)			@ May fault
 		b	.Lc2u_finished
 
 .Lc2u_2fupi:	subs	r2, r2, #4
@@ -174,7 +175,7 @@ USER(		strgtbt	r3, [r0], #1)			@ May fault
 		mov	r3, r7, pull #16
 		ldr	r7, [r1], #4
 		orr	r3, r3, r7, push #16
-USER(		strt	r3, [r0], #4)			@ May fault
+USER(		T(str)	r3, [r0], #4)			@ May fault
 		mov	ip, r0, lsl #32 - PAGE_SHIFT
 		rsb	ip, ip, #0
 		movs	ip, ip, lsr #32 - PAGE_SHIFT
@@ -209,18 +210,18 @@ USER(		strt	r3, [r0], #4)			@ May fault
 		movne	r3, r7, pull #16
 		ldrne	r7, [r1], #4
 		orrne	r3, r3, r7, push #16
-		strnet	r3, [r0], #4			@ Shouldnt fault
+		T(strne) r3, [r0], #4			@ Shouldnt fault
 		ands	ip, ip, #3
 		beq	.Lc2u_2fupi
 .Lc2u_2nowords:	mov	r3, r7, get_byte_2
 		teq	ip, #0
 		beq	.Lc2u_finished
 		cmp	ip, #2
-USER(		strbt	r3, [r0], #1)			@ May fault
+USER(		T(strb)	r3, [r0], #1)			@ May fault
 		movge	r3, r7, get_byte_3
-USER(		strgebt	r3, [r0], #1)			@ May fault
+USER(		T(strgeb) r3, [r0], #1)			@ May fault
 		ldrgtb	r3, [r1], #0
-USER(		strgtbt	r3, [r0], #1)			@ May fault
+USER(		T(strgtb) r3, [r0], #1)			@ May fault
 		b	.Lc2u_finished
 
 .Lc2u_3fupi:	subs	r2, r2, #4
@@ -229,7 +230,7 @@ USER(		strgtbt	r3, [r0], #1)			@ May fault
 		mov	r3, r7, pull #24
 		ldr	r7, [r1], #4
 		orr	r3, r3, r7, push #8
-USER(		strt	r3, [r0], #4)			@ May fault
+USER(		T(str)	r3, [r0], #4)			@ May fault
 		mov	ip, r0, lsl #32 - PAGE_SHIFT
 		rsb	ip, ip, #0
 		movs	ip, ip, lsr #32 - PAGE_SHIFT
@@ -264,18 +265,18 @@ USER(		strt	r3, [r0], #4)			@ May fault
 		movne	r3, r7, pull #24
 		ldrne	r7, [r1], #4
 		orrne	r3, r3, r7, push #8
-		strnet	r3, [r0], #4			@ Shouldnt fault
+		T(strne) r3, [r0], #4			@ Shouldnt fault
 		ands	ip, ip, #3
 		beq	.Lc2u_3fupi
 .Lc2u_3nowords:	mov	r3, r7, get_byte_3
 		teq	ip, #0
 		beq	.Lc2u_finished
 		cmp	ip, #2
-USER(		strbt	r3, [r0], #1)			@ May fault
+USER(		T(strb)	r3, [r0], #1)			@ May fault
 		ldrgeb	r3, [r1], #1
-USER(		strgebt	r3, [r0], #1)			@ May fault
+USER(		T(strgeb) r3, [r0], #1)			@ May fault
 		ldrgtb	r3, [r1], #0
-USER(		strgtbt	r3, [r0], #1)			@ May fault
+USER(		T(strgtb) r3, [r0], #1)			@ May fault
 		b	.Lc2u_finished
 ENDPROC(__copy_to_user)
 
@@ -294,11 +295,11 @@ ENDPROC(__copy_to_user)
 .Lcfu_dest_not_aligned:
 		rsb	ip, ip, #4
 		cmp	ip, #2
-USER(		ldrbt	r3, [r1], #1)			@ May fault
+USER(		T(ldrb)	r3, [r1], #1)			@ May fault
 		strb	r3, [r0], #1
-USER(		ldrgebt	r3, [r1], #1)			@ May fault
+USER(		T(ldrgeb) r3, [r1], #1)			@ May fault
 		strgeb	r3, [r0], #1
-USER(		ldrgtbt	r3, [r1], #1)			@ May fault
+USER(		T(ldrgtb) r3, [r1], #1)			@ May fault
 		strgtb	r3, [r0], #1
 		sub	r2, r2, ip
 		b	.Lcfu_dest_aligned
@@ -321,7 +322,7 @@ ENTRY(__copy_from_user)
 .Lcfu_0fupi:	subs	r2, r2, #4
 		addmi	ip, r2, #4
 		bmi	.Lcfu_0nowords
-USER(		ldrt	r3, [r1], #4)
+USER(		T(ldr)	r3, [r1], #4)
 		str	r3, [r0], #4
 		mov	ip, r1, lsl #32 - PAGE_SHIFT	@ On each page, use a ld/st??t instruction
 		rsb	ip, ip, #0
@@ -350,18 +351,18 @@ USER(		ldrt	r3, [r1], #4)
 		ldmneia	r1!, {r3 - r4}			@ Shouldnt fault
 		stmneia	r0!, {r3 - r4}
 		tst	ip, #4
-		ldrnet	r3, [r1], #4			@ Shouldnt fault
+		T(ldrne) r3, [r1], #4			@ Shouldnt fault
 		strne	r3, [r0], #4
 		ands	ip, ip, #3
 		beq	.Lcfu_0fupi
 .Lcfu_0nowords:	teq	ip, #0
 		beq	.Lcfu_finished
 .Lcfu_nowords:	cmp	ip, #2
-USER(		ldrbt	r3, [r1], #1)			@ May fault
+USER(		T(ldrb)	r3, [r1], #1)			@ May fault
 		strb	r3, [r0], #1
-USER(		ldrgebt	r3, [r1], #1)			@ May fault
+USER(		T(ldrgeb) r3, [r1], #1)			@ May fault
 		strgeb	r3, [r0], #1
-USER(		ldrgtbt	r3, [r1], #1)			@ May fault
+USER(		T(ldrgtb) r3, [r1], #1)			@ May fault
 		strgtb	r3, [r0], #1
 		b	.Lcfu_finished
 
@@ -374,7 +375,7 @@ USER(		ldrgtbt	r3, [r1], #1)			@ May fault
 
 .Lcfu_src_not_aligned:
 		bic	r1, r1, #3
-USER(		ldrt	r7, [r1], #4)			@ May fault
+USER(		T(ldr)	r7, [r1], #4)			@ May fault
 		cmp	ip, #2
 		bgt	.Lcfu_3fupi
 		beq	.Lcfu_2fupi
@@ -382,7 +383,7 @@ USER(		ldrt	r7, [r1], #4)			@ May fault
 		addmi	ip, r2, #4
 		bmi	.Lcfu_1nowords
 		mov	r3, r7, pull #8
-USER(		ldrt	r7, [r1], #4)			@ May fault
+USER(		T(ldr)	r7, [r1], #4)			@ May fault
 		orr	r3, r3, r7, push #24
 		str	r3, [r0], #4
 		mov	ip, r1, lsl #32 - PAGE_SHIFT
@@ -417,7 +418,7 @@ USER(		ldrt	r7, [r1], #4)			@ May fault
 		stmneia	r0!, {r3 - r4}
 		tst	ip, #4
 		movne	r3, r7, pull #8
-USER(		ldrnet	r7, [r1], #4)			@ May fault
+USER(		T(ldrne) r7, [r1], #4)			@ May fault
 		orrne	r3, r3, r7, push #24
 		strne	r3, [r0], #4
 		ands	ip, ip, #3
@@ -437,7 +438,7 @@ USER(		ldrnet	r7, [r1], #4)			@ May fault
 		addmi	ip, r2, #4
 		bmi	.Lcfu_2nowords
 		mov	r3, r7, pull #16
-USER(		ldrt	r7, [r1], #4)			@ May fault
+USER(		T(ldr)	r7, [r1], #4)			@ May fault
 		orr	r3, r3, r7, push #16
 		str	r3, [r0], #4
 		mov	ip, r1, lsl #32 - PAGE_SHIFT
@@ -473,7 +474,7 @@ USER(		ldrt	r7, [r1], #4)			@ May fault
 		stmneia	r0!, {r3 - r4}
 		tst	ip, #4
 		movne	r3, r7, pull #16
-USER(		ldrnet	r7, [r1], #4)			@ May fault
+USER(		T(ldrne) r7, [r1], #4)			@ May fault
 		orrne	r3, r3, r7, push #16
 		strne	r3, [r0], #4
 		ands	ip, ip, #3
@@ -485,7 +486,7 @@ USER(		ldrnet	r7, [r1], #4)			@ May fault
 		strb	r3, [r0], #1
 		movge	r3, r7, get_byte_3
 		strgeb	r3, [r0], #1
-USER(		ldrgtbt	r3, [r1], #0)			@ May fault
+USER(		T(ldrgtb) r3, [r1], #0)			@ May fault
 		strgtb	r3, [r0], #1
 		b	.Lcfu_finished
 
@@ -493,7 +494,7 @@ USER(		ldrgtbt	r3, [r1], #0)			@ May fault
 		addmi	ip, r2, #4
 		bmi	.Lcfu_3nowords
 		mov	r3, r7, pull #24
-USER(		ldrt	r7, [r1], #4)			@ May fault
+USER(		T(ldr)	r7, [r1], #4)			@ May fault
 		orr	r3, r3, r7, push #8
 		str	r3, [r0], #4
 		mov	ip, r1, lsl #32 - PAGE_SHIFT
@@ -528,7 +529,7 @@ USER(		ldrt	r7, [r1], #4)			@ May fault
 		stmneia	r0!, {r3 - r4}
 		tst	ip, #4
 		movne	r3, r7, pull #24
-USER(		ldrnet	r7, [r1], #4)			@ May fault
+USER(		T(ldrne) r7, [r1], #4)			@ May fault
 		orrne	r3, r3, r7, push #8
 		strne	r3, [r0], #4
 		ands	ip, ip, #3
@@ -538,9 +539,9 @@ USER(		ldrnet	r7, [r1], #4)			@ May fault
 		beq	.Lcfu_finished
 		cmp	ip, #2
 		strb	r3, [r0], #1
-USER(		ldrgebt	r3, [r1], #1)			@ May fault
+USER(		T(ldrgeb) r3, [r1], #1)			@ May fault
 		strgeb	r3, [r0], #1
-USER(		ldrgtbt	r3, [r1], #1)			@ May fault
+USER(		T(ldrgtb) r3, [r1], #1)			@ May fault
 		strgtb	r3, [r0], #1
 		b	.Lcfu_finished
 ENDPROC(__copy_from_user)
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 56aadfa..8bc0421 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -618,6 +618,15 @@ config CPU_CP15_MPU
 	help
 	  Processor has the CP15 register, which has MPU related registers.
 
+config CPU_USE_DOMAINS
+	bool
+	depends on MMU
+	default n if HAS_TLS_REG
+	default y
+	help
+	  This option enables or disable the use of domain switching
+	  via the set_fs() function.
+
 #
 # CPU supports 36-bit I/O
 #
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 568ccfc..f0fc850 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -223,8 +223,6 @@ __v7_setup:
 	mcr	p15, 0, r10, c2, c0, 2		@ TTB control register
 	orr	r4, r4, #TTB_FLAGS
 	mcr	p15, 0, r4, c2, c0, 1		@ load TTB1
-	mov	r10, #0x1f			@ domains 0, 1 = manager
-	mcr	p15, 0, r10, c3, c0, 0		@ load domain access register
 	/*
 	 * Memory region attributes with SCTLR.TRE=1
 	 *
