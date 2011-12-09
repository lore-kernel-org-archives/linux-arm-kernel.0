From: leif.lindholm@arm.com (Leif Lindholm)
Date: Fri, 09 Dec 2011 18:54:29 +0000
Subject: [PATCH 1/4] Add generic ARM instruction set condition code checks.
In-Reply-To: <20111209185302.19655.36481.stgit@localhost6.localdomain6>
References: <20111209185302.19655.36481.stgit@localhost6.localdomain6>
Message-ID: <20111209185422.19655.40836.stgit@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch breaks the ARM condition checking code out of nwfpe/fpopcode.{ch}
into a standalone file for opcode operations. It also modifies the code
somewhat for coding style adherence, and adds some temporary variables for
increased readability.

Signed-off-by: Leif Lindholm <leif.lindholm@arm.com>
---
 arch/arm/include/asm/opcodes.h |   20 +++++++++++
 arch/arm/kernel/Makefile       |    2 +
 arch/arm/kernel/opcodes.c      |   72 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/include/asm/opcodes.h
 create mode 100644 arch/arm/kernel/opcodes.c

diff --git a/arch/arm/include/asm/opcodes.h b/arch/arm/include/asm/opcodes.h
new file mode 100644
index 0000000..aea97bf
--- /dev/null
+++ b/arch/arm/include/asm/opcodes.h
@@ -0,0 +1,20 @@
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
+extern unsigned int arm_check_condition(unsigned int opcode, unsigned int psr);
+#endif
+
+#define ARM_OPCODE_CONDTEST_FAIL   0
+#define ARM_OPCODE_CONDTEST_PASS   1
+#define ARM_OPCODE_CONDTEST_UNCOND 2
+
+#endif /* __ASM_ARM_OPCODES_H */
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 16eed6a..43b740d 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -13,7 +13,7 @@ CFLAGS_REMOVE_return_address.o = -pg
 
 # Object file lists.
 
-obj-y		:= elf.o entry-armv.o entry-common.o irq.o \
+obj-y		:= elf.o entry-armv.o entry-common.o irq.o opcodes.o \
 		   process.o ptrace.o return_address.o setup.o signal.o \
 		   sys_arm.o stacktrace.o time.o traps.o
 
diff --git a/arch/arm/kernel/opcodes.c b/arch/arm/kernel/opcodes.c
new file mode 100644
index 0000000..f8179c6
--- /dev/null
+++ b/arch/arm/kernel/opcodes.c
@@ -0,0 +1,72 @@
+/*
+ *  linux/arch/arm/kernel/opcodes.c
+ *
+ *  A32 condition code lookup feature moved from nwfpe/fpopcode.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <asm/opcodes.h>
+
+#define ARM_OPCODE_CONDITION_UNCOND 0xf
+
+/*
+ * condition code lookup table
+ * index into the table is test code: EQ, NE, ... LT, GT, AL, NV
+ *
+ * bit position in short is condition code: NZCV
+ */
+static const unsigned short cc_map[16] = {
+	0xF0F0,			/* EQ == Z set            */
+	0x0F0F,			/* NE                     */
+	0xCCCC,			/* CS == C set            */
+	0x3333,			/* CC                     */
+	0xFF00,			/* MI == N set            */
+	0x00FF,			/* PL                     */
+	0xAAAA,			/* VS == V set            */
+	0x5555,			/* VC                     */
+	0x0C0C,			/* HI == C set && Z clear */
+	0xF3F3,			/* LS == C clear || Z set */
+	0xAA55,			/* GE == (N==V)           */
+	0x55AA,			/* LT == (N!=V)           */
+	0x0A05,			/* GT == (!Z && (N==V))   */
+	0xF5FA,			/* LE == (Z || (N!=V))    */
+	0xFFFF,			/* AL always              */
+	0			/* NV                     */
+};
+
+/*
+ * Returns:
+ * ARM_OPCODE_CONDTEST_FAIL   - if condition fails
+ * ARM_OPCODE_CONDTEST_PASS   - if condition passes (including AL)
+ * ARM_OPCODE_CONDTEST_UNCOND - if NV condition, or separate unconditional
+ *                              opcode space from v5 onwards
+ *
+ * Code that tests whether a conditional instruction would pass its condition
+ * check should check that return value == ARM_OPCODE_CONDTEST_PASS.
+ *
+ * Code that tests if a condition means that the instruction would be executed
+ * (regardless of conditional or unconditional) should instead check that the
+ * return value != ARM_OPCODE_CONDTEST_FAIL.
+ */
+asmlinkage unsigned int arm_check_condition(u32 opcode, u32 psr)
+{
+	u32 cc_bits  = opcode >> 28;
+	u32 psr_cond = psr >> 28;
+	unsigned int ret;
+
+	if (cc_bits != ARM_OPCODE_CONDITION_UNCOND) {
+		if ((cc_map[cc_bits] >> (psr_cond)) & 1)
+			ret = ARM_OPCODE_CONDTEST_PASS;
+		else
+			ret = ARM_OPCODE_CONDTEST_FAIL;
+	} else {
+		ret = ARM_OPCODE_CONDTEST_UNCOND;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(arm_check_condition);
