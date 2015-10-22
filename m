From: yangyingliang@huawei.com (Yang Yingliang)
Date: Thu, 22 Oct 2015 14:43:17 +0800
Subject: Problem about CPU stalling in hrtimer_intterrupts()
Message-ID: <56288585.40204@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

I got the following call trace when I called some set time syscalls in 
userspace.

---start---
Jan 01 00:02:29 Linux kernel: INFO: rcu_sched detected stalls on CPUs/tasks:
Jan 01 00:02:29 Linux kernel:         0: (2 GPs behind) idle=913/1/0 
softirq=59289/59291 fqs=488
Jan 01 00:02:29 Linux kernel:         (detected by 20, t=5252 jiffies, 
g=35769, c=35768, q=567)
Jan 01 00:02:29 Linux kernel: Task dump for CPU 0:
Jan 01 00:02:29 Linux kernel: swapper/0       R  running task        0 
   0      0 0x00000002
Jan 01 00:02:29 Linux kernel: Call trace:
Jan 01 00:02:29 Linux kernel: [<ffffffc000086c5c>] __switch_to+0x74/0x8c
Jan 01 00:02:29 Linux kernel: rcu_sched kthread starved for 4764 jiffies!
Jan 01 00:03:32 Linux kernel: NMI watchdog: BUG: soft lockup - CPU#0 
stuck for 23s! [swapper/0:0]
Jan 01 00:03:32 Linux kernel: CPU: 0 PID: 0 Comm: swapper/0 Not tainted 
4.1.6+ #184
Jan 01 00:03:32 Linux kernel: task: ffffffc00091cdf0 ti: 
ffffffc000910000 task.ti: ffffffc000910000
Jan 01 00:03:32 Linux kernel: PC is at arch_cpu_idle+0x10/0x18
Jan 01 00:03:32 Linux kernel: LR is at arch_cpu_idle+0xc/0x18
Jan 01 00:03:32 Linux kernel: pc : [<ffffffc00008686c>] lr : 
[<ffffffc000086868>] pstate: 60000145
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
---end---


I use the kernel-4.1.6 running on arm64.
My testcase is that it calls clock_settime and clock_adjtime alternately 
with random params on each core. My system has 32 cores.

I found the cpu stalling in  hrtimer_intterrupts(). So I added some 
debug info in hrtimer_intterrupts() and found that the while loop runs 
1020437660 times and takes 98761 jiffies(HZ=250).

Some debug log is here:
---start---
Jan 01 00:03:32 Linux kernel: i:0 basenow.tv64:4809284991830 
hrtimer_get_softexpires_tv64(timer):4440120000000 ccpu0 
timer:ffffffdffdec6138, timer->function:ffffffc000129b84
Jan 01 00:03:32 Linux kernel: i:0 basenow.tv64:4809284991830 
hrtimer_get_softexpires_tv64(timer):4440120000000 ccpu0 
timer:ffffffdffdec6138, timer->function:ffffffc000129b84
Jan 01 00:03:32 Linux kernel: i:0 basenow.tv64:4809284991830 
hrtimer_get_softexpires_tv64(timer):4440120000000 ccpu0 
timer:ffffffdffdec6138, timer->function:ffffffc000129b84
Jan 01 00:03:32 Linux kernel: i:0 basenow.tv64:4809284991830 
hrtimer_get_softexpires_tv64(timer):4440120000000 ccpu0 
timer:ffffffdffdec6138, timer->function:ffffffc000129b84
Jan 01 00:03:32 Linux kernel: i:0 basenow.tv64:4809284991830 
hrtimer_get_softexpires_tv64(timer):4440120000000 ccpu0 
timer:ffffffdffdec6138, timer->function:ffffffc000129b84
Jan 01 00:03:32 Linux kernel: i:0 basenow.tv64:4809284991830 
hrtimer_get_softexpires_tv64(timer):4440120000000 ccpu0 
timer:ffffffdffdec6138, timer->function:ffffffc000129b84
Jan 01 00:03:32 Linux kernel: i:0 basenow.tv64:4809284991830 
hrtimer_get_softexpires_tv64(timer):4440120000000 ccpu0 
timer:ffffffdffdec6138, timer->function:ffffffc000129b84
Jan 01 00:03:32 Linux kernel: i:0 basenow.tv64:4809284991830 
hrtimer_get_softexpires_tv64(timer):4440120000000 ccpu0 
timer:ffffffdffdec6138, timer->function:ffffffc000129b84
Jan 01 00:03:32 Linux kernel: i:0 basenow.tv64:4809284991830 
hrtimer_get_softexpires_tv64(timer):4440120000000 ccpu0 
timer:ffffffdffdec6138, timer->function:ffffffc000129b84
Jan 01 00:03:32 Linux kernel: i:0 basenow.tv64:4809284991830 
hrtimer_get_softexpires_tv64(timer):4440120000000 ccpu0 
timer:ffffffdffdec6138, timer->function:ffffffc000129b84
Jan 01 00:03:32 Linux kernel: hrtimer_interrupt: 12827864 callbacks 
suppressed
[....]
Jan 01 00:08:43 Linux kernel: i:0 basenow.tv64:4809284991830 
hrtimer_get_softexpires_tv64(timer):4805395417269 ccpu0 
timer:ffffffef90390a98, timer->function:ffffffc00052bcb8
Jan 01 00:08:43 Linux kernel: i:0 basenow.tv64:4809284991830 
hrtimer_get_softexpires_tv64(timer):4805395417269 ccpu0 
timer:ffffffef90390a98, timer->function:ffffffc00052bcb8
Jan 01 00:08:43 Linux kernel: i:0 basenow.tv64:4809284991830 
hrtimer_get_softexpires_tv64(timer):4805395417269 ccpu0 
timer:ffffffef90390a98, timer->function:ffffffc00052bcb8
Jan 01 00:08:43 Linux kernel: i:0 basenow.tv64:4809284991830 
hrtimer_get_softexpires_tv64(timer):4805395417269 ccpu0 
timer:ffffffef90390a98, timer->function:ffffffc00052bcb8
Jan 01 00:08:43 Linux kernel: i:0 basenow.tv64:4809284991830 
hrtimer_get_softexpires_tv64(timer):4805395417269 ccpu0 
timer:ffffffef90390a98, timer->function:ffffffc00052bcb8
Jan 01 00:08:43 Linux kernel: i:0 basenow.tv64:4809284991830 
hrtimer_get_softexpires_tv64(timer):4805395417269 ccpu0 
timer:ffffffef90390a98, timer->function:ffffffc00052bcb8
Jan 01 00:08:43 Linux kernel: i:0 basenow.tv64:4809284991830 
hrtimer_get_softexpires_tv64(timer):4809295433162 ccpu0
Jan 01 00:08:43 Linux kernel: i:0 while_cnt:1020437660, cost 
jiffies:98761, ccpu0
---end---

Is there maybe a bug or do you have any opinions ?

Thanks,
Yang
