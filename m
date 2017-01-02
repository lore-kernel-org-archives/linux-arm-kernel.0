From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 2 Jan 2017 15:15:46 +0100
Subject: [PATCH 15/20] ARM/hw_breakpoint: Convert to hotplug state machine
In-Reply-To: <20161117183541.8588-16-bigeasy@linutronix.de>
References: <20161117183541.8588-1-bigeasy@linutronix.de>
 <20161117183541.8588-16-bigeasy@linutronix.de>
Message-ID: <CACRpkdZE+h0+3EizLCMUr-e-4pv4w9iAatSqL8k0Ovd2iUaS8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2016 at 7:35 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:

> Install the callbacks via the state machine and let the core invoke
> the callbacks on the already online CPUs.
>
> smp_call_function_single() has been removed because the function is already
> invoked on the target CPU.
>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

This patch causes a regression on my Qualcomm APQ8060 DragonBoard.

[    0.000000] CPU: ARMv7 Processor [510f02d2] revision 2 (ARMv7), cr=10c5787d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIVT ASID
tagged instruction cache
[    0.000000] OF: fdt:Machine model: Qualcomm APQ8060 Dragonboard

The board hangs in very early boot. Reverting the commit does not work
because of dependencies, but I bisected down to this commit.

With earlypints the crash looks like this:

 NET: Registered protocol family 16
 DMA: preallocated 256 KiB pool for atomic coherent allocations
 cpuidle: using governor menu
 hw-breakpoint: found 3 (+1 reserved) breakpoint and 1 watchpoint registers.
 Internal error: Oops - undefined instruction: 0 [#1] PREEMPT SMP ARM
 Modules linked in: c
 CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.10.0-rc2-00001-g100b2fb6bf9c #19
 Hardware name: Generic DT based system
 task: c02a0000 task.stack: c029a000
PC is at write_wb_reg+0x20c/0x330
LR is at arch_hw_breakpoint_init+0x1dc/0x27c
pc : [<c03101dc>]    lr : [<c0c0551c>]    psr: 80000013
sp : c029bef0  ip : 00000000  fp : dfffcd80
r10: c0c4f83c  r9 : 00000004  r8 : 000000af
r7 : c0c4f828  r6 : c10a631c  r5 : c10a631c  r4 : 00001fe0
r3 : 00000020  r2 : 00001fe0  r1 : 00000000  r0 : 00000060
Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5787d  Table: 4020406a  DAC: 00000051
 Process swapper/0 (pid: 1, stack limit = 0xc029a210)
 Stack: (0xc029bef0 to 0xc029c000)
 bee0:                                     00000000 00000000 dfffcd80 07f80000
 bf00: ffffe000 c0c05340 00000000 c030185c c0b7b7d4 dfffcded c0931100 c033b75c
 bf20: 60000013 00000003 00000001 c0ab8424 c0b7aa28 00000000 c1099a20 00000003
 bf40: 00000003 c0ac1440 c100c588 c10a6000 c10a6000 00000003 c10a6000 c10a6000
 bf60: c0c5a30c 000000af 00000004 c0c00e04 00000003 00000003 00000000 c0c005c4
 bf80: c08d66c0 00000000 c08d66c0 00000000 00000000 00000000 00000000 00000000
 bfa0: 00000000 c08d66c8 00000000 c0308518 00000000 00000000 00000000 00000000
 bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
 bfe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[<c03101dc>] (write_wb_reg) from [<00000000>] (  (null))
 Code: ee001ed2 eaffffc3 ee001ed1 eaffffc1 (ee001ed0)
 ---[ end trace da08286cccfd900e ]---
 Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

 CPU1: stopping
 CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D
4.10.0-rc2-00001-g100b2fb6bf9c #19
 Hardware name: Generic DT based system
[<c030f914>] (unwind_backtrace) from [<c030c7b0>] (show_stack+0x10/0x14)
[<c030c7b0>] (show_stack) from [<c05eb2a0>] (dump_stack+0x78/0x8c)
[<c05eb2a0>] (dump_stack) from [<c030ea14>] (handle_IPI+0x358/0x368)
[<c030ea14>] (handle_IPI) from [<c03014a4>] (gic_handle_irq+0x88/0x8c)
[<c03014a4>] (gic_handle_irq) from [<c08dce8c>] (__irq_svc+0x6c/0xa8)
Exception stack(0xc02c5f70 to 0xc02c5fb8)
5f60:                                     00000001 00000000 00000000 c0318580
5f80: c02c4000 c1003c78 c1003c2c c0fa1f20 c0afea4c c02c5fc8 00000000 00000000
5fa0: 00000008 c02c5fc0 c0308f98 c0308f9c 60000013 ffffffff
[<c08dce8c>] (__irq_svc) from [<c0308f9c>] (arch_cpu_idle+0x38/0x3c)
[<c0308f9c>] (arch_cpu_idle) from [<c035d24c>] (do_idle+0x170/0x204)
[<c035d24c>] (do_idle) from [<c035d598>] (cpu_startup_entry+0x18/0x1c)
[<c035d598>] (cpu_startup_entry) from [<4030154c>] (0x4030154c)
---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

Something hits a brick wall when initializing the hardware breakpoints.

This is pretty tricksy for me to debug, hints welcome...

Yours,
Linus Walleij
