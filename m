From: linyongting@gmail.com (Lin Yongting)
Date: Tue, 25 Nov 2014 20:23:07 +0800
Subject: [PATCH] ARM: Add unwinding support for memory copy functions
Message-ID: <1416918187-26016-1-git-send-email-linyongting@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The memory copy functions(memcpy, __copy_from_user, __copy_to_user)
never had unwinding annotations added. Currently, when accessing
invalid pointer by these functions occurs the backtrace shown will
stop at these functions or some completely unrelated function.
Add unwinding annotations in hopes of getting a more useful backtrace
in following cases:
1. die on accessing invalid pointer by these functions
2. kprobe trapped at any instruction within these functions
3. interrupted at any instruction within these functions

Signed-off-by: Lin Yongting <linyongting@gmail.com>
---
 arch/arm/lib/copy_from_user.S |    5 +++++
 arch/arm/lib/copy_template.S  |   30 ++++++++++++++++++++++++++++++
 arch/arm/lib/copy_to_user.S   |    5 +++++
 arch/arm/lib/memcpy.S         |    5 +++++
 4 files changed, 45 insertions(+)

diff --git a/arch/arm/lib/copy_from_user.S b/arch/arm/lib/copy_from_user.S
index 66a477a..7a235b9 100644
--- a/arch/arm/lib/copy_from_user.S
+++ b/arch/arm/lib/copy_from_user.S
@@ -12,6 +12,7 @@
 
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/unwind.h>
 
 /*
  * Prototype:
@@ -77,6 +78,10 @@
 	stmdb	sp!, {r0, r2, r3, \reg1, \reg2}
 	.endm
 
+	.macro usave reg1 reg2
+	UNWIND(	.save {r0, r2, r3, \reg1, \reg2}	)
+	.endm
+
 	.macro exit reg1 reg2
 	add	sp, sp, #8
 	ldmfd	sp!, {r0, \reg1, \reg2}
diff --git a/arch/arm/lib/copy_template.S b/arch/arm/lib/copy_template.S
index 3bc8eb8..652e4d9 100644
--- a/arch/arm/lib/copy_template.S
+++ b/arch/arm/lib/copy_template.S
@@ -53,6 +53,12 @@
  *	data as needed by the implementation including this code. Called
  *	upon code entry.
  *
+ * usave reg1 reg2
+ *
+ *	Unwind annotation macro is corresponding for 'enter' macro.
+ *	It tell unwinder that preserved some provided registers on the stack
+ *	and additional data by a prior 'enter' macro.
+ *
  * exit reg1 reg2
  *
  *	Restore registers with the values previously saved with the
@@ -67,7 +73,12 @@
  */
 
 
+	UNWIND(	.fnstart			)
 		enter	r4, lr
+	UNWIND(	.fnend				)
+
+	UNWIND(	.fnstart			)
+		usave	r4, lr			  @ in first stmdb block
 
 		subs	r2, r2, #4
 		blt	8f
@@ -79,6 +90,11 @@
 
 1:		subs	r2, r2, #(28)
 		stmfd	sp!, {r5 - r8}
+	UNWIND(	.fnend				)
+
+	UNWIND(	.fnstart			)
+		usave	r4, lr
+	UNWIND(	.save	{r5 - r8}		) @ in second stmfd block
 		blt	5f
 
 	CALGN(	ands	ip, r0, #31		)
@@ -144,7 +160,10 @@
 	CALGN(	bcs	2b			)
 
 7:		ldmfd	sp!, {r5 - r8}
+	UNWIND(	.fnend				) @ end of second stmfd block
 
+	UNWIND(	.fnstart			)
+		usave	r4, lr			  @ still in first stmdb block
 8:		movs	r2, r2, lsl #31
 		ldr1b	r1, r3, ne, abort=21f
 		ldr1b	r1, r4, cs, abort=21f
@@ -173,10 +192,13 @@
 		ldr1w	r1, lr, abort=21f
 		beq	17f
 		bgt	18f
+	UNWIND(	.fnend				)
 
 
 		.macro	forward_copy_shift pull push
 
+	UNWIND(	.fnstart			)
+		usave	r4, lr			  @ still in first stmdb block
 		subs	r2, r2, #28
 		blt	14f
 
@@ -187,7 +209,11 @@
 	CALGN(	bcc	15f			)
 
 11:		stmfd	sp!, {r5 - r9}
+	UNWIND(	.fnend				)
 
+	UNWIND(	.fnstart			)
+		usave	r4, lr
+	UNWIND(	.save	{r5 - r9}		) @ in new second stmfd block
 	PLD(	pld	[r1, #0]		)
 	PLD(	subs	r2, r2, #96		)
 	PLD(	pld	[r1, #28]		)
@@ -221,7 +247,10 @@
 	PLD(	bge	13b			)
 
 		ldmfd	sp!, {r5 - r9}
+	UNWIND(	.fnend				) @ end of the second stmfd block
 
+	UNWIND(	.fnstart			)
+		usave	r4, lr			  @ still in first stmdb block
 14:		ands	ip, r2, #28
 		beq	16f
 
@@ -236,6 +265,7 @@
 
 16:		sub	r1, r1, #(\push / 8)
 		b	8b
+	UNWIND(	.fnend				)
 
 		.endm
 
diff --git a/arch/arm/lib/copy_to_user.S b/arch/arm/lib/copy_to_user.S
index d066df6..a9d3db1 100644
--- a/arch/arm/lib/copy_to_user.S
+++ b/arch/arm/lib/copy_to_user.S
@@ -12,6 +12,7 @@
 
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/unwind.h>
 
 /*
  * Prototype:
@@ -80,6 +81,10 @@
 	stmdb	sp!, {r0, r2, r3, \reg1, \reg2}
 	.endm
 
+	.macro usave reg1 reg2
+	UNWIND(	.save {r0, r2, r3, \reg1, \reg2}	)
+	.endm
+
 	.macro exit reg1 reg2
 	add	sp, sp, #8
 	ldmfd	sp!, {r0, \reg1, \reg2}
diff --git a/arch/arm/lib/memcpy.S b/arch/arm/lib/memcpy.S
index a9b9e22..7797e81 100644
--- a/arch/arm/lib/memcpy.S
+++ b/arch/arm/lib/memcpy.S
@@ -12,6 +12,7 @@
 
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/unwind.h>
 
 #define LDR1W_SHIFT	0
 #define STR1W_SHIFT	0
@@ -48,6 +49,10 @@
 	stmdb sp!, {r0, \reg1, \reg2}
 	.endm
 
+	.macro usave reg1 reg2
+	UNWIND(	.save	{r0, \reg1, \reg2}	)
+	.endm
+
 	.macro exit reg1 reg2
 	ldmfd sp!, {r0, \reg1, \reg2}
 	.endm
-- 
1.7.9.5
