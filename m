From: k.chander@samsung.com (Chander Kashyap)
Date: Tue,  1 Jul 2014 18:15:49 +0530
Subject: [RFC] [PATCH] ARM: save/restore power control register on Cortex-A9
 suspend/resume
Message-ID: <1404218750-5025-1-git-send-email-k.chander@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CP15 power register holds clock latency and dynamic clock gating settings
for Cortex-A9 processor, which lost during the suspend/resume. So it needs to
be saved/restored on suspend/resume.

Signed-off-by: Chander Kashyap <k.chander@samsung.com>
---
 It is depedent on: ARM: save/restore diagnostic register on Cortex-A9 suspend/resume
 http://www.spinics.net/lists/arm-kernel/msg340506.html

 arch/arm/mm/proc-v7.S |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index e26bfaa..9905df5 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -163,12 +163,14 @@ ENDPROC(cpu_v7_do_resume)
 	globl_equ	cpu_ca9mp_switch_mm,	cpu_v7_switch_mm
 	globl_equ	cpu_ca9mp_set_pte_ext,	cpu_v7_set_pte_ext
 .globl	cpu_ca9mp_suspend_size
-.equ	cpu_ca9mp_suspend_size, cpu_v7_suspend_size + 1 * 4
+.equ	cpu_ca9mp_suspend_size, cpu_v7_suspend_size + 2 * 4
 #ifdef CONFIG_ARM_CPU_SUSPEND
 ENTRY(cpu_ca9mp_do_suspend)
 	stmfd	sp!, {r4}
 	mrc	p15, 0, r4, c15, c0, 1  @ Diagnostic register
 	stmia	r0!, {r4}
+	mrc	p15, 0, r4, c15, c0, 0  @ Power register
+	stmia	r0!, {r4}
 	ldmfd	sp!, {r4}
 	b	cpu_v7_do_suspend
 ENDPROC(cpu_ca9mp_do_suspend)
@@ -176,6 +178,8 @@ ENDPROC(cpu_ca9mp_do_suspend)
 ENTRY(cpu_ca9mp_do_resume)
 	ldmia	r0!, {r4}
 	mcr	p15, 0, r4, c15, c0, 1  @ Diagnostic register
+	ldmia	r0!, {r4}
+	mcr	p15, 0, r4, c15, c0, 0  @ Power register
 	b	cpu_v7_do_resume
 ENDPROC(cpu_ca9mp_do_resume)
 #endif
-- 
1.7.9.5
