From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Tue,  8 Apr 2014 00:04:11 -0700
Subject: [PATCH] systemtap: need to use kallsyms_lookup_funcptr with arm
 thumb2 kernel
In-Reply-To: <1396940651-19013-1-git-send-email-victor.kamensky@linaro.org>
References: <1396940651-19013-1-git-send-email-victor.kamensky@linaro.org>
Message-ID: <1396940651-19013-2-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thumb2 function pointer should have bit 0 set when called, even if
function text is aligned with 2 or 4 bytes. Current systemtap runtime
uses  kallsyms_lookup_name to get function pointer, cast it, and
calls it. It does not work in case of arm CONFIG_THUMB2_KERNEL.

The patch add simple wrapper on top of kallsyms_lookup_name, which
in case of CONFIG_THUMB2_KERNEL set bit 0 of returned function
address. In all other case it just returns result of
kallsyms_lookup_name call.

In case if/when kernel will provide similar to kallsyms_lookup_funcptr
functionality in kernel itself remove/rework this change.

Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
---
 runtime/linux/kallsyms_wrapper.h | 28 ++++++++++++++++++++++++++++
 runtime/linux/runtime.h          |  2 ++
 runtime/stp_task_work.c          |  4 ++--
 runtime/stp_utrace.c             |  6 +++---
 runtime/transport/transport.c    | 12 ++++++------
 5 files changed, 41 insertions(+), 11 deletions(-)
 create mode 100644 runtime/linux/kallsyms_wrapper.h

diff --git a/runtime/linux/kallsyms_wrapper.h b/runtime/linux/kallsyms_wrapper.h
new file mode 100644
index 0000000..9e698ab
--- /dev/null
+++ b/runtime/linux/kallsyms_wrapper.h
@@ -0,0 +1,28 @@
+#ifndef _KALLSYMS_WRAPPER_H
+#define _KALLSYMS_WRAPPER_H
+
+/*
+ * Copyright (C) 2011 Avik Sil (avik.sil at linaro.org)
+ *
+ * wrapper around kallsyms_lookup_name. Implements arch-dependent code for
+ * arches where the address of the start of the function body is different
+ * from the pointer which can be used to call the function, e.g. ARM THUMB2.
+ *
+ * Dual LGPL v2.1/GPL v2 license.
+*/
+
+static inline
+unsigned long kallsyms_lookup_funcptr(const char *name)
+{
+       unsigned long addr;
+
+       addr = kallsyms_lookup_name(name);
+#ifdef CONFIG_ARM
+#ifdef CONFIG_THUMB2_KERNEL
+       if (addr)
+               addr |= 1; /* set bit 0 in address for thumb mode */
+#endif
+#endif
+       return addr;
+}
+#endif /* _KALLSYMS_WRAPPER_H */
diff --git a/runtime/linux/runtime.h b/runtime/linux/runtime.h
index 76dbea4..0ae1ffa 100644
--- a/runtime/linux/runtime.h
+++ b/runtime/linux/runtime.h
@@ -190,6 +190,8 @@ static void *kallsyms_signal_wake_up;
 static void *kallsyms___lock_task_sighand;
 #endif
 
+#include "kallsyms_wrapper.h"
+
 #include "access_process_vm.h"
 #include "loc2c-runtime.h"
 
diff --git a/runtime/stp_task_work.c b/runtime/stp_task_work.c
index 93f56a5..246d648 100644
--- a/runtime/stp_task_work.c
+++ b/runtime/stp_task_work.c
@@ -25,12 +25,12 @@ stp_task_work_init(void)
 #if !defined(STAPCONF_TASK_WORK_ADD_EXPORTED)
 	/* The task_work_add()/task_work_cancel() functions aren't
 	 * exported. Look up those function addresses. */
-        kallsyms_task_work_add = (void *)kallsyms_lookup_name("task_work_add");
+        kallsyms_task_work_add = (void *)kallsyms_lookup_funcptr("task_work_add");
         if (kallsyms_task_work_add == NULL) {
 		_stp_error("Can't resolve task_work_add!");
 		return -ENOENT;
         }
-        kallsyms_task_work_cancel = (void *)kallsyms_lookup_name("task_work_cancel");
+        kallsyms_task_work_cancel = (void *)kallsyms_lookup_funcptr("task_work_cancel");
         if (kallsyms_task_work_cancel == NULL) {
 		_stp_error("Can't resolve task_work_cancel!");
 		return -ENOENT;
diff --git a/runtime/stp_utrace.c b/runtime/stp_utrace.c
index a6f363d..056f1ab 100644
--- a/runtime/stp_utrace.c
+++ b/runtime/stp_utrace.c
@@ -191,12 +191,12 @@ static int utrace_init(void)
 	/* The signal_wake_up_state() function (which replaces
 	 * signal_wake_up() in newer kernels) isn't exported. Look up
 	 * that function address. */
-        kallsyms_signal_wake_up_state = (void *)kallsyms_lookup_name("signal_wake_up_state");
+        kallsyms_signal_wake_up_state = (void *)kallsyms_lookup_funcptr("signal_wake_up_state");
 #endif
 #if !defined(STAPCONF_SIGNAL_WAKE_UP_EXPORTED)
 	/* The signal_wake_up() function isn't exported. Look up that
 	 * function address. */
-        kallsyms_signal_wake_up = (void *)kallsyms_lookup_name("signal_wake_up");
+        kallsyms_signal_wake_up = (void *)kallsyms_lookup_funcptr("signal_wake_up");
 #endif
 #if (!defined(STAPCONF_SIGNAL_WAKE_UP_STATE_EXPORTED) \
      && !defined(STAPCONF_SIGNAL_WAKE_UP_EXPORTED))
