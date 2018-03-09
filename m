From: alex.shi@linaro.org (Alex Shi)
Date: Fri,  9 Mar 2018 17:07:13 +0800
Subject: [PATCH 30/39] ARM: 8481/2: drivers: psci: replace psci firmware calls
In-Reply-To: <20180309090722.26279-1-alex.shi@linaro.org>
References: <20180309090722.26279-1-alex.shi@linaro.org>
Message-ID: <20180309090722.26279-31-alex.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jens Wiklander <jens.wiklander@linaro.org>

commit e679660dbb8347f275fe5d83a5dd59c1fb6c8e63 upstream.

Switch to use a generic interface for issuing SMC/HVC based on ARM SMC
Calling Convention. Removes now the now unused psci-call.S.

Acked-by: Will Deacon <will.deacon@arm.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Tested-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm/Kconfig              |  2 +-
 arch/arm/kernel/Makefile      |  1 -
 arch/arm/kernel/psci-call.S   | 31 -------------------------------
 arch/arm64/kernel/Makefile    |  2 +-
 arch/arm64/kernel/psci-call.S | 28 ----------------------------
 drivers/firmware/psci.c       | 23 +++++++++++++++++++++--
 6 files changed, 23 insertions(+), 64 deletions(-)
 delete mode 100644 arch/arm/kernel/psci-call.S
 delete mode 100644 arch/arm64/kernel/psci-call.S

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 36b9490a9b8b..2687c934c6c0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1482,7 +1482,7 @@ config HOTPLUG_CPU
 
 config ARM_PSCI
 	bool "Support for the ARM Power State Coordination Interface (PSCI)"
-	depends on CPU_V7
+	depends on HAVE_ARM_SMCCC
 	select ARM_PSCI_FW
 	help
 	  Say Y here if you want Linux to communicate with system firmware
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 599c950468fc..82bdac0f2804 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -87,7 +87,6 @@ obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
 obj-$(CONFIG_ARM_VIRT_EXT)	+= hyp-stub.o
 ifeq ($(CONFIG_ARM_PSCI),y)
-obj-y				+= psci-call.o
 obj-$(CONFIG_SMP)		+= psci_smp.o
 endif
 
diff --git a/arch/arm/kernel/psci-call.S b/arch/arm/kernel/psci-call.S
deleted file mode 100644
index a78e9e1e206d..000000000000
--- a/arch/arm/kernel/psci-call.S
+++ /dev/null
@@ -1,31 +0,0 @@
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * Copyright (C) 2015 ARM Limited
- *
- * Author: Mark Rutland <mark.rutland@arm.com>
- */
-
-#include <linux/linkage.h>
-
-#include <asm/opcodes-sec.h>
-#include <asm/opcodes-virt.h>
-
-/* int __invoke_psci_fn_hvc(u32 function_id, u32 arg0, u32 arg1, u32 arg2) */
-ENTRY(__invoke_psci_fn_hvc)
-	__HVC(0)
-	bx	lr
-ENDPROC(__invoke_psci_fn_hvc)
-
-/* int __invoke_psci_fn_smc(u32 function_id, u32 arg0, u32 arg1, u32 arg2) */
-ENTRY(__invoke_psci_fn_smc)
-	__SMC(0)
-	bx	lr
-ENDPROC(__invoke_psci_fn_smc)
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index fa131fc27321..9f276e8a4d5a 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -14,7 +14,7 @@ CFLAGS_REMOVE_return_address.o = -pg
 arm64-obj-y		:= debug-monitors.o entry.o irq.o fpsimd.o		\
 			   entry-fpsimd.o process.o ptrace.o setup.o signal.o	\
 			   sys.o stacktrace.o time.o traps.o io.o vdso.o	\
-			   hyp-stub.o psci.o psci-call.o cpu_ops.o insn.o	\
+			   hyp-stub.o psci.o cpu_ops.o insn.o	\
 			   return_address.o cpuinfo.o cpu_errata.o		\
 			   cpufeature.o alternative.o cacheinfo.o		\
 			   smp.o smp_spin_table.o topology.o smccc-call.o
diff --git a/arch/arm64/kernel/psci-call.S b/arch/arm64/kernel/psci-call.S
deleted file mode 100644
index cf83e61cd3b5..000000000000
--- a/arch/arm64/kernel/psci-call.S
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * Copyright (C) 2015 ARM Limited
- *
- * Author: Will Deacon <will.deacon@arm.com>
- */
-
-#include <linux/linkage.h>
-
-/* int __invoke_psci_fn_hvc(u64 function_id, u64 arg0, u64 arg1, u64 arg2) */
-ENTRY(__invoke_psci_fn_hvc)
-	hvc	#0
-	ret
-ENDPROC(__invoke_psci_fn_hvc)
-
-/* int __invoke_psci_fn_smc(u64 function_id, u64 arg0, u64 arg1, u64 arg2) */
-ENTRY(__invoke_psci_fn_smc)
-	smc	#0
-	ret
-ENDPROC(__invoke_psci_fn_smc)
diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index 290f8982e7b3..0f35aebb30a7 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -13,6 +13,7 @@
 
 #define pr_fmt(fmt) "psci: " fmt
 
+#include <linux/arm-smccc.h>
 #include <linux/errno.h>
 #include <linux/linkage.h>
 #include <linux/of.h>
@@ -58,8 +59,6 @@ struct psci_operations psci_ops;
 
 typedef unsigned long (psci_fn)(unsigned long, unsigned long,
 				unsigned long, unsigned long);
-asmlinkage psci_fn __invoke_psci_fn_hvc;
-asmlinkage psci_fn __invoke_psci_fn_smc;
 static psci_fn *invoke_psci_fn;
 
 enum psci_function {
@@ -107,6 +106,26 @@ bool psci_power_state_is_valid(u32 state)
 	return !(state & ~valid_mask);
 }
 
+static unsigned long __invoke_psci_fn_hvc(unsigned long function_id,
+			unsigned long arg0, unsigned long arg1,
+			unsigned long arg2)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_hvc(function_id, arg0, arg1, arg2, 0, 0, 0, 0, &res);
+	return res.a0;
+}
+
+static unsigned long __invoke_psci_fn_smc(unsigned long function_id,
+			unsigned long arg0, unsigned long arg1,
+			unsigned long arg2)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(function_id, arg0, arg1, arg2, 0, 0, 0, 0, &res);
+	return res.a0;
+}
+
 static int psci_to_linux_errno(int errno)
 {
 	switch (errno) {
-- 
2.16.2.440.gc6284da
