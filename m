From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 24 Aug 2011 10:18:31 +0200
Subject: [PATCH 1/2] ARM: imx: Add PATA resources for other i.MX processors
In-Reply-To: <1314130687-27523-1-git-send-email-fabio.estevam@freescale.com>
References: <1314130687-27523-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20110824081831.GW31404@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2011 at 05:18:06PM -0300, Fabio Estevam wrote:
> MX27/31/35/53 also have PATA block. 
> 
> Add PATA resources for them.

Applied for next.

Sascha

> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> 
> In order to avoid breaking MX51 PATA support the following patch is needed:
> http://git.pengutronix.de/?p=imx/linux-2.6.git;a=commitdiff;h=1a1952779b8e92a404dceaecca70ba120bea2d94
> 
>  arch/arm/plat-mxc/devices/platform-pata_imx.c   |   29 +++++++++++++++++++---
>  arch/arm/plat-mxc/include/mach/devices-common.h |    1 +
>  arch/arm/plat-mxc/include/mach/mx35.h           |    2 +-
>  3 files changed, 27 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/devices/platform-pata_imx.c b/arch/arm/plat-mxc/devices/platform-pata_imx.c
> index c1cbaf9..b67ad9e 100644
> --- a/arch/arm/plat-mxc/devices/platform-pata_imx.c
> +++ b/arch/arm/plat-mxc/devices/platform-pata_imx.c
> @@ -6,24 +6,45 @@
>  #include <mach/hardware.h>
>  #include <mach/devices-common.h>
>  
> -#define imx_pata_imx_data_entry_single(soc)				\
> +#define imx_pata_imx_data_entry_single(soc, _size)			\
>  	{								\
>  		.iobase = soc ## _ATA_BASE_ADDR,			\
> -		.irq = soc ## _MXC_INT_ATA,				\
> +		.iosize = _size,					\
> +		.irq = soc ## _INT_ATA,					\
>  	}
>  
> +#ifdef CONFIG_SOC_IMX27
> +const struct imx_pata_imx_data imx27_pata_imx_data __initconst =
> +	imx_pata_imx_data_entry_single(MX27, SZ_4K);
> +#endif /* ifdef CONFIG_SOC_IMX27 */
> +
> +#ifdef CONFIG_SOC_IMX31
> +const struct imx_pata_imx_data imx31_pata_imx_data __initconst =
> +	imx_pata_imx_data_entry_single(MX31, SZ_16K);
> +#endif /* ifdef CONFIG_SOC_IMX31 */
> +
> +#ifdef CONFIG_SOC_IMX35
> +const struct imx_pata_imx_data imx35_pata_imx_data __initconst =
> +	imx_pata_imx_data_entry_single(MX35, SZ_16K);
> +#endif /* ifdef CONFIG_SOC_IMX35 */
> +
>  #ifdef CONFIG_SOC_IMX51
>  const struct imx_pata_imx_data imx51_pata_imx_data __initconst =
> -	imx_pata_imx_data_entry_single(MX51);
> +	imx_pata_imx_data_entry_single(MX51, SZ_16K);
>  #endif /* ifdef CONFIG_SOC_IMX51 */
>  
> +#ifdef CONFIG_SOC_IMX53
> +const struct imx_pata_imx_data imx53_pata_imx_data __initconst =
> +	imx_pata_imx_data_entry_single(MX53, SZ_16K);
> +#endif /* ifdef CONFIG_SOC_IMX53 */
> +
>  struct platform_device *__init imx_add_pata_imx(
>  		const struct imx_pata_imx_data *data)
>  {
>  	struct resource res[] = {
>  		{
>  			.start = data->iobase,
> -			.end = data->iobase + SZ_16K - 1,
> +			.end = data->iobase + data->iobase - 1,
>  			.flags = IORESOURCE_MEM,
>  		},
>  		{
> diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
> index 1b76c67..4cbad45 100644
> --- a/arch/arm/plat-mxc/include/mach/devices-common.h
> +++ b/arch/arm/plat-mxc/include/mach/devices-common.h
> @@ -253,6 +253,7 @@ struct platform_device *__init imx_add_mxc_nand(
>  
>  struct imx_pata_imx_data {
>  	resource_size_t iobase;
> +	resource_size_t iosize;
>  	resource_size_t irq;
>  };
>  struct platform_device *__init imx_add_pata_imx(
> diff --git a/arch/arm/plat-mxc/include/mach/mx35.h b/arch/arm/plat-mxc/include/mach/mx35.h
> index d13dbfe..80965a9 100644
> --- a/arch/arm/plat-mxc/include/mach/mx35.h
> +++ b/arch/arm/plat-mxc/include/mach/mx35.h
> @@ -36,7 +36,7 @@
>  #define MX35_UART3_BASE_ADDR			(MX35_SPBA0_BASE_ADDR + 0x0c000)
>  #define MX35_CSPI2_BASE_ADDR			(MX35_SPBA0_BASE_ADDR + 0x10000)
>  #define MX35_SSI2_BASE_ADDR			(MX35_SPBA0_BASE_ADDR + 0x14000)
> -#define MX35_ATA_DMA_BASE_ADDR			(MX35_SPBA0_BASE_ADDR + 0x20000)
> +#define MX35_ATA_BASE_ADDR			(MX35_SPBA0_BASE_ADDR + 0x20000)
>  #define MX35_MSHC1_BASE_ADDR			(MX35_SPBA0_BASE_ADDR + 0x24000)
>  #define MX35_FEC_BASE_ADDR		0x50038000
>  #define MX35_SPBA_CTRL_BASE_ADDR		(MX35_SPBA0_BASE_ADDR + 0x3c000)
> -- 
> 1.6.0.4
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
