From: huawei.libin@huawei.com (Li Bin)
Date: Thu, 28 May 2015 13:51:02 +0800
Subject: [RFC PATCH 2/5] livepatch: ftrace: add ftrace_function_stub_ip
 function
In-Reply-To: <1432792265-24076-1-git-send-email-huawei.libin@huawei.com>
References: <1432792265-24076-1-git-send-email-huawei.libin@huawei.com>
Message-ID: <1432792265-24076-3-git-send-email-huawei.libin@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The function of ftrace_function_stub_ip is to convert the function
address to the ftrace stub calling instruction address.

This is needed for the platform that the complier does not support
"profile before prologue" feature and the profile calling instruction
is not at begin of the function.

EXAMPLES:
...
stub_ip = ftrace_function_stub_ip(func_addr);
ftrace_set_filter_ip(&ftrace_ops, stub_ip, 0, 0);
register_ftrace_function(&ftrace_ops);
...

Signed-off-by: Li Bin <huawei.libin@huawei.com>
---
 include/linux/ftrace.h |    1 +
 kernel/trace/ftrace.c  |   32 ++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 1da6029..38a2811 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -360,6 +360,7 @@ struct dyn_ftrace {
 int ftrace_force_update(void);
 int ftrace_set_filter_ip(struct ftrace_ops *ops, unsigned long ip,
 			 int remove, int reset);
+unsigned long ftrace_function_stub_ip(unsigned long addr);
 int ftrace_set_filter(struct ftrace_ops *ops, unsigned char *buf,
 		       int len, int reset);
 int ftrace_set_notrace(struct ftrace_ops *ops, unsigned char *buf,
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 02bece4..4d8692c 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4161,6 +4161,38 @@ int ftrace_set_filter_ip(struct ftrace_ops *ops, unsigned long ip,
 }
 EXPORT_SYMBOL_GPL(ftrace_set_filter_ip);
 
+/**
+ * ftrace_function_stub_ip - get the profile stub calling location by the
+ * function address. It is useful for the platform that doesn't place the
+ * function profiling call at the start of the function.
+ * @addr - the function address to get the stub ip
+ *
+ * It returns the corresponding profile stub calling location if founded, else
+ * return zero.
+ */
+unsigned long ftrace_function_stub_ip(unsigned long addr)
+{
+	struct ftrace_page *pg;
+	struct dyn_ftrace *rec;
+	unsigned long ret = 0;
+
+	mutex_lock(&ftrace_lock);
+
+	do_for_each_ftrace_rec(pg, rec) {
+		unsigned long offset;
+
+		if (kallsyms_lookup_size_offset(rec->ip, NULL, &offset)
+				&& addr + offset == rec->ip) {
+			ret = rec->ip;
+			goto out_unlock;
+		}
+	} while_for_each_ftrace_rec()
+out_unlock:
+	mutex_unlock(&ftrace_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ftrace_function_stub_ip);
+
 static int
 ftrace_set_regex(struct ftrace_ops *ops, unsigned char *buf, int len,
 		 int reset, int enable)
-- 
1.7.1
