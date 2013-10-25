From: nm@ti.com (Nishanth Menon)
Date: Fri, 25 Oct 2013 05:18:45 -0500
Subject: [PATCH 3/3] ARM: OMAP2: omap4-sdp: remove unneeded gpios from
 dss-common
In-Reply-To: <1382695658-18757-3-git-send-email-tomi.valkeinen@ti.com>
References: <1382695658-18757-1-git-send-email-tomi.valkeinen@ti.com>
 <1382695658-18757-3-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <526A4585.30403@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/25/2013 05:07 AM, Tomi Valkeinen wrote:
> DISPLAY_SEL_GPIO and DLP_POWER_ON_GPIO are now handled in the .dts file,
> so we can remove them from dss-common.c.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  arch/arm/mach-omap2/dss-common.c | 21 ---------------------
>  1 file changed, 21 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/dss-common.c b/arch/arm/mach-omap2/dss-common.c
> index bf89eff..cc70cf9 100644
> --- a/arch/arm/mach-omap2/dss-common.c
> +++ b/arch/arm/mach-omap2/dss-common.c
> @@ -113,9 +113,6 @@ void __init omap4_panda_display_init_of(void)
>  
>  /* OMAP4 Blaze display data */
>  
> -#define DISPLAY_SEL_GPIO	59	/* LCD2/PicoDLP switch */
> -#define DLP_POWER_ON_GPIO	40
> -
>  static struct panel_dsicm_platform_data dsi1_panel = {
>  	.name		= "lcd",
>  	.source		= "dsi.0",
> @@ -185,26 +182,8 @@ static struct omap_dss_board_info sdp4430_dss_data = {
>  	.default_display_name = "lcd",
>  };
>  
> -/*
> - * we select LCD2 by default (instead of Pico DLP) by setting DISPLAY_SEL_GPIO.
> - * Setting DLP_POWER_ON gpio enables the VDLP_2V5 VDLP_1V8 and VDLP_1V0 rails
> - * used by picodlp on the 4430sdp platform. Keep this gpio disabled as LCD2 is
> - * selected by default
> - */
>  void __init omap_4430sdp_display_init_of(void)
>  {
> -	int r;
> -
> -	r = gpio_request_one(DISPLAY_SEL_GPIO, GPIOF_OUT_INIT_HIGH,
> -			"display_sel");
> -	if (r)
> -		pr_err("%s: Could not get display_sel GPIO\n", __func__);
> -
> -	r = gpio_request_one(DLP_POWER_ON_GPIO, GPIOF_OUT_INIT_LOW,
> -		"DLP POWER ON");
> -	if (r)
> -		pr_err("%s: Could not get DLP POWER ON GPIO\n", __func__);
> -
>  	omap_display_init(&sdp4430_dss_data);
>  
>  	platform_device_register(&sdp4430_lcd_device);
> 
would you not be depending on the weak IO pull done using mux to drive
these GPIO pins since the GPIO is not requested and held?

Could we not use Documentation/devicetree/bindings/gpio/gpio.txt
binding to map to the right GPIO and drive it using the GPIO module?

-- 
Regards,
Nishanth Menon
