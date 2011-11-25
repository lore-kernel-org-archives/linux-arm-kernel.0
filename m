From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 25 Nov 2011 11:28:13 +0000
Subject: [RFC PATCH] ARM: Add generic instruction opcode manipulation helpers
Message-ID: <1322220493-3251-1-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds some endianness-agnostic helpers to convert machine
instructions between canonical integer form and in-memory
representation, and also provides a transparent way to read a
single Thumb instruction from memory, without the need to know the
size in advance or write explicit condition checks.

A canonical integer form for representing instructions is also
formalised here.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/include/asm/opcodes.h |  162 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 162 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/include/asm/opcodes.h

diff --git a/arch/arm/include/asm/opcodes.h b/arch/arm/include/asm/opcodes.h
new file mode 100644
index 0000000..5d18f92
--- /dev/null
+++ b/arch/arm/include/asm/opcodes.h
@@ -0,0 +1,162 @@
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
+typedef u32 arm_opcode_t;
+
+/*
+ * Canonical instruction representation (arm_opcode_t):
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
+#define __opcode_to_mem_arm(x) (x) ((u32)(x))
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
+#define __opcode_thumb32_first(x) ((u16)((thumb_opcode) >> 16))
+#define __opcode_thumb32_second(x) ((u16)(thumb_opcode))
+#define __opcode_thumb32_compose(first, second) \
+	(((u32)(u16)(first) << 16) | (u32)(u16)(second))
+
+/*
+ * int __opcode_read_<isa>(
+ *	arm_opcode_t *outp,
+ *	void const **inpp,
+ *	int (*readfn)(void *dst, void const *src, size_t size)
+ * )
+ *
+ * This helper reads one complete Thumb instruction and stores the canonicalised
+ * opcode to *outp.
+ *
+ * For maximum flexibility, the mechanism for reading the instruction is
+ * specified as an argument: read16fn(dst, src, size) must attempt to copy
+ * <size> bytes from <src> to <dst>.  <readfn>() should return 0 if the copy
+ * was successful, or an error code otherwise.
+ *
+ * Return:
+ *	0	success;
+ *			*outp contains the instruction read
+ *			*inp points to the next instruction
+ *	!= 0	failure:
+ *			*outp is undefined
+ *			*inp contains the first address not successfully read
+ *
+ * Writing this is a macro means that <readfn> can also be implemented as a
+ * macro.  This permits the simple case where no error checking is required to
+ * be heavily optimised.
+ */
+#define __opcode_read_thumb(outp, inpp, readfn) ({			\
+	u16 __t;							\
+									\
+	BUILD_BUG_ON(sizeof(*(outp)) != sizeof(arm_opcode_t));		\
+									\
+	___read_advance(&__t, inpp, sizeof(__t), readfn)		\
+	|| __opcode_is_thumb16(*(outp) = __mem_to_opcode_thumb16(__t)) ? 0 : \
+		___read_advance(&__t, inpp, sizeof(__t), readfn)	\
+		|| (*(outp) = __opcode_thumb32_compose(			\
+					*(outp),			\
+					__mem_to_opcode_thumb16(__t)),	\
+		    0);							\
+})
+#define ___read_advance(outp, inpp, size, readfn) ({			\
+	int __status;							\
+									\
+	__status = readfn(outp, *(inpp), size);				\
+	if (!__status)							\
+		*(inpp) = (typeof(*(inpp)))((uintptr_t)*(inpp) + (size)); \
+									\
+	__status;							\
+})
+
+#define __opcode_read_arm(outp, inpp, readfn) ({			\
+	BUILD_BUG_ON(sizeof(*(outp)) != sizeof(arm_opcode_t));		\
+									\
+	___read_advance(outp, inpp, sizeof(arm_opcode_t), readfn)	\
+	|| (*(outp) = __mem_to_opcode_arm(*(outp)),			\
+	    0);								\
+})
+
+/* __opcode_read_<isa>_simple(
+ *	arm_opcode_t *outp,
+ *	void const **inpp
+ * )
+ *
+ * Reads n Thumb-2 instruction from memory, without error checks.
+ * This macro will always succeed and return 0.  Otherwise, it is similar
+ * to __opcode_read_thumb().
+ */
+#define __opcode_read_thumb_simple(outp, inp)				\
+	__opcode_read_thumb(outp, inp, ___read16_simple)
+#define __opcode_read_arm_simple(outp, inp)				\
+	__opcode_read_arm(outp, inp, ___read32_simple)
+	
+#define ___read16_simple(outp, inp, size) 				\
+	(*(outp) = *(u16 *)(inp), 0)
+#define ___read32_simple(outp, inp, size) 				\
+	(*(outp) = *(u32 *)(inp), 0)
+
+
+#ifdef CONFIG_THUMB2_KERNEL
+#define __opcode_read(outp, inpp, readfn) \
+	__opcode_read_thumb(outp, inpp, readfn)
+#define __opcode_read_simple(outp, inpp) \
+	__opcode_read_thumb_simple(outp, inpp)
+#else
+#define __opcode_read(outp, inpp, readfn) \
+	__opcode_read_arm(outp, inpp, readfn)
+#define __opcode_read_simple(outp, inpp) \
+	__opcode_read_arm_simple(outp, inpp)
+#endif
+
+/* Maybe add some C static functions here, with proper type annotations */
+
+#endif /* ! __ARM_OPCODES_H */
-- 
1.7.4.1
