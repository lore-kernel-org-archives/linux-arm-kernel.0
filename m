From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 31 May 2012 20:04:08 +0200
Subject: [PATCH] Visstrim M10: fix gpio handling.
In-Reply-To: <1338376389-32256-1-git-send-email-javier.martin@vista-silicon.com>
References: <1338376389-32256-1-git-send-email-javier.martin@vista-silicon.com>
Message-ID: <20120531180408.GV30400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2012 at 01:13:09PM +0200, Javier Martin wrote:
> Some GPIOs in Visstrim M10 are used without being registered.
> This leads to USB and video malfunctions. This patch registers
> those GPIOs to solve the issue.
> 
> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
> ---
>  arch/arm/mach-imx/mach-imx27_visstrim_m10.c |   13 ++++++++-----
>  1 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
> index e8741f9..db4aa6f 100644
> --- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
> +++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
> @@ -116,6 +116,8 @@ static const int visstrim_m10_pins[] __initconst = {
>  	PB23_PF_USB_PWR,
>  	PB24_PF_USB_OC,
>  	/* CSI */
> +	TVP5150_RSTN | GPIO_GPIO | GPIO_OUT,
> +	TVP5150_PWDN | GPIO_GPIO | GPIO_OUT,
>  	PB10_PF_CSI_D0,
>  	PB11_PF_CSI_D1,
>  	PB12_PF_CSI_D2,
> @@ -182,10 +184,10 @@ static void __init visstrim_camera_init(void)
>  	int dma;
>  
>  	/* Initialize tvp5150 gpios */
> -	mxc_gpio_mode(TVP5150_RSTN | GPIO_GPIO | GPIO_OUT);
> -	mxc_gpio_mode(TVP5150_PWDN | GPIO_GPIO | GPIO_OUT);
> -	gpio_set_value(TVP5150_RSTN, 1);
> -	gpio_set_value(TVP5150_PWDN, 0);
> +	gpio_request_one(TVP5150_RSTN, GPIOF_DIR_OUT | GPIOF_INIT_HIGH,
> +			 "tvp5150_rstn");
> +	gpio_request_one(TVP5150_PWDN, GPIOF_DIR_OUT | GPIOF_INIT_LOW,
> +			 "tvp5150_pwdn");
>  	ndelay(1);
>  
>  	gpio_set_value(TVP5150_PWDN, 1);
> @@ -414,7 +416,8 @@ static struct i2c_board_info visstrim_m10_i2c_devices[] = {
>  /* USB OTG */
>  static int otg_phy_init(struct platform_device *pdev)
>  {
> -	gpio_set_value(OTG_PHY_CS_GPIO, 0);
> +	gpio_request_one(OTG_PHY_CS_GPIO, GPIOF_DIR_OUT | GPIOF_INIT_LOW,
> +			 "usbotg_cs");

Could you please combine all gpios for your board into a single
gpio_request_array? Then you can add proper error checking aswell
without much overhead.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
