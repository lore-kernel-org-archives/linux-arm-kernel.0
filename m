From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Thu, 29 Oct 2015 09:21:24 +0100
Subject: [PATCH v6 2/6] drivers: psci: replace psci firmware calls
In-Reply-To: <1446106888-8983-1-git-send-email-jens.wiklander@linaro.org>
References: <1446106888-8983-1-git-send-email-jens.wiklander@linaro.org>
Message-ID: <1446106888-8983-3-git-send-email-jens.wiklander@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch to use a generic interface for issuing SMC/HVC based on ARM SMC
Calling Convention. Removes now the now unused psci-call.S.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 arch/arm/kernel/Makefile      |  1 -
 arch/arm/kernel/psci-call.S   | 31 -------------------------------
 arch/arm64/kernel/Makefile    |  2 +-
 arch/arm64/kernel/psci-call.S | 28 ----------------------------
 drivers/firmware/psci.c       | 21 +++++++++++++++++++--
 5 files changed, 20 insertions(+), 63 deletions(-)
 delete mode 100644 arch/arm/kernel/psci-call.S
 delete mode 100644 arch/arm64/kernel/psci-call.S

diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index a98867d..190fa74 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -88,7 +88,6 @@ obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
 obj-$(CONFIG_ARM_VIRT_EXT)	+= hyp-stub.o
 ifeq ($(CONFIG_ARM_PSCI),y)
-obj-y				+= psci-call.o
 obj-$(CONFIG_SMP)		+= psci_smp.o
 endif
 
diff --git a/arch/arm/kernel/psci-call.S b/arch/arm/kernel/psci-call.S
deleted file mode 100644
index a78e9e1..0000000
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
index 250948e..748e595 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -15,7 +15,7 @@ CFLAGS_REMOVE_return_address.o = -pg
 arm64-obj-y		:= debug-monitors.o entry.o irq.o fpsimd.o		\
 			   entry-fpsimd.o process.o ptrace.o setup.o signal.o	\
 			   sys.o stacktrace.o time.o traps.o io.o vdso.o	\
-			   hyp-stub.o psci.o psci-call.o cpu_ops.o insn.o	\
+			   hyp-stub.o psci.o cpu_ops.o insn.o	\
 			   return_address.o cpuinfo.o cpu_errata.o		\
 			   cpufeature.o alternative.o cacheinfo.o		\
 			   smp.o smp_spin_table.o topology.o
diff --git a/arch/arm64/kernel/psci-call.S b/arch/arm64/kernel/psci-call.S
deleted file mode 100644
index cf83e61..0000000
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
index 42700f0..53c9606 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -19,6 +19,7 @@
 #include <linux/pm.h>
 #include <linux/printk.h>
 #include <linux/psci.h>
+#include <linux/arm-smccc.h>
 #include <linux/reboot.h>
 
 #include <uapi/linux/psci.h>
@@ -56,8 +57,6 @@ struct psci_operations psci_ops;
 
 typedef unsigned long (psci_fn)(unsigned long, unsigned long,
 				unsigned long, unsigned long);
-asmlinkage psci_fn __invoke_psci_fn_hvc;
-asmlinkage psci_fn __invoke_psci_fn_smc;
 static psci_fn *invoke_psci_fn;
 
 enum psci_function {
@@ -70,6 +69,24 @@ enum psci_function {
 
 static u32 psci_function_id[PSCI_FN_MAX];
 
+static unsigned long __invoke_psci_fn_hvc(unsigned long a0, unsigned long a1,
+			unsigned long a2, unsigned long a3)
+{
+	struct smccc_res res;
+
+	smccc_hvc(a0, a1, a2, a3, 0, 0, 0, 0, &res);
+	return res.a0;
+}
+
+static unsigned long __invoke_psci_fn_smc(unsigned long a0, unsigned long a1,
+			unsigned long a2, unsigned long a3)
+{
+	struct smccc_res res;
+
+	smccc_smc(a0, a1, a2, a3, 0, 0, 0, 0, &res);
+	return res.a0;
+}
+
 static int psci_to_linux_errno(int errno)
 {
 	switch (errno) {
-- 
1.9.1
