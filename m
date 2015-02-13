From: wangnan0@huawei.com (Wang Nan)
Date: Fri, 13 Feb 2015 13:40:31 +0800
Subject: [RFC PATCH v3 06/26] ftrace: sort ftrace entries earlier.
In-Reply-To: <1423805941-61407-1-git-send-email-wangnan0@huawei.com>
References: <1423805941-61407-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1423806031-61742-1-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By extracting mcount sorting code and sort them earliler, futher patches
will be able to determine whether an address is on an ftrace entry or
not using bsearch().

ftrace_sort_mcount_area() will be called before, during and after
ftrace_init (when module insertion). Ensure it sort kernel mcount table
only once.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 include/linux/ftrace.h |  2 ++
 init/main.c            |  1 +
 kernel/trace/ftrace.c  | 38 ++++++++++++++++++++++++++++++++++++--
 3 files changed, 39 insertions(+), 2 deletions(-)

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
index 6c6cbb1..a75cfbe 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1169,6 +1169,7 @@ struct ftrace_page {
 
 static struct ftrace_page	*ftrace_pages_start;
 static struct ftrace_page	*ftrace_pages;
+static bool kernel_mcount_sorted = false;
 
 static bool __always_inline ftrace_hash_empty(struct ftrace_hash *hash)
 {
@@ -4743,6 +4744,32 @@ static void ftrace_swap_ips(void *a, void *b, int size)
 	*ipb = t;
 }
 
+static void ftrace_sort_mcount_area(unsigned long *start, unsigned long *end)
+{
+	extern unsigned long __start_mcount_loc[];
+	extern unsigned long __stop_mcount_loc[];
+
+	unsigned long count;
+	bool is_kernel_mcount;
+
+	count = end - start;
+	if (!count)
+		return;
+
+	is_kernel_mcount =
+		(start == __start_mcount_loc) &&
+		(end == __stop_mcount_loc);
+
+	if (is_kernel_mcount && kernel_mcount_sorted)
+		return;
+
+	sort(start, count, sizeof(*start),
+		ftrace_cmp_ips, ftrace_swap_ips);
+
+	if (is_kernel_mcount)
+		kernel_mcount_sorted = true;
+}
+
 static int ftrace_process_locs(struct module *mod,
 			       unsigned long *start,
 			       unsigned long *end)
@@ -4761,8 +4788,7 @@ static int ftrace_process_locs(struct module *mod,
 	if (!count)
 		return 0;
 
-	sort(start, count, sizeof(*start),
-	     ftrace_cmp_ips, ftrace_swap_ips);
+	ftrace_sort_mcount_area(start, end);
 
 	start_pg = ftrace_allocate_pages(count);
 	if (!start_pg)
@@ -4965,6 +4991,14 @@ void __init ftrace_init(void)
 	ftrace_disabled = 1;
 }
 
+void __init ftrace_init_early(void)
+{
+	extern unsigned long __start_mcount_loc[];
+	extern unsigned long __stop_mcount_loc[];
+
+	ftrace_sort_mcount_area(__start_mcount_loc, __stop_mcount_loc);
+}
+
 /* Do nothing if arch does not support this */
 void __weak arch_ftrace_update_trampoline(struct ftrace_ops *ops)
 {
-- 
1.8.4
