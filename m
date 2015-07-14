From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 14 Jul 2015 12:54:15 -0300
Subject: mx6: suspicious RCU usage
Message-ID: <CAOMZO5DeOLORXUAgYN2_BkB1BS8wuF8CoTf=QOfU1fB-je0UHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am running 4.2-rc2 on a mx6q board and I see the following warning
when doing a suspend/resume cycle:

$ echo mem > /sys/power/state

PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.003 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.003 seconds) done.
Suspending console(s) (use no_console_suspend to debug)

(Press GPIO button to wake up the system)

PM: suspend of devices complete after 101.667 msecs
PM: suspend devices took 0.110 seconds
PM: late suspend of devices complete after 11.073 msecs
PM: noirq suspend of devices complete after 9.432 msecs
Disabling non-boot CPUs ...

===============================
[ INFO: suspicious RCU usage. ]
4.2.0-rc2 #247 Not tainted
-------------------------------
kernel/sched/fair.c:5032 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


RCU used illegally from offline CPU!
rcu_scheduler_active = 1, debug_locks = 0
3 locks held by swapper/1/0:
 #0:  ((cpu_died).wait.lock){......}, at: [<800643e0>] complete+0x1c/0x4c
 #1:  (&p->pi_lock){-.-.-.}, at: [<8004f7e8>] try_to_wake_up+0x34/0x3c8
 #2:  (rcu_read_lock){......}, at: [<80057b68>] select_task_rq_fair+0x64/0x9e8

stack backtrace:
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.2.0-rc2 #247
Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
Backtrace:
[<80012ee8>] (dump_backtrace) from [<80013084>] (show_stack+0x18/0x1c)
 r6:000013a8 r5:00000000 r4:00000000 r3:00000000
[<8001306c>] (show_stack) from [<8078d364>] (dump_stack+0x88/0xa4)
[<8078d2dc>] (dump_stack) from [<800676d8>] (lockdep_rcu_suspicious+0xbc/0x11c)
 r5:809497c4 r4:be076780
[<8006761c>] (lockdep_rcu_suspicious) from [<80058200>]
(select_task_rq_fair+0x6fc/0x9e8)
 r7:80a94fc0 r6:00000001 r5:00000000 r4:00000000
[<80057b04>] (select_task_rq_fair) from [<8004f8cc>]
(try_to_wake_up+0x118/0x3c8)
 r10:80a94fc0 r9:00000000 r8:00000000 r7:80000093 r6:80a98b2c r5:bd748f8c
 r4:bd748b80
[<8004f7b4>] (try_to_wake_up) from [<8004fb90>]
(default_wake_function+0x14/0x18)
 r10:00000003 r9:8004fb7c r8:00000000 r7:00000000 r6:80a9dc34 r5:00000001
 r4:80a9dc28
[<8004fb7c>] (default_wake_function) from [<80063b18>]
(__wake_up_common+0x58/0x98)
[<80063ac0>] (__wake_up_common) from [<80063b74>] (__wake_up_locked+0x1c/0x24)
 r10:80a98b2c r9:807993ac r8:80a98a10 r7:80afc552 r6:60000093 r5:80a9dc10
 r4:80a9dc14
[<80063b58>] (__wake_up_locked) from [<80064400>] (complete+0x3c/0x4c)
[<800643c4>] (complete) from [<807870e0>] (cpu_die+0x3c/0xa4)
 r6:80a923e4 r5:00000001 r4:80a98968 r3:00000002
[<807870a4>] (cpu_die) from [<80010798>] (arch_cpu_idle_dead+0x10/0x14)
 r5:80a989c4 r4:00000000
[<80010788>] (arch_cpu_idle_dead) from [<80064798>]
(cpu_startup_entry+0x1d8/0x200)
[<800645c0>] (cpu_startup_entry) from [<80015e34>]
(secondary_start_kernel+0x120/0x13c)
 r7:80aff360
[<80015d14>] (secondary_start_kernel) from [<1000962c>] (0x1000962c)
 r5:00000015 r4:4e08806a
CPU1: shutdown
CPU2: shutdown
CPU3: shutdown
Enabling non-boot CPUs ...
CPU1 is up
CPU2 is up
CPU3 is up
PM: noirq resume of devices complete after 2.185 msecs
PM: early resume of devices complete after 2.786 msecs
PM: resume of devices complete after 204.223 msecs
PM: resume devices took 0.200 seconds
ata1: SATA link down (SStatus 0 SControl 300)
PM: Finishing wakeup.
Restarting tasks ... done.

I haven't started bisecting it yet, but if someone has some ideas,
please let me know.

Regards,

Fabio Estevam
