From: balbi@ti.com (Felipe Balbi)
Date: Mon, 14 Jan 2013 10:50:27 +0200
Subject: [PATCH v2 1/1] usb: fsl-mxc-udc: fix build error due to
 mach/hardware.h
In-Reply-To: <20130114081732.GA9039@nchen-desktop>
References: <1358147897-8599-1-git-send-email-peter.chen@freescale.com>
 <20130114074858.GA10176@arwen.pp.htv.fi>
 <20130114081732.GA9039@nchen-desktop>
Message-ID: <20130114085027.GF10176@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jan 14, 2013 at 04:17:35PM +0800, Peter Chen wrote:
> On Mon, Jan 14, 2013 at 09:48:58AM +0200, Felipe Balbi wrote:
> > Hi,
> > 
> > On Mon, Jan 14, 2013 at 03:18:17PM +0800, Peter Chen wrote:
> > > It changes the driver to use platform_device_id rather than cpu_is_xxx
> > > to determine the SoC type, and updates the platform code accordingly.
> > > 
> > > Compile ok at imx_v6_v7_defconfig with CONFIG_USB_FSL_USB2 enable.
> > > Tested at mx51 bbg board, it works ok after enable phy clock
> > > (Need another patch to fix this problem)
> > > 
> > > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > 
> > not good for -rc. You have to break this down as you're solving at least
> > three different problems with this patch.
> 
> Felipe, all my changes are for this problem, these are fix build error and
> let it work.
> 
>  arch/arm/mach-imx/clk-imx25.c                     |    6 +-
>  arch/arm/mach-imx/clk-imx27.c                     |    6 +-
>  arch/arm/mach-imx/clk-imx31.c                     |    6 +-
>  arch/arm/mach-imx/clk-imx35.c                     |    6 +-
>  arch/arm/mach-imx/clk-imx51-imx53.c               |    6 +-
> 
>  As we change the connection-id, we need to change clock file or
>  the devm_clk_get will be failed.

right right, that's ok.

>  arch/arm/mach-imx/devices/devices-common.h        |    1 +
>  arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c |   15 +++---
> 
>  We need to differentiate SoCs, so I use platform_device_id to
>  instead of cpu_ix_xxx(), this is for machine file change

fair enough.

>  drivers/usb/gadget/fsl_mxc_udc.c                  |   23 +++++----
>  drivers/usb/gadget/fsl_udc_core.c                 |   52 +++++++++++++-------
>  drivers/usb/gadget/fsl_usb2_udc.h                 |   13 ++++--
>  include/linux/fsl_devices.h                       |    8 +++
> 
>  Need to get platform_device_id at driver, and replace the cpu_is_xxx to
>  platform_device_id. Meanwhile, needs a solution for replace
>  MX35_IO_ADDRESS.

ok, here we go:

You just listed to me three different fixes and each fix should be on a
separate patch. Meaning that you should have one single patch to convert
MX35_IO_ADDRESS() into ioremap(), another patch should be removing
cpu_is_xxx() and the third one fixing connection-id.

As you might remember, we want patches to be self-contained logical
units and your patch contains 3 of such logical units.

> > Besides there are parts which are not related to the build break.
> 
> I can split this patch to two patches, one is driver part, the other is
> machine part. It can also fix build break, but it needs two
> patches to let the udc work.

you will need as many patches as necessary, but they need to the broken
correclty, the way you suggested above is wrong.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130114/2b1dbd39/attachment.sig>
