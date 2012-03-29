From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 29 Mar 2012 00:00:22 -0400
Subject: [PATCH 2/4] ARM: copy_template.S: rework the unaligned copy loop
In-Reply-To: <1332993624-16552-1-git-send-email-nico@fluxnic.net>
References: <alpine.LFD.2.02.1203280119550.24151@xanadu.home>
 <1332993624-16552-1-git-send-email-nico@fluxnic.net>
Message-ID: <1332993624-16552-3-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nicolas.pitre@linaro.org>

Let's rework the unaligned copy loop to enforce a range of contigous
registers starting from an even register, and to use a single ldr8w
construct instead of two ldr4w's.  There are no users of ldr4w anymore,
so its various definitions are removed.

By using one additional temporary registers, it is possible to have the
same register set for the loads and the stores, and to make the loop
friendlier to superscalar CPUs at the same time.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/lib/copy_from_user.S |   11 +++----
 arch/arm/lib/copy_template.S  |   57 ++++++++++++++++++++---------------------
 arch/arm/lib/copy_to_user.S   |    4 ---
 arch/arm/lib/memcpy.S         |    4 ---
 4 files changed, 33 insertions(+), 43 deletions(-)

diff --git a/arch/arm/lib/copy_from_user.S b/arch/arm/lib/copy_from_user.S
index 66a477a3e3..d1df0ec62b 100644
--- a/arch/arm/lib/copy_from_user.S
+++ b/arch/arm/lib/copy_from_user.S
@@ -44,16 +44,15 @@
 	ldrusr	\reg, \ptr, 4, abort=\abort
 	.endm
 
-	.macro ldr4w ptr reg1 reg2 reg3 reg4 abort
+	.macro ldr8w ptr reg1 reg2 reg3 reg4 reg5 reg6 reg7 reg8 abort
 	ldr1w \ptr, \reg1, \abort
 	ldr1w \ptr, \reg2, \abort
 	ldr1w \ptr, \reg3, \abort
 	ldr1w \ptr, \reg4, \abort
-	.endm
-
-	.macro ldr8w ptr reg1 reg2 reg3 reg4 reg5 reg6 reg7 reg8 abort
-	ldr4w \ptr, \reg1, \reg2, \reg3, \reg4, \abort
-	ldr4w \ptr, \reg5, \reg6, \reg7, \reg8, \abort
+	ldr1w \ptr, \reg5, \abort
+	ldr1w \ptr, \reg6, \abort
+	ldr1w \ptr, \reg7, \abort
+	ldr1w \ptr, \reg8, \abort
 	.endm
 
 	.macro ldr1b ptr reg cond=al abort
diff --git a/arch/arm/lib/copy_template.S b/arch/arm/lib/copy_template.S
index 7244dcef0d..84e94cd48c 100644
--- a/arch/arm/lib/copy_template.S
+++ b/arch/arm/lib/copy_template.S
@@ -27,10 +27,9 @@
  *	This loads one word from 'ptr', stores it in 'reg' and increments
  *	'ptr' to the next word. The 'abort' argument is used for fixup tables.
  *
- * ldr4w ptr reg1 reg2 reg3 reg4 abort
  * ldr8w ptr, reg1 reg2 reg3 reg4 reg5 reg6 reg7 reg8 abort
  *
- *	This loads four or eight words starting from 'ptr', stores them
+ *	This loads eight words starting from 'ptr', stores them
  *	in provided registers and increments 'ptr' past those words.
  *	The'abort' argument is used for fixup tables.
  *
@@ -63,7 +62,7 @@
  *
  *	Correction to be applied to the "ip" register when branching into
  *	the ldr1w or str1w instructions (some of these macros may expand to
- *	than one 32bit instruction in Thumb-2)
+ *	more than one 32bit instruction in Thumb-2)
  */
 
 
@@ -170,7 +169,7 @@
 
 10:		bic	r1, r1, #3
 		cmp	ip, #2
-		ldr1w	r1, ip, abort=21f
+		ldr1w	r1, r2, abort=21f
 		beq	17f
 		bgt	18f
 
@@ -178,6 +177,7 @@
 		.macro	forward_copy_shift pull push
 
 		subs	lr, lr, #28
