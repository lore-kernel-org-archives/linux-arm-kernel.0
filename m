From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 16 Dec 2015 00:42:32 +0300
Subject: [PATCH v6 06/20] thread: move thread bits accessors to separated file
In-Reply-To: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
References: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1450215766-14765-7-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

They may be accessed from low-level code, so isolating is a measure to
avoid circular dependencies in header files.

The exact reason for circular dependency is WARN_ON() macro added by Al
Viro in patch "set_restore_sigmask() is never called without SIGPENDING
(and never should be)" [edd63a27]

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 include/linux/thread_bits.h | 57 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/thread_info.h | 44 +---------------------------------
 2 files changed, 58 insertions(+), 43 deletions(-)
 create mode 100644 include/linux/thread_bits.h

diff --git a/include/linux/thread_bits.h b/include/linux/thread_bits.h
new file mode 100644
index 0000000..8d1e3be
--- /dev/null
+++ b/include/linux/thread_bits.h
@@ -0,0 +1,57 @@
+
+/* thread_bits.h: common low-level thread bits accessors */
+
+#ifndef _LINUX_THREAD_BITS_H
+#define _LINUX_THREAD_BITS_H
+
+#ifdef __KERNEL__
+#ifndef __ASSEMBLY__
+
+#include <linux/bitops.h>
+#include <asm/thread_info.h>
+
+/*
+ * flag set/clear/test wrappers
+ * - pass TIF_xxxx constants to these functions
+ */
+
+static inline void set_ti_thread_flag(struct thread_info *ti, int flag)
+{
+	set_bit(flag, (unsigned long *)&ti->flags);
+}
+
+static inline void clear_ti_thread_flag(struct thread_info *ti, int flag)
+{
+	clear_bit(flag, (unsigned long *)&ti->flags);
+}
+
+static inline int test_and_set_ti_thread_flag(struct thread_info *ti, int flag)
+{
+	return test_and_set_bit(flag, (unsigned long *)&ti->flags);
+}
+
+static inline int test_and_clear_ti_thread_flag(struct thread_info *ti, int flag)
+{
+	return test_and_clear_bit(flag, (unsigned long *)&ti->flags);
+}
+
+static inline int test_ti_thread_flag(struct thread_info *ti, int flag)
+{
+	return test_bit(flag, (unsigned long *)&ti->flags);
+}
+
+#define set_thread_flag(flag) \
+	set_ti_thread_flag(current_thread_info(), flag)
+#define clear_thread_flag(flag) \
+	clear_ti_thread_flag(current_thread_info(), flag)
+#define test_and_set_thread_flag(flag) \
+	test_and_set_ti_thread_flag(current_thread_info(), flag)
+#define test_and_clear_thread_flag(flag) \
+	test_and_clear_ti_thread_flag(current_thread_info(), flag)
+#define test_thread_flag(flag) \
+	test_ti_thread_flag(current_thread_info(), flag)
+
+#endif /* !__ASSEMBLY__ */
+#endif /* __KERNEL_  */
+#endif /* _LINUX_THREAD_BITS_H */
+
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index ff307b5..c905fec 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -50,8 +50,7 @@ struct restart_block {
 
 extern long do_no_restart_syscall(struct restart_block *parm);
 
-#include <linux/bitops.h>
-#include <asm/thread_info.h>
+#include <linux/thread_bits.h>
 
 #ifdef __KERNEL__
 
@@ -61,47 +60,6 @@ extern long do_no_restart_syscall(struct restart_block *parm);
 # define THREADINFO_GFP		(GFP_KERNEL | __GFP_NOTRACK)
 #endif
 
-/*
- * flag set/clear/test wrappers
- * - pass TIF_xxxx constants to these functions
- */
-
-static inline void set_ti_thread_flag(struct thread_info *ti, int flag)
-{
-	set_bit(flag, (unsigned long *)&ti->flags);
-}
-
-static inline void clear_ti_thread_flag(struct thread_info *ti, int flag)
-{
-	clear_bit(flag, (unsigned long *)&ti->flags);
-}
-
-static inline int test_and_set_ti_thread_flag(struct thread_info *ti, int flag)
-{
-	return test_and_set_bit(flag, (unsigned long *)&ti->flags);
-}
-
-static inline int test_and_clear_ti_thread_flag(struct thread_info *ti, int flag)
-{
-	return test_and_clear_bit(flag, (unsigned long *)&ti->flags);
-}
-
-static inline int test_ti_thread_flag(struct thread_info *ti, int flag)
-{
-	return test_bit(flag, (unsigned long *)&ti->flags);
-}
-
-#define set_thread_flag(flag) \
-	set_ti_thread_flag(current_thread_info(), flag)
-#define clear_thread_flag(flag) \
-	clear_ti_thread_flag(current_thread_info(), flag)
-#define test_and_set_thread_flag(flag) \
-	test_and_set_ti_thread_flag(current_thread_info(), flag)
-#define test_and_clear_thread_flag(flag) \
-	test_and_clear_ti_thread_flag(current_thread_info(), flag)
-#define test_thread_flag(flag) \
-	test_ti_thread_flag(current_thread_info(), flag)
-
 #define tif_need_resched() test_thread_flag(TIF_NEED_RESCHED)
 
 #if defined TIF_RESTORE_SIGMASK && !defined HAVE_SET_RESTORE_SIGMASK
-- 
2.5.0
