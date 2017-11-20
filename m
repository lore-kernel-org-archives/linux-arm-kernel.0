From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 20 Nov 2017 13:15:38 +0000
Subject: [RFC PATCH] arm64: ftrace: move ftrace-mod.o contents into linker
 script
Message-ID: <20171120131538.10492-1-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When building the arm64 kernel with bot CONFIG_ARM64_MODULE_PLTS and
CONFIG_DYNAMIC_FTRACE enabled, the ftrace-mod.o object file is built
with the kernel and contains a trampoline that is linked into each
module, so that modules can be loaded far away from the kernel and
still reach the ftrace entry point in the core kernel with an ordinary
relative branch, as is emitted by the compiler instrumentation code
dynamic ftrace relies on.

In order to be able to build out of tree modules, this object file
needs to be included into the linux-headers or linux-devel packages,
which is undesirable, as it makes arm64 a special case (although a
precedent does exist for 32-bit PPC).

Given that the trampoline only consists of two instructions, let's
hack it into the module linker script instead.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/Makefile                 |  2 +-
 arch/arm64/kernel/Makefile          |  3 ---
 arch/arm64/kernel/ftrace-mod.S      | 18 ------------------
 arch/arm64/kernel/module-ftrace.lds |  7 +++++++
 arch/arm64/kernel/module-plts.c     | 13 +++++++++++++
 5 files changed, 21 insertions(+), 22 deletions(-)
 delete mode 100644 arch/arm64/kernel/ftrace-mod.S
 create mode 100644 arch/arm64/kernel/module-ftrace.lds

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index b35788c909f1..be8a38382a57 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -84,7 +84,7 @@ endif
 ifeq ($(CONFIG_ARM64_MODULE_PLTS),y)
 KBUILD_LDFLAGS_MODULE	+= -T $(srctree)/arch/arm64/kernel/module.lds
 ifeq ($(CONFIG_DYNAMIC_FTRACE),y)
-KBUILD_LDFLAGS_MODULE	+= $(objtree)/arch/arm64/kernel/ftrace-mod.o
+KBUILD_LDFLAGS_MODULE	+= -T $(srctree)/arch/arm64/kernel/module-ftrace.lds
 endif
 endif
 
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 8265dd790895..067baace74a0 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -61,6 +61,3 @@ extra-y					+= $(head-y) vmlinux.lds
 ifeq ($(CONFIG_DEBUG_EFI),y)
 AFLAGS_head.o += -DVMLINUX_PATH="\"$(realpath $(objtree)/vmlinux)\""
 endif
-
-# will be included by each individual module but not by the core kernel itself
-extra-$(CONFIG_DYNAMIC_FTRACE) += ftrace-mod.o
diff --git a/arch/arm64/kernel/ftrace-mod.S b/arch/arm64/kernel/ftrace-mod.S
deleted file mode 100644
index 00c4025be4ff..000000000000
--- a/arch/arm64/kernel/ftrace-mod.S
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- * Copyright (C) 2017 Linaro Ltd <ard.biesheuvel@linaro.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/linkage.h>
-#include <asm/assembler.h>
-
-	.section	".text.ftrace_trampoline", "ax"
-	.align		3
-0:	.quad		0
-__ftrace_trampoline:
-	ldr		x16, 0b
-	br		x16
-ENDPROC(__ftrace_trampoline)
diff --git a/arch/arm64/kernel/module-ftrace.lds b/arch/arm64/kernel/module-ftrace.lds
new file mode 100644
index 000000000000..9df69ddaa7bb
--- /dev/null
+++ b/arch/arm64/kernel/module-ftrace.lds
@@ -0,0 +1,7 @@
+SECTIONS {
+	.text.ftrace_trampoline : ALIGN (8) {
+		QUAD (0x0);		/* 0:	.quad	0x0		*/
+		LONG (0x58ffffd0);	/*	ldr	x16, 0b		*/
+		LONG (0xd61f0200);	/*	br	x16		*/
+	}
+}
diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
index d05dbe658409..d7e85a1c3e1c 100644
--- a/arch/arm64/kernel/module-plts.c
+++ b/arch/arm64/kernel/module-plts.c
@@ -154,6 +154,7 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 	unsigned long core_plts = 0;
 	unsigned long init_plts = 0;
 	Elf64_Sym *syms = NULL;
+	Elf_Shdr *ftrace_trampoline = NULL;
 	int i;
 
 	/*
@@ -165,6 +166,9 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 			mod->arch.core.plt = sechdrs + i;
 		else if (!strcmp(secstrings + sechdrs[i].sh_name, ".init.plt"))
 			mod->arch.init.plt = sechdrs + i;
+		else if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE) &&
+			 !strcmp(secstrings + sechdrs[i].sh_name, ".text.ftrace_trampoline"))
+			ftrace_trampoline = sechdrs + i;
 		else if (sechdrs[i].sh_type == SHT_SYMTAB)
 			syms = (Elf64_Sym *)sechdrs[i].sh_addr;
 	}
@@ -215,5 +219,14 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 	mod->arch.init.plt_num_entries = 0;
 	mod->arch.init.plt_max_entries = init_plts;
 
+	if (ftrace_trampoline)
+		/*
+		 * Unfortunately, there does not seem to be a way to force a
+		 * linker output section consisting solely of QUAD()/LONG()
+		 * statements to have read-execute permissions after partial
+		 * linking. So override the permission attributes at load time.
+		 */
+		ftrace_trampoline->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
+
 	return 0;
 }
-- 
2.11.0
