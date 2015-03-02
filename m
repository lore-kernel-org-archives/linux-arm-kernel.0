From: wangnan0@huawei.com (Wang Nan)
Date: Mon, 2 Mar 2015 22:25:11 +0800
Subject: [RFC PATCH v4 33/34] ftrace: enable make ftrace nop before
 ftrace_init().
In-Reply-To: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
References: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1425306312-3437-34-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is for early kprobes, enables early kprobes to convert
target instruction into nop so it is possible to optimize them.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 include/linux/ftrace.h |  5 +++++
 kernel/trace/ftrace.c  | 18 ++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index fe99166..9cb6061a 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -703,9 +703,14 @@ static inline void __ftrace_enabled_restore(int enabled)
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
index 78787d4..bb66b20 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5046,6 +5046,24 @@ void __init ftrace_init_early(void)
 	ftrace_sort_mcount_area(__start_mcount_loc, __stop_mcount_loc);
 }
 
+int __init ftrace_process_loc_early(unsigned long addr)
+{
+	unsigned long ip;
+	struct dyn_ftrace fake_rec;
+	int ret;
+
+	BUG_ON(ftrace_pages_start);
+
+	ip = ftrace_location(addr);
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
