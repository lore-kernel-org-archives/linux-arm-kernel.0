From: m-karicheri2@ti.com (Murali Karicheri)
Date: Fri, 18 Sep 2015 12:02:15 -0400
Subject: possible reason: unannotated irqs-off
Message-ID: <55FC3587.7010601@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All,

While chasing a fix for a deadlock in netcp driver with debug options 
enabled, i bumped on another warning shown below.. Looks like I need to 
enable CONFIG_IRQSOFF_TRACER as well to get rid of this. Have anyone 
seen this? My google search showed me some connection with this option 
and I enabled it as well and I don't see the warning anymore. Any idea 
if this is a false alarm or a real bug? Looks like I need to enable 
CONFIG_IRQSOFF_TRACER as well. If so, I can send a patch. Either way let 
me know.


Murali

[   17.401337] ------------[ cut here ]------------
[   17.405991] WARNING: CPU: 2 PID: 1201 at 
kernel/locking/lockdep.c:3557 check_flags.part.37+0x224/0x228()
[   17.415508] DEBUG_LOCKS_WARN_ON(current->hardirqs_enabled)
[   17.420836] Modules linked in:
[   17.424087] CPU: 2 PID: 1201 Comm: udevd Tainted: G        W 
4.1.6-01270-gcdac6fd #1
[   17.432379] Hardware name: Keystone
[   17.435894] [<c00178e4>] (unwind_backtrace) from [<c0013cbc>] 
(show_stack+0x10/0x14)
[   17.443673] [<c0013cbc>] (show_stack) from [<c05ff398>] 
(dump_stack+0x84/0xc4)
[   17.450926] [<c05ff398>] (dump_stack) from [<c0028990>] 
(warn_slowpath_common+0x84/0xb4)
[   17.459048] [<c0028990>] (warn_slowpath_common) from [<c00289f0>] 
(warn_slowpath_fmt+0x30/0x40)
[   17.467781] [<c00289f0>] (warn_slowpath_fmt) from [<c006c37c>] 
(check_flags.part.37+0x224/0x228)
[   17.476601] [<c006c37c>] (check_flags.part.37) from [<c006ce48>] 
(lock_is_held+0x88/0x94)
[   17.484811] [<c006ce48>] (lock_is_held) from [<c008eb9c>] 
(rcu_note_context_switch+0x854/0x8c0)
[   17.493545] [<c008eb9c>] (rcu_note_context_switch) from [<c0600b54>] 
(__schedule+0x40/0x844)
[   17.502017] [<c0600b54>] (__schedule) from [<c0601398>] 
(schedule+0x40/0x98)
[   17.509097] [<c0601398>] (schedule) from [<c001364c>] 
(do_work_pending+0x24/0xb0)
[   17.516610] [<c001364c>] (do_work_pending) from [<c000ffc4>] 
(work_pending+0xc/0x20)
[   17.524380] ---[ end trace fe0042166f5d3227 ]---
[   17.529009] possible reason: unannotated irqs-off.
[   17.533813] irq event stamp: 331979
[   17.537308] hardirqs last  enabled at (331979): [<c000fffc>] 
no_work_pending+0x8/0x30
[   17.545172] hardirqs last disabled at (331978): [<c000ffe4>] 
ret_slow_syscall+0xc/0x10
[   17.553123] softirqs last  enabled at (327182): [<c002ca90>] 
__do_softirq+0x4dc/0x6cc
[   17.560987] softirqs last disabled at (327177): [<c002cf88>] 
irq_exit+0x98/0xcc

-- 
Murali Karicheri
Linux Kernel, Keystone
