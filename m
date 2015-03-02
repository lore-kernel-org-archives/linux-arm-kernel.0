From: wangnan0@huawei.com (Wang Nan)
Date: Mon, 2 Mar 2015 22:25:06 +0800
Subject: [RFC PATCH v4 28/34] ftrace: x86: get old instruction from early
 kprobes when make call.
In-Reply-To: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
References: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1425306312-3437-29-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For previously detected early kprobes on ftrace, retrieve old
instruction using kprobe_on_ftrace_get_old_insn() instead of
ftrace_nop_replace(). Which will enable convertion an early kprobed
ftrace entry directly to 'call' instrustion without turnning off
kprobe.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 arch/x86/kernel/ftrace.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 7bdba65..f200cd4 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -21,6 +21,7 @@
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/module.h>
+#include <linux/kprobes.h>
 
 #include <trace/syscall.h>
 
@@ -164,7 +165,17 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 	unsigned const char *new, *old;
 	unsigned long ip = rec->ip;
 
-	old = ftrace_nop_replace();
+#if defined(CONFIG_KPROBES_ON_FTRACE) && defined(CONFIG_EARLY_KPROBES)
+	unsigned char kprobes_old_insn[MCOUNT_INSN_SIZE];
+
+	if (unlikely(rec->flags & FTRACE_FL_EARLY_KPROBES))
+		old = kprobe_on_ftrace_get_old_insn(rec,
+				ftrace_nop_replace(),
+				kprobes_old_insn,
+				MCOUNT_INSN_SIZE);
+	else
+#endif
+		old = ftrace_nop_replace();
 	new = ftrace_call_replace(ip, addr);
 
 	/* Should only be called when module is loaded */
@@ -335,8 +346,16 @@ static int add_brk_on_call(struct dyn_ftrace *rec, unsigned long addr)
 static int add_brk_on_nop(struct dyn_ftrace *rec)
 {
 	unsigned const char *old;
+#if defined(CONFIG_KPROBES_ON_FTRACE) && defined(CONFIG_EARLY_KPROBES)
+	unsigned char kprobes_old_insn[MCOUNT_INSN_SIZE];
 
-	old = ftrace_nop_replace();
+	if (unlikely(rec->flags & FTRACE_FL_EARLY_KPROBES))
+		old = kprobe_on_ftrace_get_old_insn(rec, ftrace_nop_replace(),
+				kprobes_old_insn,
+				MCOUNT_INSN_SIZE);
+	else
+#endif
+		old = ftrace_nop_replace();
 
 	return add_break(rec->ip, old);
 }
-- 
1.8.4
