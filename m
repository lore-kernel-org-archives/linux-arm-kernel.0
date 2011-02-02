From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 3 Feb 2011 00:59:08 +0100
Subject: [PATCH 3/6] PalmTC: switch to using gpio-vbus transceiver
In-Reply-To: <1296666003-31647-4-git-send-email-dbaryshkov@gmail.com>
References: <1296666003-31647-1-git-send-email-dbaryshkov@gmail.com>
	<1296666003-31647-4-git-send-email-dbaryshkov@gmail.com>
Message-ID: <201102030059.08589.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 February 2011 18:00:00 Dmitry Eremin-Solenikov wrote:
> Switch from handling gpio-vbus in pxa25x_udc to using standard gpio-vbus
> tranceiver.
> 
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> Cc: Marek Vasut <marek.vasut@gmail.com>

Looks good

Acked-by: Marek Vasut <marek.vasut@gmail.com>
> ---
>  arch/arm/mach-pxa/palmtc.c |   14 ++++++++++++--
>  1 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/palmtc.c b/arch/arm/mach-pxa/palmtc.c
> index 2131d58..fcc4490 100644
> --- a/arch/arm/mach-pxa/palmtc.c
> +++ b/arch/arm/mach-pxa/palmtc.c
> @@ -25,6 +25,7 @@
>  #include <linux/power_supply.h>
>  #include <linux/gpio_keys.h>
>  #include <linux/mtd/physmap.h>
> +#include <linux/usb/gpio_vbus.h>
> 
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
> @@ -294,12 +295,21 @@ static struct platform_device palmtc_keyboard = {
>  /*************************************************************************
> ***** * UDC
>  
> **************************************************************************
> ****/ -static struct pxa2xx_udc_mach_info palmtc_udc_info __initdata = {
> +static struct gpio_vbus_mach_info palmtc_udc_info = {
>  	.gpio_vbus		= GPIO_NR_PALMTC_USB_DETECT_N,
>  	.gpio_vbus_inverted	= 1,
>  	.gpio_pullup		= GPIO_NR_PALMTC_USB_POWER,
>  };
> 
> +static struct platform_device palmtc_gpio_vbus = {
> +	.name	= "gpio-vbus",
> +	.id	= -1,
> +	.dev	= {
> +		.platform_data	= &palmtc_udc_info,
> +	},
> +};
> +
> +
>  /*************************************************************************
> ***** * Touchscreen / Battery / GPIO-extender
>  
> **************************************************************************
> ****/ @@ -391,6 +401,7 @@ static struct platform_device *devices[]
> __initdata = { &palmtc_keyboard,
>  	&palmtc_pxa_keys,
>  	&palmtc_flash,
> +	&palmtc_gpio_vbus,
>  };
> 
>  static void __init palmtc_init(void)
> @@ -404,7 +415,6 @@ static void __init palmtc_init(void)
> 
>  	set_pxa_fb_info(&palmtc_lcd_screen);
>  	pxa_set_mci_info(&palmtc_mci_platform_data);
> -	pxa_set_udc_info(&palmtc_udc_info);
>  	pxa_set_ac97_info(NULL);
>  	pxa_set_ficp_info(&palmtc_ficp_platform_data);
