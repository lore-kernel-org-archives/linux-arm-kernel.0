From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed,  4 Jul 2018 10:36:49 +0200
Subject: [PATCH v10 4/6] init: allow initcall tables to be emitted using
 relative references
In-Reply-To: <20180704083651.24360-1-ard.biesheuvel@linaro.org>
References: <20180704083651.24360-1-ard.biesheuvel@linaro.org>
Message-ID: <20180704083651.24360-5-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow the initcall tables to be emitted using relative references that
are only half the size on 64-bit architectures and don't require fixups
at runtime on relocatable kernels.

Acked-by: James Morris <james.morris@microsoft.com>
Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Acked-by: Petr Mladek <pmladek@suse.com>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Acked-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 include/linux/init.h   | 44 +++++++++++++++-----
 init/main.c            | 32 +++++++-------
 kernel/printk/printk.c | 16 +++----
 security/security.c    | 17 ++++----
 4 files changed, 68 insertions(+), 41 deletions(-)

diff --git a/include/linux/init.h b/include/linux/init.h
index bc27cf03c41e..2538d176dd1f 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -116,8 +116,24 @@
 typedef int (*initcall_t)(void);
 typedef void (*exitcall_t)(void);
 
-extern initcall_t __con_initcall_start[], __con_initcall_end[];
-extern initcall_t __security_initcall_start[], __security_initcall_end[];
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+typedef int initcall_entry_t;
+
+static inline initcall_t initcall_from_entry(initcall_entry_t *entry)
+{
+	return offset_to_ptr(entry);
+}
+#else
+typedef initcall_t initcall_entry_t;
+
+static inline initcall_t initcall_from_entry(initcall_entry_t *entry)
+{
+	return *entry;
+}
+#endif
+
+extern initcall_entry_t __con_initcall_start[], __con_initcall_end[];
+extern initcall_entry_t __security_initcall_start[], __security_initcall_end[];
 
 /* Used for contructor calls. */
 typedef void (*ctor_fn_t)(void);
@@ -167,9 +183,20 @@ extern bool initcall_debug;
  * as KEEP() in the linker script.
  */
 
-#define __define_initcall(fn, id) \
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+#define ___define_initcall(fn, id, __sec)			\
+	__ADDRESSABLE(fn)					\
+	asm(".section	\"" #__sec ".init\", \"a\"	\n"	\
+	"__initcall_" #fn #id ":			\n"	\
+	    ".long	" #fn " - .			\n"	\
+	    ".previous					\n");
+#else
+#define ___define_initcall(fn, id, __sec) \
 	static initcall_t __initcall_##fn##id __used \
