From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 5 Feb 2013 10:46:21 +0100
Subject: [GIT PULL] ARM: OMAP: Audio support via omap-twl4030 and pwm
 support
In-Reply-To: <20130204195251.GS22517@atomide.com>
References: <50FE64DC.2030808@ti.com> <510788B9.9050907@ti.com>
 <20130130220532.GA22517@atomide.com> <20130204195251.GS22517@atomide.com>
Message-ID: <5110D4ED.6030306@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On 02/04/2013 08:52 PM, Tony Lindgren wrote:
> Looks like this now adds some new section warnings:
> 
> WARNING: vmlinux.o(.text+0x34124): Section mismatch in reference from the function sdp3430_twl_gpio_setup() to the function .init.text:omap_twl4030_audio_init()
> The function sdp3430_twl_gpio_setup() references
> the function __init omap_twl4030_audio_init().
> This is often because sdp3430_twl_gpio_setup lacks a __init 
> annotation or the annotation of omap_twl4030_audio_init is wrong.
> 
> WARNING: vmlinux.o(.text+0x34b8c): Section mismatch in reference from the function zoom_twl_gpio_setup() to the function .init.text:omap_twl4030_audio_init()
> The function zoom_twl_gpio_setup() references
> the function __init omap_twl4030_audio_init().
> This is often because zoom_twl_gpio_setup lacks a __init 
> annotation or the annotation of omap_twl4030_audio_init is wrong.

For some reason the CONFIG_DEBUG_SECTION_MISMATCH got disabled in my rolling
kernel config...


> These can be fixed with the following patch, but I suspect some
> of these cannot be __init/__initdata if the driver reprobes.
> 
> Can you please check this? I'll hold on sendinf off
> this branch until it's been checked and fixed properly.

I think this is not the correct way. the *_twl_gpio_setup() is called from the
gpio-twl4030 driver's platform_driver probe function which if I'm not mistaken
is not __init.

I think we should remove the __init from the omap_twl4030_audio_init() in
twl-common.c
With this change I do not have section mismatch either.

-- 
P?ter

> 
> Regards,
> 
> Tony
> 
> 
> --- a/arch/arm/mach-omap2/board-3430sdp.c
> +++ b/arch/arm/mach-omap2/board-3430sdp.c
> @@ -223,7 +223,7 @@ static struct omap_tw4030_pdata omap_twl4030_audio_data = {
>  	.has_linein	= OMAP_TWL4030_LEFT | OMAP_TWL4030_RIGHT,
>  };
>  
> -static int sdp3430_twl_gpio_setup(struct device *dev,
> +static int __init sdp3430_twl_gpio_setup(struct device *dev,
>  		unsigned gpio, unsigned ngpio)
>  {
>  	/* gpio + 0 is "mmc0_cd" (input/IRQ),
> @@ -245,7 +245,7 @@ static int sdp3430_twl_gpio_setup(struct device *dev,
>  	return 0;
>  }
>  
> -static struct twl4030_gpio_platform_data sdp3430_gpio_data = {
> +static struct twl4030_gpio_platform_data __initdata sdp3430_gpio_data = {
>  	.pulldowns	= BIT(2) | BIT(6) | BIT(8) | BIT(13)
>  				| BIT(16) | BIT(17),
>  	.setup		= sdp3430_twl_gpio_setup,
> @@ -374,7 +374,7 @@ static struct regulator_init_data sdp3430_vsim = {
>  	.consumer_supplies	= sdp3430_vsim_supplies,
>  };
>  
> -static struct twl4030_platform_data sdp3430_twldata = {
> +static struct twl4030_platform_data __initdata sdp3430_twldata = {
>  	/* platform_data for children goes here */
>  	.gpio		= &sdp3430_gpio_data,
>  	.keypad		= &sdp3430_kp_data,
> --- a/arch/arm/mach-omap2/board-zoom-peripherals.c
> +++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
> @@ -238,7 +238,7 @@ static struct omap_tw4030_pdata omap_twl4030_audio_data = {
>  	.has_linein	= OMAP_TWL4030_LEFT | OMAP_TWL4030_RIGHT,
>  };
>  
> -static int zoom_twl_gpio_setup(struct device *dev,
> +static int __init zoom_twl_gpio_setup(struct device *dev,
>  		unsigned gpio, unsigned ngpio)
>  {
>  	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
> @@ -252,11 +252,11 @@ static int zoom_twl_gpio_setup(struct device *dev,
>  	return 0;
>  }
>  
> -static struct twl4030_gpio_platform_data zoom_gpio_data = {
> +static struct twl4030_gpio_platform_data __initdata zoom_gpio_data = {
>  	.setup		= zoom_twl_gpio_setup,
>  };
>  
> -static struct twl4030_platform_data zoom_twldata = {
> +static struct twl4030_platform_data __initdata zoom_twldata = {
>  	/* platform_data for children goes here */
>  	.gpio		= &zoom_gpio_data,
>  	.keypad		= &zoom_kp_twl4030_data,
> 
