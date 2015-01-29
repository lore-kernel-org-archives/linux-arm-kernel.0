From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 29 Jan 2015 16:24:43 +0000
Subject: [PATCH] arm64: Avoid breakage caused by .altmacro in fpsimd
 save/restore macros
Message-ID: <1422548683-25544-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alternate macro mode is not a property of a macro definition, but a
gas runtime state that alters the way macros are expanded for ever
after (until .noaltmacro is seen).

This means that subsequent assembly code that calls other macros can
break if fpsimdmacros.h is included.

Since these instruction sequences are simple (if dull -- but in a
good way), this patch solves the problem by simply expanding the
.irp loops.  The pre-existing fpsimd_{save,restore} macros weren't
rolled with .irp anyway and the sequences affected are short, so
this change restores consistency at little cost.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/asm/fpsimdmacros.h |   43 ++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimdmacros.h b/arch/arm64/include/asm/fpsimdmacros.h
index 007618b..a2daf12 100644
--- a/arch/arm64/include/asm/fpsimdmacros.h
+++ b/arch/arm64/include/asm/fpsimdmacros.h
@@ -76,7 +76,6 @@
 	fpsimd_restore_fpcr x\tmpnr, \state
 .endm
 
-.altmacro
 .macro fpsimd_save_partial state, numnr, tmpnr1, tmpnr2
 	mrs	x\tmpnr1, fpsr
 	str	w\numnr, [\state, #8]
@@ -86,11 +85,22 @@
 	add	\state, \state, x\numnr, lsl #4
 	sub	x\tmpnr1, x\tmpnr1, x\numnr, lsl #1
 	br	x\tmpnr1
-	.irp	qa, 30, 28, 26, 24, 22, 20, 18, 16, 14, 12, 10, 8, 6, 4, 2, 0
-	.irp	qb, %(qa + 1)
-	stp	q\qa, q\qb, [\state, # -16 * \qa - 16]
-	.endr
-	.endr
+	stp	q30, q31, [\state, #-16 * 30 - 16]
+	stp	q28, q29, [\state, #-16 * 28 - 16]
+	stp	q26, q27, [\state, #-16 * 26 - 16]
+	stp	q24, q25, [\state, #-16 * 24 - 16]
+	stp	q22, q23, [\state, #-16 * 22 - 16]
+	stp	q20, q21, [\state, #-16 * 20 - 16]
+	stp	q18, q19, [\state, #-16 * 18 - 16]
+	stp	q16, q17, [\state, #-16 * 16 - 16]
+	stp	q14, q15, [\state, #-16 * 14 - 16]
+	stp	q12, q13, [\state, #-16 * 12 - 16]
+	stp	q10, q11, [\state, #-16 * 10 - 16]
+	stp	q8, q9, [\state, #-16 * 8 - 16]
+	stp	q6, q7, [\state, #-16 * 6 - 16]
+	stp	q4, q5, [\state, #-16 * 4 - 16]
+	stp	q2, q3, [\state, #-16 * 2 - 16]
+	stp	q0, q1, [\state, #-16 * 0 - 16]
 0:
 .endm
 
@@ -103,10 +113,21 @@
 	add	\state, \state, x\tmpnr2, lsl #4
 	sub	x\tmpnr1, x\tmpnr1, x\tmpnr2, lsl #1
 	br	x\tmpnr1
-	.irp	qa, 30, 28, 26, 24, 22, 20, 18, 16, 14, 12, 10, 8, 6, 4, 2, 0
-	.irp	qb, %(qa + 1)
-	ldp	q\qa, q\qb, [\state, # -16 * \qa - 16]
-	.endr
-	.endr
+	ldp	q30, q31, [\state, #-16 * 30 - 16]
+	ldp	q28, q29, [\state, #-16 * 28 - 16]
+	ldp	q26, q27, [\state, #-16 * 26 - 16]
+	ldp	q24, q25, [\state, #-16 * 24 - 16]
+	ldp	q22, q23, [\state, #-16 * 22 - 16]
+	ldp	q20, q21, [\state, #-16 * 20 - 16]
+	ldp	q18, q19, [\state, #-16 * 18 - 16]
+	ldp	q16, q17, [\state, #-16 * 16 - 16]
+	ldp	q14, q15, [\state, #-16 * 14 - 16]
+	ldp	q12, q13, [\state, #-16 * 12 - 16]
+	ldp	q10, q11, [\state, #-16 * 10 - 16]
+	ldp	q8, q9, [\state, #-16 * 8 - 16]
+	ldp	q6, q7, [\state, #-16 * 6 - 16]
+	ldp	q4, q5, [\state, #-16 * 4 - 16]
+	ldp	q2, q3, [\state, #-16 * 2 - 16]
+	ldp	q0, q1, [\state, #-16 * 0 - 16]
 0:
 .endm
-- 
1.7.10.4
