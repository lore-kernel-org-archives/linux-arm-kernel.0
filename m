From: florian@openwrt.org (Florian Fainelli)
Date: Wed, 05 Sep 2012 10:48:14 +0200
Subject: [PATCH 3/8] gpio: 74x164: Remove platform data and use dynamic
 gpio number assignment
In-Reply-To: <1346834457-6257-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1346834457-6257-1-git-send-email-maxime.ripard@free-electrons.com>
 <1346834457-6257-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <9763805.kende5OlsI@flexo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 05 September 2012 10:40:52 Maxime Ripard wrote:
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

No, please don't do it that way, rather check if the platform_data pointer is 
null, and if it is, fall-back to dynamic gpio base assignment. There is a 
currently out of tree user of this for which it matters to be able to set a 
specific gpio base numbering.

> ---
>  drivers/gpio/gpio-74x164.c |   10 +---------
>  include/linux/spi/74x164.h |    9 ---------
>  2 files changed, 1 insertion(+), 18 deletions(-)
>  delete mode 100644 include/linux/spi/74x164.h
> 
> diff --git a/drivers/gpio/gpio-74x164.c b/drivers/gpio/gpio-74x164.c
> index 604b998..24cfe4c 100644
> --- a/drivers/gpio/gpio-74x164.c
> +++ b/drivers/gpio/gpio-74x164.c
> @@ -12,7 +12,6 @@
>  #include <linux/init.h>
>  #include <linux/mutex.h>
>  #include <linux/spi/spi.h>
> -#include <linux/spi/74x164.h>
>  #include <linux/gpio.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
> @@ -72,15 +71,8 @@ static int gen_74x164_direction_output(struct gpio_chip 
*gc,
>  static int __devinit gen_74x164_probe(struct spi_device *spi)
>  {
>  	struct gen_74x164_chip *chip;
> -	struct gen_74x164_chip_platform_data *pdata;
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
> @@ -104,7 +96,7 @@ static int __devinit gen_74x164_probe(struct spi_device 
*spi)
>  	chip->gpio_chip.direction_output = gen_74x164_direction_output;
>  	chip->gpio_chip.get = gen_74x164_get_value;
>  	chip->gpio_chip.set = gen_74x164_set_value;
> -	chip->gpio_chip.base = pdata->base;
> +	chip->gpio_chip.base = -1;
>  	chip->gpio_chip.ngpio = 8;
>  	chip->gpio_chip.can_sleep = 1;
>  	chip->gpio_chip.dev = &spi->dev;
> diff --git a/include/linux/spi/74x164.h b/include/linux/spi/74x164.h
> deleted file mode 100644
> index 0aa6acc..0000000
> --- a/include/linux/spi/74x164.h
> +++ /dev/null
> @@ -1,9 +0,0 @@
> -#ifndef LINUX_SPI_74X164_H
> -#define LINUX_SPI_74X164_H
> -
> -struct gen_74x164_chip_platform_data {
> -	/* number assigned to the first GPIO */
> -	unsigned	base;
> -};
> -
> -#endif
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
