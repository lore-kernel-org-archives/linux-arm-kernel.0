From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 14 Sep 2011 11:37:30 +0800
Subject: [PATCH] ARM: mach-mxs/mx28evk: Only register devices if their
	GPIO requests succeeded
In-Reply-To: <1315945519-15178-1-git-send-email-festevam@gmail.com>
References: <1315945519-15178-1-git-send-email-festevam@gmail.com>
Message-ID: <20110914033729.GB2638@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 13, 2011 at 05:25:19PM -0300, Fabio Estevam wrote:
> Currently framebuffer and MMC devices are registered even if their associated 
> GPIO pins fail to be requested.
> 
> Change the logic so that the registration of such devices only occurs if their 
> GPIO requests succeeded.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/mach-mxs/mach-mx28evk.c |   18 ++++++++++++------
>  1 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
> index 3f86e7a..e5c66a2 100644
> --- a/arch/arm/mach-mxs/mach-mx28evk.c
> +++ b/arch/arm/mach-mxs/mach-mx28evk.c
> @@ -353,7 +353,7 @@ static struct mxs_mmc_platform_data mx28evk_mmc_pdata[] __initdata = {
>  
>  static void __init mx28evk_init(void)
>  {
> -	int ret;
> +	int ret, gpio_lcd_error;

Shouldn't gpio_lcd_error be initialized as 0?

>  
>  	mxs_iomux_setup_multiple_pads(mx28evk_pads, ARRAY_SIZE(mx28evk_pads));
>  
> @@ -378,18 +378,23 @@ static void __init mx28evk_init(void)
>  	}
>  
>  	ret = gpio_request_one(MX28EVK_LCD_ENABLE, GPIOF_DIR_OUT, "lcd-enable");
> -	if (ret)
> +	if (ret) {
>  		pr_warn("failed to request gpio lcd-enable: %d\n", ret);
> +		gpio_lcd_error = 1;
> +	}
>  	else
>  		gpio_set_value(MX28EVK_LCD_ENABLE, 1);

Per Documentation/CodingStyle, this should be like the following.

if (condition) {
        do_this();
        do_that();
} else {
        otherwise();
}

>  
>  	ret = gpio_request_one(MX28EVK_BL_ENABLE, GPIOF_DIR_OUT, "bl-enable");
> -	if (ret)
> +	if (ret) {
>  		pr_warn("failed to request gpio bl-enable: %d\n", ret);
> +		gpio_lcd_error = 1;
> +	}
>  	else
>  		gpio_set_value(MX28EVK_BL_ENABLE, 1);

Ditto

Otherwise, Acked-by: Shawn Guo <shawn.guo@linaro.org>

Regards,
Shawn

>  
> -	mx28_add_mxsfb(&mx28evk_mxsfb_pdata);
> +	if (!gpio_lcd_error)
> +		mx28_add_mxsfb(&mx28evk_mxsfb_pdata);
>  
>  	/* power on mmc slot by writing 0 to the gpio */
>  	ret = gpio_request_one(MX28EVK_MMC0_SLOT_POWER, GPIOF_OUT_INIT_LOW,
> @@ -402,8 +407,9 @@ static void __init mx28evk_init(void)
>  			       "mmc1-slot-power");
>  	if (ret)
>  		pr_warn("failed to request gpio mmc1-slot-power: %d\n", ret);
> -	mx28_add_mxs_mmc(1, &mx28evk_mmc_pdata[1]);
> -
> +	else
> +		mx28_add_mxs_mmc(1, &mx28evk_mmc_pdata[1]);
> +
>  	gpio_led_register_device(0, &mx28evk_led_data);
>  }
>  
> -- 
> 1.7.1
