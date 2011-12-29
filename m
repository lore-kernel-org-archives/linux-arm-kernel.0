From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 29 Dec 2011 13:01:59 +0900
Subject: [PATCH 2/2] ARM: S3C64XX: Support GPIO LEDs on Cragganmore
In-Reply-To: <1325121813-2066-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1325121813-2066-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1325121813-2066-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <029401ccc5de$9d39bc40$d7ad34c0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> Cragganmore has a bank of 8 LEDs connected to the memory mapped GPIO
> bank, mostly intended for low level diagnostics. Register these with
> the LED subsystem for runtime use.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  arch/arm/mach-s3c64xx/Kconfig         |    1 +
>  arch/arm/mach-s3c64xx/mach-crag6410.c |   51
> +++++++++++++++++++++++++++++++++
>  2 files changed, 52 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
> index dd20c66..dc45123 100644
> --- a/arch/arm/mach-s3c64xx/Kconfig
> +++ b/arch/arm/mach-s3c64xx/Kconfig
> @@ -296,5 +296,6 @@ config MACH_WLF_CRAGG_6410
>  	select S3C64XX_DEV_SPI0
>  	select SAMSUNG_GPIO_EXTRA128
>  	select I2C
> +	select LEDS_GPIO_REGISTER
>  	help
>  	  Machine support for the Wolfson Cragganmore S3C6410 variant.
> diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-
> s3c64xx/mach-crag6410.c
> index d0308f0..139d16e 100644
> --- a/arch/arm/mach-s3c64xx/mach-crag6410.c
> +++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
> @@ -19,6 +19,7 @@
>  #include <linux/io.h>
>  #include <linux/init.h>
>  #include <linux/gpio.h>
> +#include <linux/leds.h>
>  #include <linux/delay.h>
>  #include <linux/mmc/host.h>
>  #include <linux/regulator/machine.h>
> @@ -710,6 +711,54 @@ static struct s3c_sdhci_platdata
> crag6410_hsmmc0_pdata = {
>  	.host_caps		= MMC_CAP_POWER_OFF_CARD,
>  };
> 
> +static const struct gpio_led gpio_leds[] = {
> +	{
> +		.name = "d13:green:",
> +		.gpio = MMGPIO_GPIO_BASE + 0,
> +		.default_state = LEDS_GPIO_DEFSTATE_ON,
> +	},
> +	{
> +		.name = "d14:green:",
> +		.gpio = MMGPIO_GPIO_BASE + 1,
> +		.default_state = LEDS_GPIO_DEFSTATE_ON,
> +	},
> +	{
> +		.name = "d15:green:",
> +		.gpio = MMGPIO_GPIO_BASE + 2,
> +		.default_state = LEDS_GPIO_DEFSTATE_ON,
> +	},
> +	{
> +		.name = "d16:green:",
> +		.gpio = MMGPIO_GPIO_BASE + 3,
> +		.default_state = LEDS_GPIO_DEFSTATE_ON,
> +	},
> +	{
> +		.name = "d17:green:",
> +		.gpio = MMGPIO_GPIO_BASE + 4,
> +		.default_state = LEDS_GPIO_DEFSTATE_ON,
> +	},
> +	{
> +		.name = "d18:green:",
> +		.gpio = MMGPIO_GPIO_BASE + 5,
> +		.default_state = LEDS_GPIO_DEFSTATE_ON,
> +	},
> +	{
> +		.name = "d19:green:",
> +		.gpio = MMGPIO_GPIO_BASE + 6,
> +		.default_state = LEDS_GPIO_DEFSTATE_ON,
> +	},
> +	{
> +		.name = "d20:green:",
> +		.gpio = MMGPIO_GPIO_BASE + 7,
> +		.default_state = LEDS_GPIO_DEFSTATE_ON,
> +	},
> +};
> +
> +static const struct gpio_led_platform_data gpio_leds_pdata = {
> +	.leds = gpio_leds,
> +	.num_leds = ARRAY_SIZE(gpio_leds),
> +};
> +
>  static void __init crag6410_machine_init(void)
>  {
>  	/* Open drain IRQs need pullups */
> @@ -743,6 +792,8 @@ static void __init crag6410_machine_init(void)
> 
>  	platform_add_devices(crag6410_devices,
> ARRAY_SIZE(crag6410_devices));
> 
> +	gpio_led_register_device(-1, &gpio_leds_pdata);
> +
>  	regulator_has_full_constraints();
> 
>  	s3c64xx_pm_init();
> --
> 1.7.7.3

OK, will apply.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
