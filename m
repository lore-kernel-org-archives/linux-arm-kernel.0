From: nico@fluxnic.net (Nicolas Pitre)
Date: Sun, 19 Jun 2011 12:54:54 -0400
Subject: [PATCH 2/2] ARM: add a kuser_cmpxchg64 user space helper
In-Reply-To: <1308502494-20938-1-git-send-email-nico@fluxnic.net>
References: <1308502494-20938-1-git-send-email-nico@fluxnic.net>
Message-ID: <1308502494-20938-3-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nicolas.pitre@linaro.org>

Some user space applications are designed around the ability to perform
atomic operations on 64 bit values.  Since this is natively possible
only with ARMv6k and above, let's provide a new kuser helper to perform
the operation with kernel supervision on pre ARMv6k hardware.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 Documentation/arm/kernel_user_helpers.txt |   64 +++++++++++++++++++
 arch/arm/kernel/entry-armv.S              |   99 ++++++++++++++++++++++++++++-
 2 files changed, 160 insertions(+), 3 deletions(-)

diff --git a/Documentation/arm/kernel_user_helpers.txt b/Documentation/arm/kernel_user_helpers.txt
index fa42426..eecf140 100644
--- a/Documentation/arm/kernel_user_helpers.txt
+++ b/Documentation/arm/kernel_user_helpers.txt
@@ -202,3 +202,67 @@ Notes:
 
   - Valid only if __kuser_helper_version >= 3 (from kernel version 2.6.15).
 
+kuser_cmpxchg64
+---------------
+
+Location:	0xffff0f60
+
+Reference prototype:
+
+  int __kuser_cmpxchg64(const int64_t *oldval,
+                        const int64_t *newval,
+                        volatile int64_t *ptr);
+
+Input:
+
+  r0 = pointer to oldval
+  r1 = pointer to newval
+  r2 = pointer to target value
+  lr = return address
+
+Output:
+
+  r0 = success code (zero or non-zero)
+  C flag = set if r0 == 0, clear if r0 != 0
+
+Clobbered registers:
+
+  r3, lr, flags
+
+Definition:
+
+  Atomically store the 64-bit value pointed by *newval in *ptr only if *ptr
+  is equal to the 64-bit value pointed by *oldval.  Return zero if *ptr was
+  changed or non-zero if no exchange happened.
+
+  The C flag is also set if *ptr was changed to allow for assembly
+  optimization in the calling code.
+
+Usage example:
+
+typedef int (__kuser_cmpxchg64_t)(const int64_t *oldval,
+                                  const int64_t *newval,
+                                  volatile int64_t *ptr);
+#define __kuser_cmpxchg64 (*(__kuser_cmpxchg64_t *)0xffff0f60)
+
+int64_t atomic_add64(volatile int64_t *ptr, int64_t val)
+{
+	int64_t old, new;
+
+	do {
+		old = *ptr;
+		new = old + val;
+	} while(__kuser_cmpxchg64(&old, &new, ptr));
+
+	return new;
+}
+
+Notes:
+
+  - This routine already includes memory barriers as needed.
+
+  - Due to the length of this sequence, this spans 2 conventional kuser
+    "slots", therefore 0xffff0f80 is not used as a valid entry point.
+
+  - Valid only if __kuser_helper_version >= 5 (from kernel version 3.0).
+
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 63f7907..c0d80bc 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -383,7 +383,7 @@ ENDPROC(__pabt_svc)
 	.endm
 
 	.macro	kuser_cmpxchg_check
-#if __LINUX_ARM_ARCH__ < 6 && !defined(CONFIG_NEEDS_SYSCALL_FOR_CMPXCHG)
+#if !defined(CONFIG_CPU_32v6K) && !defined(CONFIG_NEEDS_SYSCALL_FOR_CMPXCHG)
 #ifndef CONFIG_MMU
 #warning "NPTL on non MMU needs fixing"
 #else
@@ -392,7 +392,7 @@ ENDPROC(__pabt_svc)
 	@ perform a quick test inline since it should be false
 	@ 99.9999% of the time.  The rest is done out of line.
 	cmp	r2, #TASK_SIZE
-	blhs	kuser_cmpxchg_fixup
+	blhs	kuser_cmpxchg64_fixup
 #endif
 #endif
 	.endm
@@ -775,6 +775,99 @@ ENDPROC(__switch_to)
 	.globl	__kuser_helper_start
 __kuser_helper_start:
 
