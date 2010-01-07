From: dirk.behme@googlemail.com (Dirk Behme)
Date: Thu, 7 Jan 2010 11:50:40 +0100
Subject: SMP issues on ARM11 MPCore
In-Reply-To: <SNT109-W391FD03251D32533FAE84DA77F0@phx.gbl>
References: <SNT109-W391FD03251D32533FAE84DA77F0@phx.gbl>
Message-ID: <1687fa361001070250l62628061h4bebaca1c03d2638@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 24, 2009 at 4:27 PM, mkl lin <mkl0301@hotmail.com> wrote:
>
> hi,
>
> I'm using ARM11 MPCore with 2 CPU, Linux-2.6.31.1, SMP enabled, L1 enabled, L2 disabled
>
> Under SMP environment, I have observed following issues:
>
> case 1
> Sometimes, console became extremely slow, print 1 character for 1-2 seconds
> RVDS say that both CPU are idling. ?kernel seems find because messages ?response to inserting USB flash is quick and correct.
>
> case 2
> Sometimes, ?the Linux console halt and canot accept any input.
> RVDS say that both CPU are idling. ?kernel seems fine because messages ?response to inserting USB flash is quick and correct.
>
> case 3
> Sometimes, the test stop with no reason or some fault like segmantation fault and return to console prompt or login prompt.
>
> case 4
> Sometimes,
> the test stop with no reason, but not returning to console prompt. The
> console can accept input, but no further response, nor prompt.
>
> RVDS says that one CPU is idling, the other is in IRQ context, at
> entry-armv.S(676) after __pabt_usr, seems like it's keeps getting
> prefetch abort.
>
>
> I can duplicate case 1 by keep inserting a simple test module.
>
> -------
>
> #include <linux/init.h>
> #include <linux/module.h>
>
>
> static int __init MYDRIVER_init(void)
> {
>
> printk("%s: \n",__func__);
> return 0;
> }
>
> static void __exit MYDRIVER_exit(void)
> {
> printk("%s: \n",__func__);
> }
>
> MODULE_AUTHOR("Mac Lin");
> MODULE_DESCRIPTION("MYDRIVER");
> MODULE_LICENSE("GPL");
>
> module_init(MYDRIVER_init);
> module_exit(MYDRIVER_exit);
> -------

We tested above simple module on a 4 CPU ARM11 MPCore system using
2.6.32, too. Script to do this is very simple

> cat test.sh
insmod module.ko
rmmod module.ko
insmod module.ko
....

This immediately results in [1]  (user_debug=31 enabled).

Doing some further investigation, we found that [1] happens only if
module init and exit function are _both_ marked with __init/__exit.
Removing __init or __exit or both seems to make the test (~50 times)
run fine.

Any further proposals for testing or debugging?

Best regards

Dirk

[1] ~ # ./test.sh
 MYDRIVER_init
 MYDRIVER_exit
 Unable to handle kernel NULL pointer dereference at virtual address 00000000
 pgd = cc37c000
 [00000000] *pgd=8c38f031, *pte=00000000, *ppte=00000000
 Internal error: Oops: 17 [#1] SMP
 last sysfs file:
 Modules linked in: [last unloaded: module]
 CPU: 0    Not tainted  (2.6.32-00012-g89b993e-dirty #17)
 PC is at strcmp+0x8/0x34
 LR is at sysfs_find_dirent+0x18/0x38
 pc : [<c094bd8c>]    lr : [<c08ede4c>]    psr: a0000013
 sp : cc26bef8  ip : 00000000  fp : 00000000
 r10: 40025000  r9 : cc26a000  r8 : 00000880
 r7 : cc26bf44  r6 : 00000000  r5 : 00000000  r4 : cc326428
 r3 : 000009b3  r2 : 00000000  r1 : 00000000  r0 : 00000000
 Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
 Control: 08c5787d  Table: 8c37c00a  DAC: 00000015
 Process rmmod (pid: 378, stack limit = 0xcc26a270)
 Stack: (0xcc26bef8 to 0xcc26c000)
 bee0:                                                       cc3263f8 00000000
 bf00: 00000000 c08ec918 cc3263f8 00000000 00000000 00000000 00000000 ccd961e0
 bf20: 00000000 c087de50 bf000074 bf000074 00000000 c087e214 00000000 c087e550
 bf40: 00000001 75646f6d cc00656c cc37d000 cc25ba20 cc25ba64 cc25ba54 00000000
 bf60: 40025000 00000000 40025000 00000001 cc26a000 4002501c bef869c4 0089e8e8
 bf80: bf000074 00000880 cc26bf8c 00000000 be00656c 400256c0 00000000 00000081
 bfa0: c0842224 c08420a0 be00656c 400256c0 bef86b80 00000880 00000000 75646f6d
 bfc0: be00656c 400256c0 00000000 00000081 00000059 00000000 40025000 00000000
 bfe0: bef86b80 bef86b70 00012fe0 400e7740 60000010 bef86b80 00000000 00000000
 [<c094bd8c>] (strcmp+0x8/0x34) from [<c08ede4c>] (sysfs_find_dirent+0x18/0x38)
 [<c08ede4c>] (sysfs_find_dirent+0x18/0x38) from [<c08ec918>]
(sysfs_hash_and_remove+0x28/0x60)
 [<c08ec918>] (sysfs_hash_and_remove+0x28/0x60) from [<c087de50>]
(free_notes_attrs+0x2c/0x4c)
 [<c087de50>] (free_notes_attrs+0x2c/0x4c) from [<c087e214>]
(free_module+0x2c/0xdc)
 [<c087e214>] (free_module+0x2c/0xdc) from [<c087e550>]
(sys_delete_module+0x214/0x250)
 [<c087e550>] (sys_delete_module+0x214/0x250) from [<c08420a0>]
(ret_fast_syscall+0x0/0x2c)
 Code: 1afffff2 e8bd8030 e1a0c000 e3a02000 (e7dc0002)
 ---[ end trace 452e54bac4c701e5 ]---
 Segmentation fault
