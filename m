From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Jun 2011 16:10:11 +0100
Subject: [PATCH 05/25] ARM: pm: reallocate registers to avoid r2, r3
In-Reply-To: <20110622150816.GT23234@n2100.arm.linux.org.uk>
References: <20110622150816.GT23234@n2100.arm.linux.org.uk>
Message-ID: <E1QZP4F-0002W2-BC@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid using r2 and r3 in the suspend code, allowing these to be
passed further into the function as arguments.

Acked-by: Frank Hofmann <frank.hofmann@tomtom.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/sleep.S |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
index 8dbca93..358be13 100644
--- a/arch/arm/kernel/sleep.S
+++ b/arch/arm/kernel/sleep.S
@@ -20,26 +20,26 @@ ENTRY(cpu_suspend)
 	mov	r9, lr
 #ifdef MULTI_CPU
 	ldr	r10, =processor
-	ldr	r0, [r10, #CPU_SLEEP_SIZE] @ size of CPU sleep state
+	ldr	r5, [r10, #CPU_SLEEP_SIZE] @ size of CPU sleep state
 	ldr	ip, [r10, #CPU_DO_RESUME] @ virtual resume function
 #else
-	ldr	r0, =cpu_suspend_size
+	ldr	r5, =cpu_suspend_size
 	ldr	ip, =cpu_do_resume
 #endif
-	mov	r2, sp			@ current virtual SP
-	sub	sp, sp, r0		@ allocate CPU state on stack
+	mov	r6, sp			@ current virtual SP
+	sub	sp, sp, r5		@ allocate CPU state on stack
 	mov	r0, sp			@ save pointer
 	add	ip, ip, r1		@ convert resume fn to phys
-	stmfd	sp!, {r1, r2, ip}	@ save v:p, virt SP, phys resume fn
-	ldr	r3, =sleep_save_sp
-	add	r2, sp, r1		@ convert SP to phys
+	stmfd	sp!, {r1, r6, ip}	@ save v:p, virt SP, phys resume fn
+	ldr	r5, =sleep_save_sp
+	add	r6, sp, r1		@ convert SP to phys
 #ifdef CONFIG_SMP
 	ALT_SMP(mrc p15, 0, lr, c0, c0, 5)
 	ALT_UP(mov lr, #0)
 	and	lr, lr, #15
-	str	r2, [r3, lr, lsl #2]	@ save phys SP
+	str	r6, [r5, lr, lsl #2]	@ save phys SP
 #else
-	str	r2, [r3]		@ save phys SP
+	str	r6, [r5]		@ save phys SP
 #endif
 #ifdef MULTI_CPU
 	mov	lr, pc
-- 
1.7.4.4
