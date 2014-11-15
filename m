From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Sat, 15 Nov 2014 15:05:53 +0300
Subject: [PATCH] ARM: xscale: correct auxiliary register in suspend/resume
Message-ID: <1416053153-27491-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the manuals I have, XScale auxiliary register should be
reached with opc_2 = 1 instead of crn = 1. cpu_xscale_proc_init
correctly uses c1, c0, 1 arguments, but cpu_xscale_do_suspend and
cpu_xscale_do_resume use c1, c1, 0. Correct suspend/resume functions to
also use c1, c0, 1.

The issue was primarily noticed thanks to qemu reporing "unsupported
instruction" on the pxa suspend path. Confirmed in PXA210/250 and PXA255
XScale Core manuals and in PXA270 and PXA320 Developers Guides.

Harware tested by me on tosa (pxa255). Robert confirmed on pxa270 board.

Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mm/proc-xscale.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/proc-xscale.S b/arch/arm/mm/proc-xscale.S
index 23259f1..afa2b3c 100644
--- a/arch/arm/mm/proc-xscale.S
+++ b/arch/arm/mm/proc-xscale.S
@@ -535,7 +535,7 @@ ENTRY(cpu_xscale_do_suspend)
 	mrc	p15, 0, r5, c15, c1, 0	@ CP access reg
 	mrc	p15, 0, r6, c13, c0, 0	@ PID
 	mrc	p15, 0, r7, c3, c0, 0	@ domain ID
-	mrc	p15, 0, r8, c1, c1, 0	@ auxiliary control reg
+	mrc	p15, 0, r8, c1, c0, 1	@ auxiliary control reg
 	mrc	p15, 0, r9, c1, c0, 0	@ control reg
 	bic	r4, r4, #2		@ clear frequency change bit
 	stmia	r0, {r4 - r9}		@ store cp regs
@@ -552,7 +552,7 @@ ENTRY(cpu_xscale_do_resume)
 	mcr	p15, 0, r6, c13, c0, 0	@ PID
 	mcr	p15, 0, r7, c3, c0, 0	@ domain ID
 	mcr	p15, 0, r1, c2, c0, 0	@ translation table base addr
-	mcr	p15, 0, r8, c1, c1, 0	@ auxiliary control reg
+	mcr	p15, 0, r8, c1, c0, 1	@ auxiliary control reg
 	mov	r0, r9			@ control register
 	b	cpu_resume_mmu
 ENDPROC(cpu_xscale_do_resume)
-- 
2.1.1
