From: jp.francois@cynove.com (jean-philippe francois)
Date: Thu, 8 Mar 2012 12:06:32 +0100
Subject: soft lockup on omap3 (dm3730)
In-Reply-To: <CAGGh5h3AtiuFuU0OY1FpPre6hyGKTSTEc=S6hkf2hAr=6LAehg@mail.gmail.com>
References: <CAGGh5h3OQTniXbm8iUYGM+2oi+zzd1F6BxDKzN5epA89+i_7nQ@mail.gmail.com>
 <20120307163750.GC18787@n2100.arm.linux.org.uk>
 <CAGGh5h3AtiuFuU0OY1FpPre6hyGKTSTEc=S6hkf2hAr=6LAehg@mail.gmail.com>
Message-ID: <CAGGh5h0CtnndXtHVU_tdRDja5OcABKe9yZfEDK7xi_VcRN8G_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 8 mars 2012 09:26, jean-philippe francois <jp.francois@cynove.com> a ?crit :
> Le 7 mars 2012 17:37, Russell King - ARM Linux
> <linux@arm.linux.org.uk> a ?crit :
>> On Wed, Mar 07, 2012 at 05:16:35PM +0100, jean-philippe francois wrote:
>>> Is the backtrace pointing to this offset because soft_lockup can only
>>> detect lockups at the output of critical sections ?
>>
>> Correct - soft lockups on ARM can only be detected when hardware
>> interrupts are enabled. ?Any region which masks hard interrupts
>> effectively prevents the soft lockup detector firing should
>> execution get stuck inside such a region.
>
> But then, how is the soft lockup detector able to break this hard lockup ?

I think I may be looking at the wrong place. May be the proc is stuck
in an IRQ that is
handled at the output of the critical sections ? Below is the soft
lockup backtrace :
what belongs to the soft lockup detector, and is not the real culprit
__do_softirq ?


BUG: soft lockup - CPU#0 stuck for 22s! [yavta:496]
Modules linked in: omap3_isp fpgacam(O) ks8851_mll

Pid: 496, comm:                yavta
CPU: 0    Tainted: G           O  (3.2.0 #55)
PC is at __do_softirq+0x50/0x110
LR is at __do_softirq+0x38/0x110
pc : [<c0036be4>]    lr : [<c0036bcc>]    psr: 20000113
sp : ceff3c70  ip : cf493800  fp : 00000000
r10: cefeb2ac  r9 : 0000000a  r8 : ceff2000
r7 : 00000002  r6 : 00000000  r5 : 00000000  r4 : 00000025
r3 : c0475c80  r2 : 00000000  r1 : 00000102  r0 : 00000000
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c5387d  Table: 8e808019  DAC: 00000015
[<c00123b0>] (unwind_backtrace+0x0/0xec) from [<c0066310>]
(watchdog_timer_fn+0xd8/0x128)
[<c0066310>] (watchdog_timer_fn+0xd8/0x128) from [<c004d7a4>]
(__run_hrtimer+0x50/0xcc)
[<c004d7a4>] (__run_hrtimer+0x50/0xcc) from [<c004d9f0>]
(hrtimer_interrupt+0x114/0x290)
[<c004d9f0>] (hrtimer_interrupt+0x114/0x290) from [<c0018e30>]
(omap2_gp_timer_interrupt+0x24/0x34)
[<c0018e30>] (omap2_gp_timer_interrupt+0x24/0x34) from [<c0066a04>]
(handle_irq_event_percpu+0x28/0x110)
[<c0066a04>] (handle_irq_event_percpu+0x28/0x110) from [<c0066b28>]
(handle_irq_event+0x3c/0x5c)
[<c0066b28>] (handle_irq_event+0x3c/0x5c) from [<c0069128>]
(handle_level_irq+0xb8/0xe8)
[<c0069128>] (handle_level_irq+0xb8/0xe8) from [<c0066674>]
(generic_handle_irq+0x28/0x30)
[<c0066674>] (generic_handle_irq+0x28/0x30) from [<c000e570>]
(handle_IRQ+0x60/0x84)
[<c000e570>] (handle_IRQ+0x60/0x84) from [<c000d874>]
(__irq_svc+0x34/0x98)     <--- soft lockup backtrace
[<c000d874>] (__irq_svc+0x34/0x98) from [<c0036be4>]
(__do_softirq+0x50/0x110)  <--- real soft lockup position ??
[<c0036be4>] (__do_softirq+0x50/0x110) from [<c0036e7c>] (irq_exit+0x48/0x9c)
[<c0036e7c>] (irq_exit+0x48/0x9c) from [<c000e574>] (handle_IRQ+0x64/0x84)
[<c000e574>] (handle_IRQ+0x64/0x84) from [<c000d874>] (__irq_svc+0x34/0x98)
[<c000d874>] (__irq_svc+0x34/0x98) from [<c02d436c>]
(_raw_spin_unlock_irqrestore+0x28/0x50)
[<c02d436c>] (_raw_spin_unlock_irqrestore+0x28/0x50) from [<bf00e890>]
(omap3isp_video_queue_streamon+0x8c/0xa8 [omap3_isp])
[<bf00e890>] (omap3isp_video_queue_streamon+0x8c/0xa8 [omap3_isp])
from [<bf0105b4>] (isp_video_streamon+0x15c/0x224 [omap3_isp])
[<bf0105b4>] (isp_video_streamon+0x15c/0x224 [omap3_isp]) from
[<c0228450>] (__video_do_ioctl+0x1b9c/0x4894)
[<c0228450>] (__video_do_ioctl+0x1b9c/0x4894) from [<c0226774>]
(video_usercopy+0x1b8/0x298)
[<c0226774>] (video_usercopy+0x1b8/0x298) from [<c0225678>]
(v4l2_ioctl+0x6c/0x11c)
[<c0225678>] (v4l2_ioctl+0x6c/0x11c) from [<c00a3034>] (vfs_ioctl+0x20/0x3c)
[<c00a3034>] (vfs_ioctl+0x20/0x3c) from [<c00a38a4>] (do_vfs_ioctl+0x1ac/0x1c4)
[<c00a38a4>] (do_vfs_ioctl+0x1ac/0x1c4) from [<c00a38f0>] (sys_ioctl+0x34/0x54)
[<c00a38f0>] (sys_ioctl+0x34/0x54) from [<c000dcc0>] (ret_fast_syscall+0x0/0x30)

Thank you for your help
