From: huawei.libin@huawei.com (Li Bin)
Date: Mon, 14 Dec 2015 20:49:38 +0800
Subject: [RFC PATCH 3/3] livepatch: arm64: add support for livepatch on arm64
In-Reply-To: <1450097378-3780-1-git-send-email-huawei.libin@huawei.com>
References: <1450097378-3780-1-git-send-email-huawei.libin@huawei.com>
Message-ID: <1450097378-3780-4-git-send-email-huawei.libin@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add support for livepach on arm64 based on the gcc
-fprolog-pad feature (that always placing one nop at the beginning
of the function). And when enable/disable func patching, just
modify the pad code to nop or branch. And that NOP and B instruction
are both safe instructions on arm64 which called "concurrent
modification and execution of instructions", that can be executed
by one thread of execution as they are being modified by another
thread of execution without requiring explicit synchronization.

Signed-off-by: Li Bin <huawei.libin@huawei.com>
---
 Makefile                           |    7 ++-
 arch/arm64/Kconfig                 |    4 +
 arch/arm64/include/asm/livepatch.h |   45 +++++++++++++
 arch/arm64/kernel/Makefile         |    1 +
 arch/arm64/kernel/livepatch.c      |  123 ++++++++++++++++++++++++++++++++++++
 kernel/livepatch/Kconfig           |   10 +++-
 6 files changed, 187 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/include/asm/livepatch.h
 create mode 100644 arch/arm64/kernel/livepatch.c

diff --git a/Makefile b/Makefile
index d644f6e..6171fb8 100644
--- a/Makefile
+++ b/Makefile
@@ -727,8 +727,11 @@ export CC_FLAGS_FTRACE
 ifdef CONFIG_HAVE_FENTRY
 CC_USING_FENTRY	:= $(call cc-option, -mfentry -DCC_USING_FENTRY)
 endif
-KBUILD_CFLAGS	+= $(CC_FLAGS_FTRACE) $(CC_USING_FENTRY)
-KBUILD_AFLAGS	+= $(CC_USING_FENTRY)
+ifdef CONFIG_HAVE_PROLOG_PAD
+CC_USING_PROLOG_PAD := $(call cc-option, -fprolog-pad=1 -DCC_USING_PROLOG_PAD)
+endif
+KBUILD_CFLAGS  += $(CC_FLAGS_FTRACE) $(CC_USING_FENTRY) $(CC_USING_PROLOG_PAD)
+KBUILD_AFLAGS  += $(CC_USING_FENTRY) $(CC_USING_PROLOG_PAD)
 ifdef CONFIG_DYNAMIC_FTRACE
 	ifdef CONFIG_HAVE_C_RECORDMCOUNT
 		BUILD_C_RECORDMCOUNT := y
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 871f217..85e01b1 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -66,6 +66,7 @@ config ARM64
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select HAVE_FTRACE_MCOUNT_RECORD
+	select HAVE_PROLOG_PAD
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_GENERIC_DMA_COHERENT
@@ -92,6 +93,7 @@ config ARM64
 	select SPARSE_IRQ
 	select SYSCTL_EXCEPTION_TRACE
 	select HAVE_CONTEXT_TRACKING
+	select HAVE_LIVEPATCH
 	help
 	  ARM 64-bit (AArch64) Linux support.
 
@@ -183,6 +185,8 @@ source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
 
+source "kernel/livepatch/Kconfig"
+
 source "arch/arm64/Kconfig.platforms"
 
 menu "Bus support"
diff --git a/arch/arm64/include/asm/livepatch.h b/arch/arm64/include/asm/livepatch.h
new file mode 100644
index 0000000..9bf6c0b
--- /dev/null
+++ b/arch/arm64/include/asm/livepatch.h
@@ -0,0 +1,45 @@
+/*
+ * livepatch.h - arm64-specific Kernel Live Patching Core
+ *
+ * Copyright (C) 2015 Li Bin <huawei.libin@huawei.com>
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
+#ifndef CC_USING_PROLOG_PAD
+	return 1;
+#endif
+	return 0;
+}
+extern int klp_write_module_reloc(struct module *mod, unsigned long type,
+				  unsigned long loc, unsigned long value);
+
+static inline void klp_arch_set_pc(struct pt_regs *regs, unsigned long pc)
+{
+	BUG();
+}
+#else
+#error Live patching support is disabled; check CONFIG_LIVEPATCH
+#endif
+
+#endif /* _ASM_ARM64_LIVEPATCH_H */
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 474691f..59a415d 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -29,6 +29,7 @@ arm64-obj-$(CONFIG_COMPAT)		+= sys32.o kuser32.o signal32.o 	\
 					   sys_compat.o entry32.o		\
 					   ../../arm/kernel/opcodes.o
 arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
