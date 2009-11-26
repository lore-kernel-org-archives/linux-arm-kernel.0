From: daniel@caiaq.de (Daniel Mack)
Date: Thu, 26 Nov 2009 16:25:23 +0100
Subject: [patch] Add USB Gadget support for mx35pdk
In-Reply-To: <20091126151019.837865490@yahoo.com>
References: <20091126151019.837865490@yahoo.com>
Message-ID: <20091126152523.GH14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 26, 2009 at 04:09:11PM +0100, Harro Haan wrote:
> Add USB Gadget support for mx35pdk
> 
> The patch is baselined on:
> git://git.pengutronix.de/git/imx/linux-2.6.git mxc-master
> 
> Signed-off-by: Harro Haan <hrhaan@yahoo.com>
> ---
>  arch/arm/mach-mx3/clock-imx35.c |    3 +++
>  arch/arm/mach-mx3/mx35pdk.c     |   12 ++++++++++++
>  drivers/usb/gadget/Kconfig      |    2 +-
>  3 files changed, 16 insertions(+), 1 deletion(-)


Thank you for working on this.

However, you should split your patch into functional pieces. In this
case, that means you should have one for drivers/usb/gadget/Kconfig, one
for mx35pdk.c and one for clock-imx35.c.

Firstly because that makes tracking changes easier later and also
because these patches might take different pathes to mainline
eventually.

Git makes that very easy, btw.

Thanks,
Daniel


> Index: linux-2.6.31/drivers/usb/gadget/Kconfig
> ===================================================================
> --- linux-2.6.31.orig/drivers/usb/gadget/Kconfig	2009-11-25 17:57:01.000000000 +0100
> +++ linux-2.6.31/drivers/usb/gadget/Kconfig	2009-11-25 18:13:28.000000000 +0100
> @@ -156,7 +156,7 @@ config USB_ATMEL_USBA
>  
>  config USB_GADGET_FSL_USB2
>  	boolean "Freescale Highspeed USB DR Peripheral Controller"
> -	depends on FSL_SOC || ARCH_MXC
> +	depends on FSL_SOC || ARCH_MXC || ARCH_MX35
>  	select USB_GADGET_DUALSPEED
>  	help
>  	   Some of Freescale PowerPC processors have a High Speed
> Index: linux-2.6.31/arch/arm/mach-mx3/mx35pdk.c
> ===================================================================
> --- linux-2.6.31.orig/arch/arm/mach-mx3/mx35pdk.c	2009-11-25 17:57:01.000000000 +0100
> +++ linux-2.6.31/arch/arm/mach-mx3/mx35pdk.c	2009-11-25 19:04:39.000000000 +0100
> @@ -23,6 +23,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/memory.h>
>  #include <linux/gpio.h>
> +#include <linux/fsl_devices.h>
>  
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
> @@ -69,6 +70,15 @@ static struct pad_desc mx35pdk_pads[] = 
>  	MX35_PAD_FEC_TDATA2__FEC_TDATA_2,
>  	MX35_PAD_FEC_RDATA3__FEC_RDATA_3,
>  	MX35_PAD_FEC_TDATA3__FEC_TDATA_3,
> +	/* USBOTG */
> +	MX35_PAD_USBOTG_PWR__USB_TOP_USBOTG_PWR,
> +	MX35_PAD_USBOTG_OC__USB_TOP_USBOTG_OC,
> +};
> +
> +/* OTG config */
> +static struct fsl_usb2_platform_data usb_pdata = {
> +	.operating_mode	= FSL_USB2_DR_DEVICE,
> +	.phy_mode	= FSL_USB2_PHY_UTMI_WIDE,
>  };
>  
>  /*
> @@ -81,6 +91,8 @@ static void __init mxc_board_init(void)
>  	platform_add_devices(devices, ARRAY_SIZE(devices));
>  
>  	mxc_register_device(&mxc_uart_device0, &uart_pdata);
> +
> +	mxc_register_device(&mxc_otg_udc_device, &usb_pdata);
>  }
>  
>  static void __init mx35pdk_timer_init(void)
> Index: linux-2.6.31/arch/arm/mach-mx3/clock-imx35.c
> ===================================================================
> --- linux-2.6.31.orig/arch/arm/mach-mx3/clock-imx35.c	2009-11-25 18:20:04.000000000 +0100
> +++ linux-2.6.31/arch/arm/mach-mx3/clock-imx35.c	2009-11-25 18:29:08.000000000 +0100
> @@ -387,6 +387,8 @@ DEFINE_CLOCK(csi_clk,    0, CCM_CGR3,  0
>  DEFINE_CLOCK(iim_clk,    0, CCM_CGR3,  2, NULL, NULL);
>  DEFINE_CLOCK(gpu2d_clk,  0, CCM_CGR3,  4, NULL, NULL);
>  
> +DEFINE_CLOCK(usbahb_clk, 0, 0,         0, get_rate_ahb, NULL);
> +
>  static int clk_dummy_enable(struct clk *clk)
>  {
>  	return 0;
> @@ -471,6 +473,7 @@ static struct clk_lookup lookups[] = {
>  	_REGISTER_CLOCK("mxc-ehci.1", "usb", usbotg_clk)
>  	_REGISTER_CLOCK("mxc-ehci.2", "usb", usbotg_clk)
>  	_REGISTER_CLOCK("fsl-usb2-udc", "usb", usbotg_clk)
> +	_REGISTER_CLOCK("fsl-usb2-udc", "usb_ahb", usbahb_clk)
>  	_REGISTER_CLOCK("imx-wdt.0", NULL, wdog_clk)
>  	_REGISTER_CLOCK(NULL, "max", max_clk)
>  	_REGISTER_CLOCK(NULL, "audmux", audmux_clk)
> 
> -- 
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
