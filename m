From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 08 Jan 2013 16:27:21 +0100
Subject: [PATCH v4 0/7] Add fully tested id switch and vbus connect detect
 support for Chipidea
In-Reply-To: <1356591603-23323-1-git-send-email-peter.chen@freescale.com>
References: <1356591603-23323-1-git-send-email-peter.chen@freescale.com>
Message-ID: <50EC3AD9.8000109@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On 27/12/2012 07:59, Peter Chen wrote:
> (Sorry for update slowly due to long time business trip)
> 
> Changes for v4 mainly for 2/7, 3/7, 4/7, see individual
> patch commit for detail.
> 
> This patchset adds fully tested otg id switch function and
> vbus connect/disconnect detection for chipidea driver.
> The mainly design of id/vbus handling follows msm otg driver.
> I hope the msm usb maintainer can have a look of this patchset,
> and give some comments, and move the whole msm usb driver to
> chipidea framework if possible in the future.
> 
> This patchset is fully tested at i.mx6Q saberlite board.

Have you tested it on a 3.8 kernel?

On a 3.7 kernel, it worked flawlessly on an imx28, but I rebased your
patches on top of 3.8, and now, it doesn't work anymore. At probe, it
generates the following panic:

[    1.257375] ci_hdrc ci_hdrc.0: doesn't support host
[    1.268937] ci_hdrc ci_hdrc.0: can't init gadget role, ret=-524
[    1.277062] Unable to handle kernel NULL pointer dereference at virtual address 00000044
[    1.285343] pgd = c0004000
[    1.288093] [00000044] *pgd=00000000
[    1.291718] Internal error: Oops: 5 [#1] ARM
[    1.296000] Modules linked in:
[    1.299093] CPU: 0    Not tainted  (3.8.0-rc2-00021-ge35aebb #339)
[    1.305312] PC is at ci13xxx_imx_probe+0x1d8/0x3d0
[    1.310125] LR is at ci13xxx_imx_probe+0x1d8/0x3d0
[    1.314906] pc : [<c025124c>]    lr : [<c025124c>]    psr: a0000013
[    1.314906] sp : c782fe90  ip : c0507578  fp : 00000000
[    1.326406] r10: 00000000  r9 : c797e8a0  r8 : c79c26d0
[    1.331656] r7 : c787f600  r6 : c787f610  r5 : 00000000  r4 : c79e1600
[    1.338187] r3 : c7871b00  r2 : 20000013  r1 : c79c26d0  r0 : 00000000
[    1.344718] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[    1.352031] Control: 0005317f  Table: 40004000  DAC: 00000017
[    1.357781] Process swapper (pid: 1, stack limit = 0xc782e1b8)
[    1.363656] Stack: (0xc782fe90 to 0xc7830000)
[    1.368031] fe80:                                     c0a776c0 c787f610 c787f610 c0a776c0
[    1.376218] fea0: c787f644 c05227e4 00000000 c04e5500 c782e000 c02042ec c02042d8 c0203030
[    1.384437] fec0: c787f610 c05227e4 c787f644 c052fa60 00000000 c0203264 00000000 c05227e4
[    1.392625] fee0: c02031d0 c02017b4 c7803ca8 c7871b50 c05227e4 c79cdb00 c051a4c8 c020287c
[    1.400843] ff00: c047021c c05227e4 c05227e4 c04efed0 c052fa60 c052fa60 c04efeb0 c0203730
[    1.409031] ff20: 00000000 c04f4e0c c04efed0 c052fa60 c052fa60 c04efeb0 c782e000 c0008898
[    1.417250] ff40: c0470b50 c04b1860 00000006 00000006 ffffffff c0b88cc0 c04f4e0c c04efed0
[    1.425437] ff60: 00000007 c04efeb0 0000007c c04d421c 00000000 c035ebb0 00000006 00000006
[    1.433656] ff80: c04d421c 00000000 c035ea9c 00000000 00000000 c035ea9c 00000000 00000000
[    1.441843] ffa0: 00000000 00000000 00000000 c000ed48 00000000 00000000 00000000 00000000
[    1.450031] ffc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    1.458250] ffe0: 00000000 00000000 00000000 00000000 00000013 00000000 36060003 012c1285
[    1.466500] [<c025124c>] (ci13xxx_imx_probe+0x1d8/0x3d0) from [<c02042ec>] (platform_drv_probe+0x14/0x18)
[    1.476093] [<c02042ec>] (platform_drv_probe+0x14/0x18) from [<c0203030>] (driver_probe_device+0x74/0x214)
[    1.485781] [<c0203030>] (driver_probe_device+0x74/0x214) from [<c0203264>] (__driver_attach+0x94/0x98)
[    1.495218] [<c0203264>] (__driver_attach+0x94/0x98) from [<c02017b4>] (bus_for_each_dev+0x50/0x80)
[    1.504312] [<c02017b4>] (bus_for_each_dev+0x50/0x80) from [<c020287c>] (bus_add_driver+0x17c/0x250)
[    1.513468] [<c020287c>] (bus_add_driver+0x17c/0x250) from [<c0203730>] (driver_register+0x78/0x14c)
[    1.522625] [<c0203730>] (driver_register+0x78/0x14c) from [<c0008898>] (do_one_initcall+0x108/0x17c)
[    1.531875] [<c0008898>] (do_one_initcall+0x108/0x17c) from [<c035ebb0>] (kernel_init+0x114/0x2a4)
[    1.540875] [<c035ebb0>] (kernel_init+0x114/0x2a4) from [<c000ed48>] (ret_from_fork+0x14/0x2c)
[    1.549531] Code: e1a00006 ebfec61d e2840010 ebfec5f0 (e5903044) 
[    1.555906] ---[ end trace ad9061e486664e45 ]---

I dug a bit into it, and it seems there's two different bug here:
  - The probe function, when calling ci_hdrc_host_init, get ENXIO as
    the error code. This is new to 3.8. I don't really see why it would
    happen, because, judging from the code, only the first hw_read in
    the function returns such code, and this code hasn't change between
    the two versions.
  - The second one is that since the host mode is not enabled, the
    is_otg variable is never set to true, and thus, the function
    ci_hdrc_otg_init is never called. This is problematic since it
    registers the set_peripheral callback, that is called later in the
    function if the gadget role is defined. And I believe that this is 
    what actually triggers the panic.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
