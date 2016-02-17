From: xhnjupt@gmail.com (Han Xu)
Date: Thu, 18 Feb 2016 01:14:36 +0800
Subject: [PATCH v4 2/7] mtd: spi-nor: fsl-quadspi: add support for ls1021a
In-Reply-To: <1453793041-35868-2-git-send-email-yao.yuan@freescale.com>
References: <1453793041-35868-1-git-send-email-yao.yuan@freescale.com>
 <1453793041-35868-2-git-send-email-yao.yuan@freescale.com>
Message-ID: <20160217171436.GC16812@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2016 at 03:23:56PM +0800, Yuan Yao wrote:
> LS1021a also support Freescale Quad SPI controller.
> Add fsl-quadspi support for ls1021a chip and make SPI_FSL_QUADSPI
> selectable for LS1021A SOC hardwares.
> 
> Signed-off-by: Yuan Yao <yao.yuan@nxp.com>
> Acked-by: Han xu <han.xu@freescale.com>
> ---
> Changed in v4:
> No changes.
> 
> Changed in v3:
> No changes.
> 
> Changed in v2:
> Update my email to <yao.yuan@nxp.com>
> ---
>  drivers/mtd/spi-nor/Kconfig       |  2 +-
>  drivers/mtd/spi-nor/fsl-quadspi.c | 10 ++++++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/Kconfig b/drivers/mtd/spi-nor/Kconfig
> index 0dc9275..a28c278 100644
> --- a/drivers/mtd/spi-nor/Kconfig
> +++ b/drivers/mtd/spi-nor/Kconfig
> @@ -30,7 +30,7 @@ config MTD_SPI_NOR_USE_4K_SECTORS
>  
>  config SPI_FSL_QUADSPI
>  	tristate "Freescale Quad SPI controller"
> -	depends on ARCH_MXC || COMPILE_TEST
> +	depends on ARCH_MXC || SOC_LS1021A || COMPILE_TEST
>  	depends on HAS_IOMEM
>  	help
>  	  This enables support for the Quad SPI controller in master mode.
> diff --git a/drivers/mtd/spi-nor/fsl-quadspi.c b/drivers/mtd/spi-nor/fsl-quadspi.c
> index 04e8a93..9ab2b51 100644
> --- a/drivers/mtd/spi-nor/fsl-quadspi.c
> +++ b/drivers/mtd/spi-nor/fsl-quadspi.c
> @@ -213,6 +213,7 @@ enum fsl_qspi_devtype {
>  	FSL_QUADSPI_IMX6SX,
>  	FSL_QUADSPI_IMX7D,
>  	FSL_QUADSPI_IMX6UL,
> +	FSL_QUADSPI_LS1021A,
>  };
>  
>  struct fsl_qspi_devtype_data {
> @@ -258,6 +259,14 @@ static struct fsl_qspi_devtype_data imx6ul_data = {
>  		       | QUADSPI_QUIRK_4X_INT_CLK,
>  };
>  
> +static struct fsl_qspi_devtype_data ls1021a_data = {
> +	.devtype = FSL_QUADSPI_LS1021A,
> +	.rxfifo = 128,
> +	.txfifo = 64,
> +	.ahb_buf_size = 1024,
> +	.driver_data = 0,
> +};
> +
>  #define FSL_QSPI_MAX_CHIP	4
>  struct fsl_qspi {
>  	struct spi_nor nor[FSL_QSPI_MAX_CHIP];
> @@ -812,6 +821,7 @@ static const struct of_device_id fsl_qspi_dt_ids[] = {
>  	{ .compatible = "fsl,imx6sx-qspi", .data = (void *)&imx6sx_data, },
>  	{ .compatible = "fsl,imx7d-qspi", .data = (void *)&imx7d_data, },
>  	{ .compatible = "fsl,imx6ul-qspi", .data = (void *)&imx6ul_data, },
> +	{ .compatible = "fsl,ls1021a-qspi", .data = (void *)&ls1021a_data, },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, fsl_qspi_dt_ids);
> -- 
> 2.1.0.27.g96db324
> 
Acked-by: Han xu <han.xu@nxp.com>
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
