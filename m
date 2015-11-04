From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Wed,  4 Nov 2015 10:46:10 +0100
Subject: [PATCH 2/4] arm: add implementation for arm-smccc
In-Reply-To: <1446630372-1598-1-git-send-email-jens.wiklander@linaro.org>
References: <1446630372-1598-1-git-send-email-jens.wiklander@linaro.org>
Message-ID: <1446630372-1598-3-git-send-email-jens.wiklander@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds implementation for arm-smccc and enables CONFIG_HAVE_SMCCC for
architectures that may support arm-smccc. It's the responsibility of the
caller to know if the SMC instruction is supported by the platform.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 arch/arm/Kconfig             |  1 +
 arch/arm/kernel/Makefile     |  2 ++
 arch/arm/kernel/smccc-call.S | 46 ++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/smccc.c      | 18 +++++++++++++++++
 4 files changed, 67 insertions(+)
 create mode 100644 arch/arm/kernel/smccc-call.S
 create mode 100644 arch/arm/kernel/smccc.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 639411f..d394727 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -325,6 +325,7 @@ config ARCH_MULTIPLATFORM
 	select CLKSRC_OF
 	select COMMON_CLK
 	select GENERIC_CLOCKEVENTS
+	select HAVE_ARM_SMCCC if CPU_V7
 	select MIGHT_HAVE_PCI
 	select MULTI_IRQ_HANDLER
 	select SPARSE_IRQ
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index af9e59b..c89e6ab 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -92,4 +92,6 @@ obj-y				+= psci-call.o
 obj-$(CONFIG_SMP)		+= psci_smp.o
 endif
 
+obj-$(CONFIG_HAVE_ARM_SMCCC)	+= smccc-call.o smccc.o
+
 extra-y := $(head-y) vmlinux.lds
diff --git a/arch/arm/kernel/smccc-call.S b/arch/arm/kernel/smccc-call.S
new file mode 100644
index 0000000..bbed9f1
--- /dev/null
+++ b/arch/arm/kernel/smccc-call.S
@@ -0,0 +1,46 @@
+/*
+ * Copyright (c) 2015, Linaro Limited
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+#include <linux/linkage.h>
+
+#include <asm/opcodes-sec.h>
+#include <asm/opcodes-virt.h>
+
+	.macro SMCCC instr
+	mov	r12, sp
+	push	{r4-r7}
+	ldm	r12, {r4-r7}
+	\instr
+	pop	{r4-r7}
+	ldr	r12, [sp, #(4 * 4)]
+	stm	r12, {r0-r3}
+	bx	lr
+	.endm
+
+/*
+ * void smccc_smc(unsigned long a0, unsigned long a1, unsigned long a2,
+ *		  unsigned long a3, unsigned long a4, unsigned long a5,
+ *		  unsigned long a6, unsigned long a7, struct arm_smccc_res *res)
+ */
+ENTRY(arm_smccc_smc)
+	SMCCC __SMC(0)
+ENDPROC(arm_smccc_smc)
+
+/*
+ * void smccc_hvc(unsigned long a0, unsigned long a1, unsigned long a2,
+ *		  unsigned long a3, unsigned long a4, unsigned long a5,
+ *		  unsigned long a6, unsigned long a7, struct arm_smccc_res *res)
+ */
+ENTRY(arm_smccc_hvc)
+	SMCCC __HVC(0)
+ENDPROC(arm_smccc_hvc)
diff --git a/arch/arm/kernel/smccc.c b/arch/arm/kernel/smccc.c
new file mode 100644
index 0000000..7941210
--- /dev/null
+++ b/arch/arm/kernel/smccc.c
@@ -0,0 +1,18 @@
+/*
+ * Copyright (c) 2015, Linaro Limited
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+#include <linux/export.h>
+#include <linux/arm-smccc.h>
+
+EXPORT_SYMBOL_GPL(arm_smccc_smc);
+EXPORT_SYMBOL_GPL(arm_smccc_hvc);
-- 
1.9.1
