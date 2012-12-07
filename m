From: harvey.huawei.yang@gmail.com (harvey yang)
Date: Fri, 7 Dec 2012 17:16:12 +0800
Subject: Help: A strange kernel panic with r0 corrupted by cpsr
Message-ID: <CAFCUKTSrjii95Z8rJWbzgzG5jSpDLg1_1A+N9yK1YZwvDKksZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,
I met a strange problem, in an interrupt handler kernel panic happened
when requesting at virtual address 602acba3. From the log I find that
r0 is the same value with cpsr while it shoud be the base address of a
global structure 0xd6800000.
So when I reference a feild of that structure, kernel panics :(. I
really do not know what gose wrong. A corrupted stack? The following
is the log. Any advice will be appreciated!

/ # Unable to handle kernel paging request at virtual address 602acba3
pgd = c0004000
[602acba3] *pgd=00000000
Internal error: Oops: 5 [#1] PREEMPT
Modules linked in:
CPU: 0    Tainted: G        W    (3.0.0-14.1-build3 #647)
PC is at active_true_index_check+0x28/0x4c
LR is at cap_dl_res_adjust+0x3f8/0xa40
pc : [<c01fb26c>]    lr : [<c01f3004>]    psr: 60000193
sp : c0449e30  ip : 00000515  fp : d68079f8
r10: 00000000  r9 : 00000000  r8 : 000079f8
r7 : 00000100  r6 : d6aaa788  r5 : 00000006  r4 : d6800000
r3 : 00000001  r2 : 00000288  r1 : 002aca10  r0 : 60000193
Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 18c5387d  Table: 123b0059  DAC: 00000015
Process swapper (pid: 0, stack limit = 0xc04482e8)
Stack: (0xc0449e30 to 0xc044a000)
9e20:                                     00000002 c01eb06c d6aa9bac d6800000
9e40: 00000004 00000000 00000000 00000013 d68079f8 0000015b 0000e3b7 00000000
9e60: 00000006 00000003 d6aa99bc c01f2364 d6800000 c08a1910 0000011d d6800000
9e80: 00000006 0000b335 091be1c1 c08a17cc d6804a10 00000047 00000000 c01f9d28
9ea0: c08a17cc c08a17cc 091be1c2 c01f9de4 c08a17cc d6800000 ffdf22e0 c01e91f4
9ec0: d6800000 0003806d 000166f8 c08a17cc c08a17cc 80c60052 c0452e24 00000000
9ee0: 00000000 c0448000 00000000 c01e99f4 0c8fdb11 00000016 0c8fdb11 00000016
9f00: c0453fdc c0453d8c c0462554 0000005b c0452e24 00000000 00000000 c0448000
9f20: 00000000 c006b028 c0452e24 c0462554 c0452e24 c0448000 c0462554 00000002
9f40: 00000001 c0448000 00000000 c006b1c8 c0452e24 00000000 0000005b c006d070
9f60: 0000005b c006ab7c 0000005b c0025060 60000013 ffffffff f8f00100 c002a08c
9f80: c0448000 c0448008 c0449fc8 00000000 c044d0a4 00000000 c1503b00 c044d09c
9fa0: 00004059 413fc090 00000000 00000000 00000000 c0449fc8 c002aef4 c002aef8
9fc0: 60000013 ffffffff 00000000 c002b03c c044a104 c00088b8 c0008328 03bff7d0
9fe0: 01000000 c0472300 18c5387d c044a040 c0021678 00008044 00000000 00000000
[<c01fb26c>] (active_true_index_check+0x28/0x4c) from [<c01f3004>]
(cap_dl_res_adjust+0x3f8/0xa40)
[<c01f3004>] (cap_dl_res_adjust+0x3f8/0xa40) from [<c01f9d28>]
(cap_rt_sched_disp+0x14/0xbc)
[<c01f9d28>] (cap_rt_sched_disp+0x14/0xbc) from [<c01f9de4>]
(cap_rt_rtn+0x14/0x34)
[<c01f9de4>] (cap_rt_rtn+0x14/0x34) from [<c01e91f4>] (rcvIntDisp+0x1c4/0x594)
[<c01e91f4>] (rcvIntDisp+0x1c4/0x594) from [<c01e99f4>]
(cap_mac_interrupt+0x430/0x5dc)
[<c01e99f4>] (cap_mac_interrupt+0x430/0x5dc) from [<c006b028>]
(handle_irq_event_percpu+0x28/0x170)
[<c006b028>] (handle_irq_event_percpu+0x28/0x170) from [<c006b1c8>]
(handle_irq_event+0x58/0x74)
[<c006b1c8>] (handle_irq_event+0x58/0x74) from [<c006d070>]
(handle_fasteoi_irq+0xb4/0x108)
[<c006d070>] (handle_fasteoi_irq+0xb4/0x108) from [<c006ab7c>]
(generic_handle_irq+0x20/0x30)
[<c006ab7c>] (generic_handle_irq+0x20/0x30) from [<c0025060>]
(asm_do_IRQ+0x60/0x84)
[<c0025060>] (asm_do_IRQ+0x60/0x84) from [<c002a08c>] (__irq_svc+0x4c/0xcc)
Exception stack(0xc0449f80 to 0xc0449fc8)
9f80: c0448000 c0448008 c0449fc8 00000000 c044d0a4 00000000 c1503b00 c044d09c
9fa0: 00004059 413fc090 00000000 00000000 00000000 c0449fc8 c002aef4 c002aef8
9fc0: 60000013 ffffffff
[<c002a08c>] (__irq_svc+0x4c/0xcc) from [<c002aef8>] (default_idle+0x24/0x28)
[<c002aef8>] (default_idle+0x24/0x28) from [<c002b03c>] (cpu_idle+0x34/0x94)
[<c002b03c>] (cpu_idle+0x34/0x94) from [<c00088b8>] (start_kernel+0x280/0x2d4)
[<c00088b8>] (start_kernel+0x280/0x2d4) from [<00008044>] (0x8044)
Code: e7d03001 e3530001 1a000005 e59f101c (e7903001)
---[ end trace 1b75b31a2719ed1e ]---
Kernel panic - not syncing: Fatal exception in interrupt
