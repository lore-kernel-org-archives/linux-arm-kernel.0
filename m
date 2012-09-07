From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 07 Sep 2012 14:38:52 +0900
Subject: [PATCH v2] gpio: samsung: add devicetree init for s3c24xx arches
In-Reply-To: <201208282355.44268.heiko@sntech.de>
References: <201208282355.44268.heiko@sntech.de>
Message-ID: <243901cd8cbb$10ad0580$32071080$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko St?bner wrote:
> 
> Until now the Exynos-SoC was the only Samsung-SoC supporting the GPIOs
> via the device tree. This patch implements dt-support for the
> s3c24xx arches.
> 
> The controllers contain only 3 cells, as the underlying gpio controller
> does not support controlling the drive strength on a gpio level.
> 
> Tested with the gpio-keys driver on a s3c2416 based machine.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---

[...]

> +#if defined(CONFIG_PLAT_S3C24XX) && defined(CONFIG_OF)

[...]

> +static __init void s3c24xx_gpiolib_attach_ofnode(struct samsung_gpio_chip
> *chip,
> +						 u64 base, u64 offset)
> +{

[...]

> +}
> +#elif defined(CONFIG_PLAT_S3C24XX)

Heiko, above line breaks building for other samsung stuff except s3c24xx. I fixed with following which has been amended in your patch. If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

diff --git a/drivers/gpio/gpio-samsung.c b/drivers/gpio/gpio-samsung.c
index 5dcdcda..a006f0d 100644
--- a/drivers/gpio/gpio-samsung.c
+++ b/drivers/gpio/gpio-samsung.c
@@ -991,7 +991,7 @@ static __init void s3c24xx_gpiolib_attach_ofnode(struct samsun
 	gc->of_gpio_n_cells = 3;
 	gc->of_xlate = s3c24xx_gpio_xlate;
 }
-#elif defined(CONFIG_PLAT_S3C24XX)
+#else
 static __init void s3c24xx_gpiolib_attach_ofnode(struct samsung_gpio_chip *chip,
 						u64 base, u64 offset)
 {

> +static __init void s3c24xx_gpiolib_attach_ofnode(struct samsung_gpio_chip
> *chip,
> +						 u64 base, u64 offset)
> +{
> +	return;
> +}
> +#endif /* defined(CONFIG_PLAT_S3C24XX) && defined(CONFIG_OF) */
> +
>  static void __init s3c24xx_gpiolib_add_chips(struct samsung_gpio_chip
> *chip,
>  					     int nr_chips, void __iomem *base)
>  {
> @@ -962,6 +1023,8 @@ static void __init s3c24xx_gpiolib_add_chips(struct
> samsung_gpio_chip *chip,
>  			gc->direction_output = samsung_gpiolib_2bit_output;
> 
>  		samsung_gpiolib_add(chip);
> +
> +		s3c24xx_gpiolib_attach_ofnode(chip, S3C24XX_PA_GPIO, i *
> 0x10);
>  	}
>  }
> 
> --
> 1.7.2.3
