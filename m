From: mike@compulab.co.il (Mike Rapoport)
Date: Wed, 25 Nov 2009 17:26:38 +0200
Subject: [PATCH 05/17] ARM: pxa/raumfeld: add rotary encoder support
In-Reply-To: <1259145751-3331-6-git-send-email-daniel@caiaq.de>
References: <1259145751-3331-1-git-send-email-daniel@caiaq.de>
	<1259145751-3331-6-git-send-email-daniel@caiaq.de>
Message-ID: <4B0D4CAE.50709@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Daniel Mack wrote:
> The 'Controller' and 'Speaker S/M' have a rotary encoder device for
> volume control.
> 
> Signed-off-by: Daniel Mack <daniel@caiaq.de>
> ---
>  arch/arm/mach-pxa/raumfeld.c |   35 +++++++++++++++++++++++++++++++++++
>  1 files changed, 35 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
> index 2d47dc2..a2a2b18 100644
> --- a/arch/arm/mach-pxa/raumfeld.c
> +++ b/arch/arm/mach-pxa/raumfeld.c
> @@ -23,6 +23,8 @@
>  #include <linux/interrupt.h>
>  #include <linux/gpio.h>
>  #include <linux/smsc911x.h>
> +#include <linux/input.h>
> +#include <linux/rotary_encoder.h>
>  
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
> @@ -153,6 +155,27 @@ static struct pxaohci_platform_data raumfeld_ohci_info = {
>  	.flags		= ENABLE_PORT1,
>  };
>  
> +/**
> + * Rotary encoder input device
> + */
> +static struct rotary_encoder_platform_data raumfeld_rotary_encoder_info = {
> +	.steps		= 24,
> +	.axis		= REL_X,
> +	.relative_axis	= 1,
> +	.gpio_a		= mfp_to_gpio(GPIO_VOLENC_A),
> +	.gpio_b		= mfp_to_gpio(GPIO_VOLENC_B),
> +	.inverted_a	= 1,
> +	.inverted_b	= 0,
> +};
> +
> +static struct platform_device rotary_encoder_device = {
> +	.name		= "rotary-encoder",
> +	.id		= 0,
> +	.dev		= {
> +		.platform_data = &raumfeld_rotary_encoder_info,
> +	}
> +};
> +
>  static void __init raumfeld_common_init(void)
>  {
>  	enable_irq_wake(IRQ_WAKEUP0);
> @@ -174,6 +197,12 @@ static void __init raumfeld_common_init(void)
>  
>  static void __init raumfeld_controller_init(void)
>  {
> +	struct platform_device *raumfeld_controller_devices[] = {
> +		&rotary_encoder_device,
> +	};

Any reason to keep the devices array inside the function? I think it makes the
code less readable.

> +	platform_add_devices(ARRAY_AND_SIZE(raumfeld_controller_devices));
> +
>  	raumfeld_common_init();
>  }
>  
> @@ -185,6 +214,12 @@ static void __init raumfeld_connector_init(void)
>  
>  static void __init raumfeld_speaker_init(void)
>  {
> +	struct platform_device *raumfeld_speaker_devices[] = {
> +		&rotary_encoder_device,
> +	};

ditto

> +	platform_add_devices(ARRAY_AND_SIZE(raumfeld_speaker_devices));
> +
>  	raumfeld_common_init();
>  	raumfeld_eth_init();
>  }

-- 
Sincerely yours,
Mike.
