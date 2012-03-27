From: boojin.kim@samsung.com (Boojin Kim)
Date: Tue, 27 Mar 2012 09:27:52 +0900
Subject: [PATCH 2/2] ARM: lib: use LDRD/STRD for data copy
In-Reply-To: <007201cd059e$4af2cc10$e0d86430$%kim@samsung.com>
References: <007201cd059e$4af2cc10$e0d86430$%kim@samsung.com>
Message-ID: <00d501cd0bb0$724ab260$56e01720$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch uses LDRD/STRD that loads and stores data as DWORD unit.
It brings better performance than LDRM/STRM with cortex-a15.

Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/lib/copy_from_user.S |    9 +++++++++
 arch/arm/lib/copy_template.S  |   14 ++++++++------
 arch/arm/lib/copy_to_user.S   |    9 +++++++++
 arch/arm/lib/memcpy.S         |    9 +++++++++
 4 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/arch/arm/lib/copy_from_user.S b/arch/arm/lib/copy_from_user.S
index 66a477a..dd1fe01 100644
--- a/arch/arm/lib/copy_from_user.S
+++ b/arch/arm/lib/copy_from_user.S
@@ -68,6 +68,15 @@
 	stmia \ptr!, {\reg1, \reg2, \reg3, \reg4, \reg5, \reg6, \reg7, \reg8}
 	.endm

+	.macro cpy8w dst src reg1 reg2 abort
+	.irp offset, #0, #8, #16, #24
+	ldr1w \src, \reg1, \abort
+	ldr1w \src, \reg2, \abort
+	strd \reg1, \reg2, [\dst, \offset]
+	.endr
+	add \dst, \dst, #32
+	.endm
+
 	.macro str1b ptr reg cond=al abort
 	str\cond\()b \reg, [\ptr], #1
 	.endm
diff --git a/arch/arm/lib/copy_template.S b/arch/arm/lib/copy_template.S
index 7dc5b8c..a2dd5e2 100644
--- a/arch/arm/lib/copy_template.S
+++ b/arch/arm/lib/copy_template.S
@@ -47,6 +47,11 @@
  *	Same as their ldr* counterparts, but data is stored to 'ptr' location
  *	rather than being loaded.
  *
+ * cpy8w src dst reg1 reg2 abort
+ *
+ *	This loads eight words starting from 'src' and stores them to 'dst'.
+ *	The 'abort' argument is used for fixup tables.
+ *
  * enter reg1 reg2
  *
  *	Preserve the provided registers on the stack plus any additional
@@ -102,18 +107,15 @@
 	PLD(	pld	[r1, #PLDSIZE*3-4]	)

 3:	PLD(	pld	[r1, #PLDSIZE*4-4]	)
-4:		ldr8w   r1, r3, r4, r5, r6, r7, r8, ip, lr, abort=20f
-		str8w   r0, r3, r4, r5, r6, r7, r8, ip, lr, abort=20f
-		ldr8w   r1, r3, r4, r5, r6, r7, r8, ip, lr, abort=20f
-		str8w   r0, r3, r4, r5, r6, r7, r8, ip, lr, abort=20f
+4:		cpy8w   r0, r1, r4, r5, abort=20f
+		cpy8w   r0, r1, r4, r5, abort=20f
 		subs	r2, r2, #PLDSIZE
 		bge	3b
 	PLD(	cmn	r2, #(PLDSIZE*3)	)
 	PLD(	bge	4b			)
 	PLD(	cmn	r2, #(PLDSIZE*4-32)	)
 	PLD(	blt	5f)
-.32cpy:		ldr8w   r1, r3, r4, r5, r6, r7, r8, ip, lr, abort=20f
-		str8w   r0, r3, r4, r5, r6, r7, r8, ip, lr, abort=20f
+32copy:		cpy8w   r0, r1, r4, r5, abort=20f
 #else
 2:	PLD(	subs	r2, r2, #(PLDSIZE*3)	)
 	PLD(	pld	[r1, #(PLDSIZE-4)]	)
diff --git a/arch/arm/lib/copy_to_user.S b/arch/arm/lib/copy_to_user.S
index d066df6..fc8ea7a 100644
--- a/arch/arm/lib/copy_to_user.S
+++ b/arch/arm/lib/copy_to_user.S
@@ -71,6 +71,15 @@
 	str1w \ptr, \reg8, \abort
 	.endm

+	.macro cpy8w dst src reg1 reg2 abort
+	.irp offset, #0, #8, #16, #24
+	ldrd \reg1, \reg2, [\src, \offset]
+	str1w \dst, \reg1, \abort
+	str1w \dst, \reg2, \abort
+	.endr
+	add \src, \src, #32
+	.endm
+
 	.macro str1b ptr reg cond=al abort
 	strusr	\reg, \ptr, 1, \cond, abort=\abort
 	.endm
diff --git a/arch/arm/lib/memcpy.S b/arch/arm/lib/memcpy.S
index a9b9e22..5b4ca72 100644
--- a/arch/arm/lib/memcpy.S
+++ b/arch/arm/lib/memcpy.S
@@ -40,6 +40,15 @@
 	stmia \ptr!, {\reg1, \reg2, \reg3, \reg4, \reg5, \reg6, \reg7, \reg8}
 	.endm

+	.macro cpy8w dst src reg1 reg2 abort
+	.irp offset, #0, #8, #16, #24
+	ldrd \reg1, \reg2, [\src, \offset]
+	strd \reg1, \reg2, [\dst, \offset]
+	.endr
+	add \src, \src, #32
+	add \dst, \dst, #32
+	.endm
+
 	.macro str1b ptr reg cond=al abort
 	str\cond\()b \reg, [\ptr], #1
 	.endm
--
1.7.1
