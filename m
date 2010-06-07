From: daniel@caiaq.de (Daniel Mack)
Date: Mon, 7 Jun 2010 21:01:17 +0200
Subject: [PATCH] mx31lilly: prevent ulpi calls if !USB_CONFIG_ULPI
In-Reply-To: <1275936573-21108-1-git-send-email-jic23@cam.ac.uk>
References: <1275936573-21108-1-git-send-email-jic23@cam.ac.uk>
Message-ID: <20100607190117.GA2695@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 07, 2010 at 07:49:33PM +0100, Jonathan Cameron wrote:
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  All of the mx3 boards that use ulpi are suitably protected.
>  This currently makes mx3_defconfig fail as highlighted by
>  Kautobuild.  Sorry for noise if a fix is already on it's way!

There is actually. Have a look at Sascha's mxc trees.

Thanks, anyway :)

Daniel


> 
>  arch/arm/mach-mx3/mach-mx31lilly.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-mx3/mach-mx31lilly.c b/arch/arm/mach-mx3/mach-mx31lilly.c
> index d3d5877..6827c68 100644
> --- a/arch/arm/mach-mx3/mach-mx31lilly.c
> +++ b/arch/arm/mach-mx3/mach-mx31lilly.c
> @@ -114,6 +114,7 @@ static struct platform_device physmap_flash_device = {
>  };
>  
>  /* USB */
> +#if defined(CONFIG_USB_ULPI)
>  
>  #define USB_PAD_CFG (PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST | PAD_CTL_HYS_CMOS | \
>  			PAD_CTL_ODE_CMOS | PAD_CTL_100K_PU)
> @@ -243,6 +244,7 @@ static struct mxc_usbh_platform_data usbh2_pdata = {
>  	.portsc	= MXC_EHCI_MODE_ULPI | MXC_EHCI_UTMI_8BIT,
>  	.flags	= MXC_EHCI_POWER_PINS_ENABLED,
>  };
> +#endif /* USB_ULPI */
>  
>  static struct platform_device *devices[] __initdata = {
>  	&smsc91x_device,
> @@ -321,6 +323,7 @@ static void __init mx31lilly_board_init(void)
>  	platform_add_devices(devices, ARRAY_SIZE(devices));
>  
>  	/* USB */
> +#if defined(CONFIG_USB_ULPI)
>  	usbotg_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
>  				USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
>  	usbh2_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
> @@ -328,6 +331,7 @@ static void __init mx31lilly_board_init(void)
>  
>  	mxc_register_device(&mxc_usbh1, &usbh1_pdata);
>  	mxc_register_device(&mxc_usbh2, &usbh2_pdata);
> +#endif
>  }
>  
>  static void __init mx31lilly_timer_init(void)
> -- 
> 1.6.4.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
