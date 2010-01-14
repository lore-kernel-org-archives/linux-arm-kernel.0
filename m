From: uri.yosef@gmail.com (Uri Yosef)
Date: Thu, 14 Jan 2010 10:25:27 +0200
Subject: kernel boot failure on with s32440/mini2440 with git head
	(dd59f6c76b2)
In-Reply-To: <4B4EC3F7.8060908@walsimou.com>
References: <4B2E4A65.8070207@walsimou.com>
	<200912211410.12014.jbe@pengutronix.de>
	<dc447790912210526l3247b8fdxfc3f7c4c99706b04@mail.gmail.com>
	<4B37A6D4.9000301@walsimou.com> <4B4217E7.5000207@simtec.co.uk>
	<c7df016d1001130624s596ad2d3ub302f2bcea481234@mail.gmail.com>
	<4B4E5646.20300@simtec.co.uk> <4B4EC3F7.8060908@walsimou.com>
Message-ID: <c7df016d1001140025s19301301i8d89dd19fe4c2b49@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 14, 2010 at 9:12 AM, Gaye Abdoulaye Walsimou
<walsimou@walsimou.com> wrote:
> Ben Dooks wrote:
>>>
>>> Dear all,
>>>
>>> I still get the same issue with kernel 2.6.33-rc4 (see log).
>>> Any idea?
>>>
>>> Regards,
>>> Uri Yosef
>>>
>>> Uncompressing Linux... done, booting the kernel.
>>> Linux version 2.6.33-rc4 (uri at mylinux) (gcc version 4.4.1 (Sourcery
>>> G++ Lite 2009q3-67) ) #1 Wed Jan 13 16:00:38 IST 2010
>>> CPU: ARM920T [41129200] revision 0 (ARMv4T), cr=c0007177
>>> CPU: VIVT data cache, VIVT instruction cache
>>> Machine: MINI2440
>>> Memory policy: ECC disabled, Data cache writeback
>>> CPU S3C2440A (id 0x32440001)
>>> S3C24XX Clocks, Copyright 2004 Simtec Electronics
>>> S3C244X: core 405.000 MHz, memory 101.250 MHz, peripheral 50.625 MHz
>>> CLOCK: Slow mode (1.500 MHz), fast, MPLL on, UPLL on
>>> Built 1 zonelists in Zone order, mobility grouping on. ?Total pages: 16256
>>> Kernel command line: root=/dev/mtdblock3 console=ttySAC0,115200 mini2440=1tb
>>> PID hash table entries: 256 (order: -2, 1024 bytes)
>>> Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
>>> Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
>>> Memory: 64MB = 64MB total
>>> Memory: 61048KB available (3260K code, 351K data, 120K init, 0K highmem)
>>> SLUB: Genslabs=11, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
>>> Hierarchical RCU implementation.
>>> NR_IRQS:85
>>> irq: clearing subpending status 00000002
>>> Console: colour dummy device 80x30
>>> console [ttySAC0] enabled
>>> Calibrating delay loop... 201.93 BogoMIPS (lpj=504832)
>>> Mount-cache hash table entries: 512
>>> CPU: Testing write buffer coherency: ok
>>> devtmpfs: initialized
>>> NET: Registered protocol family 16
>>> MINI2440: Option string mini2440=1tb
>>> MINI2440: 't' ignored, touchscreen not compiled in
>>> MINI2440: LCD 0:240x320 [1:800x480] 2:1024x768
>>> Unable to handle kernel NULL pointer dereference at virtual address 00000000
>>> pgd = c0004000
>>> [00000000] *pgd=00000000
>>> Internal error: Oops: 5 [#1]
>>> last sysfs file:
>>> Modules linked in:
>>> CPU: 0 ? ?Not tainted ?(2.6.33-rc4 #1)
>>> PC is at memcpy+0x64/0x29c
>>> LR is at kmemdup+0x2c/0x34
>>>
>>
>> This looks like a new issue to me, please compile your kernel
>> with sufficient debug information so that a full backtrace can
>> be generated and we can find out where this is happening.
>>
>>
>
> No this is not a new issue, it's the same I reported. As I said
> previously reverting
> the changes introduced by commit[1] in mini2440 code, make the board to
> be able boot again.
>
> [1] ?ARM: S3C: Add NAND device platform data set call:
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=2a3a18045b136487b22733d57410e6dccd34ac84
>
> Best regards,
> AWG
>

The root cause for this crash is NULL reference set->nr_map
This patch fixes it:

diff -ruN a/arch/arm/plat-s3c/dev-nand.c b/arch/arm/plat-s3c/dev-nand.c
--- a/arch/arm/plat-s3c/dev-nand.c   2010-01-14 10:05:30.852255703 +0200
+++ linux-2.6.33-rc4/arch/arm/plat-s3c/dev-nand.c       2010-01-13
07:15:00.000000000 +0200
@@ -59,7 +59,7 @@
        }

        size = sizeof(int) * set->nr_chips;
-       if (size) {
+      if (size && set->nr_map) {
                ptr = kmemdup(set->nr_map, size, GFP_KERNEL);
                set->nr_map = ptr;


And it took me to the next crash (which can be fixed by removing few
__inidata around the mini2440 leds data):

s3c2410-rtc s3c2410-rtc: setting system clock to 2010-01-08 16:00:43
UTC (1262966443)
VFS: Mounted root (squashfs filesystem) readonly on device 31:3.
devtmpfs: mounted
Freeing init memory: 132K
Unable to handle kernel paging request at virtual address 0df0daa4
pgd = c0004000
[0df0daa4] *pgd=00000000
Internal error: Oops: 5 [#1]
last sysfs file:
Modules linked in:
CPU: 0    Not tainted  (2.6.33-rc4 #4)
PC is at s3c2410_gpio_setpin+0x2c/0x4c
LR is at s3c24xx_led_set+0x34/0x58
pc : [<c0034650>]    lr : [<c0270940>]    psr: 60000093
sp : c396bdc0  ip : c0034638  fp : c396bdd4
r10: 00000001  r9 : 00000001  r8 : 00000ac9
r7 : c394e588  r6 : 000000ff  r5 : 000000ff  r4 : c002566c
r3 : 60000013  r2 : 0df0daa0  r1 : 00000000  r0 : 25e1b54b
Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: c000717f  Table: 30004000  DAC: 00000017
Process mtdblockd (pid: 621, stack limit = 0xc396a270)
Stack: (0xc396bdc0 to 0xc396c000)
bdc0: 00000001 c002566c c396bdec c396bdd8 c0270940 c0034634 c398533c c396f8ac
bde0: c396be0c c396bdf0 c02702e4 c027091c c04bb794 c394e400 c394e588 ffff1880
be00: c396be2c c396be10 c020d95c c02702a8 c0210610 c394e400 00000000 00000000
be20: c396be54 c396be30 c020e5b0 c020d8d0 c394e588 c394e400 00000200 c394e674
be40: c0025800 00000000 c396becc c396be58 c020db28 c020e360 00000000 c3993300
be60: 00000ac9 0000003f 00000000 00000000 00000000 00000000 00000000 00000000
be80: 00000000 00000200 00000ac9 c3808100 00000000 00000000 00000000 00000000
bea0: 00000000 c394e400 c394e588 00000200 00564800 00000000 00000200 c395de00
bec0: c396befc c396bed0 c020e150 c020d9bc c394e674 c396bee0 c017b224 c395de00
bee0: 00004800 00000000 00000000 00000000 c396bf44 c396bf00 c01f6510 c020e0c4
bf00: 00000200 c396bf5c c0025800 00000000 00000000 00000000 00000000 00000000
bf20: c396bf4c 00004800 00000200 c3979b40 c0025800 00020000 c396bf8c c396bf48
bf40: c01fb270 c01f6468 00000200 c396bf5c c0025800 c3971320 00000000 c0457ffc
bf60: c396bf7c c3971320 00000002 c0457ffc 00000024 c0025800 c3af9bd0 c3af9bc0
bf80: c396bfc4 c396bf90 c01fa708 c01fb1a4 c3963720 c396a000 c030da6c c3823f18
bfa0: c396bfcc c01fa588 c0457ffc 00000000 00000000 00000000 c396bff4 c396bfc8
bfc0: c005e3f8 c01fa598 00000000 00000000 c396bfd0 c396bfd0 00000000 00000000
bfe0: 00000000 00000000 00000000 c396bff8 c002a9c0 c005e37c 00000000 00000000
[<c0034650>] (s3c2410_gpio_setpin+0x2c/0x4c) from [<c0270940>]
(s3c24xx_led_set+0x34/0x58)
[<c0270940>] (s3c24xx_led_set+0x34/0x58) from [<c02702e4>]
(led_trigger_event+0x4c/0x5c)
[<c02702e4>] (led_trigger_event+0x4c/0x5c) from [<c020d95c>]
(nand_wait_ready+0x9c/0xec)
[<c020d95c>] (nand_wait_ready+0x9c/0xec) from [<c020e5b0>]
(nand_command_lp+0x260/0x268)
[<c020e5b0>] (nand_command_lp+0x260/0x268) from [<c020db28>]
(nand_do_read_ops+0x17c/0x434)
[<c020db28>] (nand_do_read_ops+0x17c/0x434) from [<c020e150>]
(nand_read+0x9c/0xc0)
[<c020e150>] (nand_read+0x9c/0xc0) from [<c01f6510>] (part_read+0xb8/0x10c)
[<c01f6510>] (part_read+0xb8/0x10c) from [<c01fb270>]
(mtdblock_readsect+0xdc/0x11c)
[<c01fb270>] (mtdblock_readsect+0xdc/0x11c) from [<c01fa708>]
(mtd_blktrans_thread+0x180/0x268)
[<c01fa708>] (mtd_blktrans_thread+0x180/0x268) from [<c005e3f8>]
(kthread+0x8c/0x94)
[<c005e3f8>] (kthread+0x8c/0x94) from [<c002a9c0>] (kernel_thread_exit+0x0/0x8)
Code: e121f002 e3c0201f e1a020a2 e28224fb (e592c004)
---[ end trace 919bc5c9d3a012a5 ]---
