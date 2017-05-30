From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 30 May 2017 13:52:20 +0000
Subject: [PATCH v2 2/2] arm64: ftrace: add support for far branches to dynamic
 ftrace
In-Reply-To: <20170530135220.20759-1-ard.biesheuvel@linaro.org>
References: <20170530135220.20759-1-ard.biesheuvel@linaro.org>
Message-ID: <20170530135220.20759-3-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, dynamic ftrace support in the arm64 kernel assumes that all
core kernel code is within range of ordinary branch instructions in that
occur in module code, which is usually the case, but is no longer guaranteed
now that we have support for module PLTs and address space randomization.

Since on arm64, all patching of branch instructions involves function calls
to the same entry point [ftrace_caller()], we can emit the modules with a
trampoline that has unlimited range, and patch both the trampoline itself
and the branch instruction to redirect the call via the trampoline.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/Kconfig              |  2 +-
 arch/arm64/Makefile             |  3 ++
 arch/arm64/include/asm/module.h |  3 ++
 arch/arm64/kernel/Makefile      |  3 ++
 arch/arm64/kernel/ftrace-mod.S  | 18 +++++++
 arch/arm64/kernel/ftrace.c      | 52 ++++++++++++++++++--
 arch/arm64/kernel/module-plts.c | 10 ++++
 7 files changed, 87 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 3dcd7ec69bca..22f769b254b4 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -982,7 +982,7 @@ config RANDOMIZE_BASE
 
 config RANDOMIZE_MODULE_REGION_FULL
 	bool "Randomize the module region independently from the core kernel"
-	depends on RANDOMIZE_BASE && !DYNAMIC_FTRACE
+	depends on RANDOMIZE_BASE
 	default y
 	help
 	  Randomizes the location of the module region without considering the
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index f839ecd919f9..1ce57b42f390 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -70,6 +70,9 @@ endif
 
 ifeq ($(CONFIG_ARM64_MODULE_PLTS),y)
 KBUILD_LDFLAGS_MODULE	+= -T $(srctree)/arch/arm64/kernel/module.lds
+ifeq ($(CONFIG_DYNAMIC_FTRACE),y)
+KBUILD_LDFLAGS_MODULE	+= $(objtree)/arch/arm64/kernel/ftrace-mod.o
+endif
 endif
 
 # Default value
diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/module.h
index d57693f5d4ec..e931142c0e2a 100644
--- a/arch/arm64/include/asm/module.h
+++ b/arch/arm64/include/asm/module.h
@@ -30,6 +30,9 @@ struct mod_plt_sec {
 struct mod_arch_specific {
 	struct mod_plt_sec	core;
 	struct mod_plt_sec	init;
+
+	/* for CONFIG_DYNAMIC_FTRACE */
+	struct elf64_shdr	*ftrace_trampoline;
 };
 #endif
 
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 1dcb69d3d0e5..f2b4e816b6de 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -62,3 +62,6 @@ extra-y					+= $(head-y) vmlinux.lds
 ifeq ($(CONFIG_DEBUG_EFI),y)
 AFLAGS_head.o += -DVMLINUX_PATH="\"$(realpath $(objtree)/vmlinux)\""
 endif
+
+# will be included by each individual module but not by the core kernel itself
+extra-$(CONFIG_DYNAMIC_FTRACE) += ftrace-mod.o
diff --git a/arch/arm64/kernel/ftrace-mod.S b/arch/arm64/kernel/ftrace-mod.S
new file mode 100644
index 000000000000..00c4025be4ff
--- /dev/null
+++ b/arch/arm64/kernel/ftrace-mod.S
@@ -0,0 +1,18 @@
+/*
+ * Copyright (C) 2017 Linaro Ltd <ard.biesheuvel@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+
+	.section	".text.ftrace_trampoline", "ax"
+	.align		3
+0:	.quad		0
+__ftrace_trampoline:
+	ldr		x16, 0b
+	br		x16
+ENDPROC(__ftrace_trampoline)
diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index a8db6857cad6..d55151f0dc59 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -9,11 +9,14 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/elf.h>
 #include <linux/ftrace.h>
+#include <linux/module.h>
 #include <linux/swab.h>
 #include <linux/uaccess.h>
 
 #include <asm/cacheflush.h>
+#include <asm/debug-monitors.h>
 #include <asm/ftrace.h>
 #include <asm/insn.h>
 
@@ -63,6 +66,50 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 	return ftrace_modify_code(pc, 0, new, false);
 }
 
+static u32 __ftrace_gen_branch(unsigned long pc, unsigned long addr)
+{
+	long offset = (long)pc - (long)addr;
+	unsigned long *tramp;
+	struct module *mod;
+
+	if (IS_ENABLED(CONFIG_ARM64_MODULE_PLTS) &&
+	    (offset < -SZ_128M || offset >= SZ_128M)) {
+
+		/*
+		 * On kernels that support module PLTs, the offset between the
+		 * call and its target may legally exceed the range of an
+		 * ordinary branch instruction. In this case, we need to branch
+		 * via a trampoline in the module.
+		 */
+		mod = __module_address(pc);
+		if (WARN_ON(!mod))
+			return AARCH64_BREAK_FAULT;
+
+		/*
+		 * There is only one ftrace trampoline per module. For now,
+		 * this is not a problem since on arm64, all dynamic ftrace
+		 * invocations are routed via ftrace_caller(). This will need
+		 * to be revisited if support for multiple ftrace entry points
+		 * is added in the future, but for now, the pr_err() below
+		 * deals with a theoretical issue only.
+		 */
+		tramp = (unsigned long *)mod->arch.ftrace_trampoline->sh_addr;
+		if (tramp[0] != addr) {
+			if (tramp[0] != 0) {
+				pr_err("ftrace: far branches to multiple entry points unsupported inside a single module\n");
+				return AARCH64_BREAK_FAULT;
+			}
+
+			/* point the trampoline to our ftrace entry point */
+			module_disable_ro(mod);
+			tramp[0] = addr;
+			module_enable_ro(mod, true);
+		}
+		addr = (unsigned long)&tramp[1];
+	}
+	return aarch64_insn_gen_branch_imm(pc, addr, AARCH64_INSN_BRANCH_LINK);
+}
+
 /*
  * Turn on the call to ftrace_caller() in instrumented function
  */
@@ -72,7 +119,7 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 	u32 old, new;
 
 	old = aarch64_insn_gen_nop();
-	new = aarch64_insn_gen_branch_imm(pc, addr, AARCH64_INSN_BRANCH_LINK);
+	new = __ftrace_gen_branch(pc, addr);
 
 	return ftrace_modify_code(pc, old, new, true);
 }
@@ -87,8 +134,7 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
 	u32 old = 0, new;
 
 	if (!IS_ENABLED(CONFIG_ARM64_MODULE_PLTS))
-		old = aarch64_insn_gen_branch_imm(pc, addr,
-						  AARCH64_INSN_BRANCH_LINK);
+		old = __ftrace_gen_branch(pc, addr);
 	new = aarch64_insn_gen_nop();
 
 	return ftrace_modify_code(pc, old, new,
diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
index d05dbe658409..b469c504d688 100644
--- a/arch/arm64/kernel/module-plts.c
+++ b/arch/arm64/kernel/module-plts.c
@@ -167,6 +167,10 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 			mod->arch.init.plt = sechdrs + i;
 		else if (sechdrs[i].sh_type == SHT_SYMTAB)
 			syms = (Elf64_Sym *)sechdrs[i].sh_addr;
+		else if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE) &&
+			 strcmp(".text.ftrace_trampoline",
+				secstrings + sechdrs[i].sh_name) == 0)
+			mod->arch.ftrace_trampoline = sechdrs + i;
 	}
 
 	if (!mod->arch.core.plt || !mod->arch.init.plt) {
@@ -178,6 +182,12 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 		return -ENOEXEC;
 	}
 
+	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE) && !mod->arch.ftrace_trampoline) {
+		pr_err("%s: module ftrace trampoline section missing\n",
+		       mod->name);
+		return -ENOEXEC;
+	}
+
 	for (i = 0; i < ehdr->e_shnum; i++) {
 		Elf64_Rela *rels = (void *)ehdr + sechdrs[i].sh_offset;
 		int numrels = sechdrs[i].sh_size / sizeof(Elf64_Rela);
-- 
2.9.3
