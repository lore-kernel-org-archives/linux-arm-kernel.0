From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Tue, 29 Aug 2017 16:27:56 +0200
Subject: commit 73ac5d6a "arm/syscalls: Check address limit on user-mode
 return" breaks NFS boot on i.MX6 platforms
Message-ID: <20170829162756.14c78897@karo-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I found that I cannot boot a 4.13-rc7 (next-20170829) kernel on a TX6Q
module. With NFS root the kernel works well until it starts the init
process and then is busy making NFS calls over the network, but doesn't
seem to proceed any further. It reacts to sysrq triggers.

I bisected it down to commit 73ac5d6a ("arm/syscalls: Check address
limit on user-mode return").
When reverting this commit on top of next-20170829 everything works
well again, though there is a deadlock reported by lockdep:

======================================================
WARNING: possible circular locking dependency detected
4.13.0-rc7-next-20170829-karo-00001-ge6888ab #46 Not tainted
------------------------------------------------------
kworker/0:1H/1035 is trying to acquire lock:
 ((&task->u.tk_work)){+.+.}, at: [<80136264>] process_one_work+0x128/0x42c

but task is already holding lock:
 ("xprtiod"){+.+.}, at: [<80136264>] process_one_work+0x128/0x42c

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 ("xprtiod"){+.+.}:
       flush_work+0x1b0/0x248
       __cancel_work_timer+0x108/0x1e0
       xs_destroy+0x34/0x50
       __rpc_execute+0x94/0x26c
       process_one_work+0x1a4/0x42c
       worker_thread+0x38/0x4d4
       kthread+0x138/0x170
       ret_from_fork+0x14/0x24

-> #0 ((&task->u.tk_work)){+.+.}:
       lock_acquire+0x70/0x90
       process_one_work+0x18c/0x42c
       worker_thread+0x38/0x4d4
       kthread+0x138/0x170
       ret_from_fork+0x14/0x24

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock("xprtiod");
                               lock((&task->u.tk_work));
                               lock("xprtiod");
  lock((&task->u.tk_work));

 *** DEADLOCK ***

1 lock held by kworker/0:1H/1035:
 #0:  ("xprtiod"){+.+.}, at: [<80136264>] process_one_work+0x128/0x42c

stack backtrace:
CPU: 0 PID: 1035 Comm: kworker/0:1H Not tainted 4.13.0-rc7-next-20170829-karo-00001-ge6888ab #46
Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
Workqueue: xprtiod rpc_async_schedule
[<801100cc>] (unwind_backtrace) from [<8010bcb8>] (show_stack+0x10/0x14)
[<8010bcb8>] (show_stack) from [<80739af4>] (dump_stack+0xb8/0xe4)
[<80739af4>] (dump_stack) from [<80161108>] (print_circular_bug+0x258/0x414)
[<80161108>] (print_circular_bug) from [<80162330>] (check_prev_add+0x44c/0x910)
[<80162330>] (check_prev_add) from [<801653ac>] (__lock_acquire+0x1488/0x15ec)
[<801653ac>] (__lock_acquire) from [<80165d60>] (lock_acquire+0x70/0x90)
[<80165d60>] (lock_acquire) from [<801362c8>] (process_one_work+0x18c/0x42c)
[<801362c8>] (process_one_work) from [<801365a0>] (worker_thread+0x38/0x4d4)
[<801365a0>] (worker_thread) from [<8013c8b4>] (kthread+0x138/0x170)
[<8013c8b4>] (kthread) from [<80107b30>] (ret_from_fork+0x14/0x24)
Executing /sbin/init 



Lothar Wa?mann
