From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 18 Jun 2014 16:49:58 +0800
Subject: [PATCH] ARM: save/restore diagnostic register on ARMv7 suspend/resume
Message-ID: <1403081398-32116-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CP15 diagnostic register holds ARM errata bits on ARMv7, so it
needs to be saved/restored on suspend/resume.  Otherwise, the
effectiveness of errata workaround gets lost together with diagnostic
register bit across suspend/resume cycle.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mm/proc-v7.S | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 3db2c2f04a30..4de98a65a4ea 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -92,13 +92,14 @@ ENDPROC(cpu_v7_dcache_clean_area)
 
 /* Suspend/resume support: derived from arch/arm/mach-s5pv210/sleep.S */
 .globl	cpu_v7_suspend_size
-.equ	cpu_v7_suspend_size, 4 * 9
+.equ	cpu_v7_suspend_size, 4 * 10
 #ifdef CONFIG_ARM_CPU_SUSPEND
 ENTRY(cpu_v7_do_suspend)
 	stmfd	sp!, {r4 - r10, lr}
 	mrc	p15, 0, r4, c13, c0, 0	@ FCSE/PID
 	mrc	p15, 0, r5, c13, c0, 3	@ User r/o thread ID
 	stmia	r0!, {r4 - r5}
+	mrc	p15, 0, r4, c15, c0, 1	@ Diagnostic register
 #ifdef CONFIG_MMU
 	mrc	p15, 0, r6, c3, c0, 0	@ Domain ID
 #ifdef CONFIG_ARM_LPAE
@@ -111,7 +112,7 @@ ENTRY(cpu_v7_do_suspend)
 	mrc	p15, 0, r8, c1, c0, 0	@ Control register
 	mrc	p15, 0, r9, c1, c0, 1	@ Auxiliary control register
 	mrc	p15, 0, r10, c1, c0, 2	@ Co-processor access control
-	stmia	r0, {r5 - r11}
+	stmia	r0, {r4 - r11}
 	ldmfd	sp!, {r4 - r10, pc}
 ENDPROC(cpu_v7_do_suspend)
 
@@ -122,7 +123,8 @@ ENTRY(cpu_v7_do_resume)
 	ldmia	r0!, {r4 - r5}
 	mcr	p15, 0, r4, c13, c0, 0	@ FCSE/PID
 	mcr	p15, 0, r5, c13, c0, 3	@ User r/o thread ID
-	ldmia	r0, {r5 - r11}
+	ldmia	r0, {r4 - r11}
+	mcr	p15, 0, r4, c15, c0, 1	@ Diagnostic register
 #ifdef CONFIG_MMU
 	mcr	p15, 0, ip, c8, c7, 0	@ invalidate TLBs
 	mcr	p15, 0, r6, c3, c0, 0	@ Domain ID
-- 
1.8.3.2
