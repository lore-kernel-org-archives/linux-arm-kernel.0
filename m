From: wangnan0@huawei.com (Wang Nan)
Date: Thu, 12 Feb 2015 20:19:46 +0800
Subject: [RFC PATCH v2 07/26] ftrace: allow search ftrace addr before ftrace
 fully inited.
In-Reply-To: <1423743476-11927-1-git-send-email-wangnan0@huawei.com>
References: <1423743476-11927-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1423743586-12310-1-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 kernel/trace/ftrace.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index a6a6b09..79b3e88 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1539,6 +1539,8 @@ static unsigned long ftrace_location_range(unsigned long start, unsigned long en
 	return 0;
 }
 
+static unsigned long ftrace_search_mcount_ip(unsigned long ip);
+
 /**
  * ftrace_location - return true if the ip giving is a traced location
  * @ip: the instruction pointer to check
@@ -1550,6 +1552,9 @@ static unsigned long ftrace_location_range(unsigned long start, unsigned long en
  */
 unsigned long ftrace_location(unsigned long ip)
 {
+	if (unlikely(!ftrace_pages_start))
+		return ftrace_search_mcount_ip(ip);
+
 	return ftrace_location_range(ip, ip);
 }
 
@@ -4733,6 +4738,18 @@ static int ftrace_cmp_ips(const void *a, const void *b)
 	return 0;
 }
 
+static int ftrace_cmp_ips_insn(const void *a, const void *b)
+{
+	const unsigned long *ipa = a;
+	const unsigned long *ipb = b;
+
+	if (*ipa >= *ipb + MCOUNT_INSN_SIZE)
+		return 1;
+	if (*ipa < *ipb)
+		return -1;
+	return 0;
+}
+
 static void ftrace_swap_ips(void *a, void *b, int size)
 {
 	unsigned long *ipa = a;
@@ -4764,6 +4781,27 @@ static void ftrace_sort_mcount_area(void)
 	}
 }
 
+static unsigned long ftrace_search_mcount_ip(unsigned long ip)
+{
+	extern unsigned long __start_mcount_loc[];
+	extern unsigned long __stop_mcount_loc[];
+
+	unsigned long *mcount_start = __start_mcount_loc;
+	unsigned long *mcount_end = __stop_mcount_loc;
+	unsigned long count = mcount_end - mcount_start;
+	unsigned long *retval;
+
+	if (!mcount_sorted)
+		return 0;
+
+	retval = bsearch(&ip, mcount_start, count,
+			sizeof(unsigned long), ftrace_cmp_ips_insn);
+	if (!retval)
+		return 0;
+
+	return ftrace_call_adjust(ip);
+}
+
 static int ftrace_process_locs(struct module *mod,
 			       unsigned long *start,
 			       unsigned long *end)
-- 
1.8.4
