From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 27 Mar 2012 14:54:03 +0100
Subject: [PATCH v2 2/4] ARM: opcodes: Make opcode byteswapping macros
 assembly-compatible
In-Reply-To: <1332856445-7007-1-git-send-email-dave.martin@linaro.org>
References: <1332856445-7007-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1332856445-7007-3-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most of the existing macros don't work with assembler, due to the
use of type casts and C functions from <linux/swab.h>.

This patch abstracts out those operations and provides simple
explicit versions for use in assembly code.

__opcode_is_thumb32() and __opcode_is_thumb16() are also converted
to do bitmask-based testing to avoid confusion if these are used in
assembly code (the assembler typically treats all arithmetic values
as signed).

These changes avoid the need for the compiler to pre-evaluate
constant expressions used to generate opcodes.  By ensuring that
the forms of these expressions can be evaluated directly by the
assembler, we can just stringify the expressions directly into the
asm during the preprocessing pass.  The alternative approach
(passing the evaluated expression via an inline asm "i" constraint)
gets painful because the contents of the asm and the constraints
must be kept in sync.  This makes the resulting macros awkward to
use.

Retaining the C forms of the macros allows more efficient code to
be generated when opcodes are generated programmatically at run-
time, but there is no way to embed run-time-generated opcodes in
asm() blocks.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
Acked-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/include/asm/opcodes.h |   97 +++++++++++++++++++++++++++++++++------
 1 files changed, 82 insertions(+), 15 deletions(-)

diff --git a/arch/arm/include/asm/opcodes.h b/arch/arm/include/asm/opcodes.h
index 6bf54f9..f57e417 100644
--- a/arch/arm/include/asm/opcodes.h
+++ b/arch/arm/include/asm/opcodes.h
@@ -19,6 +19,33 @@ extern asmlinkage unsigned int arm_check_condition(u32 opcode, u32 psr);
 
 
 /*
+ * Assembler opcode byteswap helpers.
+ * These are only intended for use by this header: don't use them directly,
+ * because they will be suboptimal in most cases.
+ */
+#define ___asm_opcode_swab32(x) (	\
+	  (((x) << 24) & 0xFF000000)	\
+	| (((x) <<  8) & 0x00FF0000)	\
+	| (((x) >>  8) & 0x0000FF00)	\
+	| (((x) >> 24) & 0x000000FF)	\
+)
+#define ___asm_opcode_swab16(x) (	\
+	  (((x) << 8) & 0xFF00)		\
+	| (((x) >> 8) & 0x00FF)		\
+)
+#define ___asm_opcode_swahb32(x) (	\
+	  (((x) << 8) & 0xFF00FF00)	\
+	| (((x) >> 8) & 0x00FF00FF)	\
+)
+#define ___asm_opcode_swahw32(x) (	\
+	  (((x) << 16) & 0xFFFF0000)	\
+	| (((x) >> 16) & 0x0000FFFF)	\
+)
+#define ___asm_opcode_identity32(x) ((x) & 0xFFFFFFFF)
+#define ___asm_opcode_identity16(x) ((x) & 0xFFFF)
+
+
+/*
  * Opcode byteswap helpers
  *
  * These macros help with converting instructions between a canonical integer
@@ -41,30 +68,58 @@ extern asmlinkage unsigned int arm_check_condition(u32 opcode, u32 psr);
  * Note that values in the range 0x0000E800..0xE7FFFFFF intentionally do not
  * represent any valid Thumb-2 instruction.  For this range,
  * __opcode_is_thumb32() and __opcode_is_thumb16() will both be false.
+ *
+ * The ___asm variants are intended only for use by this header, in situations
+ * involving inline assembler.  For .S files, the normal __opcode_*() macros
+ * should do the right thing.
  */
+#ifdef __ASSEMBLY__
 
-#ifndef __ASSEMBLY__
+#define ___opcode_swab32(x) ___asm_opcode_swab32(x)
+#define ___opcode_swab16(x) ___asm_opcode_swab16(x)
+#define ___opcode_swahb32(x) ___asm_opcode_swahb32(x)
+#define ___opcode_swahw32(x) ___asm_opcode_swahw32(x)
+#define ___opcode_identity32(x) ___asm_opcode_identity32(x)
+#define ___opcode_identity16(x) ___asm_opcode_identity16(x)
+
+#else /* ! __ASSEMBLY__ */
 
 #include <linux/types.h>
 #include <linux/swab.h>
 
