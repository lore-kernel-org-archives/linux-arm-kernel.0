From: zoltan.kiss@linaro.org (Zoltan Kiss)
Date: Thu, 11 Dec 2014 17:56:38 +0000
Subject: Soft lockup problem on Hisilicon P650
Message-ID: <5489DAD6.6040101@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm having a soft lockup problem with a heavily modified Open vSwitch. 
(it runs OpenDataPlane). After starting it the whole system gets 
stucked, I managed to get some backtraces with SysRq. It's a HiSilicon 
P650 SoC (A15), I have the feeling an interrupt got stucked, but could 
someon help me interpreting this stack trace?

Regards,

Zoltan Kiss

[  379.532897] BUG: soft lockup - CPU#0 stuck for 25s! [ovs-vswitchd:783]
[  379.554792]
[  379.559800] CPU: 0 PID: 783 Comm: ovs-vswitchd Not tainted 
3.14.0.kz-00005-gb03444f-dirty #36
[  379.588394] task: c22803c0 ti: c1878000 task.ti: c1878000
[  379.606515] PC is at __do_softirq+0xc8/0x248
[  379.620841] LR is at __do_softirq+0xb8/0x248
[  379.635166] pc : [<c0021dd4>]    lr : [<c0021dc4>]    psr: 20010113
[  379.635166] sp : c1879f28  ip : c05a2980  fp : 00121690
[  379.673664] r10: 0011eb88  r9 : c0576080  r8 : 0011c5f0
[  379.691188] r7 : c1878000  r6 : 00000000  r5 : 0000001e  r4 : 00000282
[  379.713080] r3 : c1878000  r2 : 00000100  r1 : 00000000  r0 : 00000000
[  379.734977] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM 
Segment user
[  379.758910] Control: 30c5387d  Table: 11823580  DAC: fffffffd
[  379.778185] CPU: 0 PID: 783 Comm: ovs-vswitchd Not tainted 
3.14.0.kz-00005-gb03444f-dirty #36
[  379.806807] [<c0014328>] (unwind_backtrace) from [<c0011744>] 
(show_stack+0x10/0x14)
[  379.832805] [<c0011744>] (show_stack) from [<c0438308>] 
(dump_stack+0x7c/0xbc)
[  379.857051] [<c0438308>] (dump_stack) from [<c0075920>] 
(watchdog_timer_fn+0x144/0x17c)
[  379.883920] [<c0075920>] (watchdog_timer_fn) from [<c003ab40>] 
(__run_hrtimer.isra.32+0x44/0xd4)
[  379.913401] [<c003ab40>] (__run_hrtimer.isra.32) from [<c003b644>] 
(hrtimer_interrupt+0x118/0x2a4)
[  379.943467] [<c003b644>] (hrtimer_interrupt) from [<c032994c>] 
(arch_timer_handler_phys+0x28/0x30)
[  379.973532] [<c032994c>] (arch_timer_handler_phys) from [<c005db68>] 
(handle_percpu_devid_irq+0x6c/0x84)
[  380.005343] [<c005db68>] (handle_percpu_devid_irq) from [<c005a624>] 
(generic_handle_irq+0x2c/0x3c)
[  380.035691] [<c005a624>] (generic_handle_irq) from [<c000f16c>] 
(handle_IRQ+0x40/0x90)
[  380.062252] [<c000f16c>] (handle_IRQ) from [<c0008568>] 
(gic_handle_irq+0x2c/0x5c)
[  380.087648] [<c0008568>] (gic_handle_irq) from [<c0012280>] 
(__irq_svc+0x40/0x70)
[  380.112742] Exception stack(0xc1879ee0 to 0xc1879f28)
[  380.129693] 9ee0: 00000000 00000000 00000100 c1878000 00000282 
0000001e 00000000 c1878000
[  380.157123] 9f00: 0011c5f0 c0576080 0011eb88 00121690 c05a2980 
c1879f28 c0021dc4 c0021dd4
[  380.184548] 9f20: 20010113 ffffffff
[  380.196262] [<c0012280>] (__irq_svc) from [<c0021dd4>] 
(__do_softirq+0xc8/0x248)
[  380.221087] [<c0021dd4>] (__do_softirq) from [<c00221dc>] 
(irq_exit+0xb8/0xf4)
[  380.245324] [<c00221dc>] (irq_exit) from [<c000f170>] 
(handle_IRQ+0x44/0x90)
[  380.268974] [<c000f170>] (handle_IRQ) from [<c0008568>] 
(gic_handle_irq+0x2c/0x5c)
[  380.294366] [<c0008568>] (gic_handle_irq) from [<c001243c>] 
(__irq_usr+0x3c/0x60)
[  380.319463] Exception stack(0xc1879fb0 to 0xc1879ff8)
[  380.336409] 9fa0:                                     000003cf 
b5b36604 00000400 000003cf
[  380.363842] 9fc0: b6b66000 001390b0 00113350 bedaf2a0 0011c5f0 
001213f0 0011eb88 00121690
[  380.391271] 9fe0: 00000000 bedaf2a0 000b658d 000b6590 80010030 ffffffff
