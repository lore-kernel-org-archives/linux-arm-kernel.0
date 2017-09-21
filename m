From: hejianet@gmail.com (Jia He)
Date: Thu, 21 Sep 2017 14:31:55 +0800
Subject: Possible gcc 4.8.5 bug about RELOC_HIDE marcro
Message-ID: <03f619bd-e3b2-49e0-5f2c-e232974eac12@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I tried to build kernel 4.14-rc1 on a arm64 server in distro centos 7.3. 
The gcc version is 4.8.5

It was built successfully but failed to boot with the call trace below:

===========call trace begin==============

[??? 8.993531] Unable to handle kernel NULL pointer dereference at 
virtual address 0000c4a0
[??? 9.000668] Mem abort info:
[??? 9.000669]?? Exception class = DABT (current EL), IL = 32 bits
[??? 9.000670]?? SET = 0, FnV = 0
[??? 9.000670]?? EA = 0, S1PTW = 0
[??? 9.000671] Data abort info:
[??? 9.000671]?? ISV = 0, ISS = 0x00000005
[??? 9.000672]?? CM = 0, WnR = 0
[??? 9.000674] user pgtable: 64k pages, 48-bit VAs, pgd = ffff8017ddf79c00
[??? 9.000675] [000000000000c4a0] *pgd=0000000000000000, 
*pud=0000000000000000
[??? 9.000678] Internal error: Oops: 96000005 [#1] SMP
[??? 9.000679] Modules linked in: sdhci_acpi ixgbe(+) mdio xhci_plat_hcd 
at803x xhci_hcd ahci_platform libahci_platform qcom_emac libahci usbcore 
sdhci ipv6 crc_ccitt
[??? 9.000693] CPU: 1 PID: 1073 Comm: kworker/1:1 Not tainted 4.14.0-rc1+ #5
[??? 9.000693] Hardware name: To be filled by O.E.M. To be filled by 
O.E.M./To be filled by O.E.M., BIOS 5.13 12/12/2012
[??? 9.000701] Workqueue: events_power_efficient process_srcu
[??? 9.000703] task: ffff8017cd498c00 task.stack: ffff00001bbe0000
[??? 9.000704] PC is at process_srcu+0x50/0x4bc
[??? 9.000706] LR is at process_srcu+0x48/0x4bc
[??? 9.000707] pc : [<ffff00000813fc30>] lr : [<ffff00000813fc28>] 
pstate: 60400145
[??? 9.000707] sp : ffff00001bbefcf0
[??? 9.000708] x29: ffff00001bbefcf0 x28: ffff8017f952c800
[??? 9.000710] x27: ffff000009271000 x26: ffff000009484c88
[??? 9.000711] x25: 0000000000000000 x24: ffff000009b5aca0
[??? 9.000713] x23: ffff8017f9530f00 x22: ffff000009b5aca8
[??? 9.000715] x21: ffff8017f952c800 x20: ffff000009b5ac00
[??? 9.000716] x19: ffff000009b5a9d8 x18: 0000ffffdd61b6c0
[??? 9.000721] x17: 0000000000000000 x16: 0000000000000000
[??? 9.000722] x15: 0000000000000000 x14: 0000000000000000
[??? 9.000724] x13: 0000000000000000 x12: 0000000000000000
[??? 9.000725] x11: 0000000000000000 x10: 0000000000000c80
[??? 9.000727] x9 : ffff00001bbefd30 x8 : ffff8017cd4998e0
[??? 9.000729] x7 : 0000000000000000 x6 : 000000000ab89a36
[??? 9.000730] x5 : 000000000ab89a36 x4 : 000000000000079e
[??? 9.000732] x3 : ffff8017f952c820 x2 : 000000000000c4a0
[??? 9.000733] x1 : 0000000000000000 x0 : 0000000000000000
[??? 9.000735] Process kworker/1:1 (pid: 1073, stack limit = 
0xffff00001bbe0000)
[??? 9.000736] Call trace:
[??? 9.000738] Exception stack(0xffff00001bbefbb0 to 0xffff00001bbefcf0)
[??? 9.000739] fba0: 0000000000000000 0000000000000000
[??? 9.000741] fbc0: 000000000000c4a0 ffff8017f952c820 000000000000079e 
000000000ab89a36
[??? 9.000742] fbe0: 000000000ab89a36 0000000000000000 ffff8017cd4998e0 
ffff00001bbefd30
[??? 9.000743] fc00: 0000000000000c80 0000000000000000 0000000000000000 
0000000000000000
[??? 9.000745] fc20: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[??? 9.000746] fc40: 0000ffffdd61b6c0 ffff000009b5a9d8 ffff000009b5ac00 
ffff8017f952c800
[??? 9.000747] fc60: ffff000009b5aca8 ffff8017f9530f00 ffff000009b5aca0 
0000000000000000
[??? 9.000749] fc80: ffff000009484c88 ffff000009271000 ffff8017f952c800 
ffff00001bbefcf0
[??? 9.000750] fca0: ffff00000813fc28 ffff00001bbefcf0 ffff00000813fc30 
0000000060400145
[??? 9.000751] fcc0: ffff00001bbefcd0 ffff000008ac88dc ffffffffffffffff 
ffff00000813fc28
[??? 9.000752] fce0: ffff00001bbefcf0 ffff00000813fc30
[??? 9.000754] [<ffff00000813fc30>] process_srcu+0x50/0x4bc
[??? 9.000757] [<ffff0000080eac64>] process_one_work+0x16c/0x380
[??? 9.000759] [<ffff0000080eaed8>] worker_thread+0x60/0x3d4
[??? 9.000760] [<ffff0000080f182c>] kthread+0x10c/0x138
[??? 9.000762] [<ffff000008084d00>] ret_from_fork+0x10/0x20
[??? 9.000764] Code: aa1403e0 94262327 d28c4a02 8b020042 (c8dffc40)
[??? 9.000786] ---[ end trace 27afa0bd722ea1ea ]---
[??? 9.000787] Kernel panic - not syncing: Fatal exception
[??? 9.000800] SMP: stopping secondary CPUs
[??? 9.003437] Kernel Offset: disabled
[??? 9.003438] CPU features: 0x060418
[??? 9.003439] Memory Limit: none
[??? 9.340761] ---[ end Kernel panic - not syncing: Fatal exception

===========call trace end==============

I tried to disassemble the code and found the related lines:

Dump of assembler code for function process_srcu:
 ?? 0xffff00000813c5c4 <+0>:???? stp???? x29, x30, [sp,#-160]!
 ?? 0xffff00000813c5c8 <+4>:???? mov???? x29, sp
 ?? 0xffff00000813c5cc <+8>:???? stp???? x19, x20, [sp,#16]
 ?? 0xffff00000813c5d0 <+12>:??? stp???? x21, x22, [sp,#32]
 ?? 0xffff00000813c5d4 <+16>:??? stp???? x23, x24, [sp,#48]
 ?? 0xffff00000813c5d8 <+20>:??? stp???? x25, x26, [sp,#64]
 ?? 0xffff00000813c5dc <+24>:??? stp???? x27, x28, [sp,#80]
 ?? 0xffff00000813c5e0 <+28>:??? mov???? x24, x0
 ?? 0xffff00000813c5e4 <+32>:??? sub???? x0, x0, #0x6, lsl #12
 ?? 0xffff00000813c5e8 <+36>:??? sub???? x1, x0, #0x2c8
 ?? 0xffff00000813c5ec <+40>:??? add???? x19, x1, #0x6, lsl #12
 ?? 0xffff00000813c5f0 <+44>:??? str???? x0, [x29,#144]
 ?? 0xffff00000813c5f4 <+48>:??? mov???? x0, x30
 ?? 0xffff00000813c5f8 <+52>:??? str???? x1, [x29,#152]
 ?? 0xffff00000813c5fc <+56>:??? add???? x20, x19, #0x228
 ?? 0xffff00000813c600 <+60>:??? bl????? 0xffff000008090830 <_mcount>
 ?? 0xffff00000813c604 <+64>:??? mov???? x0, x20
 ?? 0xffff00000813c608 <+68>:??? bl????? 0xffff000008aa8554 <mutex_lock>
 ?? 0xffff00000813c60c <+72>:??? mov???? x2, #0x6250???????????????????? 
// #25168
 ?? 0xffff00000813c610 <+76>:??? add???? x2, x2, x2
 ?? ------>0xffff00000813c614 <+80>:??? ldar??? x0, [x2]???????? <------ 
panic in this line
 ?? 0xffff00000813c618 <+84>:??? and???? w0, w0, #0x3
 ?? 0xffff00000813c61c <+88>:??? cbz???? w0, 0xffff00000813c678 
<process_srcu+180>
 ?? 0xffff00000813c620 <+92>:??? ldr???? x2, [x24,#-120]
 ?? 0xffff00000813c624 <+96>:??? and???? w2, w2, #0x3
 ?? 0xffff00000813c628 <+100>:?? cmp???? w2, #0x1
 ?? 0xffff00000813c62c <+104>:?? b.eq??? 0xffff00000813c9ac 
<process_srcu+1000>
 ?? 0xffff00000813c630 <+108>:?? ldr???? x2, [x24,#-120]

seems the compiler doesn't work correctly, should it be some thing like

add???? x2, x2, x25 ??

instead of

add???? x2, x2, x2

Besides, I git bisect and find this *kernel* patch cause the compiler bug:

commit??? c350c008297643dad3c395c2fd92230142da5cf6
srcu: Prevent sdp->srcu_gp_seq_needed counter wrap

In this bug, srcu uses a percpu ptr which will call RELOC_HIDE. After I 
remove

the RELOC_HIDE code, this bug disappearred.


This bug is not in latest gcc version


Cheers,

Justin(Jia He)
