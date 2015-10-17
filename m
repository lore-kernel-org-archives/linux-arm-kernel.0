From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Sat, 17 Oct 2015 14:28:11 +0000
Subject: [PATCH v3] arm64: Synchronise dump_backtrace() with perf callchain
Message-ID: <1445092091-12373-1-git-send-email-jungseoklee85@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Unlike perf callchain relying on walk_stackframe(), dump_backtrace()
has its own backtrace logic. A major difference between them is the
moment a symbol is recorded. Perf writes down a symbol *before*
calling unwind_frame(), but dump_backtrace() prints it out *after*
unwind_frame(). As a result, the last valid symbol cannot be hooked
in case of dump_backtrace(). This patch addresses the issue as
synchronising dump_backtrace() with perf callchain.

A simple test and its results are as follows:

- crash trigger

 $ sudo echo c > /proc/sysrq-trigger

- current status

 Call trace:
 [<fffffe00003dc738>] sysrq_handle_crash+0x24/0x30
 [<fffffe00003dd2ac>] __handle_sysrq+0x128/0x19c
 [<fffffe00003dd730>] write_sysrq_trigger+0x60/0x74
 [<fffffe0000249fc4>] proc_reg_write+0x84/0xc0
 [<fffffe00001f2638>] __vfs_write+0x44/0x104
 [<fffffe00001f2e60>] vfs_write+0x98/0x1a8
 [<fffffe00001f3730>] SyS_write+0x50/0xb0

- with this change

 Call trace:
 [<fffffe00003dc738>] sysrq_handle_crash+0x24/0x30
 [<fffffe00003dd2ac>] __handle_sysrq+0x128/0x19c
 [<fffffe00003dd730>] write_sysrq_trigger+0x60/0x74
 [<fffffe0000249fc4>] proc_reg_write+0x84/0xc0
 [<fffffe00001f2638>] __vfs_write+0x44/0x104
 [<fffffe00001f2e60>] vfs_write+0x98/0x1a8
 [<fffffe00001f3730>] SyS_write+0x50/0xb0
 [<fffffe00000939ec>] el0_svc_naked+0x20/0x28

Note that this patch does not cover a case where MMU is disabled. The
last stack frame of swapper, for example, has PC in a form of physical
address. Unfortunately, a simple conversion using phys_to_virt() cannot
cover all scenarios since PC is retrieved from LR - 4, not LR. It is
a big tradeoff to change both head.S and unwind_frame() for only a few
of symbols in *.S. Thus, this hunk does not take care of the case.

Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: James Morse <james.morse@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Jungseok Lee <jungseoklee85@gmail.com>
---
Changes since v2:
- Fixed a typo and mixed data in the commit msg

Changes since v1:
- Added an example to the commit msg, per Will
- Modified a comment

 arch/arm64/kernel/traps.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index f93aae5..e9b9b53 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -103,12 +103,12 @@ static void dump_mem(const char *lvl, const char *str, unsigned long bottom,
 	set_fs(fs);
 }
 
-static void dump_backtrace_entry(unsigned long where, unsigned long stack)
+static void dump_backtrace_entry(unsigned long where)
 {
+	/*
+	 * Note that 'where' can have a physical address, but it's not handled.
+	 */
 	print_ip_sym(where);
-	if (in_exception_text(where))
-		dump_mem("", "Exception stack", stack,
-			 stack + sizeof(struct pt_regs), false);
 }
 
 static void dump_instr(const char *lvl, struct pt_regs *regs)
@@ -172,12 +172,17 @@ static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 	pr_emerg("Call trace:\n");
 	while (1) {
 		unsigned long where = frame.pc;
+		unsigned long stack;
 		int ret;
 
+		dump_backtrace_entry(where);
 		ret = unwind_frame(&frame);
 		if (ret < 0)
 			break;
-		dump_backtrace_entry(where, frame.sp);
+		stack = frame.sp;
+		if (in_exception_text(where))
+			dump_mem("", "Exception stack", stack,
+				 stack + sizeof(struct pt_regs), false);
 	}
 }
 
-- 
2.5.0
