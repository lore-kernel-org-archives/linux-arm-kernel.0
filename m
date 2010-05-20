From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 20 May 2010 08:39:34 +0200
Subject: [PATCH 06/13] eukrea_mbimx27: fix ADS7846 support
In-Reply-To: <1274287568-30253-6-git-send-email-eric@eukrea.com>
References: <1274287568-30253-1-git-send-email-eric@eukrea.com>
	<1274287568-30253-2-git-send-email-eric@eukrea.com>
	<1274287568-30253-3-git-send-email-eric@eukrea.com>
	<1274287568-30253-4-git-send-email-eric@eukrea.com>
	<1274287568-30253-5-git-send-email-eric@eukrea.com>
	<1274287568-30253-6-git-send-email-eric@eukrea.com>
Message-ID: <20100520063934.GS31199@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 19, 2010 at 06:46:01PM +0200, Eric B?nard wrote:
> Signed-off-by: Eric B?nard <eric@eukrea.com>
> ---
>  arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c |   19 ++++++++++++-------
>  1 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c b/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c
> index fff6c8d..7ea93e0 100644
> --- a/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c
> +++ b/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c
> @@ -35,6 +35,7 @@
>  #include <mach/hardware.h>
>  #include <mach/mmc.h>
>  #include <mach/imx-uart.h>
> +#include <mach/spi.h>
>  
>  #include "devices.h"
>  
> @@ -88,7 +89,6 @@ static int eukrea_mbimx27_pins[] = {
>  	PA30_PF_CONTRAST,
>  	PA31_PF_OE_ACD,
>  	/* SPI1 */
> -	PD28_PF_CSPI1_SS0,
>  	PD29_PF_CSPI1_SCLK,
>  	PD30_PF_CSPI1_MISO,
>  	PD31_PF_CSPI1_MOSI,
> @@ -236,7 +236,7 @@ static struct imxuart_platform_data uart_pdata[] = {
>  	},
>  };
>  
> -#if defined(CONFIG_TOUCHSCREEN_ADS7846)
> +#if defined(CONFIG_TOUCHSCREEN_ADS7846) \
>  	|| defined(CONFIG_TOUCHSCREEN_ADS7846_MODULE)
>  
>  #define ADS7846_PENDOWN (GPIO_PORTD | 25)
> @@ -247,7 +247,6 @@ static void ads7846_dev_init(void)
>  		printk(KERN_ERR "can't get ads746 pen down GPIO\n");
>  		return;
>  	}
> -
>  	gpio_direction_input(ADS7846_PENDOWN);
>  }
>  
> @@ -260,7 +259,9 @@ static struct ads7846_platform_data ads7846_config __initdata = {
>  	.get_pendown_state	= ads7846_get_pendown_state,
>  	.keep_vref_on		= 1,
>  };
> +#endif
>  
> +#if defined(CONFIG_SPI_IMX) || defined(CONFIG_SPI_IMX_MODULE)
>  static struct spi_board_info eukrea_mbimx27_spi_board_info[] __initdata = {
>  	[0] = {
>  		.modalias	= "ads7846",
> @@ -305,15 +306,19 @@ void __init eukrea_mbimx27_baseboard_init(void)
>  	mxc_register_device(&mxc_fb_device, &eukrea_mbimx27_fb_data);
>  	mxc_register_device(&mxc_sdhc_device0, NULL);
>  
> -#if defined(CONFIG_TOUCHSCREEN_ADS7846)
> +#if defined(CONFIG_TOUCHSCREEN_ADS7846) \
>  	|| defined(CONFIG_TOUCHSCREEN_ADS7846_MODULE)
> -	/* SPI and ADS7846 Touchscreen controler init */
> -	mxc_gpio_mode(GPIO_PORTD | 28 | GPIO_GPIO | GPIO_OUT);
> +	/* ADS7846 Touchscreen controler init */

s/controler/controller/

>  	mxc_gpio_mode(GPIO_PORTD | 25 | GPIO_GPIO | GPIO_IN);
> +	ads7846_dev_init();
> +#endif
> +
> +#if defined(CONFIG_SPI_IMX) || defined(CONFIG_SPI_IMX_MODULE)
> +	/* SPI_CS0 init */
> +	mxc_gpio_mode(GPIO_PORTD | 28 | GPIO_GPIO | GPIO_OUT);
>  	mxc_register_device(&mxc_spi_device0, &eukrea_mbimx27_spi_0_data);
>  	spi_register_board_info(eukrea_mbimx27_spi_board_info,
>  			ARRAY_SIZE(eukrea_mbimx27_spi_board_info));
> -	ads7846_dev_init();
>  #endif
>  
>  	/* Leds configuration */
> -- 
> 1.6.3.3
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
