From: wangnan0@huawei.com (Wang Nan)
Date: Fri, 13 Feb 2015 13:40:36 +0800
Subject: [RFC PATCH v3 08/26] ftrace: enable make ftrace nop before
 ftrace_init().
In-Reply-To: <1423805941-61407-1-git-send-email-wangnan0@huawei.com>
References: <1423805941-61407-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1423806036-61825-1-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is for early kprobes.

Ftrace converts ftrace entries to nop when init, which will conflict
with early kprobes if it probe on an ftrace entry before such
conversion. For x86, ftrace entries is 'call' instruction which is
happends unboostable.

This patch provides ftrace_process_loc_early() to allow early kprobes to
convert target instruction before ftrace_init() is called. Only allows
ftrace_process_loc_early() called before ftrace_init().

However, for x86 only this patch is not enough. Due to ideal_nop() is
updated during setup_arch(), we are unable to ensure
ftrace_process_loc_early() choose similar nop as normal ftrace. I'll use
another mechanism to solve this problem.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 include/linux/ftrace.h |  5 +++++
 kernel/trace/ftrace.c  | 18 ++++++++++++++++++
 2 files changed, 23 insertions(+)

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
index fc0c1aa..e39e72a 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5037,6 +5037,24 @@ void __init ftrace_init_early(void)
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
