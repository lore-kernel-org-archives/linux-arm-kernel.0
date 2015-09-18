From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 18 Sep 2015 17:39:59 +0200
Subject: [PATCH v1 1/2] arm64: introduce infrastructure for emitting veneers
 at module reloc time
In-Reply-To: <1442590800-14645-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1442590800-14645-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1442590800-14645-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce a framework for arm64 that allows errata fixups to be implemented
by replacing problematic instruction sequences with calls into veneers that
are generated on the fly.

This is based on the module PLT support for ARM.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/Kconfig              |   3 +
 arch/arm64/include/asm/module.h |  11 ++
 arch/arm64/kernel/Makefile      |   1 +
 arch/arm64/kernel/mod_veneers.c | 105 ++++++++++++++++++++
 4 files changed, 120 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7d95663c0160..b591aac06fed 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -68,6 +68,7 @@ config ARM64
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS
 	select HAVE_MEMBLOCK
+	select HAVE_MOD_ARCH_SPECIFIC if ARM64_MOD_VENEERS
 	select HAVE_PATA_PLATFORM
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
@@ -333,6 +334,8 @@ config ARM64_ERRATUM_845719
 
 endmenu
 
+config ARM64_MOD_VENEERS
+	bool
 
 choice
 	prompt "Page size"
diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/module.h
index e80e232b730e..d9ce63386e33 100644
--- a/arch/arm64/include/asm/module.h
+++ b/arch/arm64/include/asm/module.h
@@ -20,4 +20,15 @@
 
 #define MODULE_ARCH_VERMAGIC	"aarch64"
 
+#ifdef CONFIG_HAVE_MOD_ARCH_SPECIFIC
+struct mod_arch_specific {
+#ifdef CONFIG_ARM64_MOD_VENEERS
+	struct veneer_section {
+		int		sec_index;
+		unsigned int	sec_offset;
+	} core, init;
+#endif
+};
+#endif
+
 #endif /* __ASM_MODULE_H */
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 22dc9bc781be..29eb0c8c33a8 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -25,6 +25,7 @@ arm64-obj-$(CONFIG_COMPAT)		+= sys32.o kuser32.o signal32.o 	\
 					   ../../arm/kernel/opcodes.o
 arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
 arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
+arm64-obj-$(CONFIG_ARM64_MOD_VENEERS)	+= mod_veneers.o
 arm64-obj-$(CONFIG_PERF_EVENTS)		+= perf_regs.o perf_callchain.o
 arm64-obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o
 arm64-obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
diff --git a/arch/arm64/kernel/mod_veneers.c b/arch/arm64/kernel/mod_veneers.c
new file mode 100644
index 000000000000..9649c4f305bd
--- /dev/null
+++ b/arch/arm64/kernel/mod_veneers.c
@@ -0,0 +1,105 @@
+/*
+ * Copyright (C) 2015 Linaro Ltd. <ard.biesheuvel@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/elf.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+static bool in_init(const struct module *mod, u64 addr)
+{
+	return addr - (u64)mod->module_init < mod->init_size;
+}
+
+static void *alloc_veneer(struct module *mod, u64 loc, int size,
+			  Elf64_Shdr *sechdrs)
+{
+	struct veneer_section *vs;
+	void *ret;
+
+	if (in_init(mod, loc) && mod->arch.init.sec_index != -1)
+		vs = &mod->arch.init;
+	else
+		vs = &mod->arch.core;
+
+	ret = (void*)sechdrs[vs->sec_index].sh_addr + vs->sec_offset;
+	vs->sec_offset += size;
+
+	return ret;
+}
+
+/* estimate the maximum size of the veneer for this relocation */
+static unsigned long get_veneers_size(Elf64_Addr base, const Elf64_Rela *rel,
+				      int num)
+{
+	unsigned long ret = 0;
+	int i;
+
+	for (i = 0; i < num; i++)
+		switch (ELF64_R_TYPE(rel[i].r_info)) {
+		}
+	return ret;
+}
+
+int module_frob_arch_sections(Elf64_Ehdr *ehdr, Elf64_Shdr *sechdrs,
+			      char *secstrings, struct module *mod)
+{
+	unsigned long core_veneers_maxsize = 0, init_veneers_maxsize = 0;
+	int core_sec_idx = -1, init_sec_idx = -1;
+	int i;
+
+	/* find the .text and .init.text sections */
+	for (i = 0; i < ehdr->e_shnum; i++) {
+		const char *sec_name = secstrings + sechdrs[i].sh_name;
+
+		if (strcmp(sec_name, ".text") == 0)
+			core_sec_idx = i;
+		else if (strcmp(sec_name, ".init.text") == 0)
+			init_sec_idx = i;
+
+		if (core_sec_idx != -1 && init_sec_idx != -1)
+			break;
+	}
+
+	for (i = 0; i < ehdr->e_shnum; i++) {
+		Elf64_Shdr *s = &sechdrs[i];
+		Elf64_Rela *rels = (void *)ehdr + s->sh_offset;
+		int numrels = s->sh_size / sizeof(Elf64_Rela);
+		Elf64_Shdr *dstsec = sechdrs + s->sh_info;
+
+		if (s->sh_type != SHT_RELA)
+			continue;
+
+		if (strstr(secstrings + s->sh_name, ".init"))
+			init_veneers_maxsize += get_veneers_size(
+						dstsec->sh_addr, rels, numrels);
+		else
+			core_veneers_maxsize += get_veneers_size(
+						dstsec->sh_addr, rels, numrels);
+	}
+
+	if (init_sec_idx == -1 && init_veneers_maxsize > 0)
+		core_veneers_maxsize += init_veneers_maxsize;
+
+	if (core_sec_idx == -1 && core_veneers_maxsize > 0) {
+		pr_err("%s: .text section missing\n", mod->name);
+		return -ENOEXEC;
+	}
+
+	mod->arch.core.sec_index = core_sec_idx;
+	mod->arch.core.sec_offset = sechdrs[core_sec_idx].sh_size;
+	sechdrs[core_sec_idx].sh_size += core_veneers_maxsize;
+
+	mod->arch.init.sec_index = init_sec_idx;
+	if (init_sec_idx != -1) {
+		mod->arch.init.sec_offset = sechdrs[init_sec_idx].sh_size;
+		sechdrs[init_sec_idx].sh_size += init_veneers_maxsize;
+	}
+	pr_debug("module %s: core_veneers_maxsize == %lu, init_veneers_maxsize == %lu\n",
+		 mod->name, core_veneers_maxsize, init_veneers_maxsize);
+	return 0;
+}
-- 
1.9.1
