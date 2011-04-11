From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 11 Apr 2011 16:23:07 +0200
Subject: [RFC PATCH 0/5] Convert some ARM platforms to basic-mmio-gpio
In-Reply-To: <20110411135215.GD2818@pulham.picochip.com>
References: <1302522502-24381-1-git-send-email-jamie@jamieiles.com>
	<20110411134320.GJ18601@pengutronix.de>
	<20110411135215.GD2818@pulham.picochip.com>
Message-ID: <20110411142307.GK18601@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 11, 2011 at 02:52:16PM +0100, Jamie Iles wrote:
> Hi Uwe,
> 
> On Mon, Apr 11, 2011 at 03:43:20PM +0200, Uwe Kleine-K?nig wrote:
> > On Mon, Apr 11, 2011 at 12:48:17PM +0100, Jamie Iles wrote:
> > > The basic-mmio-gpio driver has been extended in
> > > <http://marc.info/?l=linux-kernel&m=130252092900804&w=2> to support a
> > > larger wider of controllers and this series converts the ARM platforms
> > > that do not implement I/O muxing in the GPIO driver or use the .to_irq
> > > method of gpio_chip to use the driver.
> > As these patches are necessary to test at least the mxc patch but they
> > are not present in todays next and I don't want to spend the time to
> > find the patches on marc.info (the "next in thread" link is greyed out)
> > and it's non-trivial to get patches from marc into git (
> > wget -O - 'http://marc.info/?l=linux-kernel&m=130252092900807&q=raw' | git am
> > fails with "Patch does not have a valid e-mail address." because the raw
> > view doesn't provide the From: header (Subject: is missing, too)) can
> > you please point out a repository that has all 12 patches?
> 
> Sure, they're all in:
> 
> 	git://github.com/jamieiles/linux-2.6-ji.git gpio
> 
> There's one extra slightly unrelated fix for gemini in there too.
Thanks, compiles fine for a i.MX35 machine here, but fails to boot:

