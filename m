From: will.deacon@arm.com (Will Deacon)
Date: Wed, 25 Feb 2015 12:10:35 +0000
Subject: [PATCH 1/2] arm64: psci: move psci firmware calls out of line
Message-ID: <1424866236-12482-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

An arm64 allmodconfig fails to build with GCC 5 due to __asmeq
assertions in the PSCI firmware calling code firing due to mcount
preambles breaking our assumptions about register allocation of function
arguments:

  /tmp/ccDqJsJ6.s: Assembler messages:
  /tmp/ccDqJsJ6.s:60: Error: .err encountered
  /tmp/ccDqJsJ6.s:61: Error: .err encountered
  /tmp/ccDqJsJ6.s:62: Error: .err encountered
  /tmp/ccDqJsJ6.s:99: Error: .err encountered
  /tmp/ccDqJsJ6.s:100: Error: .err encountered
  /tmp/ccDqJsJ6.s:101: Error: .err encountered

This patch fixes the issue by moving the PSCI calls out-of-line into
their own assembly files, which are safe from the compiler's meddling
fingers.

Reported-by: Andy Whitcroft <apw@canonical.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/Makefile    |  5 +++--
 arch/arm64/kernel/psci-call.S | 28 ++++++++++++++++++++++++++++
 arch/arm64/kernel/psci.c      | 37 +++----------------------------------
 3 files changed, 34 insertions(+), 36 deletions(-)
 create mode 100644 arch/arm64/kernel/psci-call.S

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index bef04afd6031..5ee07eee80c2 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -15,8 +15,9 @@ CFLAGS_REMOVE_return_address.o = -pg
 arm64-obj-y		:= cputable.o debug-monitors.o entry.o irq.o fpsimd.o	\
 			   entry-fpsimd.o process.o ptrace.o setup.o signal.o	\
 			   sys.o stacktrace.o time.o traps.o io.o vdso.o	\
-			   hyp-stub.o psci.o cpu_ops.o insn.o return_address.o	\
-			   cpuinfo.o cpu_errata.o alternative.o cacheinfo.o
+			   hyp-stub.o psci.o psci-call.o cpu_ops.o insn.o	\
+			   return_address.o cpuinfo.o cpu_errata.o		\
+			   alternative.o cacheinfo.o
 
 arm64-obj-$(CONFIG_COMPAT)		+= sys32.o kuser32.o signal32.o 	\
 					   sys_compat.o entry32.o		\
diff --git a/arch/arm64/kernel/psci-call.S b/arch/arm64/kernel/psci-call.S
new file mode 100644
index 000000000000..cf83e61cd3b5
--- /dev/null
+++ b/arch/arm64/kernel/psci-call.S
@@ -0,0 +1,28 @@
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
+ * Copyright (C) 2015 ARM Limited
+ *
+ * Author: Will Deacon <will.deacon@arm.com>
+ */
+
+#include <linux/linkage.h>
+
+/* int __invoke_psci_fn_hvc(u64 function_id, u64 arg0, u64 arg1, u64 arg2) */
+ENTRY(__invoke_psci_fn_hvc)
+	hvc	#0
+	ret
+ENDPROC(__invoke_psci_fn_hvc)
+
+/* int __invoke_psci_fn_smc(u64 function_id, u64 arg0, u64 arg1, u64 arg2) */
+ENTRY(__invoke_psci_fn_smc)
+	smc	#0
+	ret
+ENDPROC(__invoke_psci_fn_smc)
diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index 3425f311c49e..9b8a70ae64a1 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -57,6 +57,9 @@ static struct psci_operations psci_ops;
 static int (*invoke_psci_fn)(u64, u64, u64, u64);
 typedef int (*psci_initcall_t)(const struct device_node *);
 
+asmlinkage int __invoke_psci_fn_hvc(u64, u64, u64, u64);
+asmlinkage int __invoke_psci_fn_smc(u64, u64, u64, u64);
+
 enum psci_function {
 	PSCI_FN_CPU_SUSPEND,
 	PSCI_FN_CPU_ON,
@@ -109,40 +112,6 @@ static void psci_power_state_unpack(u32 power_state,
 			PSCI_0_2_POWER_STATE_AFFL_SHIFT;
 }
 
-/*
- * The following two functions are invoked via the invoke_psci_fn pointer
- * and will not be inlined, allowing us to piggyback on the AAPCS.
- */
-static noinline int __invoke_psci_fn_hvc(u64 function_id, u64 arg0, u64 arg1,
-					 u64 arg2)
-{
-	asm volatile(
-			__asmeq("%0", "x0")
-			__asmeq("%1", "x1")
-			__asmeq("%2", "x2")
-			__asmeq("%3", "x3")
-			"hvc	#0\n"
-		: "+r" (function_id)
-		: "r" (arg0), "r" (arg1), "r" (arg2));
-
-	return function_id;
-}
-
-static noinline int __invoke_psci_fn_smc(u64 function_id, u64 arg0, u64 arg1,
-					 u64 arg2)
-{
-	asm volatile(
-			__asmeq("%0", "x0")
-			__asmeq("%1", "x1")
-			__asmeq("%2", "x2")
-			__asmeq("%3", "x3")
-			"smc	#0\n"
-		: "+r" (function_id)
-		: "r" (arg0), "r" (arg1), "r" (arg2));
-
-	return function_id;
-}
-
 static int psci_get_version(void)
 {
 	int err;
-- 
2.1.4
