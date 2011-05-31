From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 1 Jun 2011 00:08:24 +0800
Subject: [RFC] Simplify the code in arch/arm/kernel/sleep.S a bit
Message-ID: <BANLkTiksF3q88dwz8AGKWC2m4OoptDtN8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

While reading arch/arm/kernel/sleep.S, actually felt a bit redundancy
of the code handling MULTI_CPU and otherwise. Will something like
below be a bit simpler, though I didn't test it and I know the performance
will be worse (yet I'd argue here it's on the path of suspend/resume, not
really a hotspot).

And further more, does it even make sense to make MULTI_CPU always
true, even when handling a kernel supporting only one core? I believe
we can get rid of many lines and still keep the code generic. Although
I don't have a sense of how it's going to impact the performance.

diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
index 6398ead..ab47c95 100644
--- a/arch/arm/kernel/sleep.S
+++ b/arch/arm/kernel/sleep.S
@@ -12,15 +12,22 @@
  *  r1 = v:p offset
  *  r3 = virtual return function
  * Note: sp is decremented to allocate space for CPU state on stack
- * r0-r3,r9,r10,lr corrupted
+ * r0-r3,r8,r9,r10,lr corrupted
  */
 ENTRY(cpu_suspend)
 	mov	r9, lr
 #ifdef MULTI_CPU
 	ldr	r10, =processor
+	ldr	r0, [r10, #CPU_SLEEP_SIZE]
+	ldr	r8, [r10, #CPU_DO_SUSPEND]
+	ldr	ip, [r10, #CPU_DO_RESUME]
+#else
+	ldr	r0, =cpu_suspend_size
+	ldr	r8, =cpu_do_suspend
+	ldr	ip, =cpu_do_resume
+#endif
+
 	mov	r2, sp			@ current virtual SP
-	ldr	r0, [r10, #CPU_SLEEP_SIZE] @ size of CPU sleep state
-	ldr	ip, [r10, #CPU_DO_RESUME] @ virtual resume function
 	sub	sp, sp, r0		@ allocate CPU state on stack
 	mov	r0, sp			@ save pointer
 	add	ip, ip, r1		@ convert resume fn to phys
@@ -36,25 +43,7 @@ ENTRY(cpu_suspend)
 	str	r2, [r3]		@ save phys SP
 #endif
 	mov	lr, pc
-	ldr	pc, [r10, #CPU_DO_SUSPEND] @ save CPU state
-#else
-	mov	r2, sp			@ current virtual SP
-	ldr	r0, =cpu_suspend_size
-	sub	sp, sp, r0		@ allocate CPU state on stack
-	mov	r0, sp			@ save pointer
-	stmfd	sp!, {r1, r2, r3}	@ save v:p, virt SP, return fn
-	ldr	r3, =sleep_save_sp
-	add	r2, sp, r1		@ convert SP to phys
-#ifdef CONFIG_SMP
-	ALT_SMP(mrc p15, 0, lr, c0, c0, 5)
-	ALT_UP(mov lr, #0)
-	and	lr, lr, #15
-	str	r2, [r3, lr, lsl #2]	@ save phys SP
-#else
-	str	r2, [r3]		@ save phys SP
-#endif
-	bl	cpu_do_suspend
-#endif
+	mov	pc, r8			@ cpu_do_suspend

 	@ flush data cache
 #ifdef MULTI_CACHE
@@ -120,20 +109,12 @@ ENTRY(cpu_resume)
 	ldr	r0, sleep_save_sp	@ stack phys addr
 #endif
 	setmode	PSR_I_BIT | PSR_F_BIT | SVC_MODE, r1  @ set SVC, irqs off
-#ifdef MULTI_CPU
 	@ load v:p, stack, return fn, resume fn
   ARM(	ldmia	r0!, {r1, sp, lr, pc}	)
 THUMB(	ldmia	r0!, {r1, r2, r3, r4}	)
 THUMB(	mov	sp, r2			)
 THUMB(	mov	lr, r3			)
 THUMB(	bx	r4			)
-#else
-	@ load v:p, stack, return fn
-  ARM(	ldmia	r0!, {r1, sp, lr}	)
-THUMB(	ldmia	r0!, {r1, r2, lr}	)
-THUMB(	mov	sp, r2			)
-	b	cpu_do_resume
-#endif
 ENDPROC(cpu_resume)

 sleep_save_sp:
