From: kristoffer.ericson@gmail.com (Kristoffer Ericson)
Date: Sat, 11 Dec 2010 21:57:11 +0100
Subject: [PATCH] sa1100: Fix platform device registration
In-Reply-To: <1292090000-21779-1-git-send-email-jochen@scram.de>
References: <1292090000-21779-1-git-send-email-jochen@scram.de>
Message-ID: <20101211205710.GB810@boggieman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Applies and makes sense, so

Acked-by: Kristoffer Ericson <kristoffer.ericson@gmail.com>

On Sat, Dec 11, 2010 at 06:53:20PM +0100, Jochen Friedrich wrote:
> Since commit 7a5b4e16c880f8350d255dc188f81622905618c1, simpad devices don't
> boot anymore, since platform devices are registered too early. Fix by moving
> the registration from map_io to arch_initcall as done on other sa1100 boards.
> 
> Signed-off-by: Jochen Friedrich <jochen@scram.de>
> ---
>  arch/arm/mach-sa1100/simpad.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-sa1100/simpad.c b/arch/arm/mach-sa1100/simpad.c
> index 27692d0..cfb7607 100644
> --- a/arch/arm/mach-sa1100/simpad.c
> +++ b/arch/arm/mach-sa1100/simpad.c
> @@ -166,9 +166,6 @@ static void __init simpad_map_io(void)
>  	PCFR = 0;
>  	PSDR = 0;
>  
> -	sa11x0_register_mtd(&simpad_flash_data, simpad_flash_resources,
> -			      ARRAY_SIZE(simpad_flash_resources));
> -	sa11x0_register_mcp(&simpad_mcp_data);
>  }
>  
>  static void simpad_power_off(void)
> @@ -216,6 +213,10 @@ static int __init simpad_init(void)
>  
>  	pm_power_off = simpad_power_off;
>  
> +	sa11x0_register_mtd(&simpad_flash_data, simpad_flash_resources,
> +			      ARRAY_SIZE(simpad_flash_resources));
> +	sa11x0_register_mcp(&simpad_mcp_data);
> +
>  	ret = platform_add_devices(devices, ARRAY_SIZE(devices));
>  	if(ret)
>  		printk(KERN_WARNING "simpad: Unable to register mq200 framebuffer device");
> -- 
> 1.7.2.3
