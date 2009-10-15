From: jbe@pengutronix.de (Juergen Beisert)
Date: Thu, 15 Oct 2009 20:14:50 +0200
Subject: S3C2440: SD-Card access fails
Message-ID: <200910152014.50677.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi list,

I'm using an S3C2440 based custom made board with a 2.6.31.3 kernel (with a
few modifications to add the boards specific file). When I do some traffic on
the SD card (1GiB SD type), for example untaring an archive I get a failure
like this one:

Unable to handle kernel paging request at virtual address 4b856104
pgd = c0004000
[4b856104] *pgd=00000000
Internal error: Oops: 5 [#1]
Modules linked in:
CPU: 0    Not tainted  (2.6.31.3jbe #6)
PC is at s3c2410_gpio_getpin+0x18/0x2c
LR is at s3cmci_card_present+0x28/0x44
pc : [<c002cf10>]    lr : [<c0199290>]    psr: a0000013
sp : c1db9df8  ip : c1db9e08  fp : c1db9e04
r10: c1d33ae4  r9 : c1db9e78  r8 : 00000001
r7 : c1d61e00  r6 : c1db9e78  r5 : c1c3b000  r4 : c001d8d8
r3 : 4b856100  r2 : c1db9eb8  r1 : c1db9e78  r0 : a10ac21a
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: c000717f  Table: 3034c000  DAC: 00000017
Process mmcqd (pid: 375, stack limit = 0xc1db8270)
Stack: (0xc1db9df8 to 0xc1dba000)
9de0:                                                       c1db9e1c c1db9e08
9e00: c0199290 c002cf08 c1d33ae4 c1c3b140 c1db9e3c c1db9e20 c0199960 c0199278
9e20: c1d33ae4 c1db9e78 c1c3b000 c1d26708 c1db9e64 c1db9e40 c0190418 c019993c
9e40: c0196718 00000000 c1db9e48 c1db9e48 c1d26708 c1d33ae4 c1db9f94 c1db9e68
9e60: c01962b8 c019031c c02c01c0 c02c0100 c1db9e8c 00000000 c1db9e8c c1db9ee4
9e80: c1db9eb8 c1db9e44 c01904a8 00000012 08074600 00000000 00000000 00000000
9ea0: 00000000 000000b5 00000000 00000000 c1db9ee4 c1db9e78 0000000c 00000000
9ec0: 00000000 00000000 00000000 00000000 0000049d 00000000 00000000 00000000
9ee0: c1db9e78 05f5e100 00000000 00000200 00000008 00000000 00000200 00000000
9f00: c1db9eb8 c1db9e78 00000001 c1ceb800 c1c3d830 c1daac00 c1db9f44 c1db9f28
9f20: c1c6e01c c1daac00 00000017 c1daac00 00000000 c1d34438 00000000 c1d34438
9f40: 00000000 c1db9f5c c1db9f7c c1db9f58 c0115740 c1d26708 c1db9f7c c1db9f68
9f60: c0114ea4 c0119fcc c1db8000 c1d26708 c1d33ae4 c1db8000 c1d33aec c1d34438
9f80: 00000000 c1d34540 c1db9fc4 c1db9f98 c0196b50 c01960f4 c1db9fc4 c1db9fcc
9fa0: c1c3fd3c c1d33ae4 c0196a68 00000000 00000000 00000000 c1db9ff4 c1db9fc8
9fc0: c0048cb4 c0196a78 00000000 00000000 c1db9fd0 c1db9fd0 00000000 00000000
9fe0: 00000000 00000000 00000000 c1db9ff8 c00386e8 c0048c40 00000000 00000000
Backtrace:
[<c002cef8>] (s3c2410_gpio_getpin+0x0/0x2c) from [<c0199290>] 
(s3cmci_card_present+0x28/0x44)
[<c0199268>] (s3cmci_card_present+0x0/0x44) from [<c0199960>] 
(s3cmci_request+0x34/0x6c)
 r4:c1c3b140
[<c019992c>] (s3cmci_request+0x0/0x6c) from [<c0190418>] 
(mmc_wait_for_req+0x10c/0x124)
 r6:c1d26708 r5:c1c3b000 r4:c1db9e78
[<c019030c>] (mmc_wait_for_req+0x0/0x124) from [<c01962b8>] 
(mmc_blk_issue_rq+0x1d4/0x550)
 r5:c1d33ae4 r4:c1d26708
[<c01960e4>] (mmc_blk_issue_rq+0x0/0x550) from [<c0196b50>] 
(mmc_queue_thread+0xe8/0xec)
[<c0196a68>] (mmc_queue_thread+0x0/0xec) from [<c0048cb4>] (kthread+0x84/0x8c)
[<c0048c30>] (kthread+0x0/0x8c) from [<c00386e8>] (do_exit+0x0/0x21c)
 r7:00000000 r6:00000000 r5:00000000 r4:00000000
Code: e24cb004 e3c0301f e1a030a3 e28334fb (e5933004)
---[ end trace 969be95693003e89 ]---

This failure at adress 0xc002cf10 is the last line in function
s3c2410_gpio_getpin in arch/arm/plat-s3c24xx/gpio.c:

    return __raw_readl(base + 0x04) & (1<< offs);

But it doesn't fails always at this location. I saw various location when I 
try
to find the cause of the failure. Another failure was:

mmc0: card b368 removed
Unable to handle kernel paging request at virtual address 00001000
pgd = c0004000
[00001000] *pgd=00000000
Internal error: Oops: 0 [#1]
Modules linked in:
CPU: 0    Not tainted  (2.6.31.3jbe #4)
PC is at 0x1000
LR is@s3cmci_set_ios+0xf0/0x1f0
pc : [<00001000>]    lr : [<c01993d8>]    psr: 20000013
[...]
Backtrace:
[<c01992e8>] (s3cmci_set_ios+0x0/0x1f0) from [<c018f9e8>] 
(mmc_power_off+0x54/0x58)
[<c018f994>] (mmc_power_off+0x0/0x58) from [<c018fc74>] 
(mmc_detach_bus+0x6c/0xcc)
[<c018fc08>] (mmc_detach_bus+0x0/0xcc) from [<c0192a80>] 
(mmc_sd_detect+0x78/0x8c)
[...]

But: It does not happen immediately when the traffic starts. It always happens
a few seconds after the traffic starts. And it fails more often when I run a
kernel with CONFIG_KALLSYMS=n instead of =y.
And currently the system only fails if I use the SD card. While running from
NFS root and doing some action in the system it seems to run stable.

Any idea what is going on here? 

Regards,
Juergen

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | Phone: +49-8766-939 228     |
Vertretung Sued/Muenchen, Germany             | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686              | http://www.pengutronix.de/  |
