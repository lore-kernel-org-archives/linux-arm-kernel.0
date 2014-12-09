From: moon.linux@yahoo.com (Anand Moon)
Date: Tue,  9 Dec 2014 15:33:18 +0530
Subject: [PATCH v2] do_work_pending: Enable interrupts in do_work_pending()
Message-ID: <1418119398-5112-1-git-send-email-moon.linux@yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A recent change triggered a WARN_ON that interrupts were disabled,
and in fact other architectures enable interrupts uniformly for their
related do_work_pending() type code, and all the things we call from
this routine appear to expect interrupts to be enabled.  So, enable them.
Below is the warning.

v2 Remove the call of local_irq_disable during restart of signal.

[   12.094106] systemd-udevd[1643]: starting version 204
[   13.466537] ------------[ cut here ]------------
[   13.469750] WARNING: CPU: 1 PID: 1645 at kernel/locking/lockdep.c:3536 check_flags+0x7c/0x1d0()
[   13.478397] DEBUG_LOCKS_WARN_ON(current->hardirqs_enabled)
[   13.483663] Modules linked in:
[   13.486863] CPU: 1 PID: 1645 Comm: systemd-udevd Not tainted 3.17.4-arm7 #6
[   13.493851] [<c0013dc8>] (unwind_backtrace) from [<c0011208>] (show_stack+0x10/0x14)
[   13.501563] [<c0011208>] (show_stack) from [<c05df5f0>] (dump_stack+0x80/0xac)
[   13.508753] [<c05df5f0>] (dump_stack) from [<c0024594>] (warn_slowpath_common+0x60/0x84)
[   13.516808] [<c0024594>] (warn_slowpath_common) from [<c00245e4>] (warn_slowpath_fmt+0x2c/0x3c)
[   13.525463] [<c00245e4>] (warn_slowpath_fmt) from [<c006c508>] (check_flags+0x7c/0x1d0)
[   13.533447] [<c006c508>] (check_flags) from [<c006cf60>] (lock_is_held+0x34/0x60)
[   13.540884] [<c006cf60>] (lock_is_held) from [<c05e0500>] (__schedule+0x98/0x7cc)
[   13.548342] [<c05e0500>] (__schedule) from [<c0010adc>] (do_work_pending+0x28/0xbc)
[   13.555962] [<c0010adc>] (do_work_pending) from [<c000dd38>] (work_pending+0xc/0x20)
[   13.563663] ---[ end trace 33bbfa4173cfa520 ]---
[   13.568238] possible reason: unannotated irqs-off.
[   13.573005] irq event stamp: 5227
[   13.576293] hardirqs last  enabled at (5227): [<c000dd04>] ret_fast_syscall+0x24/0x48
[   13.584096] hardirqs last disabled at (5226): [<c000dcec>] ret_fast_syscall+0xc/0x48
[   13.591823] softirqs last  enabled at (5222): [<c00283b0>] __do_softirq+0x1e8/0x270
[   13.599447] softirqs last disabled at (5205): [<c00286f4>] irq_exit+0x84/0xf4
[   13.656634] random: nonblocking pool is initialized

Signed-off-by: Anand Moon <moon.linux@yahoo.com>
---
 arch/arm/kernel/signal.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index bd19834..195745a 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -574,12 +574,13 @@ asmlinkage int
 do_work_pending(struct pt_regs *regs, unsigned int thread_flags, int syscall)
 {
 	do {
+		if (unlikely(!user_mode(regs)))
+			return 0;
+
+		local_irq_enable();
 		if (likely(thread_flags & _TIF_NEED_RESCHED)) {
 			schedule();
 		} else {
-			if (unlikely(!user_mode(regs)))
-				return 0;
-			local_irq_enable();
 			if (thread_flags & _TIF_SIGPENDING) {
 				int restart = do_signal(regs, syscall);
 				if (unlikely(restart)) {
-- 
2.1.0
