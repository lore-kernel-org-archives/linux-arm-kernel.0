From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 19 Apr 2011 21:10:23 -0500
Subject: [RFC PATCH 02/23] at91: Make Ethernet device common
In-Reply-To: <1303261827-27730-3-git-send-email-ryan@bluewatersys.com>
References: <1303261827-27730-1-git-send-email-ryan@bluewatersys.com>
	<1303261827-27730-3-git-send-email-ryan@bluewatersys.com>
Message-ID: <0D753D10438DA54287A00B027084269764D2329FA6@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, April 19, 2011 6:10 PM, Ryan Mallon wrote:
>
> Replace the individual Ethernet device code for each at91 variant with
> a single implementation in devices.
>
> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>

Nice.

A couple comments below.

[snip]

> diff --git a/arch/arm/mach-at91/at572d940hf_devices.c b/arch/arm/mach-at91/at572d940hf_devices.c
> index 0fc20a2..12af1d5 100644
> --- a/arch/arm/mach-at91/at572d940hf_devices.c
> +++ b/arch/arm/mach-at91/at572d940hf_devices.c
> @@ -35,6 +35,7 @@
>  
>  #include "generic.h"
>  #include "sam9_smc.h"
> +#include "devices.h"
>  
>  
>  /* --------------------------------------------------------------------
> @@ -138,68 +139,26 @@ void __init at91_add_device_udc(struct at91_udc_data *data) {}
>   *  Ethernet
>   * -------------------------------------------------------------------- */
>  
> -#if defined(CONFIG_MACB) || defined(CONFIG_MACB_MODULE)
> -static u64 eth_dmamask = DMA_BIT_MASK(32);
> -static struct at91_eth_data eth_data;
> -
> -static struct resource eth_resources[] = {
> -	[0] = {
> -		.start	= AT572D940HF_BASE_EMAC,
> -		.end	= AT572D940HF_BASE_EMAC + SZ_16K - 1,
> -		.flags	= IORESOURCE_MEM,
> -	},
> -	[1] = {
> -		.start	= AT572D940HF_ID_EMAC,
> -		.end	= AT572D940HF_ID_EMAC,
> -		.flags	= IORESOURCE_IRQ,
> -	},

[snip]

> +static struct __initdata at91_dev_table_ethernet device_eth = {
> +	.mmio_base	= AT91SAM9260_BASE_EMAC,
> +	.irq		= AT91SAM9260_ID_EMAC,

AT572D940HF_BASE_EMAC and AT572D940HF_ID_EMAC?

> +	.rmii_pins	= eth_rmii_pins,
> +	.nr_rmii_pins	= ARRAY_SIZE(eth_rmii_pins),
>  };
> 
> -void __init at91_add_device_eth(struct at91_eth_data *data)
> -{
> -	if (!data)
> -		return;
> -
> -	if (data->phy_irq_pin) {
> -		at91_set_gpio_input(data->phy_irq_pin, 0);
> -		at91_set_deglitch(data->phy_irq_pin, 1);
> -	}
> -
> -	/* Only RMII is supported */
> -	data->is_rmii = 1;

How is this set for this platfrom?

[snip]

diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index 59fc483..3c0959f 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -1044,7 +1044,6 @@ void __init at91_set_serial_console(unsigned portnr) {}
 void __init at91_add_device_serial(void) {}
 #endif
 
-

Nit. Unrelated whitespace change.

[snip]

diff --git a/arch/arm/mach-at91/devices.c b/arch/arm/mach-at91/devices.c
index 653e0a9..07fefc8 100644
--- a/arch/arm/mach-at91/devices.c
+++ b/arch/arm/mach-at91/devices.c

[snip]

> +static struct platform_device at91_eth_device = {
> +	.name		= "macb",
> +	.id		= -1,
> +	.dev		= {
> +				.dma_mask		= &eth_dmamask,
> +				.coherent_dma_mask	= DMA_BIT_MASK(32),
> +				.platform_data		= &eth_data,

Nit.  Excessive whitespace.

[snip]

> +#else
> +void __init at91_add_device_eth(struct at91_eth_data *data) {}

inline maybe?

> +#endif

Regards,
Hartley
