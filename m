From: arnd@arndb.de (Arnd Bergmann)
Date: Fri,  9 Jun 2017 12:27:06 +0200
Subject: [PATCH] arm64: ftrace: fix building without CONFIG_MODULES
Message-ID: <20170609102807.2992510-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When CONFIG_MODULES is disabled, we cannot dereference a module pointer:

arch/arm64/kernel/ftrace.c: In function 'ftrace_make_call':
arch/arm64/kernel/ftrace.c:107:36: error: dereferencing pointer to incomplete type 'struct module'
   trampoline = (unsigned long *)mod->arch.ftrace_trampoline;

Also, the within_module() function is not defined:

arch/arm64/kernel/ftrace.c: In function 'ftrace_make_nop':
arch/arm64/kernel/ftrace.c:171:8: error: implicit declaration of function 'within_module'; did you mean 'init_module'? [-Werror=implicit-function-declaration]

This addresses both by adding the appropriate stubs.

Fixes: e71a4e1bebaf ("arm64: ftrace: add support for far branches to dynamic ftrace")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/include/asm/module.h | 6 ++++++
 arch/arm64/kernel/ftrace.c      | 2 +-
 include/linux/module.h          | 5 +++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/module.h
index 19bd97671bb8..ca5d024f4247 100644
--- a/arch/arm64/include/asm/module.h
+++ b/arch/arm64/include/asm/module.h
@@ -36,6 +36,12 @@ struct mod_arch_specific {
 };
 #endif
 
+#if defined(CONFIG_MODULES) && defined(CONFIG_ARM64_MODULE_PLTS)
+#define module_ftrace_trampoline(mod) ((mod)->arch.ftrace_trampoline)
+#else
+#define module_ftrace_trampoline(mod) NULL
+#endif
+
 u64 module_emit_plt_entry(struct module *mod, void *loc, const Elf64_Rela *rela,
 			  Elf64_Sym *sym);
 
diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index 8a42be0693c9..7f5eb9939a55 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -104,7 +104,7 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 		 * is added in the future, but for now, the pr_err() below
 		 * deals with a theoretical issue only.
 		 */
-		trampoline = (unsigned long *)mod->arch.ftrace_trampoline;
+		trampoline = module_ftrace_trampoline(mod);
 		if (trampoline[0] != addr) {
 			if (trampoline[0] != 0) {
 				pr_err("ftrace: far branches to multiple entry points unsupported inside a single module\n");
diff --git a/include/linux/module.h b/include/linux/module.h
index 21f56393602f..9196f532f158 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -671,6 +671,11 @@ static inline bool is_module_text_address(unsigned long addr)
 	return false;
 }
 
+static inline bool within_module(unsigned long addr, const struct module *mod)
+{
+	return false;
+}
+
 /* Get/put a kernel symbol (calls should be symmetric) */
 #define symbol_get(x) ({ extern typeof(x) x __attribute__((weak)); &(x); })
 #define symbol_put(x) do { } while (0)
-- 
2.9.0
