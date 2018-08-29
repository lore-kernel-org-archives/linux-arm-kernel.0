From: dingtianhong@huawei.com (Ding Tianhong)
Date: Wed, 29 Aug 2018 18:17:30 +0800
Subject: [PATCH RESEND] arm64: don't dump stack for usermode address in
 show_regs
Message-ID: <0003f02c-fc35-b4e9-3d3d-82ee8d02acb7@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I met this problem when do some testcase on my arm64 board system:

160935.412546] BUG: soft lockup - CPU#0 stuck for 116s! [cce_hlt_no_shar:12141]
[160935.413292] CPU: 0 PID: 12141 Comm: cce_hlt_no_shar Tainted: G
[160935.413429] Hardware name: Hisilicon Phosphorxxxx ESL (DT)
[160935.413571] task: ffff800024efe300 ti: ffff80001670c000 task.ti: ffff80001670c000
[160935.413711] PC is at 0xffffa0bf76b0
[160935.413818] LR is at 0xffffa0c003a8
[160935.413936] pc : [<0000ffffa0bf76b0>] lr : [<0000ffffa0c003a8>] pstate: 20000000
[160935.414060] sp : 0000ffff9ed56d00
[160935.414157] x29: 0000ffff9ed56d00 x28: 0000ffffa0eae6f0
[160935.414307] x27: 0000ffff9ed57c60 x26: 0000000000000000
[160935.414456] x25: 0000ffffa0a33250 x24: 0000000000001000
[160935.414605] x23: 0000ffffa0a37320 x22: 0000ffffa0eae000
[160935.414754] x21: 0000000000002d2a x20: 0000ffff9ed58840
[160935.414903] x19: 0000000000000005 x18: 0000ffffcda37490
[160935.415053] x17: 0000ffffa0c0033c x16: 0000ffffa0c4cc60
[160935.415206] x15: 00312d6898000000 x14: 0000ffffa0c2670e
[160935.415354] x13: 000000000000016e x12: 0000000000000000
[160935.415502] x11: 0000ffff9ed56e00 x10: 0000000000000020
[160935.415652] x9 : 2079726f00000000 x8 : 0000000000000040
[160935.415796] x7 : 0000000000000000 x6 : 0000ffff9ed58290
[160935.415943] x5 : 0000000000000000 x4 : 0000000000000000
[160935.416089] x3 : 0000000000000000 x2 : 0000000000000000
[160935.416236] x1 : 00000000ffff0000 x0 : 0000000000000005
[160935.416371] Call trace:
[160935.416477] Unable to handle kernel paging request at virtual address ffff9ed56d00
[160935.416604] pgd = ffff800011991000
[160935.416705] [ffff9ed56d00] *pgd=00000000193a0003, *pud=000000001e447003, ....
[160935.416954] Internal error: Oops: 9600000f [#1] SMP
[160935.417686] CPU: 0 PID: 12141 Comm: cce_hlt_no_shar Tainted: G
[160935.417822] Hardware name: Hisilicon Phosphorxxxx ESL (DT)
[160935.417964] task: ffff800024efe300 ti: ffff80001670c000 task.ti: ffff80001670c000
[160935.418138] PC is at unwind_frame+0x38/0x60
[160935.418287] LR is at dump_backtrace+0x58/0x148
160935.418413] pc : [<ffff800000089428>] lr : [<ffff800000089740>] pstate: 404001c5
[160935.418540] sp : ffff80001670fbe0
[160935.418635] x29: ffff80001670fbe0 x28: 00000000ee6b2800
[160935.418785] x27: ffff8000281aa3a0 x26: ffff800000941388
[160935.418937] x25: ffff80001670feb0 x24: 0000000000000074
[160935.419088] x23: ffff800000815598 x22: ffff800000081800
[160935.419240] x21: ffff800000081000 x20: ffff800000941388
[160935.419391] x19: 0000ffffa0bf76b0 x18: 0000000000000010
[160935.419540] x17: 0000ffffa0c0033c x16: 0000ffffa0c4cc60
[160935.419689] x15: 0000000000000000 x14: ffff800080a732b7
[160935.419841] x13: ffff800000a732c6 x12: 0000000000000002
[160935.419987] x11: 0000000000000000 x10: 0000000000027ea8
[160935.420134] x9 : 0000000000000000 x8 : 0000000000065a73
[160935.420284] x7 : ffff800000961568 x6 : ffff8000003e2e70
[160935.420431] x5 : 0000000000000001 x4 : 0000000000000000
[160935.420578] x3 : 0000ffff9ed56d10 x2 : 0000ffff9ed56d00
[160935.420725] x1 : 0000000000000000 x0 : ffff80001670fc20
[160935.420896] Process cce_hlt_no_shar (pid: 12141, stack limit = 0xffff80001670c020)
......
[160935.427658] Call trace:
[160935.427804] [<ffff800000089428>] unwind_frame+0x38/0x60
[160935.427961] [<ffff800000085c80>] show_regs+0x20/0x30
[160935.428123] [<ffff80000014e6d4>] watchdog_timer_fn+0x204/0x260
[160935.428292] [<ffff80000011e1e0>] __run_hrtimer+0x60/0x208
[160935.428464] [<ffff80000011ee88>] hrtimer_interrupt+0xf8/0x288
[160935.428627] [<ffff80000053dae8>] arch_timer_handler_phys+0x30/0x40
[160935.428792] [<ffff80000010f36c>] handle_percpu_devid_irq+0x84/0x230
[160935.428971] [<ffff80000010ac14>] generic_handle_irq+0x34/0x50
[160935.429148] [<ffff80000010af2c>] __handle_domain_irq+0x5c/0xb0
[160935.429299] [<ffff800000081d2c>] gic_handle_irq+0xac/0x1b4

--------------------------------- cut here --------------------------------------

Obviously the cce_hlt_no_shar was in loop issues, the soft watchdog catch this
error and try to dump stack, then the bug hit.

The reason is that the patch 1149aad10b ("arm64: Add dump_backtrace() in show_regs")
would help to dump the stack when debug in the socklockups, but if the issues
happened in the user space, it will be errors when dumping the usermode
address in kernel, so fix this problem by avoid dumping stack for usermode address
in show_regs.

Fixes: 1149aad10b ("arm64: Add dump_backtrace() in show_regs")
Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
---
 arch/arm64/kernel/process.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 7f1628e..454825a 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -249,7 +249,9 @@ void __show_regs(struct pt_regs *regs)
 void show_regs(struct pt_regs * regs)
 {
 	__show_regs(regs);
-	dump_backtrace(regs, NULL);
+
+	if (!user_mode(regs))
+		dump_backtrace(regs, NULL);
 }

 static void tls_thread_flush(void)
-- 
1.8.3.1
