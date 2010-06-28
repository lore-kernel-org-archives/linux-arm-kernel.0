From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 28 Jun 2010 11:42:28 +0800
Subject: [PATCH 2/4] pxa/colibri320: Add UDC support
In-Reply-To: <1277388132-5549-2-git-send-email-marek.vasut@gmail.com>
References: <1277388132-5549-1-git-send-email-marek.vasut@gmail.com>
	<1277388132-5549-2-git-send-email-marek.vasut@gmail.com>
Message-ID: <AANLkTinfZB-hznbD60wF9tO_6hI5pG-3EjNZPXksjSVL@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 24, 2010 at 10:02 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> Add support for PXA UDC.
>
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>

Applied.

> ---
> ?arch/arm/mach-pxa/colibri-pxa320.c | ? 40 ++++++++++++++++++++++++++++++++++++
> ?1 files changed, 40 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/colibri-pxa320.c b/arch/arm/mach-pxa/colibri-pxa320.c
> index ae835fa..99e850d 100644
> --- a/arch/arm/mach-pxa/colibri-pxa320.c
> +++ b/arch/arm/mach-pxa/colibri-pxa320.c
> @@ -16,6 +16,7 @@
> ?#include <linux/platform_device.h>
> ?#include <linux/gpio.h>
> ?#include <linux/interrupt.h>
> +#include <linux/usb/gpio_vbus.h>
>
> ?#include <asm/mach-types.h>
> ?#include <asm/sizes.h>
> @@ -28,6 +29,8 @@
> ?#include <mach/pxafb.h>
> ?#include <mach/ohci.h>
> ?#include <mach/audio.h>
> +#include <mach/pxa27x-udc.h>
> +#include <mach/udc.h>
>
> ?#include "generic.h"
> ?#include "devices.h"
> @@ -101,6 +104,42 @@ void __init colibri_pxa320_init_ohci(void)
> ?static inline void colibri_pxa320_init_ohci(void) {}
> ?#endif /* CONFIG_USB_OHCI_HCD || CONFIG_USB_OHCI_HCD_MODULE */
>
> +#if defined(CONFIG_USB_GADGET_PXA27X)||defined(CONFIG_USB_GADGET_PXA27X_MODULE)
> +static struct gpio_vbus_mach_info colibri_pxa320_gpio_vbus_info = {
> + ? ? ? .gpio_vbus ? ? ? ? ? ? ?= mfp_to_gpio(MFP_PIN_GPIO96),
> + ? ? ? .gpio_pullup ? ? ? ? ? ?= -1,
> +};
> +
> +static struct platform_device colibri_pxa320_gpio_vbus = {
> + ? ? ? .name ? = "gpio-vbus",
> + ? ? ? .id ? ? = -1,
> + ? ? ? .dev ? ?= {
> + ? ? ? ? ? ? ? .platform_data ?= &colibri_pxa320_gpio_vbus_info,
> + ? ? ? },
> +};
> +
> +static void colibri_pxa320_udc_command(int cmd)
> +{
> + ? ? ? if (cmd == PXA2XX_UDC_CMD_CONNECT)
> + ? ? ? ? ? ? ? UP2OCR = UP2OCR_HXOE | UP2OCR_DPPUE;
> + ? ? ? else if (cmd == PXA2XX_UDC_CMD_DISCONNECT)
> + ? ? ? ? ? ? ? UP2OCR = UP2OCR_HXOE;
> +}
> +
> +static struct pxa2xx_udc_mach_info colibri_pxa320_udc_info __initdata = {
> + ? ? ? .udc_command ? ? ? ? ? ?= colibri_pxa320_udc_command,
> + ? ? ? .gpio_pullup ? ? ? ? ? ?= -1,
> +};
> +
> +static void __init colibri_pxa320_init_udc(void)
> +{
> + ? ? ? pxa_set_udc_info(&colibri_pxa320_udc_info);
> + ? ? ? platform_device_register(&colibri_pxa320_gpio_vbus);
> +}
> +#else
> +static inline void colibri_pxa320_init_udc(void) {}
> +#endif
> +
> ?static mfp_cfg_t colibri_pxa320_mmc_pin_config[] __initdata = {
> ? ? ? ?GPIO22_MMC1_CLK,
> ? ? ? ?GPIO23_MMC1_CMD,
> @@ -212,6 +251,7 @@ void __init colibri_pxa320_init(void)
> ? ? ? ?colibri_pxa3xx_init_mmc(ARRAY_AND_SIZE(colibri_pxa320_mmc_pin_config),
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?mfp_to_gpio(MFP_PIN_GPIO28));
> ? ? ? ?colibri_pxa320_init_uart();
> + ? ? ? colibri_pxa320_init_udc();
> ?}
>
> ?MACHINE_START(COLIBRI320, "Toradex Colibri PXA320")
> --
> 1.7.1
>
>
