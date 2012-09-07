From: florian@openwrt.org (Florian Fainelli)
Date: Fri, 07 Sep 2012 16:01:01 +0200
Subject: [PATCH 3/7] gpio: 74x164: Use dynamic gpio number assignment if
 no pdata is present
In-Reply-To: <1347020296-18796-4-git-send-email-maxime.ripard@free-electrons.com>
References: <1347020296-18796-1-git-send-email-maxime.ripard@free-electrons.com>
 <1347020296-18796-4-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1903354.7S2pl9Kbxh@flexo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 September 2012 14:18:12 Maxime Ripard wrote:
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Florian Fainelli <florian@openwrt.org>

Thank you Maxime!

> ---
>  drivers/gpio/gpio-74x164.c |   13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-74x164.c b/drivers/gpio/gpio-74x164.c
> index 604b998..ef8baac 100644
> --- a/drivers/gpio/gpio-74x164.c
> +++ b/drivers/gpio/gpio-74x164.c
> @@ -75,12 +75,6 @@ static int __devinit gen_74x164_probe(struct spi_device 
*spi)
>  	struct gen_74x164_chip_platform_data *pdata;
>  	int ret;
>  
> -	pdata = spi->dev.platform_data;
> -	if (!pdata || !pdata->base) {
> -		dev_dbg(&spi->dev, "incorrect or missing platform data\n");
> -		return -EINVAL;
> -	}
> -
>  	/*
>  	 * bits_per_word cannot be configured in platform data
>  	 */
> @@ -94,6 +88,12 @@ static int __devinit gen_74x164_probe(struct spi_device 
*spi)
>  	if (!chip)
>  		return -ENOMEM;
>  
> +	pdata = spi->dev.platform_data;
> +	if (pdata && pdata->base)
> +		chip->gpio_chip.base = pdata->base;
> +	else
> +		chip->gpio_chip.base = -1;
> +
>  	mutex_init(&chip->lock);
>  
>  	dev_set_drvdata(&spi->dev, chip);
> @@ -104,7 +104,6 @@ static int __devinit gen_74x164_probe(struct spi_device 
*spi)
>  	chip->gpio_chip.direction_output = gen_74x164_direction_output;
>  	chip->gpio_chip.get = gen_74x164_get_value;
>  	chip->gpio_chip.set = gen_74x164_set_value;
> -	chip->gpio_chip.base = pdata->base;
>  	chip->gpio_chip.ngpio = 8;
>  	chip->gpio_chip.can_sleep = 1;
>  	chip->gpio_chip.dev = &spi->dev;
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
