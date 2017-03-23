From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 23 Mar 2017 18:18:41 +0000
Subject: [PATCH] arm64: relocation testing module
Message-ID: <20170323181841.6800-1-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This module tests the module loader's ELF relocation processing
routines. When loaded, it logs output like below.

    Relocation test:
    -------------------------------------------------------
    R_AARCH64_ABS64                 0xffff880000cccccc pass
    R_AARCH64_ABS32                 0x00000000f800cccc pass
    R_AARCH64_ABS16                 0x000000000000f8cc pass
    R_AARCH64_MOVW_SABS_Gn          0xffff880000cccccc pass
    R_AARCH64_MOVW_UABS_Gn          0xffff880000cccccc pass
    R_AARCH64_ADR_PREL_LO21         0xffffff9cf4d1a400 pass
    R_AARCH64_PREL64                0xffffff9cf4d1a400 pass
    R_AARCH64_PREL32                0xffffff9cf4d1a400 pass
    R_AARCH64_PREL16                0xffffff9cf4d1a400 pass

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/Kconfig.debug            |  4 ++
 arch/arm64/kernel/Makefile          |  2 +
 arch/arm64/kernel/reloc_test_core.c | 79 +++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/reloc_test_syms.S | 83 +++++++++++++++++++++++++++++++++++++
 4 files changed, 168 insertions(+)
 create mode 100644 arch/arm64/kernel/reloc_test_core.c
 create mode 100644 arch/arm64/kernel/reloc_test_syms.S

diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
index b661fe742615..5b0c07cbe766 100644
--- a/arch/arm64/Kconfig.debug
+++ b/arch/arm64/Kconfig.debug
@@ -62,6 +62,10 @@ config DEBUG_ALIGN_RODATA
 
 	  If in doubt, say N.
 
+config ARM64_RELOC_TEST
+	depends on m
+	tristate "Relocation testing module"
+
 source "drivers/hwtracing/coresight/Kconfig"
 
 endmenu
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 7d66bbaafc0c..38d67a5db973 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -50,6 +50,8 @@ arm64-obj-$(CONFIG_RANDOMIZE_BASE)	+= kaslr.o
 arm64-obj-$(CONFIG_HIBERNATION)		+= hibernate.o hibernate-asm.o
 arm64-obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o	\
 					   cpu-reset.o
+arm64-obj-$(CONFIG_ARM64_RELOC_TEST)	+= arm64-reloc-test.o
+arm64-reloc-test-y := reloc_test_core.o reloc_test_syms.o
 
 obj-y					+= $(arm64-obj-y) vdso/ probes/
 obj-m					+= $(arm64-obj-m)
