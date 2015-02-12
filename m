From: wangnan0@huawei.com (Wang Nan)
Date: Thu, 12 Feb 2015 20:19:41 +0800
Subject: [RFC PATCH v2 06/26] ftrace: sort ftrace entries earlier.
In-Reply-To: <1423743476-11927-1-git-send-email-wangnan0@huawei.com>
References: <1423743476-11927-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1423743581-12267-1-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 include/linux/ftrace.h |  2 ++
 init/main.c            |  1 +
 kernel/trace/ftrace.c  | 29 +++++++++++++++++++++++++++--
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 1da6029..8db315a 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -701,8 +701,10 @@ static inline void __ftrace_enabled_restore(int enabled)
 
 #ifdef CONFIG_FTRACE_MCOUNT_RECORD
 extern void ftrace_init(void);
+extern void ftrace_init_early(void);
 #else
 static inline void ftrace_init(void) { }
+static inline void ftrace_init_early(void) { }
 #endif
 
 /*
diff --git a/init/main.c b/init/main.c
index 6f0f1c5f..eaafc3e 100644
--- a/init/main.c
+++ b/init/main.c
@@ -517,6 +517,7 @@ asmlinkage __visible void __init start_kernel(void)
 	boot_cpu_init();
 	page_address_init();
 	pr_notice("%s", linux_banner);
+	ftrace_init_early();
 	setup_arch(&command_line);
 	mm_init_cpumask(&init_mm);
 	setup_command_line(command_line);
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 6c6cbb1..a6a6b09 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1169,6 +1169,7 @@ struct ftrace_page {
 
 static struct ftrace_page	*ftrace_pages_start;
 static struct ftrace_page	*ftrace_pages;
+static bool mcount_sorted = false;
 
 static bool __always_inline ftrace_hash_empty(struct ftrace_hash *hash)
 {
@@ -4743,6 +4744,26 @@ static void ftrace_swap_ips(void *a, void *b, int size)
 	*ipb = t;
 }
 
+static void ftrace_sort_mcount_area(void)
+{
+	extern unsigned long __start_mcount_loc[];
+	extern unsigned long __stop_mcount_loc[];
+
+	unsigned long *start = __start_mcount_loc;
+	unsigned long *end = __stop_mcount_loc;
+	unsigned long count;
+
+	count = end - start;
+	if (!count)
+		return;
+
+	if (!mcount_sorted) {
+		sort(start, count, sizeof(*start),
+		     ftrace_cmp_ips, ftrace_swap_ips);
+		mcount_sorted = true;
+	}
+}
+
 static int ftrace_process_locs(struct module *mod,
 			       unsigned long *start,
 			       unsigned long *end)
@@ -4761,8 +4782,7 @@ static int ftrace_process_locs(struct module *mod,
 	if (!count)
 		return 0;
 
-	sort(start, count, sizeof(*start),
-	     ftrace_cmp_ips, ftrace_swap_ips);
+	ftrace_sort_mcount_area();
 
 	start_pg = ftrace_allocate_pages(count);
 	if (!start_pg)
@@ -4965,6 +4985,11 @@ void __init ftrace_init(void)
 	ftrace_disabled = 1;
 }
 
+void __init ftrace_init_early(void)
+{
+	ftrace_sort_mcount_area();
+}
+
 /* Do nothing if arch does not support this */
 void __weak arch_ftrace_update_trampoline(struct ftrace_ops *ops)
 {
-- 
1.8.4
