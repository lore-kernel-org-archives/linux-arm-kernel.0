From: wangnan0@huawei.com (Wang Nan)
Date: Mon, 2 Mar 2015 22:25:07 +0800
Subject: [RFC PATCH v4 29/34] ftrace: x86: call kprobe_int3_handler() in
 ftrace int3 handler.
In-Reply-To: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
References: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1425306312-3437-30-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since early kprobes and ftrace both use int3 (ftrace insert int3 to the
first byte of ftrace entry, fill other bytes of the inserted 'call'
instruction and finally restore the first byte, while kprobe rely on
int3 to trigger its actions), it is possible that a breakpoint is shared
between ftrace and an early kprobe on it. Let ftrace_int3_handler() deal
with this confliction by calling kprobe_int3_handler() before it jump
to next instruction to avoid lost event during ftrace inserting 'call'
instruction.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 arch/x86/kernel/ftrace.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index f200cd4..0a86c7c 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -302,7 +302,17 @@ int ftrace_int3_handler(struct pt_regs *regs)
 	if (!ftrace_location(ip) && !is_ftrace_caller(ip))
 		return 0;
 
-	regs->ip += MCOUNT_INSN_SIZE - 1;
+	/*
+	 * During converting early kprobes on ftrace to ftrace, it is
+	 * possible to hit a breakpoint belong to both ftrace and
+	 * kprobe. Call kprobe_int3_handler() to avoid missing events.
+	 * Note that even if kprobe is optimized, breakpoint based
+	 * kprobe should still be functional.
+	 */
+#if defined(CONFIG_EARLY_KPROBES) && defined(CONFIG_KPROBES_ON_FTRACE)
+	if (!kprobe_int3_handler(regs))
+#endif
+		regs->ip += MCOUNT_INSN_SIZE - 1;
 
 	return 1;
 }
-- 
1.8.4
