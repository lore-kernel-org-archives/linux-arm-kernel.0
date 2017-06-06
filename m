From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue,  6 Jun 2017 17:00:22 +0000
Subject: [PATCH v3 2/2] arm64: ftrace: add support for far branches to dynamic
 ftrace
In-Reply-To: <20170606170022.11461-1-ard.biesheuvel@linaro.org>
References: <20170606170022.11461-1-ard.biesheuvel@linaro.org>
Message-ID: <20170606170022.11461-3-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, dynamic ftrace support in the arm64 kernel assumes that all
core kernel code is within range of ordinary branch instructions that
occur in module code, which is usually the case, but is no longer
guaranteed now that we have support for module PLTs and address space
randomization.

Since on arm64, all patching of branch instructions involves function
calls to the same entry point [ftrace_caller()], we can emit the modules
with a trampoline that has unlimited range, and patch both the trampoline
itself and the branch instruction to redirect the call via the trampoline.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/Kconfig              |  2 +-
 arch/arm64/Makefile             |  3 ++
 arch/arm64/include/asm/module.h |  3 ++
 arch/arm64/kernel/Makefile      |  3 ++
 arch/arm64/kernel/ftrace-mod.S  | 18 +++++++
 arch/arm64/kernel/ftrace.c      | 51 ++++++++++++++++++++
 arch/arm64/kernel/module.c      |  6 ++-
 7 files changed, 84 insertions(+), 2 deletions(-)

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
index d57693f5d4ec..19bd97671bb8 100644
--- a/arch/arm64/include/asm/module.h
+++ b/arch/arm64/include/asm/module.h
@@ -30,6 +30,9 @@ struct mod_plt_sec {
 struct mod_arch_specific {
 	struct mod_plt_sec	core;
 	struct mod_plt_sec	init;
+
+	/* for CONFIG_DYNAMIC_FTRACE */
+	void			*ftrace_trampoline;
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
index 4cb576374b82..c23fa29883f8 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -10,10 +10,12 @@
  */
 
 #include <linux/ftrace.h>
+#include <linux/module.h>
 #include <linux/swab.h>
 #include <linux/uaccess.h>
 
 #include <asm/cacheflush.h>
+#include <asm/debug-monitors.h>
 #include <asm/ftrace.h>
 #include <asm/insn.h>
 
@@ -69,8 +71,57 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 {
 	unsigned long pc = rec->ip;
+	long offset = (long)pc - (long)addr;
 	u32 old, new;
 
+	if (IS_ENABLED(CONFIG_ARM64_MODULE_PLTS) &&
+	    (offset < -SZ_128M || offset >= SZ_128M)) {
+		unsigned long *trampoline;
+		struct module *mod;
+
+		/*
+		 * On kernels that support module PLTs, the offset between the
+		 * branch instruction and its target may legally exceed the
+		 * range of an ordinary relative 'bl' opcode. In this case, we
+		 * need to branch via a trampoline in the module.
+		 *
+		 * NOTE: __module_text_address() must be called with preemption
+		 * disabled, but we can rely on ftrace_lock to ensure that 'mod'
+		 * retains its validity throughout the remainder of this code.
+		 */
+		preempt_disable();
+		mod = __module_text_address(pc);
+		preempt_enable();
+
+		if (WARN_ON(!mod))
+			return -EINVAL;
+
+		/*
+		 * There is only one ftrace trampoline per module. For now,
+		 * this is not a problem since on arm64, all dynamic ftrace
+		 * invocations are routed via ftrace_caller(). This will need
+		 * to be revisited if support for multiple ftrace entry points
+		 * is added in the future, but for now, the pr_err() below
+		 * deals with a theoretical issue only.
+		 */
+		trampoline = (unsigned long *)mod->arch.ftrace_trampoline;
+		if (trampoline[0] != addr) {
+			if (trampoline[0] != 0) {
+				pr_err("ftrace: far branches to multiple entry points unsupported inside a single module\n");
+				return -EINVAL;
+			}
+
+			/* point the trampoline to our ftrace entry point */
+			module_disable_ro(mod);
+			trampoline[0] = addr;
+			module_enable_ro(mod, true);
+
+			/* update the trampoline before taking its address */
+			smp_wmb();
+		}
+		addr = (unsigned long)&trampoline[1];
+	}
+
 	old = aarch64_insn_gen_nop();
 	new = aarch64_insn_gen_branch_imm(pc, addr, AARCH64_INSN_BRANCH_LINK);
 
diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index f035ff6fb223..8c3a7264fb0f 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -420,8 +420,12 @@ int module_finalize(const Elf_Ehdr *hdr,
 	for (s = sechdrs, se = sechdrs + hdr->e_shnum; s < se; s++) {
 		if (strcmp(".altinstructions", secstrs + s->sh_name) == 0) {
 			apply_alternatives((void *)s->sh_addr, s->sh_size);
-			return 0;
 		}
+#ifdef CONFIG_ARM64_MODULE_PLTS
+		if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE) &&
+		    !strcmp(".text.ftrace_trampoline", secstrs + s->sh_name))
+			me->arch.ftrace_trampoline = (void *)s->sh_addr;
+#endif
 	}
 
 	return 0;
-- 
2.9.3
