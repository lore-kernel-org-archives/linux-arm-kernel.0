From: marex@denx.de (Marek Vasut)
Date: Sun, 28 Oct 2012 22:59:46 +0100
Subject: [PATCH 2/5] ARM: PXA: Zipit Z2: Add USB host and device support
In-Reply-To: <1351438555-4668-2-git-send-email-anarsoul@gmail.com>
References: <1351438555-4668-1-git-send-email-anarsoul@gmail.com>
 <1351438555-4668-2-git-send-email-anarsoul@gmail.com>
Message-ID: <201210282259.46491.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Vasily Khoruzhick,

missing commit message.

> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  arch/arm/mach-pxa/z2.c | 52
> ++++++++++++++++++++++++++++++++++++++++++++++++++ 1 file changed, 52
> insertions(+)
> 
> diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
> index c97485f..ce90fa9 100644
> --- a/arch/arm/mach-pxa/z2.c
> +++ b/arch/arm/mach-pxa/z2.c
> @@ -41,6 +41,9 @@
>  #include <linux/platform_data/mmc-pxamci.h>
>  #include <linux/platform_data/keypad-pxa27x.h>
>  #include <mach/pm.h>
> +#include <mach/pxa27x-udc.h>
> +#include <mach/udc.h>
> +#include <linux/platform_data/usb-ohci-pxa27x.h>
> 
>  #include "generic.h"
>  #include "devices.h"
> @@ -680,6 +683,52 @@ static void __init z2_pmic_init(void)
>  static inline void z2_pmic_init(void) {}
>  #endif
> 
> +/*************************************************************************
> ***** + * USB Switch
> +
> **************************************************************************
> ****/ +static struct platform_device z2_usb_switch = {
> +	.name		= "z2-usb-switch",
> +	.id		= -1,
> +};
> +
> +static void __init z2_usb_switch_init(void)
> +{
> +	platform_device_register(&z2_usb_switch);
> +}
> +
> +/*************************************************************************
> ***** + * USB Gadget
> +
> **************************************************************************
> ****/ +#if defined(CONFIG_USB_GADGET_PXA27X) \
> +	|| defined(CONFIG_USB_GADGET_PXA27X_MODULE)
> +static int z2_udc_is_connected(void)
> +{
> +	return 1;
> +}
> +
> +static struct pxa2xx_udc_mach_info z2_udc_info __initdata = {
> +	.udc_is_connected	= z2_udc_is_connected,
> +	.gpio_pullup		= -1,
> +};
> +
> +static void __init z2_udc_init(void)
> +{
> +	pxa_set_udc_info(&z2_udc_info);
> +}
> +#else
> +static inline void z2_udc_init(void) {}
> +#endif

We really should work on the DT here.

> +/*************************************************************************
> ***** + * USB Host (OHCI)
> +
> **************************************************************************
> ****/ +static struct pxaohci_platform_data z2_ohci_platform_data = {
> +	.port_mode	= PMM_PERPORT_MODE,
> +	.flags		= ENABLE_PORT2 | NO_OC_PROTECTION,
> +	.power_on_delay	= 10,
> +	.power_budget	= 500,
> +};
> +
>  #ifdef CONFIG_PM
>  static void z2_power_off(void)
>  {
> @@ -705,10 +754,12 @@ static void __init z2_init(void)
>  	pxa_set_ffuart_info(NULL);
>  	pxa_set_btuart_info(NULL);
>  	pxa_set_stuart_info(NULL);
> +	pxa_set_ohci_info(&z2_ohci_platform_data);
> 
>  	z2_lcd_init();
>  	z2_mmc_init();
>  	z2_mkp_init();
> +	z2_udc_init();

This patch adds _host_ ? So why do you have udc in here ?

Besides, pxa_set_ohci_info() should also be wrapped in some z2_uhc_init()

>  	z2_i2c_init();
>  	z2_spi_init();
>  	z2_nor_init();
> @@ -716,6 +767,7 @@ static void __init z2_init(void)
>  	z2_leds_init();
>  	z2_keys_init();
>  	z2_pmic_init();
> +	z2_usb_switch_init();
> 
>  	pm_power_off = z2_power_off;
>  }

Best regards,
Marek Vasut
