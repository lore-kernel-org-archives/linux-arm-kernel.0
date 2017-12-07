From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 7 Dec 2017 20:22:07 +0530
Subject: [PATCH v1 1/6] ARM: davinci: clean up map_io functions
In-Reply-To: <1512182054-17410-2-git-send-email-david@lechnology.com>
References: <1512182054-17410-1-git-send-email-david@lechnology.com>
 <1512182054-17410-2-git-send-email-david@lechnology.com>
Message-ID: <2e0a60bb-08be-5d0c-3c4c-c9e075c9170a@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 02 December 2017 08:04 AM, David Lechner wrote:
> This cleans up the map_io functions in the board init files for
> mach-davinci.
> 
> Most of the boards had a wrapper function around <board>_init(). This
> wrapper is removed and the function is used directly. Additionally, the
> <board>_init() functions are renamed to <board>_map_io() to match the
> field name.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

> diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
> index cb0a41e..f0e2762 100644
> --- a/arch/arm/mach-davinci/board-dm646x-evm.c
> +++ b/arch/arm/mach-davinci/board-dm646x-evm.c
> @@ -716,16 +716,6 @@ static void __init evm_init_i2c(void)
>  }
>  #endif
>  
> -#define DM6467T_EVM_REF_FREQ		33000000
> -
> -static void __init davinci_map_io(void)
> -{
> -	dm646x_init();

The call to dm646x_init() is dropped here, but I don't see it added
back, at least in this patch.

> diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
> index da21353..b3be5c8 100644
> --- a/arch/arm/mach-davinci/dm646x.c
> +++ b/arch/arm/mach-davinci/dm646x.c
> @@ -17,6 +17,7 @@
>  #include <linux/platform_data/edma.h>
>  #include <linux/platform_data/gpio-davinci.h>
>  
> +#include <asm/mach-types.h>
>  #include <asm/mach/map.h>
>  
>  #include <mach/cputype.h>
> @@ -952,11 +953,16 @@ int __init dm646x_init_edma(struct edma_rsv_info *rsv)
>  	return IS_ERR(edma_pdev) ? PTR_ERR(edma_pdev) : 0;
>  }
>  
> -void __init dm646x_init(void)
> +#define DM6467T_EVM_REF_FREQ		33000000
> +
> +void __init dm646x_map_io(void)
>  {
>  	davinci_common_init(&davinci_soc_info_dm646x);
>  	davinci_map_sysmod();
>  	davinci_clk_init(davinci_soc_info_dm646x.cpu_clks);
> +
> +	if (machine_is_davinci_dm6467tevm())
> +		davinci_set_refclk_rate(DM6467T_EVM_REF_FREQ);
>  }

I think we should leave the DM646x case out of this since there are
additional issues like introducing these EVM specific defines in a file
meant for SoC.

Is this clean-up a must for you to implement rest of the series (haven't
looked at other patches yet).

Thanks,
Sekhar
