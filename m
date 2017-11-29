From: alexander.sverdlin@gmail.com (Alexander Sverdlin)
Date: Wed, 29 Nov 2017 21:36:48 +0100
Subject: [PATCH v2 4/6] ARM: ep93xx: ts72xx: Rewrite map IO code to be
 reusable
In-Reply-To: <20171121143204.1839-5-lukma@denx.de>
References: <20171116232239.16823-1-lukma@denx.de>
 <20171121143204.1839-1-lukma@denx.de> <20171121143204.1839-5-lukma@denx.de>
Message-ID: <d4ece591-74ef-060e-87cd-873fb946867c@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On 21/11/17 15:32, Lukasz Majewski wrote:
> The map IO common code has been excluded to be reused by other ts72xx
> clones.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> 
> ---
> Changes for v2:
> - New patch
> ---
>  arch/arm/mach-ep93xx/ts72xx.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
> index 00e0e5b8babf..a6e473b3dcf6 100644
> --- a/arch/arm/mach-ep93xx/ts72xx.c
> +++ b/arch/arm/mach-ep93xx/ts72xx.c
> @@ -30,11 +30,6 @@
>  
>  static struct map_desc ts72xx_io_desc[] __initdata = {
>  	{
> -		.virtual	= (unsigned long)TS72XX_MODEL_VIRT_BASE,
> -		.pfn		= __phys_to_pfn(TS72XX_MODEL_PHYS_BASE),
> -		.length		= TS72XX_MODEL_SIZE,
> -		.type		= MT_DEVICE,
> -	}, {
>  		.virtual	= (unsigned long)TS72XX_OPTIONS_VIRT_BASE,
>  		.pfn		= __phys_to_pfn(TS72XX_OPTIONS_PHYS_BASE),
>  		.length		= TS72XX_OPTIONS_SIZE,
> @@ -47,12 +42,26 @@ static struct map_desc ts72xx_io_desc[] __initdata = {
>  	}
>  };
>  
> -static void __init ts72xx_map_io(void)
> +static struct map_desc ts72xx_common_io_desc[] __initdata = {
> +	{
> +		.virtual	= (unsigned long)TS72XX_MODEL_VIRT_BASE,
> +		.pfn		= __phys_to_pfn(TS72XX_MODEL_PHYS_BASE),
> +		.length		= TS72XX_MODEL_SIZE,
> +		.type		= MT_DEVICE,
> +	}
> +};
> +
> +void __init ts72xx_common_map_io(void)
>  {
>  	ep93xx_map_io();
> -	iotable_init(ts72xx_io_desc, ARRAY_SIZE(ts72xx_io_desc));
> +	iotable_init(ts72xx_common_io_desc, ARRAY_SIZE(ts72xx_common_io_desc));
>  }
>  
> +static void __init ts72xx_map_io(void)
> +{
> +	ts72xx_common_map_io();
> +	iotable_init(ts72xx_io_desc, ARRAY_SIZE(ts72xx_io_desc));
> +}
>  
>  /*************************************************************************
>   * NAND flash
