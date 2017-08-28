From: Vadim.Lomovtsev@caviumnetworks.com (Vadim Lomovtsev)
Date: Mon, 28 Aug 2017 04:54:47 -0700
Subject: [arm64 BUG] INFO: rcu_preempt detected stalls on CPUs/tasks 
Message-ID: <20170828115447.GA20818@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Following issue has been observed while running stress-ng test
at arm64-based board. Please find short summary below.

Similar issue was reported a while ago: https://lkml.org/lkml/2017/1/20/101
but in my case I have totally "empty" setup having nothing special running
except test itself and OS default stuff (using Centos 7.3) so before test
run cpu is mostly idle.

Problem description:
====================
Observed kernel message "INFO: rcu_preempt detected stalls on CPUs/tasks"
while running strss-ng test.

Setup:
======
kernel: 4.13.0-rc7
Arch: arm64
Board: Cavium ThunderX (48 CPU)

Steps to reproduce:
===================
1. clone & build stress-ng src
 git clone git://kernel.ubuntu.com/cking/stress-ng.git
 cd stress-ng
 make

2. run stress test
./stress-ng --kill 4 -t 300 -v

Expected results:
=================
- no any warning/error messages in dmesg;
- no kernel failures/crashes;

Actual results:
===============

Following messages observed at default console:

[  354.876479] INFO: rcu_preempt detected stalls on CPUs/tasks:
[  354.882219]  4-...: (1 GPs behind) idle=7da/140000000000000/0 softirq=1914/1914 fqs=2626
[  354.890490]  5-...: (1 GPs behind) idle=016/140000000000000/0 softirq=2474/2474 fqs=2627
[  354.898761]  12-...: (1 GPs behind) idle=262/140000000000000/0 softirq=3020/3022 fqs=2627
[  354.907119]  28-...: (1 GPs behind) idle=432/140000000000000/0 softirq=2800/2802 fqs=2627
[  354.915474]  (detected by 25, t=5261 jiffies, g=4059, c=4058, q=4696)
[  354.921992] Task dump for CPU 4:
[  354.925252] kworker/dying   R  running task        0    31      2 0x00000002
[  354.932383] Call trace:
[  354.934858] [<fffffc0008084f28>] __switch_to+0x70/0x7c
[  354.940053] [<fffffc000808b8b8>] return_address+0x44/0x64
[  354.945511] [<fffffc00080dee6c>] preempt_count_add+0xfc/0x118
[  354.951323] [<fffffc000884c228>] _raw_write_lock_irq+0x1c/0x48
[  354.957222] [<fffffc00080c1b54>] do_exit+0x2d0/0x958
[  354.962244] [<fffffc00080d96e4>] kthread+0xe4/0x12c
[  354.967174] [<fffffc0008082bb0>] ret_from_fork+0x10/0x20
[  354.972542] Task dump for CPU 5:
[  354.975802] kworker/dying   R  running task        0    36      2 0x00000002
[  354.982933] Call trace:
[  354.985403] [<fffffc0008084f28>] __switch_to+0x70/0x7c
[  354.990597] [<fffffe1f00000000>] 0xfffffe1f00000000
[  354.995526] Task dump for CPU 12:
[  354.998874] kworker/dying   R  running task        0    71      2 0x00000002
[  355.006004] Call trace:
[  355.008473] [<fffffc0008084f28>] __switch_to+0x70/0x7c
[  355.013666] [<fffffc000808b8b8>] return_address+0x44/0x64
[  355.019124] [<fffffc00080dee6c>] preempt_count_add+0xfc/0x118
[  355.024933] [<fffffc000884c228>] _raw_write_lock_irq+0x1c/0x48
[  355.030830] [<fffffc00080c1b54>] do_exit+0x2d0/0x958
[  355.035849] [<fffffc00080d96e4>] kthread+0xe4/0x12c
[  355.040778] [<fffffc0008082bb0>] ret_from_fork+0x10/0x20
[  355.046147] Task dump for CPU 28:
[  355.049495] kworker/dying   R  running task        0   151      2 0x00000002
[  355.056625] Call trace:
[  355.059094] [<fffffc0008084f28>] __switch_to+0x70/0x7c
[  355.064288] [<fffffc000808b8b8>] return_address+0x44/0x64
[  355.069745] [<fffffc00080dee6c>] preempt_count_add+0xfc/0x118
[  355.075554] [<fffffc000884c228>] _raw_write_lock_irq+0x1c/0x48
[  355.081451] [<fffffc00080c1b54>] do_exit+0x2d0/0x958
[  355.086470] [<fffffc00080d96e4>] kthread+0xe4/0x12c
[  355.091399] [<fffffc0008082bb0>] ret_from_fork+0x10/0x20


WBR,
Vadim
