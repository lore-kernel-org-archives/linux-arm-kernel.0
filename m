From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 29 Sep 2014 12:47:03 +0200
Subject: ARMADA 370 - Kernel panic during boot
In-Reply-To: <6241a6200de0d573c982f73f062ed7fa@twien.net>
References: <6241a6200de0d573c982f73f062ed7fa@twien.net>
Message-ID: <542938A7.8050307@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tormod,

On 29/09/2014 12:09, post at twien.net wrote:
> I'm trying to run the linux 3.16.3 kernel on a custom board based on the 
> ARMADA 370 (88F6W11).
> The bootloader (U-boot) is the latest from Marvell. A custom .dts file 
> is created for the board.

Could you send your dts file and your .config ? it will help us to understand
what happens. Maybe you have a wrong address in your dts.

> The Kernel panics during initialization. See screen dump.
> The error occurs when trying to read the interrupt control register (on 
> this line:)
> 
> control = readl(main_int_base + ARMADA_370_XP_INT_CONTROL);
> => Unhandled fault: external abort on non-linefetch (0x1008) at 
> 0xf0000a00

It is not the first access on this register so it's surprising that it
crashes here.

> 
> Any hint in which direction to look is welcome. The MMU?

I put the other mvebu maintainer in copy and also the main developer on
this SoC to see if it something familiar to them.

