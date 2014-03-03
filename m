From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 3 Mar 2014 10:41:21 +0100
Subject: [PATCH 1/4] mfd: mc13xxx: Honor designed SPI mode
In-Reply-To: <1393746275-9253-1-git-send-email-shc_work@mail.ru>
References: <1393746275-9253-1-git-send-email-shc_work@mail.ru>
Message-ID: <20140303094121.GM24917@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 02, 2014 at 11:44:32AM +0400, Alexander Shiyan wrote:
> Instead of using hard coded SPI mode, use mode described in
> devicetree or defined for the board.
> Additionally, patch updates all users of this PMIC to use
> correct SPI mode.

What's the reason for this change? Without it the driver just does the
correct thing, this only adds a chance for boards do get it wrong. This
for example happens with the i.MX27 phyCORE in this patch, see
happens with arch/arm/boot/dts/imx27-phytec-phycore-som.dts whih doesn't
have the spi-cs-high property.

Sascha

> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/mach-imx/mach-mx31lilly.c | 1 +
>  arch/arm/mach-imx/mach-mx31lite.c  | 1 +
>  drivers/mfd/mc13xxx-spi.c          | 2 --
>  3 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/mach-mx31lilly.c b/arch/arm/mach-imx/mach-mx31lilly.c
> index 832b1e2..16c688e 100644
> --- a/arch/arm/mach-imx/mach-mx31lilly.c
> +++ b/arch/arm/mach-imx/mach-mx31lilly.c
> @@ -231,6 +231,7 @@ static struct spi_board_info mc13783_dev __initdata = {
>  	.bus_num	= 1,
>  	.chip_select	= 0,
>  	.platform_data	= &mc13783_pdata,
> +	.mode		= SPI_MODE_0 | SPI_CS_HIGH,
>  	/* irq number is run-time assigned */
>  };
>  
> diff --git a/arch/arm/mach-imx/mach-mx31lite.c b/arch/arm/mach-imx/mach-mx31lite.c
> index bea0729..bf3e61e 100644
> --- a/arch/arm/mach-imx/mach-mx31lite.c
> +++ b/arch/arm/mach-imx/mach-mx31lite.c
> @@ -121,6 +121,7 @@ static struct spi_board_info mc13783_spi_dev __initdata = {
>  	.bus_num	= 1,
>  	.chip_select    = 0,
>  	.platform_data  = &mc13783_pdata,
> +	.mode		= SPI_MODE_0 | SPI_CS_HIGH,
>  	/* irq number is run-time assigned */
>  };
>  
> diff --git a/drivers/mfd/mc13xxx-spi.c b/drivers/mfd/mc13xxx-spi.c
> index 38ab678..f88087f 100644
> --- a/drivers/mfd/mc13xxx-spi.c
> +++ b/drivers/mfd/mc13xxx-spi.c
> @@ -136,8 +136,6 @@ static int mc13xxx_spi_probe(struct spi_device *spi)
>  
>  	dev_set_drvdata(&spi->dev, mc13xxx);
>  
> -	spi->mode = SPI_MODE_0 | SPI_CS_HIGH;
> -
>  	mc13xxx->irq = spi->irq;
>  
>  	mc13xxx->regmap = devm_regmap_init(&spi->dev, &regmap_mc13xxx_bus,
> -- 
> 1.8.3.2
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
