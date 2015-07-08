From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Wed,  8 Jul 2015 12:16:28 +0200
Subject: [PATCH v4 1/5] arm/arm64: add smccc ARCH32
In-Reply-To: <1436350592-7732-1-git-send-email-jens.wiklander@linaro.org>
References: <1436350592-7732-1-git-send-email-jens.wiklander@linaro.org>
Message-ID: <1436350592-7732-2-git-send-email-jens.wiklander@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds helpers to do SMC based on ARM SMC Calling Convention.
CONFIG_HAVE_SMCCC is enabled for architectures that may support
the SMC instruction. It's the responsibility of the caller to
know if the SMC instruction is supported by the platform.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 arch/arm/Kconfig               |  4 +++
 arch/arm/kernel/Makefile       |  2 ++
 arch/arm/kernel/smccc-call.S   | 26 ++++++++++++++
 arch/arm/kernel/smccc.c        | 17 +++++++++
 arch/arm64/Kconfig             |  4 +++
 arch/arm64/kernel/Makefile     |  1 +
 arch/arm64/kernel/smccc-call.S | 34 ++++++++++++++++++
 arch/arm64/kernel/smccc.c      | 17 +++++++++
 include/linux/arm-smccc.h      | 80 ++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 185 insertions(+)
 create mode 100644 arch/arm/kernel/smccc-call.S
 create mode 100644 arch/arm/kernel/smccc.c
 create mode 100644 arch/arm64/kernel/smccc-call.S
 create mode 100644 arch/arm64/kernel/smccc.c
 create mode 100644 include/linux/arm-smccc.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 45df48b..75e4da3 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -221,6 +221,9 @@ config NEED_RET_TO_USER
 config ARCH_MTD_XIP
 	bool
 
+config HAVE_SMCCC
+	bool
+
 config VECTORS_BASE
 	hex
 	default 0xffff0000 if MMU || CPU_HIGH_VECTOR
@@ -324,6 +327,7 @@ config ARCH_MULTIPLATFORM
 	select CLKSRC_OF
 	select COMMON_CLK
 	select GENERIC_CLOCKEVENTS
+	select HAVE_SMCCC if CPU_V7
 	select MIGHT_HAVE_PCI
 	select MULTI_IRQ_HANDLER
 	select SPARSE_IRQ
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 752725d..8cdd25b 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -90,4 +90,6 @@ obj-y				+= psci.o psci-call.o
 obj-$(CONFIG_SMP)		+= psci_smp.o
 endif
 
+obj-$(CONFIG_HAVE_SMCCC)	+= smccc-call.o smccc.o
+
 extra-y := $(head-y) vmlinux.lds
diff --git a/arch/arm/kernel/smccc-call.S b/arch/arm/kernel/smccc-call.S
new file mode 100644
index 0000000..05bc554
--- /dev/null
+++ b/arch/arm/kernel/smccc-call.S
@@ -0,0 +1,26 @@
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
+
+/* void smccc_call32(struct smccc_param32 *param) */
+ENTRY(smccc_call32)
+	push	{r4-r8, lr}
+	mov	r8, r0
+	ldm	r8, {r0-r7}
+	__SMC(0)
+	stm	r8, {r0-r7}
+	pop	{r4-r8, pc}
+ENDPROC(smccc_call32)
diff --git a/arch/arm/kernel/smccc.c b/arch/arm/kernel/smccc.c
new file mode 100644
index 0000000..ba4039e
--- /dev/null
+++ b/arch/arm/kernel/smccc.c
@@ -0,0 +1,17 @@
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
+EXPORT_SYMBOL_GPL(smccc_call32);
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7796af4..b3ea778 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -83,6 +83,7 @@ config ARM64
 	select SPARSE_IRQ
 	select SYSCTL_EXCEPTION_TRACE
 	select HAVE_CONTEXT_TRACKING
+	select HAVE_SMCCC
 	help
 	  ARM 64-bit (AArch64) Linux support.
 
@@ -146,6 +147,9 @@ config KERNEL_MODE_NEON
 config FIX_EARLYCON_MEM
 	def_bool y
 
+config HAVE_SMCCC
+	bool
+
 config PGTABLE_LEVELS
 	int
 	default 2 if ARM64_64K_PAGES && ARM64_VA_BITS_42
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 426d076..f7804f7 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -36,6 +36,7 @@ arm64-obj-$(CONFIG_EFI)			+= efi.o efi-stub.o efi-entry.o
 arm64-obj-$(CONFIG_PCI)			+= pci.o
 arm64-obj-$(CONFIG_ARMV8_DEPRECATED)	+= armv8_deprecated.o
 arm64-obj-$(CONFIG_ACPI)		+= acpi.o
+arm64-obj-$(CONFIG_HAVE_SMCCC)		+= smccc-call.o smccc.o
 
 obj-y					+= $(arm64-obj-y) vdso/
 obj-m					+= $(arm64-obj-m)
