From: cgagneraud@techworks.ie (Christian Gagneraud)
Date: Sat, 10 Oct 2009 00:16:40 +0100
Subject: 2.6.32-rc3/sparsemem: kernel BUG at mm/bootmem.c:243
Message-ID: <4ACFC458.7080307@techworks.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I've rebased my tree to 2.6.32-rc3, and apply the patch for sparsemem
support (ts72xx) + the fix in mm/Kconfig, and now the kernel refuse to
boot. Any hint is greatly appreciated
Here is the log:

Using base address 0x00218000 and length 0x000b87f8

Uncompressing
Linux...................................................... done,
booting the kernel.
<5>Linux version 2.6.32-rc3 (cgagneraud at archeopterix.techworks.local)
(gcc version 4.3.3 (Sourcery G++ Lite 2009q1-203) ) #1
  Fri Oct 9 23:32:03 IST 2009

CPU: ARM920T [41129200] revision 0 (ARMv4T), cr=00007177

CPU: VIVT data cache, VIVT instruction cache

Machine: Technologic Systems TS-72xx SBC

Memory policy: ECC disabled, Data cache writeback

<7>On node 0 totalpages: 16384

<7>  Normal zone: 8262 pages used for memmap

<7>  Normal zone: 0 pages reserved

<7>  Normal zone: 8122 pages, LIFO batch:0

Built 1 zonelists in Zone order, mobility grouping on.  Total pages:
8122
<5>Kernel command line: console=ttyAM0,115200 bootmem_debug

<6>bootmem::alloc_bootmem_core nid=0 size=200 [1 pages] align=20
goal=0 limit=0
<6>bootmem::__reserve nid=0 start=10b9 end=10b9 flags=1

<6>PID hash table entries: 128 (order: -3, 512 bytes)

<6>bootmem::alloc_bootmem_core nid=0 size=4000 [4 pages] align=20
goal=0 limit=0
<6>bootmem::__reserve nid=0 start=10b9 end=10bd flags=1

<6>Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)

<6>bootmem::alloc_bootmem_core nid=0 size=2000 [2 pages] align=20
goal=0 limit=0
<6>bootmem::__reserve nid=0 start=10bd end=10bf flags=1

<6>Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
<6>bootmem::mark_bootmem_node nid=0 start=776 end=788 reserve=0
flags=0
<6>bootmem::__free nid=0 start=776 end=788

<6>bootmem::mark_bootmem_node nid=0 start=79a end=7ac reserve=0
flags=0
<6>bootmem::__free nid=0 start=79a end=7ac

<6>bootmem::mark_bootmem_node nid=0 start=7be end=7d0 reserve=0
flags=0
<6>bootmem::__free nid=0 start=7be end=7d0

<6>bootmem::mark_bootmem_node nid=0 start=7e2 end=1000 reserve=0
flags=0
<6>bootmem::__free nid=0 start=7e2 end=1000

<2>kernel BUG at mm/bootmem.c:243!

<1>Unable to handle kernel NULL pointer dereference at virtual address
00000000
<1>pgd = c0004000

<1>[00000000] *pgd=00000000

