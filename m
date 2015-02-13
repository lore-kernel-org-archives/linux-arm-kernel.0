From: wangnan0@huawei.com (Wang Nan)
Date: Fri, 13 Feb 2015 13:40:39 +0800
Subject: [RFC PATCH v3 09/26] ftrace: allow fixing code update failure by
 notifier chain.
In-Reply-To: <1423805941-61407-1-git-send-email-wangnan0@huawei.com>
References: <1423805941-61407-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1423806039-61864-1-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces a notifier chain (ftrace_update_notifier_list) and
ftrace_tryfix_bug(). The goal of this patch is to provide other
subsystem a chance to fix code if they alert ftrace entries before
ftrace_init().

Such subsystems should register a callback with
register_ftrace_update_notifier(). Ftrace will trigger the callback by
ftrace_tryfix_bug() when it fail to alert ftrace entries, instead of
directly fire an ftrace_bug(). It wrapps failure information with
a struct ftrace_update_notifier_info. Subscriber is able to determine
what it trying to do with it.

Subscriber of that notifier chain should return NOTIFY_STOP if it can
deal with the problem, or NOTIFY_DONE to pass it to other. By setting
info->retry it can inform ftrace to retry faild operation.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 include/linux/ftrace.h | 30 ++++++++++++++++++++++++++++++
 kernel/trace/ftrace.c  | 46 ++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 70 insertions(+), 6 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index d37ccd8a..98da86d 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -283,6 +283,21 @@ int ftrace_arch_code_modify_post_process(void);
 struct dyn_ftrace;
 
 void ftrace_bug(int err, struct dyn_ftrace *rec);
+int ftrace_tryfix(int failed, int enable, struct dyn_ftrace *rec);
+
+#define __ftrace_tryfix_bug(__failed, __enable, __rec, __retry, __trigger)\
+	({								\
+		int __fix_ret = ftrace_tryfix((__failed), (__enable), (__rec));\
+		__fix_ret = (__fix_ret == -EAGAIN) ?			\
+			({ __retry; }) :				\
+			__fix_ret;					\
+		if (__fix_ret && (__trigger))					\
+			ftrace_bug(__failed, __rec);			\
+		__fix_ret;						\
+	})
+
+#define ftrace_tryfix_bug(__failed, __enable, __rec, __retry)	\
+	__ftrace_tryfix_bug(__failed, __enable, __rec, __retry, true)
 
 struct seq_file;
 
@@ -699,10 +714,20 @@ static inline void __ftrace_enabled_restore(int enabled)
 # define trace_preempt_off(a0, a1) do { } while (0)
 #endif
 
+struct ftrace_update_notifier_info {
+	struct dyn_ftrace *rec;
+	int errno;
+	int enable;
+
+	/* Filled by subscriber */
+	bool retry;
+};
+
 #ifdef CONFIG_FTRACE_MCOUNT_RECORD
 extern void ftrace_init(void);
 extern void ftrace_init_early(void);
 extern int ftrace_process_loc_early(unsigned long ip);
+extern int register_ftrace_update_notifier(struct notifier_block *nb);
 #else
 static inline void ftrace_init(void) { }
 static inline void ftrace_init_early(void) { }
@@ -710,6 +735,11 @@ static inline int ftrace_process_loc_early(unsigned long __unused)
 {
 	return 0;
 }
+
+static inline int register_ftrace_update_notifier(struct notifier_block *__unused)
+{
+	return 0;
+}
 #endif
 
 /*
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index e39e72a..d75b823 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -112,6 +112,7 @@ ftrace_func_t ftrace_trace_function __read_mostly = ftrace_stub;
 ftrace_func_t ftrace_pid_function __read_mostly = ftrace_stub;
 static struct ftrace_ops global_ops;
 static struct ftrace_ops control_ops;
+static ATOMIC_NOTIFIER_HEAD(ftrace_update_notifier_list);
 
 static void ftrace_ops_recurs_func(unsigned long ip, unsigned long parent_ip,
 				   struct ftrace_ops *op, struct pt_regs *regs);
@@ -1971,6 +1972,28 @@ void ftrace_bug(int failed, struct dyn_ftrace *rec)
 	}
 }
 
+int ftrace_tryfix(int failed, int enable, struct dyn_ftrace *rec)
+{
+	int notify_result = NOTIFY_DONE;
+	struct ftrace_update_notifier_info info = {
+		.rec = rec,
+		.errno = failed,
+		.enable = enable,
+		.retry = false,
+	};
+
+	notify_result = atomic_notifier_call_chain(
+			&ftrace_update_notifier_list,
+			0, &info);
+
+	if (notify_result != NOTIFY_STOP)
+		return failed;
+
+	if (info.retry)
+		return -EAGAIN;
+	return 0;
+}
+
 static int ftrace_check_record(struct dyn_ftrace *rec, int enable, int update)
 {
 	unsigned long flag = 0UL;
@@ -2298,9 +2321,12 @@ void __weak ftrace_replace_code(int enable)
 	do_for_each_ftrace_rec(pg, rec) {
 		failed = __ftrace_replace_code(rec, enable);
 		if (failed) {
-			ftrace_bug(failed, rec);
-			/* Stop processing */
-			return;
+			failed = ftrace_tryfix_bug(failed, enable, rec,
+					__ftrace_replace_code(rec, enable));
+
+			/* Stop processing if still fail */
+			if (failed)
+				return;
 		}
 	} while_for_each_ftrace_rec();
 }
@@ -2387,8 +2413,10 @@ ftrace_code_disable(struct module *mod, struct dyn_ftrace *rec)
 
 	ret = ftrace_make_nop(mod, rec, MCOUNT_ADDR);
 	if (ret) {
-		ftrace_bug(ret, rec);
-		return 0;
+		ret = ftrace_tryfix_bug(ret, 0, rec,
+				ftrace_make_nop(mod, rec, MCOUNT_ADDR));
+		if (ret)
+			return 0;
 	}
 	return 1;
 }
@@ -2844,7 +2872,8 @@ static int ftrace_update_code(struct module *mod, struct ftrace_page *new_pgs)
 			if (ftrace_start_up && cnt) {
 				int failed = __ftrace_replace_code(p, 1);
 				if (failed)
-					ftrace_bug(failed, p);
+					failed = ftrace_tryfix_bug(failed, 1, p,
+							__ftrace_replace_code(p, 1));
 			}
 		}
 	}
@@ -5673,6 +5702,11 @@ ftrace_enable_sysctl(struct ctl_table *table, int write,
 	return ret;
 }
 
+int register_ftrace_update_notifier(struct notifier_block *nb)
+{
+	return atomic_notifier_chain_register(&ftrace_update_notifier_list, nb);
+}
+
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 
 static struct ftrace_ops graph_ops = {
-- 
1.8.4