@@ -209,7 +209,7 @@ static int utrace_init(void)
 #if !defined(STAPCONF___LOCK_TASK_SIGHAND_EXPORTED)
 	/* The __lock_task_sighand() function isn't exported. Look up
 	 * that function address. */
-        kallsyms___lock_task_sighand = (void *)kallsyms_lookup_name("__lock_task_sighand");
+        kallsyms___lock_task_sighand = (void *)kallsyms_lookup_funcptr("__lock_task_sighand");
         if (kallsyms___lock_task_sighand == NULL) {
 		_stp_error("Can't resolve __lock_task_sighand!");
 		goto error;
diff --git a/runtime/transport/transport.c b/runtime/transport/transport.c
index 0ddf514..bbad89e 100644
--- a/runtime/transport/transport.c
+++ b/runtime/transport/transport.c
@@ -352,7 +352,7 @@ static int _stp_transport_init(void)
 
 /* PR13489, missing inode-uprobes symbol-export workaround */
 #if !defined(STAPCONF_TASK_USER_REGSET_VIEW_EXPORTED) && !defined(STAPCONF_UTRACE_REGSET) /* RHEL5 era utrace */
-        kallsyms_task_user_regset_view = (void*) kallsyms_lookup_name ("task_user_regset_view");
+        kallsyms_task_user_regset_view = (void*) kallsyms_lookup_funcptr ("task_user_regset_view");
         /* There exist interesting kernel versions without task_user_regset_view(), like ARM before 3.0.
            For these kernels, uprobes etc. are out of the question, but plain kernel stap works fine.
            All we have to accomplish is have the loc2c runtime code compile.  For that, it's enough
@@ -363,9 +363,9 @@ static int _stp_transport_init(void)
 #endif
 #if defined(CONFIG_UPROBES) // i.e., kernel-embedded uprobes
 #if !defined(STAPCONF_UPROBE_REGISTER_EXPORTED)
-        kallsyms_uprobe_register = (void*) kallsyms_lookup_name ("uprobe_register");
+        kallsyms_uprobe_register = (void*) kallsyms_lookup_funcptr ("uprobe_register");
         if (kallsyms_uprobe_register == NULL) {
-		kallsyms_uprobe_register = (void*) kallsyms_lookup_name ("register_uprobe");
+		kallsyms_uprobe_register = (void*) kallsyms_lookup_funcptr ("register_uprobe");
         }
         if (kallsyms_uprobe_register == NULL) {
                 printk(KERN_ERR "%s can't resolve uprobe_register!", THIS_MODULE->name);
@@ -373,9 +373,9 @@ static int _stp_transport_init(void)
         }
 #endif
 #if !defined(STAPCONF_UPROBE_UNREGISTER_EXPORTED)
-        kallsyms_uprobe_unregister = (void*) kallsyms_lookup_name ("uprobe_unregister");
+        kallsyms_uprobe_unregister = (void*) kallsyms_lookup_funcptr ("uprobe_unregister");
         if (kallsyms_uprobe_unregister == NULL) {
-		kallsyms_uprobe_unregister = (void*) kallsyms_lookup_name ("unregister_uprobe");
+		kallsyms_uprobe_unregister = (void*) kallsyms_lookup_funcptr ("unregister_uprobe");
         }
         if (kallsyms_uprobe_unregister == NULL) {
                 printk(KERN_ERR "%s can't resolve uprobe_unregister!", THIS_MODULE->name);
@@ -383,7 +383,7 @@ static int _stp_transport_init(void)
         }
 #endif
 #if !defined(STAPCONF_UPROBE_GET_SWBP_ADDR_EXPORTED)
-        kallsyms_uprobe_get_swbp_addr = (void*) kallsyms_lookup_name ("uprobe_get_swbp_addr");
+        kallsyms_uprobe_get_swbp_addr = (void*) kallsyms_lookup_funcptr ("uprobe_get_swbp_addr");
         if (kallsyms_uprobe_get_swbp_addr == NULL) {
                 printk(KERN_ERR "%s can't resolve uprobe_get_swbp_addr!", THIS_MODULE->name);
                 goto err0;
-- 
1.9.0
