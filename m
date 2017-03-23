From: keescook@chromium.org (Kees Cook)
Date: Thu, 23 Mar 2017 13:34:19 -0700
Subject: [PATCH] lkdtm: add bad USER_DS test
Message-ID: <20170323203419.GA62859@beast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds CORRUPT_USER_DS to check that the get_fs() test on syscall return
still sees USER_DS during the new VERIFY_PRE_USERMODE_STATE checks.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm.h      |  1 +
 drivers/misc/lkdtm_bugs.c | 20 ++++++++++++++++++++
 drivers/misc/lkdtm_core.c |  1 +
 3 files changed, 22 insertions(+)

diff --git a/drivers/misc/lkdtm.h b/drivers/misc/lkdtm.h
index 67d27be60405..3b4976396ec4 100644
--- a/drivers/misc/lkdtm.h
+++ b/drivers/misc/lkdtm.h
@@ -27,6 +27,7 @@ void lkdtm_REFCOUNT_ZERO_SUB(void);
 void lkdtm_REFCOUNT_ZERO_ADD(void);
 void lkdtm_CORRUPT_LIST_ADD(void);
 void lkdtm_CORRUPT_LIST_DEL(void);
+void lkdtm_CORRUPT_USER_DS(void);
 
 /* lkdtm_heap.c */
 void lkdtm_OVERWRITE_ALLOCATION(void);
diff --git a/drivers/misc/lkdtm_bugs.c b/drivers/misc/lkdtm_bugs.c
index e3f4cd8876b5..4906e53a6df3 100644
--- a/drivers/misc/lkdtm_bugs.c
+++ b/drivers/misc/lkdtm_bugs.c
@@ -8,6 +8,7 @@
 #include <linux/list.h>
 #include <linux/refcount.h>
 #include <linux/sched.h>
+#include <linux/uaccess.h>
 
 struct lkdtm_list {
 	struct list_head node;
@@ -279,3 +280,22 @@ void lkdtm_CORRUPT_LIST_DEL(void)
 	else
 		pr_err("list_del() corruption not detected!\n");
 }
+
+void lkdtm_CORRUPT_USER_DS(void)
+{
+	/*
+	 * Test that USER_DS has been set correctly on exiting a syscall.
+	 * Since setting this higher than USER_DS (TASK_SIZE) would introduce
+	 * an exploitable condition, we lower it instead, since that should
+	 * not create as large a problem on an unprotected system.
+	 */
+	mm_segment_t lowfs;
+#ifdef MAKE_MM_SEG
+	lowfs = MAKE_MM_SEG(TASK_SIZE - PAGE_SIZE);
+#else
+	lowfs = TASK_SIZE - PAGE_SIZE;
+#endif
+
+	pr_info("setting bad task size limit\n");
+	set_fs(lowfs);
+}
diff --git a/drivers/misc/lkdtm_core.c b/drivers/misc/lkdtm_core.c
index b9a4cd4a9b68..42d2b8e31e6b 100644
--- a/drivers/misc/lkdtm_core.c
+++ b/drivers/misc/lkdtm_core.c
@@ -199,6 +199,7 @@ struct crashtype crashtypes[] = {
 	CRASHTYPE(OVERFLOW),
 	CRASHTYPE(CORRUPT_LIST_ADD),
 	CRASHTYPE(CORRUPT_LIST_DEL),
+	CRASHTYPE(CORRUPT_USER_DS),
 	CRASHTYPE(CORRUPT_STACK),
 	CRASHTYPE(UNALIGNED_LOAD_STORE_WRITE),
 	CRASHTYPE(OVERWRITE_ALLOCATION),
-- 
2.7.4


-- 
Kees Cook
Pixel Security
