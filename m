From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu,  6 Sep 2012 16:12:26 +0800
Subject: [PATCH RFC] clk: use spinlock for clk_get_rate
Message-ID: <1346919146-25972-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A nested locking issue is seen on imx6q (CA9 Quad) as below when cpufreq
driver is running.  It looks like the issue is caused by a simultaneous
call to clk_get_rate from two smp_twd threads.

1) cpu0_set_target
     cpufreq_notify_transition
       ...
         twd_cpufreq_transition
           twd_update_frequency
             clk_get_rate

2) do_exit
     kernel_init
       smp_prepare_cpus
         percpu_timer_setup
           twd_timer_setup
             clk_get_rate

The patch "clk: new locking scheme for reentrancy" does not help the
issue.  I'm not sure if this is an issue that should be fixed in
smp_twd driver or it's an use case which should be supported by clk API.

Looking at clk_get_rate() API, it just reads a cached clock rate and
should be fast enough to hold a spinlock than mutex.  It's a quick
fix to the issue, but I'm not really sure it's the correct one. That's
why this is a RFC patch.

root at freescale ~$ BUG: sleeping function called from invalid context at /home/r6
5073/repos/mxs/linux-2.6/kernel/mutex.c:269
in_atomic(): 1, irqs_disabled(): 128, pid: 38, name: kworker/0:1
4 locks held by kworker/0:1/38:
 #0:  (events){.+.+..}, at: [<80037e98>] process_one_work+0x114/0x478
 #1:  ((&(&dbs_info->work)->work)){+.+...}, at: [<80037e98>] process_one_work+0x
114/0x478
 #2:  (&this_dbs_info->timer_mutex){+.+...}, at: [<802e1bfc>] do_dbs_timer+0x38/
0x4ec
 #3:  (&nh->srcu){......}, at: [<80043bf0>] __srcu_notifier_call_chain+0x0/0xac
irq event stamp: 60956
hardirqs last  enabled at (60955): [<804012e8>] __mutex_unlock_slowpath+0xf4/0x1
6c
hardirqs last disabled at (60956): [<800684ec>] smp_call_function_single+0x194/0
x1ec
softirqs last  enabled at (59634): [<8032cca8>] neigh_periodic_work+0x170/0x1d4
softirqs last disabled at (59630): [<8040346c>] _raw_write_lock_bh+0x1c/0x6c
Backtrace:
[<80011d64>] (dump_backtrace+0x0/0x10c) from [<803fc164>] (dump_stack+0x18/0x1c)
 r6:ffff9fd8 r5:805780c0 r4:bf252000 r3:bf9fd000
[<803fc14c>] (dump_stack+0x0/0x1c) from [<80047484>] (__might_sleep+0x100/0x11c)
[<80047384>] (__might_sleep+0x0/0x11c) from [<80400edc>] (mutex_lock_nested+0x2c
/0x344)
 r6:80013c30 r5:bf252000 r4:805c2a04
[<80400eb0>] (mutex_lock_nested+0x0/0x344) from [<803089ac>] (clk_get_rate+0x1c/
0x58)
[<80308990>] (clk_get_rate+0x0/0x58) from [<80013c48>] (twd_update_frequency+0x1
8/0x50)
 r5:bf252000 r4:805cadf4
[<80013c30>] (twd_update_frequency+0x0/0x50) from [<800684f4>] (smp_call_functio
n_single+0x19c/0x1ec)
 r4:60000013 r3:bf9fd000
[<80068358>] (smp_call_function_single+0x0/0x1ec) from [<80013d48>] (twd_cpufreq
_transition+0x2c/0x38)
[<80013d1c>] (twd_cpufreq_transition+0x0/0x38) from [<80043970>] (notifier_call_
chain+0x4c/0x8c)
[<80043924>] (notifier_call_chain+0x0/0x8c) from [<80043c68>] (__srcu_notifier_c
all_chain+0x78/0xac)
 r8:ffffffff r7:80b0ab54 r6:80b0abec r5:00000001 r4:80b0ab0c
r3:ffffffff
[<80043bf0>] (__srcu_notifier_call_chain+0x0/0xac) from [<80043cbc>] (srcu_notif
ier_call_chain+0x20/0x28)
[<80043c9c>] (srcu_notifier_call_chain+0x0/0x28) from [<802dec88>] (cpufreq_noti
fy_transition+0xa8/0xdc)
[<802debe0>] (cpufreq_notify_transition+0x0/0xdc) from [<802e350c>] (cpu0_set_ta
rget+0x18c/0x2a8)
 r6:00000000 r5:80593664 r4:80593610 r3:00000004
[<802e3380>] (cpu0_set_target+0x0/0x2a8) from [<802de394>] (__cpufreq_driver_tar
get+0x70/0x88)
[<802de324>] (__cpufreq_driver_target+0x0/0x88) from [<802e2090>] (do_dbs_timer+
0x4cc/0x4ec)
 r4:805c0d28 r3:bf30de40
[<802e1bc4>] (do_dbs_timer+0x0/0x4ec) from [<80037f0c>] (process_one_work+0x188/
0x478)
[<80037d84>] (process_one_work+0x0/0x478) from [<800385bc>] (worker_thread+0x184
/0x388)
[<80038438>] (worker_thread+0x0/0x388) from [<8003d6e8>] (kthread+0x90/0x9c)
[<8003d658>] (kthread+0x0/0x9c) from [<80024870>] (do_exit+0x0/0x7ac)
 r6:80024870 r5:8003d658 r4:bf86de90

