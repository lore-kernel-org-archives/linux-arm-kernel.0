From: ynorov@caviumnetworks.com (Yury Norov)
Date: Sun,  4 Jun 2017 14:59:57 +0300
Subject: [PATCH 08/20] thread: move thread bits accessors to separated file
In-Reply-To: <20170604120009.342-1-ynorov@caviumnetworks.com>
References: <20170604120009.342-1-ynorov@caviumnetworks.com>
Message-ID: <20170604120009.342-9-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

They may be accessed from low-level code, so isolating is a measure to
avoid circular dependencies in header files.

The exact reason for circular dependency is WARN_ON() macro added in patch
edd63a27 "set_restore_sigmask() is never called without SIGPENDING (and
never should be)"

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 include/linux/thread_bits.h | 63 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/thread_info.h | 66 +++++++++------------------------------------
 2 files changed, 75 insertions(+), 54 deletions(-)
 create mode 100644 include/linux/thread_bits.h

diff --git a/include/linux/thread_bits.h b/include/linux/thread_bits.h
new file mode 100644
index 000000000000..87354331bc7b
--- /dev/null
+++ b/include/linux/thread_bits.h
@@ -0,0 +1,63 @@
+/* thread_bits.h: common low-level thread bits accessors */
+
+#ifndef _LINUX_THREAD_BITS_H
+#define _LINUX_THREAD_BITS_H
+
+#ifndef __ASSEMBLY__
+
+#include <linux/bitops.h>
+#include <asm/thread_info.h>
+
+#ifdef CONFIG_THREAD_INFO_IN_TASK
+/*
+ * For CONFIG_THREAD_INFO_IN_TASK kernels we need <asm/current.h> for the
+ * definition of current, but for !CONFIG_THREAD_INFO_IN_TASK kernels,
+ * including <asm/current.h> can cause a circular dependency on some platforms.
+ */
+#include <asm/current.h>
+#define current_thread_info() ((struct thread_info *)current)
+#endif
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
+#endif /* _LINUX_THREAD_BITS_H */
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index d7d3ea637dd0..2467f350d659 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -7,9 +7,21 @@
 #ifndef _LINUX_THREAD_INFO_H
 #define _LINUX_THREAD_INFO_H
 
+/*
+ * For per-arch arch_within_stack_frames() implementations, defined in
+ * asm/thread_info.h.
+ */
+enum {
+	BAD_STACK = -1,
+	NOT_STACK = 0,
+	GOOD_FRAME,
+	GOOD_STACK,
+};
+
 #include <linux/types.h>
 #include <linux/bug.h>
 #include <linux/restart_block.h>
+#include <linux/thread_bits.h>
 
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 /*
@@ -21,19 +33,6 @@
 #define current_thread_info() ((struct thread_info *)current)
 #endif
 
-#include <linux/bitops.h>
-
-/*
- * For per-arch arch_within_stack_frames() implementations, defined in
- * asm/thread_info.h.
- */
-enum {
-	BAD_STACK = -1,
-	NOT_STACK = 0,
-	GOOD_FRAME,
-	GOOD_STACK,
-};
-
 #include <asm/thread_info.h>
 
 #ifdef __KERNEL__
@@ -45,47 +44,6 @@ enum {
 # define THREADINFO_GFP		(GFP_KERNEL_ACCOUNT | __GFP_NOTRACK)
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
 
 #ifndef CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES
-- 
2.11.0
