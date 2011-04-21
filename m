From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 21 Apr 2011 18:19:37 -0500
Subject: [PATCH v2 02/23] at91: Make Ethernet device common
In-Reply-To: <1303364535-11557-3-git-send-email-ryan@bluewatersys.com>
References: <1303364535-11557-1-git-send-email-ryan@bluewatersys.com>
	<1303364535-11557-3-git-send-email-ryan@bluewatersys.com>
Message-ID: <0D753D10438DA54287A00B027084269764D24302CC@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, April 20, 2011 10:42 PM, Ryan Mallon wrote:
>
> Replace the individual Ethernet device code for each at91 variant with
> a single implementation in devices.
>
> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>

[snip]

> diff --git a/arch/arm/mach-at91/devices.c b/arch/arm/mach-at91/devices.c
> index 6f6e0d5..4ecbd38 100644
> --- a/arch/arm/mach-at91/devices.c
> +++ b/arch/arm/mach-at91/devices.c
> @@ -14,8 +14,11 @@
>   */
>  
>  #include <linux/platform_device.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/gpio.h>
>  
> +#include <mach/board.h>
> +
>  #include "devices.h"
>  
>  static struct at91_device_table *devices __initdata;
> @@ -64,6 +67,64 @@ static inline void __init init_resource_irq(struct resource *res, int irq)
>  	}
>  }
>  
> +/* --------------------------------------------------------------------
> + *  Ethernet
> + * -------------------------------------------------------------------- */
> +
> +#if defined(CONFIG_MACB) || defined(CONFIG_MACB_MODULE)
> +static u64 eth_dmamask = DMA_BIT_MASK(32);
> +static struct at91_eth_data eth_data;
> +
> +static struct resource eth_resources[] = {
> +	[0] = {
> +		.end	= SZ_16K,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.flags	= IORESOURCE_IRQ,
> +	},
> +};
> +
> +static struct platform_device at91_eth_device = {
> +	.name		= "macb",
> +	.id		= -1,
> +	.dev		= {
> +				.dma_mask		= &eth_dmamask,
> +				.coherent_dma_mask	= DMA_BIT_MASK(32),

Doesn't this work also?

+static struct platform_device at91_eth_device = {
+	.name		= "macb",
+	.id		= -1,
+	.dev		= {
+		.dma_mask		= &at91_eth_device.dev.coherent_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),

That will get rid of the static u64 variable used for every dma capable device.

Regards,
Hartley
