From: huawei.libin@huawei.com (Li Bin)
Date: Thu, 28 May 2015 13:51:04 +0800
Subject: [RFC PATCH 4/5] livepatch: arm64: add support for livepatch on arm64
In-Reply-To: <1432792265-24076-1-git-send-email-huawei.libin@huawei.com>
References: <1432792265-24076-1-git-send-email-huawei.libin@huawei.com>
Message-ID: <1432792265-24076-5-git-send-email-huawei.libin@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add support for livepatch on arm64 based on the gcc -mfentry
feature and the ftrace DYNAMIC_FTRACE_WITH_REGS feature.

Signed-off-by: Li Bin <huawei.libin@huawei.com>
---
 arch/arm64/Kconfig                 |    3 ++
 arch/arm64/include/asm/livepatch.h |   45 ++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/Makefile         |    1 +
 arch/arm64/kernel/livepatch.c      |   38 ++++++++++++++++++++++++++++++
 kernel/livepatch/core.c            |   17 +++++++++----
 5 files changed, 99 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm64/include/asm/livepatch.h
 create mode 100644 arch/arm64/kernel/livepatch.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7bb2468..8a3845c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -85,6 +85,7 @@ config ARM64
 	select SPARSE_IRQ
 	select SYSCTL_EXCEPTION_TRACE
 	select HAVE_CONTEXT_TRACKING
+	select HAVE_LIVEPATCH
 	help
 	  ARM 64-bit (AArch64) Linux support.
 
@@ -159,6 +160,8 @@ source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
 
+source "kernel/livepatch/Kconfig"
+
 menu "Platform selection"
 
 config ARCH_EXYNOS
diff --git a/arch/arm64/include/asm/livepatch.h b/arch/arm64/include/asm/livepatch.h
new file mode 100644
index 0000000..1890413
--- /dev/null
+++ b/arch/arm64/include/asm/livepatch.h
@@ -0,0 +1,45 @@
+/*
+ * livepatch.h - arm64-specific Kernel Live Patching Core
+ *
+ * Copyright (C) 2014 Li Bin <huawei.libin@huawei.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef _ASM_ARM64_LIVEPATCH_H
+#define _ASM_ARM64_LIVEPATCH_H
+
+#include <linux/module.h>
+#include <linux/ftrace.h>
+
+#ifdef CONFIG_LIVEPATCH
+static inline int klp_check_compiler_support(void)
+{
+#ifndef CC_USING_FENTRY
+	return 1;
+#endif
+	return 0;
+}
+extern int klp_write_module_reloc(struct module *mod, unsigned long type,
+				  unsigned long loc, unsigned long value);
+
+static inline void klp_arch_set_pc(struct pt_regs *regs, unsigned long pc)
+{
+	regs->pc = pc;
+}
+#else
+#error Live patching support is disabled; check CONFIG_LIVEPATCH
+#endif
+
+#endif /* _ASM_ARM64_LIVEPATCH_H */
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 426d076..30d307b 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -23,6 +23,7 @@ arm64-obj-$(CONFIG_COMPAT)		+= sys32.o kuser32.o signal32.o 	\
 					   sys_compat.o entry32.o		\
 					   ../../arm/kernel/opcodes.o
 arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
+arm64-obj-$(CONFIG_LIVEPATCH) += livepatch.o
 arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
 arm64-obj-$(CONFIG_SMP)			+= smp.o smp_spin_table.o topology.o
 arm64-obj-$(CONFIG_PERF_EVENTS)		+= perf_regs.o
diff --git a/arch/arm64/kernel/livepatch.c b/arch/arm64/kernel/livepatch.c
new file mode 100644
index 0000000..2a55532
--- /dev/null
+++ b/arch/arm64/kernel/livepatch.c
@@ -0,0 +1,38 @@
+/*
+ * livepatch.c - arm64-specific Kernel Live Patching Core
+ *
+ * Copyright (C) 2014 Li Bin <huawei.libin@huawei.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/module.h>
+#include <asm/livepatch.h>
+
+/**
+ * klp_write_module_reloc() - write a relocation in a module
+ * @mod:	module in which the section to be modified is found
+ * @type:	ELF relocation type (see asm/elf.h)
+ * @loc:	address that the relocation should be written to
+ * @value:	relocation value (sym address + addend)
+ *
+ * This function writes a relocation to the specified location for
+ * a particular module.
+ */
+int klp_write_module_reloc(struct module *mod, unsigned long type,
+			   unsigned long loc, unsigned long value)
+{
+	pr_err("lpc_write_module_reloc has not supported now\n");
+	return -ENOSYS;
+}
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 284e269..945065f 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -321,6 +321,7 @@ static void notrace klp_ftrace_handler(unsigned long ip,
 {
 	struct klp_ops *ops;
 	struct klp_func *func;
+	unsigned long new_ip;
 
 	ops = container_of(fops, struct klp_ops, fops);
 
@@ -330,7 +331,8 @@ static void notrace klp_ftrace_handler(unsigned long ip,
 	if (WARN_ON_ONCE(!func))
 		goto unlock;
 
-	klp_arch_set_pc(regs, (unsigned long)func->new_func);
+	new_ip = ftrace_function_stub_ip((unsigned long)func->new_func);
+	klp_arch_set_pc(regs, new_ip);
 unlock:
 	rcu_read_unlock();
 }
@@ -338,6 +340,8 @@ unlock:
 static void klp_disable_func(struct klp_func *func)
 {
 	struct klp_ops *ops;
+	int ret;
+	unsigned long ip;
 
 	WARN_ON(func->state != KLP_ENABLED);
 	WARN_ON(!func->old_addr);
@@ -347,8 +351,9 @@ static void klp_disable_func(struct klp_func *func)
 		return;
 
 	if (list_is_singular(&ops->func_stack)) {
-		WARN_ON(unregister_ftrace_function(&ops->fops));
-		WARN_ON(ftrace_set_filter_ip(&ops->fops, func->old_addr, 1, 0));
+		ip = ftrace_function_stub_ip(func->old_addr);
+	 	WARN_ON(unregister_ftrace_function(&ops->fops));
+		WARN_ON(ftrace_set_filter_ip(&ops->fops, ip, 1, 0));
 
 		list_del_rcu(&func->stack_node);
 		list_del(&ops->node);
@@ -364,6 +369,7 @@ static int klp_enable_func(struct klp_func *func)
 {
 	struct klp_ops *ops;
 	int ret;
+	unsigned long ip;
 
 	if (WARN_ON(!func->old_addr))
 		return -EINVAL;
@@ -387,7 +393,8 @@ static int klp_enable_func(struct klp_func *func)
 		INIT_LIST_HEAD(&ops->func_stack);
 		list_add_rcu(&func->stack_node, &ops->func_stack);
 
-		ret = ftrace_set_filter_ip(&ops->fops, func->old_addr, 0, 0);
+		ip = ftrace_function_stub_ip(func->old_addr);
+		ret = ftrace_set_filter_ip(&ops->fops, ip, 0, 0);
 		if (ret) {
 			pr_err("failed to set ftrace filter for function '%s' (%d)\n",
 			       func->old_name, ret);
@@ -398,7 +405,7 @@ static int klp_enable_func(struct klp_func *func)
 		if (ret) {
 			pr_err("failed to register ftrace handler for function '%s' (%d)\n",
 			       func->old_name, ret);
-			ftrace_set_filter_ip(&ops->fops, func->old_addr, 1, 0);
+			ftrace_set_filter_ip(&ops->fops, ip, 1, 0);
 			goto err;
 		}
 
-- 
1.7.1
