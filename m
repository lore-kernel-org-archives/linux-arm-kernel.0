From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 25 Aug 2011 08:43:36 +0200
Subject: [PATCH] ARM: mx53_loco: Add support for the accelerometer
In-Reply-To: <1314217895-30699-1-git-send-email-fabio.estevam@freescale.com>
References: <1314217895-30699-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20110825064336.GP31404@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2011 at 05:31:35PM -0300, Fabio Estevam wrote:
> mx53_loco has a MMA8450 accelerometer connected to i2c0.
> 
> Add support for it.

Applied for next.

Sascha

> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/mach-mx5/board-mx53_loco.c |   20 ++++++++++++++++++++
>  1 files changed, 20 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
> index 4e1d51d..145f48e 100644
> --- a/arch/arm/mach-mx5/board-mx53_loco.c
> +++ b/arch/arm/mach-mx5/board-mx53_loco.c
> @@ -22,6 +22,7 @@
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/gpio.h>
> +#include <linux/i2c.h>
>  
>  #include <mach/common.h>
>  #include <mach/hardware.h>
> @@ -42,6 +43,7 @@
>  #define LOCO_SD3_CD			IMX_GPIO_NR(3, 11)
>  #define LOCO_SD3_WP			IMX_GPIO_NR(3, 12)
>  #define LOCO_SD1_CD			IMX_GPIO_NR(3, 13)
> +#define LOCO_ACCEL_EN			IMX_GPIO_NR(6, 14)
>  
>  static iomux_v3_cfg_t mx53_loco_pads[] = {
>  	/* FEC */
> @@ -64,6 +66,10 @@ static iomux_v3_cfg_t mx53_loco_pads[] = {
>  	MX53_PAD_KEY_ROW0__AUDMUX_AUD5_TXD,
>  	MX53_PAD_KEY_COL1__AUDMUX_AUD5_TXFS,
>  	MX53_PAD_KEY_ROW1__AUDMUX_AUD5_RXD,
> +	/* I2C1 */
> +	MX53_PAD_CSI0_DAT8__I2C1_SDA,
> +	MX53_PAD_CSI0_DAT9__I2C1_SCL,
> +	MX53_PAD_NANDF_CS1__GPIO6_14,	/* Accelerometer Enable */
>  	/* I2C2 */
>  	MX53_PAD_KEY_COL3__I2C2_SCL,
>  	MX53_PAD_KEY_ROW3__I2C2_SDA,
> @@ -257,8 +263,15 @@ static const struct gpio_led_platform_data mx53loco_leds_data __initconst = {
>  	.num_leds	= ARRAY_SIZE(mx53loco_leds),
>  };
>  
> +static struct i2c_board_info mx53loco_i2c_devices[] = {
> +	{
> +		I2C_BOARD_INFO("mma8450", 0x1C),
> +	},
> +};
> +
>  static void __init mx53_loco_board_init(void)
>  {
> +	int ret;
>  	imx53_soc_init();
>  
>  	mxc_iomux_v3_setup_multiple_pads(mx53_loco_pads,
> @@ -267,6 +280,13 @@ static void __init mx53_loco_board_init(void)
>  	mx53_loco_fec_reset();
>  	imx53_add_fec(&mx53_loco_fec_data);
>  	imx53_add_imx2_wdt(0, NULL);
> +
> +	ret = gpio_request_one(LOCO_ACCEL_EN, GPIOF_OUT_INIT_HIGH, "accel_en");
> +	if (ret)
> +		pr_err("Cannot request ACCEL_EN pin: %d\n", ret);
> +
> +	i2c_register_board_info(0, mx53loco_i2c_devices,
> +				ARRAY_SIZE(mx53loco_i2c_devices));
>  	imx53_add_imx_i2c(0, &mx53_loco_i2c_data);
>  	imx53_add_imx_i2c(1, &mx53_loco_i2c_data);
>  	imx53_add_sdhci_esdhc_imx(0, &mx53_loco_sd1_data);
> -- 
> 1.6.0.4
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
