From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 21 May 2010 09:17:53 +0200
Subject: [PATCH 2/3] mx27: add support for the CSI device
In-Reply-To: <2df2fdd7809e836bac3ff4cd2d77aa976e6ca760.1273150585.git.baruch@tkos.co.il>
References: <cover.1273150585.git.baruch@tkos.co.il>
	<2df2fdd7809e836bac3ff4cd2d77aa976e6ca760.1273150585.git.baruch@tkos.co.il>
Message-ID: <20100521071753.GB17272@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 06, 2010 at 04:09:40PM +0300, Baruch Siach wrote:
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  arch/arm/mach-mx2/clock_imx27.c |    2 +-
>  arch/arm/mach-mx2/devices.c     |   31 +++++++++++++++++++++++++++++++
>  arch/arm/mach-mx2/devices.h     |    1 +
>  3 files changed, 33 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-mx2/clock_imx27.c b/arch/arm/mach-mx2/clock_imx27.c
> index 0f0823c..5a1aa15 100644
> --- a/arch/arm/mach-mx2/clock_imx27.c
> +++ b/arch/arm/mach-mx2/clock_imx27.c
> @@ -644,7 +644,7 @@ static struct clk_lookup lookups[] = {
>  	_REGISTER_CLOCK("spi_imx.1", NULL, cspi2_clk)
>  	_REGISTER_CLOCK("spi_imx.2", NULL, cspi3_clk)
>  	_REGISTER_CLOCK("imx-fb.0", NULL, lcdc_clk)
> -	_REGISTER_CLOCK(NULL, "csi", csi_clk)
> +	_REGISTER_CLOCK("mx2-camera.0", NULL, csi_clk)
>  	_REGISTER_CLOCK("fsl-usb2-udc", "usb", usb_clk)
>  	_REGISTER_CLOCK("fsl-usb2-udc", "usb_ahb", usb_clk1)
>  	_REGISTER_CLOCK("mxc-ehci.0", "usb", usb_clk)
> diff --git a/arch/arm/mach-mx2/devices.c b/arch/arm/mach-mx2/devices.c
> index b91e412..de501ac 100644
> --- a/arch/arm/mach-mx2/devices.c
> +++ b/arch/arm/mach-mx2/devices.c
> @@ -40,6 +40,37 @@
>  
>  #include "devices.h"
>  
> +#ifdef CONFIG_MACH_MX27
> +static struct resource mx27_camera_resources[] = {
> +	{
> +	       .start = CSI_BASE_ADDR,
> +	       .end = CSI_BASE_ADDR + 0x1f,
> +	       .flags = IORESOURCE_MEM,
> +	}, {
> +	       .start = EMMA_PRP_BASE_ADDR,
> +	       .end = EMMA_PRP_BASE_ADDR + 0x1f,
> +	       .flags = IORESOURCE_MEM,
> +	}, {
> +	       .start = MXC_INT_CSI,
> +	       .end = MXC_INT_CSI,
> +	       .flags = IORESOURCE_IRQ,
> +	},{
> +	       .start = MXC_INT_EMMAPRP,
> +	       .end = MXC_INT_EMMAPRP,
> +	       .flags = IORESOURCE_IRQ,
> +	},
> +};
> +struct platform_device mx27_camera_device = {
> +	.name = "mx2-camera",
> +	.id = 0,
> +	.num_resources = ARRAY_SIZE(mx27_camera_resources),
> +	.resource = mx27_camera_resources,
> +	.dev = {
> +		.coherent_dma_mask = 0xffffffff,
> +	},
> +};
> +#endif
> +
>  /*
>   * SPI master controller
>   *
> diff --git a/arch/arm/mach-mx2/devices.h b/arch/arm/mach-mx2/devices.h
> index 84ed513..8bdf018 100644
> --- a/arch/arm/mach-mx2/devices.h
> +++ b/arch/arm/mach-mx2/devices.h
> @@ -29,6 +29,7 @@ extern struct platform_device mxc_i2c_device1;
>  extern struct platform_device mxc_sdhc_device0;
>  extern struct platform_device mxc_sdhc_device1;
>  extern struct platform_device mxc_otg_udc_device;
> +extern struct platform_device mx27_camera_device;
>  extern struct platform_device mxc_otg_host;
>  extern struct platform_device mxc_usbh1;
>  extern struct platform_device mxc_usbh2;
> -- 
> 1.7.0
> 
>

Please amend the following to this patch to make it compile on i.MX27:
 
