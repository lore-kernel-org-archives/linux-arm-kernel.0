From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 4 Feb 2011 10:53:02 -0600
Subject: [PATCH] EDB93xx: Add support for CS4271 SPI-connected CODEC
In-Reply-To: <1296770466.14577.8.camel@r60e>
References: <1296770466.14577.8.camel@r60e>
Message-ID: <0D753D10438DA54287A00B027084269764CF0C44AA@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, February 03, 2011 3:01 PM, Alexander Sverdlin wrote:
>
> Add support for CS4271 SPI-connected CODEC to EDB93xx
>
> Signed-off-by: Alexander Sverdlin <subaparts@yandex.ru>
> ---
>  arch/arm/mach-ep93xx/edb93xx.c |   85 ++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 85 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-ep93xx/edb93xx.c b/arch/arm/mach-ep93xx/edb93xx.c
> index 3f37567..c1e73ee 100644
> --- a/arch/arm/mach-ep93xx/edb93xx.c
> +++ b/arch/arm/mach-ep93xx/edb93xx.c
> @@ -30,13 +30,17 @@
>  #include <linux/gpio.h>
>  #include <linux/i2c.h>
>  #include <linux/i2c-gpio.h>
> +#include <linux/spi/spi.h>
> 
>  #include <mach/hardware.h>
>  #include <mach/fb.h>
> +#include <mach/ep93xx_spi.h>
>
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
> 
> +#include <sound/cs4271.h>
> +

Nitpick... Please move this include to before the <mach/*> includes.

> 
>  static void __init edb93xx_register_flash(void)
>  {
> @@ -94,6 +98,85 @@ static void __init edb93xx_register_i2c(void)
> 
> 
>  /*************************************************************************
> + * EDB93xx SPI peripheral handling
> + *************************************************************************/
> +static struct cs4271_platform_data edb93xx_cs4271_data = {
> +	.gpio_nreset	= -EINVAL,	/* filled in later */
> +};
> +
> +static int edb93xx_cs4271_hw_setup(struct spi_device *spi)
> +{
> +	return gpio_request_one(EP93XX_GPIO_LINE_EGPIO6,
> +				GPIOF_OUT_INIT_HIGH, spi->modalias);
> +}
> +
> +static void edb93xx_cs4271_hw_cleanup(struct spi_device *spi)
> +{
> +	gpio_free(EP93XX_GPIO_LINE_EGPIO6);
> +}
> +
> +static void edb93xx_cs4271_hw_cs_control(struct spi_device *spi, int value)
> +{
> +	gpio_set_value(EP93XX_GPIO_LINE_EGPIO6, value);
> +}
> +
> +static struct ep93xx_spi_chip_ops edb93xx_cs4271_hw = {
> +	.setup		= edb93xx_cs4271_hw_setup,
> +	.cleanup	= edb93xx_cs4271_hw_cleanup,
> +	.cs_control	= edb93xx_cs4271_hw_cs_control,
> +};

This all looks good!  Thanks.

> +
> +static struct spi_board_info edb93xx_spi_board_info[] __initdata = {
> +	{
> +		.modalias		= "cs4271",
> +		.platform_data		= &edb93xx_cs4271_data,
> +		.controller_data	= &edb93xx_cs4271_hw,
> +		.max_speed_hz		= 6000000,
> +		.bus_num		= 0,
> +		.chip_select		= 0,
> +		.mode			= SPI_MODE_3,
> +	},
> +};
> +
> +static struct ep93xx_spi_info edb93xx_spi_info __initdata = {
> +	.num_chipselect	= ARRAY_SIZE(edb93xx_spi_board_info),
> +};
> +
> +static void __init edb93xx_register_spi(void)
> +{
> +	if (machine_is_edb9301() || machine_is_edb9302())
> +		edb93xx_cs4271_data.gpio_nreset = EP93XX_GPIO_LINE_EGPIO1;
> +	else if (machine_is_edb9302a() || machine_is_edb9307a())
> +		edb93xx_cs4271_data.gpio_nreset = EP93XX_GPIO_LINE_H(2);
> +	else if (machine_is_edb9315a())
> +		edb93xx_cs4271_data.gpio_nreset = EP93XX_GPIO_LINE_EGPIO14;
> +	else
> +		return;

You might want to just remove the last else test.

When the spi flash finally gets added it will exist on all edb93xx boards
and the call below will need to happen regardless of the tests above.

For the edb93xx boards that don't have the cs4271 codec, it will still be
registered but it will not _do_ anything because the 12s driver will not
be registered below.

> +
> +	ep93xx_register_spi(&edb93xx_spi_info, edb93xx_spi_board_info,
> +			    ARRAY_SIZE(edb93xx_spi_board_info));
> +}
> +
> +
> +/*************************************************************************
> + * EDB93xx I2S
> + *************************************************************************/
> +static int __init edb93xx_has_audio(void)
> +{
> +	return (machine_is_edb9301() || machine_is_edb9302() ||
> +		machine_is_edb9302a() || machine_is_edb9307a() ||
> +		machine_is_edb9315a());
> +}
> +
> +static void __init edb93xx_register_i2s(void)
> +{
> +	if (edb93xx_has_audio()) {
> +		ep93xx_register_i2s();
> +	}
> +}
> +
> +
> +/*************************************************************************
>   * EDB93xx pwm
>   *************************************************************************/
>  static void __init edb93xx_register_pwm(void)
> @@ -149,6 +232,8 @@ static void __init edb93xx_init_machine(void)
>  	edb93xx_register_flash();
>  	ep93xx_register_eth(&edb93xx_eth_data, 1);
>  	edb93xx_register_i2c();
> +	edb93xx_register_spi();
> +	edb93xx_register_i2s();
>  	edb93xx_register_pwm();
>  	edb93xx_register_fb();
>  }

Other than the comments above this looks good.

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
