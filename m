From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 29 Mar 2012 00:00:21 -0400
Subject: [PATCH 1/4] ARM: copy_template.S: move some registers around
In-Reply-To: <1332993624-16552-1-git-send-email-nico@fluxnic.net>
References: <alpine.LFD.2.02.1203280119550.24151@xanadu.home>
 <1332993624-16552-1-git-send-email-nico@fluxnic.net>
Message-ID: <1332993624-16552-2-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nicolas.pitre@linaro.org>

The copy length is held in r2, making it difficult to use a consecutive
set of registers starting on an even register number as required by the
LDRD and STRD instructions.  Let's move the length to lr instead, and
adjust affected code accordingly.

Functionally speaking, this patch is a no-op.

Signed-off-by: nicolas Pitre <nico@linaro.org>
---
 arch/arm/lib/copy_template.S |   92 +++++++++++++++++++++---------------------
 1 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/arch/arm/lib/copy_template.S b/arch/arm/lib/copy_template.S
index 805e3f8fb0..7244dcef0d 100644
--- a/arch/arm/lib/copy_template.S
+++ b/arch/arm/lib/copy_template.S
@@ -69,7 +69,7 @@
 
 		enter	r4, lr
 
-		subs	r2, r2, #4
+		subs	lr, r2, #4
 		blt	8f
 		ands	ip, r0, #3
 	PLD(	pld	[r1, #0]		)
@@ -77,34 +77,34 @@
 		ands	ip, r1, #3
 		bne	10f
 
-1:		subs	r2, r2, #(28)
+1:		subs	lr, lr, #(28)
 		stmfd	sp!, {r5 - r8}
 		blt	5f
 
 	CALGN(	ands	ip, r0, #31		)
 	CALGN(	rsb	r3, ip, #32		)
-	CALGN(	sbcnes	r4, r3, r2		)  @ C is always set here
+	CALGN(	sbcnes	r4, r3, lr		)  @ C is always set here
 	CALGN(	bcs	2f			)
 	CALGN(	adr	r4, 6f			)
-	CALGN(	subs	r2, r2, r3		)  @ C gets set
+	CALGN(	subs	lr, lr, r3		)  @ C gets set
 	CALGN(	add	pc, r4, ip		)
 
 	PLD(	pld	[r1, #0]		)
-2:	PLD(	subs	r2, r2, #96		)
+2:	PLD(	subs	lr, lr, #96		)
 	PLD(	pld	[r1, #28]		)
 	PLD(	blt	4f			)
 	PLD(	pld	[r1, #60]		)
 	PLD(	pld	[r1, #92]		)
 
 3:	PLD(	pld	[r1, #124]		)
-4:		ldr8w	r1, r3, r4, r5, r6, r7, r8, ip, lr, abort=20f
-		subs	r2, r2, #32
-		str8w	r0, r3, r4, r5, r6, r7, r8, ip, lr, abort=20f
+4:		ldr8w	r1, r2, r3, r4, r5, r6, r7, r8, ip, abort=20f
+		subs	lr, lr, #32
+		str8w	r0, r2, r3, r4, r5, r6, r7, r8, ip, abort=20f
 		bge	3b
-	PLD(	cmn	r2, #96			)
+	PLD(	cmn	lr, #96			)
 	PLD(	bge	4b			)
 
-5:		ands	ip, r2, #28
+5:		ands	ip, lr, #28
 		rsb	ip, ip, #32
 #if LDR1W_SHIFT > 0
 		lsl	ip, ip, #LDR1W_SHIFT
@@ -115,13 +115,13 @@
 		.rept	(1 << LDR1W_SHIFT)
 		W(nop)
 		.endr
+		ldr1w	r1, r2, abort=20f
 		ldr1w	r1, r3, abort=20f
 		ldr1w	r1, r4, abort=20f
 		ldr1w	r1, r5, abort=20f
 		ldr1w	r1, r6, abort=20f
 		ldr1w	r1, r7, abort=20f
 		ldr1w	r1, r8, abort=20f
-		ldr1w	r1, lr, abort=20f
 
 #if LDR1W_SHIFT < STR1W_SHIFT
 		lsl	ip, ip, #STR1W_SHIFT - LDR1W_SHIFT
@@ -133,73 +133,75 @@
 		.rept	(1 << STR1W_SHIFT)
 		W(nop)
 		.endr
+		str1w	r0, r2, abort=20f
 		str1w	r0, r3, abort=20f
 		str1w	r0, r4, abort=20f
 		str1w	r0, r5, abort=20f
 		str1w	r0, r6, abort=20f
 		str1w	r0, r7, abort=20f
 		str1w	r0, r8, abort=20f
-		str1w	r0, lr, abort=20f
 
 	CALGN(	bcs	2b			)
 
 7:		ldmfd	sp!, {r5 - r8}
 
-8:		movs	r2, r2, lsl #31
-		ldr1b	r1, r3, ne, abort=21f
+8:		movs	lr, lr, lsl #31
+		ldr1b	r1, r2, ne, abort=21f
+		ldr1b	r1, r3, cs, abort=21f
 		ldr1b	r1, r4, cs, abort=21f
-		ldr1b	r1, ip, cs, abort=21f
-		str1b	r0, r3, ne, abort=21f
+		str1b	r0, r2, ne, abort=21f
+		str1b	r0, r3, cs, abort=21f
 		str1b	r0, r4, cs, abort=21f
-		str1b	r0, ip, cs, abort=21f
 
 		exit	r4, pc
 
 9:		rsb	ip, ip, #4
 		cmp	ip, #2
-		ldr1b	r1, r3, gt, abort=21f
-		ldr1b	r1, r4, ge, abort=21f
-		ldr1b	r1, lr, abort=21f
-		str1b	r0, r3, gt, abort=21f
-		str1b	r0, r4, ge, abort=21f
-		subs	r2, r2, ip
-		str1b	r0, lr, abort=21f
+		ldr1b	r1, r2, gt, abort=21f
+		ldr1b	r1, r3, ge, abort=21f
+		ldr1b	r1, r4, abort=21f
+		str1b	r0, r2, gt, abort=21f
+		str1b	r0, r3, ge, abort=21f
+		subs	lr, lr, ip
+		str1b	r0, r4, abort=21f
 		blt	8b
 		ands	ip, r1, #3
 		beq	1b
 
 10:		bic	r1, r1, #3
 		cmp	ip, #2
-		ldr1w	r1, lr, abort=21f
+		ldr1w	r1, ip, abort=21f
 		beq	17f
 		bgt	18f
 
 
 		.macro	forward_copy_shift pull push
 
-		subs	r2, r2, #28
+		subs	lr, lr, #28
 		blt	14f
 
-	CALGN(	ands	ip, r0, #31		)
-	CALGN(	rsb	ip, ip, #32		)
-	CALGN(	sbcnes	r4, ip, r2		)  @ C is always set here
-	CALGN(	subcc	r2, r2, ip		)
+	CALGN(	ands	r3, r0, #31		)
+	CALGN(	rsb	r3, r3, #32		)
+	CALGN(	sbcnes	r4, r3, lr		)  @ C is always set here
+	CALGN(	subcc	lr, lr, r3		)
 	CALGN(	bcc	15f			)
 
 11:		stmfd	sp!, {r5 - r9}
 
 	PLD(	pld	[r1, #0]		)
-	PLD(	subs	r2, r2, #96		)
+	PLD(	subs	lr, lr, #96		)
 	PLD(	pld	[r1, #28]		)
 	PLD(	blt	13f			)
 	PLD(	pld	[r1, #60]		)
 	PLD(	pld	[r1, #92]		)
 
 12:	PLD(	pld	[r1, #124]		)
-13:		ldr4w	r1, r4, r5, r6, r7, abort=19f
-		mov	r3, lr, pull #\pull
-		subs	r2, r2, #32
-		ldr4w	r1, r8, r9, ip, lr, abort=19f
+13:		ldr4w	r1, r3, r4, r5, r6, abort=19f
+		mov	r2, ip, pull #\pull
+		subs	lr, lr, #32
+		ldr4w	r1, r7, r8, r9, ip, abort=19f
+		orr	r2, r2, r3, push #\push
+		mov	r3, r3, pull #\pull
 		orr	r3, r3, r4, push #\push
 		mov	r4, r4, pull #\pull
 		orr	r4, r4, r5, push #\push
@@ -213,25 +215,23 @@
 		orr	r8, r8, r9, push #\push
 		mov	r9, r9, pull #\pull
 		orr	r9, r9, ip, push #\push
-		mov	ip, ip, pull #\pull
-		orr	ip, ip, lr, push #\push
-		str8w	r0, r3, r4, r5, r6, r7, r8, r9, ip, , abort=19f
+		str8w	r0, r2, r3, r4, r5, r6, r7, r8, r9, abort=19f
 		bge	12b
-	PLD(	cmn	r2, #96			)
+	PLD(	cmn	lr, #96			)
 	PLD(	bge	13b			)
 
 		ldmfd	sp!, {r5 - r9}
 
-14:		ands	ip, r2, #28
+14:		ands	r3, lr, #28
 		beq	16f
 
-15:		mov	r3, lr, pull #\pull
-		ldr1w	r1, lr, abort=21f
-		subs	ip, ip, #4
-		orr	r3, r3, lr, push #\push
-		str1w	r0, r3, abort=21f
+15:		mov	r2, ip, pull #\pull
+		ldr1w	r1, ip, abort=21f
+		subs	r3, r3, #4
+		orr	r2, r2, ip, push #\push
+		str1w	r0, r2, abort=21f
 		bgt	15b
-	CALGN(	cmp	r2, #0			)
+	CALGN(	cmp	lr, #0			)
 	CALGN(	bge	11b			)
 
 16:		sub	r1, r1, #(\push / 8)
-- 
1.7.9.rc2
