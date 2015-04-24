From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 24 Apr 2015 11:44:06 +0900
Subject: [RFC 1/4] ftrace: add a helper function for livepatch
In-Reply-To: <1429843449-7388-1-git-send-email-takahiro.akashi@linaro.org>
References: <1429843449-7388-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1429843449-7388-2-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ftrace_lookup_mcount() will return an address of mcount call in a function.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 include/linux/ftrace.h |    2 ++
 kernel/trace/ftrace.c  |   26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 1da6029..1d0271f 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -699,6 +699,8 @@ static inline void __ftrace_enabled_restore(int enabled)
 # define trace_preempt_off(a0, a1) do { } while (0)
 #endif
 
+extern unsigned long ftrace_lookup_mcount(unsigned long addr);
+
 #ifdef CONFIG_FTRACE_MCOUNT_RECORD
 extern void ftrace_init(void);
 #else
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 4f22802..fcfb04f 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4857,6 +4857,32 @@ static int ftrace_process_locs(struct module *mod,
 	return ret;
 }
 
+unsigned long ftrace_lookup_mcount(unsigned long addr)
+{
+	struct ftrace_page *pg;
+	struct dyn_ftrace *rec;
+	char str[KSYM_SYMBOL_LEN];
+	char *modname;
+	const char *name;
+	unsigned long mcount = 0;
+	unsigned long offset;
+
+	mutex_lock(&ftrace_lock);
+
+	do_for_each_ftrace_rec(pg, rec) {
+		name = kallsyms_lookup(rec->ip, NULL, &offset, &modname, str);
+		if (name && rec->ip == (addr + offset)) {
+			mcount = rec->ip;
+			goto out_unlock;
+		}
+	} while_for_each_ftrace_rec();
+
+ out_unlock:
+	mutex_unlock(&ftrace_lock);
+
+	return mcount;
+}
+
 #ifdef CONFIG_MODULES
 
 #define next_to_ftrace_page(p) container_of(p, struct ftrace_page, next)
-- 
1.7.9.5
