From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 31 Jan 2012 23:31:00 +0800
Subject: [PATCH v2] ARM: mx28evk: Simplify GPIO requests
In-Reply-To: <1327675952-11443-1-git-send-email-fabio.estevam@freescale.com>
References: <1327329709-25545-1-git-send-email-fabio.estevam@freescale.com>
 <1327675952-11443-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20120131153057.GE26436@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2012 at 12:52:32PM -0200, Fabio Estevam wrote:
> Requesting all the GPIOs on a single array (mx28evk_gpios[]) can make the 
> error handling of gpio_requests much simpler.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied with one makeup blank line below added.  Thanks.

> ---
> Changes since v1:
> - Removed empty line
> - Leave gpio_set_value(MX28EVK_FEC_PHY_RESET, 0) prior to the delay line in fec_reset
> - Put __initconst after mx28evk_gpios[]
>  arch/arm/mach-mxs/mach-mx28evk.c |   71 ++++++++------------------------------
>  1 files changed, 15 insertions(+), 56 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
> index fdb0a56..dad053d 100644
> --- a/arch/arm/mach-mxs/mach-mx28evk.c
> +++ b/arch/arm/mach-mxs/mach-mx28evk.c
> @@ -223,7 +223,6 @@ static const struct gpio_led_platform_data mx28evk_led_data __initconst = {
>  /* fec */
>  static void __init mx28evk_fec_reset(void)
>  {
> -	int ret;
>  	struct clk *clk;
>  
>  	/* Enable fec phy clock */
> @@ -231,32 +230,7 @@ static void __init mx28evk_fec_reset(void)
>  	if (!IS_ERR(clk))
>  		clk_prepare_enable(clk);
>  
> -	/* Power up fec phy */
> -	ret = gpio_request(MX28EVK_FEC_PHY_POWER, "fec-phy-power");
> -	if (ret) {
> -		pr_err("Failed to request gpio fec-phy-%s: %d\n", "power", ret);
> -		return;
> -	}
> -
> -	ret = gpio_direction_output(MX28EVK_FEC_PHY_POWER, 0);
> -	if (ret) {
> -		pr_err("Failed to drive gpio fec-phy-%s: %d\n", "power", ret);
> -		return;
> -	}
> -
> -	/* Reset fec phy */
> -	ret = gpio_request(MX28EVK_FEC_PHY_RESET, "fec-phy-reset");
> -	if (ret) {
> -		pr_err("Failed to request gpio fec-phy-%s: %d\n", "reset", ret);
> -		return;
> -	}
> -
> -	gpio_direction_output(MX28EVK_FEC_PHY_RESET, 0);
> -	if (ret) {
> -		pr_err("Failed to drive gpio fec-phy-%s: %d\n", "reset", ret);
> -		return;
> -	}
> -
> +	gpio_set_value(MX28EVK_FEC_PHY_RESET, 0);
>  	mdelay(1);
>  	gpio_set_value(MX28EVK_FEC_PHY_RESET, 1);
>  }
> @@ -417,9 +391,14 @@ static void __init mx28evk_add_regulators(void)
>  static void __init mx28evk_add_regulators(void) {}
>  #endif
>  
> -static struct gpio mx28evk_lcd_gpios[] = {
> +static const struct gpio mx28evk_gpios[] __initconst = {
>  	{ MX28EVK_LCD_ENABLE, GPIOF_OUT_INIT_HIGH, "lcd-enable" },
>  	{ MX28EVK_BL_ENABLE, GPIOF_OUT_INIT_HIGH, "bl-enable" },
> +	{ MX28EVK_FLEXCAN_SWITCH, GPIOF_DIR_OUT, "flexcan-switch" },
> +	{ MX28EVK_MMC0_SLOT_POWER, GPIOF_OUT_INIT_LOW, "mmc0-slot-power" },
> +	{ MX28EVK_MMC1_SLOT_POWER, GPIOF_OUT_INIT_LOW, "mmc1-slot-power" },
> +	{ MX28EVK_FEC_PHY_POWER, GPIOF_OUT_INIT_LOW, "fec-phy-power" },
> +	{ MX28EVK_FEC_PHY_RESET, GPIOF_DIR_OUT, "fec-phy-reset" },
>  };
>  
>  static const struct mxs_saif_platform_data
> @@ -447,25 +426,17 @@ static void __init mx28evk_init(void)
>  	if (mx28evk_fec_get_mac())
>  		pr_warn("%s: failed on fec mac setup\n", __func__);
>  
> +	ret = gpio_request_array(mx28evk_gpios, ARRAY_SIZE(mx28evk_gpios));
> +	if (ret)
> +		pr_err("One or more GPIOs failed to be requested: %d\n", ret);

Here, I added one blank line.

Regards,
Shawn

>  	mx28evk_fec_reset();
>  	mx28_add_fec(0, &mx28_fec_pdata[0]);
>  	mx28_add_fec(1, &mx28_fec_pdata[1]);
>  
> -	ret = gpio_request_one(MX28EVK_FLEXCAN_SWITCH, GPIOF_DIR_OUT,
> -				"flexcan-switch");
> -	if (ret) {
> -		pr_err("failed to request gpio flexcan-switch: %d\n", ret);
> -	} else {
> -		mx28_add_flexcan(0, &mx28evk_flexcan_pdata[0]);
> -		mx28_add_flexcan(1, &mx28evk_flexcan_pdata[1]);
> -	}
> +	mx28_add_flexcan(0, &mx28evk_flexcan_pdata[0]);
> +	mx28_add_flexcan(1, &mx28evk_flexcan_pdata[1]);
>  
> -	ret = gpio_request_array(mx28evk_lcd_gpios,
> -				 ARRAY_SIZE(mx28evk_lcd_gpios));
> -	if (ret)
> -		pr_warn("failed to request gpio pins for lcd: %d\n", ret);
> -	else
> -		mx28_add_mxsfb(&mx28evk_mxsfb_pdata);
> +	mx28_add_mxsfb(&mx28evk_mxsfb_pdata);
>  
>  	mxs_saif_clkmux_select(MXS_DIGCTL_SAIF_CLKMUX_EXTMSTR0);
>  	mx28_add_saif(0, &mx28evk_mxs_saif_pdata[0]);
> @@ -480,20 +451,8 @@ static void __init mx28evk_init(void)
>  	mxs_add_platform_device("mxs-sgtl5000", 0, NULL, 0,
>  			NULL, 0);
>  
> -	/* power on mmc slot by writing 0 to the gpio */
> -	ret = gpio_request_one(MX28EVK_MMC0_SLOT_POWER, GPIOF_OUT_INIT_LOW,
> -			       "mmc0-slot-power");
> -	if (ret)
> -		pr_warn("failed to request gpio mmc0-slot-power: %d\n", ret);
> -	else
> -		mx28_add_mxs_mmc(0, &mx28evk_mmc_pdata[0]);
> -
> -	ret = gpio_request_one(MX28EVK_MMC1_SLOT_POWER, GPIOF_OUT_INIT_LOW,
> -			       "mmc1-slot-power");
> -	if (ret)
> -		pr_warn("failed to request gpio mmc1-slot-power: %d\n", ret);
> -	else
> -		mx28_add_mxs_mmc(1, &mx28evk_mmc_pdata[1]);
> +	mx28_add_mxs_mmc(0, &mx28evk_mmc_pdata[0]);
> +	mx28_add_mxs_mmc(1, &mx28evk_mmc_pdata[1]);
>  
>  	mx28_add_rtc_stmp3xxx();
>  
> -- 
> 1.7.1
