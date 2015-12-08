From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Tue,  8 Dec 2015 14:28:34 +0100
Subject: [PATCH v5 3/4] arm64: add implementation for arm-smccc
In-Reply-To: <1449581315-14519-1-git-send-email-jens.wiklander@linaro.org>
References: <1449581315-14519-1-git-send-email-jens.wiklander@linaro.org>
Message-ID: <1449581315-14519-4-git-send-email-jens.wiklander@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds implementation for arm-smccc and enables CONFIG_HAVE_SMCCC.

Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 arch/arm64/Kconfig              |  1 +
 arch/arm64/kernel/Makefile      |  2 +-
 arch/arm64/kernel/arm64ksyms.c  |  5 +++++
 arch/arm64/kernel/asm-offsets.c |  3 +++
 arch/arm64/kernel/smccc-call.S  | 43 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 53 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/kernel/smccc-call.S

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 871f217..96513d0 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -92,6 +92,7 @@ config ARM64
 	select SPARSE_IRQ
 	select SYSCTL_EXCEPTION_TRACE
 	select HAVE_CONTEXT_TRACKING
+	select HAVE_ARM_SMCCC
 	help
 	  ARM 64-bit (AArch64) Linux support.
 
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 474691f..0170bea 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -17,7 +17,7 @@ arm64-obj-y		:= debug-monitors.o entry.o irq.o fpsimd.o		\
 			   hyp-stub.o psci.o psci-call.o cpu_ops.o insn.o	\
 			   return_address.o cpuinfo.o cpu_errata.o		\
 			   cpufeature.o alternative.o cacheinfo.o		\
-			   smp.o smp_spin_table.o topology.o
+			   smp.o smp_spin_table.o topology.o smccc-call.o
 
 extra-$(CONFIG_EFI)			:= efi-entry.o
 
diff --git a/arch/arm64/kernel/arm64ksyms.c b/arch/arm64/kernel/arm64ksyms.c
index 3b6d8cc..678f30b0 100644
--- a/arch/arm64/kernel/arm64ksyms.c
+++ b/arch/arm64/kernel/arm64ksyms.c
@@ -26,6 +26,7 @@
 #include <linux/syscalls.h>
 #include <linux/uaccess.h>
 #include <linux/io.h>
+#include <linux/arm-smccc.h>
 
 #include <asm/checksum.h>
 
@@ -68,3 +69,7 @@ EXPORT_SYMBOL(test_and_change_bit);
 #ifdef CONFIG_FUNCTION_TRACER
 EXPORT_SYMBOL(_mcount);
 #endif
+
+	/* arm-smccc */
+EXPORT_SYMBOL(arm_smccc_smc);
+EXPORT_SYMBOL(arm_smccc_hvc);
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 25de8b2..bb493d4 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -28,6 +28,7 @@
 #include <asm/suspend.h>
 #include <asm/vdso_datapage.h>
 #include <linux/kbuild.h>
+#include <linux/arm-smccc.h>
 
 int main(void)
 {
@@ -161,5 +162,7 @@ int main(void)
   DEFINE(SLEEP_SAVE_SP_PHYS,	offsetof(struct sleep_save_sp, save_ptr_stash_phys));
   DEFINE(SLEEP_SAVE_SP_VIRT,	offsetof(struct sleep_save_sp, save_ptr_stash));
 #endif
+  DEFINE(ARM_SMCCC_RES_X0_OFFS,	offsetof(struct arm_smccc_res, a0));
+  DEFINE(ARM_SMCCC_RES_X2_OFFS,	offsetof(struct arm_smccc_res, a2));
   return 0;
 }
diff --git a/arch/arm64/kernel/smccc-call.S b/arch/arm64/kernel/smccc-call.S
new file mode 100644
index 0000000..ae0496f
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
+#include <asm/asm-offsets.h>
+
+	.macro SMCCC instr
+	.cfi_startproc
+	\instr	#0
+	ldr	x4, [sp]
+	stp	x0, x1, [x4, #ARM_SMCCC_RES_X0_OFFS]
+	stp	x2, x3, [x4, #ARM_SMCCC_RES_X2_OFFS]
+	ret
+	.cfi_endproc
+	.endm
+
+/*
+ * void arm_smccc_smc(unsigned long a0, unsigned long a1, unsigned long a2,
+ *		  unsigned long a3, unsigned long a4, unsigned long a5,
+ *		  unsigned long a6, unsigned long a7, struct arm_smccc_res *res)
+ */
+ENTRY(arm_smccc_smc)
+	SMCCC	smc
+ENDPROC(arm_smccc_smc)
+
+/*
+ * void arm_smccc_hvc(unsigned long a0, unsigned long a1, unsigned long a2,
+ *		  unsigned long a3, unsigned long a4, unsigned long a5,
+ *		  unsigned long a6, unsigned long a7, struct arm_smccc_res *res)
+ */
+ENTRY(arm_smccc_hvc)
+	SMCCC	hvc
+ENDPROC(arm_smccc_hvc)
-- 
1.9.1
