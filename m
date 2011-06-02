From: ming.lei@canonical.com (Ming Lei)
Date: Thu, 2 Jun 2011 16:46:09 +0800
Subject: arm: fix lockdep warning of "unannotated irqs-off"(v2)
Message-ID: <20110602164609.3ad67e37@tom-ThinkPad-T410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From 6dff1e25a75f0fd99b115c96564444952c0a2cc6 Mon Sep 17 00:00:00 2001
From: Ming Lei <ming.lei@canonical.com>
Date: Wed, 1 Jun 2011 15:02:24 +0800
Subject: [PATCH] arm: fix lockdep warning of "unannotated irqs-off"(v2)

This patch fixes the lockdep warning of "unannotated irqs-off"[1].

After entering __irq_usr, arm core has disabled interrupt automatically,
but __irq_usr does not annotate the irq disable, so lockdep may complain
the warning if it has chance to check this in irq handler.

This patch adds trace_hardirqs_off in __irq_usr before entering irq_handler
to handle the irq, also calls ret_to_user_from_irq to avoid calling
disable_irq again.

This is also a fix for irq off tracer.

[1], lockdep warning log of "unannotated irqs-off"

[   13.804687] ------------[ cut here ]------------
[   13.809570] WARNING: at kernel/lockdep.c:3335 check_flags+0x78/0x1d0()
[   13.816467] Modules linked in:
[   13.819732] Backtrace:
[   13.822357] [<c01cb42c>] (dump_backtrace+0x0/0x100) from [<c06abb14>] (dump_stack+0x20/0x24)
[   13.831268]  r6:c07d8c2c r5:00000d07 r4:00000000 r3:00000000
[   13.837280] [<c06abaf4>] (dump_stack+0x0/0x24) from [<c01ffc04>] (warn_slowpath_common+0x5c/0x74)
[   13.846649] [<c01ffba8>] (warn_slowpath_common+0x0/0x74) from [<c01ffc48>] (warn_slowpath_null+0x2c/0x34)
[   13.856781]  r8:00000000 r7:00000000 r6:c18b8194 r5:60000093 r4:ef182000
[   13.863708] r3:00000009
[   13.866485] [<c01ffc1c>] (warn_slowpath_null+0x0/0x34) from [<c0237d84>] (check_flags+0x78/0x1d0)
[   13.875823] [<c0237d0c>] (check_flags+0x0/0x1d0) from [<c023afc8>] (lock_acquire+0x4c/0x150)
[   13.884704] [<c023af7c>] (lock_acquire+0x0/0x150) from [<c06af638>] (_raw_spin_lock+0x4c/0x84)
[   13.893798] [<c06af5ec>] (_raw_spin_lock+0x0/0x84) from [<c01f9a44>] (sched_ttwu_pending+0x58/0x8c)
[   13.903320]  r6:ef92d040 r5:00000003 r4:c18b8180
[   13.908233] [<c01f99ec>] (sched_ttwu_pending+0x0/0x8c) from [<c01f9a90>] (scheduler_ipi+0x18/0x1c)
[   13.917663]  r6:ef183fb0 r5:00000003 r4:00000000 r3:00000001
[   13.923645] [<c01f9a78>] (scheduler_ipi+0x0/0x1c) from [<c01bc458>] (do_IPI+0x9c/0xfc)
[   13.932006] [<c01bc3bc>] (do_IPI+0x0/0xfc) from [<c06b0888>] (__irq_usr+0x48/0xe0)
[   13.939971] Exception stack(0xef183fb0 to 0xef183ff8)
[   13.945281] 3fa0:                                     ffffffc3 0001500c 00000001 0001500c
[   13.953948] 3fc0: 00000050 400b45f0 400d9000 00000000 00000001 400d9600 6474e552 bea05b3c
[   13.962585] 3fe0: 400d96c0 bea059c0 400b6574 400b65d8 20000010 ffffffff
[   13.969573]  r6:00000403 r5:fa240100 r4:ffffffff r3:20000010
[   13.975585] ---[ end trace efc4896ab0fb62cb ]---
[   13.980468] possible reason: unannotated irqs-off.
[   13.985534] irq event stamp: 1610
[   13.989044] hardirqs last  enabled at (1610): [<c01c703c>] no_work_pending+0x8/0x2c
[   13.997131] hardirqs last disabled at (1609): [<c01c7024>] ret_slow_syscall+0xc/0x1c
[   14.005371] softirqs last  enabled at (0): [<c01fe5e4>] copy_process+0x2cc/0xa24
[   14.013183] softirqs last disabled at (0): [<  (null)>]   (null)

Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 arch/arm/kernel/entry-armv.S   |    6 +++++-
 arch/arm/kernel/entry-common.S |    2 ++
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index e8d8856..90c62cd 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -435,6 +435,10 @@ __irq_usr:
 	usr_entry
 	kuser_cmpxchg_check
 
+#ifdef CONFIG_IRQSOFF_TRACER
+	bl	trace_hardirqs_off
+#endif
+
 	get_thread_info tsk
 #ifdef CONFIG_PREEMPT
 	ldr	r8, [tsk, #TI_PREEMPT]		@ get preempt count
@@ -453,7 +457,7 @@ __irq_usr:
 #endif
 
 	mov	why, #0
-	b	ret_to_user
+	b	ret_to_user_from_irq
  UNWIND(.fnend		)
 ENDPROC(__irq_usr)
 
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 1e7b04a..b2a27b6 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -64,6 +64,7 @@ work_resched:
 ENTRY(ret_to_user)
 ret_slow_syscall:
 	disable_irq				@ disable interrupts
+ENTRY(ret_to_user_from_irq)
 	ldr	r1, [tsk, #TI_FLAGS]
 	tst	r1, #_TIF_WORK_MASK
 	bne	work_pending
@@ -75,6 +76,7 @@ no_work_pending:
 	arch_ret_to_user r1, lr
 
 	restore_user_regs fast = 0, offset = 0
+ENDPROC(ret_to_user_from_irq)
 ENDPROC(ret_to_user)
 
 /*
-- 
1.7.4.1



--
Ming Lei
