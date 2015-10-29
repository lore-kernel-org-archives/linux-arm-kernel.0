From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Thu, 29 Oct 2015 09:21:23 +0100
Subject: [PATCH v6 1/6] arm/arm64: add smccc
In-Reply-To: <1446106888-8983-1-git-send-email-jens.wiklander@linaro.org>
References: <1446106888-8983-1-git-send-email-jens.wiklander@linaro.org>
Message-ID: <1446106888-8983-2-git-send-email-jens.wiklander@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds helpers to do SMC and HVC based on ARM SMC Calling Convention.
CONFIG_HAVE_SMCCC is enabled for architectures that may support
the SMC or HVC instruction. It's the responsibility of the caller
to know if the SMC instruction is supported by the platform.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 arch/arm/Kconfig               |  4 ++
 arch/arm/kernel/Makefile       |  2 +
 arch/arm/kernel/smccc-call.S   | 49 +++++++++++++++++++++
 arch/arm/kernel/smccc.c        | 18 ++++++++
 arch/arm64/Kconfig             |  4 ++
 arch/arm64/kernel/Makefile     |  1 +
 arch/arm64/kernel/smccc-call.S | 43 ++++++++++++++++++
 arch/arm64/kernel/smccc.c      | 18 ++++++++
 include/linux/arm-smccc.h      | 98 ++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 237 insertions(+)
 create mode 100644 arch/arm/kernel/smccc-call.S
 create mode 100644 arch/arm/kernel/smccc.c
 create mode 100644 arch/arm64/kernel/smccc-call.S
 create mode 100644 arch/arm64/kernel/smccc.c
 create mode 100644 include/linux/arm-smccc.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 72ad724..29ab16a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -226,6 +226,9 @@ config NEED_RET_TO_USER
 config ARCH_MTD_XIP
 	bool
 
+config HAVE_SMCCC
+	bool
+
 config VECTORS_BASE
 	hex
 	default 0xffff0000 if MMU || CPU_HIGH_VECTOR
@@ -325,6 +328,7 @@ config ARCH_MULTIPLATFORM
 	select CLKSRC_OF
 	select COMMON_CLK
 	select GENERIC_CLOCKEVENTS
+	select HAVE_SMCCC if CPU_V7
 	select MIGHT_HAVE_PCI
 	select MULTI_IRQ_HANDLER
 	select SPARSE_IRQ
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index af9e59b..a98867d 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -92,4 +92,6 @@ obj-y				+= psci-call.o
 obj-$(CONFIG_SMP)		+= psci_smp.o
 endif
 
+obj-$(CONFIG_HAVE_SMCCC)	+= smccc-call.o smccc.o
+
 extra-y := $(head-y) vmlinux.lds
