From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 5 Jan 2010 13:11:18 +0100
Subject: [PATCH 1/3] mx31ads: Convert 1133-EV1 to use dev_name to
	specify consumer devices
In-Reply-To: <1262629491-18942-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1262629491-18942-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <20100105121118.GF6923@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 04, 2010 at 06:24:49PM +0000, Mark Brown wrote:
> This means we don't need to go running round working out struct
> devices at runtime.

Ok, scheduled for -next.

Sascha

> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  arch/arm/mach-mx3/mx31ads.c |   14 ++------------
>  1 files changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/mach-mx3/mx31ads.c b/arch/arm/mach-mx3/mx31ads.c
> index 0497c15..cda570b 100644
> --- a/arch/arm/mach-mx3/mx31ads.c
> +++ b/arch/arm/mach-mx3/mx31ads.c
> @@ -307,12 +307,8 @@ static struct regulator_init_data ldo1_data = {
>  };
>  
>  static struct regulator_consumer_supply ldo2_consumers[] = {
> -	{
> -		.supply = "AVDD",
> -	},
> -	{
> -		.supply = "HPVDD",
> -	},
> +	{ .supply = "AVDD", .dev_name = "1-001a" },
> +	{ .supply = "HPVDD", .dev_name = "1-001a" },
>  };
>  
>  /* CODEC and SIM */
> @@ -382,8 +378,6 @@ static struct wm8350_audio_platform_data imx32ads_wm8350_setup = {
>  
>  static int mx31_wm8350_init(struct wm8350 *wm8350)
>  {
> -	int i;
> -
>  	wm8350_gpio_config(wm8350, 0, WM8350_GPIO_DIR_IN,
>  			   WM8350_GPIO0_PWR_ON_IN, WM8350_GPIO_ACTIVE_LOW,
>  			   WM8350_GPIO_PULL_UP, WM8350_GPIO_INVERT_OFF,
> @@ -419,10 +413,6 @@ static int mx31_wm8350_init(struct wm8350 *wm8350)
>  			   WM8350_GPIO_PULL_NONE, WM8350_GPIO_INVERT_OFF,
>  			   WM8350_GPIO_DEBOUNCE_OFF);
>  
> -	/* Fix up for our own supplies. */
> -	for (i = 0; i < ARRAY_SIZE(ldo2_consumers); i++)
> -		ldo2_consumers[i].dev = wm8350->dev;
> -
>  	wm8350_register_regulator(wm8350, WM8350_DCDC_1, &sw1a_data);
>  	wm8350_register_regulator(wm8350, WM8350_DCDC_3, &viohi_data);
>  	wm8350_register_regulator(wm8350, WM8350_DCDC_4, &violo_data);
> -- 
> 1.6.5.7
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
