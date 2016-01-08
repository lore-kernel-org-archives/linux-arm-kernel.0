From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 8 Jan 2016 16:16:49 +0900
Subject: [Question] Any restriction for the location of initramdisk?
Message-ID: <CAK7LNAQS--QobTNyAvxqqZY2gvy4zB_eBOGju69Pjs-1FAJ+tQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.


I know DTB should be located within the reach of the kernel
so that the kernel can get access to it at the early boot stage.
In other words, DTB should be put in the low memory area.

Does initramdisk has the similar restriction?
Or, does the kernel try best effort to relocate the initramdisk
when it is placed too high by a boot-loader?


As far as I tested on my board,
the kernel would not boot if initramdisk goes too high.
So, I suspect that there is some restriction.  I want to know this.


[My board detail]
I use  arch/arm/configs/multi_v7_defconfig of the mainline kernel.
The DRAM is located at the physical address 0x80000000 - 0xffffffff
on my board.

I put the zImage at  0x80208000.   (So, PHYS_OFFSET = 0x80000000)

The format of the initramdisk is  .cpio.gz
I created it with Buildroot.


(1) If I put the initramdisk at 0x9f677000, the kernel booted successfully.

(2) If I put the initramdisk at 0xb7677000, the kernel failed to boot.



The following is the snippet of the log of U-Boot and the Kernel.
(earlycon is enabled so that the kernel can display as much log as possible.


-----------------------------[log]----------------------------------------

Kernel image @ 0x80208000 [ 0x000000 - 0x642a10 ]
## Loading init Ramdisk from Legacy Image at 84a00000 ...
   Image Name:
   Created:      2015-09-24   4:40:46 UTC
   Image Type:   ARM Linux RAMDisk Image (uncompressed)
   Data Size:    9997435 Bytes = 9.5 MiB
   Load Address: 00000000
   Entry Point:  00000000
## Flattened Device Tree blob at 84100000
   Booting using the fdt blob at 0x84100000
   Loading Ramdisk to b7677000, end b7fffc7b ... OK
   Loading Device Tree to 9fffb000, end 9fffff2b ... OK

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.4.0-rc8-00139-g9010cb3-dirty
(yamada at beagle) (gcc version 4.9.0 (GCC) ) #159 SMP Fri Jan 8 15:01:34
JST 2016
[    0.000000] CPU: ARMv7 Processor [414fc091] revision 1 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
instruction cache
[    0.000000] Machine model: UniPhier ProXstream2 Gentil Board
[    0.000000] bootconsole [uart0] enabled
[    0.000000] cma: Reserved 64 MiB at 0xfb800000
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] On node 0 totalpages: 524287
[    0.000000] free_area_init_node: node 0, pgdat c100b700,
node_mem_map eeff9000
[    0.000000]   DMA zone: 1536 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 196608 pages, LIFO batch:31
[    0.000000]   HighMem zone: 327679 pages, LIFO batch:31
[    0.000000] PERCPU: Embedded 12 pages/cpu @eefb7000 s19136 r8192
d21824 u49152
[    0.000000] pcpu-alloc: s19136 r8192 d21824 u49152 alloc=12*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 522751
[    0.000000] Kernel command line: earlycon loglevel=8
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Memory: 1989660K/2097148K available (8378K kernel code,
981K rwdata, 3916K rodata, 1076K init, 340K bss, 41952K reserved,
65536K cma-reserved, 1235416K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xf0000000   ( 768 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0208000 - 0xc0e0aac0   (12299 kB)
[    0.000000]       .init : 0xc0e0b000 - 0xc0f18000   (1076 kB)
[    0.000000]       .data : 0xc0f18000 - 0xc100d660   ( 982 kB)
[    0.000000]        .bss : 0xc1010000 - 0xc1065368   ( 341 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  Build-time adjustment of leaf fanout to 32.
[    0.000000]  RCU restricting CPUs from NR_CPUS=16 to nr_cpu_ids=4.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=32, nr_cpu_ids=4
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] uniphier: enabled outer cache (cache level: 2)
[    0.000007] sched_clock: 64 bits at 50MHz, resolution 20ns, wraps
every 4398046511100ns
[    0.007967] clocksource: arm_global_timer: mask: 0xffffffffffffffff
max_cycles: 0xb8812736b, max_idle_ns: 440795202655 ns
[    0.019373] Console: colour dummy device 80x30
[    0.023791] console [tty0] enabled
[    0.027196] bootconsole [uart0] disabled

---------------------------------[log end]-------------------------------------




-- 
Best Regards
Masahiro Yamada
