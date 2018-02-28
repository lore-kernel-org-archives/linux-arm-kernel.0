From: alex.shi@linaro.org (Alex Shi)
Date: Wed, 28 Feb 2018 11:56:30 +0800
Subject: [PATCH 08/29] module: extend 'rodata=off' boot cmdline parameter to
 module mappings
In-Reply-To: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
Message-ID: <1519790211-16582-9-git-send-email-alex.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

commit 39290b389ea upstream.

The current "rodata=off" parameter disables read-only kernel mappings
under CONFIG_DEBUG_RODATA:
    commit d2aa1acad22f ("mm/init: Add 'rodata=off' boot cmdline parameter
    to disable read-only kernel mappings")

This patch is a logical extension to module mappings ie. read-only mappings
at module loading can be disabled even if CONFIG_DEBUG_SET_MODULE_RONX
(mainly for debug use). Please note, however, that it only affects RO/RW
permissions, keeping NX set.

This is the first step to make CONFIG_DEBUG_SET_MODULE_RONX mandatory
(always-on) in the future as CONFIG_DEBUG_RODATA on x86 and arm64.

Suggested-by: and Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Rusty Russell <rusty@rustcorp.com.au>
Link: http://lkml.kernel.org/r/20161114061505.15238-1-takahiro.akashi at linaro.org
Signed-off-by: Jessica Yu <jeyu@redhat.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>

Conflicts:
	keeping kaiser.h in init/main.c
---
 include/linux/init.h |  3 +++
 init/main.c          |  7 +++++--
 kernel/module.c      | 20 +++++++++++++++++---
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/include/linux/init.h b/include/linux/init.h
index 8e346d1..4dfe300 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -133,6 +133,9 @@ void prepare_namespace(void);
 void __init load_default_modules(void);
 int __init init_rootfs(void);
 
+#if defined(CONFIG_DEBUG_RODATA) || defined(CONFIG_DEBUG_SET_MODULE_RONX)
+extern bool rodata_enabled;
+#endif
 #ifdef CONFIG_DEBUG_RODATA
 void mark_rodata_ro(void);
 #endif
diff --git a/init/main.c b/init/main.c
index 99f0265..f22957a 100644
--- a/init/main.c
+++ b/init/main.c
@@ -81,6 +81,7 @@
 #include <linux/proc_ns.h>
 #include <linux/io.h>
 #include <linux/kaiser.h>
+#include <linux/cache.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -914,14 +915,16 @@ static int try_to_run_init_process(const char *init_filename)
 
 static noinline void __init kernel_init_freeable(void);
 
-#ifdef CONFIG_DEBUG_RODATA
-static bool rodata_enabled = true;
+#if defined(CONFIG_DEBUG_RODATA) || defined(CONFIG_SET_MODULE_RONX)
+bool rodata_enabled __ro_after_init = true;
 static int __init set_debug_rodata(char *str)
 {
 	return strtobool(str, &rodata_enabled);
 }
 __setup("rodata=", set_debug_rodata);
+#endif
 
+#ifdef CONFIG_DEBUG_RODATA
 static void mark_readonly(void)
 {
 	if (rodata_enabled)
diff --git a/kernel/module.c b/kernel/module.c
index 07bfb99..0651f2d 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1911,6 +1911,9 @@ static void frob_writable_data(const struct module_layout *layout,
 /* livepatching wants to disable read-only so it can frob module. */
 void module_disable_ro(const struct module *mod)
 {
+	if (!rodata_enabled)
+		return;
+
 	frob_text(&mod->core_layout, set_memory_rw);
 	frob_rodata(&mod->core_layout, set_memory_rw);
 	frob_ro_after_init(&mod->core_layout, set_memory_rw);
@@ -1920,6 +1923,9 @@ void module_disable_ro(const struct module *mod)
 
 void module_enable_ro(const struct module *mod, bool after_init)
 {
+	if (!rodata_enabled)
+		return;
+
 	frob_text(&mod->core_layout, set_memory_ro);
 	frob_rodata(&mod->core_layout, set_memory_ro);
 	frob_text(&mod->init_layout, set_memory_ro);
@@ -1952,6 +1958,9 @@ void set_all_modules_text_rw(void)
 {
 	struct module *mod;
 
+	if (!rodata_enabled)
+		return;
+
 	mutex_lock(&module_mutex);
 	list_for_each_entry_rcu(mod, &modules, list) {
 		if (mod->state == MODULE_STATE_UNFORMED)
@@ -1968,6 +1977,9 @@ void set_all_modules_text_ro(void)
 {
 	struct module *mod;
 
+	if (!rodata_enabled)
+		return;
+
 	mutex_lock(&module_mutex);
 	list_for_each_entry_rcu(mod, &modules, list) {
 		if (mod->state == MODULE_STATE_UNFORMED)
@@ -1981,10 +1993,12 @@ void set_all_modules_text_ro(void)
 
 static void disable_ro_nx(const struct module_layout *layout)
 {
-	frob_text(layout, set_memory_rw);
-	frob_rodata(layout, set_memory_rw);
+	if (rodata_enabled) {
+		frob_text(layout, set_memory_rw);
+		frob_rodata(layout, set_memory_rw);
+		frob_ro_after_init(layout, set_memory_rw);
+	}
 	frob_rodata(layout, set_memory_x);
-	frob_ro_after_init(layout, set_memory_rw);
 	frob_ro_after_init(layout, set_memory_x);
 	frob_writable_data(layout, set_memory_x);
 }
-- 
2.7.4