=================================
[ INFO: inconsistent lock state ]
3.5.0+ #342 Not tainted
---------------------------------
inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
swapper/1/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
 (prepare_lock){?.+...}, at: [<803089ac>] clk_get_rate+0x1c/0x58
{HARDIRQ-ON-W} state was registered at:
  [<80060b78>] mark_lock+0x154/0x670
  [<80061950>] __lock_acquire+0x8bc/0x19b4
  [<80062f14>] lock_acquire+0x68/0x7c
  [<80400f28>] mutex_lock_nested+0x78/0x344
  [<803096cc>] clk_prepare+0x20/0x40
  [<803f98a0>] twd_timer_setup+0x48/0x26c
  [<803f9590>] percpu_timer_setup+0x70/0xc8
  [<8053f79c>] smp_prepare_cpus+0x74/0x98
  [<8053b8ec>] kernel_init+0x60/0x1c8
  [<80024870>] do_exit+0x0/0x7ac
irq event stamp: 399240
hardirqs last  enabled at (399237): [<8000f1f4>] default_idle+0x3c/0x4c
hardirqs last disabled at (399238): [<8000e114>] __irq_svc+0x34/0x60
softirqs last  enabled at (399240): [<80026d78>] _local_bh_enable+0x14/0x18
softirqs last disabled at (399239): [<80027370>] irq_enter+0x68/0x78

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(prepare_lock);
  <Interrupt>
    lock(prepare_lock);

 *** DEADLOCK ***

no locks held by swapper/1/0.

stack backtrace:
Backtrace:
[<80011d64>] (dump_backtrace+0x0/0x10c) from [<803fc164>] (dump_stack+0x18/0x1c)
 r6:bf8142e0 r5:bf814000 r4:806ac794 r3:bf814000
[<803fc14c>] (dump_stack+0x0/0x1c) from [<803fd444>] (print_usage_bug+0x250/0x2b
8)
[<803fd1f4>] (print_usage_bug+0x0/0x2b8) from [<80060f90>] (mark_lock+0x56c/0x67
0)
[<80060a24>] (mark_lock+0x0/0x670) from [<80061a20>] (__lock_acquire+0x98c/0x19b
4)
[<80061094>] (__lock_acquire+0x0/0x19b4) from [<80062f14>] (lock_acquire+0x68/0x
7c)
[<80062eac>] (lock_acquire+0x0/0x7c) from [<80400f28>] (mutex_lock_nested+0x78/0
x344)
 r7:00000000 r6:bf872000 r5:805cc858 r4:805c2a04
[<80400eb0>] (mutex_lock_nested+0x0/0x344) from [<803089ac>] (clk_get_rate+0x1c/
0x58)
[<80308990>] (clk_get_rate+0x0/0x58) from [<80013c48>] (twd_update_frequency+0x1
8/0x50)
 r5:bf253d04 r4:805cadf4
[<80013c30>] (twd_update_frequency+0x0/0x50) from [<80068e20>] (generic_smp_call
_function_single_interrupt+0xd4/0x13c)
 r4:bf873ee0 r3:80013c30
[<80068d4c>] (generic_smp_call_function_single_interrupt+0x0/0x13c) from [<80013
34c>] (handle_IPI+0xc0/0x194)
 r8:00000001 r7:00000000 r6:80574e48 r5:bf872000 r4:80593958
[<8001328c>] (handle_IPI+0x0/0x194) from [<800084e8>] (gic_handle_irq+0x58/0x60)
 r8:00000000 r7:bf873f8c r6:bf873f58 r5:80593070 r4:f4000100
r3:00000005
[<80008490>] (gic_handle_irq+0x0/0x60) from [<8000e124>] (__irq_svc+0x44/0x60)
Exception stack(0xbf873f58 to 0xbf873fa0)
3f40:                                                       00000001 00000001
3f60: 00000000 bf814000 bf872000 805cab48 80405aa4 80597648 00000000 412fc09a
3f80: bf872000 bf873fac bf873f70 bf873fa0 80063844 8000f1f8 20000013 ffffffff
 r6:ffffffff r5:20000013 r4:8000f1f8 r3:bf814000
[<8000f1b8>] (default_idle+0x0/0x4c) from [<8000f428>] (cpu_idle+0x98/0x114)
[<8000f390>] (cpu_idle+0x0/0x114) from [<803f9834>] (secondary_start_kernel+0x11
c/0x140)
[<803f9718>] (secondary_start_kernel+0x0/0x140) from [<103f9234>] (0x103f9234)
 r6:10c03c7d r5:0000001f r4:4f86806a r3:803f921c

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/clk/clk.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index efdfd00..d6fb25b 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -566,11 +566,12 @@ EXPORT_SYMBOL_GPL(clk_enable);
  */
 unsigned long clk_get_rate(struct clk *clk)
 {
+	unsigned long flags;
 	unsigned long rate;
 
-	mutex_lock(&prepare_lock);
+	spin_lock_irqsave(&enable_lock, flags);
 	rate = __clk_get_rate(clk);
-	mutex_unlock(&prepare_lock);
+	spin_unlock_irqrestore(&enable_lock, flags);
 
 	return rate;
 }
-- 
1.7.5.4
