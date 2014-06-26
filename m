From: daniel@zonque.org (Daniel Mack)
Date: Thu, 26 Jun 2014 14:29:42 +0200
Subject: Regression in 3.16-rc1 due to 1417a6b8dc (ARM: 8036/1: Enable IRQs
 before attempting to read user space in __und_usr)
Message-ID: <53AC1236.2000504@zonque.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

I just noticed a regression when booting up a PXA3xx board with
3.16-rc1. I see the following warning, and the CPU is stalled afterwards:

[   44.600978] ------------[ cut here ]------------
[   44.605643] WARNING: CPU: 0 PID: 2026 at kernel/sched/core.c:2489
handle_IRQ+0x2c/0xac()
[   44.613671] DEBUG_LOCKS_WARN_ON((preempt_count() < 0))
[   44.618597] Modules linked in: w1_gpio wire pxamci
[   44.623570] CPU: 0 PID: 2026 Comm: ssh-keygen Not tainted 3.15.0-rc1+
#1192
[   44.630527] [<c000dd70>] (unwind_backtrace) from [<c000bc78>]
(show_stack+0x10/0x14)
[   44.638253] [<c000bc78>] (show_stack) from [<c00175cc>]
(warn_slowpath_common+0x60/0x80)
[   44.646297] [<c00175cc>] (warn_slowpath_common) from [<c0017618>]
(warn_slowpath_fmt+0x2c/0x3c)
[   44.654943] [<c0017618>] (warn_slowpath_fmt) from [<c0009b38>]
(handle_IRQ+0x2c/0xac)
[   44.662729] [<c0009b38>] (handle_IRQ) from [<c000853c>]
(ichp_handle_irq+0x24/0x2c)
[   44.670336] [<c000853c>] (ichp_handle_irq) from [<c000c7c0>]
(__irq_svc+0x40/0x6c)
[   44.677848] Exception stack(0xc70e9dd8 to 0xc70e9e20)
[   44.682864] 9dc0:
   00000000 c70e9e30
[   44.690987] 9de0: 00000003 ffffffff 000000a0 be954ac0 00000000
00000000 c785b6d8 00000000
[   44.699113] 9e00: c70e8000 00000000 00000013 c70e9e20 c000e240
fffffffc 40000013 ffffffff
[   44.707239] [<c000c7c0>] (__irq_svc) from [<fffffffc>] (0xfffffffc)
[   44.713465] ---[ end trace 5257138f34695fa8 ]---

git bisect shows 1417a6b8dc (ARM: 8036/1: Enable IRQs before attempting
to read user space in __und_usr) as first bad commit. When reverting the
changes in arch/arm/kernel/entry-armv.S that came in for 3.16c-rc1,
everything goes back to normal. Any ideas?

Arun - which SoC did you test this on? Did you enable CONFIG_DEBUG_PREEMPT?


Thanks,
Daniel