diff --git a/arch/arm64/kernel/smccc-call.S b/arch/arm64/kernel/smccc-call.S
new file mode 100644
index 0000000..3ce7fe8
--- /dev/null
+++ b/arch/arm64/kernel/smccc-call.S
@@ -0,0 +1,34 @@
+/*
+ * Copyright (c) 2015, Linaro Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License Version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ */
+#include <linux/linkage.h>
+
+#define SMC_PARAM_W0_OFFS	0
+#define SMC_PARAM_W2_OFFS	8
+#define SMC_PARAM_W4_OFFS	16
+#define SMC_PARAM_W6_OFFS	24
+
+/* void smccc_call32(struct smccc_param32 *param) */
+ENTRY(smccc_call32)
+	stp	x28, x30, [sp, #-16]!
+	mov	x28, x0
+	ldp	w0, w1, [x28, #SMC_PARAM_W0_OFFS]
+	ldp	w2, w3, [x28, #SMC_PARAM_W2_OFFS]
+	ldp	w4, w5, [x28, #SMC_PARAM_W4_OFFS]
+	ldp	w6, w7, [x28, #SMC_PARAM_W6_OFFS]
+	smc	#0
+	stp	w0, w1, [x28, #SMC_PARAM_W0_OFFS]
+	stp	w2, w3, [x28, #SMC_PARAM_W2_OFFS]
+	ldp	x28, x30, [sp], #16
+	ret
+ENDPROC(smccc_call32)
diff --git a/arch/arm64/kernel/smccc.c b/arch/arm64/kernel/smccc.c
new file mode 100644
index 0000000..ba4039e
--- /dev/null
+++ b/arch/arm64/kernel/smccc.c
@@ -0,0 +1,17 @@
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
+EXPORT_SYMBOL_GPL(smccc_call32);
diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
new file mode 100644
index 0000000..98b3c3c
--- /dev/null
+++ b/include/linux/arm-smccc.h
@@ -0,0 +1,80 @@
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
+#ifndef __LINUX_ARM_SMCCC_H
+#define __LINUX_ARM_SMCCC_H
+
+#include <linux/types.h>
+
+/*
+ * This file provideds defines common defines for ARM SMC Calling
+ * Convention as specified in
+ * http://infocenter.arm.com/help/topic/com.arm.doc.den0028a/index.html
+ */
+
+#define SMCCC_SMC_32			(0 << 30)
+#define SMCCC_SMC_64			(1 << 30)
+#define SMCCC_FAST_CALL			(1 << 31)
+#define SMCCC_STD_CALL			(0 << 31)
+
+#define SMCCC_OWNER_MASK		0x3F
+#define SMCCC_OWNER_SHIFT		24
+
+#define SMCCC_FUNC_MASK			0xFFFF
+
+#define SMCCC_IS_FAST_CALL(smc_val)	((smc_val) & SMCCC_FAST_CALL)
+#define SMCCC_IS_64(smc_val)		((smc_val) & SMCCC_SMC_64)
+#define SMCCC_FUNC_NUM(smc_val)		((smc_val) & SMCCC_FUNC_MASK)
+#define SMCCC_OWNER_NUM(smc_val) \
+	(((smc_val) >> SMCCC_OWNER_SHIFT) & SMCCC_OWNER_MASK)
+
+#define SMCCC_CALL_VAL(type, calling_convention, owner, func_num) \
+			((type) | (calling_convention) | \
+			(((owner) & SMCCC_OWNER_MASK) << SMCCC_OWNER_SHIFT) | \
+			((func_num) & SMCCC_FUNC_MASK))
+
+#define SMCCC_OWNER_ARCH		0
+#define SMCCC_OWNER_CPU			1
+#define SMCCC_OWNER_SIP			2
+#define SMCCC_OWNER_OEM			3
+#define SMCCC_OWNER_STANDARD		4
+#define SMCCC_OWNER_TRUSTED_APP		48
+#define SMCCC_OWNER_TRUSTED_APP_END	49
+#define SMCCC_OWNER_TRUSTED_OS		50
+#define SMCCC_OWNER_TRUSTED_OS_END	63
+
+struct smccc_param32 {
+	u32 a0;
+	u32 a1;
+	u32 a2;
+	u32 a3;
+	u32 a4;
+	u32 a5;
+	u32 a6;
+	u32 a7;
+};
+
+/**
+ * smccc_call32() - make ARCH32 SMC calls
+ * @param: values to pass in registers 0 to 7
+ *
+ * This function is used to make SMC calls following SMC Calling Convention
+ * for ARCH32 calls. The content of the supplied param are copied to
+ * registers 0 to 7 prior to the SMC instruction. Values a0..a3 are updated
+ * with the content from register 0 to 3 on return from the SMC
+ * instruction.
+ */
+void smccc_call32(struct smccc_param32 *param);
+
+#endif /*__LINUX_ARM_SMCCC_H*/
+
-- 
1.9.1
