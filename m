From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 3 Aug 2012 12:07:11 +0200
Subject: [PATCH v2 2/3] mtd: nand: Let MTD_NAND_GPMI_NAND depend on MXS_DMA
In-Reply-To: <1343215100-24005-2-git-send-email-festevam@gmail.com>
References: <1343215100-24005-1-git-send-email-festevam@gmail.com>
 <1343215100-24005-2-git-send-email-festevam@gmail.com>
Message-ID: <20120803100711.GC24458@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 25, 2012 at 08:18:19AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> MTD_NAND_GPMI_NAND driver depends on MXS_DMA to be selected, otherwise the following error happens
> for imx_v6_v7_defconfig:
> 
> drivers/built-in.o: In function `gpmi_dma_filter':
> clk-fixed-factor.c:(.text+0xb124c): undefined reference to `mxs_dma_is_apbh'
> make: *** [vmlinux] Error 1
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

As mentioned elsewhere in this thread: We should not select user visible
options, so this patch is the only thing we can do atm (apart from
'fixing the tools' as David mentioned, but this is out of scope for an
-rc kernel)

Additionally the imx_v6_v7_defconfig should be adjusted so that the gpmi
nand driver actually gets built.

Sascha

> ---
> Changes since v1:
> - Use 'depends' rather than 'select'
>  drivers/mtd/nand/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> index a5d8a1b..da52c7d 100644
> --- a/drivers/mtd/nand/Kconfig
> +++ b/drivers/mtd/nand/Kconfig
> @@ -463,6 +463,7 @@ config MTD_NAND_NANDSIM
>  config MTD_NAND_GPMI_NAND
>          bool "GPMI NAND Flash Controller driver"
>          depends on MTD_NAND && (SOC_IMX23 || SOC_IMX28 || SOC_IMX6Q)
> +	depends on MXS_DMA
>          help
>  	 Enables NAND Flash support for IMX23, IMX28 or IMX6.
>  	 The GPMI controller is very powerful, with the help of BCH
> -- 
> 1.7.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
