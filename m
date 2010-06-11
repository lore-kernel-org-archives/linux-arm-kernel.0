From: gores@marvell.com (Siddarth Gore)
Date: Fri, 11 Jun 2010 15:50:01 +0530
Subject: L2 cache support for pxa16x
In-Reply-To: <AANLkTilYrgroqxaL0uGnpmTXmUznkijtFmNmkSuFL89V@mail.gmail.com>
References: <1273658181.6926.27.camel@pe-dt434>
	<AANLkTiky2tG7-n5bmMBqhKBIn7tq1tIT0KeWpkUee5YK@mail.gmail.com>
	<1274350676.6926.58.camel@pe-dt434>
	<AANLkTilYrgroqxaL0uGnpmTXmUznkijtFmNmkSuFL89V@mail.gmail.com>
Message-ID: <1276251601.29294.60.camel@pe-dt434>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-05-21 at 04:05 -0700, Haojian Zhuang wrote:
> >
> 
> I didn't meet any failure on enabling L2. What I do is in below. Which
> kernel version are you using?
> 
extremely sorry for replying _so_ late. I was using 2.6.34 vanilla
kernel. I tried your patch on latest 2.6.35-rc2 today, and it is
crashing as well (log pasted below).

<...snip...>
Uncompressing Linux... done, booting the kernel.
[    0.000000] Linux version 2.6.35-rc2-00131-g7908a9e-dirty
(gores at linux-dev.marvell.com) (gcc version 4.1.2 20070925 (Red Hat
4.1.2-33.fa1)) #40 PREEMPT Fr
i Jun 11 15:29:40 IST 2010
[    0.000000] CPU: Marvell 88SV331x [56158400] revision 0 (ARMv5TE),
cr=00053947
[    0.000000] CPU: VIVT data cache, VIVT instruction cache
[    0.000000] Machine: PXA168-based Aspenite Development Platform
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 65024
[    0.000000] Kernel command line: root=mtd4 rw rootfstype=jffs2
console=ttyS0,115200
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072
bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536
bytes)
[    0.000000] Memory: 256MB = 256MB total
[    0.000000] Memory: 256664k/256664k available, 5480k reserved, 0K
highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
[    0.000000]     vmalloc : 0xd0800000 - 0xfe000000   ( 728 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .init : 0xc0008000 - 0xc001d000   (  84 kB)
[    0.000000]       .text : 0xc001d000 - 0xc02d0000   (2764 kB)
[    0.000000]       .data : 0xc02e6000 - 0xc030a460   ( 146 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU-based detection of stalled CPUs is disabled.
[    0.000000]  Verbose stalled-CPUs detection is disabled.
[    0.000000] NR_IRQS:384
[    0.000000] Console: colour dummy device 80x30
[    0.000015] Calibrating delay loop... 796.26 BogoMIPS (lpj=3981312)
[    0.220115] pid_max: default: 32768 minimum: 301
[    0.220147] Mount-cache hash table entries: 512
[    0.220321] CPU: Testing write buffer coherency: ok
[    0.224377] NET: Registered protocol family 16
[    0.224505] Tauros2: Disabling L2 prefetch.
[    0.224554] Tauros2: Enabling L2 cache.
[    0.224567] Tauros2: L2 cache support initialised in ARMv5 mode.
[    0.231784] bio: create slab <bio-0> at 0

<...snip...>
[    4.243206] VFS: Mounted root (jffs2 filesystem) on device 31:4.
[    4.243249] Freeing init memory: 84K
[    4.370645] BUG: Bad page state in process init  pfn:00563
[    4.376669] page:c0334c60 count:0 mapcount:0 mapping:cf80aab8
index:0x4f
[    4.383411] page flags: 0x8(uptodate)
[    4.383420] [<c00235e8>] (unwind_backtrace+0x0/0xe0) from
[<c006c0d0>] (bad_page+0xc8/0xfc)
[    4.395478] [<c006c0d0>] (bad_page+0xc8/0xfc) from [<c006c16c>]
(free_pages_prepare+0x68/0xbc)
[    4.404141] [<c006c16c>] (free_pages_prepare+0x68/0xbc) from
[<c006c9c4>] (free_hot_cold_page+0x20/0x1a0)
[    4.413758] [<c006c9c4>] (free_hot_cold_page+0x20/0x1a0) from
[<c006cc10>] (__pagevec_free+0x20/0x34)
[    4.423019] [<c006cc10>] (__pagevec_free+0x20/0x34) from [<c0070798>]
(release_pages+0x274/0x28c)
[    4.423048] [<c0070798>] (release_pages+0x274/0x28c) from
[<c0070984>] (____pagevec_lru_add+0x1d4/0x1ec)
[    4.441441] [<c0070984>] (____pagevec_lru_add+0x1d4/0x1ec) from
[<c0070c28>] (lru_add_drain+0x40/0xac)
[    4.450798] [<c0070c28>] (lru_add_drain+0x40/0xac) from [<c00813c8>]
(exit_mmap+0x5c/0x1cc)
[    4.459201] [<c00813c8>] (exit_mmap+0x5c/0x1cc) from [<c0033d08>]
(mmput+0x3c/0x11c)
[    4.466988] [<c0033d08>] (mmput+0x3c/0x11c) from [<c0037f40>]
(exit_mm+0x124/0x130)
[    4.474686] [<c0037f40>] (exit_mm+0x124/0x130) from [<c00394f8>]
(do_exit+0x16c/0x654)
[    4.474712] [<c00394f8>] (do_exit+0x16c/0x654) from [<c0039a98>]
(do_group_exit+0xb8/0xec)
[    4.490928] [<c0039a98>] (do_group_exit+0xb8/0xec) from [<c0045528>]
(get_signal_to_deliver+0x3cc/0x42c)
[    4.500459] [<c0045528>] (get_signal_to_deliver+0x3cc/0x42c) from
[<c00206c4>] (do_notify_resume+0x58/0x5d8)
[    4.510337] [<c00206c4>] (do_notify_resume+0x58/0x5d8) from
[<c001df2c>] (work_pending+0x1c/0x20)
[    4.519263] Disabling lock debugging due to kernel taint
[    4.524634] kernel BUG at lib/prio_tree.c:149!
[    4.524679] Unable to handle kernel NULL pointer dereference at
virtual address 00000000
[    4.529129] pgd = c0004000
[    4.537220] [00000000] *pgd=00000000
[    4.539919] Internal error: Oops: 817 [#1] PREEMPT
[    4.543490] last sysfs file: 
[    4.548277] Modules linked in:
[    4.551238] CPU: 0    Tainted: G    B
(2.6.35-rc2-00131-g7908a9e-dirty #40)
[    4.554290] PC is at __bug+0x1c/0x28
[    4.561862] LR is at __bug+0x18/0x28
[    4.565434] pc : [<c002140c>]    lr : [<c0021408>]    psr: 60000093
[    4.569016] sp : cfc19db0  ip : c0183b34  fp : cfc19fb0
[    4.569025] r10: 00001000  r9 : c02ea1d0  r8 : 00000000
[    4.580503] r7 : cfc725c4  r6 : cfc725a0  r5 : cf80aacc  r4 :
cfc7256c
[    4.585730] r3 : 00000000  r2 : 00000003  r1 : 00002370  r0 :
00000038
[    4.592257] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM
Segment user
[    4.598785] Control: 0005397f  Table: 0fd00018  DAC: 00000015
[    4.606008] Process init (pid: 1, stack limit = 0xcfc18278)
[    4.611752] Stack: (0xcfc19db0 to 0xcfc1a000)
[    4.617326] 9da0:                                     cfdc2ce0
c01571cc 00000000 c01572fc
[    4.621688] 9dc0: 00006fab 00000000 00000001 be9ba000 cfd02fa0
cf80aab8 cfc72548 cfc725a0
[    4.629879] 9de0: 00008000 c00817f0 cfc18000 c0081850 cfc18000
c007f298 cfc19e1c cfc18000
[    4.638065] 9e00: cfc18000 00000000 cfc725a0 cfd5bde0 cfc19ee8
00000001 cfc19f68 c0081480
[    4.646250] 9e20: cfc19e28 00000000 00000025 c02ea1d0 cfc15bc0
00000000 cfd5bde0 cfd5be18
[    4.654435] 9e40: cfc15bc0 c0033d08 cfd5bde0 cfc18000 cfd5bde0
c0037f40 00000000 c0044074
[    4.662623] 9e60: cfc18000 cfc18000 cfc15bc0 0000000b 000000dc
c00394f8 00000000 cfc7880c
[    4.670807] 9e80: 0000000b 0000000b cfdc3590 000000dc cfc19ee8
cfc1bd60 cfc19f68 c0039a98
[    4.678993] 9ea0: cfc18000 c0045528 00008000 cfdc35a0 00000000
cfc18000 00000000 cfc19fb0
[    4.687179] 9ec0: 00000000 00000000 cfc18000 4000cfac be9b9d64
c00206c4 cfc15bc0 00000190
[    4.695365] 9ee0: 00020001 c0024978 0000000b 00000000 00030001
00000190 00000000 00000003
[    4.703549] 9f00: 40003000 c032a1e0 4000cfac c001d30c c02f5760
cfd69ba0 cfc18000 00000000
[    4.711736] 9f20: c00cdb3c c0096b44 cfc18000 cfc19f88 cfd69ba0
00000000 cfd69ba0 c02927e8
[    4.719922] 9f40: cfc18000 00000000 00000000 cfd69ba0 c02927e8
c0097fd4 cfdc2d10 00000000
[    4.728107] 9f60: 00000000 c02927e8 c02e98e4 00000000 00001fb0
cfc19f88 00000000 cfc19fb0
[    4.736293] 9f80: cfc18000 c002124c 00000000 ffffffff be9b9f8f
40000000 00000000 00000000
[    4.744479] 9fa0: cfc18000 4000cfac be9b9d64 c001df2c ea00004b
00000190 be9b9f8f 00040000
[    4.752665] 9fc0: 00000000 be9b9f8f 40000000 00000000 00000000
00000000 4000cfac be9b9d64
[    4.760850] 9fe0: be9b9f8f be9b9d58 40003c70 40000a7c a0000010
ffffffff 76f7fd97 fdc53774
[    4.769037] [<c002140c>] (__bug+0x1c/0x28) from [<c01571cc>]
(prio_tree_replace+0x3c/0x90)
[    4.777233] [<c01571cc>] (prio_tree_replace+0x3c/0x90) from
[<c01572fc>] (prio_tree_remove+0xdc/0xf8)
[    4.785517] [<c01572fc>] (prio_tree_remove+0xdc/0xf8) from
[<c00817f0>] (__remove_shared_vm_struct+0xa4/0xd8)
[    4.794758] [<c00817f0>] (__remove_shared_vm_struct+0xa4/0xd8) from
[<c0081850>] (unlink_file_vma+0x2c/0x4c)
[    4.804694] [<c0081850>] (unlink_file_vma+0x2c/0x4c) from
[<c007f298>] (free_pgtables+0x34/0x98)
[    4.814534] [<c007f298>] (free_pgtables+0x34/0x98) from [<c0081480>]
(exit_mmap+0x114/0x1cc)
[    4.823337] [<c0081480>] (exit_mmap+0x114/0x1cc) from [<c0033d08>]
(mmput+0x3c/0x11c)
[    4.831791] [<c0033d08>] (mmput+0x3c/0x11c) from [<c0037f40>]
(exit_mm+0x124/0x130)
[    4.839639] [<c0037f40>] (exit_mm+0x124/0x130) from [<c00394f8>]
(do_exit+0x16c/0x654)
[    4.847311] [<c00394f8>] (do_exit+0x16c/0x654) from [<c0039a98>]
(do_group_exit+0xb8/0xec)
[    4.855245] [<c0039a98>] (do_group_exit+0xb8/0xec) from [<c0045528>]
(get_signal_to_deliver+0x3cc/0x42c)
[    4.863531] [<c0045528>] (get_signal_to_deliver+0x3cc/0x42c) from
[<c00206c4>] (do_notify_resume+0x58/0x5d8)
[    4.873025] [<c00206c4>] (do_notify_resume+0x58/0x5d8) from
[<c001df2c>] (work_pending+0x1c/0x20)
[    4.882874] Code: e1a01000 e59f000c eb0056ac e3a03000 (e5833000) 
[    4.897903] ---[ end trace 053bf21ade3656af ]---
[    4.897921] Fixing recursive fault but reboot is needed!
[    4.907883] BUG: scheduling while atomic: init/1/0x00000004
[    4.913488] Modules linked in:
[    4.913495] [<c00235e8>] (unwind_backtrace+0x0/0xe0) from
[<c0233970>] (schedule+0x6c/0x320)
[    4.929710] kernel BUG at fs/jffs2/readinode.c:154!
[    4.934682] Unable to handle kernel NULL pointer dereference at
virtual address 00000000
[    4.934695] pgd = c0004000
[    4.945504] [00000000] *pgd=00000000
[    4.945513] Internal error: Oops: 817 [#2] PREEMPT
[    4.949086] last sysfs file: 
[    4.953875] Modules linked in:
[    4.956836] CPU: 0    Tainted: G    B D
(2.6.35-rc2-00131-g7908a9e-dirty #40)
[    4.959887] PC is at __bug+0x1c/0x28
[    4.967458] LR is at __bug+0x18/0x28
[    4.971031] pc : [<c002140c>]    lr : [<c0021408>]    psr: 60000013
[    4.974613] sp : cfc71db0  ip : cfc71ca0  fp : cfcae600
[    4.974622] r10: cfc4df80  r9 : cfc4aef0  r8 : cfcaea00
[    4.986101] r7 : 00000000  r6 : cfc4df80  r5 : cfc71e4c  r4 :
cfc4df80
[    4.991327] r3 : 00000000  r2 : 00000000  r1 : 00000001  r0 :
0000003d
[    4.997855] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM
Segment kernel
[    5.004383] Control: 0005397f  Table: 0fd00018  DAC: 00000017
[    5.011693] Process jffs2_gcd_mtd4 (pid: 194, stack limit =
0xcfc70278)
[    5.017437] Stack: (0xcfc71db0 to 0xcfc72000)
[    5.024051] 1da0:                                     00000002
c0122fb4 00000000 cfc71e70
[    5.028414] 1dc0: cfc68000 cfcaea00 00000110 cfc4df20 cfc4df80
cfc71e4c cfc4df80 00000000
[    5.036605] 1de0: cfcaea00 0000001a cfc4df00 c012341c cfc4df20
00000000 cfc4df80 cfc71e4c
[    5.044791] 1e00: cfc4df80 cfc4df80 000001cb 00000000 cfc71ea4
cfd5a000 00000000 c01246ac
[    5.052976] 1e20: 000007cc cfc71e70 cfd5a000 c02ea8f0 00000085
cfcae600 cfcaea00 00000000
[    5.061163] 1e40: cfc70000 00000000 00008f07 00000000 00000000
cfc4df60 0000001b 00000000
[    5.069347] 1e60: 00000000 00000000 cfd57a98 00000001 000007cc
cfc71e80 c00325ac cfcae600
[    5.077533] 1e80: cfc4b3b0 cfcaea00 00000001 00000000 00000000
00000000 00000000 c0124eb0
[    5.085719] 1ea0: 00000017 c02f4ddc cfc15bc0 c0051664 00000000
c002eb08 c002f388 cfc1801c
[    5.093906] 1ec0: 00000000 cfdc2ce0 cfc71efc cfc71ed8 c0233ba8
c002eff8 cfdc2ce0 ffff8c7e
[    5.102092] 1ee0: c0310a00 00000005 cfc70000 cfc4b3b0 cfcaea00
c012949c ffff8c7e c02343f4
[    5.110278] 1f00: 00000000 00200200 ffff8c7e c0310a00 c00413c8
cfdc2ce0 cfc71fd4 cfc70000
[    5.118462] 1f20: cfcaea00 cfcaea00 00000000 00000000 00000000
c012b070 cfdc2d10 c02ea8f0
[    5.126648] 1f40: cfc71f8c cfc71f50 c00315d0 c002dab0 cfdc2d10
c02ea8f0 cfdc2d10 cfdc2e44
[    5.134836] 1f60: 00000000 00000000 00000000 c002eb1c c02ea8f0
cfdc2d10 cfc71fa4 cfc71f88
[    5.143028] 1f80: c002ebe8 c002eb08 00000000 c02ea8b0 cfdc2ce0
cfc70000 cfc71fcc cfc71fa8
[    5.151214] 1fa0: c0233a70 c002eb70 cfc71fcc cfc71fd4 cfc19e08
cfcaea00 c012af10 cfc71fd4
[    5.159400] 1fc0: cfc19e08 cfcaea00 c012af10 c004bfa8 00000000
00000000 cfc71fd8 cfc71fd8
[    5.167586] 1fe0: 00000000 00000000 00000000 00000000 00000000
c001ef1c 76f7fd97 fdcd3774
[    5.175770] [<c002140c>] (__bug+0x1c/0x28) from [<c0122fb4>]
(check_tn_node+0x54/0x3c4)
[    5.183967] [<c0122fb4>] (check_tn_node+0x54/0x3c4) from [<c012341c>]
(jffs2_build_inode_fragtree+0xf8/0x1ec)
[    5.191993] [<c012341c>] (jffs2_build_inode_fragtree+0xf8/0x1ec) from
[<c01246ac>] (jffs2_do_read_inode_internal+0x119c/0x194c)
[    5.201921] [<c01246ac>] (jffs2_do_read_inode_internal+0x119c/0x194c)
from [<c0124eb0>] (jffs2_do_crccheck_inode+0x54/0x94)
[    5.213414] [<c0124eb0>] (jffs2_do_crccheck_inode+0x54/0x94) from
[<c012949c>] (jffs2_garbage_collect_pass+0x21c/0x974)
[    5.224561] [<c012949c>] (jffs2_garbage_collect_pass+0x21c/0x974)
from [<c012b070>] (jffs2_garbage_collect_thread+0x160/0x1b8)
[    5.235360] [<c012b070>] (jffs2_garbage_collect_thread+0x160/0x1b8)
from [<c004bfa8>] (kthread+0x78/0x80)
[    5.246766] [<c004bfa8>] (kthread+0x78/0x80) from [<c001ef1c>]
(kernel_thread_exit+0x0/0x8)
[    5.256347] Code: e1a01000 e59f000c eb0056ac e3a03000 (e5833000) 
[    5.270951] ---[ end trace 053bf21ade3656b0 ]---
[    7.022826] kernel BUG at mm/slab.c:509!
[    7.022938] Unable to handle kernel NULL pointer dereference at
virtual address 00000000
[    7.026862] pgd = c0004000
[    7.034956] [00000000] *pgd=00000000
[    7.037655] Internal error: Oops: 817 [#3] PREEMPT
[    7.041224] last sysfs file: 
[    7.046014] Modules linked in:
[    7.048973] CPU: 0    Tainted: G    B D
(2.6.35-rc2-00131-g7908a9e-dirty #40)
[    7.052024] PC is at __bug+0x1c/0x28
[    7.059598] LR is at __bug+0x18/0x28
[    7.063170] pc : [<c002140c>]    lr : [<c0021408>]    psr: 60000093
[    7.066751] sp : cfc31f40  ip : c0183b34  fp : 00000000
[    7.066761] r10: 00000001  r9 : 00000000  r8 : 00000000
[    7.078238] r7 : 00000000  r6 : cfc05130  r5 : cfc003c0  r4 :
cfc05130
[    7.083465] r3 : 00000000  r2 : 00000001  r1 : 000045ae  r0 :
00000032
[    7.089993] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM
Segment kernel
[    7.096521] Control: 0005397f  Table: 0fd00018  DAC: 00000017
[    7.103917] Process events/0 (pid: 5, stack limit = 0xcfc30278)
[    7.109661] Stack: (0xcfc31f40 to 0xcfc32000)
[    7.115582] 1f40: 00000017 c008ea44 cfcab660 cfc05130 00000001
cfc05120 00000000 cfc003c0
[    7.119951] 1f60: 00000000 c008ebf8 cfc022a0 cfc003c0 00000000
c02f51c8 c008fc90 c008fccc
[    7.128135] 1f80: 00000000 cfc018e0 c02f51c8 c02f51cc cfc30000
cfc018e0 c02f51c8 c0048eb4
[    7.136322] 1fa0: c0233a70 00000000 cfc15040 c004c268 cfc31fb0
cfc31fb0 cfc31fd4 cfc19f60
[    7.144507] 1fc0: cfc018e0 c0048d84 00000000 c004bfa8 00000000
00000000 cfc31fd8 cfc31fd8
[    7.152692] 1fe0: 00000000 00000000 00000000 00000000 00000000
c001ef1c 76f7fd97 fdcd3774
[    7.160877] [<c002140c>] (__bug+0x1c/0x28) from [<c008ea44>]
(free_block+0x60/0x15c)
[    7.169073] [<c008ea44>] (free_block+0x60/0x15c) from [<c008ebf8>]
(drain_array+0xb8/0x108)
[    7.176829] [<c008ebf8>] (drain_array+0xb8/0x108) from [<c008fccc>]
(cache_reap+0x3c/0x114)
[    7.185196] [<c008fccc>] (cache_reap+0x3c/0x114) from [<c0048eb4>]
(worker_thread+0x130/0x1f8)
[    7.193570] [<c0048eb4>] (worker_thread+0x130/0x1f8) from
[<c004bfa8>] (kthread+0x78/0x80)
[    7.202205] [<c004bfa8>] (kthread+0x78/0x80) from [<c001ef1c>]
(kernel_thread_exit+0x0/0x8)
[    7.210481] Code: e1a01000 e59f000c eb0056ac e3a03000 (e5833000) 
[    7.224964] ---[ end trace 053bf21ade3656b1 ]---
[    7.224979] note: events/0[5] exited with preempt_count 1

-siddarth
> 
> diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
> index 652ae66..689e0d5 100644
> --- a/arch/arm/mach-mmp/pxa168.c
> +++ b/arch/arm/mach-mmp/pxa168.c
> @@ -15,6 +15,7 @@
>  #include <linux/io.h>
>  #include <linux/clk.h>
> 
> +#include <asm/hardware/cache-tauros2.h>
>  #include <asm/mach/time.h>
>  #include <mach/addr-map.h>
>  #include <mach/cputype.h>
> @@ -101,6 +102,7 @@ static struct clk_lookup pxa168_clkregs[] = {
>  static int __init pxa168_init(void)
>  {
>         if (cpu_is_pxa168()) {
> +               tauros2_init();
>                 mfp_init_base(MFPR_VIRT_BASE);
>                 mfp_init_addr(pxa168_mfp_addr_map);
>                 pxa_init_dma(IRQ_PXA168_DMA_INT0, 32);
> diff --git a/arch/arm/mm/cache-tauros2.c b/arch/arm/mm/cache-tauros2.c
> index 5086865..79f49f5 100644
> --- a/arch/arm/mm/cache-tauros2.c
> +++ b/arch/arm/mm/cache-tauros2.c
> @@ -120,7 +120,11 @@ static inline u32 __init read_extra_features(void)
> 
>  static inline void __init write_extra_features(u32 u)
>  {
> +       volatile u32 cp15;
>         __asm__("mcr p15, 1, %0, c15, c1, 0" : : "r" (u));
> +       __asm__("mrc p15, 0, %0, c1, c0, 0" : "=r" (cp15));
> +       cp15 |= (1 << 26);
> +       __asm__("mcr p15, 0, %0, c1, c0, 0" : : "r" (cp15));
>  }
