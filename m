From: bbb.lst@gmail.com (Bjoern Brandenburg)
Date: Sat, 29 May 2010 18:02:28 -0400
Subject: 2.6.34 hangs during boot on PB11MPCore
Message-ID: <AANLkTin9n6HDdiTnQoQ9mrmuzSR8JhZVq7uPgU86yqgU@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

we're having a bit of trouble to get 2.6.34 to run on a PB11MPCore board with
SMP enabled. If we don't specify maxcpus=1, then the system gets stuck when
trying to launch init (via NFS).

We've tried three kernel versions:
- 2.6.33-arm1 [1]
  - boot log: http://pastebin.com/UqhfJNgz
- 2.6.34-vanilla
  - boot log with maxcpus=1: http://pastebin.com/NHHeYpbb
  - boot log with failure: http://pastebin.com/uy6y8msZ
  - config: http://pastebin.com/v9dttg0L
- 2.6.34-arm  [2]
  - boot log with maxcpus=1: http://pastebin.com/rCy2x9AP
  - boot log with failure: http://pastebin.com/spam.php?i=mpedVqp3

Of these, only 2.6.33-arm1 boots with more than one CPU enabled. The 2.6.34
versions only boot to login if we restrict the number of CPUs. The configuration
used in all cases is based on the one provided by ARM [3]. For 2.6.34, we used
'make oldconfig' and accepted all defaults.

Trying to boot 2.6.34-vanilla results in:
-----
[...]
Looking up port of RPC 100003/3 on 152.2.128.169
Looking up port of RPC 100005/3 on 152.2.128.169
VFS: Mounted root (nfs filesystem) on device 0:11.
Freeing init memory: 148K
BUG: soft lockup - CPU#0 stuck for 61s! [swapper:0]
Modules linked in:

Pid: 0, comm:              swapper
CPU: 0    Not tainted  (2.6.34 #2)
PC is at handle_IRQ_event+0x1c/0xf8
LR is at handle_level_irq+0xa4/0x150
pc : [<c0086084>]    lr : [<c0088130>]    psr: 40000113
sp : c0433e60  ip : 009564e3  fp : ffff8e11
r10: c0434080  r9 : c0888200  r8 : c0433f70
r7 : 00000029  r6 : 00000029  r5 : c043509c  r4 : dfdce980
r3 : 00000080  r2 : 00000000  r1 : dfdce980  r0 : 00000029
Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 00c5787d  Table: 8fefc00a  DAC: 00000017
INFO: task init:1 blocked for more than 120 seconds.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
init          D c03423c0     0     1      0 0x00000000
[<c03423c0>] (schedule+0x228/0x5f8) from [<c03427e4>] (io_schedule+0x54/0x84)
[<c03427e4>] (io_schedule+0x54/0x84) from [<c0097140>] (sync_page+0x50/0x5c)
[<c0097140>] (sync_page+0x50/0x5c) from [<c0342b8c>]
(__wait_on_bit_lock+0x6c/0xb8)
[<c0342b8c>] (__wait_on_bit_lock+0x6c/0xb8) from [<c00970c8>]
(__lock_page+0x94/0xac)
[<c00970c8>] (__lock_page+0x94/0xac) from [<c0097334>]
(find_lock_page+0x50/0x68)
[<c0097334>] (find_lock_page+0x50/0x68) from [<c0097a6c>]
(filemap_fault+0x1a0/0x420)
[<c0097a6c>] (filemap_fault+0x1a0/0x420) from [<c00ae48c>]
(__do_fault+0x54/0x49c)
[<c00ae48c>] (__do_fault+0x54/0x49c) from [<c00af79c>]
(handle_mm_fault+0x114/0x898)
[<c00af79c>] (handle_mm_fault+0x114/0x898) from [<c00381e4>]
(do_page_fault+0x208/0x300)
[<c00381e4>] (do_page_fault+0x208/0x300) from [<c002d45c>]
(do_PrefetchAbort+0x34/0x98)
[<c002d45c>] (do_PrefetchAbort+0x34/0x98) from [<c002e080>]
(ret_from_exception+0x0/0x10)
Exception stack(0xdfc3dfb0 to 0xdfc3dff8)
dfa0:                                     beee1bdd 0000007e 000b1b14 beee1c80
dfc0: beee1bdc 00000003 beee1c80 00000204 00000204 20400000 00000053 00000000
dfe0: 4014884c beee1bd8 0008976c 4014884c 60000010 ffffffff
INFO: task events/3:18 blocked for more than 120 seconds.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
events/3      D c03423c0     0    18      2 0x00000000
[<c03423c0>] (schedule+0x228/0x5f8) from [<c0342a68>]
(schedule_timeout+0x168/0x1cc)
[<c0342a68>] (schedule_timeout+0x168/0x1cc) from [<c0342054>]
(wait_for_common+0xb8/0x170)
[<c0342054>] (wait_for_common+0xb8/0x170) from [<c008a2c0>]
(synchronize_sched+0x50/0x64)
[<c008a2c0>] (synchronize_sched+0x50/0x64) from [<c02ccb7c>]
(dev_deactivate+0x168/0x1e8)
[<c02ccb7c>] (dev_deactivate+0x168/0x1e8) from [<c02c9194>]
(linkwatch_do_dev+0x9c/0xf4)
[<c02c9194>] (linkwatch_do_dev+0x9c/0xf4) from [<c02c9608>]
(__linkwatch_run_queue+0x1bc/0x1fc)
[<c02c9608>] (__linkwatch_run_queue+0x1bc/0x1fc) from [<c02c966c>]
(linkwatch_event+0x24/0x34)
[<c02c966c>] (linkwatch_event+0x24/0x34) from [<c0061e2c>]
(worker_thread+0x14c/0x1f0)
[<c0061e2c>] (worker_thread+0x14c/0x1f0) from [<c0065d8c>] (kthread+0x80/0x88)
[<c0065d8c>] (kthread+0x80/0x88) from [<c002f390>] (kernel_thread_exit+0x0/0x8)
-----

Trying to boot 2.6.34-arm results in:
-----
[...]
VFS: Mounted root (nfs filesystem) on device 0:12.
Freeing init memory: 160K
nfs: server 152.2.128.169 not responding, still trying
nfs: server 152.2.128.169 not responding, still trying
-----
Nothing happens after this for a while, so I gave up. I was using 152.2.128.169
at the same time via ssh, so I'm pretty sure that it was responding just fine.

Are these known problem? Are there additional patches that we should try to get
2.6.34 to run with SMP enabled?

Thanks,
Bj?rn


[1]
http://linux-arm.org/git?p=linux-2.6-stable.git;a=commit;h=
729b7925dd8b9f6e5f4e4466408f91a2b9f51c3a
[2]
http://linux-arm.org/git?p=linux-2.6.git;a=commit;h=
9bc7891fd8946a6de950902f25b870e04144add2
[3]
http://linux-arm.org/git?p=ael.git;a=blob;f=kernel/config/2.6.33-arm1/config-2.6
.33-arm1-realview-v6-smp;h=7637d63580ab87ed25f8102b874d3e3e2fae1322;hb=2010q2
