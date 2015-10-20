From: chengang.beijing@gmail.com (Chen Gang)
Date: Tue, 20 Oct 2015 11:30:02 +0800
Subject: [PATCH 1/1] ARM: prov-v7: cpu_do_suspend corrupt r11
Message-ID: <1445311802-28465-1-git-send-email-chengang.beijing@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM V7 version of cpu_do_suspend() [cpu_v7_do_suspend] is called
with C calling conventions from arch/arm/kernel/suspend.c - but
cpu_v7_do_suspend() use R11. The temporary register R12 is unused,
so change reference from R11 to R12.

Signed-off-by: Chen Gang <gangchen@rdamicro.com>
Signed-off-by: Chen Gang <chengang.beijing@gmail.com>
---
 arch/arm/mm/proc-v7.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index de2b246..c8a427a 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -106,12 +106,12 @@ ENTRY(cpu_v7_do_suspend)
 #else
 	mrc	p15, 0, r7, c2, c0, 1	@ TTB 1
 #endif
-	mrc	p15, 0, r11, c2, c0, 2	@ TTB control register
+	mrc	p15, 0, r12, c2, c0, 2	@ TTB control register
 #endif
 	mrc	p15, 0, r8, c1, c0, 0	@ Control register
 	mrc	p15, 0, r9, c1, c0, 1	@ Auxiliary control register
 	mrc	p15, 0, r10, c1, c0, 2	@ Co-processor access control
-	stmia	r0, {r5 - r11}
+	stmia	r0, {r5 - r10, r12}
 	ldmfd	sp!, {r4 - r10, pc}
 ENDPROC(cpu_v7_do_suspend)
 
-- 
2.4.3
