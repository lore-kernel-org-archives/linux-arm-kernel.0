From: ming.lei@canonical.com (Ming Lei)
Date: Wed,  9 Dec 2015 15:23:49 +0800
Subject: [PATCH] arm64: annotate irq off before schedule
Message-ID: <1449645829-1070-1-git-send-email-ming.lei@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Before schedule in ret_to_user(), irq has been disabled,
so irq off should be annotated for killing the following
lockdep warning during kernel booting:

[   13.762775] DEBUG_LOCKS_WARN_ON(current->hardirqs_enabled)
[   13.768065] ------------[ cut here ]------------
[   13.772843] WARNING: at kernel/locking/lockdep.c:3519
[   13.777866] Modules linked in:
[   13.782398] CPU: 1 PID: 1 Comm: init Not tainted 4.4.0-rc4+ #54
[   13.788287] Hardware name: AppliedMicro Mustang/Mustang, BIOS 2.0.0 Oct 23 2015
[   13.795557] task: fffffe07c0440000 ti: fffffe07c0480000 task.ti: fffffe07c0480000
[   13.803005] PC is at check_flags.part.35+0x144/0x19c
[   13.807943] LR is at check_flags.part.35+0x144/0x19c
[   13.812882] pc : [<fffffe000011479c>] lr : [<fffffe000011479c>] pstate: 800001c5
[   13.820238] sp : fffffe07c0483d90
[   13.823534] x29: fffffe07c0483d90 x28: fffffe07c0480000
[   13.828839] x27: fffffe0000cc2000 x26: fffffe0000861bd0
[   13.834144] x25: 0000000000000001 x24: 000003ffe3504d50
[   13.839450] x23: 0000000000000000 x22: fffffe0000db5000
[   13.844755] x21: fffffe0000aba788 x20: fffffe0000ceaa98
[   13.850059] x19: fffffe0001b7e000 x18: 0000000000000000
[   13.855364] x17: 000003ffb2ba4440 x16: 000003ffb2bbd000
[   13.860670] x15: 000003ffb27241a0 x14: 0ffffffffffffffd
[   13.865975] x13: 0000000000000008 x12: 0101010101010101
[   13.871280] x11: 7f7f7f7f7f7f7f7f x10: fefefefefefeff63
[   13.876585] x9 : 000000000000013d x8 : fffffe07c0483ae0
[   13.881889] x7 : fffffe07c0440000 x6 : fffffe0000122008
[   13.887196] x5 : 0000000000000000 x4 : fffffe0000cc2000
[   13.892501] x3 : fffffe07c0483c10 x2 : 0000000000000002
[   13.897807] x1 : 0000000000000000 x0 : 000000000000002e
[   13.904593] ---[ end trace 42e2299dc2cf1b7d ]---
[   13.909184] Call trace:
[   13.911618] [<fffffe000011479c>] check_flags.part.35+0x144/0x19c
[   13.917594] [<fffffe00001151a4>] lock_is_held+0x7c/0x88
[   13.922793] [<fffffe000012c514>] rcu_read_lock_sched_held+0xa0/0xac
[   13.929028] [<fffffe0000132fe4>] rcu_note_context_switch+0x28c/0x56c
[   13.935350] [<fffffe0000861020>] __schedule+0x4c/0xa28
[   13.940462] [<fffffe0000861bd0>] schedule+0x40/0xa0
[   13.945315] [<fffffe0000093bb0>] ret_to_user+0x0/0x24
[   13.950339] possible reason: unannotated irqs-off.
[   13.955104] irq event stamp: 2488963
[   13.958660] hardirqs last  enabled at (2488963): [<fffffe0000093a98>] el0_irq_naked+0x1c/0x24
[   13.967151] hardirqs last disabled at (2488962): [<fffffe0000093a84>] el0_irq_naked+0x8/0x24
[   13.975557] softirqs last  enabled at (2488958): [<fffffe00000cb1f4>] __do_softirq+0x308/0x4f8
[   13.984137] softirqs last disabled at (2488935): [<fffffe00000cb6f0>] irq_exit+0x9c/0xec

Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 arch/arm64/kernel/entry.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 7ed3d75..4769190 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -634,6 +634,9 @@ work_pending:
 	bl	do_notify_resume
 	b	ret_to_user
 work_resched:
+#ifdef CONFIG_TRACE_IRQFLAGS
+	bl	trace_hardirqs_off
+#endif
 	bl	schedule
 
 /*
-- 
1.9.1
