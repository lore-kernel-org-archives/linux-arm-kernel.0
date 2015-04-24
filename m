From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 24 Apr 2015 11:44:09 +0900
Subject: [RFC 4/4] arm64: add livepatch support
In-Reply-To: <1429843449-7388-1-git-send-email-takahiro.akashi@linaro.org>
References: <1429843449-7388-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1429843449-7388-5-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/Kconfig                 |    3 ++
 arch/arm64/include/asm/livepatch.h |   38 ++++++++++++++++++++
 arch/arm64/kernel/Makefile         |    1 +
 arch/arm64/kernel/livepatch.c      |   68 ++++++++++++++++++++++++++++++++++++
 4 files changed, 110 insertions(+)
 create mode 100644 arch/arm64/include/asm/livepatch.h
 create mode 100644 arch/arm64/kernel/livepatch.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c3678ed..d4b5bac 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -61,6 +61,7 @@ config ARM64
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS
+	select HAVE_LIVEPATCH
 	select HAVE_MEMBLOCK
 	select HAVE_PATA_PLATFORM
 	select HAVE_PERF_EVENTS
@@ -612,6 +613,8 @@ config SETEND_EMULATION
 	  If unsure, say Y
 endif
 
+source "kernel/livepatch/Kconfig"
+
 endmenu
 
 menu "Boot options"
diff --git a/arch/arm64/include/asm/livepatch.h b/arch/arm64/include/asm/livepatch.h
new file mode 100644
index 0000000..590d139
--- /dev/null
+++ b/arch/arm64/include/asm/livepatch.h
@@ -0,0 +1,38 @@
+/*
+ * Copyright (C) 2015 Linaro Limited
+ * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __ASM_LIVEPATCH_H
+#define __ASM_LIVEPATCH_H
+
+#include <linux/module.h>
+#include <linux/ftrace.h>
+
+#ifdef CONFIG_LIVEPATCH
+static inline int klp_check_compiler_support(void)
+{
+	return 0;
+}
+extern int klp_write_module_reloc(struct module *mod, unsigned long type,
+				  unsigned long loc, unsigned long value);
+
+extern unsigned long ftrace_lookup_mcount(unsigned long addr);
+
+static inline void klp_arch_set_pc(struct pt_regs *regs, unsigned long ip)
+{
+	regs->regs[30] = ip;
+}
+
+static inline unsigned long klp_arch_lookup_mcount(unsigned long addr)
+{
+	return ftrace_lookup_mcount(addr);
+}
+#else
+#error Live patching support is disabled; check CONFIG_LIVEPATCH
+#endif
+
+#endif /* __ASM_LIVEPATCH_H */
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 5ee07ee..7614990 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -35,6 +35,7 @@ arm64-obj-$(CONFIG_KGDB)		+= kgdb.o
 arm64-obj-$(CONFIG_EFI)			+= efi.o efi-stub.o efi-entry.o
 arm64-obj-$(CONFIG_PCI)			+= pci.o
 arm64-obj-$(CONFIG_ARMV8_DEPRECATED)	+= armv8_deprecated.o
+arm64-obj-$(CONFIG_LIVEPATCH)		+= livepatch.o
 
 obj-y					+= $(arm64-obj-y) vdso/
 obj-m					+= $(arm64-obj-m)
diff --git a/arch/arm64/kernel/livepatch.c b/arch/arm64/kernel/livepatch.c
new file mode 100644
index 0000000..abe4947
--- /dev/null
+++ b/arch/arm64/kernel/livepatch.c
@@ -0,0 +1,68 @@
+/*
+ * livepatch.c - arm64-specific Kernel Live Patching Core
+ *
+ * Copyright (C) 2015 Linaro Limited
+ * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <asm/cacheflush.h>
+#include <asm/elf.h>
+#include <asm/insn.h>
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
+	unsigned long core = (unsigned long)mod->module_core;
+	unsigned long core_ro_size = mod->core_ro_size;
+	unsigned long core_size = mod->core_size;
+	bool readonly;
+	u32 new;
+	int ret;
+
+	switch (type) {
+	case R_AARCH64_NONE:
+		return 0;
+	case R_AARCH64_CALL26:
+		break;
+	default:
+		/* unsupported relocation type */
+		return -EINVAL;
+	}
+
+	if (loc < core || loc >= core + core_size)
+		/* loc does not point to any symbol inside the module */
+		return -EINVAL;
+
+	if (loc < core + core_ro_size)
+		readonly = true;
+	else
+		readonly = false;
+
+	if (readonly)
+		set_memory_rw(loc & PAGE_MASK, 1);
+
+	new = aarch64_insn_gen_branch_imm(loc, value,
+					  AARCH64_INSN_BRANCH_NOLINK);
+	ret = aarch64_insn_patch_text_nosync((void *)loc, new);
+
+	if (readonly)
+		set_memory_ro(loc & PAGE_MASK, 1);
+
+	return ret;
+}
-- 
1.7.9.5
