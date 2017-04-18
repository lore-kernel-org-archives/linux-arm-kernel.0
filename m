From: lkundrak@v3.sk (Lubomir Rintel)
Date: Tue, 18 Apr 2017 12:44:28 +0200
Subject: Panic in arch_hw_breakpoint_init() on Cortex-A9 (SPEAr1340)
Message-ID: <1492512268.28092.8.camel@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm getting a crash that looks awfully lot like what ddc37832a1 [ARM:
8634/1: hw_breakpoint: blacklist Scorpion CPUs] aims to fix.

My hardware doesn't use a Scorpion CPU though -- it uses a Cortex-A9
(cpuid=0x412fc091).

[????0.157000] Internal error: Oops - undefined instruction: 0 [#1] SMP ARM
[????0.157000] Modules linked in:
[????0.157000] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.11.0-0.rc3.git0.2.spear2.fc26.armv7hl #1
[????0.157000] Hardware name: ST SPEAr1340 SoC with Flattened Device Tree
[????0.157000] task: ef102b80 task.stack: ef0fa000
[????0.157000] PC is at arch_hw_breakpoint_init+0x130/0x2a0
[????0.157000] LR is at arch_hw_breakpoint_init+0x7c/0x2a0
[????0.157000] pc : [<c0e0538c>]????lr : [<c0e052d8>]????psr: 60000013
[????0.157000] sp : ef0fbee8??ip : 00000000??fp : 00000000
[????0.157000] r10: c0ea183c??r9 : c0f24814??r8 : 00000000
[????0.157000] r7 : 000000e4??r6 : c0ea1828??r5 : c112e488??r4 : c112e488
[????0.157000] r3 : 0000000f??r2 : 510002d0??r1 : 2e7a7000??r0 : 00000003
[????0.157000] Flags: nZCv??IRQs on??FIQs on??Mode SVC_32??ISA ARM??Segment none
[????0.157000] Control: 10c5387d??Table: 0020404a??DAC: 00000051
[????0.157000] Process swapper/0 (pid: 1, stack limit = 0xef0fa220)
[????0.157000] Stack: (0xef0fbee8 to 0xef0fc000)
[????0.157000] bee0:???????????????????c0c7e6c6 ef182234 00000000 54410001 00000000 c0e0525c
[????0.157000] bf00: ffffe000 c0ea1828 000000e4 c0301e08 c112d980 00000000 c0ea1800 c036ab70
[????0.157000] bf20: efffcd92 c036ab70 efffcd92 c036ab70 00000003 00000001 c0d9a670 000000e4
[????0.157000] bf40: 00000003 00000003 c0d9a710 c0d9a710 c10359ac 00000004 00000004 c112d980
[????0.157000] bf60: c0ea1828 000000e4 c112d980 c0ea183c 00000000 c0e00ec0 00000003 00000003
[????0.157000] bf80: 00000000 c0e005c0 00000000 c0a33600 00000000 00000000 00000000 00000000
[????0.157000] bfa0: 00000000 c0a33610 00000000 c0307ef8 00000000 00000000 00000000 00000000
[????0.157000] bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[????0.157000] bfe0: 00000000 00000000 00000000 00000000 00000013 00000000 ffffffff ffffffff
[????0.157000] [<c0e0538c>] (arch_hw_breakpoint_init) from [<c0301e08>] (do_one_initcall+0x12c/0x154)
[????0.157000] [<c0301e08>] (do_one_initcall) from [<c0e00ec0>] (kernel_init_freeable+0x218/0x264)
[????0.157000] [<c0e00ec0>] (kernel_init_freeable) from [<c0a33610>] (kernel_init+0x10/0x114)
[????0.157000] [<c0a33610>] (kernel_init) from [<c0307ef8>] (ret_from_fork+0x14/0x3c)
[????0.157000] Code: e1a00004 ebd52503 ebd522fa eaffffc5 (ee110e91)
[????0.157000] ---[ end trace dc9bbf347b3b7b44 ]---
[????0.158000] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[????0.158000]
[????0.158000] CPU1: stopping
[????0.158000] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G??????D?????????4.11.0-0.rc3.git0.2.spear2.fc26.armv7hl #1
[????0.158000] Hardware name: ST SPEAr1340 SoC with Flattened Device Tree
[????0.158000] [<c03117a0>] (unwind_backtrace) from [<c030c4d0>] (show_stack+0x18/0x1c)
[????0.158000] [<c030c4d0>] (show_stack) from [<c063a044>] (dump_stack+0x80/0xa0)
[????0.158000] [<c063a044>] (dump_stack) from [<c030f578>] (handle_IPI+0x154/0x29c)
[????0.158000] [<c030f578>] (handle_IPI) from [<c03017ec>] (gic_handle_irq+0x7c/0x84)
[????0.158000] [<c03017ec>] (gic_handle_irq) from [<c0a3978c>] (__irq_svc+0x6c/0x90)
[????0.158000] Exception stack(0xef12df80 to 0xef12dfc8)
[????0.158000] df80: 00000001 00000000 00000000 c031c800 00000000 00000000 ffffe000 c1004df4
[????0.158000] dfa0: c1004e58 412fc091 00000000 00000000 00000001 ef12dfd0 c0308988 c0308978
[????0.158000] dfc0: 60000013 ffffffff
[????0.158000] [<c0a3978c>] (__irq_svc) from [<c0308978>] (arch_cpu_idle+0x24/0x40)
[????0.158000] [<c0308978>] (arch_cpu_idle) from [<c0391a54>] (do_idle+0xfc/0x1d8)
[????0.158000] [<c0391a54>] (do_idle) from [<c0391d84>] (cpu_startup_entry+0x20/0x24)
[????0.158000] [<c0391d84>] (cpu_startup_entry) from [<00301a2c>] (0x301a2c)
[????0.158000] Rebooting in 10 seconds..

Lubo
