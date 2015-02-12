From: wangnan0@huawei.com (Wang Nan)
Date: Thu, 12 Feb 2015 20:19:51 +0800
Subject: [RFC PATCH v2 08/26] ftrace: enable other subsystems make ftrace nop
 before ftrace_init()
In-Reply-To: <1423743476-11927-1-git-send-email-wangnan0@huawei.com>
References: <1423743476-11927-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1423743591-12353-1-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 include/linux/ftrace.h |  5 +++++
 kernel/trace/ftrace.c  | 15 +++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 8db315a..d37ccd8a 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -702,9 +702,14 @@ static inline void __ftrace_enabled_restore(int enabled)
 #ifdef CONFIG_FTRACE_MCOUNT_RECORD
 extern void ftrace_init(void);
 extern void ftrace_init_early(void);
+extern int ftrace_process_loc_early(unsigned long ip);
 #else
 static inline void ftrace_init(void) { }
 static inline void ftrace_init_early(void) { }
+static inline int ftrace_process_loc_early(unsigned long __unused)
+{
+	return 0;
+}
 #endif
 
 /*
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 79b3e88..150762a 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5028,6 +5028,21 @@ void __init ftrace_init_early(void)
 	ftrace_sort_mcount_area();
 }
 
+int __init ftrace_process_loc_early(unsigned long addr)
+{
+	unsigned long ip = ftrace_location(addr);
+	struct dyn_ftrace fake_rec;
+	int ret;
+
+	if (ip != addr)
+		return -EINVAL;
+
+	memset(&fake_rec, '\0', sizeof(fake_rec));
+	fake_rec.ip = ip;
+	ret = ftrace_make_nop(NULL, &fake_rec, MCOUNT_ADDR);
+	return ret;
+}
+
 /* Do nothing if arch does not support this */
 void __weak arch_ftrace_update_trampoline(struct ftrace_ops *ops)
 {
-- 
1.8.4
