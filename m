From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 28 Feb 2012 18:59:46 +0000
Subject: [RFC PATCH 2/2] ARM: virt: Add assembler helpers for the
 Virtualization Extensions
In-Reply-To: <1330455586-10353-1-git-send-email-dave.martin@linaro.org>
References: <1330455586-10353-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1330455586-10353-3-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the benefit of hypervisor implementations such as kvm, Xen
etc., this patch adds support for generating code to use the CPU
virtualization extensions.  This allows hypervisor calls to be
inlined without changing the CFLAGS for the whole kernel, as well
as supporting older binutils.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/include/asm/arch-virt.h     |    1 +
 arch/arm/include/asm/arch-virt.h.asm |  104 ++++++++++++++++++
 arch/arm/include/asm/opcodes.h       |   80 +--------------
 arch/arm/include/asm/opcodes.h.asm   |  191 ++++++++++++++++++++++++++++++++++
 4 files changed, 297 insertions(+), 79 deletions(-)
 create mode 100644 arch/arm/include/asm/arch-virt.h
 create mode 100644 arch/arm/include/asm/arch-virt.h.asm
 create mode 100644 arch/arm/include/asm/opcodes.h.asm

diff --git a/arch/arm/include/asm/arch-virt.h b/arch/arm/include/asm/arch-virt.h
new file mode 100644
index 0000000..de077f8
--- /dev/null
+++ b/arch/arm/include/asm/arch-virt.h
@@ -0,0 +1 @@
+#include <generated/asm-arch-virt.h>
diff --git a/arch/arm/include/asm/arch-virt.h.asm b/arch/arm/include/asm/arch-virt.h.asm
new file mode 100644
index 0000000..18f6e0e
--- /dev/null
+++ b/arch/arm/include/asm/arch-virt.h.asm
@@ -0,0 +1,104 @@
+/*
+ * Assembler definitions for the ARM Virtualization Extensions
+ * Copyright (C) 2012 Linaro Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ *
+ * Older assembler versions lack support for some new instruction forms
+ * which are required by the Virtualization Extensions.  These
+ * definitions provide macros allowing the affected instructions to be
+ * generated in such cases.
+ */
+
+#ifndef __ASM_ARCH_VIRT_H
+#define __ASM_ARCH_VIRT_H
+
+#include <asm/opcodes.h>
+
+/*
+ * Special register names defined by the Virtualization Extensions for
+ * MSR/MRS.
+ *
+ * We could define a lot more, but for the hyp mode registers there is
+ * no conveinent architectural workaround for using MSR/MRS to access
+ * them.
+ */
+ASM(
+.equ .L__asm_msr_elr_hyp,	0x01e
+.equ .L__asm_msr_sp_hyp,	0x01f
+)
+
+/*
+ * System instruction definitions for the Virtualization Extensions
+ */
+#ifdef CONFIG_THUMB2_KERNEL
+ASM(
+.macro _hvc imm16=0
+	_instw	0xf7e08000 | (((\imm16 ) & 0xf000) << 4) | ((\imm16 ) & 0xfff)
+.endm
+.macro _eret
+	_instw	0xf3de8f00
+.endm
+.macro _msr reg:req, Rn:req
+	_check_reg _msr, \Rn
+	_check_msr _msr, \reg
+	_instw	0xf3808020 | \
+		((.L__asm_msr_\reg & 0x00f) <<  8)	| \
+		((.L__asm_msr_\reg & 0x030) <<  0)	| \
+		((.L__asm_msr_\reg & 0x100) << 12)	| \
+		.L__asm_reg_\Rn << 16
+.endm
+.macro _mrs Rd:req, reg:req
+	_check_reg _mrs, \Rd
+	_check_msr _mrs, \reg
+	_instw	0xf3e08020 | \
+		((.L__asm_msr_\reg & 0x00f) << 16)	| \
+		((.L__asm_msr_\reg & 0x030) <<  0)	| \
+		((.L__asm_msr_\reg & 0x100) << 12)	| \
+		.L__asm_reg_\Rd << 8
+.endm
+)
+#else /* ! CONFIG_THUMB2_KERNEL */
+ASM(
+.macro _hvc imm16=0
+	_inst	0xe1400070 | (((\imm16 ) & 0xfff0) << 4) | ((\imm16 ) & 0xf)
+.endm
+.macro _eret
+	_inst	0xe160006e
+.endm
+.macro _msr reg:req, Rn:req
+	_check_reg _msr, \Rn
+	_check_msr _msr, \reg
+	_inst	0xe120f200 | \
+		((.L__asm_msr_\reg & 0x00f) << 16)	| \
+		((.L__asm_msr_\reg & 0x030) <<  4)	| \
+		((.L__asm_msr_\reg & 0x100) << 14)	| \
+		.L__asm_reg_\Rn
+.endm
+.macro _mrs Rd:req, reg:req
+	_check_reg _mrs, \Rd
+	_check_msr _mrs, \reg
+	_inst	0xe1000200 | \
+		((.L__asm_msr_\reg & 0x00f) << 16)	| \
+		((.L__asm_msr_\reg & 0x030) <<  4)	| \
+		((.L__asm_msr_\reg & 0x100) << 14)	| \
+		.L__asm_reg_\Rd << 12
+.endm
+)
+#endif /* ! CONFIG_THUMB2_KERNEL */
+
+#endif /* ! __ASM_ARCH_VIRT_H */
+
diff --git a/arch/arm/include/asm/opcodes.h b/arch/arm/include/asm/opcodes.h
index 19c48de..4be04fc 100644
--- a/arch/arm/include/asm/opcodes.h
+++ b/arch/arm/include/asm/opcodes.h
@@ -1,79 +1 @@
-/*
- *  arch/arm/include/asm/opcodes.h
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __ASM_ARM_OPCODES_H
-#define __ASM_ARM_OPCODES_H
-
-#ifndef __ASSEMBLY__
-extern asmlinkage unsigned int arm_check_condition(u32 opcode, u32 psr);
-#endif
-
-#define ARM_OPCODE_CONDTEST_FAIL   0
-#define ARM_OPCODE_CONDTEST_PASS   1
-#define ARM_OPCODE_CONDTEST_UNCOND 2
-
-
-/*
- * Opcode byteswap helpers
- *
- * These macros help with converting instructions between a canonical integer
- * format and in-memory representation, in an endianness-agnostic manner.
- *
- * __mem_to_opcode_*() convert from in-memory representation to canonical form.
- * __opcode_to_mem_*() convert from canonical form to in-memory representation.
- *
- *
- * Canonical instruction representation:
- *
- *	ARM:		0xKKLLMMNN
- *	Thumb 16-bit:	0x0000KKLL, where KK < 0xE8
- *	Thumb 32-bit:	0xKKLLMMNN, where KK >= 0xE8
- *
- * There is no way to distinguish an ARM instruction in canonical representation
- * from a Thumb instruction (just as these cannot be distinguished in memory).
- * Where this distinction is important, it needs to be tracked separately.
- *
- * Note that values in the range 0x0000E800..0xE7FFFFFF intentionally do not
- * represent any valid Thumb-2 instruction.  For this range,
- * __opcode_is_thumb32() and __opcode_is_thumb16() will both be false.
- */
-
-#ifndef __ASSEMBLY__
-
-#include <linux/types.h>
-#include <linux/swab.h>
-
-#ifdef CONFIG_CPU_ENDIAN_BE8
-#define __opcode_to_mem_arm(x) swab32(x)
-#define __opcode_to_mem_thumb16(x) swab16(x)
-#define __opcode_to_mem_thumb32(x) swahb32(x)
-#else
-#define __opcode_to_mem_arm(x) ((u32)(x))
-#define __opcode_to_mem_thumb16(x) ((u16)(x))
-#define __opcode_to_mem_thumb32(x) swahw32(x)
-#endif
-
-#define __mem_to_opcode_arm(x) __opcode_to_mem_arm(x)
-#define __mem_to_opcode_thumb16(x) __opcode_to_mem_thumb16(x)
-#define __mem_to_opcode_thumb32(x) __opcode_to_mem_thumb32(x)
-
-/* Operations specific to Thumb opcodes */
-
-/* Instruction size checks: */
-#define __opcode_is_thumb32(x) ((u32)(x) >= 0xE8000000UL)
-#define __opcode_is_thumb16(x) ((u32)(x) < 0xE800UL)
-
-/* Operations to construct or split 32-bit Thumb instructions: */
-#define __opcode_thumb32_first(x) ((u16)((x) >> 16))
-#define __opcode_thumb32_second(x) ((u16)(x))
-#define __opcode_thumb32_compose(first, second) \
-	(((u32)(u16)(first) << 16) | (u32)(u16)(second))
-
-#endif /* __ASSEMBLY__ */
-
-#endif /* __ASM_ARM_OPCODES_H */
+#include <generated/asm-opcodes.h>
diff --git a/arch/arm/include/asm/opcodes.h.asm b/arch/arm/include/asm/opcodes.h.asm
new file mode 100644
index 0000000..acc4c0e
--- /dev/null
+++ b/arch/arm/include/asm/opcodes.h.asm
@@ -0,0 +1,191 @@
+/*
+ *  arch/arm/include/asm/opcodes.h
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ASM_ARM_OPCODES_H
+#define __ASM_ARM_OPCODES_H
+
+#ifndef __ASSEMBLY__
+extern asmlinkage unsigned int arm_check_condition(u32 opcode, u32 psr);
+#endif
+
+#define ARM_OPCODE_CONDTEST_FAIL   0
+#define ARM_OPCODE_CONDTEST_PASS   1
+#define ARM_OPCODE_CONDTEST_UNCOND 2
+
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
+#ifndef __ASSEMBLY__
+
+#include <linux/types.h>
+#include <linux/swab.h>
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
+#endif /* __ASSEMBLY__ */
+
+/*
+ * Assembler declarations and helpers for defining macros to emit
+ * instruction opcodes:
+ */
+ASM(
+.equ .L__asm_reg_r0,	0
+.equ .L__asm_reg_r1,	1
+.equ .L__asm_reg_r2,	2
+.equ .L__asm_reg_r3,	3
+.equ .L__asm_reg_r4,	4
+.equ .L__asm_reg_r5,	5
+.equ .L__asm_reg_r6,	6
+.equ .L__asm_reg_r7,	7
+.equ .L__asm_reg_r8,	8
+.equ .L__asm_reg_r9,	9
+.equ .L__asm_reg_r10,	10
+.equ .L__asm_reg_r11,	11
+.equ .L__asm_reg_r12,	12
+.equ .L__asm_reg_ip,	12
+.equ .L__asm_reg_r13,	13
+.equ .L__asm_reg_sp,	13
+.equ .L__asm_reg_r14,	14
+.equ .L__asm_reg_lr,	14
+.equ .L__asm_reg_r15,	15
+.equ .L__asm_reg_pc,	15
+
+@ _check_reg: Fail assembly with a human-readable error if reg is not a known
+@ general-purpose register name:
+
+.macro _check_reg where:req, reg:req
+	.ifndef .L__asm_reg_\reg
+		.error "\where\(): \"\reg\": general-purpose register expected"
+	.endif
+.endm
+
+@ _check_msr: Fail assembler with a human-readable error if reg is not a
+@ known special register name accessible via MSR/MRS
+
+@ No actual register names are defined here, since without the ARM
+@ Virtualization Extensions, the only special registers and CPSR and
+@ SPSR.  For those, you should use the real MRS/MSR instruction
+@ mnemonics, not some helper macro.
+
+.macro _check_msr where:req, reg:req
+	.ifndef .L__asm_msr_\reg
+		.error "\where\(): \"\reg\": special register expected"
+	.endif
+.endm
+)
+
+/*
+ * _inst*: emit a single instruction opcode:
+ *
+ * _inst <opcode>	emit a (32-bit) ARM opcode
+ * _instn <opcode>	emit a 16-bit Thumb opcode
+ * _instw <opcode>	emit a 32-bit Thumb opcode (in canonical form)
+ *
+ * _instw and _inst are deliberately not interchangeable.  If you
+ * are emitting opcodes, you WILL need to write special-case code
+ * for ARM and Thumb kernels.
+ *
+ * Newer versions of the assembler also have .inst, .inst.n, .inst.w
+ * which achieve the same thing, but for now we shouldn't assume that
+ * everyone has those tools.
+ */
+#ifdef CONFIG_THUMB2_KERNEL
+
+#ifdef CONFIG_CPU_ENDIAN_BE8
+ASM(
+.macro _instn opcode:req
+	.short \
+		(((\opcode ) << 8) & 0xff00) | \
+		(((\opcode ) >> 8) & 0x00ff)
+.endm
+)
+#else
+ASM(
+.macro _instn opcode:req
+	.short	\opcode
+.endm
+)
+#endif
+
+ASM(
+.macro _instw opcode:req
+	_instn	((\opcode ) >> 16) & 0xffff
+	_instn	(\opcode ) & 0xffff
+.endm
+)
+
+#else /* ! CONFIG_THUMB2_KERNEL */
+
+#ifdef CONFIG_CPU_ENDIAN_BE8
+ASM(
+.macro _inst opcode:req
+	.long \
+		(((\opcode ) << 24) & 0xff000000) | \
+		(((\opcode ) <<  8) & 0x00ff0000) | \
+		(((\opcode ) >>  8) & 0x0000ff00) | \
+		(((\opcode ) >> 24) & 0x000000ff)
+.endm
+)
+#else
+ASM(
+.macro _inst opcode:req
+	.long	\opcode
+.endm
+)
+#endif
+
+#endif /* ! CONFIG_THUMB2_KERNEL */
+
+#endif /* __ASM_ARM_OPCODES_H */
-- 
1.7.4.1