+arm64-obj-$(CONFIG_LIVEPATCH) += livepatch.o
 arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
 arm64-obj-$(CONFIG_PERF_EVENTS)		+= perf_regs.o perf_callchain.o
 arm64-obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o
diff --git a/arch/arm64/kernel/livepatch.c b/arch/arm64/kernel/livepatch.c
new file mode 100644
index 0000000..a06f710
--- /dev/null
+++ b/arch/arm64/kernel/livepatch.c
@@ -0,0 +1,123 @@
+/*
+ * livepatch.c - arm64-specific Kernel Live Patching Core
+ *
+ * Copyright (C) 2015 Li Bin <huawei.libin@huawei.com>
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
+#include <linux/uaccess.h>
+#include <linux/livepatch.h>
+#include <linux/slab.h>
+#include <asm/livepatch.h>
+#include <asm/insn.h>
+
+struct klp_func_node {
+	struct list_head node;
+	struct list_head func_stack;
+	unsigned long old_addr;
+};
+
+static LIST_HEAD(klp_func_list);
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
+	/* Perform the static relocation. */
+	return static_relocate(mod, type, (void *)loc, value);
+}
+
+#ifdef CC_USING_PROLOG_PAD
+static struct klp_func_node *klp_find_func_node(unsigned long old_addr)
+{
+	struct klp_func_node *func_node;
+
+	list_for_each_entry(func_node, &klp_func_list, node) {
+		if (func_node->old_addr == old_addr)
+			return func_node;
+	}
+
+	return NULL;
+}
+
+void arch_klp_disable_func(struct klp_func *func)
+{
+	struct klp_func_node *func_node;
+	struct klp_func *next_func;
+	unsigned long pc, new_addr;
+	u32 insn;
+
+	func_node = klp_find_func_node(func->old_addr);
+	pc = func_node->old_addr;
+	if (list_is_singular(&func_node->func_stack)) {
+		list_del_rcu(&func->stack_node);
+		list_del(&func_node->node);
+		kfree(func_node);
+
+		insn = aarch64_insn_gen_nop();
+		aarch64_insn_patch_text_nosync((void *)pc, insn);
+	} else {
+		list_del_rcu(&func->stack_node);
+		next_func = list_first_or_null_rcu(&func_node->func_stack,
+				struct klp_func, stack_node);
+
+		new_addr = (unsigned long)next_func->new_func;
+		insn = aarch64_insn_gen_branch_imm(pc, new_addr,
+				AARCH64_INSN_BRANCH_NOLINK);
+
+		aarch64_insn_patch_text_nosync((void *)pc, insn);
+	}
+}
+
+int arch_klp_enable_func(struct klp_func *func)
+{
+	struct klp_func_node *func_node;
+	unsigned long pc, new_addr;
+	u32 insn;
+
+	func_node = klp_find_func_node(func->old_addr);
+	if (!func_node) {
+		func_node = kzalloc(sizeof(*func_node), GFP_KERNEL);
+		if (!func_node)
+			return -ENOMEM;
+
+		INIT_LIST_HEAD(&func_node->func_stack);
+		func_node->old_addr = func->old_addr;
+		list_add(&func_node->node, &klp_func_list);
+	}
+
+	list_add_rcu(&func->stack_node, &func_node->func_stack);
+
+	pc = func->old_addr;
+	new_addr = (unsigned long)func->new_func;
+	insn = aarch64_insn_gen_branch_imm(pc, new_addr,
+			                AARCH64_INSN_BRANCH_NOLINK);
+
+	if (aarch64_insn_patch_text_nosync((void *)pc, insn))
+		        return -EPERM;
+
+	return 0;
+}
+#endif
diff --git a/kernel/livepatch/Kconfig b/kernel/livepatch/Kconfig
index 0450225..287bb79 100644
--- a/kernel/livepatch/Kconfig
+++ b/kernel/livepatch/Kconfig
@@ -1,3 +1,11 @@
+config HAVE_PROLOG_PAD
+	bool
+
+config PROLOG_PAD
+	bool
+	depends on HAVE_PROLOG_PAD
+	default y
+
 config HAVE_LIVEPATCH
 	bool
 	help
@@ -5,7 +13,7 @@ config HAVE_LIVEPATCH
 
 config LIVEPATCH
 	bool "Kernel Live Patching"
-	depends on DYNAMIC_FTRACE_WITH_REGS
+	depends on DYNAMIC_FTRACE_WITH_REGS || PROLOG_PAD
 	depends on MODULES
 	depends on SYSFS
 	depends on KALLSYMS_ALL
-- 
1.7.1
