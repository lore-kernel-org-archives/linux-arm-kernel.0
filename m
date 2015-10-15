From: huawei.libin@huawei.com (Li Bin)
Date: Thu, 15 Oct 2015 20:12:35 +0800
Subject: [PATCH] arm64: ftrace: function_graph: dump real return addr in call
 trace
Message-ID: <1444911155-17480-1-git-send-email-huawei.libin@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When using function graph tracer, the printed call trace will be as
following that has many ftrace_graph_caller (return_to_handler - 4),
which is been placed in the stack by ftrace_graph tracer to replace
the real return address.

    [  198.582568] Call trace:
    [  198.583313] [<ffffffc0002a1070>] next_tgid+0x30/0x100
    [  198.584359] [<ffffffc0000907bc>] ftrace_graph_caller+0x6c/0x70
    [  198.585503] [<ffffffc0000907bc>] ftrace_graph_caller+0x6c/0x70
    [  198.586574] [<ffffffc0000907bc>] ftrace_graph_caller+0x6c/0x70
    [  198.587660] [<ffffffc0000907bc>] ftrace_graph_caller+0x6c/0x70
    [  198.588896] Code: aa0003f5 2a0103f4 b4000102 91004043 (885f7c60)
    [  198.591092] ---[ end trace 6a346f8f20949ac8 ]---

This patch fix it, and dump the real return address in the call trace.

Signed-off-by: Li Bin <huawei.libin@huawei.com>
---
 arch/arm64/kernel/traps.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index f93aae5..4a4e679 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -143,9 +143,38 @@ static void dump_instr(const char *lvl, struct pt_regs *regs)
 	set_fs(fs);
 }
 
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+static void print_ftrace_graph_addr(unsigned long addr,
+					struct task_struct *tsk,
+					unsigned long sp, int *graph)
+{
+	unsigned long ret_addr;
+	int index = tsk->curr_ret_stack;
+
+	if (addr != ((unsigned long)return_to_handler - 4))
+		return;
+
+	if (!tsk->ret_stack || index < *graph)
+		return;
+
+	index -= *graph;
+	ret_addr = tsk->ret_stack[index].ret;
+
+	dump_backtrace_entry(ret_addr - 4, sp);
+
+	(*graph)++;
+}
+#else
+static inline void print_ftrace_graph_addr(unsigned long addr,
+					struct task_struct *tsk,
+					unsigned long sp, int *graph)
+{}
+#endif
+
 static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 {
 	struct stackframe frame;
+	int graph = 0;
 
 	pr_debug("%s(regs = %p tsk = %p)\n", __func__, regs, tsk);
 
@@ -177,7 +206,9 @@ static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 		ret = unwind_frame(&frame);
 		if (ret < 0)
 			break;
+
 		dump_backtrace_entry(where, frame.sp);
+		print_ftrace_graph_addr(where, tsk, frame.sp, &graph);
 	}
 }
 
-- 
1.7.12.4
