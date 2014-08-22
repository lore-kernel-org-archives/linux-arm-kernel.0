From: geoff@infradead.org (Geoff Levand)
Date: Fri, 22 Aug 2014 19:49:16 +0000
Subject: [PATCH 7/9] arm64: Add atomic macros to assembler.h
In-Reply-To: <cover.1408736066.git.geoff@infradead.org>
References: <cover.1408736066.git.geoff@infradead.org>
Message-ID: <73d234924f6de3b3b274d5d5648e4bbea6810450.1408736066.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an assembler macro definition 'atomic' for performing generic
atomic operations.  Also add macro definitions for atomic_add,
atomic_sub, atomic_inc, and atomic_dec.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/include/asm/assembler.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 5901480..dad3118 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -23,6 +23,39 @@
 #include <asm/ptrace.h>
 #include <asm/thread_info.h>
 
+/**
+ * macro atomic - Macros for simple atomic operations.
+ *
+ * @op: The operation to perform.
+ * @reg: A 32 or 64 bit register to operate on.
+ * @value: The value for the operation.
+ * @tmp1:  A scratch register the same size as @reg.  Defaluts to x20.
+ * @tmp2: A 32 bit scratch register.  Defaluts to w21.
+ **/
+
+	.macro	atomic	op:req, reg:req, value:req, tmp1=x20, tmp2=w21
+.Latomic\@:	ldxr	\tmp1, [\reg]
+	\op	\tmp1, \tmp1, \value
+	stxr	\tmp2, \tmp1, [\reg]
+	cbnz	\tmp2, .Latomic\@
+	.endm
+
+	.macro	atomic_add	reg:req, value:req, tmp1=x20, tmp2=w21
+	atomic add, \reg, \value, \tmp1, \tmp2
+	.endm
+
+	.macro	atomic_sub	reg:req, value:req, tmp1, tmp2
+	atomic sub, \reg, \value, \tmp1, \tmp2
+	.endm
+
+	.macro	atomic_inc	reg:req, tmp1, tmp2
+	atomic add, \reg, 1, \tmp1, \tmp2
+	.endm
+
+	.macro	atomic_dec	reg:req, tmp1, tmp2
+	atomic sub, \reg, 1, \tmp1, \tmp2
+	.endm
+
 /*
  * Stack pushing/popping (register pairs only). Equivalent to store decrement
  * before, load increment after.
-- 
1.9.1
