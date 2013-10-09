From: Dave.Martin@arm.com (Dave Martin)
Date: Wed,  9 Oct 2013 15:29:51 +0100
Subject: [RFC PATCH 2/4] ARM: Add common compile-time swab32 for asm code
In-Reply-To: <1381328993-12724-1-git-send-email-Dave.Martin@arm.com>
References: <1381328993-12724-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1381328993-12724-3-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

<linux/swab.h> doesn't work for asm code, yet swabbing constants
for asm is still useful, such as when writing code which needs to
build with different target endiannesses.

This patch adds a simple asm_swab32() macro so that this operation
doesn't need to be reinvented repeatedly.

Since <asm/opcodes.h> already defines this operation, this patch
lifts the definition into assembler.h and makes opcodes.h use it.

The other swab variants defined by opcodes.h could be transferred
too, but there is no clear need for that yet.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm/include/asm/assembler.h |   23 +++++++++++++++++++++++
 arch/arm/include/asm/opcodes.h   |    9 +++------
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index a71d117..860256c 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -380,4 +380,27 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
 
 #endif /* __ASSEMBLY__ */
 
+/*
+ * Use asm_swab32() only for compile-time swabbing of constants for
+ * assembly code.  in inline asm, the argument is a string
+ * representation of an expression which will be passed through to the
+ * assembler, so it can't contain embedded C expressions or preprocessor
+ * macros.  Macros would need to be pre-expanded using __stringify().
+ */
+#ifdef __ASSEMBLY__
+#define __asm_swab32(x) (			\
+	  (((x) >> 24) & 0x000000ff)		\
+	| (((x) >> 8)  & 0x0000ff00)		\
+	| (((x) << 8)  & 0x00ff0000)		\
+	| (((x) << 24) & 0xff000000)		\
+)
+#else /* ! __ASSEMBLY__ */
+#define __asm_swab32(x) "( "			\
+	  "(((" x ") >> 24) & 0x000000ff) "	\
+	"| (((" x ") >> 8)  & 0x0000ff00) "	\
+	"| (((" x ") << 8)  & 0x00ff0000) "	\
+	"| (((" x ") << 24) & 0xff000000) "	\
+")"
+#endif /* ! __ASSEMBLY__ */
+
 #endif /* __ASM_ASSEMBLER_H__ */
diff --git a/arch/arm/include/asm/opcodes.h b/arch/arm/include/asm/opcodes.h
index e796c59..b2e93c9 100644
--- a/arch/arm/include/asm/opcodes.h
+++ b/arch/arm/include/asm/opcodes.h
@@ -9,6 +9,8 @@
 #ifndef __ASM_ARM_OPCODES_H
 #define __ASM_ARM_OPCODES_H
 
+#include <asm/assembler.h>
+
 #ifndef __ASSEMBLY__
 #include <linux/linkage.h>
 extern asmlinkage unsigned int arm_check_condition(u32 opcode, u32 psr);
@@ -24,12 +26,7 @@ extern asmlinkage unsigned int arm_check_condition(u32 opcode, u32 psr);
  * These are only intended for use by this header: don't use them directly,
  * because they will be suboptimal in most cases.
  */
-#define ___asm_opcode_swab32(x) (	\
-	  (((x) << 24) & 0xFF000000)	\
-	| (((x) <<  8) & 0x00FF0000)	\
-	| (((x) >>  8) & 0x0000FF00)	\
-	| (((x) >> 24) & 0x000000FF)	\
-)
+#define ___asm_opcode_swab32(x) __asm_swab32(x)
 #define ___asm_opcode_swab16(x) (	\
 	  (((x) << 8) & 0xFF00)		\
 	| (((x) >> 8) & 0x00FF)		\
-- 
1.7.9.5
