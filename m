From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 29 Mar 2012 00:00:23 -0400
Subject: [PATCH 3/4] ARM: copy_template.S: enforce contigous register set with
 memory accessors
In-Reply-To: <1332993624-16552-1-git-send-email-nico@fluxnic.net>
References: <alpine.LFD.2.02.1203280119550.24151@xanadu.home>
 <1332993624-16552-1-git-send-email-nico@fluxnic.net>
Message-ID: <1332993624-16552-4-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nicolas.pitre@linaro.org>

Let's enforce a range of contigous registers with the remaining ldr8w
and str8w accessors.  An additional register needs to be preserved to
achieve this although not strictly necessary otherwise, but this will
allow for a greater flexibility inthe accessor implementation.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/lib/copy_template.S |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/lib/copy_template.S b/arch/arm/lib/copy_template.S
index 84e94cd48c..f6f42c3330 100644
--- a/arch/arm/lib/copy_template.S
+++ b/arch/arm/lib/copy_template.S
@@ -77,7 +77,7 @@
 		bne	10f
 
 1:		subs	lr, lr, #(28)
-		stmfd	sp!, {r5 - r8}
+		stmfd	sp!, {r5 - r9}
 		blt	5f
 
 	CALGN(	ands	ip, r0, #31		)
@@ -96,9 +96,9 @@
 	PLD(	pld	[r1, #92]		)
 
 3:	PLD(	pld	[r1, #124]		)
-4:		ldr8w	r1, r2, r3, r4, r5, r6, r7, r8, ip, abort=20f
+4:		ldr8w	r1, r2, r3, r4, r5, r6, r7, r8, r9, abort=20f
 		subs	lr, lr, #32
-		str8w	r0, r2, r3, r4, r5, r6, r7, r8, ip, abort=20f
+		str8w	r0, r2, r3, r4, r5, r6, r7, r8, r9, abort=20f
 		bge	3b
 	PLD(	cmn	lr, #96			)
 	PLD(	bge	4b			)
@@ -142,7 +142,7 @@
 
 	CALGN(	bcs	2b			)
 
-7:		ldmfd	sp!, {r5 - r8}
+7:		ldmfd	sp!, {r5 - r9}
 
 8:		movs	lr, lr, lsl #31
 		ldr1b	r1, r2, ne, abort=21f
@@ -256,7 +256,7 @@
 	.macro	copy_abort_preamble
 19:	ldmfd	sp!, {r5 - sl}
 	b	21f
-20:	ldmfd	sp!, {r5 - r8}
+20:	ldmfd	sp!, {r5 - r9}
 21:
 	.endm
 
-- 
1.7.9.rc2
