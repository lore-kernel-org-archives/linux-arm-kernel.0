From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 19 Jun 2013 22:07:57 +0200
Subject: [PATCH v2 6/7] drivers: bus: imx-weim: Add support for
 i.MX1/21/25/27/31/35/50/51/53
In-Reply-To: <1371671678-6345-6-git-send-email-shc_work@mail.ru>
References: <1371671678-6345-1-git-send-email-shc_work@mail.ru>
 <1371671678-6345-6-git-send-email-shc_work@mail.ru>
Message-ID: <20130619200757.GC14308@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexander,

Nice work!

On Wed, Jun 19, 2013 at 11:54:37PM +0400, Alexander Shiyan wrote:
> - - fsl,weim-cs-timing:	The timing array, contains 6 timing values for the
> + - fsl,weim-cs-timing:	The timing array, contains timing values for the
>  			child node. We can get the CS index from the child
> -			node's "reg" property. This property contains the values
> -			for the registers EIM_CSnGCR1, EIM_CSnGCR2, EIM_CSnRCR1,
> +			node's "reg" property. For example, if i.MX6Q CPU
> +			is used, this property contains the values for the
> +			registers EIM_CSnGCR1, EIM_CSnGCR2, EIM_CSnRCR1,
>  			EIM_CSnRCR2, EIM_CSnWCR1, EIM_CSnWCR2 in this order.
> +			For other i.MX CPUs count of register and register
> +			names may be different.

I think here we should have a more precise description for each SoC.

>  
>  Example for an imx6q-sabreauto board, the NOR flash connected to the WEIM:
>  
> diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
> index 1f70e84..4faedc21 100644
> --- a/drivers/bus/Kconfig
> +++ b/drivers/bus/Kconfig
> @@ -8,10 +8,10 @@ config IMX_WEIM
>  	bool "Freescale EIM DRIVER"
>  	depends on ARCH_MXC
>  	help
> -	  Driver for i.MX6 WEIM controller.
> +	  Driver for i.MX WEIM controller.
>  	  The WEIM(Wireless External Interface Module) works like a bus.
>  	  You can attach many different devices on it, such as NOR, onenand.
> -	  But now, we only support the Parallel NOR.
> +	  But now, we only support the "of_physmap" driver.

This comment is wrong. In the early versions of this patch indeed only
parallel NOR was supported, but now there is no limitation on the device
type anymore.

>  
>  config MVEBU_MBUS
>  	bool
> diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
> index b6479fb..77fa1d4 100644
> --- a/drivers/bus/imx-weim.c
> +++ b/drivers/bus/imx-weim.c
> @@ -17,6 +17,17 @@ struct imx_weim_devtype {
>  	unsigned int	cs_regs_count;
>  	unsigned int	cs_stride;
>  };
> +static const struct imx_weim_devtype imx1_weim_devtype = {
> +	.cs_count	= 6,
> +	.cs_regs_count	= 2,
> +	.cs_stride	= 0x08,
> +};
> +
> +static const struct imx_weim_devtype imx25_weim_devtype = {
> +	.cs_count	= 6,
> +	.cs_regs_count	= 3,
> +	.cs_stride	= 0x10,
> +};
>  
>  static const struct imx_weim_devtype imx50_weim_devtype = {
>  	.cs_count	= 4,
> @@ -24,9 +35,21 @@ static const struct imx_weim_devtype imx50_weim_devtype = {
>  	.cs_stride	= 0x18,
>  };
>  
> +static const struct imx_weim_devtype imx51_weim_devtype = {
> +	.cs_count	= 6,
> +	.cs_regs_count	= 6,
> +	.cs_stride	= 0x18,
> +};
> +
>  static const struct of_device_id weim_id_table[] = {
> +	/* i.MX1/21 */
> +	{ .compatible = "fsl,imx1-weim", .data = &imx1_weim_devtype, },
> +	/* i.MX25/27/31/35 */
> +	{ .compatible = "fsl,imx25-weim", .data = &imx25_weim_devtype, },

We usually name the compatible name after the oldest i.MX supporting
this IP, not after the lowest number. So this should be imx27, not
imx25.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
