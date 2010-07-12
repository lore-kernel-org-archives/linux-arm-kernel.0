From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 12 Jul 2010 17:32:31 +0900
Subject: About SECTION_SIZE_BITS for Sparsemem
Message-ID: <000601cb219c$c7830b60$56892220$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

Hi,

Kukjin Kim wrote:
> Russell wrote:
> > So, memory starts at 0x20000000 and finishes at 0x25000000.  That's
fine.
> > That doesn't mean the section size is 16MB.
> > 
> > As I've already said, the section size has _nothing_ what so ever to do
> > with the size of memory, or the granularity of the size of memory.  By
> > way of illustration, it is perfectly legal to have a section size of
> > 256MB but only have 1MB in a section and this is perfectly legal.  So
> > sections do not have to be completely filled.
> > 
> Actually, as you know, the hole's area of mem_map is freed from bootmem if
a
> section has a hole when initializing sparse memory.
> 
> I identified that a section doesn't need to be a contiguous area of
physical
> memory when reading your comment with the fact that the mem_map of a
section
> can be smaller than the size of a section.
> 
> I found, however, the kernel panics when modifying min_free_kbytes file in
> the proc filesystem if a section has a hole.
> 
> While processing the change of min_free_kbytes in the kernel, page
> descriptors in a hole of an online section is accessed.

As I said, following error happens.
It would be helpful to me if any opinions or comments.

---
When SECTION_SIZE_BITS is 24 (16MiB),

[root at Samsung ~]# cat /proc/sys/vm/min_free_kbytes
2736
[root at Samsung ~]# echo "2730" > /proc/sys/vm/min_free_kbytes

[root at Samsung ~]# cat /proc/sys/vm/min_free_kbytes
2730
[root at Samsung ~]#


When SECTION_SIZE_BITS is 28 (256MiB),

