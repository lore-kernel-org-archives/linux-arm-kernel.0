From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 4 Apr 2011 15:24:19 +0200
Subject: [PATCH] ARM: mx5/mx53_evk: Add LED support
In-Reply-To: <1301068415-18989-1-git-send-email-fabio.estevam@freescale.com>
References: <1301068415-18989-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20110404132419.GD30938@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Fabio,

On Fri, Mar 25, 2011 at 12:53:35PM -0300, Fabio Estevam wrote:
> On the mx53evk board there is an LED connected to GPIO7_7.
> 
> Add support for it.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/mach-mx5/board-mx53_evk.c |   31 +++++++++++++++++++++++++++++++
>  1 files changed, 31 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/board-mx53_evk.c b/arch/arm/mach-mx5/board-mx53_evk.c
> index 7b5735c..f2c5151 100644
> --- a/arch/arm/mach-mx5/board-mx53_evk.c
> +++ b/arch/arm/mach-mx5/board-mx53_evk.c
> @@ -24,6 +24,7 @@
>  #include <linux/fec.h>
>  #include <linux/delay.h>
>  #include <linux/gpio.h>
> +#include <linux/leds.h>
>  #include <linux/spi/flash.h>
>  #include <linux/spi/spi.h>
>  #include <mach/common.h>
> @@ -37,6 +38,7 @@
>  #define SMD_FEC_PHY_RST		IMX_GPIO_NR(7, 6)
>  #define EVK_ECSPI1_CS0		IMX_GPIO_NR(2, 30)
>  #define EVK_ECSPI1_CS1		IMX_GPIO_NR(3, 19)
> +#define MX53EVK_LED		IMX_GPIO_NR(7, 7)
>  
>  #include "crm_regs.h"
>  #include "devices-imx53.h"
> @@ -60,6 +62,8 @@ static iomux_v3_cfg_t mx53_evk_pads[] = {
>  	/* ecspi chip select lines */
>  	MX53_PAD_EIM_EB2__GPIO2_30,
>  	MX53_PAD_EIM_D19__GPIO3_19,
> +	/* LED */
> +	MX53_PAD_PATA_DA_1__GPIO7_7,
>  };
>  
>  static const struct imxuart_platform_data mx53_evk_uart_pdata __initconst = {
> @@ -118,6 +122,32 @@ static const struct spi_imx_master mx53_evk_spi_data __initconst = {
>  	.num_chipselect = ARRAY_SIZE(mx53_evk_spi_cs),
>  };
>  
> +static struct gpio_led mx53_evk_leds[] = {
> +	{
> +		.name			= "led-green",
> +		.default_trigger	= "heartbeat",
> +		.active_low		= 0,
> +		.gpio			= MX53EVK_LED,
> +	},
> +};
> +
> +static struct gpio_led_platform_data mx53_evk_leds_data = {
> +	.leds = mx53_evk_leds,
> +	.num_leds = ARRAY_SIZE(mx53_evk_leds),
> +};
> +
> +static struct platform_device mx53_evk_leds_device = {
> +	.name = "leds-gpio",
> +	.id = -1,
> +	.dev = {
> +		.platform_data = &mx53_evk_leds_data,
> +	},
> +};
> +
> +static struct platform_device *platform_devices[] __initdata = {
> +	&mx53_evk_leds_device,
> +};
> +
>  static void __init mx53_evk_board_init(void)
>  {
>  	mxc_iomux_v3_setup_multiple_pads(mx53_evk_pads,
> @@ -136,6 +166,7 @@ static void __init mx53_evk_board_init(void)
>  		ARRAY_SIZE(mx53_evk_spi_board_info));
>  	imx53_add_ecspi(0, &mx53_evk_spi_data);
>  	imx53_add_imx2_wdt(0, NULL);
> +	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
>  }
>  
>  static void __init mx53_evk_timer_init(void)
Can you please instead add a function imx_add_leds_gpio?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
