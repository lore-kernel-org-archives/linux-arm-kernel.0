From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 19 Dec 2011 14:36:05 +0000
Subject: [PATCH v4] ARM: Add generic instruction opcode manipulation helpers
Message-ID: <1324305365-22514-1-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds some endianness-agnostic helpers to convert machine
instructions between canonical integer form and in-memory
representation.

A canonical integer form for representing instructions is also
formalised here.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
Acked-by: Nicolas Pitre <nico@linaro.org>
---
Changes since v1:

v4: Rebase on top of Leif's patch which created <asm/opcodes.h>
    ARM: 7206/1: Add generic ARM instruction set condition code checks.

    No functional changes.

v3: Fix some stupid errors:

  * remove bogus extra (x) in __opcode_to_mem_arm
  * fix use of nonexistent "thumb_opcode" argument in
        __opcode_thumb32_{first,second} which causes these
        macros to be broken.

v2: Remove unnecessary typedef for arm_opcode_t.

    The general "everything is a word" concept works just fine here --
    we don't need a typedef, and people will probably not use it
    anyway.

 arch/arm/include/asm/opcodes.h |   68 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 68 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/include/asm/opcodes.h

diff --git a/arch/arm/include/asm/opcodes.h b/arch/arm/include/asm/opcodes.h
new file mode 100644
index 0000000..eed11db
--- /dev/null
+++ b/arch/arm/include/asm/opcodes.h
@@ -0,0 +1,68 @@
+/*
+ * arch/arm/include/asm/opcodes.h
+ *
+ * Copyright (C) 2011 Linaro Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#ifndef __ARM_OPCODES_H
+#define __ARM_OPCODES_H
+
+#include <linux/types.h>
+#include <linux/swab.h>
+
+/*
+ * Canonical instruction representation:
+ *
+ *	ARM:		0xKKLLMMNN
+ *	Thumb 16-bit:	0x0000KKLL, where KK < 0xE8
+ *	Thumb 32-bit:	0xKKLLMMNN, where KK >= 0xE8
+ *
+ * There is no way to distinguish an ARM instruction in canonical representation
+ * from a Thumb instruction (just as these cannot be distinguished in memory).
+ * Where this distinction is important, it needs to be tracked separately.
+ *
+ * Note that values in the range 0x0000E800..0xE7FFFFFF intentionally do not
+ * represent any valid Thumb-2 instruction.  For this range,
+ * __opcode_is_thumb32() and __opcode_is_thumb16() will both be false.
+ */
+
+#ifdef CONFIG_CPU_ENDIAN_BE8
+#define __opcode_to_mem_arm(x) swab32(x)
+#define __opcode_to_mem_thumb16(x) swab16(x)
+#define __opcode_to_mem_thumb32(x) swahb32(x)
+#else
+#define __opcode_to_mem_arm(x) ((u32)(x))
+#define __opcode_to_mem_thumb16(x) ((u16)(x))
+#define __opcode_to_mem_thumb32(x) swahw32(x)
+#endif
+
+#define __mem_to_opcode_arm(x) __opcode_to_mem_arm(x)
+#define __mem_to_opcode_thumb16(x) __opcode_to_mem_thumb16(x)
+#define __mem_to_opcode_thumb32(x) __opcode_to_mem_thumb32(x)
+
+/* Operations specific to Thumb opcodes */
+
+/* Instruction size checks: */
+#define __opcode_is_thumb32(x) ((u32)(x) >= 0xE8000000UL)
+#define __opcode_is_thumb16(x) ((u32)(x) < 0xE800UL)
+
+/* Operations to construct or split 32-bit Thumb instructions: */
+#define __opcode_thumb32_first(x) ((u16)((x) >> 16))
+#define __opcode_thumb32_second(x) ((u16)(x))
+#define __opcode_thumb32_compose(first, second) \
+	(((u32)(u16)(first) << 16) | (u32)(u16)(second))
+
+#endif /* ! __ARM_OPCODES_H */
-- 
1.7.4.1

--------
 arch/arm/include/asm/opcodes.h |   56 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/opcodes.h b/arch/arm/include/asm/opcodes.h
index c0efdd6..98e9e26 100644
--- a/arch/arm/include/asm/opcodes.h
+++ b/arch/arm/include/asm/opcodes.h
@@ -9,6 +9,10 @@
 #ifndef __ASM_ARM_OPCODES_H
 #define __ASM_ARM_OPCODES_H
 
+#include <linux/types.h>
+#include <linux/swab.h>
+
+
 #ifndef __ASSEMBLY__
 extern asmlinkage unsigned int arm_check_condition(u32 opcode, u32 psr);
 #endif
@@ -17,4 +21,56 @@ extern asmlinkage unsigned int arm_check_condition(u32 opcode, u32 psr);
 #define ARM_OPCODE_CONDTEST_PASS   1
 #define ARM_OPCODE_CONDTEST_UNCOND 2
 
+
+/*
+ * Opcode byteswap helpers
+ *
+ * These macros help with converting instructions between a canonical integer
+ * format and in-memory representation, in an endianness-agnostic manner.
+ *
+ * __mem_to_opcode_*() convert from in-memory representation to canonical form.
+ * __opcode_to_mem_*() convert from canonical form to in-memory representation.
+ *
+ *
+ * Canonical instruction representation:
+ *
+ *	ARM:		0xKKLLMMNN
+ *	Thumb 16-bit:	0x0000KKLL, where KK < 0xE8
+ *	Thumb 32-bit:	0xKKLLMMNN, where KK >= 0xE8
+ *
+ * There is no way to distinguish an ARM instruction in canonical representation
+ * from a Thumb instruction (just as these cannot be distinguished in memory).
+ * Where this distinction is important, it needs to be tracked separately.
+ *
+ * Note that values in the range 0x0000E800..0xE7FFFFFF intentionally do not
+ * represent any valid Thumb-2 instruction.  For this range,
+ * __opcode_is_thumb32() and __opcode_is_thumb16() will both be false.
+ */
+
+#ifdef CONFIG_CPU_ENDIAN_BE8
+#define __opcode_to_mem_arm(x) swab32(x)
+#define __opcode_to_mem_thumb16(x) swab16(x)
+#define __opcode_to_mem_thumb32(x) swahb32(x)
+#else
+#define __opcode_to_mem_arm(x) ((u32)(x))
+#define __opcode_to_mem_thumb16(x) ((u16)(x))
+#define __opcode_to_mem_thumb32(x) swahw32(x)
+#endif
+
+#define __mem_to_opcode_arm(x) __opcode_to_mem_arm(x)
+#define __mem_to_opcode_thumb16(x) __opcode_to_mem_thumb16(x)
+#define __mem_to_opcode_thumb32(x) __opcode_to_mem_thumb32(x)
+
+/* Operations specific to Thumb opcodes */
+
+/* Instruction size checks: */
+#define __opcode_is_thumb32(x) ((u32)(x) >= 0xE8000000UL)
+#define __opcode_is_thumb16(x) ((u32)(x) < 0xE800UL)
+
+/* Operations to construct or split 32-bit Thumb instructions: */
+#define __opcode_thumb32_first(x) ((u16)((x) >> 16))
+#define __opcode_thumb32_second(x) ((u16)(x))
+#define __opcode_thumb32_compose(first, second) \
+	(((u32)(u16)(first) << 16) | (u32)(u16)(second))
+
 #endif /* __ASM_ARM_OPCODES_H */
-- 
1.7.4.1
