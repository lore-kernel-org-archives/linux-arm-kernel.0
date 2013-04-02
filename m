From: marex@denx.de (Marek Vasut)
Date: Wed, 3 Apr 2013 01:18:42 +0200
Subject: [PATCH V2 01/12] spi/mxs: Always set LOCK_CS
In-Reply-To: <1364905195-24286-1-git-send-email-tpiepho@gmail.com>
References: <1364905195-24286-1-git-send-email-tpiepho@gmail.com>
Message-ID: <201304030118.42976.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Trent Piepho,

> There are two bits which control the CS line in the CTRL0 register:
> LOCK_CS and IGNORE_CRC.  The latter would be better named DEASSERT_CS
> in SPI mode.
> 
> LOCK_CS keeps CS asserted though the entire transfer.  This should
> always be set.  The DMA code will always set it, explicitly on the
> first segment of the first transfer, and then implicitly on all the
> rest by never clearing the bit from the value read from the ctrl0
> register.
> 
> The only reason to not set LOCK_CS would be to attempt an altered
> protocol where CS pulses between each word.  Though don't get your
> hopes up if you want to do this, as the hardware doesn't appear to do
> this in any sane manner.

Can you please elaborate on this part above? The description is very vague.

Fabio, can you review this too please?

> The code can be simplified by just setting LOCK_CS once and then not
> needing to deal with it in the PIO and DMA transfer functions.
> 
> Signed-off-by: Trent Piepho <tpiepho@gmail.com>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/spi/spi-mxs.c |    8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
> index 22a0af0..9334167 100644
> --- a/drivers/spi/spi-mxs.c
> +++ b/drivers/spi/spi-mxs.c
> @@ -91,6 +91,8 @@ static int mxs_spi_setup_transfer(struct spi_device *dev,
> 
>  	mxs_ssp_set_clk_rate(ssp, hz);
> 
> +	writel(BM_SSP_CTRL0_LOCK_CS,
> +		ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);
>  	writel(BF_SSP_CTRL1_SSP_MODE(BV_SSP_CTRL1_SSP_MODE__SPI) |
>  		     BF_SSP_CTRL1_WORD_LENGTH
>  		     (BV_SSP_CTRL1_WORD_LENGTH__EIGHT_BITS) |
> @@ -159,8 +161,6 @@ static inline void mxs_spi_enable(struct mxs_spi *spi)
>  {
>  	struct mxs_ssp *ssp = &spi->ssp;
> 
> -	writel(BM_SSP_CTRL0_LOCK_CS,
> -		ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);
>  	writel(BM_SSP_CTRL0_IGNORE_CRC,
>  		ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_CLR);
>  }
> @@ -169,8 +169,6 @@ static inline void mxs_spi_disable(struct mxs_spi *spi)
>  {
>  	struct mxs_ssp *ssp = &spi->ssp;
> 
> -	writel(BM_SSP_CTRL0_LOCK_CS,
> -		ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_CLR);
>  	writel(BM_SSP_CTRL0_IGNORE_CRC,
>  		ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);
>  }
> @@ -244,8 +242,6 @@ static int mxs_spi_txrx_dma(struct mxs_spi *spi, int
> cs, ctrl0 &= ~BM_SSP_CTRL0_XFER_COUNT;
>  	ctrl0 |= BM_SSP_CTRL0_DATA_XFER | mxs_spi_cs_to_reg(cs);
> 
> -	if (*first)
> -		ctrl0 |= BM_SSP_CTRL0_LOCK_CS;
>  	if (!write)
>  		ctrl0 |= BM_SSP_CTRL0_READ;

Best regards,
Marek Vasut
