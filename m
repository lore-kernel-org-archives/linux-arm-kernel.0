From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 30 May 2013 11:22:48 +0800
Subject: [RFC 2/3] SPI: imx: Using SPI-master "cs_gpios" field for array
 of chipselects instead of private
In-Reply-To: <1369847430-10799-2-git-send-email-shc_work@mail.ru>
References: <20130529144909.GT3660@sirena.org.uk>
 <1369847430-10799-1-git-send-email-shc_work@mail.ru>
 <1369847430-10799-2-git-send-email-shc_work@mail.ru>
Message-ID: <20130530032246.GD1875@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 29, 2013 at 09:10:29PM +0400, Alexander Shiyan wrote:
> @@ -356,11 +356,12 @@ static void __maybe_unused mx31_trigger(struct spi_imx_data *spi_imx)
>  	writel(reg, spi_imx->base + MXC_CSPICTRL);
>  }
>  
> -static int __maybe_unused mx31_config(struct spi_imx_data *spi_imx,
> +static int __maybe_unused mx31_config(struct spi_device *spi,
>  		struct spi_imx_config *config)
>  {
> +	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
>  	unsigned int reg = MX31_CSPICTRL_ENABLE | MX31_CSPICTRL_MASTER;
> -	int cs = spi_imx->chipselect[config->cs];
> +	int cs = spi->master->cs_gpios[config->cs];

Hmm, just took another look and found it (and all the following) can be
even simpler like:

	int cs = spi->cs_gpio;

Shawn

>  
>  	reg |= spi_imx_clkdiv_2(spi_imx->spi_clk, config->speed_hz) <<
>  		MX31_CSPICTRL_DR_SHIFT;
> @@ -434,11 +435,12 @@ static void __maybe_unused mx21_trigger(struct spi_imx_data *spi_imx)
>  	writel(reg, spi_imx->base + MXC_CSPICTRL);
>  }
>  
> -static int __maybe_unused mx21_config(struct spi_imx_data *spi_imx,
> +static int __maybe_unused mx21_config(struct spi_device *spi,
>  		struct spi_imx_config *config)
>  {
> +	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
>  	unsigned int reg = MX21_CSPICTRL_ENABLE | MX21_CSPICTRL_MASTER;
> -	int cs = spi_imx->chipselect[config->cs];
> +	int cs = spi->master->cs_gpios[config->cs];
>  	unsigned int max = is_imx27_cspi(spi_imx) ? 16 : 18;
>  
>  	reg |= spi_imx_clkdiv_1(spi_imx->spi_clk, config->speed_hz, max) <<
> @@ -501,9 +503,10 @@ static void __maybe_unused mx1_trigger(struct spi_imx_data *spi_imx)
>  	writel(reg, spi_imx->base + MXC_CSPICTRL);
>  }
>  
> -static int __maybe_unused mx1_config(struct spi_imx_data *spi_imx,
> +static int __maybe_unused mx1_config(struct spi_device *spi,
>  		struct spi_imx_config *config)
>  {
> +	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
>  	unsigned int reg = MX1_CSPICTRL_ENABLE | MX1_CSPICTRL_MASTER;
>  
>  	reg |= spi_imx_clkdiv_2(spi_imx->spi_clk, config->speed_hz) <<
> @@ -622,8 +625,7 @@ static const struct of_device_id spi_imx_dt_ids[] = {
>  
>  static void spi_imx_chipselect(struct spi_device *spi, int is_active)
>  {
> -	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
> -	int gpio = spi_imx->chipselect[spi->chip_select];
> +	int gpio = spi->master->cs_gpios[spi->chip_select];
>  	int active = is_active != BITBANG_CS_INACTIVE;
>  	int dev_is_lowactive = !(spi->mode & SPI_CS_HIGH);
>  
> @@ -703,7 +705,7 @@ static int spi_imx_setupxfer(struct spi_device *spi,
>  	} else
>  		BUG();
>  
> -	spi_imx->devtype_data->config(spi_imx, &config);
> +	spi_imx->devtype_data->config(spi, &config);
>  
>  	return 0;
>  }
> @@ -731,8 +733,7 @@ static int spi_imx_transfer(struct spi_device *spi,
>  
>  static int spi_imx_setup(struct spi_device *spi)
>  {
> -	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
> -	int gpio = spi_imx->chipselect[spi->chip_select];
> +	int gpio = spi->master->cs_gpios[spi->chip_select];
>  
>  	dev_dbg(&spi->dev, "%s: mode %d, %u bpw, %d hz\n", __func__,
>  		 spi->mode, spi->bits_per_word, spi->max_speed_hz);
