From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 28 May 2010 05:00:36 +0200
Subject: [PATCH] Add battery support into Zipit Z2
In-Reply-To: <1275015564-21803-1-git-send-email-marek.vasut@gmail.com>
References: <1275015564-21803-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <201005280500.36443.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne P? 28. kv?tna 2010 04:59:24 Marek Vasut napsal(a):
> This patch adds support for the AER915 battery chip into Zipit Z2
> platform file.
> 
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> ---
>  arch/arm/mach-pxa/z2.c |   42 +++++++++++++++++++++++++++++++++++++++---
>  1 files changed, 39 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
> index f5d1ae3..194865e 100644
> --- a/arch/arm/mach-pxa/z2.c
> +++ b/arch/arm/mach-pxa/z2.c
> @@ -16,6 +16,7 @@
>  #include <linux/mtd/mtd.h>
>  #include <linux/mtd/partitions.h>
>  #include <linux/pwm_backlight.h>
> +#include <linux/z2_battery.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/spi/spi.h>
>  #include <linux/spi/libertas_spi.h>
> @@ -458,6 +459,39 @@ static inline void z2_keys_init(void) {}
>  #endif
> 
>  /*************************************************************************
> ***** + * Battery
> +
> **************************************************************************
> ****/ +#if defined(CONFIG_I2C_PXA) || defined(CONFIG_I2C_PXA_MODULE)
> +static struct z2_battery_info batt_chip_info = {
> +	.batt_I2C_bus	= 0,
> +	.batt_I2C_addr	= 0x55,
> +	.batt_I2C_reg	= 2,
> +	.charge_gpio	= GPIO0_ZIPITZ2_AC_DETECT,
> +	.min_voltage	= 2400000,
> +	.max_voltage	= 3700000,
> +	.batt_div	= 69,
> +	.batt_mult	= 1000000,
> +	.batt_tech	= POWER_SUPPLY_TECHNOLOGY_LION,
> +	.batt_name	= "Z2",
> +};
> +
> +static struct i2c_board_info __initdata z2_i2c_board_info[] = {
> +	{
> +		I2C_BOARD_INFO("aer915", 0x55),
> +		.platform_data	= &batt_chip_info,
> +	}
> +};
> +
> +static void __init z2_i2c_init(void)
> +{
> +	pxa_set_i2c_info(NULL);
> +	i2c_register_board_info(0, ARRAY_AND_SIZE(z2_i2c_board_info));
> +}
> +#else
> +static inline void z2_i2c_init(void) {}
> +#endif
> +
> +/*************************************************************************
> ***** * SSP Devices - WiFi and LCD control
>  
> **************************************************************************
> ****/ #if defined(CONFIG_SPI_PXA2XX) || defined(CONFIG_SPI_PXA2XX_MODULE)
> @@ -585,12 +619,14 @@ static void __init z2_init(void)
>  {
>  	pxa2xx_mfp_config(ARRAY_AND_SIZE(z2_pin_config));
> 
> +	pxa_set_ffuart_info(NULL);
> +	pxa_set_btuart_info(NULL);
> +	pxa_set_stuart_info(NULL);
> +
>  	z2_lcd_init();
>  	z2_mmc_init();
>  	z2_mkp_init();
> -
> -	pxa_set_i2c_info(NULL);
> -
> +	z2_i2c_init();
>  	z2_spi_init();
>  	z2_nor_init();
>  	z2_pwm_init();

btw. this should be applied before "[PATCH 2/2] pxa/z2: Register WM8750". Sorry, 
I'm off to bed before I do any more stupid mistakes.