+		mov	ip, r2, pull #\pull
 		blt	14f
 
 	CALGN(	ands	r3, r0, #31		)
@@ -186,7 +186,7 @@
 	CALGN(	subcc	lr, lr, r3		)
 	CALGN(	bcc	15f			)
 
-11:		stmfd	sp!, {r5 - r9}
+11:		stmfd	sp!, {r5 - sl}
 
 	PLD(	pld	[r1, #0]		)
 	PLD(	subs	lr, lr, #96		)
@@ -196,40 +196,39 @@
 	PLD(	pld	[r1, #92]		)
 
 12:	PLD(	pld	[r1, #124]		)
-13:		ldr4w	r1, r3, r4, r5, r6, abort=19f
-		mov	r2, ip, pull #\pull
+13:		ldr8w	r1, r2, r3, r4, r5, r6, r7, r8, r9, abort=19f
 		subs	lr, lr, #32
-		ldr4w	r1, r7, r8, r9, ip, abort=19f
-		orr	r2, r2, r3, push #\push
-		mov	r3, r3, pull #\pull
-		orr	r3, r3, r4, push #\push
-		mov	r4, r4, pull #\pull
-		orr	r4, r4, r5, push #\push
-		mov	r5, r5, pull #\pull
-		orr	r5, r5, r6, push #\push
-		mov	r6, r6, pull #\pull
-		orr	r6, r6, r7, push #\push
-		mov	r7, r7, pull #\pull
-		orr	r7, r7, r8, push #\push
-		mov	r8, r8, pull #\pull
-		orr	r8, r8, r9, push #\push
-		mov	r9, r9, pull #\pull
-		orr	r9, r9, ip, push #\push
+		mov	sl, r2, pull #\pull
+		orr	r2, ip, r2, push #\push
+		mov	ip, r3, pull #\pull
+		orr	r3, sl, r3, push #\push
+		mov	sl, r4, pull #\pull
+		orr	r4, ip, r4, push #\push
+		mov	ip, r5, pull #\pull
+		orr	r5, sl, r5, push #\push
+		mov	sl, r6, pull #\pull
+		orr	r6, ip, r6, push #\push
+		mov	ip, r7, pull #\pull
+		orr	r7, sl, r7, push #\push
+		mov	sl, r8, pull #\pull
+		orr	r8, ip, r8, push #\push
+		mov	ip, r9, pull #\pull
+		orr	r9, sl, r9, push #\push
 		str8w	r0, r2, r3, r4, r5, r6, r7, r8, r9, abort=19f
 		bge	12b
 	PLD(	cmn	lr, #96			)
 	PLD(	bge	13b			)
 
-		ldmfd	sp!, {r5 - r9}
+		ldmfd	sp!, {r5 - sl}
 
 14:		ands	r3, lr, #28
 		beq	16f
 
-15:		mov	r2, ip, pull #\pull
-		ldr1w	r1, ip, abort=21f
+15:		ldr1w	r1, r2, abort=21f
 		subs	r3, r3, #4
-		orr	r2, r2, ip, push #\push
-		str1w	r0, r2, abort=21f
+		orr	r4, ip, r2, push #\push
+		mov	ip, r2, pull #\pull
+		str1w	r0, r4, abort=21f
 		bgt	15b
 	CALGN(	cmp	lr, #0			)
 	CALGN(	bge	11b			)
@@ -255,7 +254,7 @@
  */
 
 	.macro	copy_abort_preamble
-19:	ldmfd	sp!, {r5 - r9}
+19:	ldmfd	sp!, {r5 - sl}
 	b	21f
 20:	ldmfd	sp!, {r5 - r8}
 21:
diff --git a/arch/arm/lib/copy_to_user.S b/arch/arm/lib/copy_to_user.S
index d066df686e..a83bc04365 100644
--- a/arch/arm/lib/copy_to_user.S
+++ b/arch/arm/lib/copy_to_user.S
@@ -44,10 +44,6 @@
 	W(ldr) \reg, [\ptr], #4
 	.endm
 
-	.macro ldr4w ptr reg1 reg2 reg3 reg4 abort
-	ldmia \ptr!, {\reg1, \reg2, \reg3, \reg4}
-	.endm
-
 	.macro ldr8w ptr reg1 reg2 reg3 reg4 reg5 reg6 reg7 reg8 abort
 	ldmia \ptr!, {\reg1, \reg2, \reg3, \reg4, \reg5, \reg6, \reg7, \reg8}
 	.endm
diff --git a/arch/arm/lib/memcpy.S b/arch/arm/lib/memcpy.S
index a9b9e2287a..adbccc6e2d 100644
--- a/arch/arm/lib/memcpy.S
+++ b/arch/arm/lib/memcpy.S
@@ -20,10 +20,6 @@
 	W(ldr) \reg, [\ptr], #4
 	.endm
 
-	.macro ldr4w ptr reg1 reg2 reg3 reg4 abort
-	ldmia \ptr!, {\reg1, \reg2, \reg3, \reg4}
-	.endm
-
 	.macro ldr8w ptr reg1 reg2 reg3 reg4 reg5 reg6 reg7 reg8 abort
 	ldmia \ptr!, {\reg1, \reg2, \reg3, \reg4, \reg5, \reg6, \reg7, \reg8}
 	.endm
-- 
1.7.9.rc2
