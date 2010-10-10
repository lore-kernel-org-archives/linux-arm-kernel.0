From: grant.likely@secretlab.ca (Grant Likely)
Date: Sun, 10 Oct 2010 01:01:42 -0600
Subject: [PATCH] spi/pl022: fix dubious allocation staticize platform data
In-Reply-To: <1285932793-30431-1-git-send-email-linus.walleij@stericsson.com>
References: <1285932793-30431-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20101010070142.GC1227@angua.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 01, 2010 at 01:33:13PM +0200, Linus Walleij wrote:
> This removes some dubious allocation of a local chipinfo struct
> in favor of a constant preset, tagging that one const revealed
> further problems with platform data being modified so fixed up
> these too.
> 
> Reported-by: Virupax Sadashivpetimath <virupax.sadashivpetimath@stericsson.com>
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>

Applied, thanks.  I've pushed this out to my next-spi branch[1].
Please take a look and make sure everything has been applied
correctly.

[1] git://git.secretlab.ca/git/linux-2.6 next-spi

g.

> ---
> Note: this is based on top of the previous patch for fixing
> the device pointer issue, which is in turn based on Kevins
> modebits patch.
> ---
>  drivers/spi/amba-pl022.c |   96 ++++++++++++++++++++++------------------------
>  1 files changed, 46 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
> index b01ee5b..8a0b9eb 100644
> --- a/drivers/spi/amba-pl022.c
> +++ b/drivers/spi/amba-pl022.c
> @@ -1593,7 +1593,7 @@ static int destroy_queue(struct pl022 *pl022)
>  }
>  
>  static int verify_controller_parameters(struct pl022 *pl022,
> -					struct pl022_config_chip *chip_info)
> +				struct pl022_config_chip const *chip_info)
>  {
>  	if ((chip_info->iface < SSP_INTERFACE_MOTOROLA_SPI)
>  	    || (chip_info->iface > SSP_INTERFACE_UNIDIRECTIONAL)) {
> @@ -1614,12 +1614,6 @@ static int verify_controller_parameters(struct pl022 *pl022,
>  			"hierarchy is configured incorrectly\n");
>  		return -EINVAL;
>  	}
> -	if (((chip_info->clk_freq).cpsdvsr < CPSDVR_MIN)
> -	    || ((chip_info->clk_freq).cpsdvsr > CPSDVR_MAX)) {
> -		dev_err(&pl022->adev->dev,
> -			"cpsdvsr is configured incorrectly\n");
> -		return -EINVAL;
> -	}
>  	if ((chip_info->com_mode != INTERRUPT_TRANSFER)
>  	    && (chip_info->com_mode != DMA_TRANSFER)
>  	    && (chip_info->com_mode != POLLING_TRANSFER)) {
> @@ -1670,11 +1664,6 @@ static int verify_controller_parameters(struct pl022 *pl022,
>  			return -EINVAL;
>  		}
>  	}
> -	if (chip_info->cs_control == NULL) {
> -		dev_warn(&pl022->adev->dev,
> -			"Chip Select Function is NULL for this chip\n");
> -		chip_info->cs_control = null_cs_control;
> -	}
>  	return 0;
>  }
>  
> @@ -1774,6 +1763,25 @@ static int calculate_effective_freq(struct pl022 *pl022,
>  	return 0;
>  }
>  
> +
> +/*
> + * A piece of default chip info unless the platform
> + * supplies it.
> + */
> +static const struct pl022_config_chip pl022_default_chip_info = {
> +	.com_mode = POLLING_TRANSFER,
> +	.iface = SSP_INTERFACE_MOTOROLA_SPI,
> +	.hierarchy = SSP_SLAVE,
> +	.slave_tx_disable = DO_NOT_DRIVE_TX,
> +	.rx_lev_trig = SSP_RX_1_OR_MORE_ELEM,
> +	.tx_lev_trig = SSP_TX_1_OR_MORE_EMPTY_LOC,
> +	.ctrl_len = SSP_BITS_8,
> +	.wait_state = SSP_MWIRE_WAIT_ZERO,
> +	.duplex = SSP_MICROWIRE_CHANNEL_FULL_DUPLEX,
> +	.cs_control = null_cs_control,
> +};
> +
> +
>  /**
>   * pl022_setup - setup function registered to SPI master framework
>   * @spi: spi device which is requesting setup
> @@ -1788,8 +1796,9 @@ static int calculate_effective_freq(struct pl022 *pl022,
>   */
>  static int pl022_setup(struct spi_device *spi)
>  {
> -	struct pl022_config_chip *chip_info;
> +	struct pl022_config_chip const *chip_info;
>  	struct chip_data *chip;
> +	struct ssp_clock_params clk_freq;
>  	int status = 0;
>  	struct pl022 *pl022 = spi_master_get_devdata(spi->master);
>  	unsigned int bits = spi->bits_per_word;
> @@ -1816,40 +1825,13 @@ static int pl022_setup(struct spi_device *spi)
>  	chip_info = spi->controller_data;
>  
>  	if (chip_info == NULL) {
> +		chip_info = &pl022_default_chip_info;
>  		/* spi_board_info.controller_data not is supplied */
>  		dev_dbg(&spi->dev,
>  			"using default controller_data settings\n");
> -
> -		chip_info =
> -			kzalloc(sizeof(struct pl022_config_chip), GFP_KERNEL);
> -
> -		if (!chip_info) {
> -			dev_err(&spi->dev,
> -				"cannot allocate controller data\n");
> -			status = -ENOMEM;
> -			goto err_first_setup;
> -		}
> -
> -		dev_dbg(&spi->dev, "allocated memory for controller data\n");
> -
> -		/*
> -		 * Set controller data default values:
> -		 * Polling is supported by default
> -		 */
> -		chip_info->com_mode = POLLING_TRANSFER;
> -		chip_info->iface = SSP_INTERFACE_MOTOROLA_SPI;
> -		chip_info->hierarchy = SSP_SLAVE;
> -		chip_info->slave_tx_disable = DO_NOT_DRIVE_TX;
> -		chip_info->rx_lev_trig = SSP_RX_1_OR_MORE_ELEM;
> -		chip_info->tx_lev_trig = SSP_TX_1_OR_MORE_EMPTY_LOC;
> -		chip_info->ctrl_len = SSP_BITS_8;
> -		chip_info->wait_state = SSP_MWIRE_WAIT_ZERO;
> -		chip_info->duplex = SSP_MICROWIRE_CHANNEL_FULL_DUPLEX;
> -		chip_info->cs_control = null_cs_control;
> -	} else {
> +	} else
>  		dev_dbg(&spi->dev,
>  			"using user supplied controller_data settings\n");
> -	}
>  
>  	/*
>  	 * We can override with custom divisors, else we use the board
> @@ -1859,22 +1841,37 @@ static int pl022_setup(struct spi_device *spi)
>  	    && (0 == chip_info->clk_freq.scr)) {
>  		status = calculate_effective_freq(pl022,
>  						  spi->max_speed_hz,
> -						  &chip_info->clk_freq);
> +						  &clk_freq);
>  		if (status < 0)
>  			goto err_config_params;
>  	} else {
> -		if ((chip_info->clk_freq.cpsdvsr % 2) != 0)
> -			chip_info->clk_freq.cpsdvsr =
> -				chip_info->clk_freq.cpsdvsr - 1;
> +		memcpy(&clk_freq, &chip_info->clk_freq, sizeof(clk_freq));
> +		if ((clk_freq.cpsdvsr % 2) != 0)
> +			clk_freq.cpsdvsr =
> +				clk_freq.cpsdvsr - 1;
>  	}
> +	if ((clk_freq.cpsdvsr < CPSDVR_MIN)
> +	    || (clk_freq.cpsdvsr > CPSDVR_MAX)) {
> +		dev_err(&spi->dev,
> +			"cpsdvsr is configured incorrectly\n");
> +		goto err_config_params;
> +	}
> +
> +
>  	status = verify_controller_parameters(pl022, chip_info);
>  	if (status) {
>  		dev_err(&spi->dev, "controller data is incorrect");
>  		goto err_config_params;
>  	}
> +
>  	/* Now set controller state based on controller data */
>  	chip->xfer_type = chip_info->com_mode;
> -	chip->cs_control = chip_info->cs_control;
> +	if (!chip_info->cs_control) {
> +		chip->cs_control = null_cs_control;
> +		dev_warn(&spi->dev,
> +			 "chip select function is NULL for this chip\n");
> +	} else
> +		chip->cs_control = chip_info->cs_control;
>  
>  	if (bits <= 3) {
>  		/* PL022 doesn't support less than 4-bits */
> @@ -1931,7 +1928,7 @@ static int pl022_setup(struct spi_device *spi)
>  			       SSP_DMACR_MASK_TXDMAE, 1);
>  	}
>  
> -	chip->cpsr = chip_info->clk_freq.cpsdvsr;
> +	chip->cpsr = clk_freq.cpsdvsr;
>  
>  	/* Special setup for the ST micro extended control registers */
>  	if (pl022->vendor->extended_cr) {
> @@ -1988,7 +1985,7 @@ static int pl022_setup(struct spi_device *spi)
>  		tmp = SSP_CLK_FIRST_EDGE;
>  	SSP_WRITE_BITS(chip->cr0, tmp, SSP_CR0_MASK_SPH, 7);
>  
> -	SSP_WRITE_BITS(chip->cr0, chip_info->clk_freq.scr, SSP_CR0_MASK_SCR, 8);
> +	SSP_WRITE_BITS(chip->cr0, clk_freq.scr, SSP_CR0_MASK_SCR, 8);
>  	/* Loopback is available on all versions except PL023 */
>  	if (!pl022->vendor->pl023) {
>  		if (spi->mode & SPI_LOOP)
> @@ -2006,7 +2003,6 @@ static int pl022_setup(struct spi_device *spi)
>  	return status;
>   err_config_params:
>  	spi_set_ctldata(spi, NULL);
> - err_first_setup:
>  	kfree(chip);
>  	return status;
>  }
> -- 
> 1.6.3.3
> 
