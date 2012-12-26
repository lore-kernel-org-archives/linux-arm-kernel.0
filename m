From: marex@denx.de (Marek Vasut)
Date: Wed, 26 Dec 2012 06:06:26 +0100
Subject: [PATCH] mxs: spi: clear XFER_LEN in CTRL0 register during DMA
In-Reply-To: <1356498088-31176-1-git-send-email-juha.lumme@gmail.com>
References: <1356498088-31176-1-git-send-email-juha.lumme@gmail.com>
Message-ID: <201212260606.26770.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Juha Lumme,

> On MX23 the XFER_LEN

XFER_COUNT ;-)

> part in CTRL0 register was improperly OR'd

... during construction of DMA descriptor chain. Instead of being freshly set.

> , and
> because of that too many characters

Bytes

> were being expected from SPI.

expected from SPI during the last DMA cycle.

> This caused a timeout (SSP_TIMEOUT) to happen in the last package

... during the processing of the last DMA descriptor ...

> in the
> DMA chain, and resulted into a corrupted read.

Write too, really ;-)

> This is a workaround for the problem

This is actually a correct fix for the issue.

> , by clearing the XFER_LEN bytes always
> before reading the new size for XFER_LEN.

before setting new XFER_COUNT into the ctrl0 field of DMA control transfer.

> Cc: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org
> Signed-off-by: Juha Lumme <juha.lumme@gmail.com>

All but the commit message,

Acked-by: Marek Vasut <marex@denx.de>

> ---
>  drivers/spi/spi-mxs.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
> index 86dd04d..265c33f 100644
> --- a/drivers/spi/spi-mxs.c
> +++ b/drivers/spi/spi-mxs.c
> @@ -241,6 +241,7 @@ static int mxs_spi_txrx_dma(struct mxs_spi *spi, int
> cs, INIT_COMPLETION(spi->c);
> 
>  	ctrl0 = readl(ssp->base + HW_SSP_CTRL0);
> +	ctrl0 &= ~BM_SSP_CTRL0_XFER_COUNT;
>  	ctrl0 |= BM_SSP_CTRL0_DATA_XFER | mxs_spi_cs_to_reg(cs);
> 
>  	if (*first)
> @@ -256,8 +257,10 @@ static int mxs_spi_txrx_dma(struct mxs_spi *spi, int
> cs, if ((sg_count + 1 == sgs) && *last)
>  			ctrl0 |= BM_SSP_CTRL0_IGNORE_CRC;
> 
> -		if (ssp->devid == IMX23_SSP)
> +		if (ssp->devid == IMX23_SSP) {
> +			ctrl0 &= ~BM_SSP_CTRL0_XFER_COUNT;
>  			ctrl0 |= min;
> +		}
> 
>  		dma_xfer[sg_count].pio[0] = ctrl0;
>  		dma_xfer[sg_count].pio[3] = min;

Best regards,
Marek Vasut