Gregory
> 
> Thanks, Tormod
> 
> 
> Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 3.16.3 (tormod at TW-Dell) (gcc version 4.6.4 
> (Linaro GCC branch-4.6.4. Marvell GCC Dev 201310-2126.3d181f66 64K 
> MAXPAGESIZE ALIGN) ) #13 SMP Wed Sep 24 14:45:08 CEST 2014
> [    0.000000] CPU: ARMv7 Processor [561f5811] revision 1 (ARMv7), 
> cr=10c5387d
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction 
> cache
> [    0.000000] Machine model: Marvell Armada 370 Ethernet Prototype
> [    0.000000] bootconsole [earlycon0] enabled
> [    0.000000] Truncating RAM at 0x00000000-0x40000000 to -0x2f800000
> [    0.000000] Memory policy: Data cache writeback
> [    0.000000] CPU: All CPU(s) started in SVC mode.
> [    0.000000] PERCPU: Embedded 7 pages/cpu @ef137000 s5952 r8192 d14528 
> u32768
> [    0.000000] Kernel command line: console=ttyS0,115200 root=/dev/nfs 
> rw nfsroot=193.71.72.30:/srv/nfs4/fs ip=dhcp earlyprintk
> [    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
> [    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 
> bytes)
> [    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 
> bytes)
> [    0.000000] Virtual kernel memory layout:
> [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
> [    0.000000]     fixmap  : 0xffc00000 - 0xffe00000   (2048 kB)
> [    0.000000]     vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
> [    0.000000]     lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
> [    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
> [    0.000000]       .text : 0xc0008000 - 0xc04ba004   (4809 kB)
> [    0.000000]       .init : 0xc04bb000 - 0xc04e9740   ( 186 kB)
> [    0.000000]       .data : 0xc04ea000 - 0xc050f880   ( 151 kB)
> [    0.000000]        .bss : 0xc050f888 - 0xc0544afc   ( 213 kB)
> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, 
> Nodes=1
> [    0.000000] Hierarchical RCU implementation.
> [    0.000000]  RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=1.
> [    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, 
> nr_cpu_ids=1
> [    0.000000] NR_IRQS:16 nr_irqs:16 16
> [    0.000000] Unhandled fault: external abort on non-linefetch (0x1008) 
> at 0xf0000a00
> [    0.000000] Internal error: : 1008 [#1] SMP ARM
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.16.3 #13
> [    0.000000] task: c04f4c60 ti: c04ea000 task.ti: c04ea000
> [    0.000000] PC is at armada_370_xp_mpic_of_init+0xf8/0x1dc
> [    0.000000] LR is at ioremap_page_range+0xf4/0x19c
> [    0.000000] pc : [<c04ccda8>]    lr : [<c01f06d4>]    psr: a00001d3
> [    0.000000] sp : c04ebee0  ip : c04ebe78  fp : c04ebf44
> [    0.000000] r10: 00100100  r9 : 00200200  r8 : c04e6f00
> [    0.000000] r7 : 00000000  r6 : c0538cc0  r5 : 00000000  r4 : 
> ef144300
> [    0.000000] r3 : f0000a00  r2 : 00000000  r1 : d0021e13  r0 : 
> f0002870
> [    0.000000] Flags: NzCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  
> Segment kernel
> [    0.000000] Control: 10c5387d  Table: 00004019  DAC: 00000015
> [    0.000000] Process swapper/0 (pid: 0, stack limit = 0xc04ea248)
> [    0.000000] Stack: (0xc04ebee0 to 0xc04ec000)
> [    0.000000] bee0: 00000000 ef144300 d0020a00 d0020bcf ef144358 
> 00000200 00000000 00000000
> [    0.000000] bf00: 00000000 d0021870 d00218c7 ef144358 00000200 
> 00000000 00000000 00000000
> [    0.000000] bf20: c02b3260 eec023c0 c04ebf48 c04ebf48 00000000 
> c04e6f00 c04ebf84 c04ebf48
> [    0.000000] bf40: c04d1dc8 c04cccbc c04ebf48 c04ebf48 c04ebf50 
> c04ebf50 ef7fcd00 c04e375c
> [    0.000000] bf60: c050f8c0 c04e376c ef7fcd00 00004059 561f5811 
> 00000000 c04ebf94 c04ebf88
> [    0.000000] bf80: c04ccca4 c04d1c6c c04ebfa4 c04ebf98 c04c1528 
> c04ccc9c c04ebfbc c04ebfa8
> [    0.000000] bfa0: c04bc68c c04c1524 c04f27dc ffffffff c04ebff4 
> c04ebfc0 c04bbabc c04bc66c
> [    0.000000] bfc0: ffffffff ffffffff c04bb668 00000000 00000000 
> c04e376c c050fb54 c04f23fc
> [    0.000000] bfe0: c04e3768 c04f5c10 00000000 c04ebff8 00008074 
> c04bb8d4 00000000 00000000
> [    0.000000] Backtrace:
> [    0.000000] [<c04cccb0>] (armada_370_xp_mpic_of_init) from 
> [<c04d1dc8>] (of_irq_init+0x168/0x2a4)
> [    0.000000]  r8:c04e6f00 r7:00000000 r6:c04ebf48 r5:c04ebf48 
> r4:eec023c0
> [    0.000000] [<c04d1c60>] (of_irq_init) from [<c04ccca4>] 
> (irqchip_init+0x14/0x20)
> [    0.000000]  r10:00000000 r9:561f5811 r8:00004059 r7:ef7fcd00 
> r6:c04e376c r5:c050f8c0
> [    0.000000]  r4:c04e375c
> [    0.000000] [<c04ccc90>] (irqchip_init) from [<c04c1528>] 
> (mvebu_init_irq+0x10/0x5c)
> [    0.000000] [<c04c1518>] (mvebu_init_irq) from [<c04bc68c>] 
> (init_IRQ+0x2c/0x84)
> [    0.000000] [<c04bc660>] (init_IRQ) from [<c04bbabc>] 
> (start_kernel+0x1f4/0x318)
> [    0.000000]  r4:ffffffff r3:c04f27dc
> [    0.000000] [<c04bb8c8>] (start_kernel) from [<00008074>] (0x8074)
> [    0.000000]  r7:c04f5c10 r6:c04e3768 r5:c04f23fc r4:c050fb54
> [    0.000000] Code: e3500000 1a000000 e7f001f2 e5963000 (e5937000)
> [    0.000000] ---[ end trace 3406ff24bd97382e ]---
> [    0.000000] Kernel panic - not syncing: Attempted to kill the idle 
> task!
> [    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill 
> the idle task!
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
