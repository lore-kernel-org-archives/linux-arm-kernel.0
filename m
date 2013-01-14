From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 14 Jan 2013 16:17:35 +0800
Subject: [PATCH v2 1/1] usb: fsl-mxc-udc: fix build error due to
 mach/hardware.h
In-Reply-To: <20130114074858.GA10176@arwen.pp.htv.fi>
References: <1358147897-8599-1-git-send-email-peter.chen@freescale.com>
 <20130114074858.GA10176@arwen.pp.htv.fi>
Message-ID: <20130114081732.GA9039@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 14, 2013 at 09:48:58AM +0200, Felipe Balbi wrote:
> Hi,
> 
> On Mon, Jan 14, 2013 at 03:18:17PM +0800, Peter Chen wrote:
> > It changes the driver to use platform_device_id rather than cpu_is_xxx
> > to determine the SoC type, and updates the platform code accordingly.
> > 
> > Compile ok at imx_v6_v7_defconfig with CONFIG_USB_FSL_USB2 enable.
> > Tested at mx51 bbg board, it works ok after enable phy clock
> > (Need another patch to fix this problem)
> > 
> > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> 
> not good for -rc. You have to break this down as you're solving at least
> three different problems with this patch.

Felipe, all my changes are for this problem, these are fix build error and
let it work.

 arch/arm/mach-imx/clk-imx25.c                     |    6 +-
 arch/arm/mach-imx/clk-imx27.c                     |    6 +-
 arch/arm/mach-imx/clk-imx31.c                     |    6 +-
 arch/arm/mach-imx/clk-imx35.c                     |    6 +-
 arch/arm/mach-imx/clk-imx51-imx53.c               |    6 +-

 As we change the connection-id, we need to change clock file or
 the devm_clk_get will be failed.
 
 arch/arm/mach-imx/devices/devices-common.h        |    1 +
 arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c |   15 +++---

 We need to differentiate SoCs, so I use platform_device_id to
 instead of cpu_ix_xxx(), this is for machine file change

 drivers/usb/gadget/fsl_mxc_udc.c                  |   23 +++++----
 drivers/usb/gadget/fsl_udc_core.c                 |   52 +++++++++++++-------
 drivers/usb/gadget/fsl_usb2_udc.h                 |   13 ++++--
 include/linux/fsl_devices.h                       |    8 +++

 Need to get platform_device_id at driver, and replace the cpu_is_xxx to
 platform_device_id. Meanwhile, needs a solution for replace
 MX35_IO_ADDRESS.

> 
> Besides there are parts which are not related to the build break.

I can split this patch to two patches, one is driver part, the other is
machine part. It can also fix build break, but it needs two
patches to let the udc work.

> 
> -- 
> balbi



-- 

Best Regards,
Peter Chen
