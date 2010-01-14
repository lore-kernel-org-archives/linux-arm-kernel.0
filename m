From: walsimou@walsimou.com (Abdoulaye Walsimou Gaye)
Date: Thu, 14 Jan 2010 09:57:15 +0100
Subject: kernel boot failure on with s32440/mini2440 with git head
	(dd59f6c76b2)
In-Reply-To: <c7df016d1001140025s19301301i8d89dd19fe4c2b49@mail.gmail.com>
References: <4B2E4A65.8070207@walsimou.com>	
	<200912211410.12014.jbe@pengutronix.de>	
	<dc447790912210526l3247b8fdxfc3f7c4c99706b04@mail.gmail.com>	
	<4B37A6D4.9000301@walsimou.com> <4B4217E7.5000207@simtec.co.uk>	
	<c7df016d1001130624s596ad2d3ub302f2bcea481234@mail.gmail.com>	
	<4B4E5646.20300@simtec.co.uk> <4B4EC3F7.8060908@walsimou.com>
	<c7df016d1001140025s19301301i8d89dd19fe4c2b49@mail.gmail.com>
Message-ID: <4B4EDC6B.7010709@walsimou.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uri Yosef wrote:
> The root cause for this crash is NULL reference set->nr_map
> This patch fixes it:
>
> diff -ruN a/arch/arm/plat-s3c/dev-nand.c b/arch/arm/plat-s3c/dev-nand.c
> --- a/arch/arm/plat-s3c/dev-nand.c   2010-01-14 10:05:30.852255703 +0200
> +++ linux-2.6.33-rc4/arch/arm/plat-s3c/dev-nand.c       2010-01-13
> 07:15:00.000000000 +0200
> @@ -59,7 +59,7 @@
>         }
>
>         size = sizeof(int) * set->nr_chips;
> -       if (size) {
> +      if (size && set->nr_map) {
>                 ptr = kmemdup(set->nr_map, size, GFP_KERNEL);
>                 set->nr_map = ptr;
>
>
>   

I think this one is already in the ML

> And it took me to the next crash (which can be fixed by removing few
> __inidata around the mini2440 leds data):
>
> s3c2410-rtc s3c2410-rtc: setting system clock to 2010-01-08 16:00:43
> UTC (1262966443)
> VFS: Mounted root (squashfs filesystem) readonly on device 31:3.
> devtmpfs: mounted
> Freeing init memory: 132K
> Unable to handle kernel paging request at virtual address 0df0daa4
> pgd = c0004000
> [0df0daa4] *pgd=00000000
> Internal error: Oops: 5 [#1]
> last sysfs file:
> Modules linked in:
> CPU: 0    Not tainted  (2.6.33-rc4 #4)
> PC is at s3c2410_gpio_setpin+0x2c/0x4c
> LR is at s3c24xx_led_set+0x34/0x58
> pc : [<c0034650>]    lr : [<c0270940>]    psr: 60000093
> sp : c396bdc0  ip : c0034638  fp : c396bdd4
> r10: 00000001  r9 : 00000001  r8 : 00000ac9
> r7 : c394e588  r6 : 000000ff  r5 : 000000ff  r4 : c002566c
> r3 : 60000013  r2 : 0df0daa0  r1 : 00000000  r0 : 25e1b54b
> Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
> Control: c000717f  Table: 30004000  DAC: 00000017
> Process mtdblockd (pid: 621, stack limit = 0xc396a270)
> Stack: (0xc396bdc0 to 0xc396c000)
>
>   
[...]

> [<c0034650>] (s3c2410_gpio_setpin+0x2c/0x4c) from [<c0270940>]
> (s3c24xx_led_set+0x34/0x58)
> [<c0270940>] (s3c24xx_led_set+0x34/0x58) from [<c02702e4>]
> (led_trigger_event+0x4c/0x5c)
> [<c02702e4>] (led_trigger_event+0x4c/0x5c) from [<c020d95c>]
> (nand_wait_ready+0x9c/0xec)
> [<c020d95c>] (nand_wait_ready+0x9c/0xec) from [<c020e5b0>]
> (nand_command_lp+0x260/0x268)
> [<c020e5b0>] (nand_command_lp+0x260/0x268) from [<c020db28>]
> (nand_do_read_ops+0x17c/0x434)
> [<c020db28>] (nand_do_read_ops+0x17c/0x434) from [<c020e150>]
> (nand_read+0x9c/0xc0)
> [<c020e150>] (nand_read+0x9c/0xc0) from [<c01f6510>] (part_read+0xb8/0x10c)
> [<c01f6510>] (part_read+0xb8/0x10c) from [<c01fb270>]
> (mtdblock_readsect+0xdc/0x11c)
> [<c01fb270>] (mtdblock_readsect+0xdc/0x11c) from [<c01fa708>]
> (mtd_blktrans_thread+0x180/0x268)
> [<c01fa708>] (mtd_blktrans_thread+0x180/0x268) from [<c005e3f8>]
> (kthread+0x8c/0x94)
> [<c005e3f8>] (kthread+0x8c/0x94) from [<c002a9c0>] (kernel_thread_exit+0x0/0x8)
> Code: e121f002 e3c0201f e1a020a2 e28224fb (e592c004)
> ---[ end trace 919bc5c9d3a012a5 ]---
>   

Please submit a patch for this one, may be it will get a chance to be
mainlined...

Best regards,
AWG
