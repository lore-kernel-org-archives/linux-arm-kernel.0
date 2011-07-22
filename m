From: pj0585@gmail.com (P J)
Date: Fri, 22 Jul 2011 19:06:40 +0530
Subject: at91sam9g45: Issues while working with RAM that is separated on
	physical address space
Message-ID: <CAA2DH4u1kcky3xzxpepS=gtDK1Xas17zDxcRkDR7qRNLHQyoxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I'm using Linux 2.6.30 with a custom board design based on AT91SAM9G45-EKES.

The memory map (required) is as follows:
    phys           =>          virt
0x70000000    =>    0xC0000000  (128 MB)
0x20000000    =>    0xC8000000  (128 MB)

While booting I see this message: Ignoring RAM at 0x20000000 -
0x27FFFFFF (vmalloc region overlap).
The default and only option in the Kernel configuration is FLAT MEMORY MODEL.


Now I use the 2 patches put by Nicu at the following website:
http://blog.linuxconsulting.ro/2010/05/using-both-memory-controller-with.html

The patches basically do two things:
1) enable SPARSE memory &
2) Change the __virt_to_phys() and __phys_to_virt() in
arch/arm/include/asm/memory.h

After applying the patches
Linux does accept both the memory banks and the total memory is 256 MB
but crashes immediately after that.

The kernel dump is as follows:


Starting kernel ...

Uncompressing Linux................................................................................................................
done, booting the kernel.
Linux version 2.6.30 (prasant at prasant-laptop) (gcc version 4.2.0
20070413 (prerelease) (CodeSourcery Sourcery G++ Lite 2007q1-10)) #4
Fri Jul 22 14:46:45 IST 201
CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=00053177
CPU: VIVT data cache, VIVT instruction cache
Machine: Atmel AT91SAM9G45-EKES
Ignoring unrecognised tag 0x54410008
Memory policy: ECC disabled, Data cache writeback
Clocks: CPU 400 MHz, master 133 MHz, main 12.000 MHz
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 62720
Kernel command line: console=ttyS0,115200 rootfstype=ext3
root=/dev/mmcblk0p2 rootdelay=3 ip=dhcp
mtdparts=atmel_nand:128k(bootstrap)ro,256k(uboot)ro,128k(env1))
NR_IRQS:192
AT91: 160 gpio irqs in 5 banks
PID hash table entries: 1024 (order: 10, 4096 bytes)
Console: colour dummy device 80x30
console [ttyS0] enabled
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
MEM: unordered memory banks.  Not freeing memmap.
Memory: 128MB 128MB = 256MB total
Memory: 255932KB available (3108K code, 236K data, 116K init, 0K highmem)
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c0004000
[00000000] *pgd=00000000
Internal error: Oops: 5 [#1]
Modules linked in:
CPU: 0    Not tainted  (2.6.30 #4)
PC is at kmem_cache_alloc+0x1c/0x88
LR is at setup_cpu_cache+0x50/0x110
pc : [<c007f76c>]    lr : [<c0270288>]    psr: a00000d3
sp : c0349f40  ip : 0000001b  fp : ffffffe0
r10: 00000020  r9 : 00000000  r8 : 00000000
r7 : 000000d0  r6 : 00000000  r5 : c78000c0  r4 : a0000053
r3 : a00000d3  r2 : c02e9fe0  r1 : 000000d0  r0 : 00000000
Flags: NzCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
Control: 0005317f  Table: 70004000  DAC: 00000017
Process swapper (pid: 0, stack limit = 0xc0348268)
Stack: (0xc0349f40 to 0xc034a000)
9f40: c03762dc c0354d54 c78000c0 c03762d8 00042000 c0270288 c78000c0 000001e0
9f60: 00000020 c00805e8 c0349f80 c0349f84 c04961e0 00000001 c02e9fe0 00000001
9f80: 00000000 00000071 41069265 c0023854 00000000 c0349fbc c0354d54 c0354d80
9fa0: 41069265 7002091c 00000000 c00128f0 00000000 c0354d80 00000074 00000040
9fc0: c0022eec c036e9a0 c0022ee8 c034bc90 70020950 c0008b74 c00084ec 00000000
9fe0: 00000000 c0022eec 00000000 00053175 c036ea98 70008034 00000000 00000000
[<c007f76c>] (kmem_cache_alloc+0x1c/0x88) from [<c0270288>]
(setup_cpu_cache+0x50/0x110)
[<c0270288>] (setup_cpu_cache+0x50/0x110) from [<c00805e8>]
(kmem_cache_create+0x3b8/0x460)
[<c00805e8>] (kmem_cache_create+0x3b8/0x460) from [<c00128f0>]
(kmem_cache_init+0x144/0x344)
[<c00128f0>] (kmem_cache_init+0x144/0x344) from [<c0008b74>]
(start_kernel+0x2a0/0x364)
[<c0008b74>] (start_kernel+0x2a0/0x364) from [<70008034>] (0x70008034)
Code: e1a07001 e10f4000 e3843080 e121f003 (e590c000)
---[ end trace 1b75b31a2719ed1c ]---
Kernel panic - not syncing: Attempted to kill the idle task!
[<c002b574>] (unwind_backtrace+0x0/0xdc) from [<c003c93c>] (panic+0x44/0x114)
[<c003c93c>] (panic+0x44/0x114) from [<c003f354>] (do_exit+0x5c/0x598)
[<c003f354>] (do_exit+0x5c/0x598) from [<c0029b24>] (die+0x138/0x158)
[<c0029b24>] (die+0x138/0x158) from [<c002c650>] (__do_kernel_fault+0x68/0x80)
[<c002c650>] (__do_kernel_fault+0x68/0x80) from [<c002c870>]
(do_page_fault+0x208/0x228)
[<c002c870>] (do_page_fault+0x208/0x228) from [<c0025224>]
(do_DataAbort+0x34/0x98)
[<c0025224>] (do_DataAbort+0x34/0x98) from [<c002594c>] (__dabt_svc+0x4c/0x60)
Exception stack(0xc0349ef8 to 0xc0349f40)
9ee0:                                                       00000000 000000d0
9f00: c02e9fe0 a00000d3 a0000053 c78000c0 00000000 000000d0 00000000 00000000
9f20: 00000020 ffffffe0 0000001b c0349f40 c0270288 c007f76c a00000d3 ffffffff
[<c002594c>] (__dabt_svc+0x4c/0x60) from [<c0270288>]
(setup_cpu_cache+0x50/0x110)
[<c0270288>] (setup_cpu_cache+0x50/0x110) from [<c03762d8>] (0xc03762d8


These patches are not working for me.

I want to know how to work with memories that are separate on physical
address space.

-Prasant J
