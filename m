From: romain.izard.pro@gmail.com (Romain Izard)
Date: Mon, 6 Mar 2017 12:28:00 +0100
Subject: Warning on boot on SAMA5D2 with Linux 4.11-rc1
Message-ID: <CAGkQfmPP7w09xutsK5OhfWzNfCyC3Bj8VmoFxDiB5eqAFnZBbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

While looking for another issue, I tried Linux 4.11-rc1 on a SAMA5D2 Xplained
board. The boot log contains the following warning:

[    0.100000] ------------[ cut here ]------------
[    0.100000] WARNING: CPU: 0 PID: 1 at
../kernel/time/sched_clock.c:180 sched_clock_register+0x44/0x1e4
[    0.100000] CPU: 0 PID: 1 Comm: swapper Not tainted 4.11.0-rc1+ #3
[    0.100000] Hardware name: Atmel SAMA5
[    0.100000] [<c010c494>] (unwind_backtrace) from [<c010a558>]
(show_stack+0x10/0x14)
[    0.100000] [<c010a558>] (show_stack) from [<c0115654>] (__warn+0xe0/0xf8)
[    0.100000] [<c0115654>] (__warn) from [<c011571c>]
(warn_slowpath_null+0x20/0x28)
[    0.100000] [<c011571c>] (warn_slowpath_null) from [<c090b0d0>]
(sched_clock_register+0x44/0x1e4)
[    0.100000] [<c090b0d0>] (sched_clock_register) from [<c091fb98>]
(tcb_clksrc_init+0x1ac/0x360)
[    0.100000] [<c091fb98>] (tcb_clksrc_init) from [<c0900d8c>]
(do_one_initcall+0xb4/0x15c)
[    0.100000] [<c0900d8c>] (do_one_initcall) from [<c0900f68>]
(kernel_init_freeable+0x134/0x1c4)
[    0.100000] [<c0900f68>] (kernel_init_freeable) from [<c06bfc64>]
(kernel_init+0x8/0x10c)
[    0.100000] [<c06bfc64>] (kernel_init) from [<c0107318>]
(ret_from_fork+0x14/0x3c)
[    0.100000] ---[ end trace 7ce9be9d7cf6f800 ]---
[    0.100012] sched_clock: 32 bits at 10MHz, resolution 96ns, wraps
every 206986376143ns

This is related to the following commit:
7b9f1d16e6d1 clocksource/drivers/tcb_clksrc: Use 32 bit tcb as sched_clock

When we call sched_clock_register from tcb_clksrc_init from
arch_initcall, we are too late as sched expects all the candidates for
its clock to be registered before interrupts are enabled. This warning
does not prevent the tcb clock from being used.

-- 
Romain Izard
