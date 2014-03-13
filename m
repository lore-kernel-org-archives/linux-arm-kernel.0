From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 13 Mar 2014 18:15:50 +0000
Subject: [PATCH 3/5] arm: Disable preemption in iwmmxt_task_enable()
In-Reply-To: <1394734552-4704-1-git-send-email-catalin.marinas@arm.com>
References: <1394734552-4704-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1394734552-4704-4-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is in preparation for calling the iwmmxt_task_enable()
function with interrupts enabled.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/kernel/iwmmxt.S | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/iwmmxt.S b/arch/arm/kernel/iwmmxt.S
index a08783823b32..c52f3e225aeb 100644
--- a/arch/arm/kernel/iwmmxt.S
+++ b/arch/arm/kernel/iwmmxt.S
@@ -65,13 +65,14 @@
  */
 
 ENTRY(iwmmxt_task_enable)
+	inc_preempt_count r10, r3
 
 	XSC(mrc	p15, 0, r2, c15, c1, 0)
 	PJ4(mrc p15, 0, r2, c1, c0, 2)
 	@ CP0 and CP1 accessible?
 	XSC(tst	r2, #0x3)
 	PJ4(tst	r2, #0xf)
-	movne	pc, lr				@ if so no business here
+	bne	4f				@ if so no business here
 	@ enable access to CP0 and CP1
 	XSC(orr	r2, r2, #0x3)
 	XSC(mcr	p15, 0, r2, c15, c1, 0)
@@ -132,7 +133,7 @@ concan_dump:
 	wstrd	wR15, [r1, #MMX_WR15]
 
 2:	teq	r0, #0				@ anything to load?
-	moveq	pc, lr
+	beq	3f
 
 concan_load:
 
@@ -165,8 +166,14 @@ concan_load:
 	@ clear CUP/MUP (only if r1 != 0)
 	teq	r1, #0
 	mov 	r2, #0
-	moveq	pc, lr
+	beq	3f
 	tmcr	wCon, r2
+
+3:
+#ifdef CONFIG_PREEMPT_COUNT
+	get_thread_info r10
+#endif
+4:	dec_preempt_count r10, r3
 	mov	pc, lr
 
 /*
