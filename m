From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 28 May 2011 19:50:33 +0200
Subject: [PATCH] ARM: mx5/mx53_loco: Add support for LED
In-Reply-To: <1306594292-14375-1-git-send-email-festevam@gmail.com>
References: <1306594292-14375-1-git-send-email-festevam@gmail.com>
Message-ID: <20110528175033.GG9907@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Fabio,

On Sat, May 28, 2011 at 11:51:32AM -0300, Fabio Estevam wrote:
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/mach-mx5/Kconfig           |    1 +
>  arch/arm/mach-mx5/board-mx53_loco.c |   17 ++++++++++++++++-
>  2 files changed, 17 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
> index 799fbc4..ab0e8d6 100644
> --- a/arch/arm/mach-mx5/Kconfig
> +++ b/arch/arm/mach-mx5/Kconfig
> @@ -199,6 +199,7 @@ config MACH_MX53_LOCO
>  	select IMX_HAVE_PLATFORM_IMX_UART
>  	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
>  	select IMX_HAVE_PLATFORM_GPIO_KEYS
> +	select LEDS_GPIO_REGISTER
>  	help
>  	  Include support for MX53 LOCO platform. This includes specific
>  	  configurations for the board and its peripherals.
> diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
> index 1b947e8..3b3bf75 100644
> --- a/arch/arm/mach-mx5/board-mx53_loco.c
> +++ b/arch/arm/mach-mx5/board-mx53_loco.c
> @@ -38,6 +38,7 @@
>  #define MX53_LOCO_UI1			IMX_GPIO_NR(2, 14)
>  #define MX53_LOCO_UI2			IMX_GPIO_NR(2, 15)
>  #define LOCO_FEC_PHY_RST		IMX_GPIO_NR(7, 6)
> +#define LOCO_LED			IMX_GPIO_NR(7, 7)
>  
>  static iomux_v3_cfg_t mx53_loco_pads[] = {
>  	/* FEC */
unrelated to this patch, mx53_loco_pads could be __initconst, too.

> @@ -163,7 +164,7 @@ static iomux_v3_cfg_t mx53_loco_pads[] = {
>  	MX53_PAD_GPIO_7__SPDIF_PLOCK,
>  	MX53_PAD_GPIO_17__SPDIF_OUT1,
>  	/* GPIO */
> -	MX53_PAD_PATA_DA_1__GPIO7_7,
> +	MX53_PAD_PATA_DA_1__GPIO7_7,		/* LED */
>  	MX53_PAD_PATA_DA_2__GPIO7_8,
>  	MX53_PAD_PATA_DATA5__GPIO2_5,
>  	MX53_PAD_PATA_DATA6__GPIO2_6,
> @@ -225,6 +226,19 @@ static const struct imxi2c_platform_data mx53_loco_i2c_data __initconst = {
>  	.bitrate = 100000,
>  };
>  
> +static const struct gpio_led mx53loco_leds[] __initconst = {
> +	{
> +		.name			= "green",
> +		.default_trigger	= "heartbeat",
> +		.gpio			= LOCO_LED,
> +	},
> +};
> +
> +static const struct gpio_led_platform_data mx53loco_leds_data __initconst = {
> +	.leds		= mx53loco_leds,
> +	.num_leds	= ARRAY_SIZE(mx53loco_leds),
> +};
> +
>  static void __init mx53_loco_board_init(void)
>  {
>  	mxc_iomux_v3_setup_multiple_pads(mx53_loco_pads,
> @@ -238,6 +252,7 @@ static void __init mx53_loco_board_init(void)
>  	imx53_add_sdhci_esdhc_imx(0, NULL);
>  	imx53_add_sdhci_esdhc_imx(2, NULL);
>  	imx_add_gpio_keys(&loco_button_data);
> +	gpio_led_register_device(-1, &mx53loco_leds_data);
>  }
>  
>  static void __init mx53_loco_timer_init(void)
Looks good,

Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

> -- 
> 1.6.0.4
> 
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
