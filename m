From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 27 Mar 2012 14:54:05 +0100
Subject: [PATCH v2 4/4] ARM: opcodes: Opcode definitions for the
 Virtualization Extensions
In-Reply-To: <1332856445-7007-1-git-send-email-dave.martin@linaro.org>
References: <1332856445-7007-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1332856445-7007-5-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For now, this patch just adds a definition for the HVC instruction.
More can be added here later, as needed.

Now that we have a real example of how to use the opcode injection
macros properly, this patch also adds a cross-reference from the
explanation in opcodes.h (since without an example, figuring out
how to use the macros is not that easy).

Signed-off-by: Dave Martin <dave.martin@linaro.org>
Acked-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/include/asm/opcodes-virt.h |   29 +++++++++++++++++++++++++++++
 arch/arm/include/asm/opcodes.h      |    2 ++
 2 files changed, 31 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/include/asm/opcodes-virt.h

diff --git a/arch/arm/include/asm/opcodes-virt.h b/arch/arm/include/asm/opcodes-virt.h
new file mode 100644
index 0000000..b85665a
--- /dev/null
+++ b/arch/arm/include/asm/opcodes-virt.h
@@ -0,0 +1,29 @@
+/*
+ * opcodes-virt.h: Opcode definitions for the ARM virtualization extensions
+ * Copyright (C) 2012  Linaro Limited
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
+ */
+#ifndef __ASM_ARM_OPCODES_VIRT_H
+#define __ASM_ARM_OPCODES_VIRT_H
+
+#include <asm/opcodes.h>
+
+#define __HVC(imm16) __inst_arm_thumb32(				\
+	0xE1400070 | (((imm16) & 0xFFF0) << 4) | ((imm16) & 0x000F),	\
+	0xF7E08000 | (((imm16) & 0xF000) << 4) | ((imm16) & 0x0FFF)	\
+)
+
+#endif /* ! __ASM_ARM_OPCODES_VIRT_H */
diff --git a/arch/arm/include/asm/opcodes.h b/arch/arm/include/asm/opcodes.h
index f7937e1..74e211a 100644
--- a/arch/arm/include/asm/opcodes.h
+++ b/arch/arm/include/asm/opcodes.h
@@ -193,6 +193,8 @@ extern asmlinkage unsigned int arm_check_condition(u32 opcode, u32 psr);
  * specify the ARM and Thumb alternatives at the same time.  This ensures
  * that the correct opcode gets emitted depending on the instruction set
  * used for the kernel build.
+ *
+ * Look@opcodes-virt.h for an example of how to use these macros.
  */
 #include <linux/stringify.h>
 
-- 
1.7.4.1