+/*
+ * Due to the length of some sequences, __kuser_cmpxchg64 spans 2 regular 
+ * kuser "slots", therefore 0xffff0f80 is not used as a valid entry point.
+ */
+
+__kuser_cmpxchg64:				@ 0xffff0f60
+
+#if defined(CONFIG_NEEDS_SYSCALL_FOR_CMPXCHG)
+
+	/*
+	 * Poor you.  No fast solution possible...
+	 * The kernel itself must perform the operation.
+	 * A special ghost syscall is used for that (see traps.c).
+	 */
+	stmfd	sp!, {r7, lr}
+	ldr	r7, 1f			@ it's 20 bits
+	swi	__ARM_NR_cmpxchg64
+	ldmfd	sp!, {r7, pc}
+1:	.word	__ARM_NR_cmpxchg64
+
+#elif defined(CONFIG_CPU_32v6K)
+
+	stmfd	sp!, {r4, r5, r6, r7}
+	ldrd	r4, r5, [r0]			@ load old val
+	ldrd	r6, r7, [r1]			@ load new val
+	smp_dmb	arm
+1:	ldrexd	r0, r1, [r2]			@ load current val
+	eors	r3, r0, r4			@ compare with oldval (1)
+	eoreqs	r3, r1, r5			@ compare with oldval (2)
+	strexdeq r3, r6, r7, [r2]		@ store newval if eq
+	teqeq	r3, #1				@ success?
+	beq	1b				@ if no then retry
+	smp_dmb	arm
+	rsbs	r0, r3, #0			@ set returned val and C flag
+	ldmfd	sp!, {r4, r5, r6, r7}
+	bx	lr
+
+#elif !defined(CONFIG_SMP)
+
+#ifdef CONFIG_MMU
+
+	/*
+	 * The only thing that can break atomicity in this cmpxchg64
+	 * implementation is either an IRQ or a data abort exception
+	 * causing another process/thread to be scheduled in the middle of
+	 * the critical sequence.  The same strategy as for cmpxchg is used.
+	 */
+	stmfd	sp!, {r4, r5, r6, lr}
+	ldmia	r0, {r4, r5}			@ load old val
+	ldmia	r1, {r6, lr}			@ load new val
+1:	ldmia	r2, {r0, r1}			@ load current val
+	eors	r3, r0, r4			@ compare with oldval (1)
+	eoreqs	r3, r1, r5			@ compare with oldval (2)
+2:	stmeqia	r2, {r6, lr}			@ store newval if eq
+	rsbs	r0, r3, #0			@ set return val and C flag
+	ldmfd	sp!, {r4, r5, r6, pc}
+
+	.text
+kuser_cmpxchg64_fixup:
+	@ Called from kuser_cmpxchg_fixup.
+	@ r2 = address of interrupted insn (must be preserved).
+	@ sp = saved regs. r7 and r8 are clobbered.
+	@ 1b = first critical insn, 2b = last critical insn.
+	@ If r2 >= 1b and r2 <= 2b then saved pc_usr is set to 1b.
+	mov	r7, #0xffff0fff
+	sub	r7, r7, #(0xffff0fff - (0xffff0f60 + (1b - __kuser_cmpxchg64)))
+	subs	r8, r2, r7
+	rsbcss	r8, r8, #(2b - 1b)
+	strcs	r7, [sp, #S_PC]
+#if __LINUX_ARM_ARCH__ < 6
+	bcc	kuser_cmpxchg32_fixup
+#endif
+	mov	pc, lr
+	.previous
+
+#else
+#warning "NPTL on non MMU needs fixing"
+	mov	r0, #-1
+	adds	r0, r0, #0
+	usr_ret	lr
+#endif
+
+#else
+#error "incoherent kernel configuration"
+#endif
+
+	/* pad to next slot */
+	.rept	(16 - (. - __kuser_cmpxchg64)/4)
+	.word	0
+	.endr
+
+	.align	5
+
 __kuser_memory_barrier:				@ 0xffff0fa0
 	smp_dmb	arm
 	usr_ret	lr
@@ -816,7 +909,7 @@ __kuser_cmpxchg:				@ 0xffff0fc0
 	usr_ret	lr
 
 	.text
-kuser_cmpxchg_fixup:
+kuser_cmpxchg32_fixup:
 	@ Called from kuser_cmpxchg_check macro.
 	@ r2 = address of interrupted insn (must be preserved).
 	@ sp = saved regs. r7 and r8 are clobbered.
-- 
1.7.4
