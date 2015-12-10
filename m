From: ddaney@caviumnetworks.com (David Daney)
Date: Thu, 10 Dec 2015 11:43:46 -0800
Subject: Commit 81a43adae3b9 (locking/mutex: Use acquire/release semantics)
 causing failures on arm64 (ThunderX)
Message-ID: <5669D5F2.5050004@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

We are getting soft lockup OOPs on Cavium CN88XX (A.K.A. ThunderX), 
which is an arm64 implementation.

A typical failure shows multiple threads stuck in mutex operations like 
this:

.
.
.
[   68.909873] Task dump for CPU 18:
[   68.909876] systemd-udevd   R  running task        0   537    534 
0x00000002
[   68.909877] Call trace:
[   68.909880] [<fffffe0000088858>] dump_backtrace+0x0/0x17c
[   68.909883] [<fffffe00000889f8>] show_stack+0x24/0x2c
[   68.909885] [<fffffe00000c4210>] sched_show_task+0xb0/0x104
[   68.909888] [<fffffe00000c682c>] dump_cpu_task+0x48/0x54
[   68.909890] [<fffffe00000ee5e0>] rcu_dump_cpu_stacks+0x9c/0xec
[   68.909893] [<fffffe00000f2c9c>] rcu_check_callbacks+0x524/0xa18
[   68.909896] [<fffffe00000f83a0>] update_process_times+0x44/0x74
[   68.909899] [<fffffe00001078d4>] tick_sched_timer+0x78/0x1ac
[   68.909901] [<fffffe00000f8b74>] __hrtimer_run_queues+0x148/0x2d4
[   68.909903] [<fffffe00000f9464>] hrtimer_interrupt+0xb0/0x1f4
[   68.909906] [<fffffe000056e6e8>] arch_timer_handler_phys+0x3c/0x48
[   68.909909] [<fffffe00000e7fd4>] handle_percpu_devid_irq+0xb0/0x1b0
[   68.909912] [<fffffe00000e33c4>] generic_handle_irq+0x34/0x4c
[   68.909914] [<fffffe00000e3738>] __handle_domain_irq+0x90/0xfc
[   68.909916] [<fffffe0000081d80>] gic_handle_irq+0x90/0x18c
[   68.909918] Exception stack(0xfffffe03f14e3920 to 0xfffffe03f14e3a40)
[   68.909921] 3920: fffffe03fd5c5800 fffffe0000c55800 fffffe03f14e3a80 
fffffe00000dabd8
[   68.909924] 3940: 00000000a0000145 0000000000000015 fffffe03e9602400 
fffffe00002fddb0
[   68.909927] 3960: 0000000000000000 0000000000000000 fffffe03fd5c5810 
fffffe03f14e0000
[   68.909929] 3980: 0000000000000001 ffffffffff000000 fffffe03db307e38 
0000000000000000
[   68.909932] 39a0: 0000000000737973 00000000ffffffff 0000000000000000 
000000003b364d50
[   68.909935] 39c0: 0000000000000018 ffffffffa99641af 0016fd71b6000000 
003b9aca00000000
[   68.909937] 39e0: fffffe00001f1508 000003ff9b9fd028 000003ffed7a0a10 
fffffe03fd5c5800
[   68.909940] 3a00: fffffe0000c55800 fffffe0000cea1c8 fffffe03fd5a5800 
fffffe0000ca2eb0
[   68.909943] 3a20: 0000000000000015 fffffe03e9602400 fffffe0000cea1c8 
fffffe0000712000
[   68.909945] [<fffffe0000084ce8>] el1_irq+0x68/0xd8
[   68.909948] [<fffffe00000da03c>] mutex_optimistic_spin+0x9c/0x1d0
[   68.909951] [<fffffe00006fe4b8>] __mutex_lock_slowpath+0x44/0x158
[   68.909953] [<fffffe00006fe620>] mutex_lock+0x54/0x58
[   68.909956] [<fffffe0000265efc>] kernfs_iop_permission+0x38/0x70
[   68.909959] [<fffffe00001fbf50>] __inode_permission+0x88/0xd8
[   68.909961] [<fffffe00001fbfd0>] inode_permission+0x30/0x6c
[   68.909964] [<fffffe00001fe26c>] link_path_walk+0x68/0x4d4
[   68.909966] [<fffffe00001ffa14>] path_openat+0xb4/0x2bc
[   68.909968] [<fffffe000020123c>] do_filp_open+0x74/0xd0
[   68.909971] [<fffffe00001f13e4>] do_sys_open+0x14c/0x228
[   68.909973] [<fffffe00001f1544>] SyS_openat+0x3c/0x48
[   68.909976] [<fffffe00000851f0>] el0_svc_naked+0x24/0x28
.
.
.

Reverting 81a43adae3b9 (locking/mutex: Use acquire/release semantics) 
Makes the problem go away.

At this point it is unknown if this patch is incorrect, or if the 
underlying ARM64 atomic_*_{acquire,release} primitives are defective, or 
if the problem lies elsewhere.

I am not requesting any specific action with this e-mail, but wanted to 
draw attention to the issue.  Undoubtedly we will be able to provide 
more detailed information about the issue in the coming days.

Thanks,
David Daney
