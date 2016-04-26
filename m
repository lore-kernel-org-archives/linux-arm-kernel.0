From: stefan@agner.ch (Stefan Agner)
Date: Tue, 26 Apr 2016 10:04:18 -0700
Subject: [PATCH 1/2] clk: imx: do not sleep if IRQ's are still disabled
In-Reply-To: <20160130011641.GD4848@codeaurora.org>
References: <1454107764-19876-1-git-send-email-stefan@agner.ch>
 <20160130011641.GD4848@codeaurora.org>
Message-ID: <c6579f08fcbbd988f31c5c82cd58c030@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-01-29 17:16, Stephen Boyd wrote:
> On 01/29, Stefan Agner wrote:
>> If a clock gets enabled early during boot time, it can lead to a PLL
>> startup. The wait_lock function makes sure that the PLL is really
>> stareted up before it gets used. However, the function sleeps which
>> leads to scheduling and an error:
>> bad: scheduling from the idle thread!
>> ...
> 
> Can you please share the full splat? I have no clue what's going
> on.

Finally, full splat:

...
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2,
Nodes=1
[    0.000000] Running RCU self tests
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU lockdep checking is enabled.
[    0.000000]  Build-time adjustment of leaf fanout to 32.
[    0.000000]  RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=2.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=32,
nr_cpu_ids=2
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:3407
lock_release+0x398/0x3a0()
[    0.000000] releasing a pinned lock
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
4.5.0-rc1-00013-gdb45d67 #40
[    0.000000] Hardware name: Freescale i.MX7 Dual (Device Tree)
[    0.000000] Backtrace:
[    0.000000] [<c0014230>] (dump_backtrace) from [<c001442c>]
(show_stack+0x18/0x1c)
[    0.000000]  r7:c006f8f8 r6:00000d4f r5:00000000 r4:c0ad541c
[    0.000000] [<c0014414>] (show_stack) from [<c02de8fc>]
(dump_stack+0x80/0x90)
[    0.000000] [<c02de87c>] (dump_stack) from [<c00263c0>]
(warn_slowpath_common+0x88/0xb8)
[    0.000000]  r5:00000009 r4:c0abdc58
[    0.000000] [<c0026338>] (warn_slowpath_common) from [<c0026428>]
(warn_slowpath_fmt+0x38/0x40)
[    0.000000]  r8:00000002 r7:00000001 r6:cedc3fd0 r5:c0ac24e0
r4:c0984048
[    0.000000] [<c00263f4>] (warn_slowpath_fmt) from [<c006f8f8>]
(lock_release+0x398/0x3a0)
[    0.000000]  r3:0000fff0 r2:c0984048
[    0.000000]  r4:c0ac2500
[    0.000000] [<c006f560>] (lock_release) from [<c07cc298>]
(_raw_spin_unlock_irq+0x20/0x34)
[    0.000000]  r10:00000000 r9:c0ac2384 r8:cedc3fd0 r7:c0abe6d0
r6:00000001 r5:cedc3fc0
[    0.000000]  r4:cedc3fc0
[    0.000000] [<c07cc278>] (_raw_spin_unlock_irq) from [<c0055298>]
(dequeue_task_idle+0x14/0x30)
[    0.000000]  r5:cedc3fc0 r4:cedc3fc0
[    0.000000] [<c0055284>] (dequeue_task_idle) from [<c004d764>]
(deactivate_task+0x64/0x68)
[    0.000000]  r5:cedc3fc0 r4:c0ac2040
[    0.000000] [<c004d700>] (deactivate_task) from [<c07c6fd0>]
(__schedule+0x29c/0x67c)
[    0.000000]  r7:c0abe6d0 r6:c0abafc0 r5:c0ac2040 r4:cedc3fc0
[    0.000000] [<c07c6d34>] (__schedule) from [<c07c73f8>]
(schedule+0x48/0xa0)
[    0.000000]  r10:c0b0d91c r9:00000036 r8:c1331c3c r7:00000000
r6:0006ddd0 r5:c0abde08
[    0.000000]  r4:c0abc000
[    0.000000] [<c07c73b0>] (schedule) from [<c07cbd38>]
(schedule_hrtimeout_range_clock+0xbc/0x130)
[    0.000000]  r5:c0abde08 r4:00000001
[    0.000000] [<c07cbc7c>] (schedule_hrtimeout_range_clock) from
[<c07cbdc0>] (schedule_hrtimeout_range+0x14/0x18)
[    0.000000]  r7:00000003 r6:ffff8ad1 r5:ce804fc0 r4:c0abe100
[    0.000000] [<c07cbdac>] (schedule_hrtimeout_range) from [<c07cb854>]
(usleep_range+0x64/0x6c)
[    0.000000] [<c07cb7f0>] (usleep_range) from [<c0578468>]
(clk_pllv3_wait_lock+0x80/0xbc)
[    0.000000] [<c05783e8>] (clk_pllv3_wait_lock) from [<c05784d0>]
(clk_pllv3_prepare+0x2c/0x30)
[    0.000000]  r7:00000003 r6:d0864490 r5:c1331c3c r4:ce807680
[    0.000000] [<c05784a4>] (clk_pllv3_prepare) from [<c0571d28>]
(clk_core_prepare+0xa0/0xc4)
[    0.000000] [<c0571c88>] (clk_core_prepare) from [<c0572230>]
(clk_prepare+0x20/0x38)
[    0.000000]  r5:c1331c3c r4:ce80c040
[    0.000000] [<c0572210>] (clk_prepare) from [<c0a8e980>]
(imx7d_clocks_init+0x5ee0/0x5f6c)
[    0.000000]  r5:c1331c3c r4:ce80c040
[    0.000000] [<c0a88aa0>] (imx7d_clocks_init) from [<c0a88618>]
(of_clk_init+0x148/0x1d8)
[    0.000000]  r10:cede50b4 r9:00000003 r8:00000001 r7:c0abdf60
r6:c0abdf68 r5:00000000
[    0.000000]  r4:ce8043c0
[    0.000000] [<c0a884d0>] (of_clk_init) from [<c0a63918>]
(time_init+0x30/0x38)
[    0.000000]  r10:cefffb80 r9:c0aa6a48 r8:c0b24000 r7:ffffffff
r6:c0abe4c0 r5:c0b24000
[    0.000000]  r4:00000000
[    0.000000] [<c0a638e8>] (time_init) from [<c0a5fc38>]
(start_kernel+0x2b4/0x3ec)
[    0.000000] [<c0a5f984>] (start_kernel) from [<8000807c>]
(0x8000807c)
[    0.000000]  r10:00000000 r9:410fc075 r8:8000406a r7:c0ac39b4
r6:c0aa6a44 r5:c0abe540
[    0.000000]  r4:c0b24294
[    0.000000] ---[ end trace cb88537fdc8fa200 ]---
[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:2601
trace_hardirqs_on_caller+0x1e8/0x1fc()
[    0.000000] DEBUG_LOCKS_WARN_ON(unlikely(early_boot_irqs_disabled))
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W      
4.5.0-rc1-00013-gdb45d67 #40
[    0.000000] Hardware name: Freescale i.MX7 Dual (Device Tree)   
[    0.000000] Backtrace:
[    0.000000] [<c0014230>] (dump_backtrace) from [<c001442c>]
(show_stack+0x18/0x1c)
[    0.000000]  r7:c006cb24 r6:00000a29 r5:00000000 r4:c0ad541c
[    0.000000] [<c0014414>] (show_stack) from [<c02de8fc>]
(dump_stack+0x80/0x90)
[    0.000000] [<c02de87c>] (dump_stack) from [<c00263c0>]
(warn_slowpath_common+0x88/0xb8)
[    0.000000]  r5:00000009 r4:c0abdc88
[    0.000000] [<c0026338>] (warn_slowpath_common) from [<c0026428>]
(warn_slowpath_fmt+0x38/0x40)
[    0.000000]  r8:cedc3fd0 r7:c0abe6d0 r6:00000001 r5:cedc3fc0
r4:c098066c
[    0.000000] [<c00263f4>] (warn_slowpath_fmt) from [<c006cb24>]
(trace_hardirqs_on_caller+0x1e8/0x1fc)
[    0.000000]  r3:c0983e1c r2:c098066c
[    0.000000]  r4:c07cc2a4
[    0.000000] [<c006c93c>] (trace_hardirqs_on_caller) from [<c006cb4c>]
(trace_hardirqs_on+0x14/0x18)
[    0.000000]  r7:c0abe6d0 r6:00000001 r5:cedc3fc0 r4:cedc3fc0
[    0.000000] [<c006cb38>] (trace_hardirqs_on) from [<c07cc2a4>]
(_raw_spin_unlock_irq+0x2c/0x34)
[    0.000000] [<c07cc278>] (_raw_spin_unlock_irq) from [<c0055298>]
(dequeue_task_idle+0x14/0x30)
[    0.000000]  r5:cedc3fc0 r4:cedc3fc0
[    0.000000] [<c0055284>] (dequeue_task_idle) from [<c004d764>]
(deactivate_task+0x64/0x68)
[    0.000000]  r5:cedc3fc0 r4:c0ac2040
[    0.000000] [<c004d700>] (deactivate_task) from [<c07c6fd0>]
(__schedule+0x29c/0x67c)
[    0.000000]  r7:c0abe6d0 r6:c0abafc0 r5:c0ac2040 r4:cedc3fc0
[    0.000000] [<c07c6d34>] (__schedule) from [<c07c73f8>]
(schedule+0x48/0xa0)
[    0.000000]  r10:c0b0d91c r9:00000036 r8:c1331c3c r7:00000000
r6:0006ddd0 r5:c0abde08
[    0.000000]  r4:c0abc000
[    0.000000] [<c07c73b0>] (schedule) from [<c07cbd38>]
(schedule_hrtimeout_range_clock+0xbc/0x130)
[    0.000000]  r5:c0abde08 r4:00000001
[    0.000000] [<c07c73b0>] (schedule) from [<c07cbd38>]
(schedule_hrtimeout_range_clock+0xbc/0x130)
[    0.000000]  r5:c0abde08 r4:00000001
[    0.000000] [<c07cbc7c>] (schedule_hrtimeout_range_clock) from
[<c07cbdc0>] (schedule_hrtimeout_range+0x14/0x18)
[    0.000000]  r7:00000003 r6:ffff8ad1 r5:ce804fc0 r4:c0abe100
[    0.000000] [<c07cbdac>] (schedule_hrtimeout_range) from [<c07cb854>]
(usleep_range+0x64/0x6c)
[    0.000000] [<c07cb7f0>] (usleep_range) from [<c0578468>]
(clk_pllv3_wait_lock+0x80/0xbc)
[    0.000000] [<c05783e8>] (clk_pllv3_wait_lock) from [<c05784d0>]
(clk_pllv3_prepare+0x2c/0x30)
[    0.000000]  r7:00000003 r6:d0864490 r5:c1331c3c r4:ce807680
[    0.000000] [<c05784a4>] (clk_pllv3_prepare) from [<c0571d28>]
(clk_core_prepare+0xa0/0xc4)
[    0.000000] [<c0571c88>] (clk_core_prepare) from [<c0572230>]
(clk_prepare+0x20/0x38)
[    0.000000]  r5:c1331c3c r4:ce80c040
[    0.000000] [<c0572210>] (clk_prepare) from [<c0a8e980>]
(imx7d_clocks_init+0x5ee0/0x5f6c)
[    0.000000]  r5:c1331c3c r4:ce80c040
[    0.000000] [<c0a88aa0>] (imx7d_clocks_init) from [<c0a88618>]
(of_clk_init+0x148/0x1d8)
[    0.000000]  r10:cede50b4 r9:00000003 r8:00000001 r7:c0abdf60
r6:c0abdf68 r5:00000000
[    0.000000]  r4:ce8043c0
[    0.000000] [<c0a884d0>] (of_clk_init) from [<c0a63918>]
(time_init+0x30/0x38)
[    0.000000]  r10:cefffb80 r9:c0aa6a48 r8:c0b24000 r7:ffffffff
r6:c0abe4c0 r5:c0b24000
[    0.000000]  r4:00000000
[    0.000000] [<c0a638e8>] (time_init) from [<c0a5fc38>]
(start_kernel+0x2b4/0x3ec)
[    0.000000] [<c0a5f984>] (start_kernel) from [<8000807c>]
(0x8000807c)
[    0.000000]  r10:00000000 r9:410fc075 r8:8000406a r7:c0ac39b4
r6:c0aa6a44 r5:c0abe540
[    0.000000]  r4:c0b24294
[    0.000000] ---[ end trace cb88537fdc8fa201 ]---
[    0.000000] bad: scheduling from the idle thread!                    
                                                                        
                                                                  
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W      
4.5.0-rc1-00013-gdb45d67 #40
[    0.000000] Hardware name: Freescale i.MX7 Dual (Device Tree)
[    0.000000] Backtrace:
[    0.000000] [<c0014230>] (dump_backtrace) from [<c001442c>]
(show_stack+0x18/0x1c)
...
