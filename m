From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 2 Mar 2011 09:46:37 +0100
Subject: [PATCH 2/2] ARM MX53_LOCO: add pwm backlight device
In-Reply-To: <1298972303-1010-2-git-send-email-b02280@freescale.com>
References: <1298972303-1010-1-git-send-email-b02280@freescale.com>
	<1298972303-1010-2-git-send-email-b02280@freescale.com>
Message-ID: <20110302084637.GS29521@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 01, 2011 at 05:38:23PM +0800, Jason Chen wrote:
> Signed-off-by: Jason Chen <b02280@freescale.com>
> ---
>  arch/arm/mach-mx5/Kconfig           |    1 +
>  arch/arm/mach-mx5/board-mx53_loco.c |   11 +++++++++++
>  arch/arm/mach-mx5/devices-imx53.h   |    4 ++++
>  3 files changed, 16 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
> index f065a0d..baf5223 100644
> --- a/arch/arm/mach-mx5/Kconfig
> +++ b/arch/arm/mach-mx5/Kconfig
> @@ -162,6 +162,7 @@ config MACH_MX53_LOCO
>  	select IMX_HAVE_PLATFORM_IMX2_WDT
>  	select IMX_HAVE_PLATFORM_IMX_I2C
>  	select IMX_HAVE_PLATFORM_IMX_UART
> +	select IMX_HAVE_PLATFORM_MXC_PWM
>  	help
>  	  Include support for MX53 LOCO platform. This includes specific
>  	  configurations for the board and its peripherals.
> diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
> index 160899e..3b0b200 100644
> --- a/arch/arm/mach-mx5/board-mx53_loco.c
> +++ b/arch/arm/mach-mx5/board-mx53_loco.c
> @@ -23,6 +23,7 @@
>  #include <linux/fec.h>
>  #include <linux/delay.h>
>  #include <linux/gpio.h>
> +#include <linux/pwm_backlight.h>
>  
>  #include <mach/common.h>
>  #include <mach/hardware.h>
> @@ -203,6 +204,13 @@ static const struct imxi2c_platform_data mx53_loco_i2c_data __initconst = {
>  	.bitrate = 100000,
>  };
>  
> +static struct platform_pwm_backlight_data loco_pwm_backlight_data = {
> +	.pwm_id = 1,
> +	.max_brightness = 255,
> +	.dft_brightness = 128,
> +	.pwm_period_ns = 50000,
> +};
> +
>  static void __init mx53_loco_board_init(void)
>  {
>  	mxc_iomux_v3_setup_multiple_pads(mx53_loco_pads,
> @@ -213,6 +221,9 @@ static void __init mx53_loco_board_init(void)
>  	imx53_add_imx2_wdt(0, NULL);
>  	imx53_add_imx_i2c(0, &mx53_loco_i2c_data);
>  	imx53_add_imx_i2c(1, &mx53_loco_i2c_data);
> +
> +	imx53_add_mxc_pwm(1);
> +	imx53_add_mxc_pwm_backlight(0, &loco_pwm_backlight_data);
>  }
>  
>  static void __init mx53_loco_timer_init(void)
> diff --git a/arch/arm/mach-mx5/devices-imx53.h b/arch/arm/mach-mx5/devices-imx53.h
> index 5a1d6c9..e9c5661 100644
> --- a/arch/arm/mach-mx5/devices-imx53.h
> +++ b/arch/arm/mach-mx5/devices-imx53.h
> @@ -37,3 +37,7 @@ extern const struct imx_imx2_wdt_data imx53_imx2_wdt_data[] __initconst;
>  extern const struct imx_mxc_pwm_data imx53_mxc_pwm_data[] __initconst;
>  #define imx53_add_mxc_pwm(id)	\
>  	imx_add_mxc_pwm(&imx53_mxc_pwm_data[id])
> +
> +#define imx53_add_mxc_pwm_backlight(id, pdata)			\
> +	imx_add_platform_device("pwm-backlight", id, NULL,	\
> +			0, pdata, sizeof(*pdata));


No. There is nothing i.MX53 specific in this, not even i.MX specific.
Please just add a static struct platform_device or maybe
platform_device_register_resndata.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
