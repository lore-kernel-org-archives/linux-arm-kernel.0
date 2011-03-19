From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 18 Mar 2011 23:00:02 -0400 (EDT)
Subject: [PATCH] ARM: kernel/sleep.S: fix Thumb2 compilation issues
Message-ID: <alpine.LFD.2.00.1103182256330.26889@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>

diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
index bfad698..6398ead 100644
--- a/arch/arm/kernel/sleep.S
+++ b/arch/arm/kernel/sleep.S
@@ -119,11 +119,19 @@ ENTRY(cpu_resume)
 #else
 	ldr	r0, sleep_save_sp	@ stack phys addr
 #endif
-	msr	cpsr_c, #PSR_I_BIT | PSR_F_BIT | SVC_MODE @ set SVC, irqs off
+	setmode	PSR_I_BIT | PSR_F_BIT | SVC_MODE, r1  @ set SVC, irqs off
 #ifdef MULTI_CPU
-	ldmia	r0!, {r1, sp, lr, pc}	@ load v:p, stack, return fn, resume fn
+	@ load v:p, stack, return fn, resume fn
+  ARM(	ldmia	r0!, {r1, sp, lr, pc}	)
+THUMB(	ldmia	r0!, {r1, r2, r3, r4}	)
+THUMB(	mov	sp, r2			)
+THUMB(	mov	lr, r3			)
+THUMB(	bx	r4			)
 #else
-	ldmia	r0!, {r1, sp, lr}	@ load v:p, stack, return fn
+	@ load v:p, stack, return fn
+  ARM(	ldmia	r0!, {r1, sp, lr}	)
+THUMB(	ldmia	r0!, {r1, r2, lr}	)
+THUMB(	mov	sp, r2			)
 	b	cpu_do_resume
 #endif
 ENDPROC(cpu_resume)
