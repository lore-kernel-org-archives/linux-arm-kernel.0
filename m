From: yang.shi@linaro.org (Yang Shi)
Date: Fri,  5 Feb 2016 15:04:47 -0800
Subject: [PATCH] arm64: disable kasan when accessing frame->fp in unwind_frame
Message-ID: <1454713487-5239-1-git-send-email-yang.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When boot arm64 kernel with KASAN enabled, the below error is reported by
kasan:

BUG: KASAN: out-of-bounds in unwind_frame+0xec/0x260 at addr ffffffc064d57ba0
Read of size 8 by task pidof/499
page:ffffffbdc39355c0 count:0 mapcount:0 mapping:          (null) index:0x0
flags: 0x0()
page dumped because: kasan: bad access detected
CPU: 2 PID: 499 Comm: pidof Not tainted 4.5.0-rc1 #119
Hardware name: Freescale Layerscape 2085a RDB Board (DT)
Call trace:
[<ffffffc00008d078>] dump_backtrace+0x0/0x290
[<ffffffc00008d32c>] show_stack+0x24/0x30
[<ffffffc0006a981c>] dump_stack+0x8c/0xd8
[<ffffffc0002e4400>] kasan_report_error+0x558/0x588
[<ffffffc0002e4958>] kasan_report+0x60/0x70
[<ffffffc0002e3188>] __asan_load8+0x60/0x78
[<ffffffc00008c92c>] unwind_frame+0xec/0x260
[<ffffffc000087e60>] get_wchan+0x110/0x160
[<ffffffc0003b647c>] do_task_stat+0xb44/0xb68
[<ffffffc0003b7730>] proc_tgid_stat+0x40/0x50
[<ffffffc0003ac840>] proc_single_show+0x88/0xd8
[<ffffffc000345be8>] seq_read+0x370/0x770
[<ffffffc00030aba0>] __vfs_read+0xc8/0x1d8
[<ffffffc00030c0ec>] vfs_read+0x94/0x168
[<ffffffc00030d458>] SyS_read+0xb8/0x128
[<ffffffc000086530>] el0_svc_naked+0x24/0x28
Memory state around the buggy address:
 ffffffc064d57a80: 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00 00 f4 f4
 ffffffc064d57b00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffffc064d57b80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
                                  ^
 ffffffc064d57c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffffc064d57c80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Since the shadow byte pointed by the report is 0, so it may mean it is just hit
oob in non-current task. So, disable the instrumentation here.

Signed-off-by: Yang Shi <yang.shi@linaro.org>
---
 arch/arm64/kernel/stacktrace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 4fad978..88278c2 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -20,6 +20,7 @@
 #include <linux/ftrace.h>
 #include <linux/sched.h>
 #include <linux/stacktrace.h>
+#include <linux/kasan.h>
 
 #include <asm/irq.h>
 #include <asm/stacktrace.h>
@@ -64,7 +65,9 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
 		return -EINVAL;
 
 	frame->sp = fp + 0x10;
+	kasan_disable_current();
 	frame->fp = *(unsigned long *)(fp);
+	kasan_enable_current();
 	frame->pc = *(unsigned long *)(fp + 8);
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-- 
2.0.2
