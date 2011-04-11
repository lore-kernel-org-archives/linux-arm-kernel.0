From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 11 Apr 2011 16:49:28 +0200
Subject: [RFC PATCH 0/5] Convert some ARM platforms to basic-mmio-gpio
In-Reply-To: <20110411143327.GA21449@pulham.picochip.com>
References: <1302522502-24381-1-git-send-email-jamie@jamieiles.com>
	<20110411134320.GJ18601@pengutronix.de>
	<20110411135215.GD2818@pulham.picochip.com>
	<20110411142307.GK18601@pengutronix.de>
	<20110411143327.GA21449@pulham.picochip.com>
Message-ID: <20110411144928.GL18601@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Apr 11, 2011 at 03:33:27PM +0100, Jamie Iles wrote:
> On Mon, Apr 11, 2011 at 04:23:07PM +0200, Uwe Kleine-K?nig wrote:
> > On Mon, Apr 11, 2011 at 02:52:16PM +0100, Jamie Iles wrote:
> > > On Mon, Apr 11, 2011 at 03:43:20PM +0200, Uwe Kleine-K?nig wrote:
> > > > On Mon, Apr 11, 2011 at 12:48:17PM +0100, Jamie Iles wrote:
> > > > > The basic-mmio-gpio driver has been extended in
> > > > > <http://marc.info/?l=linux-kernel&m=130252092900804&w=2> to support a
> > > > > larger wider of controllers and this series converts the ARM platforms
> > > > > that do not implement I/O muxing in the GPIO driver or use the .to_irq
> > > > > method of gpio_chip to use the driver.
> > > > As these patches are necessary to test at least the mxc patch but they
> > > > are not present in todays next and I don't want to spend the time to
> > > > find the patches on marc.info (the "next in thread" link is greyed out)
> > > > and it's non-trivial to get patches from marc into git (
> > > > wget -O - 'http://marc.info/?l=linux-kernel&m=130252092900807&q=raw' | git am
> > > > fails with "Patch does not have a valid e-mail address." because the raw
> > > > view doesn't provide the From: header (Subject: is missing, too)) can
> > > > you please point out a repository that has all 12 patches?
> > > 
> > > Sure, they're all in:
> > > 
> > > 	git://github.com/jamieiles/linux-2.6-ji.git gpio
> > > 
> > > There's one extra slightly unrelated fix for gemini in there too.
> > Thanks, compiles fine for a i.MX35 machine here, but fails to boot:
> > 
> > <6>[    0.000000] MXC GPIO hardware
> > <4>[    0.000000] ------------[ cut here ]------------
> > <4>[    0.000000] WARNING: at lib/kref.c:34 kref_get+0x2c/0x48()
> > <4>[    0.000000] Modules linked in:
> > <4>[    0.000000] Backtrace: 
> > <4>[    0.000000] [<c0039f9c>] (dump_backtrace+0x0/0x110) from [<c02bff9c>] (dump_stack+0x1c/0x20)
> > <4>[    0.000000]  r7:00000000 r6:c01c1ed0 r5:c0367fd4 r4:00000022
> > <4>[    0.000000] [<c02bff80>] (dump_stack+0x0/0x20) from [<c004b95c>] (warn_slowpath_common+0x5c/0x74)
> > <4>[    0.000000] [<c004b900>] (warn_slowpath_common+0x0/0x74) from [<c004b99c>] (warn_slowpath_null+0x28/0x30)
> > <4>[    0.000000]  r8:00000000 r7:00000000 r6:00000003 r5:c7803008 r4:c03bce7c
> > <4>[    0.000000] [<c004b974>] (warn_slowpath_null+0x0/0x30) from [<c01c1ed0>] (kref_get+0x2c/0x48)
> > <4>[    0.000000] [<c01c1ea4>] (kref_get+0x0/0x48) from [<c01c0df0>] (kobject_get+0x20/0x28)
> > <4>[    0.000000]  r4:c03bce60
> > <4>[    0.000000] [<c01c0dd0>] (kobject_get+0x0/0x28) from [<c02017e4>] (get_device+0x20/0x28)
> > <4>[    0.000000]  r4:c7803000
> > <4>[    0.000000] [<c02017c4>] (get_device+0x0/0x28) from [<c0202b24>] (device_add+0x80/0x5c8)
> > <4>[    0.000000] [<c0202aa4>] (device_add+0x0/0x5c8) from [<c0206d50>] (platform_device_add+0x110/0x16c)
> > <4>[    0.000000] [<c0206c40>] (platform_device_add+0x0/0x16c) from [<c0207064>] (platform_device_register_resndata+0x90/0xb8)
> > <4>[    0.000000]  r7:00000000 r6:c0395f1c r5:c7803000 r4:00000000
> > <4>[    0.000000] [<c0206fd4>] (platform_device_register_resndata+0x0/0xb8) from [<c000cb34>] (mxc_gpio_init+0x134/0x1f0)
> > <4>[    0.000000]  r8:c039a82c r7:f57cc000 r6:53fcc007 r5:00000000 r4:00000060
> > <4>[    0.000000] [<c000ca00>] (mxc_gpio_init+0x0/0x1f0) from [<c000c3dc>] (mx35_init_irq+0x20/0x2c)
> > <4>[    0.000000] [<c000c3bc>] (mx35_init_irq+0x0/0x2c) from [<c00096bc>] (init_IRQ+0x1c/0x24)
> > <4>[    0.000000] [<c00096a0>] (init_IRQ+0x0/0x24) from [<c0008970>] (start_kernel+0x184/0x2b4)
> 
> Hmm, so this looks like it's because mxc_gpio_init() is being called 
> from init_IRQ which is too early for platform devices.  Is there a 
> suitable place where this can be called later in the boot process?  I 
> guess the gpio irq stuff should remain where it is but the 
> platform_device registration should be moved to later.
I guess this means that using gpios in .init_machine (== arch_initcall
time) stops working then? Actually I wanted to test if this is broken
already now because the driver is registered too late. Actually my build
doesn't even have CONFIG_GPIO_BASIC_MMIO=y. I suggest to let the
converted platforms select it.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
