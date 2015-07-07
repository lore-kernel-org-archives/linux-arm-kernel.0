From: will.deacon@arm.com (Will Deacon)
Date: Tue,  7 Jul 2015 19:21:35 +0100
Subject: [PATCH] arm64: lib: use pair accessors for copy_*_user routines
Message-ID: <1436293295-4353-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AArch64 instruction set contains load/store pair memory accessors,
so use these in our copy_*_user routines to transfer 16 bytes per
iteration.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/lib/copy_from_user.S | 17 +++++++++++------
 arch/arm64/lib/copy_in_user.S   | 17 +++++++++++------
 arch/arm64/lib/copy_to_user.S   | 17 +++++++++++------
 3 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/lib/copy_from_user.S b/arch/arm64/lib/copy_from_user.S
index 5e27add9d362..47c3fa5ae4ae 100644
--- a/arch/arm64/lib/copy_from_user.S
+++ b/arch/arm64/lib/copy_from_user.S
@@ -28,14 +28,19 @@
  *	x0 - bytes not copied
  */
 ENTRY(__copy_from_user)
-	add	x4, x1, x2			// upper user buffer boundary
-	subs	x2, x2, #8
+	add	x5, x1, x2			// upper user buffer boundary
+	subs	x2, x2, #16
+	b.mi	1f
+0:
+USER(9f, ldp	x3, x4, [x1], #16)
+	subs	x2, x2, #16
+	stp	x3, x4, [x0], #16
+	b.pl	0b
+1:	adds	x2, x2, #8
 	b.mi	2f
-1:
 USER(9f, ldr	x3, [x1], #8	)
-	subs	x2, x2, #8
+	sub	x2, x2, #8
 	str	x3, [x0], #8
-	b.pl	1b
 2:	adds	x2, x2, #4
 	b.mi	3f
 USER(9f, ldr	w3, [x1], #4	)
@@ -56,7 +61,7 @@ ENDPROC(__copy_from_user)
 
 	.section .fixup,"ax"
 	.align	2
-9:	sub	x2, x4, x1
+9:	sub	x2, x5, x1
 	mov	x3, x2
 10:	strb	wzr, [x0], #1			// zero remaining buffer space
 	subs	x3, x3, #1
diff --git a/arch/arm64/lib/copy_in_user.S b/arch/arm64/lib/copy_in_user.S
index 84b6c9bb9b93..436bcc5d77b5 100644
--- a/arch/arm64/lib/copy_in_user.S
+++ b/arch/arm64/lib/copy_in_user.S
@@ -30,14 +30,19 @@
  *	x0 - bytes not copied
  */
 ENTRY(__copy_in_user)
-	add	x4, x0, x2			// upper user buffer boundary
-	subs	x2, x2, #8
+	add	x5, x0, x2			// upper user buffer boundary
+	subs	x2, x2, #16
+	b.mi	1f
+0:
+USER(9f, ldp	x3, x4, [x1], #16)
+	subs	x2, x2, #16
+USER(9f, stp	x3, x4, [x0], #16)
+	b.pl	0b
+1:	adds	x2, x2, #8
 	b.mi	2f
-1:
 USER(9f, ldr	x3, [x1], #8	)
-	subs	x2, x2, #8
+	sub	x2, x2, #8
 USER(9f, str	x3, [x0], #8	)
-	b.pl	1b
 2:	adds	x2, x2, #4
 	b.mi	3f
 USER(9f, ldr	w3, [x1], #4	)
@@ -58,6 +63,6 @@ ENDPROC(__copy_in_user)
 
 	.section .fixup,"ax"
 	.align	2
-9:	sub	x0, x4, x0			// bytes not copied
+9:	sub	x0, x5, x0			// bytes not copied
 	ret
 	.previous
diff --git a/arch/arm64/lib/copy_to_user.S b/arch/arm64/lib/copy_to_user.S
index a0aeeb9b7a28..f5e1f526f408 100644
--- a/arch/arm64/lib/copy_to_user.S
+++ b/arch/arm64/lib/copy_to_user.S
@@ -28,14 +28,19 @@
  *	x0 - bytes not copied
  */
 ENTRY(__copy_to_user)
-	add	x4, x0, x2			// upper user buffer boundary
-	subs	x2, x2, #8
+	add	x5, x0, x2			// upper user buffer boundary
+	subs	x2, x2, #16
+	b.mi	1f
+0:
+	ldp	x3, x4, [x1], #16
+	subs	x2, x2, #16
+USER(9f, stp	x3, x4, [x0], #16)
+	b.pl	0b
+1:	adds	x2, x2, #8
 	b.mi	2f
-1:
 	ldr	x3, [x1], #8
-	subs	x2, x2, #8
+	sub	x2, x2, #8
 USER(9f, str	x3, [x0], #8	)
-	b.pl	1b
 2:	adds	x2, x2, #4
 	b.mi	3f
 	ldr	w3, [x1], #4
@@ -56,6 +61,6 @@ ENDPROC(__copy_to_user)
 
 	.section .fixup,"ax"
 	.align	2
-9:	sub	x0, x4, x0			// bytes not copied
+9:	sub	x0, x5, x0			// bytes not copied
 	ret
 	.previous
-- 
2.1.4
