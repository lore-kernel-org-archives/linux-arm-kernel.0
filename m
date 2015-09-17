From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 17 Sep 2015 21:38:54 +0200
Subject: [RFC PATCH 1/2] arm64: introduce infrastructure for emitting veneers
 at module reloc time
In-Reply-To: <1442518735-16625-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1442518735-16625-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1442518735-16625-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce a framework for arm64 that allows errata fixups to be implemented
by replacing problematic instruction sequences with calls into veneers that
are generated on the fly.

This is based on the module PLT support for ARM.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/Kconfig              |   4 +
 arch/arm64/Makefile             |   4 +
 arch/arm64/include/asm/module.h |   9 ++
 arch/arm64/kernel/Makefile      |   1 +
 arch/arm64/kernel/module.lds    |   4 +
 arch/arm64/kernel/veneers.c     | 100 ++++++++++++++++++++
 6 files changed, 122 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7d95663c0160..115586d8299b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -68,6 +68,7 @@ config ARM64
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS
 	select HAVE_MEMBLOCK
+	select HAVE_MOD_ARCH_SPECIFIC if ARM64_MODULE_VENEERS
 	select HAVE_PATA_PLATFORM
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
@@ -333,6 +334,9 @@ config ARM64_ERRATUM_845719
 
 endmenu
 
+config ARM64_MODULE_VENEERS
+	bool
+	depends on MODULES
 
 choice
 	prompt "Page size"
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 15ff5b4156fd..ccbcb399b9f1 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -41,6 +41,10 @@ endif
 
 CHECKFLAGS	+= -D__aarch64__
 
+ifeq ($(CONFIG_ARM64_MODULE_VENEERS),y)
+LDFLAGS_MODULE += -T $(srctree)/arch/arm64/kernel/module.lds
+endif
+
 # Default value
 head-y		:= arch/arm64/kernel/head.o
 
diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/module.h
index e80e232b730e..87e1f097a500 100644
--- a/arch/arm64/include/asm/module.h
+++ b/arch/arm64/include/asm/module.h
@@ -20,4 +20,13 @@
 
 #define MODULE_ARCH_VERMAGIC	"aarch64"
 
+#ifdef CONFIG_ARM64_MODULE_VENEERS
+struct mod_arch_specific {
+	struct veneer_section {
+		struct elf64_shdr	*veneers;
+		unsigned long	 	size;
+	} core, init;
+};
+#endif
+
 #endif /* __ASM_MODULE_H */
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 22dc9bc781be..0016e042848f 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -25,6 +25,7 @@ arm64-obj-$(CONFIG_COMPAT)		+= sys32.o kuser32.o signal32.o 	\
 					   ../../arm/kernel/opcodes.o
 arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
 arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
+arm64-obj-$(CONFIG_ARM64_MODULE_VENEERS)+= veneers.o
 arm64-obj-$(CONFIG_PERF_EVENTS)		+= perf_regs.o perf_callchain.o
 arm64-obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o
 arm64-obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
diff --git a/arch/arm64/kernel/module.lds b/arch/arm64/kernel/module.lds
new file mode 100644
index 000000000000..845b75ee0f93
--- /dev/null
+++ b/arch/arm64/kernel/module.lds
@@ -0,0 +1,4 @@
+SECTIONS {
+	.core.veneers : { BYTE(0) }
+	.init.veneers : { BYTE(0) }
+}
diff --git a/arch/arm64/kernel/veneers.c b/arch/arm64/kernel/veneers.c
new file mode 100644
index 000000000000..0a33a63a9b46
--- /dev/null
+++ b/arch/arm64/kernel/veneers.c
@@ -0,0 +1,100 @@
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
+static void __maybe_unused *alloc_veneer(struct module *mod, u64 loc, int size)
+{
+	struct veneer_section *vs;
+	void *ret;
+
+	if (in_init(mod, loc))
+		vs = &mod->arch.init;
+	else
+		vs = &mod->arch.core;
+
+	ret = (void*)vs->veneers->sh_addr + vs->size;
+	vs->size += size;
+
+	return ret;
+}
+
+/* estimate the maximum size of the veneer for this relocation */
+static unsigned long get_veneers_size(Elf64_Addr base, const Elf64_Rel *rel,
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
+	Elf64_Shdr *s, *sechdrs_end = sechdrs + ehdr->e_shnum;
+
+	/*
+	 * To store the veneers, we expand the .text section for core module
+	 * code and the .init.text section for initialization code.
+	 */
+	for (s = sechdrs; s < sechdrs_end; ++s)
+		if (strcmp(".core.veneers", secstrings + s->sh_name) == 0)
+			mod->arch.core.veneers = s;
+		else if (strcmp(".init.veneers", secstrings + s->sh_name) == 0)
+			mod->arch.init.veneers = s;
+
+	if (!mod->arch.core.veneers || !mod->arch.init.veneers) {
+		pr_err("%s: sections missing\n", mod->name);
+		return -ENOEXEC;
+	}
+
+	for (s = sechdrs + 1; s < sechdrs_end; ++s) {
+		const Elf64_Rel *rels = (void *)ehdr + s->sh_offset;
+		int numrels = s->sh_size / sizeof(Elf64_Rel);
+		Elf64_Shdr *dstsec = sechdrs + s->sh_info;
+
+		if (s->sh_type != SHT_REL)
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
+	mod->arch.core.veneers->sh_type = SHT_NOBITS;
+	mod->arch.core.veneers->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
+	mod->arch.core.veneers->sh_addralign = L1_CACHE_BYTES;
+	mod->arch.core.veneers->sh_size = core_veneers_maxsize;
+	mod->arch.core.size = 0;
+
+	mod->arch.init.veneers->sh_type = SHT_NOBITS;
+	mod->arch.init.veneers->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
+	mod->arch.init.veneers->sh_addralign = L1_CACHE_BYTES;
+	mod->arch.init.veneers->sh_size = init_veneers_maxsize;
+	mod->arch.init.size = 0;
+	pr_debug("%s: core.veneers=%llx, init.veneers=%llx\n",
+		__func__,
+		 mod->arch.core.veneers->sh_size,
+		 mod->arch.init.veneers->sh_size);
+	return 0;
+}
-- 
1.9.1
