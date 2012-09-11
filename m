From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 11 Sep 2012 11:47:48 +0200
Subject: [PATCH v2] ARM : i.MX27 : split code for allocation of
 ressources of camera and eMMA
In-Reply-To: <1346843175-4166-1-git-send-email-gcembed@gmail.com>
References: <1346843175-4166-1-git-send-email-gcembed@gmail.com>
Message-ID: <20120911094748.GS18243@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

Since you worked in this area recently, can I have your Ack on this?

As a side note: Please be prepared that all this should be removed in
the not-so-far future. It would be good if you start converting your
boards to devicetree soon. You may be doing so internally already, I
don't know.

Thanks
 Sascha

On Wed, Sep 05, 2012 at 01:06:15PM +0200, Ga?tan Carlier wrote:
> Hi,
> This is to prepare addition of m2m-emmapp driver otherwise
>  IMX_HAVE_PLATFORM_MX2_CAMERA must be declared even if only Post-Processor
> is needed.
> 
> IMX_HAVE_PLATFORM_MX2_EMMA define has been added.
> 
> Changes since v1:
>  - Add "select IMX_HAVE_PLATFORM_MX2_EMMA" for MACH_IMX27_VISSTRIM_M10 platform
>    due to pending patch in linux-media tree that will call
>    imx27_add_mx2_emmaprp().
> 
> Signed-off-by: Ga?tan Carlier <gcembed@gmail.com>
> ---
>  arch/arm/mach-imx/Kconfig                       |    1 +
>  arch/arm/mach-imx/devices-imx27.h               |    4 ++-
>  arch/arm/plat-mxc/devices/Kconfig               |    3 ++
>  arch/arm/plat-mxc/devices/Makefile              |    1 +
>  arch/arm/plat-mxc/devices/platform-mx2-camera.c |   17 ---------
>  arch/arm/plat-mxc/devices/platform-mx2-emma.c   |   41 +++++++++++++++++++++++
>  arch/arm/plat-mxc/include/mach/devices-common.h |    9 ++++-
>  7 files changed, 57 insertions(+), 19 deletions(-)
>  create mode 100644 arch/arm/plat-mxc/devices/platform-mx2-emma.c
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index afd542a..c2984d7 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -322,6 +322,7 @@ config MACH_IMX27_VISSTRIM_M10
>  	select IMX_HAVE_PLATFORM_IMX_SSI
>  	select IMX_HAVE_PLATFORM_IMX_UART
>  	select IMX_HAVE_PLATFORM_MX2_CAMERA
> +	select IMX_HAVE_PLATFORM_MX2_EMMA
>  	select IMX_HAVE_PLATFORM_MXC_EHCI
>  	select IMX_HAVE_PLATFORM_MXC_MMC
>  	select LEDS_GPIO_REGISTER
> diff --git a/arch/arm/mach-imx/devices-imx27.h b/arch/arm/mach-imx/devices-imx27.h
> index 0482293..d8eb4a0 100644
> --- a/arch/arm/mach-imx/devices-imx27.h
> +++ b/arch/arm/mach-imx/devices-imx27.h
> @@ -54,8 +54,10 @@ extern const struct imx_imx_uart_1irq_data imx27_imx_uart_data[];
>  extern const struct imx_mx2_camera_data imx27_mx2_camera_data;
>  #define imx27_add_mx2_camera(pdata)	\
>  	imx_add_mx2_camera(&imx27_mx2_camera_data, pdata)
> +
> +extern const struct imx_mx2_emma_data imx27_mx2_emmaprp_data;
>  #define imx27_add_mx2_emmaprp()	\
> -	imx_add_mx2_emmaprp(&imx27_mx2_camera_data)
> +	imx_add_mx2_emmaprp(&imx27_mx2_emmaprp_data)
>  
>  extern const struct imx_mxc_ehci_data imx27_mxc_ehci_otg_data;
>  #define imx27_add_mxc_ehci_otg(pdata)	\
> diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/devices/Kconfig
> index 6b46cee..96feef7 100644
> --- a/arch/arm/plat-mxc/devices/Kconfig
> +++ b/arch/arm/plat-mxc/devices/Kconfig
> @@ -56,6 +56,9 @@ config IMX_HAVE_PLATFORM_MX1_CAMERA
>  config IMX_HAVE_PLATFORM_MX2_CAMERA
>  	bool
>  
> +config IMX_HAVE_PLATFORM_MX2_EMMA
> +	bool
> +
>  config IMX_HAVE_PLATFORM_MXC_EHCI
>  	bool
>  
> diff --git a/arch/arm/plat-mxc/devices/Makefile b/arch/arm/plat-mxc/devices/Makefile
> index 76f3195..7292c1f 100644
> --- a/arch/arm/plat-mxc/devices/Makefile
> +++ b/arch/arm/plat-mxc/devices/Makefile
> @@ -28,3 +28,4 @@ obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_W1) += platform-mxc_w1.o
>  obj-$(CONFIG_IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX) += platform-sdhci-esdhc-imx.o
>  obj-$(CONFIG_IMX_HAVE_PLATFORM_SPI_IMX) +=  platform-spi_imx.o
>  obj-$(CONFIG_IMX_HAVE_PLATFORM_AHCI) +=  platform-ahci-imx.o
> +obj-$(CONFIG_IMX_HAVE_PLATFORM_MX2_EMMA) += platform-mx2-emma.o
> diff --git a/arch/arm/plat-mxc/devices/platform-mx2-camera.c b/arch/arm/plat-mxc/devices/platform-mx2-camera.c
> index 11eace9..11c688f 100644
> --- a/arch/arm/plat-mxc/devices/platform-mx2-camera.c
> +++ b/arch/arm/plat-mxc/devices/platform-mx2-camera.c
> @@ -63,20 +63,3 @@ struct platform_device *__init imx_add_mx2_camera(
>  			pdata, sizeof(*pdata), DMA_BIT_MASK(32));
>  }
>  
> -struct platform_device *__init imx_add_mx2_emmaprp(
> -		const struct imx_mx2_camera_data *data)
> -{
> -	struct resource res[] = {
> -		{
> -			.start = data->iobaseemmaprp,
> -			.end = data->iobaseemmaprp + data->iosizeemmaprp - 1,
> -			.flags = IORESOURCE_MEM,
> -		}, {
> -			.start = data->irqemmaprp,
> -			.end = data->irqemmaprp,
> -			.flags = IORESOURCE_IRQ,
> -		},
> -	};
> -	return imx_add_platform_device_dmamask("m2m-emmaprp", 0,
> -			res, 2, NULL, 0, DMA_BIT_MASK(32));
> -}
> diff --git a/arch/arm/plat-mxc/devices/platform-mx2-emma.c b/arch/arm/plat-mxc/devices/platform-mx2-emma.c
> new file mode 100644
> index 0000000..a51749a
> --- /dev/null
> +++ b/arch/arm/plat-mxc/devices/platform-mx2-emma.c
> @@ -0,0 +1,41 @@
> +/*
> + * Copyright (C) 2010 Pengutronix
> + * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
> + *
> + * This program is free software; you can redistribute it and/or modify it under
> + * the terms of the GNU General Public License version 2 as published by the
> + * Free Software Foundation.
> + */
> +#include <mach/hardware.h>
> +#include <mach/devices-common.h>
> +
> +#define imx_mx2_emmaprp_data_entry_single(soc)				\
> +	{								\
> +		.iobase = soc ## _EMMAPRP_BASE_ADDR,			\
> +		.iosize = SZ_32,					\
> +		.irq = soc ## _INT_EMMAPRP,				\
> +	}
> +
> +#ifdef CONFIG_SOC_IMX27
> +const struct imx_mx2_emma_data imx27_mx2_emmaprp_data __initconst =
> +	imx_mx2_emmaprp_data_entry_single(MX27);
> +#endif /* ifdef CONFIG_SOC_IMX27 */
> +
> +struct platform_device *__init imx_add_mx2_emmaprp(
> +		const struct imx_mx2_emma_data *data)
> +{
> +	struct resource res[] = {
> +		{
> +			.start = data->iobase,
> +			.end = data->iobase + data->iosize - 1,
> +			.flags = IORESOURCE_MEM,
> +		}, {
> +			.start = data->irq,
> +			.end = data->irq,
> +			.flags = IORESOURCE_IRQ,
> +		},
> +	};
> +	return imx_add_platform_device_dmamask("m2m-emmaprp", 0,
> +			res, 2, NULL, 0, DMA_BIT_MASK(32));
> +}
> +
> diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
> index 762780c..2117072 100644
> --- a/arch/arm/plat-mxc/include/mach/devices-common.h
> +++ b/arch/arm/plat-mxc/include/mach/devices-common.h
> @@ -229,8 +229,15 @@ struct imx_mx2_camera_data {
>  struct platform_device *__init imx_add_mx2_camera(
>  		const struct imx_mx2_camera_data *data,
>  		const struct mx2_camera_platform_data *pdata);
> +
> +
> +struct imx_mx2_emma_data {
> +	resource_size_t iobase;
> +	resource_size_t iosize;
> +	resource_size_t irq;
> +};
>  struct platform_device *__init imx_add_mx2_emmaprp(
> -		const struct imx_mx2_camera_data *data);
> +		const struct imx_mx2_emma_data *data);
>  
>  #include <mach/mxc_ehci.h>
>  struct imx_mxc_ehci_data {
> -- 
> 1.7.7.4
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
