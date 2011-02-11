From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Feb 2011 16:18:35 +0000
Subject: [PATCH 4/6] ARM: pm: convert sa11x0 to generic suspend/resume support
In-Reply-To: <20110211161626.GA31356@n2100.arm.linux.org.uk>
References: <20110211161626.GA31356@n2100.arm.linux.org.uk>
Message-ID: <E1Pnvhb-0002yk-61@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert sa11x0 to use the generic CPU suspend/resume support, rather
than implementing its own version.  Tested on Assabet.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-sa1100/pm.c    |   12 ++-----
 arch/arm/mach-sa1100/sleep.S |   72 ++---------------------------------------
 2 files changed, 7 insertions(+), 77 deletions(-)

diff --git a/arch/arm/mach-sa1100/pm.c b/arch/arm/mach-sa1100/pm.c
index ab9fc44..c4661aa 100644
--- a/arch/arm/mach-sa1100/pm.c
+++ b/arch/arm/mach-sa1100/pm.c
@@ -32,8 +32,7 @@
 #include <asm/system.h>
 #include <asm/mach/time.h>
 
-extern void sa1100_cpu_suspend(void);
-extern void sa1100_cpu_resume(void);
+extern void sa1100_cpu_suspend(long);
 
 #define SAVE(x)		sleep_save[SLEEP_SAVE_##x] = x
 #define RESTORE(x)	x = sleep_save[SLEEP_SAVE_##x]
@@ -73,10 +72,10 @@ static int sa11x0_pm_enter(suspend_state_t state)
 	RCSR = RCSR_HWR | RCSR_SWR | RCSR_WDR | RCSR_SMR;
 
 	/* set resume return address */
-	PSPR = virt_to_phys(sa1100_cpu_resume);
+	PSPR = virt_to_phys(cpu_resume);
 
 	/* go zzz */
-	sa1100_cpu_suspend();
+	sa1100_cpu_suspend(PLAT_PHYS_OFFSET - PAGE_OFFSET);
 
 	cpu_init();
 
@@ -115,11 +114,6 @@ static int sa11x0_pm_enter(suspend_state_t state)
 	return 0;
 }
 
-unsigned long sleep_phys_sp(void *sp)
-{
-	return virt_to_phys(sp);
-}
-
 static const struct platform_suspend_ops sa11x0_pm_ops = {
 	.enter		= sa11x0_pm_enter,
 	.valid		= suspend_valid_only_mem,
diff --git a/arch/arm/mach-sa1100/sleep.S b/arch/arm/mach-sa1100/sleep.S
index 80f31ba..04f2a61 100644
--- a/arch/arm/mach-sa1100/sleep.S
+++ b/arch/arm/mach-sa1100/sleep.S
@@ -20,12 +20,7 @@
 #include <asm/assembler.h>
 #include <mach/hardware.h>
 
-
-
 		.text
-
-
-
 /*
  * sa1100_cpu_suspend()
  *
@@ -34,27 +29,10 @@
  */
 
 ENTRY(sa1100_cpu_suspend)
-
 	stmfd	sp!, {r4 - r12, lr}		@ save registers on stack
-
-	@ get coprocessor registers
-	mrc 	p15, 0, r4, c3, c0, 0		@ domain ID
-	mrc 	p15, 0, r5, c2, c0, 0		@ translation table base addr
-	mrc	p15, 0, r6, c13, c0, 0		@ PID
-	mrc 	p15, 0, r7, c1, c0, 0		@ control reg
-
-	@ store them plus current virtual stack ptr on stack
-	mov	r8, sp
-	stmfd	sp!, {r4 - r8}
-
-	@ preserve phys address of stack
-	mov	r0, sp
-	bl	sleep_phys_sp
-	ldr	r1, =sleep_save_sp
-	str	r0, [r1]
-
-	@ clean data cache and invalidate WB
-	bl	v4wb_flush_kern_cache_all
+	mov	r1, r0
+	ldr	r3, =sa1100_cpu_resume		@ return function
+	bl	cpu_suspend
 
 	@ disable clock switching
 	mcr	p15, 0, r1, c15, c2, 2
@@ -166,50 +144,8 @@ sa1110_sdram_controller_fix:
  * cpu_sa1100_resume()
  *
  * entry point from bootloader into kernel during resume
- *
- * Note: Yes, part of the following code is located into the .data section.
- *       This is to allow sleep_save_sp to be accessed with a relative load
- *       while we can't rely on any MMU translation.  We could have put
- *       sleep_save_sp in the .text section as well, but some setups might
- *       insist on it to be truly read-only.
  */
-
-	.data
-	.align 5
-ENTRY(sa1100_cpu_resume)
-	mov	r0, #PSR_F_BIT | PSR_I_BIT | SVC_MODE
-	msr	cpsr_c, r0			@ set SVC, irqs off
-
-	ldr	r0, sleep_save_sp		@ stack phys addr
-	ldr	r2, =resume_after_mmu		@ its absolute virtual address
-	ldmfd	r0, {r4 - r7, sp}		@ CP regs + virt stack ptr
-
-	mov	r1, #0
-	mcr	p15, 0, r1, c8, c7, 0   	@ flush I+D TLBs
-	mcr	p15, 0, r1, c7, c7, 0		@ flush I&D cache
-	mcr	p15, 0, r1, c9, c0, 0		@ invalidate RB
-	mcr	p15, 0, r1, c9, c0, 5		@ allow user space to use RB
-
-	mcr	p15, 0, r4, c3, c0, 0		@ domain ID
-	mcr	p15, 0, r5, c2, c0, 0		@ translation table base addr
-	mcr	p15, 0, r6, c13, c0, 0		@ PID
-	b	resume_turn_on_mmu		@ cache align execution
-
 	.align 5
-resume_turn_on_mmu:
-	mcr 	p15, 0, r7, c1, c0, 0		@ turn on MMU, caches, etc.
-	nop
-	mov	pc, r2				@ jump to virtual addr
-	nop
-	nop
-	nop
-
-sleep_save_sp:
-	.word	0				@ preserve stack phys ptr here
-
-	.text
-resume_after_mmu:
+sa1100_cpu_resume:
 	mcr	p15, 0, r1, c15, c1, 2		@ enable clock switching
 	ldmfd	sp!, {r4 - r12, pc}		@ return to caller
-
-
-- 
1.6.2.5
