From: marex@denx.de (Marek Vasut)
Date: Tue, 2 Apr 2013 01:18:27 +0200
Subject: [PATCH 5/5] spi/mxs: Fix multiple slave bug and don't set clock
 for each xfer
In-Reply-To: <1364570381-17605-5-git-send-email-tpiepho@gmail.com>
References: <1364570381-17605-1-git-send-email-tpiepho@gmail.com>
 <1364570381-17605-5-git-send-email-tpiepho@gmail.com>
Message-ID: <201304020118.27575.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Trent Piepho,

> Despite many warnings in the SPI documentation and code, the spi-mxs
> driver sets shared chip registers in the ->setup method.  This method can
> be called when transfers are in progress on other slaves controlled by the
> master.  Setting registers or any other shared state will corrupt those
> transfers.
> 
> So fix mxs_spi_setup() to not call mxs_spi_setup_transfer().
> 
> Now that mxs_spi_setup_transfer() won't be called with a NULL transfer,
> since it's only purpose is to setup a transfer, the code can be
> simplified.
> 
> mxs_spi_setup_transfer() would set the SSP SCK rate every time it was
> called, which is before each transfer.  It is uncommon for the SCK rate to
> change between transfers and this causes unnecessary reprogramming of the
> clock registers.  Changed to only set the rate when it has changed.
> 
> This significantly speeds up short SPI messages, especially messages made
> up of many transfers.  On an iMX287, using spidev with messages that
> consist of 511 transfers of 4 bytes each at an SCK of 48 MHz, the
> effective transfer rate more than doubles from about 290 KB/sec to 600
> KB/sec.

This patch is full of unrelated changes, the relevant parts are not clear. 
Please clean up and resubmit with only the relevant changes.

> Signed-off-by: Trent Piepho <tpiepho@gmail.com>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/spi/spi-mxs.c |   54
> ++++++++++++++++++++++++------------------------- 1 file changed, 26
> insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
> index fc52f78..b60baab 100644
> --- a/drivers/spi/spi-mxs.c
> +++ b/drivers/spi/spi-mxs.c
> @@ -66,44 +66,47 @@
>  struct mxs_spi {
>  	struct mxs_ssp		ssp;
>  	struct completion	c;
> +	unsigned int		sck;	/* Rate requested (vs actual) */
>  };
> 
>  static int mxs_spi_setup_transfer(struct spi_device *dev,
> -				struct spi_transfer *t)
> +				  const struct spi_transfer *t)
>  {
>  	struct mxs_spi *spi = spi_master_get_devdata(dev->master);
>  	struct mxs_ssp *ssp = &spi->ssp;
> -	uint8_t bits_per_word;
> -	uint32_t hz = 0;
> -
> -	bits_per_word = dev->bits_per_word;
> -	if (t && t->bits_per_word)
> -		bits_per_word = t->bits_per_word;
> +	const unsigned int bits_per_word = t->bits_per_word ? :
> dev->bits_per_word; +	const unsigned int hz = t->speed_hz ?
> min(dev->max_speed_hz, t->speed_hz) : +					      
dev->max_speed_hz;
> 
>  	if (bits_per_word != 8) {
> -		dev_err(&dev->dev, "%s, unsupported bits_per_word=%d\n",
> -					__func__, bits_per_word);
> +		dev_err(&dev->dev, "Unsupported bits per word of %d\n",
> +			bits_per_word);
>  		return -EINVAL;
>  	}
> 
> -	hz = dev->max_speed_hz;
> -	if (t && t->speed_hz)
> -		hz = min(hz, t->speed_hz);
>  	if (hz == 0) {
> -		dev_err(&dev->dev, "Cannot continue with zero clock\n");
> +		dev_err(&dev->dev, "SPI clock rate of zero not possible\n");
>  		return -EINVAL;
>  	}
> 
> -	mxs_ssp_set_clk_rate(ssp, hz);
> +	if (hz != spi->sck) {
> +		mxs_ssp_set_clk_rate(ssp, hz);
> +		/* Save requested value, not actual value from ssp->clk_rate.
> +		 * Otherwise we would set the rate again each trasfer when
> +		 * actual is not quite the same as requested.  */
> +		spi->sck = hz;
> +		/* Perhaps we should return an error if the actual clock is
> +		 * nowhere close? */
> +	}
> 
>  	writel(BM_SSP_CTRL0_LOCK_CS,
>  		ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);
> +
>  	writel(BF_SSP_CTRL1_SSP_MODE(BV_SSP_CTRL1_SSP_MODE__SPI) |
> -		     BF_SSP_CTRL1_WORD_LENGTH
> -		     (BV_SSP_CTRL1_WORD_LENGTH__EIGHT_BITS) |
> -		     ((dev->mode & SPI_CPOL) ? BM_SSP_CTRL1_POLARITY : 0) |
> -		     ((dev->mode & SPI_CPHA) ? BM_SSP_CTRL1_PHASE : 0),
> -		     ssp->base + HW_SSP_CTRL1(ssp));
> +	       BF_SSP_CTRL1_WORD_LENGTH(BV_SSP_CTRL1_WORD_LENGTH__EIGHT_BITS) |
> +	       ((dev->mode & SPI_CPOL) ? BM_SSP_CTRL1_POLARITY : 0) |
> +	       ((dev->mode & SPI_CPHA) ? BM_SSP_CTRL1_PHASE : 0),
> +	       ssp->base + HW_SSP_CTRL1(ssp));
> 
>  	writel(0x0, ssp->base + HW_SSP_CMD0);
>  	writel(0x0, ssp->base + HW_SSP_CMD1);
> @@ -113,21 +116,16 @@ static int mxs_spi_setup_transfer(struct spi_device
> *dev,
> 
>  static int mxs_spi_setup(struct spi_device *dev)
>  {
> -	int err = 0;
> -
>  	if (!dev->bits_per_word)
>  		dev->bits_per_word = 8;
> 
> -	if (dev->mode & ~(SPI_CPOL | SPI_CPHA))
> +	if (dev->bits_per_word != 8)
>  		return -EINVAL;
> 
> -	err = mxs_spi_setup_transfer(dev, NULL);
> -	if (err) {
> -		dev_err(&dev->dev,
> -			"Failed to setup transfer, error = %d\n", err);
> -	}
> +	if (dev->mode & ~(SPI_CPOL | SPI_CPHA))
> +		return -EINVAL;
> 
> -	return err;
> +	return 0;
>  }
> 
>  static u32 mxs_spi_cs_to_reg(unsigned cs)

Best regards,
Marek Vasut
