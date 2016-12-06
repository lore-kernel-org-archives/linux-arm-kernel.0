From: abelvesa@linux.com (Abel Vesa)
Date: Tue,  6 Dec 2016 17:06:02 +0000
Subject: [PATCH 2/7] arm: ftrace: Add call modify mechanism
In-Reply-To: <1481043967-15602-1-git-send-email-abelvesa@linux.com>
References: <1481043967-15602-1-git-send-email-abelvesa@linux.com>
Message-ID: <1481043967-15602-3-git-send-email-abelvesa@linux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Function ftrace_modify_call provides a way to replace ftrace_stub
with the ftrace function. This helps the klp_ftrace_handler to be
called via ftrace_ops_no_ops, which in turn will set the pc with
the patched function's starting address. This is used for
livepatching.

Signed-off-by: Abel Vesa <abelvesa@linux.com>
---
 arch/arm/kernel/ftrace.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
index 3f17594..cb4543a 100644
--- a/arch/arm/kernel/ftrace.c
+++ b/arch/arm/kernel/ftrace.c
@@ -139,6 +139,15 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 
 	ret = ftrace_modify_code(pc, 0, new, false);
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+	if (!ret) {
+		pc = (unsigned long)&ftrace_regs_call;
+		new = ftrace_call_replace(pc, (unsigned long)func);
+
+		ret = ftrace_modify_code(pc, 0, new, false);
+	}
+#endif
+
 #ifdef CONFIG_OLD_MCOUNT
 	if (!ret) {
 		pc = (unsigned long)&ftrace_call_old;
@@ -151,6 +160,18 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 	return ret;
 }
 
+int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
+	       unsigned long addr)
+{
+	unsigned long pc = rec->ip;
+	u32 old, new;
+
+	old = arm_gen_branch(pc, old_addr);
+	new = arm_gen_branch(pc, addr);
+
+	return ftrace_modify_code(pc, old, new, true);
+}
+
 int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 {
 	unsigned long new, old;
-- 
2.7.4
