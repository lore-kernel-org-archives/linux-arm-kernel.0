From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 2 Jul 2014 14:48:35 +0800
Subject: [PATCH] ARM: cpu_pj4b_suspend_size should base on cpu_v7_suspend_size
Message-ID: <1404283715-3631-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since pj4b suspend/resume routines are implemented based on generic
ARMv7 ones, instead of hard-coding cpu_pj4b_suspend_size, we should have
it be cpu_v7_suspend_size plus pj4b specific bytes.  Otherwise, if
cpu_v7_suspend_size gets updated alone, the pj4b suspend/resume will
likely be broken.

While at it, fix the comments in cpu_pj4b_do_resume, as we're restoring
CP15 registers rather than saving in there.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
Completely untested.

 arch/arm/mm/proc-v7.S | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 3db2c2f04a30..604dda5f65cc 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -184,16 +184,16 @@ ENDPROC(cpu_pj4b_do_suspend)
 
 ENTRY(cpu_pj4b_do_resume)
 	ldmia	r0!, {r6 - r10}
-	mcr	p15, 1, r6, c15, c1, 0  @ save CP15 - extra features
-	mcr	p15, 1, r7, c15, c2, 0	@ save CP15 - Aux Func Modes Ctrl 0
-	mcr	p15, 1, r8, c15, c1, 2	@ save CP15 - Aux Debug Modes Ctrl 2
-	mcr	p15, 1, r9, c15, c1, 1  @ save CP15 - Aux Debug Modes Ctrl 1
-	mcr	p15, 0, r10, c9, c14, 0  @ save CP15 - PMC
+	mcr	p15, 1, r6, c15, c1, 0  @ retore CP15 - extra features
+	mcr	p15, 1, r7, c15, c2, 0	@ retore CP15 - Aux Func Modes Ctrl 0
+	mcr	p15, 1, r8, c15, c1, 2	@ retore CP15 - Aux Debug Modes Ctrl 2
+	mcr	p15, 1, r9, c15, c1, 1  @ retore CP15 - Aux Debug Modes Ctrl 1
+	mcr	p15, 0, r10, c9, c14, 0  @ retore CP15 - PMC
 	b cpu_v7_do_resume
 ENDPROC(cpu_pj4b_do_resume)
 #endif
 .globl	cpu_pj4b_suspend_size
-.equ	cpu_pj4b_suspend_size, 4 * 14
+.equ	cpu_pj4b_suspend_size, cpu_v7_suspend_size + 4 * 5
 
 #endif
 
-- 
1.8.3.2