diff --git a/arch/arm64/kernel/reloc_test_core.c b/arch/arm64/kernel/reloc_test_core.c
new file mode 100644
index 000000000000..22d84fdb6d98
--- /dev/null
+++ b/arch/arm64/kernel/reloc_test_core.c
@@ -0,0 +1,79 @@
+/*
+ * Copyright (C) 2016 Linaro Ltd;  <ard.biesheuvel@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/module.h>
+
+int sym64_rel;
+
+#define SYM64_ABS_VAL		0xffff880000cccccc
+#define SYM32_ABS_VAL		0xf800cccc
+#define SYM16_ABS_VAL		0xf8cc
+
+#define __SET_ABS(name, val)	asm(".globl " #name "; .set "#name ", " #val)
+#define SET_ABS(name, val)	__SET_ABS(name, val)
+
+SET_ABS(sym64_abs, SYM64_ABS_VAL);
+SET_ABS(sym32_abs, SYM32_ABS_VAL);
+SET_ABS(sym16_abs, SYM16_ABS_VAL);
+
+asmlinkage u64 absolute_data64(void);
+asmlinkage u64 absolute_data32(void);
+asmlinkage u64 absolute_data16(void);
+asmlinkage u64 signed_movw(void);
+asmlinkage u64 unsigned_movw(void);
+asmlinkage u64 relative_adrp(void);
+asmlinkage u64 relative_adr(void);
+asmlinkage u64 relative_data64(void);
+asmlinkage u64 relative_data32(void);
+asmlinkage u64 relative_data16(void);
+
+static struct {
+	char	name[32];
+	u64	(*f)(void);
+	u64	expect;
+} const funcs[] = {
+	{ "R_AARCH64_ABS64",		absolute_data64, UL(SYM64_ABS_VAL) },
+	{ "R_AARCH64_ABS32",		absolute_data32, UL(SYM32_ABS_VAL) },
+	{ "R_AARCH64_ABS16",		absolute_data16, UL(SYM16_ABS_VAL) },
+	{ "R_AARCH64_MOVW_SABS_Gn",	signed_movw, UL(SYM64_ABS_VAL) },
+	{ "R_AARCH64_MOVW_UABS_Gn",	unsigned_movw, UL(SYM64_ABS_VAL) },
+#ifndef CONFIG_ARM64_ERRATUM_843419
+	{ "R_AARCH64_ADR_PREL_PG_HI21",	relative_adrp, (u64)&sym64_rel },
+#endif
+	{ "R_AARCH64_ADR_PREL_LO21",	relative_adr, (u64)&sym64_rel },
+	{ "R_AARCH64_PREL64",		relative_data64, (u64)&sym64_rel },
+	{ "R_AARCH64_PREL32",		relative_data32, (u64)&sym64_rel },
+	{ "R_AARCH64_PREL16",		relative_data16, (u64)&sym64_rel },
+};
+
+static int reloc_test_init(void)
+{
+	int i;
+
+	pr_info("Relocation test:\n");
+	pr_info("-------------------------------------------------------\n");
+
+	for (i = 0; i < ARRAY_SIZE(funcs); i++) {
+		u64 ret = funcs[i].f();
+
+		pr_info("%-31s 0x%016llx %s\n", funcs[i].name, ret,
+			ret == funcs[i].expect ? "pass" : "fail");
+		if (ret != funcs[i].expect)
+			pr_err("Relocation failed, expected 0x%016llx, not 0x%016llx\n",
+			       funcs[i].expect, ret);
+	}
+	return 0;
+}
+
+static void reloc_test_exit(void)
+{
+}
+
+module_init(reloc_test_init);
+module_exit(reloc_test_exit);
diff --git a/arch/arm64/kernel/reloc_test_syms.S b/arch/arm64/kernel/reloc_test_syms.S
new file mode 100644
index 000000000000..b01732802e7d
--- /dev/null
+++ b/arch/arm64/kernel/reloc_test_syms.S
@@ -0,0 +1,83 @@
+/*
+ * Copyright (C) 2016 Linaro Ltd;  <ard.biesheuvel@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/linkage.h>
+
+ENTRY(absolute_data64)
+	ldr	x0, 0f
+	ret
+0:	.quad	sym64_abs
+ENDPROC(absolute_data64)
+
+ENTRY(absolute_data32)
+	ldr	w0, 0f
+	ret
+0:	.long	sym32_abs
+ENDPROC(absolute_data32)
+
+ENTRY(absolute_data16)
+	adr	x0, 0f
+	ldrh	w0, [x0]
+	ret
+0:	.short	sym16_abs, 0
+ENDPROC(absolute_data16)
+
+ENTRY(signed_movw)
+	movz	x0, #:abs_g2_s:sym64_abs
+	movk	x0, #:abs_g1_nc:sym64_abs
+	movk	x0, #:abs_g0_nc:sym64_abs
+	ret
+ENDPROC(signed_movw)
+
+ENTRY(unsigned_movw)
+	movz	x0, #:abs_g3:sym64_abs
+	movk	x0, #:abs_g2_nc:sym64_abs
+	movk	x0, #:abs_g1_nc:sym64_abs
+	movk	x0, #:abs_g0_nc:sym64_abs
+	ret
+ENDPROC(unsigned_movw)
+
+#ifndef CONFIG_ARM64_ERRATUM_843419
+
+ENTRY(relative_adrp)
+	adrp	x0, sym64_rel
+	add	x0, x0, #:lo12:sym64_rel
+	ret
+ENDPROC(relative_adrp)
+
+#endif
+
+ENTRY(relative_adr)
+	adr	x0, sym64_rel
+	ret
+ENDPROC(relative_adr)
+
+ENTRY(relative_data64)
+	adr	x1, 0f
+	ldr	x0, [x1]
+	add	x0, x0, x1
+	ret
+0:	.quad	sym64_rel - .
+ENDPROC(relative_data64)
+
+ENTRY(relative_data32)
+	adr	x1, 0f
+	ldr	w0, [x1]
+	add	x0, x0, x1
+	ret
+0:	.long	sym64_rel - .
+ENDPROC(relative_data32)
+
+ENTRY(relative_data16)
+	adr	x1, 0f
+	ldrsh	w0, [x1]
+	add	x0, x0, x1
+	ret
+0:	.short	sym64_rel - ., 0
+ENDPROC(relative_data16)
-- 
2.9.3