+#define ___opcode_swab32(x) swab32(x)
+#define ___opcode_swab16(x) swab16(x)
+#define ___opcode_swahb32(x) swahb32(x)
+#define ___opcode_swahw32(x) swahw32(x)
+#define ___opcode_identity32(x) ((u32)(x))
+#define ___opcode_identity16(x) ((u16)(x))
+
+#endif /* ! __ASSEMBLY__ */
+
+
 #ifdef CONFIG_CPU_ENDIAN_BE8
 
-#define __opcode_to_mem_arm(x) swab32(x)
-#define __opcode_to_mem_thumb16(x) swab16(x)
-#define __opcode_to_mem_thumb32(x) swahb32(x)
+#define __opcode_to_mem_arm(x) ___opcode_swab32(x)
+#define __opcode_to_mem_thumb16(x) ___opcode_swab16(x)
+#define __opcode_to_mem_thumb32(x) ___opcode_swahb32(x)
+#define ___asm_opcode_to_mem_arm(x) ___asm_opcode_swab32(x)
+#define ___asm_opcode_to_mem_thumb16(x) ___asm_opcode_swab16(x)
+#define ___asm_opcode_to_mem_thumb32(x) ___asm_opcode_swahb32(x)
 
 #else /* ! CONFIG_CPU_ENDIAN_BE8 */
 
-#define __opcode_to_mem_arm(x) ((u32)(x))
-#define __opcode_to_mem_thumb16(x) ((u16)(x))
+#define __opcode_to_mem_arm(x) ___opcode_identity32(x)
+#define __opcode_to_mem_thumb16(x) ___opcode_identity16(x)
+#define ___asm_opcode_to_mem_arm(x) ___asm_opcode_identity32(x)
+#define ___asm_opcode_to_mem_thumb16(x) ___asm_opcode_identity16(x)
 #ifndef CONFIG_CPU_ENDIAN_BE32
 /*
  * On BE32 systems, using 32-bit accesses to store Thumb instructions will not
  * work in all cases, due to alignment constraints.  For now, a correct
  * version is not provided for BE32.
  */
-#define __opcode_to_mem_thumb32(x) swahw32(x)
+#define __opcode_to_mem_thumb32(x) ___opcode_swahw32(x)
+#define ___asm_opcode_to_mem_thumb32(x) ___asm_opcode_swahw32(x)
 #endif
 
 #endif /* ! CONFIG_CPU_ENDIAN_BE8 */
@@ -78,15 +133,27 @@ extern asmlinkage unsigned int arm_check_condition(u32 opcode, u32 psr);
 /* Operations specific to Thumb opcodes */
 
 /* Instruction size checks: */
-#define __opcode_is_thumb32(x) ((u32)(x) >= 0xE8000000UL)
-#define __opcode_is_thumb16(x) ((u32)(x) < 0xE800UL)
+#define __opcode_is_thumb32(x) (		\
+	   ((x) & 0xF8000000) == 0xE8000000	\
+	|| ((x) & 0xF0000000) == 0xF0000000	\
+)
+#define __opcode_is_thumb16(x) (					\
+	   ((x) & 0xFFFF0000) == 0					\
+	&& !(((x) & 0xF800) == 0xE800 || ((x) & 0xF000) == 0xF000)	\
+)
 
 /* Operations to construct or split 32-bit Thumb instructions: */
-#define __opcode_thumb32_first(x) ((u16)((x) >> 16))
-#define __opcode_thumb32_second(x) ((u16)(x))
-#define __opcode_thumb32_compose(first, second) \
-	(((u32)(u16)(first) << 16) | (u32)(u16)(second))
-
-#endif /* __ASSEMBLY__ */
+#define __opcode_thumb32_first(x) (___opcode_identity16((x) >> 16))
+#define __opcode_thumb32_second(x) (___opcode_identity16(x))
+#define __opcode_thumb32_compose(first, second) (			\
+	  (___opcode_identity32(___opcode_identity16(first)) << 16)	\
+	| ___opcode_identity32(___opcode_identity16(second))		\
+)
+#define ___asm_opcode_thumb32_first(x) (___asm_opcode_identity16((x) >> 16))
+#define ___asm_opcode_thumb32_second(x) (___asm_opcode_identity16(x))
+#define ___asm_opcode_thumb32_compose(first, second) (			    \
+	  (___asm_opcode_identity32(___asm_opcode_identity16(first)) << 16) \
+	| ___asm_opcode_identity32(___asm_opcode_identity16(second))	    \
+)
 
 #endif /* __ASM_ARM_OPCODES_H */
-- 
1.7.4.1
