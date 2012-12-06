From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Thu, 06 Dec 2012 18:11:06 +0000
Subject: [PATCH] ARM: ftrace: Ensure code modifications are synchronised
 across all cpus
Message-ID: <1354817466.30905.13.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the generic ftrace implementation modifies code for trace-points it
uses stop_machine() to call ftrace_modify_all_code() on one CPU. This
ultimately calls the ARM specific function ftrace_modify_code() which
updates the instruction and then does flush_icache_range(). As this
cache flushing only operates on the local CPU then other cores may end
up executing the old instruction if it's still in their icaches.

This may or may not cause problems for the use of ftrace on kernels
compiled for ARM instructions. However, Thumb2 instructions can straddle
two cache lines so its possible for half the old instruction to be in
the cache and half the new one, leading to the CPU executing garbage.

This patch fixes this situation by providing an arch-specific
implementation of arch_ftrace_update_code() which ensures that after one
core has modified all the code, the other cores invalidate their icaches
before continuing.

Signed-off-by: Jon Medhurst <tixy@linaro.org>
---
 arch/arm/kernel/ftrace.c |   34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
index 34e5664..38b670c 100644
--- a/arch/arm/kernel/ftrace.c
+++ b/arch/arm/kernel/ftrace.c
@@ -14,6 +14,7 @@
 
 #include <linux/ftrace.h>
 #include <linux/uaccess.h>
+#include <linux/stop_machine.h>
 
 #include <asm/cacheflush.h>
 #include <asm/opcodes.h>
@@ -156,6 +157,39 @@ int ftrace_make_nop(struct module *mod,
 	return ret;
 }
 
+struct afmc_data {
+	int command;
+	atomic_t cpu;
+	atomic_t done;
+};
+
+static int __arch_ftrace_modify_code(void *data)
+{
+	struct afmc_data *afmcd = data;
+
+	if (atomic_inc_return(&afmcd->cpu) == num_online_cpus()) {
+		/* Last cpu to get into this function does the actual work */
+		ftrace_modify_all_code(afmcd->command);
+		wmb();
+		atomic_set(&afmcd->done, true);
+	} else {
+		/* Other cpus wait for the code modifications to be done */
+		rmb();
+		while (!atomic_read(&afmcd->done))
+			cpu_relax();
+		/* Ensure icache is consistent with the code changes */
+		__flush_icache_all();
+	}
+
+	return 0;
+}
+
+void arch_ftrace_update_code(int command)
+{
+	struct afmc_data afmcd = { command };
+	stop_machine(__arch_ftrace_modify_code, &afmcd, cpu_online_mask);
+}
+
 int __init ftrace_dyn_arch_init(void *data)
 {
 	*(unsigned long *)data = 0;
-- 
1.7.10.4
