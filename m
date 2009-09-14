From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 14 Sep 2009 13:21:21 +0100
Subject: LDREX/STREX and pre-emption on SMP hardware
In-Reply-To: <1252928832.16853.96.camel@pc1117.cambridge.arm.com>
References: <4A8EB836.3000406@plxtech.com>
	<1250869355.10642.10.camel@pc1117.cambridge.arm.com>
	<20090821155011.GB8583@shareable.org>
	<1250870319.10642.23.camel@pc1117.cambridge.arm.com>
	<1250890146.29685.18.camel@david-laptop>
	<1251128692.28977.17.camel@pc1117.cambridge.arm.com>
	<1251134043.31975.23.camel@david-laptop>
	<1251135709.28977.40.camel@pc1117.cambridge.arm.com>
	<20090914014353.GA4762@shareable.org>
	<20090914100056.GC16644@n2100.arm.linux.org.uk>
	<1252922773.16853.62.camel@pc1117.cambridge.arm.com>
	<1252928832.16853.96.camel@pc1117.cambridge.arm.com>
Message-ID: <1252930881.16853.99.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2009-09-14 at 12:47 +0100, Catalin Marinas wrote:
> On Mon, 2009-09-14 at 11:06 +0100, Catalin Marinas wrote:
> > On Mon, 2009-09-14 at 11:00 +0100, Russell King - ARM Linux wrote:
> > > It doesn't matter though - consider two threads using LDREX on the same
> > > location:
> > > 
> > > 	T1		T2
> > > 	LDREX
> > > 			LDREX
> > > 			STREXEQ (not satsified)
> > > 	STREX
> > 
> > As I replied to Jamie on a similar issue, you can have:
> > 
> > T1			T2
> > LDREX
> > 			LDREX
> > 			STREXEQ (satisfied, succeeds)
> > 			LDREX
> > 			STREXEQ (not satisfied)
> > STREX (succeeds)
> > 
> > Though this may be an unlikely sequence.
> 
> Searching for STREXEQ, it looks like there are several other locking
> functions using it in spinlock.h. Do we have a real problem with these?

And here's an untested patch to clear the exclusive monitor on the
exception return path. If you are OK with the idea, I'll do some testing
before pushing it for upstream:


Clear the exclusive monitor when returning from an exception

From: Catalin Marinas <catalin.marinas@arm.com>

The patch adds a CLREX or dummy STREX to the exception return path. This
is needed because several atomic/locking operations use a pair of
LDREX/STREXEQ and the EQ condition may not always be satisfied. This
would leave the exclusive monitor status set and may cause problems with
atomic/locking operations in the interrupted code.

With this patch, the atomic_set() operation can be a simple STR
instruction (on SMP systems, the global exclusive monitor is cleared by
STR anyway). Clearing the exclusive monitor during context switch is no
longer needed as this is handled by the exception return path anyway.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Jamie Lokier <jamie@shareable.org>
---
 arch/arm/include/asm/atomic.h  |   21 ++-------------------
 arch/arm/kernel/entry-armv.S   |    7 -------
 arch/arm/kernel/entry-header.S |   12 ++++++++++++
 3 files changed, 14 insertions(+), 26 deletions(-)

diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
index 9ed2377..74045f4 100644
--- a/arch/arm/include/asm/atomic.h
+++ b/arch/arm/include/asm/atomic.h
@@ -20,30 +20,15 @@
 #ifdef __KERNEL__
 
 #define atomic_read(v)	((v)->counter)
+#define atomic_set(v,i)	(((v)->counter) = (i))
 
 #if __LINUX_ARM_ARCH__ >= 6
 
 /*
  * ARMv6 UP and SMP safe atomic ops.  We use load exclusive and
  * store exclusive to ensure that these are atomic.  We may loop
- * to ensure that the update happens.  Writing to 'v->counter'
- * without using the following operations WILL break the atomic
- * nature of these ops.
+ * to ensure that the update happens.
  */
-static inline void atomic_set(atomic_t *v, int i)
-{
-	unsigned long tmp;
-
-	__asm__ __volatile__("@ atomic_set\n"
-"1:	ldrex	%0, [%1]\n"
-"	strex	%0, %2, [%1]\n"
-"	teq	%0, #0\n"
-"	bne	1b"
-	: "=&r" (tmp)
-	: "r" (&v->counter), "r" (i)
-	: "cc");
-}
-
 static inline void atomic_add(int i, atomic_t *v)
 {
 	unsigned long tmp;
@@ -163,8 +148,6 @@ static inline void atomic_clear_mask(unsigned long mask, unsigned long *addr)
 #error SMP not supported on pre-ARMv6 CPUs
 #endif
 
-#define atomic_set(v,i)	(((v)->counter) = (i))
-
 static inline int atomic_add_return(int i, atomic_t *v)
 {
 	unsigned long flags;
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 468425f..a7196d2 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -736,13 +736,6 @@ ENTRY(__switch_to)
 #ifdef CONFIG_MMU
 	ldr	r6, [r2, #TI_CPU_DOMAIN]
 #endif
-#if __LINUX_ARM_ARCH__ >= 6
-#ifdef CONFIG_CPU_32v6K
-	clrex
-#else
-	strex	r5, r4, [ip]			@ Clear exclusive monitor
-#endif
-#endif
 #if defined(CONFIG_HAS_TLS_REG)
 	mcr	p15, 0, r3, c13, c0, 3		@ set TLS register
 #elif !defined(CONFIG_TLS_REG_EMUL)
diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index a4eaf4f..24875db 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -75,11 +75,21 @@
 
 #ifndef CONFIG_THUMB2_KERNEL
 	.macro	svc_exit, rpsr
+#ifdef CONFIG_CPU_32v6K
+	clrex					@ clear the exclusive monitor
+#else
+	strex	r0, r1, [sp, #-4]		@ clear the exclusive monitor
+#endif
 	msr	spsr_cxsf, \rpsr
 	ldmia	sp, {r0 - pc}^			@ load r0 - pc, cpsr
 	.endm
 
 	.macro	restore_user_regs, fast = 0, offset = 0
+#ifdef CONFIG_CPU_32v6K
+	clrex					@ clear the exclusive monitor
+#else
+	strex	r1, lr, [sp, #-4]		@ clear the exclusive monitor
+#endif
 	ldr	r1, [sp, #\offset + S_PSR]	@ get calling cpsr
 	ldr	lr, [sp, #\offset + S_PC]!	@ get pc
 	msr	spsr_cxsf, r1			@ save in spsr_svc
@@ -98,6 +108,7 @@
 	.endm
 #else	/* CONFIG_THUMB2_KERNEL */
 	.macro	svc_exit, rpsr
+	clrex					@ clear the exclusive monitor
 	ldr	r0, [sp, #S_SP]			@ top of the stack
 	ldr	r1, [sp, #S_PC]			@ return address
 	tst	r0, #4				@ orig stack 8-byte aligned?
@@ -110,6 +121,7 @@
 	.endm
 
 	.macro	restore_user_regs, fast = 0, offset = 0
+	clrex					@ clear the exclusive monitor
 	mov	r2, sp
 	load_user_sp_lr r2, r3, \offset + S_SP	@ calling sp, lr
 	ldr	r1, [sp, #\offset + S_PSR]	@ get calling cpsr


-- 
Catalin
