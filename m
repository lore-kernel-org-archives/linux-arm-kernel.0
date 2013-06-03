From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 3 Jun 2013 13:26:20 +0800
Subject: [RFC v2 2/5] SPI: imx: Using existing properties for chipselects
In-Reply-To: <1370168531-22718-2-git-send-email-shc_work@mail.ru>
References: <1370168531-22718-1-git-send-email-shc_work@mail.ru>
 <1370168531-22718-2-git-send-email-shc_work@mail.ru>
Message-ID: <20130603052618.GH13970@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 02, 2013 at 02:22:08PM +0400, Alexander Shiyan wrote:
> Patch reuse existing "cs_gpios" field for master and "cs_gpio" for devices.
> 
It seems that the patch does a little bit more than these.  At least, it
reuses chip_select for spi_device as well.

> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  drivers/spi/spi-imx.c | 76 +++++++++++++++++++++++++--------------------------
>  1 file changed, 37 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 1a53e7d..65f73d6 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -56,7 +56,6 @@ struct spi_imx_config {
>  	unsigned int speed_hz;
>  	unsigned int bpw;
>  	unsigned int mode;
> -	u8 cs;
>  };
>  
>  enum spi_imx_devtype {
> @@ -72,7 +71,7 @@ struct spi_imx_data;
>  
>  struct spi_imx_devtype_data {
>  	void (*intctrl)(struct spi_imx_data *, int);
> -	int (*config)(struct spi_imx_data *, struct spi_imx_config *);
> +	int (*config)(struct spi_device *, struct spi_imx_config *);
>  	void (*trigger)(struct spi_imx_data *);
>  	int (*rx_available)(struct spi_imx_data *);
>  	void (*reset)(struct spi_imx_data *);
> @@ -96,7 +95,6 @@ struct spi_imx_data {
>  	unsigned int txfifo; /* number of words pushed in tx FIFO */
>  
>  	const struct spi_imx_devtype_data *devtype_data;
> -	int chipselect[0];
>  };
>  
>  static inline int is_imx27_cspi(struct spi_imx_data *d)
> @@ -259,9 +257,10 @@ static void __maybe_unused mx51_ecspi_trigger(struct spi_imx_data *spi_imx)
>  	writel(reg, spi_imx->base + MX51_ECSPI_CTRL);
>  }
>  
> -static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
> +static int __maybe_unused mx51_ecspi_config(struct spi_device *spi,
>  		struct spi_imx_config *config)
>  {
> +	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
>  	u32 ctrl = MX51_ECSPI_CTRL_ENABLE, cfg = 0;
>  
>  	/*
> @@ -277,21 +276,21 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
>  	ctrl |= mx51_ecspi_clkdiv(spi_imx->spi_clk, config->speed_hz);
>  
>  	/* set chip select to use */
> -	ctrl |= MX51_ECSPI_CTRL_CS(config->cs);
> +	ctrl |= MX51_ECSPI_CTRL_CS(spi->chip_select);
>  
>  	ctrl |= (config->bpw - 1) << MX51_ECSPI_CTRL_BL_OFFSET;
>  
> -	cfg |= MX51_ECSPI_CONFIG_SBBCTRL(config->cs);
> +	cfg |= MX51_ECSPI_CONFIG_SBBCTRL(spi->chip_select);
>  
>  	if (config->mode & SPI_CPHA)
> -		cfg |= MX51_ECSPI_CONFIG_SCLKPHA(config->cs);
> +		cfg |= MX51_ECSPI_CONFIG_SCLKPHA(spi->chip_select);
>  
>  	if (config->mode & SPI_CPOL) {
> -		cfg |= MX51_ECSPI_CONFIG_SCLKPOL(config->cs);
> -		cfg |= MX51_ECSPI_CONFIG_SCLKCTL(config->cs);
> +		cfg |= MX51_ECSPI_CONFIG_SCLKPOL(spi->chip_select);
> +		cfg |= MX51_ECSPI_CONFIG_SCLKCTL(spi->chip_select);
>  	}
>  	if (config->mode & SPI_CS_HIGH)
> -		cfg |= MX51_ECSPI_CONFIG_SSBPOL(config->cs);
> +		cfg |= MX51_ECSPI_CONFIG_SSBPOL(spi->chip_select);
>  
>  	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
>  	writel(cfg, spi_imx->base + MX51_ECSPI_CONFIG);

<snip>

> @@ -772,11 +767,17 @@ static int spi_imx_probe(struct platform_device *pdev)
>  			return ret;
>  	}
>  
> -	master = spi_alloc_master(&pdev->dev,
> -			sizeof(struct spi_imx_data) + sizeof(int) * num_cs);
> +	master = spi_alloc_master(&pdev->dev, sizeof(struct spi_imx_data));
>  	if (!master)
>  		return -ENOMEM;
>  
> +	master->cs_gpios = devm_kzalloc(&pdev->dev, sizeof(int) * num_cs,
> +					GFP_KERNEL);
> +	if (!master->cs_gpios) {
> +		ret = -ENOMEM;
> +		goto out_master_free;
> +	}
> +

For DT case, of_spi_register_master() will set master->cs_gpios up over
again with the memory it allocates, so the memory allocated here will be
leaked?

Shawn

>  	platform_set_drvdata(pdev, master);
>  
>  	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
> @@ -791,14 +792,10 @@ static int spi_imx_probe(struct platform_device *pdev)
>  		if (!gpio_is_valid(cs_gpio) && mxc_platform_info)
>  			cs_gpio = mxc_platform_info->chipselect[i];
>  
> -		spi_imx->chipselect[i] = cs_gpio;
> -		if (!gpio_is_valid(cs_gpio))
> -			continue;
> -
> -		ret = devm_gpio_request(&pdev->dev, spi_imx->chipselect[i],
> -					DRIVER_NAME);
> +		master->cs_gpios[i] = cs_gpio;
> +		ret = devm_gpio_request(&pdev->dev, cs_gpio, DRIVER_NAME);
>  		if (ret) {
> -			dev_err(&pdev->dev, "can't get cs gpios\n");
> +			dev_err(&pdev->dev, "can't get cs gpio %i\n", cs_gpio);
>  			goto out_master_put;
>  		}
>  	}
