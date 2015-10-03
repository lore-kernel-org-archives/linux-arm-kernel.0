From: philipp.zabel@gmail.com (Philipp Zabel)
Date: Sat, 03 Oct 2015 14:58:47 +0200
Subject: [PATCH v4 21/26] ARM: pxa: magician: Add support for PXA27x UDC
In-Reply-To: <5609B395.8040800@tul.cz>
References: <cover.1443472089.git.petr.cvek@tul.cz> <5609B395.8040800@tul.cz>
Message-ID: <1443877127.4186.39.camel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 28.09.2015, 23:39 +0200 schrieb Petr Cvek:
> A PXA27x SoC supports USB device mode, this patch adds support for
> that.
> 
> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
> ---
>  arch/arm/mach-pxa/magician.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach
> -pxa/magician.c
> index 490d79f..331dfd1 100644
> --- a/arch/arm/mach-pxa/magician.c
> +++ b/arch/arm/mach-pxa/magician.c
> @@ -54,6 +54,10 @@
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
> @@ -582,6 +586,23 @@ static struct platform_device pasic3 = {
>   * PXA UDC
>   */

This comment should be part of this patch.

> +static void magician_udc_command(int cmd)
> +{
> +	if (cmd == PXA2XX_UDC_CMD_CONNECT)
> +		UP2OCR |= UP2OCR_DPPUE | UP2OCR_DPPUBE;
> +	else if (cmd == PXA2XX_UDC_CMD_DISCONNECT)
> +		UP2OCR &= ~(UP2OCR_DPPUE | UP2OCR_DPPUBE);
> +}
> +
> +static struct pxa2xx_udc_mach_info magician_udc_info __initdata = {
> +	.udc_command	= magician_udc_command,
> +	.gpio_pullup	= GPIO27_MAGICIAN_USBC_PUEN,
> +};
> +
> +/*
> + * USB device VUSB detection
> + */
> +

Move this comment to the earlier comment fixup patch.

Otherwise,
Acked-by: Philipp Zabel <philipp.zabel@gmail.com>

regards
Philipp
