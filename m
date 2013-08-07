From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 6 Aug 2013 22:41:11 -0700
Subject: VM Kernel bug with CONFIG_DEBUG_VM
Message-ID: <20130807054111.GQ16694@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I've found that booting a recent kernel (and as far back as 3.9 at
least) I get a kernel bug during boot with VM debugging enabled.  I
haven't had time to dig further into it, but wanted to check if this is
a known issue?

I am using a versatile express TC2 platform with the following config:
http://www.cs.columbia.edu/~cdall/vmbug.config

Here's a dump of the panic:

------------[ cut here ]------------
kernel BUG at mm/util.c:390!
Internal error: Oops - BUG: 0 [#1] SMP THUMB2
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W    3.11.0-rc1+ #112
task: c0432880 ti: c0428000 task.ti: c0428000
PC is at page_mapping+0x1a/0x30
LR is at flush_dcache_page+0x11/0x48
pc : [<c00786d6>]    lr : [<c001e02d>]    psr: 800001b3
sp : c0429dd8  ip : 00000000  fp : ef075780
r10: eea07e00  r9 : eec4b000  r8 : eea0a000
r7 : c0429e18  r6 : c0429e18  r5 : c045eb28  r4 : c0b078d8
r3 : 00000000  r2 : 00000080  r1 : 80000000  r0 : c0b078d8
Flags: Nzcv  IRQs off  FIQs on  Mode SVC_32  ISA Thumb  Segment kernel
Control: 70c53c7d  Table: 80003000  DAC: fffffffd
Process swapper/0 (pid: 0, stack limit = 0xc0428238)
Stack: (0xc0429dd8 to 0xc042a000)
9dc0:                                                       c04325c4 c01e848d
9de0: 00000001 00000001 00000000 00000000 00000000 00000001 f0100000 ef07586c
9e00: ef075868 00001000 eea06e00 ef075e28 00000003 00000000 eec4b000 eec4b000
9e20: c042a0c0 c0430428 00000001 c004308b c0429e38 00000000 ef080000 c0427600
9e40: c001a051 00000000 ef075780 00000000 ef0759f4 eec2d0d0 00000001 ef075868
9e60: 00000001 c01e8dad c0b32600 ef04df10 00000000 00000000 00000000 eec2d0d8
9e80: 00000000 00000001 a0040008 00003410 01018080 03800001 00000000 00000001
9ea0: 00000000 00000000 c042a0c0 ef075780 00000083 f0100000 00000030 f0002000
9ec0: ef00e480 c0453cec 00000001 c01e8e7d 40000193 00000000 00000000 c01db82f
9ee0: ee99c700 c0059dd7 00000000 00000020 c042a0a4 00000030 20000113 ef00e480
9f00: ef00e4d4 00000000 c0429f68 f0002000 c0453cd7 c0428000 c0428000 c0059edf
9f20: ef00e480 00000030 00000000 c005bb67 00000030 c0059a0b c0426cb4 c001637b
9f40: f000200c 00000020 c0430814 c0008539 c00165a6 40000133 ffffffff c0429f9c
9f60: c02b8b6c c001875b c0b318c0 00000000 00000000 00000000 c0428000 c0453cd7
9f80: 00000001 c0430438 c02b8b6c c0453cd7 c0428000 c0428000 c0428040 c0429fb0
9fa0: c00165a5 c00165a6 40000133 ffffffff 000011a8 c0046523 c04374c0 ffffffff
9fc0: 00000000 c03f55bd ffffffff ffffffff c03f522d 00000000 00000000 c0414008
9fe0: 00000000 70c73c7d c04303b0 c0414004 c0433f10 8000808d 00000000 00000000
[<c00786d6>] (page_mapping+0x1a/0x30) from [<c001e02d>] (flush_dcache_page+0x11/0x48)
[<c001e02d>] (flush_dcache_page+0x11/0x48) from [<c01e848d>] (schedule_ptds+0x231/0x548)
[<c01e848d>] (schedule_ptds+0x231/0x548) from [<c01e8dad>] (handle_done_ptds+0x2fd/0x360)
[<c01e8dad>] (handle_done_ptds+0x2fd/0x360) from [<c01e8e7d>] (isp1760_irq+0x6d/0x90)
[<c01e8e7d>] (isp1760_irq+0x6d/0x90) from [<c01db82f>] (usb_hcd_irq+0x1f/0x30)
[<c01db82f>] (usb_hcd_irq+0x1f/0x30) from [<c0059dd7>] (handle_irq_event_percpu+0x33/0x108)
[<c0059dd7>] (handle_irq_event_percpu+0x33/0x108) from [<c0059edf>] (handle_irq_event+0x33/0x48)
[<c0059edf>] (handle_irq_event+0x33/0x48) from [<c005bb67>] (handle_fasteoi_irq+0x4b/0xc4)
[<c005bb67>] (handle_fasteoi_irq+0x4b/0xc4) from [<c0059a0b>] (generic_handle_irq+0x13/0x1c)
[<c0059a0b>] (generic_handle_irq+0x13/0x1c) from [<c001637b>] (handle_IRQ+0x23/0x60)
[<c001637b>] (handle_IRQ+0x23/0x60) from [<c0008539>] (gic_handle_irq+0x21/0x4c)
[<c0008539>] (gic_handle_irq+0x21/0x4c) from [<c001875b>] (__irq_svc+0x3b/0x5c)
Exception stack(0xc0429f68 to 0xc0429fb0)
9f60:                   c0b318c0 00000000 00000000 00000000 c0428000 c0453cd7
9f80: 00000001 c0430438 c02b8b6c c0453cd7 c0428000 c0428000 c0428040 c0429fb0
9fa0: c00165a5 c00165a6 40000133 ffffffff
[<c001875b>] (__irq_svc+0x3b/0x5c) from [<c00165a6>] (arch_cpu_idle+0x16/0x1c)
[<c00165a6>] (arch_cpu_idle+0x16/0x1c) from [<c0046523>] (cpu_startup_entry+0x33/0xc8)
[<c0046523>] (cpu_startup_entry+0x33/0xc8) from [<c03f55bd>] (start_kernel+0x215/0x268)
[<c03f55bd>] (start_kernel+0x215/0x268) from [<8000808d>] (0x8000808d)
Code: bf18 2300 4618 4770 (de02) 69c3
---[ end trace 1b75b31a2719ed1e ]---
Kernel panic - not syncing: Fatal exception in interrupt
CPU1: stopping
CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D W    3.11.0-rc1+ #112
[<c001a439>] (unwind_backtrace+0x1/0x98) from [<c0017fab>] (show_stack+0xb/0xc)
[<c0017fab>] (show_stack+0xb/0xc) from [<c02b267f>] (dump_stack+0x4f/0x64)
[<c02b267f>] (dump_stack+0x4f/0x64) from [<c001990f>] (handle_IPI+0xa3/0xd0)
[<c001990f>] (handle_IPI+0xa3/0xd0) from [<c000855d>] (gic_handle_irq+0x45/0x4c)
[<c000855d>] (gic_handle_irq+0x45/0x4c) from [<c001875b>] (__irq_svc+0x3b/0x5c)
Exception stack(0xef0adf98 to 0xef0adfe0)
df80:                                                       c0b398c0 00000000
dfa0: 00000000 00000000 ef0ac000 c0453cd7 00000001 c0430438 c02b8b6c c0453cd7
dfc0: ef0ac000 ef0ac000 ef0ac040 ef0adfe0 c00165a5 c00165a6 40000133 ffffffff
[<c001875b>] (__irq_svc+0x3b/0x5c) from [<c00165a6>] (arch_cpu_idle+0x16/0x1c)
[<c00165a6>] (arch_cpu_idle+0x16/0x1c) from [<c0046523>] (cpu_startup_entry+0x33/0xc8)
[<c0046523>] (cpu_startup_entry+0x33/0xc8) from [<80008241>] (0x80008241)

--
Thanks,
Christoffer
