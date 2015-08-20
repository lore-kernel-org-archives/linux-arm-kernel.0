From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 20 Aug 2015 19:23:50 +0200
Subject: [PATCH v2 12/21] ARM: pxa: magician: Add PXA27x UDC support
References: <cover.1439843482.git.petr.cvek@tul.cz> <55D25A06.9030507@tul.cz>
Message-ID: <87twrt6fh5.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Petr Cvek <petr.cvek@tul.cz> writes:

> Add support for PXA27x UDC to HTC Magician.
>
> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
> ---
>  arch/arm/mach-pxa/magician.c | 40 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
> index 8ca0b67..23b59a0 100644
> --- a/arch/arm/mach-pxa/magician.c
> +++ b/arch/arm/mach-pxa/magician.c
> @@ -98,6 +98,10 @@
>  
>  #include <linux/regulator/max1586.h>
>  
> +#include <linux/platform_data/pxa2xx_udc.h>
> +#include <mach/udc.h>
> +#include <mach/pxa27x-udc.h>
> +
>  #include "devices.h"
>  #include "generic.h"
>  
> @@ -698,6 +702,34 @@ static struct platform_device magician_camera = {
>   * USB "Transceiver"
>   */
>  
> +#if IS_ENABLED(CONFIG_USB_PXA27X)
No #if please, just let it out of #ifdefery, no need to.

> +static void magician_udc_command(int cmd)
> +{
> +	if (cmd == PXA2XX_UDC_CMD_CONNECT)
> +		UP2OCR |= UP2OCR_DPPUE | UP2OCR_DPPUBE;
> +	else if (cmd == PXA2XX_UDC_CMD_DISCONNECT)
> +		UP2OCR &= ~(UP2OCR_DPPUE | UP2OCR_DPPUBE);
> +}
> +
> +/* HACK, shared USB connected state with pda-power */
> +int my_usb_online = 1;
Definitely not, a global (ie. non static variable) is not something I'll let
in. Besides, can't a "gpio_get_value()" give the same level of information ?

> +static int magician_udc_is_connected(void)
> +{
> +	/* Shared with pda_power or gpio-vbus */
> +	return my_usb_online;
gpio_get_value() something ?

> +}
> +
> +static struct pxa2xx_udc_mach_info magician_udc_info __initdata = {
> +	.udc_command		= magician_udc_command,
> +	.udc_is_connected	= magician_udc_is_connected,
I don't think udc_is_connected is a field used by pxa27x_udc.c, it it ? The VBus
connection information comes from a transciever, usually from gpio_vbus driver
nowadays.

> @@ -1175,6 +1207,11 @@ static struct platform_device *devices[] __initdata = {
>  
>  	/* NOTICE mutually exclusive with PXA I2C */
>  	&i2c_gpio_bus_alt,
> +
> +	/* NOTICE mutually exclusive with UDC*/
Euh why so ?
In arch/arm/mach-pxa/mioa701.c they cooperate, why can't they for magician ?

Cheers.

-- 
Robert