[root at Samsung ~]# cat /proc/sys/vm/min_free_kbytes
2736
[root at Samsung ~]# echo "2730" > /proc/sys/vm/min_free_kbytes
Unable to handle kernel NULL pointer dereference at virtual address 00000004
pgd = 80a14000
[00000004] *pgd=20a0b031, *pte=00000000, *ppte=00000000
Internal error: Oops: 17 [#1] PREEMPT
last sysfs file:
Modules linked in:
CPU: 0    Not tainted  (2.6.35-rc4-00007-g9a59bf7-dirty #3)
PC is at get_pageblock_flags_group+0x54/0xa8
LR is at setup_per_zone_wmarks+0xfc/0x1d4
pc : [<800686cc>]    lr : [<800691a0>]    psr: 60000093
sp : 80a03ed0  ip : 00000001  fp : 00058000
r10: 004a0000  r9 : 801e5fbc  r8 : 802c0000
r7 : 0001c900  r6 : 00025000  r5 : 801e5fa4  r4 : 0000007e
r3 : 00000018  r2 : 00000002  r1 : 00000000  r0 : 00000000
Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c5387d  Table: 20a14019  DAC: 00000015
Process bash (pid: 888, stack limit = 0x80a022e8)
Stack: (0x80a03ed0 to 0x80a04000)
3ec0:                                     00000000 801e5fa4 00025000
800691a0
3ee0: a0000013 000002aa 00000005 00000001 801d8254 2aacb000 00000005
00000001
3f00: 80a02000 80a03f80 00000001 80069354 80a03f80 00000001 801d7900
800d2734
3f20: 80a03f80 00000000 00000000 00000005 80a0903c 00000005 b7c81c00
2aacb000
3f40: 80a03f80 00000005 00000000 800d2760 00000001 2aacb000 00000005
8008ff74
3f60: b7c81c00 2aacb000 b7c81c00 2aacb000 00000000 00000000 00000005
800900c8
3f80: 00000005 00000000 00000005 00000000 00000005 2aacb000 2ac525f8
00000004
3fa0: 8001f0e8 8001ef40 00000005 2aacb000 00000001 2aacb000 00000005
00000000
3fc0: 00000005 2aacb000 2ac525f8 00000004 00000005 000babe0 00000000
00000001
3fe0: 2aacb000 7e88ca58 2ab99124 2abe643c 60000010 00000001 00000000
00000000
[<800686cc>] (get_pageblock_flags_group+0x54/0xa8) from [<800691a0>]
(setup_per_zone_wmarks+0xfc/0x1d4)
[<800691a0>] (setup_per_zone_wmarks+0xfc/0x1d4) from [<80069354>]
(min_free_kbytes_sysctl_handler+0x20/0x28)
[<80069354>] (min_free_kbytes_sysctl_handler+0x20/0x28) from [<800d2734>]
(proc_sys_call_handler+0x90/0xac)
[<800d2734>] (proc_sys_call_handler+0x90/0xac) from [<800d2760>]
(proc_sys_write+0x10/0x14)
[<800d2760>] (proc_sys_write+0x10/0x14) from [<8008ff74>]
(vfs_write+0xac/0x154)
[<8008ff74>] (vfs_write+0xac/0x154) from [<800900c8>] (sys_write+0x3c/0x68)
[<800900c8>] (sys_write+0x3c/0x68) from [<8001ef40>]
(ret_fast_syscall+0x0/0x30)
Code: 11a0cb8c 11a0cbac 1080018c e3a0c001 (e5904004)
---[ end trace 8b96cc6afed783d1 ]---
note: bash[888] exited with preempt_count 1
BUG: scheduling while atomic: bash/888/0x40000002
Modules linked in:
[<80024558>] (unwind_backtrace+0x0/0xec) from [<8014f110>]
(schedule+0x6c/0x2e4)
[<8014f110>] (schedule+0x6c/0x2e4) from [<80035f74>]
(__cond_resched+0x24/0x34)
[<80035f74>] (__cond_resched+0x24/0x34) from [<8014f484>]
(_cond_resched+0x30/0x40)
[<8014f484>] (_cond_resched+0x30/0x40) from [<8007ac1c>]
(unmap_vmas+0x550/0x604)
[<8007ac1c>] (unmap_vmas+0x550/0x604) from [<8007d6b8>]
(exit_mmap+0xb0/0x1d8)
[<8007d6b8>] (exit_mmap+0xb0/0x1d8) from [<80037de8>] (mmput+0x4c/0x104)
[<80037de8>] (mmput+0x4c/0x104) from [<8003b7f4>] (exit_mm+0x104/0x10c)
[<8003b7f4>] (exit_mm+0x104/0x10c) from [<8003cdc4>] (do_exit+0x194/0x5bc)
[<8003cdc4>] (do_exit+0x194/0x5bc) from [<80022950>] (die+0x190/0x1bc)
[<80022950>] (die+0x190/0x1bc) from [<80025488>]
(__do_kernel_fault+0x64/0x84)
[<80025488>] (__do_kernel_fault+0x64/0x84) from [<8002567c>]
(do_page_fault+0x1d4/0x1ec)
[<8002567c>] (do_page_fault+0x1d4/0x1ec) from [<8001e2d0>]
(do_DataAbort+0x34/0x94)
[<8001e2d0>] (do_DataAbort+0x34/0x94) from [<8001ea2c>]
(__dabt_svc+0x4c/0x60)
Exception stack(0x80a03e88 to 0x80a03ed0)
3e80:                   00000000 00000000 00000002 00000018 0000007e
801e5fa4
3ea0: 00025000 0001c900 802c0000 801e5fbc 004a0000 00058000 00000001
80a03ed0
3ec0: 800691a0 800686cc 60000093 ffffffff
[<8001ea2c>] (__dabt_svc+0x4c/0x60) from [<800686cc>]
(get_pageblock_flags_group+0x54/0xa8)
[<800686cc>] (get_pageblock_flags_group+0x54/0xa8) from [<800691a0>]
(setup_per_zone_wmarks+0xfc/0x1d4)
[<800691a0>] (setup_per_zone_wmarks+0xfc/0x1d4) from [<80069354>]
(min_free_kbytes_sysctl_handler+0x20/0x28)
[<80069354>] (min_free_kbytes_sysctl_handler+0x20/0x28) from [<800d2734>]
(proc_sys_call_handler+0x90/0xac)
[<800d2734>] (proc_sys_call_handler+0x90/0xac) from [<800d2760>]
(proc_sys_write+0x10/0x14)
[<800d2760>] (proc_sys_write+0x10/0x14) from [<8008ff74>]
(vfs_write+0xac/0x154)
[<8008ff74>] (vfs_write+0xac/0x154) from [<800900c8>] (sys_write+0x3c/0x68)
[<800900c8>] (sys_write+0x3c/0x68) from [<8001ef40>]
(ret_fast_syscall+0x0/0x30)
BUG: spinlock lockup on CPU#0, bash/888, 801e5fbc
[<80024558>] (unwind_backtrace+0x0/0xec) from [<801098a8>]
(do_raw_spin_lock+0x110/0x14c)
[<801098a8>] (do_raw_spin_lock+0x110/0x14c) from [<8006963c>]
(free_pcppages_bulk+0x24/0x2f4)
[<8006963c>] (free_pcppages_bulk+0x24/0x2f4) from [<80069f28>]
(free_hot_cold_page+0x15c/0x180)
[<80069f28>] (free_hot_cold_page+0x15c/0x180) from [<8007b834>]
(free_pgd_range+0x15c/0x17c)
[<8007b834>] (free_pgd_range+0x15c/0x17c) from [<8007b8e4>]
(free_pgtables+0x90/0x9c)
[<8007b8e4>] (free_pgtables+0x90/0x9c) from [<8007d714>]
(exit_mmap+0x10c/0x1d8)
[<8007d714>] (exit_mmap+0x10c/0x1d8) from [<80037de8>] (mmput+0x4c/0x104)
[<80037de8>] (mmput+0x4c/0x104) from [<8003b7f4>] (exit_mm+0x104/0x10c)
[<8003b7f4>] (exit_mm+0x104/0x10c) from [<8003cdc4>] (do_exit+0x194/0x5bc)
[<8003cdc4>] (do_exit+0x194/0x5bc) from [<80022950>] (die+0x190/0x1bc)
[<80022950>] (die+0x190/0x1bc) from [<80025488>]
(__do_kernel_fault+0x64/0x84)
[<80025488>] (__do_kernel_fault+0x64/0x84) from [<8002567c>]
(do_page_fault+0x1d4/0x1ec)
[<8002567c>] (do_page_fault+0x1d4/0x1ec) from [<8001e2d0>]
(do_DataAbort+0x34/0x94)
[<8001e2d0>] (do_DataAbort+0x34/0x94) from [<8001ea2c>]
(__dabt_svc+0x4c/0x60)
Exception stack(0x80a03e88 to 0x80a03ed0)
3e80:                   00000000 00000000 00000002 00000018 0000007e
801e5fa4
3ea0: 00025000 0001c900 802c0000 801e5fbc 004a0000 00058000 00000001
80a03ed0
3ec0: 800691a0 800686cc 60000093 ffffffff
[<8001ea2c>] (__dabt_svc+0x4c/0x60) from [<800686cc>]
(get_pageblock_flags_group+0x54/0xa8)
[<800686cc>] (get_pageblock_flags_group+0x54/0xa8) from [<800691a0>]
(setup_per_zone_wmarks+0xfc/0x1d4)
[<800691a0>] (setup_per_zone_wmarks+0xfc/0x1d4) from [<80069354>]
(min_free_kbytes_sysctl_handler+0x20/0x28)
[<80069354>] (min_free_kbytes_sysctl_handler+0x20/0x28) from [<800d2734>]
(proc_sys_call_handler+0x90/0xac)
[<800d2734>] (proc_sys_call_handler+0x90/0xac) from [<800d2760>]
(proc_sys_write+0x10/0x14)
[<800d2760>] (proc_sys_write+0x10/0x14) from [<8008ff74>]
(vfs_write+0xac/0x154)
[<8008ff74>] (vfs_write+0xac/0x154) from [<800900c8>] (sys_write+0x3c/0x68)
[<800900c8>] (sys_write+0x3c/0x68) from [<8001ef40>]
(ret_fast_syscall+0x0/0x30)


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