diff --git a/arch/arm/kernel/smccc-call.S b/arch/arm/kernel/smccc-call.S
new file mode 100644
index 0000000..3161c21
--- /dev/null
+++ b/arch/arm/kernel/smccc-call.S
@@ -0,0 +1,49 @@
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
+/*
+ * void smccc_smc(unsigned long a0, unsigned long a1, unsigned long a2,
+ *		  unsigned long a3, unsigned long a4, unsigned long a5,
+ *		  unsigned long a6, unsigned long a7, struct smccc_res *res)
+ */
+ENTRY(smccc_smc)
+	mov	r12, sp
+	push	{r4-r7}
+	ldm	r12, {r4-r7}
+	__SMC(0)
+	pop	{r4-r7}
+	ldr	r12, [sp, #(4 * 4)]
+	stm	r12, {r0-r3}
+	bx	lr
+ENDPROC(smccc_smc)
+
+/*
+ * void smccc_hvc(unsigned long a0, unsigned long a1, unsigned long a2,
+ *		  unsigned long a3, unsigned long a4, unsigned long a5,
+ *		  unsigned long a6, unsigned long a7, struct smccc_res *res)
+ */
+ENTRY(smccc_hvc)
+	mov	r12, sp
+	push	{r4-r7}
+	ldm	r12, {r4-r7}
+	__HVC(0)
+	pop	{r4-r7}
+	ldr	r12, [sp, #(4 * 4)]
+	stm	r12, {r0-r3}
+	bx	lr
+ENDPROC(smccc_hvc)
diff --git a/arch/arm/kernel/smccc.c b/arch/arm/kernel/smccc.c
new file mode 100644
index 0000000..ed13ba3
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
+EXPORT_SYMBOL_GPL(smccc_smc);
+EXPORT_SYMBOL_GPL(smccc_hvc);
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 07d1811..a3281ff 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -89,6 +89,7 @@ config ARM64
 	select SPARSE_IRQ
 	select SYSCTL_EXCEPTION_TRACE
 	select HAVE_CONTEXT_TRACKING
+	select HAVE_SMCCC
 	help
 	  ARM 64-bit (AArch64) Linux support.
 
@@ -167,6 +168,9 @@ config KERNEL_MODE_NEON
 config FIX_EARLYCON_MEM
 	def_bool y
 
+config HAVE_SMCCC
+	bool
+
 config PGTABLE_LEVELS
 	int
 	default 2 if ARM64_64K_PAGES && ARM64_VA_BITS_42
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 22dc9bc..250948e 100644
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
index 0000000..9098bd8
--- /dev/null
+++ b/arch/arm64/kernel/smccc-call.S
@@ -0,0 +1,43 @@
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
+#define SMC_RES_X0_OFFS	0
+#define SMC_RES_X2_OFFS	16
+
+/*
+ * void smccc_smc(unsigned long a0, unsigned long a1, unsigned long a2,
+ *		  unsigned long a3, unsigned long a4, unsigned long a5,
+ *		  unsigned long a6, unsigned long a7, struct smccc_res *res)
+ */
+ENTRY(smccc_smc)
+	smc	#0
+	ldr	x4, [sp]
+	stp	x0, x1, [x4, #SMC_RES_X0_OFFS]
+	stp	x2, x3, [x4, #SMC_RES_X2_OFFS]
+	ret
+ENDPROC(smccc_smc)
+
+/*
+ * void smccc_hvc(unsigned long a0, unsigned long a1, unsigned long a2,
+ *		  unsigned long a3, unsigned long a4, unsigned long a5,
+ *		  unsigned long a6, unsigned long a7, struct smccc_res *res)
+ */
+ENTRY(smccc_hvc)
+	hvc	#0
+	ldr	x4, [sp]
+	stp	x0, x1, [x4, #SMC_RES_X0_OFFS]
+	stp	x2, x3, [x4, #SMC_RES_X2_OFFS]
+	ret
+ENDPROC(smccc_hvc)
diff --git a/arch/arm64/kernel/smccc.c b/arch/arm64/kernel/smccc.c
new file mode 100644
index 0000000..ed13ba3
--- /dev/null
+++ b/arch/arm64/kernel/smccc.c
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
+EXPORT_SYMBOL_GPL(smccc_smc);
+EXPORT_SYMBOL_GPL(smccc_hvc);
diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
new file mode 100644
index 0000000..16f99ce
--- /dev/null
+++ b/include/linux/arm-smccc.h
@@ -0,0 +1,98 @@
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
+#include <linux/linkage.h>
+
+/*
+ * This file provides common defines for ARM SMC Calling Convention as
+ * specified in
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
+/**
+ * struct smccc_res - Result from SMC/HVC call
+ * @a0-a3 result values from registers 0 to 3
+ */
+struct smccc_res {
+	unsigned long a0;
+	unsigned long a1;
+	unsigned long a2;
+	unsigned long a3;
+};
+
+/**
+ * smccc_smc() - make SMC calls
+ * @a0-a7: arguments passed in registers 0 to 7
+ * @res: result values from registers 0 to 3
+ *
+ * This function is used to make SMC calls following SMC Calling Convention.
+ * The content of the supplied param are copied to registers 0 to 7 prior
+ * to the SMC instruction. The return values are updated with the content
+ * from register 0 to 3 on return from the SMC instruction.
+ */
+asmlinkage void smccc_smc(unsigned long a0, unsigned long a1, unsigned long a2,
+			unsigned long a3, unsigned long a4, unsigned long a5,
+			unsigned long a6, unsigned long a7,
+			struct smccc_res *res);
+
+/**
+ * smccc_hvc() - make HVC calls
+ * @a0-a7: arguments passed in registers 0 to 7
+ * @res: result values from registers 0 to 3
+ *
+ * This function is used to make HVC calls following SMC Calling
+ * Convention.  The content of the supplied param are copied to registers 0
+ * to 7 prior to the HVC instruction. The return values are updated with
+ * the content from register 0 to 3 on return from the HVC instruction.
+ */
+asmlinkage void smccc_hvc(unsigned long a0, unsigned long a1, unsigned long a2,
+			unsigned long a3, unsigned long a4, unsigned long a5,
+			unsigned long a6, unsigned long a7,
+			struct smccc_res *res);
+
+#endif /*__LINUX_ARM_SMCCC_H*/
-- 
1.9.1