<6>[    0.000000] MXC GPIO hardware
<4>[    0.000000] ------------[ cut here ]------------
<4>[    0.000000] WARNING: at lib/kref.c:34 kref_get+0x2c/0x48()
<4>[    0.000000] Modules linked in:
<4>[    0.000000] Backtrace: 
<4>[    0.000000] [<c0039f9c>] (dump_backtrace+0x0/0x110) from [<c02bff9c>] (dump_stack+0x1c/0x20)
<4>[    0.000000]  r7:00000000 r6:c01c1ed0 r5:c0367fd4 r4:00000022
<4>[    0.000000] [<c02bff80>] (dump_stack+0x0/0x20) from [<c004b95c>] (warn_slowpath_common+0x5c/0x74)
<4>[    0.000000] [<c004b900>] (warn_slowpath_common+0x0/0x74) from [<c004b99c>] (warn_slowpath_null+0x28/0x30)
<4>[    0.000000]  r8:00000000 r7:00000000 r6:00000003 r5:c7803008 r4:c03bce7c
<4>[    0.000000] [<c004b974>] (warn_slowpath_null+0x0/0x30) from [<c01c1ed0>] (kref_get+0x2c/0x48)
<4>[    0.000000] [<c01c1ea4>] (kref_get+0x0/0x48) from [<c01c0df0>] (kobject_get+0x20/0x28)
<4>[    0.000000]  r4:c03bce60
<4>[    0.000000] [<c01c0dd0>] (kobject_get+0x0/0x28) from [<c02017e4>] (get_device+0x20/0x28)
<4>[    0.000000]  r4:c7803000
<4>[    0.000000] [<c02017c4>] (get_device+0x0/0x28) from [<c0202b24>] (device_add+0x80/0x5c8)
<4>[    0.000000] [<c0202aa4>] (device_add+0x0/0x5c8) from [<c0206d50>] (platform_device_add+0x110/0x16c)
<4>[    0.000000] [<c0206c40>] (platform_device_add+0x0/0x16c) from [<c0207064>] (platform_device_register_resndata+0x90/0xb8)
<4>[    0.000000]  r7:00000000 r6:c0395f1c r5:c7803000 r4:00000000
<4>[    0.000000] [<c0206fd4>] (platform_device_register_resndata+0x0/0xb8) from [<c000cb34>] (mxc_gpio_init+0x134/0x1f0)
<4>[    0.000000]  r8:c039a82c r7:f57cc000 r6:53fcc007 r5:00000000 r4:00000060
<4>[    0.000000] [<c000ca00>] (mxc_gpio_init+0x0/0x1f0) from [<c000c3dc>] (mx35_init_irq+0x20/0x2c)
<4>[    0.000000] [<c000c3bc>] (mx35_init_irq+0x0/0x2c) from [<c00096bc>] (init_IRQ+0x1c/0x24)
<4>[    0.000000] [<c00096a0>] (init_IRQ+0x0/0x24) from [<c0008970>] (start_kernel+0x184/0x2b4)
<4>[    0.000000] [<c00087ec>] (start_kernel+0x0/0x2b4) from [<8000803c>] (0x8000803c)
<4>[    0.000000]  r7:c0399cb8 r6:c0021e70 r5:c0396054 r4:00c5387d
<4>[    0.000000] ---[ end trace 1b75b31a2719ed1c ]---
<1>[    0.000000] Unable to handle kernel NULL pointer dereference at virtual address 00000031
<1>[    0.000000] pgd = c0004000
<1>[    0.000000] [00000031] *pgd=00000000
<0>[    0.000000] Internal error: Oops: 5 [#1] PREEMPT
<0>[    0.000000] last sysfs file: 
<4>[    0.000000] Modules linked in:
<4>[    0.000000] CPU: 0    Tainted: G        W    (2.6.39-rc2-00013-gdc29556-dirty #59)
<4>[    0.000000] PC is at sysfs_create_dir+0x34/0xf8
<4>[    0.000000] LR is at kobject_add_internal+0xdc/0x1b0
<4>[    0.000000] pc : [<c012d534>]    lr : [<c01c0fc0>]    psr: a00001d3
<4>[    0.000000] sp : c0395dd8  ip : c0395e08  fp : c0395e04
<4>[    0.000000] r10: c7803010  r9 : 00000003  r8 : c03bce60
<4>[    0.000000] r7 : 00000000  r6 : 00000000  r5 : c7803010  r4 : c7803010
<4>[    0.000000] r3 : c7805200  r2 : 00000002  r1 : c03bce60  r0 : c7803010
<4>[    0.000000] Flags: NzCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
<4>[    0.000000] Control: 00c5387f  Table: 80004008  DAC: 00000017
<0>[    0.000000] Process swapper (pid: 0, stack limit = 0xc0394268)
<0>[    0.000000] Stack: (0xc0395dd8 to 0xc0396000)
<0>[    0.000000] 5dc0:                                                       c0395e0c c03bce60
<0>[    0.000000] 5de0: c0395e04 c0395df0 c7803010 00000000 c03bce60 00000000 c0395e2c c0395e08
<0>[    0.000000] 5e00: c01c0fc0 c012d50c c004b99c c7803010 00000000 c03bce60 00000000 00000000
<0>[    0.000000] 5e20: c0395e4c c0395e30 c01c1198 c01c0ef0 c0395e54 c7803000 c7803008 00000003
<0>[    0.000000] 5e40: c0395e5c c0395e50 c01c1230 c01c1160 c0395eac c0395e68 c0202b50 c01c11f4
<0>[    0.000000] 5e60: 00000000 00000000 c03bce58 00000000 c0395e9c c0395e80 c00532bc c02c3200
<0>[    0.000000] 5e80: c0395ea0 c7803000 00000054 00000003 00000000 c0395f70 00000003 00000000
<0>[    0.000000] 5ea0: c0395ecc c0395eb0 c0206d50 c0202ab0 00000000 c7803000 c0395f1c 00000000
<0>[    0.000000] 5ec0: c0395f04 c0395ed0 c0207064 c0206c4c 00000000 c0395f1c c0395f70 600001d3
<0>[    0.000000] 5ee0: 0000005f 00000060 00000000 53fcc007 f57cc000 c039a82c c0395fa4 c0395f08
<0>[    0.000000] 5f00: c000cb34 c0206fe0 00000003 c0395f70 00000008 c0390020 c007b2b8 53fcc000
<0>[    0.000000] 5f20: 53fcc003 c0368645 00000200 00000000 00000000 00000000 53fcc008 53fcc00b
<0>[    0.000000] 5f40: c034b35b 00000200 00000000 00000000 00000000 53fcc004 53fcc007 c034b35f
<0>[    0.000000] 5f60: 00000200 00000000 00000000 00000000 00000000 00000020 c000cee0 bfffffff
<0>[    0.000000] 5f80: c03c720c c0021a6c c03c7200 80000000 4117b363 8002011c c0395fb4 c0395fa8
<0>[    0.000000] 5fa0: c000c3dc c000ca0c c0395fc4 c0395fb8 c00096bc c000c3c8 c0395ff4 c0395fc8
<0>[    0.000000] 5fc0: c0008970 c00096ac c0008554 00000000 00000000 c0021a6c 00c5387d c0396054
<0>[    0.000000] 5fe0: c0021e70 c0399cb8 00000000 c0395ff8 8000803c c00087f8 00000000 00000000
<4>[    0.000000] Backtrace: 
<4>[    0.000000] [<c012d500>] (sysfs_create_dir+0x0/0xf8) from [<c01c0fc0>] (kobject_add_internal+0xdc/0x1b0)
<4>[    0.000000]  r7:00000000 r6:c03bce60 r5:00000000 r4:c7803010
<4>[    0.000000] [<c01c0ee4>] (kobject_add_internal+0x0/0x1b0) from [<c01c1198>] (kobject_add_varg+0x44/0x54)
<4>[    0.000000]  r8:00000000 r7:00000000 r6:c03bce60 r5:00000000 r4:c7803010
<4>[    0.000000] [<c01c1154>] (kobject_add_varg+0x0/0x54) from [<c01c1230>] (kobject_add+0x4c/0x58)
<4>[    0.000000]  r6:00000003 r5:c7803008 r4:c7803000
<4>[    0.000000] [<c01c11e4>] (kobject_add+0x0/0x58) from [<c0202b50>] (device_add+0xac/0x5c8)
<4>[    0.000000]  r3:00000000 r2:00000000
<4>[    0.000000] [<c0202aa4>] (device_add+0x0/0x5c8) from [<c0206d50>] (platform_device_add+0x110/0x16c)
<4>[    0.000000] [<c0206c40>] (platform_device_add+0x0/0x16c) from [<c0207064>] (platform_device_register_resndata+0x90/0xb8)
<4>[    0.000000]  r7:00000000 r6:c0395f1c r5:c7803000 r4:00000000
<4>[    0.000000] [<c0206fd4>] (platform_device_register_resndata+0x0/0xb8) from [<c000cb34>] (mxc_gpio_init+0x134/0x1f0)
<4>[    0.000000]  r8:c039a82c r7:f57cc000 r6:53fcc007 r5:00000000 r4:00000060
<4>[    0.000000] [<c000ca00>] (mxc_gpio_init+0x0/0x1f0) from [<c000c3dc>] (mx35_init_irq+0x20/0x2c)
<4>[    0.000000] [<c000c3bc>] (mx35_init_irq+0x0/0x2c) from [<c00096bc>] (init_IRQ+0x1c/0x24)
<4>[    0.000000] [<c00096a0>] (init_IRQ+0x0/0x24) from [<c0008970>] (start_kernel+0x184/0x2b4)
<4>[    0.000000] [<c00087ec>] (start_kernel+0x0/0x2b4) from [<8000803c>] (0x8000803c)
<4>[    0.000000]  r7:c0399cb8 r6:c0021e70 r5:c0396054 r4:00c5387d
<0>[    0.000000] Code: e595100c e3510000 059f60b8 15916018 (e5d60031) 
<4>[    0.000000] ---[ end trace 1b75b31a2719ed1d ]---
<0>[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
<4>[    0.000000] Backtrace: 
<4>[    0.000000] [<c0039f9c>] (dump_backtrace+0x0/0x110) from [<c02bff9c>] (dump_stack+0x1c/0x20)
<4>[    0.000000]  r7:c0395d90 r6:c03985e8 r5:c0394000 r4:c03c75ac
<4>[    0.000000] [<c02bff80>] (dump_stack+0x0/0x20) from [<c02c000c>] (panic+0x6c/0x19c)
<4>[    0.000000] [<c02bffa0>] (panic+0x0/0x19c) from [<c004f56c>] (do_exit+0xa4/0x6c4)
<4>[    0.000000]  r3:00000000 r2:00000000 r1:c0394000 r0:c034c3cc
<4>[    0.000000] [<c004f4c8>] (do_exit+0x0/0x6c4) from [<c003a540>] (die+0x198/0x1cc)
<4>[    0.000000] [<c003a3a8>] (die+0x0/0x1cc) from [<c003c6c4>] (__do_kernel_fault+0x74/0x94)
<4>[    0.000000] [<c003c650>] (__do_kernel_fault+0x0/0x94) from [<c003c8a8>] (do_page_fault+0x1c4/0x1dc)
<4>[    0.000000]  r8:00000031 r7:00000031 r6:c03985e8 r5:00000000 r4:c039a434
<4>[    0.000000] [<c003c6e4>] (do_page_fault+0x0/0x1dc) from [<c003c95c>] (do_translation_fault+0x28/0xb4)
<4>[    0.000000] [<c003c934>] (do_translation_fault+0x0/0xb4) from [<c0031264>] (do_DataAbort+0x40/0xa0)
<4>[    0.000000]  r7:c0395d90 r6:00000005 r5:c0395dc4 r4:c039a434
<4>[    0.000000] [<c0031224>] (do_DataAbort+0x0/0xa0) from [<c003696c>] (__dabt_svc+0x4c/0x80)
<4>[    0.000000] Exception stack(0xc0395d90 to 0xc0395dd8)
<4>[    0.000000] 5d80:                                     c7803010 c03bce60 00000002 c7805200
<4>[    0.000000] 5da0: c7803010 c7803010 00000000 00000000 c03bce60 00000003 c7803010 c0395e04
<4>[    0.000000] 5dc0: c0395e08 c0395dd8 c01c0fc0 c012d534 a00001d3 ffffffff
<4>[    0.000000]  r8:c03bce60 r7:00000000 r6:00000000 r5:c0395dc4 r4:ffffffff
<4>[    0.000000] [<c012d500>] (sysfs_create_dir+0x0/0xf8) from [<c01c0fc0>] (kobject_add_internal+0xdc/0x1b0)
<4>[    0.000000]  r7:00000000 r6:c03bce60 r5:00000000 r4:c7803010
<4>[    0.000000] [<c01c0ee4>] (kobject_add_internal+0x0/0x1b0) from [<c01c1198>] (kobject_add_varg+0x44/0x54)
<4>[    0.000000]  r8:00000000 r7:00000000 r6:c03bce60 r5:00000000 r4:c7803010
<4>[    0.000000] [<c01c1154>] (kobject_add_varg+0x0/0x54) from [<c01c1230>] (kobject_add+0x4c/0x58)
<4>[    0.000000]  r6:00000003 r5:c7803008 r4:c7803000
<4>[    0.000000] [<c01c11e4>] (kobject_add+0x0/0x58) from [<c0202b50>] (device_add+0xac/0x5c8)
<4>[    0.000000]  r3:00000000 r2:00000000
<4>[    0.000000] [<c0202aa4>] (device_add+0x0/0x5c8) from [<c0206d50>] (platform_device_add+0x110/0x16c)
<4>[    0.000000] [<c0206c40>] (platform_device_add+0x0/0x16c) from [<c0207064>] (platform_device_register_resndata+0x90/0xb8)
<4>[    0.000000]  r7:00000000 r6:c0395f1c r5:c7803000 r4:00000000
<4>[    0.000000] [<c0206fd4>] (platform_device_register_resndata+0x0/0xb8) from [<c000cb34>] (mxc_gpio_init+0x134/0x1f0)
<4>[    0.000000]  r8:c039a82c r7:f57cc000 r6:53fcc007 r5:00000000 r4:00000060
<4>[    0.000000] [<c000ca00>] (mxc_gpio_init+0x0/0x1f0) from [<c000c3dc>] (mx35_init_irq+0x20/0x2c)
<4>[    0.000000] [<c000c3bc>] (mx35_init_irq+0x0/0x2c) from [<c00096bc>] (init_IRQ+0x1c/0x24)
<4>[    0.000000] [<c00096a0>] (init_IRQ+0x0/0x24) from [<c0008970>] (start_kernel+0x184/0x2b4)
<4>[    0.000000] [<c00087ec>] (start_kernel+0x0/0x2b4) from [<8000803c>] (0x8000803c)
<4>[    0.000000]  r7:c0399cb8 r6:c0021e70 r5:c0396054 r4:00c5387d

Booting a .39-rc2 works just fine.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
