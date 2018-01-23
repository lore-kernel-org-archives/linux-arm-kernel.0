From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 23 Jan 2018 13:03:01 +0000
Subject: [RFC/RFT PATCH 1/2] gcc-plugins: add support plugin for arm64
 per-task stack canaries
In-Reply-To: <20180123130302.29409-1-ard.biesheuvel@linaro.org>
References: <20180123130302.29409-1-ard.biesheuvel@linaro.org>
Message-ID: <20180123130302.29409-2-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By default, GCC for AArch64 uses a global variable __stack_chk_guard
which is shared between all CPUs, and hence between all tasks, which
means the stack canary value only changes between reboots.

This plugin renames the symbol to __stack_chk_guard_tsk_offset, and
adds an RTL pass to replace the first instruction in each adrp/add pair
referring to the symbol with a load of sp_el0, which holds the address
of 'current'. In a subsequent patch, we will tweak the kernel build to
expose the offset of the stack_canary field in task_struct via the
symbol, so that the resulting reference resolves to the task's unique
canary value directly.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/Kconfig                                    |   4 +
 scripts/Makefile.gcc-plugins                    |   2 +
 scripts/gcc-plugins/arm64_ssp_per_task_plugin.c | 121 ++++++++++++++++++++
 3 files changed, 127 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 400b9e1b2f27..e7f110a89a91 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -517,6 +517,10 @@ config GCC_PLUGIN_RANDSTRUCT_PERFORMANCE
 	  in structures.  This reduces the performance hit of RANDSTRUCT
 	  at the cost of weakened randomization.
 
+config GCC_PLUGIN_ARM64_SSP_PER_TASK
+	bool
+	depends on GCC_PLUGINS
+
 config HAVE_CC_STACKPROTECTOR
 	bool
 	help
diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
index b2a95af7df18..aa1ca74b3d70 100644
--- a/scripts/Makefile.gcc-plugins
+++ b/scripts/Makefile.gcc-plugins
@@ -35,6 +35,8 @@ ifdef CONFIG_GCC_PLUGINS
   gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_RANDSTRUCT)	+= -DRANDSTRUCT_PLUGIN
   gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_RANDSTRUCT_PERFORMANCE)	+= -fplugin-arg-randomize_layout_plugin-performance-mode
 
+  gcc-plugin-$(CONFIG_GCC_PLUGIN_ARM64_SSP_PER_TASK) += arm64_ssp_per_task_plugin.so
+
   GCC_PLUGINS_CFLAGS := $(strip $(addprefix -fplugin=$(objtree)/scripts/gcc-plugins/, $(gcc-plugin-y)) $(gcc-plugin-cflags-y))
 
   export PLUGINCC GCC_PLUGINS_CFLAGS GCC_PLUGIN GCC_PLUGIN_SUBDIR
diff --git a/scripts/gcc-plugins/arm64_ssp_per_task_plugin.c b/scripts/gcc-plugins/arm64_ssp_per_task_plugin.c
new file mode 100644
index 000000000000..611036a459c3
--- /dev/null
+++ b/scripts/gcc-plugins/arm64_ssp_per_task_plugin.c
@@ -0,0 +1,121 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2018 Ard Biesheuvel <ard.biesheuvel@linaro.org>
+ */
+
+#include "gcc-common.h"
+
+__visible int plugin_is_GPL_compatible;
+
+static GTY(()) tree stack_chk_guard_decl;
+
+static void init_stack_chk_guard_decl(void)
+{
+	tree t;
+	rtx x;
+
+	t = build_decl (UNKNOWN_LOCATION,
+			VAR_DECL,
+			get_identifier ("__stack_chk_guard_tsk_offset"),
+			ptr_type_node);
+	TREE_STATIC (t) = 1;
+	TREE_PUBLIC (t) = 1;
+	DECL_EXTERNAL (t) = 1;
+	TREE_USED (t) = 1;
+	TREE_THIS_VOLATILE (t) = 1;
+	DECL_ARTIFICIAL (t) = 1;
+	DECL_IGNORED_P (t) = 1;
+
+	/* Do not share RTL as the declaration is visible outside of
+	   current function.  */
+	x = DECL_RTL (t);
+	RTX_FLAG (x, used) = 1;
+
+	stack_chk_guard_decl = t;
+}
+
+static tree arm64_pertask_ssp_stack_protect_guard(void)
+{
+	if (stack_chk_guard_decl == NULL);
+		init_stack_chk_guard_decl();
+	return stack_chk_guard_decl;
+}
+
+static bool arm64_pertask_ssp_rtl_gate(void)
+{
+	return true;
+}
+
+static unsigned int arm64_pertask_ssp_rtl_execute(void)
+{
+	rtx_insn *insn, *next;
+	int regno;
+
+	for (insn = get_insns(); insn; insn = next) {
+		const char *sym;
+		rtx body;
+
+		//
+		// Find a SET insn involving a HIGH SYMBOL_REF to
+		// __stack_chk_guard_tsk_offset
+		//
+		next = NEXT_INSN(insn);
+		if (!INSN_P(insn))
+			continue;
+		body = PATTERN(insn);
+		if (GET_CODE(body) != SET ||
+		    GET_CODE(SET_SRC(body)) != HIGH ||
+		    GET_CODE(XEXP(SET_SRC (body), 0)) != SYMBOL_REF)
+			continue;
+		if (!REG_P(SET_DEST(body)))
+			continue;
+		sym = XSTR(XEXP(SET_SRC (body), 0), 0);
+		if (strcmp(sym, "__stack_chk_guard_tsk_offset"))
+			continue;
+		regno = REGNO(SET_DEST(body));
+
+		//
+		// We have found the ADRP assignment of the relative address
+		// of __stack_chk_guard_tsk_offset. Replace it with an asm
+		// expression returning the value of sp_el0 into the same
+		// register.
+		//
+		SET_SRC(body) = gen_rtx_ASM_OPERANDS(Pmode,
+						     "mrs %0, sp_el0",
+						     "=r",
+						     regno,
+						     rtvec_alloc (0),
+						     rtvec_alloc (0),
+						     rtvec_alloc (0),
+						     UNKNOWN_LOCATION);
+	}
+	return 0;
+}
+
+#define PASS_NAME arm64_pertask_ssp_rtl
+#define TODO_FLAGS_FINISH TODO_dump_func
+#include "gcc-generate-rtl-pass.h"
+
+static void arm64_pertask_ssp_start_unit(void *gcc_data, void *user_data)
+{
+	targetm.stack_protect_guard = arm64_pertask_ssp_stack_protect_guard;
+}
+
+__visible int plugin_init(struct plugin_name_args *plugin_info,
+			  struct plugin_gcc_version *version)
+{
+	if (!plugin_default_version_check(version, &gcc_version)) {
+		error(G_("incompatible gcc/plugin versions"));
+		return 1;
+	}
+
+	PASS_INFO(arm64_pertask_ssp_rtl, "final", 1, PASS_POS_INSERT_BEFORE);
+
+	register_callback(plugin_info->base_name, PLUGIN_START_UNIT,
+			  arm64_pertask_ssp_start_unit, NULL);
+
+	register_callback(plugin_info->base_name, PLUGIN_PASS_MANAGER_SETUP,
+			  NULL, &arm64_pertask_ssp_rtl_pass_info);
+
+	return 0;
+}
-- 
2.11.0
