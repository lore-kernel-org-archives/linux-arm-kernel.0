From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 13 Mar 2014 18:15:51 +0000
Subject: [PATCH 4/5] arm: Disable preemption in crunch_task_enable()
In-Reply-To: <1394734552-4704-1-git-send-email-catalin.marinas@arm.com>
References: <1394734552-4704-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1394734552-4704-5-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is in preparation for calling the crunch_task_enable()
function with interrupts enabled.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <rmallon@gmail.com>
---
 arch/arm/mach-ep93xx/crunch-bits.S | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ep93xx/crunch-bits.S b/arch/arm/mach-ep93xx/crunch-bits.S
index 0ec9bb48fab9..890c5df2b4fe 100644
--- a/arch/arm/mach-ep93xx/crunch-bits.S
+++ b/arch/arm/mach-ep93xx/crunch-bits.S
@@ -65,11 +65,13 @@
  * called from prefetch exception handler with interrupts disabled
  */
 ENTRY(crunch_task_enable)
+	inc_preempt_count r10, r3
+
 	ldr	r8, =(EP93XX_APB_VIRT_BASE + 0x00130000)	@ syscon addr
 
 	ldr	r1, [r8, #0x80]
 	tst	r1, #0x00800000			@ access to crunch enabled?
-	movne	pc, lr				@ if so no business here
+	bne	2f				@ if so no business here
 	mov	r3, #0xaa			@ unlock syscon swlock
 	str	r3, [r8, #0xc0]
 	orr	r1, r1, #0x00800000		@ enable access to crunch
@@ -142,7 +144,7 @@ crunch_save:
 
 	teq		r0, #0				@ anything to load?
 	cfldr64eq	mvdx0, [r1, #CRUNCH_MVDX0]	@ mvdx0 was clobbered
-	moveq		pc, lr
+	beq		1f
 
 crunch_load:
 	cfldr64		mvdx0, [r0, #CRUNCH_DSPSC]	@ load status word
@@ -190,6 +192,11 @@ crunch_load:
 	cfldr64		mvdx14, [r0, #CRUNCH_MVDX14]
 	cfldr64		mvdx15, [r0, #CRUNCH_MVDX15]
 
+1:
+#ifdef CONFIG_PREEMPT_COUNT
+	get_thread_info r10
+#endif
+2:	dec_preempt_count r10, r3
 	mov	pc, lr
 
 /*