Internal error: Oops: 805 [#1]

CPU: 0    Not tainted  (2.6.32-rc3 #1)

PC is at __bug+0x20/0x2c

LR is at vprintk+0x388/0x3d8

pc : [<c0028e20>]    lr : [<c0040720>]    psr: 600000d3

sp : c0187f18  ip : c0187e78  fp : c0187f24

r10: 00016130  r9 : 41129200  r8 : 00000000

r7 : 00000000  r6 : 00001000  r5 : c0018270  r4 : 000007f4

r3 : 00000000  r2 : 600000d3  r1 : c01896d0  r0 : 00000035

Flags: nZCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel

Control: 0000717f  Table: 00004000  DAC: 00000017

Process swapper (pid: 0, stack limit = 0xc0186270)

Stack: (0xc0187f18 to 0xc0188000)

7f00:                                                       c0187f4c
c0187f28
7f20: c000ea20 c0028e10 00001000 c0187f44 c0187f84 c0018270 00001000
000007e2
7f40: c0187f84 c0187f50 c000ef64 c000e9a8 00001000 00000000 00000000
c0010cfc
7f60: 00000000 007e2000 01000000 c019b674 c018b1c8 00016164 c0187fac
c0187f88
7f80: c000f564 c000eec4 00000000 00016164 41129200 c019c998 00000004
c0017c9c
7fa0: c0187fcc c0187fb0 c000a784 c000f514 c0187fcc c0187fc0 c019c620
c0017ca0
7fc0: c0187ff4 c0187fd0 c00089ec c000a654 c000866c 00000000 00000000
c0017ca0
7fe0: 00007175 c019c930 00000000 c0187ff8 00008038 c00088e0 00000000
00000000
[<c0028e20>] (__bug+0x20/0x2c) from [<c000ea20>] (__free+0x88/0xb4)

[<c000ea20>] (__free+0x88/0xb4) from [<c000ef64>]
(mark_bootmem_node+0xb0/0xd8)
[<c000ef64>] (mark_bootmem_node+0xb0/0xd8) from [<c000f564>]
(free_bootmem_node+0x60/0x68)
[<c000f564>] (free_bootmem_node+0x60/0x68) from [<c000a784>]
(mem_init+0x140/0x2a4)
[<c000a784>] (mem_init+0x140/0x2a4) from [<c00089ec>]
(start_kernel+0x11c/0x27c)
[<c00089ec>] (start_kernel+0x11c/0x27c) from [<00008038>] (0x8038)

Code: e1a01000 e59f000c eb0400be e3a03000 (e5833000)

<4>---[ end trace 1b75b31a2719ed1c ]---

<0>Kernel panic - not syncing: Attempted to kill the idle task!

[<c002afd8>] (unwind_backtrace+0x0/0x154) from [<c0128ff0>]
(dump_stack+0x18/0x1c)
[<c0128ff0>] (dump_stack+0x18/0x1c) from [<c0129040>]
(panic+0x4c/0x124)
[<c0129040>] (panic+0x4c/0x124) from [<c0042bdc>] (do_exit+0x70/0x598)

[<c0042bdc>] (do_exit+0x70/0x598) from [<c0029288>] (die+0x144/0x168)

[<c0029288>] (die+0x144/0x168) from [<c002c1f0>]
(__do_kernel_fault+0x6c/0x7c)

[<c002c1f0>] (__do_kernel_fault+0x6c/0x7c) from [<c002c3dc>]
(do_page_fault+0x1dc/0x1fc)
[<c002c3dc>] (do_page_fault+0x1dc/0x1fc) from [<c002c49c>]
(do_translation_fault+0x18/0x94)
[<c002c49c>] (do_translation_fault+0x18/0x94) from [<c00242b8>]
(do_DataAbort+0x3c/0x9c)
[<c00242b8>] (do_DataAbort+0x3c/0x9c) from [<c0024a6c>]
(__dabt_svc+0x4c/0x80)
Exception stack(0xc0187ed0 to 0xc0187f18)

7ec0:                                     00000035 c01896d0 600000d3
00000000
7ee0: 000007f4 c0018270 00001000 00000000 00000000 41129200 00016130
c0187f24
7f00: c0187e78 c0187f18 c0040720 c0028e20 600000d3 ffffffff

[<c0024a6c>] (__dabt_svc+0x4c/0x80) from [<c0028e20>]
(__bug+0x20/0x2c)
[<c0028e20>] (__bug+0x20/0x2c) from [<c000ea20>] (__free+0x88/0xb4)

[<c000ea20>] (__free+0x88/0xb4) from [<c000ef64>]
(mark_bootmem_node+0xb0/0xd8)
[<c000ef64>] (mark_bootmem_node+0xb0/0xd8) from [<c000f564>]
(free_bootmem_node+0x60/0x68)
[<c000f564>] (free_bootmem_node+0x60/0x68) from [<c000a784>]
(mem_init+0x140/0x2a4)
[<c000a784>] (mem_init+0x140/0x2a4) from [<c00089ec>]
(start_kernel+0x11c/0x27c)
[<c00089ec>] (start_kernel+0x11c/0x27c) from [<00008038>] (0x8038)

Regards,
Chris
