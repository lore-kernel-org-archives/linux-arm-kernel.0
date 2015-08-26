From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 26 Aug 2015 10:09:21 +0300
Subject: ARM: davinci: linux-next: Boot failure on OMAP-L138 with commit
 0db805aa8c96
Message-ID: <55DD6621.20907@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

with next-20150825 I have the following kernel panic:

RAMDISK: cramfs filesystem found at block 0
RAMDISK: Loading 7412KiB [1 disk] into ram disk... done.
VFS: Mounted root (cramfs filesystem) readonly on device 1:0.
devtmpfs: mounted
Freeing unused kernel memory: 200K (c04de000 - c0510000)
Unhandled fault: page domain fault (0x01b) at 0xb6f306a0
pgd = c64e0000
[b6f306a0] *pgd=c5a2e831, *pte=c76e718b, *ppte=c76e7aaa
Internal error: : 1b [#1] PREEMPT ARM
Modules linked in:
CPU: 0 PID: 1 Comm: init Not tainted 4.2.0-rc8-next-20150825 #19
Hardware name: DaVinci DA850/OMAP-L138/AM18x EVM
task: c7034000 ti: c7036000 task.ti: c7036000
PC is at not_thumb+0x0/0x18
LR is at __dabt_usr+0x50/0x60
pc : [<c00130b8>]    lr : [<c000e290>]    psr: 40000093
sp : c7037fb0  ip : 00000051  fp : 00000000
r10: 00000000  r9 : 00000000  r8 : 00053177
r7 : 0005317f  r6 : ffffffff  r5 : 60000010  r4 : b6f306a0
r3 : becacd60  r2 : c7037fb0  r1 : 00000017  r0 : b6f38f70
Flags: nZcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 0005317f  Table: c64e0000  DAC: 00000051
Process init (pid: 1, stack limit = 0xc7036190)
Stack: (0xc7037fb0 to 0xc7038000)
7fa0:                                     ???????? ???????? ???????? ????????
7fc0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
7fe0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
Backtrace: no frame pointer
Code: bad PC value
---[ end trace 8cb5f050de571f06 ]---
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

bisect points me to the following commit:
0db805aa8c96 ARM: software-based priviledged-no-access support

If I disable the CONFIG_CPU_SW_DOMAIN_PAN, I will have:

RAMDISK: cramfs filesystem found at block 0
RAMDISK: Loading 7412KiB [1 disk] into ram disk... done.
VFS: Mounted root (cramfs filesystem) readonly on device 1:0.
devtmpfs: mounted
Freeing unused kernel memory: 204K (c04d9000 - c050c000)
Unhandled fault: page domain fault (0x81b) at 0x000b2b4a
pgd = c36d4000
[000b2b4a] *pgd=c36c5831, *pte=c050a14b, *ppte=c050affa
Internal error: : 81b [#1] PREEMPT ARM
Modules linked in:
CPU: 0 PID: 1 Comm: init Not tainted 4.2.0-rc8-next-20150825 #21
Hardware name: DaVinci DA850/OMAP-L138/AM18x EVM
task: c7034000 ti: c7036000 task.ti: c7036000
PC is at __clear_user_std+0x1c/0x68
LR is at padzero+0x54/0x60
pc : [<c01e607c>]    lr : [<c010dd28>]    psr: 60000013
sp : c7037e48  ip : 00000002  fp : c7037e5c
r10: c70800a0  r9 : c47816e0  r8 : c4786300
r7 : c7037e60  r6 : 00000000  r5 : c4786200  r4 : c46e6100
r3 : 00000000  r2 : 00000000  r1 : 000004b6  r0 : 000b2b4a
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 0005317f  Table: c36d4000  DAC: 00000051
Process init (pid: 1, stack limit = 0xc7036190)
Stack: (0xc7037e48 to 0xc7038000)
7e40:                   000004b6 c010dd28 c7037ee4 c7037e60 c010fbb0 c010dce4
7e60: 00001812 00000000 00000000 00000000 c7037e60 00000000 c7036000 c4786200
7e80: 00008000 000b2b4a 000b2500 000aa500 00008000 00000000 c47816e0 000b2b4a
7ea0: 000b3e2c c474de40 c7037f4c c7037f10 c003a8c0 c00c73bc c00c6108 c0539508
7ec0: c4786200 c05390b8 fffffff8 c7036000 00000001 c36d9000 c7037f0c c7037ee8
7ee0: c00c5b54 c010f434 c7034000 c701a000 00000001 c0510ff8 c4786200 00000000
7f00: c7037f4c c7037f10 c00c73bc c00c5ad0 c36d9034 c4772b40 00000000 c7034218
7f20: c0510ff8 c0510ff8 c0510f70 00000000 00000000 00000000 00000000 00000000
7f40: c7037f64 c7037f50 c00c7518 c00c6ef4 00000000 00000000 c7037f7c c7037f68
7f60: c0009558 c00c74f8 c054a640 c046dc24 c7037f94 c7037f80 c0009574 c0009540
7f80: c054a640 c03ac7bc c7037fac c7037f98 c03ac84c c0009570 c7036000 00000000
7fa0: 00000000 c7037fb0 c000a4a0 c03ac7cc 00000000 00000000 00000000 00000000
7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
7fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 80000400
Backtrace:
[<c010dcd4>] (padzero) from [<c010fbb0>] (load_elf_binary+0x78c/0x1190)
[<c010f424>] (load_elf_binary) from [<c00c5b54>]
(search_binary_handler+0x94/0x24c)
 r10:c36d9000 r9:00000001 r8:c7036000 r7:fffffff8 r6:c05390b8 r5:c4786200
 r4:c0539508
[<c00c5ac0>] (search_binary_handler) from [<c00c73bc>]
(do_execveat_common+0x4d8/0x604)
 r9:00000000 r8:c4786200 r7:c0510ff8 r6:00000001 r5:c701a000 r4:c7034000
[<c00c6ee4>] (do_execveat_common) from [<c00c7518>] (do_execve+0x30/0x38)
 r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c0510f70
 r4:c0510ff8
[<c00c74e8>] (do_execve) from [<c0009558>] (run_init_process+0x28/0x30)
[<c0009530>] (run_init_process) from [<c0009574>]
(try_to_run_init_process+0x14/0x44)
 r5:c046dc24 r4:c054a640
[<c0009560>] (try_to_run_init_process) from [<c03ac84c>] (kernel_init+0x90/0xf4)
 r5:c03ac7bc r4:c054a640
[<c03ac7bc>] (kernel_init) from [<c000a4a0>] (ret_from_fork+0x14/0x34)
 r4:00000000 r3:c7036000
Code: ba00000d e210c003 0a000005 e35c0002 (e4e02001)
---[ end trace 613fb4181e192889 ]---
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

Reverting commit 0db805aa8c96 will allows me to boot up properly as it used to
work up to 4.2-rc8.

OMAP-L138 is ARM926EJ-S, the filesystem is built with buildroot
(arm926t/EABI/Soft float/ARM instruction set).

Using davinci_all_defconfig for the kernel.

Regards,
P?ter
