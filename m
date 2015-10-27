From: yangyingliang@huawei.com (Yang Yingliang)
Date: Tue, 27 Oct 2015 21:21:13 +0800
Subject: [PATCH 2/2] arm64: validate the delta of cycle_now and cycle_last
In-Reply-To: <1445952073-7260-1-git-send-email-yangyingliang@huawei.com>
References: <1445952073-7260-1-git-send-email-yangyingliang@huawei.com>
Message-ID: <1445952073-7260-3-git-send-email-yangyingliang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In multi-core system, if the clock is not sync perfectly, it
will make cycle_last that recorded by CPU-A is a little more
than cycle_now that read by CPU-B. With the negative result,
hrtimer_update_base() return a huge and wrong time. It leads
to the cpu can not finish the while loop in hrtimer_interrupt()
until the real nowtime which is returned from ktime_get() catch
up with the wrong time on clock monotonic base.

I was able to reproudce the problem with calling clock_settime
and clock_adjtime repeatedly on each cpu. The params of the calls
is random. Here is the calltrace:

Jan 01 00:02:29 Linux kernel: INFO: rcu_sched detected stalls on CPUs/tasks:
Jan 01 00:02:29 Linux kernel:         0: (2 GPs behind) idle=913/1/0 softirq=59289/59291 fqs=488
Jan 01 00:02:29 Linux kernel:         (detected by 20, t=5252 jiffies, g=35769, c=35768, q=567)
Jan 01 00:02:29 Linux kernel: Task dump for CPU 0:
Jan 01 00:02:29 Linux kernel: swapper/0       R  running task        0   0      0 0x00000002
Jan 01 00:02:29 Linux kernel: Call trace:
Jan 01 00:02:29 Linux kernel: [<ffffffc000086c5c>] __switch_to+0x74/0x8c
Jan 01 00:02:29 Linux kernel: rcu_sched kthread starved for 4764 jiffies!
Jan 01 00:03:32 Linux kernel: NMI watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [swapper/0:0]
Jan 01 00:03:32 Linux kernel: CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.1.6+ #184
Jan 01 00:03:32 Linux kernel: task: ffffffc00091cdf0 ti: ffffffc000910000 task.ti: ffffffc000910000
Jan 01 00:03:32 Linux kernel: PC is at arch_cpu_idle+0x10/0x18
Jan 01 00:03:32 Linux kernel: LR is at arch_cpu_idle+0xc/0x18
Jan 01 00:03:32 Linux kernel: pc : [<ffffffc00008686c>] lr : [<ffffffc000086868>] pstate: 60000145
Jan 01 00:03:32 Linux kernel: sp : ffffffc000913f20
Jan 01 00:03:32 Linux kernel: x29: ffffffc000913f20 x28: 000000003f4bbab0
Jan 01 00:03:32 Linux kernel: x27: ffffffc00091669c x26: ffffffc00096e000
Jan 01 00:03:32 Linux kernel: x25: ffffffc000804000 x24: ffffffc000913f30
Jan 01 00:03:32 Linux kernel: x23: 0000000000000001 x22: ffffffc0006817f8
Jan 01 00:03:32 Linux kernel: x21: ffffffc0008fdb00 x20: ffffffc000916618
Jan 01 00:03:32 Linux kernel: x19: ffffffc000910000 x18: 00000000ffffffff
Jan 01 00:03:32 Linux kernel: x17: 0000007f9d6f682c x16: ffffffc0001e19d0
Jan 01 00:03:32 Linux kernel: x15: 0000000000000061 x14: 0000000000000072
Jan 01 00:03:32 Linux kernel: x13: 0000000000000067 x12: ffffffc000682528
Jan 01 00:03:32 Linux kernel: x11: 0000000000000005 x10: 00000001000faf9a
Jan 01 00:03:32 Linux kernel: x9 : ffffffc000913e60 x8 : ffffffc00091d350
Jan 01 00:03:32 Linux kernel: x7 : 0000000000000000 x6 : 002b24c4f00026aa
Jan 01 00:03:32 Linux kernel: x5 : 0000001ffd5c6000 x4 : ffffffc000913ea0
Jan 01 00:03:32 Linux kernel: x3 : ffffffdffdec3b44 x2 : ffffffdffdec3b44
Jan 01 00:03:32 Linux kernel: x1 : 0000000000000000 x0 : 0000000000000000

CPU-A updates the cycle_last in do_settimeofday64() under lock and CPU-B
reads the current cycles which is slightly behind CPU-A to substract the
cycle_last after unlock, then we get a negative result, after masking it
comes to a extremely huge value and lead to "hang" in hrtimer_interrupt().

And multi-core system on X86 had already met such problem and Thomas introduce
a fix which is commit 47001d603375 ("x86: tsc prevent time going backwards").
And then Thomas moved the fix code into the core code file of time in
commit 09ec54429c6d ("clocksource: Move cycle_last validation to core code").
Now the validation can be enabled by config CLOCKSOURCE_VALIDATE_LAST_CYCLE.
I think we can fix the problem on arm64 by selecting the config. This is no
side effect for systems with counters running properly.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 07d1811..6a53926 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -30,6 +30,7 @@ config ARM64
 	select GENERIC_ALLOCATOR
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CLOCKEVENTS_BROADCAST
+	select CLOCKSOURCE_VALIDATE_LAST_CYCLE
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_EARLY_IOREMAP
 	select GENERIC_IDLE_POLL_SETUP
-- 
2.5.0
