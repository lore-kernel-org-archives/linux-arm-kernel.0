From: ore@pengutronix.de (Oleksij Rempel)
Date: Thu, 19 Oct 2017 12:17:16 +0200
Subject: [PATCH 1/4] spi: imx: GPIO based chip selects should not be
 required
In-Reply-To: <1507918921.24265.8.camel@impinj.com>
References: <1507918921.24265.8.camel@impinj.com>
Message-ID: <20171019101715.wmm6avnoyb5r3bsv@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 13, 2017 at 06:22:01PM +0000, Trent Piepho wrote:
> The driver will fail to load if no gpio chip selects are specified,
> this patch changes this so that it no longer fails.
> 
> It's possible to use all native chip selects, in which case there is
> no reason to have a gpio chip select array.  This is what happens if
> the *optional* device tree property "cs-gpios" is omitted.
> 
> The spi core already checks for the absence of gpio chip selects in
> the master and assigns any slaves the gpio_cs value of -ENOENT.
> 
> Signed-off-by: Trent Piepho <tpiepho@impinj.com>
> ---
>  drivers/spi/spi-imx.c | 29 +++++++++++++----------------
>  1 file changed, 13 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index babb15f07995..07e6250f2dad 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -1457,22 +1457,19 @@ static int spi_imx_probe(struct platform_device *pdev)
>  		goto out_clk_put;
>  	}
>  
> -	if (!master->cs_gpios) {
> -		dev_err(&pdev->dev, "No CS GPIOs available\n");
> -		ret = -EINVAL;
> -		goto out_clk_put;
> -	}
> -
> -	for (i = 0; i < master->num_chipselect; i++) {
> -		if (!gpio_is_valid(master->cs_gpios[i]))
> -			continue;
> -
> -		ret = devm_gpio_request(&pdev->dev, master->cs_gpios[i],
> -					DRIVER_NAME);
> -		if (ret) {
> -			dev_err(&pdev->dev, "Can't get CS GPIO %i\n",
> -				master->cs_gpios[i]);
> -			goto out_clk_put;
> +	/* Request GPIO CS lines, if any */
> +	if (master->cs_gpios) {
> +		for (i = 0; i < master->num_chipselect; i++) {
> +			if (!gpio_is_valid(master->cs_gpios[i]))
> +				continue;
> +
> +			ret = devm_gpio_request(&pdev->dev, master->cs_gpios[i],
> +						DRIVER_NAME);
> +			if (ret) {
> +				dev_err(&pdev->dev, "Can't get CS GPIO %i\n",
> +					master->cs_gpios[i]);
> +				goto out_clk_put;
> +			}
>  		}
>  	}
>  
> -- 
> 2.13.6

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
