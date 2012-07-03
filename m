From: marex@denx.de (Marek Vasut)
Date: Wed, 4 Jul 2012 00:30:36 +0200
Subject: MX28 poweroff issue
Message-ID: <201207040030.36713.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I recently confirmed this issue when doing "poweroff". The issue was initially 
reported by Detlev Zundel.

The console output (trimmed) can be seen below:

Unmounting remote filesystems...
Stopping portmap daemon...
Deactivating swap...
Unmounting local filesystems...
[   59.840000] System halted.
[   84.100000] BUG: soft lockup - CPU#0 stuck for 23s! [halt:584]
[   84.100000] Modules linked in:
[   84.100000] irq event stamp: 27684
[   84.100000] hardirqs last  enabled at (27683): [<c000e758>] 
__irq_svc+0x58/0x60
[   84.100000] hardirqs last disabled at (27684): [<c000e734>] 
__irq_svc+0x34/0x60
[   84.100000] softirqs last  enabled at (27682): [<c002332c>] 
irq_exit+0x8c/0x94
[   84.100000] softirqs last disabled at (27675): [<c002332c>] 
irq_exit+0x8c/0x94
[   84.100000] 
[   84.100000] Pid: 584, comm:                 halt
[   84.100000] CPU: 0    Not tainted  (3.5.0-rc5-next-20120703-00028-g0ec2c3e-
dirty #1578)
[   84.100000] PC is at machine_halt+0x0/0x4
[   84.100000] LR is at sys_reboot+0x160/0x1d0
[   84.100000] pc : [<c000fd08>]    lr : [<c0031c88>]    psr: 60000013
[   84.100000] sp : c7745e90  ip : c06a68c4  fp : 00000000
[   84.100000] r10: 00000000  r9 : c7744000  r8 : c000ec88
[   84.100000] r7 : 00000001  r6 : c7744000  r5 : 4321fedc  r4 : 4321fedc
[   84.100000] r3 : 22222222  r2 : 00000000  r1 : c77e9318  r0 : 00000005
[   84.100000] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[   84.100000] Control: 0005317f  Table: 46474000  DAC: 00000015
[   84.100000] [<c001378c>] (unwind_backtrace+0x0/0xf0) from [<c0070cd4>] 
(watchdog_timer_fn+0x114/0x14c)
[   84.100000] [<c0070cd4>] (watchdog_timer_fn+0x114/0x14c) from [<c004052c>] 
(__run_hrtimer+0x7c/0x1ec)
[   84.100000] [<c004052c>] (__run_hrtimer+0x7c/0x1ec) from [<c0040e6c>] 
(hrtimer_interrupt+0xf8/0x280)
[   84.100000] [<c0040e6c>] (hrtimer_interrupt+0xf8/0x280) from [<c0017f28>] 
(mxs_timer_interrupt+0x1c/0x28)
[   84.100000] [<c0017f28>] (mxs_timer_interrupt+0x1c/0x28) from [<c00714d0>] 
(handle_irq_event_percpu+0x5c/0x274)
[   84.100000] [<c00714d0>] (handle_irq_event_percpu+0x5c/0x274) from 
[<c0071724>] (handle_irq_event+0x3c/0x5c)
[   84.100000] [<c0071724>] (handle_irq_event+0x3c/0x5c) from [<c0073930>] 
(handle_level_irq+0x8c/0xe8)
[   84.100000] [<c0073930>] (handle_level_irq+0x8c/0xe8) from [<c0070e38>] 
(generic_handle_irq+0x28/0x3c)
[   84.100000] [<c0070e38>] (generic_handle_irq+0x28/0x3c) from [<c000f9ac>] 
(handle_IRQ+0x30/0x84)
[   84.100000] [<c000f9ac>] (handle_IRQ+0x30/0x84) from [<c000e738>] 
(__irq_svc+0x38/0x60)
[   84.100000] [<c000e738>] (__irq_svc+0x38/0x60) from [<c000fd08>] 
(machine_halt+0x0/0x4)
[   84.100000] [<c000fd08>] (machine_halt+0x0/0x4) from [<c0031c88>] 
(sys_reboot+0x160/0x1d0)
[   84.100000] [<c0031c88>] (sys_reboot+0x160/0x1d0) from [<c000eae0>] 
(ret_fast_syscall+0x0/0x38)

Best regards,
Marek Vasut
