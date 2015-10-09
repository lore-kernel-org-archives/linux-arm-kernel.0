From: lars.persson@axis.com (Lars Persson)
Date: Fri,  9 Oct 2015 17:33:33 +0200
Subject: [PATCH 1/1] arm: Add generic smc wrapper
In-Reply-To: <cover.1444404015.git.larper@axis.com>
References: <cover.1444404015.git.larper@axis.com>
Message-ID: <f25638d6fd776790f6d137ab3de761fc076c7f9f.1444404015.git.larper@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds an smc wrapper according to the ARM standard for secure
monitor calling conventions (ARM DEN 0028A).

Signed-off-by: Lars Persson <larper@axis.com>
---
 arch/arm/include/asm/smc-call.h | 12 ++++++++++++
 arch/arm/kernel/Makefile        |  3 +++
 arch/arm/kernel/smc-call.S      | 22 ++++++++++++++++++++++
 3 files changed, 37 insertions(+)
 create mode 100644 arch/arm/include/asm/smc-call.h
 create mode 100644 arch/arm/kernel/smc-call.S

diff --git a/arch/arm/include/asm/smc-call.h b/arch/arm/include/asm/smc-call.h
new file mode 100644
index 0000000..88a83d4
--- /dev/null
+++ b/arch/arm/include/asm/smc-call.h
@@ -0,0 +1,12 @@
+/*
+ * Wrapper for secure monitor calls using the ARM SMC calling
+ * convention.
+ */
+#ifndef __ASM_SMC_CALL_H
+#define __ASM_SMC_CALL_H
+
+#include <linux/types.h>
+
+extern int invoke_smc(u32 function_id, u32 arg0, u32 arg1, u32 arg2);
+
+#endif
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index af9e59b..73c95e0 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -92,4 +92,7 @@ obj-y				+= psci-call.o
 obj-$(CONFIG_SMP)		+= psci_smp.o
 endif
 
+obj-$(CONFIG_CPU_V6)		+= smc-call.o
+obj-$(CONFIG_CPU_V7)		+= smc-call.o
+
 extra-y := $(head-y) vmlinux.lds
diff --git a/arch/arm/kernel/smc-call.S b/arch/arm/kernel/smc-call.S
new file mode 100644
index 0000000..a07ebf9
--- /dev/null
+++ b/arch/arm/kernel/smc-call.S
@@ -0,0 +1,22 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Copied from: psci-call.S.
+ */
+
+#include <linux/linkage.h>
+
+#include <asm/opcodes-sec.h>
+
+/* int invoke_smc(u32 function_id, u32 arg0, u32 arg1, u32 arg2) */
+ENTRY(invoke_smc)
+	__SMC(0)
+	bx	lr
+ENDPROC(invoke_smc)
-- 
2.1.4