-	__attribute__((__section__(".initcall" #id ".init"))) = fn;
+		__attribute__((__section__(#__sec ".init"))) = fn;
+#endif
+
+#define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
 
 /*
  * Early initcalls run before initializing SMP.
@@ -208,13 +235,8 @@ extern bool initcall_debug;
 #define __exitcall(fn)						\
 	static exitcall_t __exitcall_##fn __exit_call = fn
 
-#define console_initcall(fn)					\
-	static initcall_t __initcall_##fn			\
-	__used __section(.con_initcall.init) = fn
-
-#define security_initcall(fn)					\
-	static initcall_t __initcall_##fn			\
-	__used __section(.security_initcall.init) = fn
+#define console_initcall(fn)	___define_initcall(fn,, .con_initcall)
+#define security_initcall(fn)	___define_initcall(fn,, .security_initcall)
 
 struct obs_kernel_param {
 	const char *str;
diff --git a/init/main.c b/init/main.c
index 3b4ada11ed52..e59a01f163d6 100644
--- a/init/main.c
+++ b/init/main.c
@@ -901,18 +901,18 @@ int __init_or_module do_one_initcall(initcall_t fn)
 }
 
 
-extern initcall_t __initcall_start[];
-extern initcall_t __initcall0_start[];
-extern initcall_t __initcall1_start[];
-extern initcall_t __initcall2_start[];
-extern initcall_t __initcall3_start[];
-extern initcall_t __initcall4_start[];
-extern initcall_t __initcall5_start[];
-extern initcall_t __initcall6_start[];
-extern initcall_t __initcall7_start[];
-extern initcall_t __initcall_end[];
-
-static initcall_t *initcall_levels[] __initdata = {
+extern initcall_entry_t __initcall_start[];
+extern initcall_entry_t __initcall0_start[];
+extern initcall_entry_t __initcall1_start[];
+extern initcall_entry_t __initcall2_start[];
+extern initcall_entry_t __initcall3_start[];
+extern initcall_entry_t __initcall4_start[];
+extern initcall_entry_t __initcall5_start[];
+extern initcall_entry_t __initcall6_start[];
+extern initcall_entry_t __initcall7_start[];
+extern initcall_entry_t __initcall_end[];
+
+static initcall_entry_t *initcall_levels[] __initdata = {
 	__initcall0_start,
 	__initcall1_start,
 	__initcall2_start,
@@ -938,7 +938,7 @@ static char *initcall_level_names[] __initdata = {
 
 static void __init do_initcall_level(int level)
 {
-	initcall_t *fn;
+	initcall_entry_t *fn;
 
 	strcpy(initcall_command_line, saved_command_line);
 	parse_args(initcall_level_names[level],
@@ -949,7 +949,7 @@ static void __init do_initcall_level(int level)
 
 	trace_initcall_level(initcall_level_names[level]);
 	for (fn = initcall_levels[level]; fn < initcall_levels[level+1]; fn++)
-		do_one_initcall(*fn);
+		do_one_initcall(initcall_from_entry(fn));
 }
 
 static void __init do_initcalls(void)
@@ -980,11 +980,11 @@ static void __init do_basic_setup(void)
 
 static void __init do_pre_smp_initcalls(void)
 {
-	initcall_t *fn;
+	initcall_entry_t *fn;
 
 	trace_initcall_level("early");
 	for (fn = __initcall_start; fn < __initcall0_start; fn++)
-		do_one_initcall(*fn);
+		do_one_initcall(initcall_from_entry(fn));
 }
 
 /*
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 247808333ba4..688a27b0888c 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2772,7 +2772,8 @@ EXPORT_SYMBOL(unregister_console);
 void __init console_init(void)
 {
 	int ret;
-	initcall_t *call;
+	initcall_t call;
+	initcall_entry_t *ce;
 
 	/* Setup the default TTY line discipline. */
 	n_tty_init();
@@ -2781,13 +2782,14 @@ void __init console_init(void)
 	 * set up the console device so that later boot sequences can
 	 * inform about problems etc..
 	 */
-	call = __con_initcall_start;
+	ce = __con_initcall_start;
 	trace_initcall_level("console");
-	while (call < __con_initcall_end) {
-		trace_initcall_start((*call));
-		ret = (*call)();
-		trace_initcall_finish((*call), ret);
-		call++;
+	while (ce < __con_initcall_end) {
+		call = initcall_from_entry(ce);
+		trace_initcall_start(call);
+		ret = call();
+		trace_initcall_finish(call, ret);
+		ce++;
 	}
 }
 
diff --git a/security/security.c b/security/security.c
index 68f46d849abe..1e7b1486d82a 100644
--- a/security/security.c
+++ b/security/security.c
@@ -48,14 +48,17 @@ static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
 static void __init do_security_initcalls(void)
 {
 	int ret;
-	initcall_t *call;
-	call = __security_initcall_start;
+	initcall_t call;
+	initcall_entry_t *ce;
+
+	ce = __security_initcall_start;
 	trace_initcall_level("security");
-	while (call < __security_initcall_end) {
-		trace_initcall_start((*call));
-		ret = (*call) ();
-		trace_initcall_finish((*call), ret);
-		call++;
+	while (ce < __security_initcall_end) {
+		call = initcall_from_entry(ce);
+		trace_initcall_start(call);
+		ret = call();
+		trace_initcall_finish(call, ret);
+		ce++;
 	}
 }
 
-- 
2.17.1
