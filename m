From: linyongting@gmail.com (Lin Yongting)
Date: Mon, 24 Nov 2014 21:45:56 +0800
Subject: [PATCH] ARM: Add unwinding support for memmove function
Message-ID: <1416836757-30547-1-git-send-email-linyongting@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The memmove function never had unwinding annotations added.
Currently, when accessing invalid pointer by memmove occurs the
backtrace shown will stop at memmove or some completely unrelated
function. Add unwinding annotations in hopes of getting a more
useful backtrace in following cases:
1. die on accessing invalid pointer by memmove
2. kprobe trapped at any instruction within memmove
3. interrupted at any instruction within memmove

Signed-off-by: Lin Yongting <linyongting@gmail.com>
---
 arch/arm/lib/memmove.S |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/lib/memmove.S b/arch/arm/lib/memmove.S
index d1fc0c0..69a9d47 100644
--- a/arch/arm/lib/memmove.S
+++ b/arch/arm/lib/memmove.S
@@ -12,6 +12,7 @@
 
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/unwind.h>
 
 		.text
 
@@ -27,12 +28,17 @@
  */
 
 ENTRY(memmove)
+	UNWIND(	.fnstart			)
 
 		subs	ip, r0, r1
 		cmphi	r2, ip
 		bls	memcpy
 
 		stmfd	sp!, {r0, r4, lr}
+	UNWIND(	.fnend				)
+
+	UNWIND(	.fnstart			)
+	UNWIND(	.save	{r0, r4, lr}		) @ in first stmfd block
 		add	r1, r1, r2
 		add	r0, r0, r2
 		subs	r2, r2, #4
@@ -45,6 +51,11 @@ ENTRY(memmove)
 
 1:		subs	r2, r2, #(28)
 		stmfd	sp!, {r5 - r8}
+	UNWIND(	.fnend				)
+
+	UNWIND(	.fnstart			)
+	UNWIND(	.save	{r0, r4, lr}		)
+	UNWIND(	.save	{r5 - r8}		) @ in second stmfd block
 		blt	5f
 
 	CALGN(	ands	ip, r0, #31		)
@@ -97,6 +108,10 @@ ENTRY(memmove)
 	CALGN(	bcs	2b			)
 
 7:		ldmfd	sp!, {r5 - r8}
+	UNWIND(	.fnend				) @ end of second stmfd block
+
+	UNWIND(	.fnstart			)
+	UNWIND(	.save	{r0, r4, lr}		) @ still in first stmfd block
 
 8:		movs	r2, r2, lsl #31
 		ldrneb	r3, [r1, #-1]!
@@ -124,10 +139,13 @@ ENTRY(memmove)
 		ldr	r3, [r1, #0]
 		beq	17f
 		blt	18f
+	UNWIND(	.fnend				)
 
 
 		.macro	backward_copy_shift push pull
 
+	UNWIND(	.fnstart			)
+	UNWIND(	.save	{r0, r4, lr}		) @ still in first stmfd block
 		subs	r2, r2, #28
 		blt	14f
 
@@ -137,6 +155,11 @@ ENTRY(memmove)
 	CALGN(	bcc	15f			)
 
 11:		stmfd	sp!, {r5 - r9}
+	UNWIND(	.fnend				)
+
+	UNWIND(	.fnstart			)
+	UNWIND(	.save	{r0, r4, lr}		)
+	UNWIND(	.save	{r5 - r9}		) @ in new second stmfd block
 
 	PLD(	pld	[r1, #-4]		)
 	PLD(	subs	r2, r2, #96		)
@@ -171,6 +194,10 @@ ENTRY(memmove)
 	PLD(	bge	13b			)
 
 		ldmfd	sp!, {r5 - r9}
+	UNWIND(	.fnend				) @ end of the second stmfd block
+
+	UNWIND(	.fnstart			)
+	UNWIND(	.save {r0, r4, lr}		) @ still in first stmfd block
 
 14:		ands	ip, r2, #28
 		beq	16f
@@ -186,6 +213,7 @@ ENTRY(memmove)
 
 16:		add	r1, r1, #(\pull / 8)
 		b	8b
+	UNWIND(	.fnend				)
 
 		.endm
 
-- 
1.7.9.5
