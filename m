From: abhijit.ray.chaudhury@gmail.com (Abhijit Ray Chaudhury)
Date: Thu, 8 Jan 2015 15:42:29 +0530
Subject: Question regarding Linux Bringup in ARMA9 platform
Message-ID: <CAACKNgW6S4fFvsczgMODb6NdH+r_H62VAHG+-3uWcK7RFHUUdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ,

I am trying to bringup linux in ARMA9 platform. I am getting following crash :


Unhandled fault: alignment exception (0x001) at 0x88042001:

 (link_path_walk+0xa4/0x86c)
(path_lookupat+0x54/0x780)
(do_path_lookup+0x1c/0x58)
(user_path_at_empty+0x54/0x88)
(user_path_at+0x10/0x14)
(sys_chdir+0x18/0x64)
(devtmpfsd+0x60/0x2b4)
(kthread+0x80/0x90)

when kthread tries to mount tempfs and does sys_chdir kernel copies
the path ("/..") at a kernel buffer starting at 0x88042000. It the
skips the "/" character. In "
load_unaligned_zeropad" function it tries to access the content of
0x88042001 using "ldr" or 32bit access instruction. That causes
alignment exception and kernel simply panics.

At this stage is it expected that ARM does not generate alignment
fault ? I can see a fixup code is written inside
load_unaligned_zeropad function, but fixup is not applicable, as this
is not page fault exception.

i am attaching the kernel log. Kindly advice what could be going wrong.

Thanks in advance,
-Abhijit
-------------- next part --------------
Uncompressing Linux... done, booting the kernel.
Booting Linux on physical CPU 0
Linux version 3.6.0-uc0  (gcc version 4.7.1 (crosstool-NG 1.16.0) ) #7 PREEMPT Tue Jan 6 12:29:13 IST 2015
CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=10c53c7f
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
Memory policy: ECC disabled, Data cache writeback
On node 0 totalpages: 65536
free_area_init_node: node 0, pgdat 8029bf98, node_mem_map 805be000
  Normal zone: 512 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 65024 pages, LIFO batch:15
pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
pcpu-alloc: [0] 0
Built 1 zonelists in Zone order, mobility grouping off.  Total pages: 65024
Kernel command line: console=ttyS0 rootfstype=romfs
PID hash table entries: 1024 (order: 0, 4096 bytes)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 256MB = 256MB total
Memory: 253976k/253976k available, 8168k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0x90800000 - 0xff000000   (1768 MB)
    lowmem  : 0x80000000 - 0x90000000   ( 256 MB)
    modules : 0x7f000000 - 0x80000000   (  16 MB)
      .text : 0x80008000 - 0x8026c7fc   (2450 kB)
      .init : 0x8026d000 - 0x80281fe8   (  84 kB)
      .data : 0x80282000 - 0x8029c840   ( 107 kB)
       .bss : 0x8029c880 - 0x802d8000   ( 238 kB)
NR_IRQS:64
sched_clock: 32 bits at 100 Hz, resolution 10000000ns, wraps every 4294967286ms
Console: colour dummy device 80x30
console [ttyS0] enabled
Calibrating delay loop... 1607.27 BogoMIPS (lpj=8036352)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
Setting up static identity map for 0x1d1d40 - 0x1d1dd4
L310 cache controller enabled
l2x0: 8 ways, CACHE_ID 0x410094c8, AUX_CTRL 0x7e460000, Cache size: 524288 B
Unhandled fault: alignment exception (0x001) at 0x88042001
Internal error: : 1 [#1] PREEMPT ARM
Modules linked in:
CPU: 0    Not tainted  (3.6.0-uc0 #7)
PC is at link_path_walk+0xa4/0x86c
LR is at link_path_walk+0x5c/0x86c
pc : [<80087448>]    lr : [<80087400>]    psr: 60000153
sp : 8804de10  ip : 8804ded0  fp : 00000000
r10: 00000000  r9 : 00000000  r8 : 88042000
r7 : 88042001  r6 : 8804c000  r5 : 00000000  r4 : 8804deb8
r3 : 00000000  r2 : 88042001  r1 : 00000000  r0 : 00000000
Flags: nZCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c53c7f  Table: 00004059  DAC: 00000015
Process kdevtmpfs (pid: 9, stack limit = 0x8804c2f0)
Stack: (0x8804de10 to 0x8804e000)
de00:                                     8800ab40 80078934 8803fca0 8803fca0
de20: 00000000 8008f610 00000000 8003b960 0000002f 80087fbc ffffff9c 8804deb8
de40: 00000000 00000043 ffffff9c 88042000 00000000 80088280 8804de60 8003c374
de60: 00000000 8009e7ec 8804de68 8800d780 600001d3 8802bfa4 8800abc0 00000003
de80: 8804deb8 88042000 ffffff9c ffffff9c 00000000 00000000 00000000 800889c8
dea0: 88042000 8804df66 00000003 8804df38 ffffff9c 8008a838 8800d810 88012800
dec0: 8800d810 00000000 00000020 8800d750 8800d810 88012800 88011d78 00001053
dee0: 00000002 00000001 00000000 806be860 806be020 00000000 88001bc0 800795a0
df00: 8028a2e4 00000000 88042000 00008000 8802bfa4 8804df66 801389e8 00000013
df20: 00000000 8008a87c 00000000 8023b739 00000003 8007bea0 8023b739 00008001
df40: 8802bfa4 80138a48 8804df66 00000003 8028f200 88028630 ffffffff 8802a000
df60: 00000002 6f6dca2c 303d6564 00353537 00000000 00000002 8804df9c 8003c724
df80: 8804c000 88028600 8028f200 8804c000 8804c000 88028600 8804dfcc 801d0ed0
dfa0: 00000013 00000000 00000000 8802bf74 8802bfa4 801389e8 00000013 00000000
dfc0: 00000000 00000000 00000000 80034798 00000000 00000000 8802bfa4 00000000
dfe0: 8804dfe0 8804dfe0 8802bf74 80034718 8000ebc8 8000ebc8 00000000 00000000
[<80087448>] (link_path_walk+0xa4/0x86c) from [<80088280>] (path_lookupat+0x54/0x780)
[<80088280>] (path_lookupat+0x54/0x780) from [<800889c8>] (do_path_lookup+0x1c/0x58)
[<800889c8>] (do_path_lookup+0x1c/0x58) from [<8008a838>] (user_path_at_empty+0x54/0x88)
[<8008a838>] (user_path_at_empty+0x54/0x88) from [<8008a87c>] (user_path_at+0x10/0x14)
[<8008a87c>] (user_path_at+0x10/0x14) from [<8007bea0>] (sys_chdir+0x18/0x64)
[<8007bea0>] (sys_chdir+0x18/0x64) from [<80138a48>] (devtmpfsd+0x60/0x2b4)
[<80138a48>] (devtmpfsd+0x60/0x2b4) from [<80034798>] (kthread+0x80/0x90)
[<80034798>] (kthread+0x80/0x90) from [<8000ebc8>] (kernel_thread_exit+0x0/0x8)
Code: e1a03000 e2811004 e0835005 e0872001 (e5923000)
---[ end trace 1b75b31a2719ed1c ]---
Kernel panic - not syncing: Fatal exception
