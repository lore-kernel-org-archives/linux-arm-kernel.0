From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Jun 2011 18:15:10 +0100
Subject: [PATCH 01/14] ARM: suspend: make MULTI_CPU and !MULTI_CPU resume
	paths the same
In-Reply-To: <20110613171446.GF13643@n2100.arm.linux.org.uk>
References: <20110613171446.GF13643@n2100.arm.linux.org.uk>
Message-ID: <E1QWAjG-0002di-21@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eliminate the differences between MULTI_CPU and non-MULTI_CPU resume
paths, making the saved structure identical irrespective of the way
the kernel was configured.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/sleep.S |   12 +++---------
 1 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
index 6398ead..97a6577 100644
--- a/arch/arm/kernel/sleep.S
+++ b/arch/arm/kernel/sleep.S
@@ -40,9 +40,11 @@ ENTRY(cpu_suspend)
 #else
 	mov	r2, sp			@ current virtual SP
 	ldr	r0, =cpu_suspend_size
+	ldr	ip, =cpu_do_resume
 	sub	sp, sp, r0		@ allocate CPU state on stack
 	mov	r0, sp			@ save pointer
-	stmfd	sp!, {r1, r2, r3}	@ save v:p, virt SP, return fn
+	add	ip, ip, r1		@ convert resume fn to phys
+	stmfd	sp!, {r1, r2, r3, ip}	@ save v:p, virt SP, retfn, phys resume fn
 	ldr	r3, =sleep_save_sp
 	add	r2, sp, r1		@ convert SP to phys
 #ifdef CONFIG_SMP
@@ -120,20 +122,12 @@ ENTRY(cpu_resume)
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
-- 
1.7.4.4
