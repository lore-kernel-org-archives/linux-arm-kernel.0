From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 23 Mar 2017 17:03:02 -0400
Subject: [PATCH 1/3] console: move console_init() out of tty_io.c
In-Reply-To: <20170323210304.2181-1-nicolas.pitre@linaro.org>
References: <20170323210304.2181-1-nicolas.pitre@linaro.org>
Message-ID: <20170323210304.2181-2-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All the console driver handling code lives in printk.c.
Move console_init() there as well so console support can still be used
when the TTY code is configured out.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 drivers/tty/tty_io.c    | 24 ------------------------
 include/linux/console.h |  2 ++
 include/linux/tty.h     |  7 ++++---
 init/main.c             |  2 +-
 kernel/printk/printk.c  | 24 ++++++++++++++++++++++++
 5 files changed, 31 insertions(+), 28 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index e6d1a65108..2100295861 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3578,30 +3578,6 @@ void tty_default_fops(struct file_operations *fops)
 	*fops = tty_fops;
 }
 
-/*
- * Initialize the console device. This is called *early*, so
- * we can't necessarily depend on lots of kernel help here.
- * Just do some early initializations, and do the complex setup
- * later.
- */
-void __init console_init(void)
-{
-	initcall_t *call;
-
-	/* Setup the default TTY line discipline. */
-	n_tty_init();
-
-	/*
-	 * set up the console device so that later boot sequences can
-	 * inform about problems etc..
-	 */
-	call = __con_initcall_start;
-	while (call < __con_initcall_end) {
-		(*call)();
-		call++;
-	}
-}
-
 static char *tty_devnode(struct device *dev, umode_t *mode)
 {
 	if (!mode)
diff --git a/include/linux/console.h b/include/linux/console.h
index 5949d18555..b8920a031a 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -212,4 +212,6 @@ extern bool vgacon_text_force(void);
 static inline bool vgacon_text_force(void) { return false; }
 #endif
 
+extern void console_init(void);
+
 #endif /* _LINUX_CONSOLE_H */
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 1017e904c0..f1106d7c73 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -390,7 +390,6 @@ static inline bool tty_throttled(struct tty_struct *tty)
 }
 
 #ifdef CONFIG_TTY
-extern void console_init(void);
 extern void tty_kref_put(struct tty_struct *tty);
 extern struct pid *tty_get_pgrp(struct tty_struct *tty);
 extern void tty_vhangup_self(void);
@@ -402,8 +401,6 @@ extern struct tty_struct *get_current_tty(void);
 extern int __init tty_init(void);
 extern const char *tty_name(const struct tty_struct *tty);
 #else
-static inline void console_init(void)
-{ }
 static inline void tty_kref_put(struct tty_struct *tty)
 { }
 static inline struct pid *tty_get_pgrp(struct tty_struct *tty)
@@ -669,7 +666,11 @@ extern int tty_ldisc_receive_buf(struct tty_ldisc *ld, const unsigned char *p,
 
 /* n_tty.c */
 extern void n_tty_inherit_ops(struct tty_ldisc_ops *ops);
+#ifdef CONFIG_TTY
 extern void __init n_tty_init(void);
+#else
+static inline void n_tty_init(void) { }
+#endif
 
 /* tty_audit.c */
 #ifdef CONFIG_AUDIT
diff --git a/init/main.c b/init/main.c
index f9c9d99482..b9bd0edf21 100644
--- a/init/main.c
+++ b/init/main.c
@@ -27,7 +27,7 @@
 #include <linux/initrd.h>
 #include <linux/bootmem.h>
 #include <linux/acpi.h>
-#include <linux/tty.h>
+#include <linux/console.h>
 #include <linux/nmi.h>
 #include <linux/percpu.h>
 #include <linux/kmod.h>
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 2984fb0f02..3a09406526 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2611,6 +2611,30 @@ int unregister_console(struct console *console)
 EXPORT_SYMBOL(unregister_console);
 
 /*
+ * Initialize the console device. This is called *early*, so
+ * we can't necessarily depend on lots of kernel help here.
+ * Just do some early initializations, and do the complex setup
+ * later.
+ */
+void __init console_init(void)
+{
+	initcall_t *call;
+
+	/* Setup the default TTY line discipline. */
+	n_tty_init();
+
+	/*
+	 * set up the console device so that later boot sequences can
+	 * inform about problems etc..
+	 */
+	call = __con_initcall_start;
+	while (call < __con_initcall_end) {
+		(*call)();
+		call++;
+	}
+}
+
+/*
  * Some boot consoles access data that is in the init section and which will
  * be discarded after the initcalls have been run. To make sure that no code
  * will access this data, unregister the boot consoles in a late initcall.
-- 
2.9.3
