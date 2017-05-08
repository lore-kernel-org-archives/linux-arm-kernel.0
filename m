From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Mon, 8 May 2017 21:56:55 +0800
Subject: [PATCH 2/2] arm64: Add dump_backtrace() in show_regs
In-Reply-To: <1494251815-55961-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1494251815-55961-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1494251815-55961-2-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the system trigger a softlockup(eg, infinite loop when
PREEMPT_NONE), it only shows regs without stack trace, which
makes it difficult to adress the issue.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/include/asm/stacktrace.h | 1 +
 arch/arm64/kernel/process.c         | 1 +
 arch/arm64/kernel/traps.c           | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
index 801a16db..5b6eafc 100644
--- a/arch/arm64/include/asm/stacktrace.h
+++ b/arch/arm64/include/asm/stacktrace.h
@@ -30,5 +30,6 @@ struct stackframe {
 extern int unwind_frame(struct task_struct *tsk, struct stackframe *frame);
 extern void walk_stackframe(struct task_struct *tsk, struct stackframe *frame,
 			    int (*fn)(struct stackframe *, void *), void *data);
+extern void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk);
 
 #endif	/* __ASM_STACKTRACE_H */
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index ae2a835..af1ea25 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -210,6 +210,7 @@ void __show_regs(struct pt_regs *regs)
 void show_regs(struct pt_regs * regs)
 {
 	__show_regs(regs);
+	dump_backtrace(regs, NULL);
 }
 
 static void tls_thread_flush(void)
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index d4d6ae0..368c3c8 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -140,7 +140,7 @@ static void dump_instr(const char *lvl, struct pt_regs *regs)
 	}
 }
 
-static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
+void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 {
 	struct stackframe frame;
 	unsigned long irq_stack_ptr;
-- 
1.7.12.4
