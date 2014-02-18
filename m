From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Feb 2014 12:03:19 +0100
Subject: [PATCH v4 1/3] ARM: EXYNOS: initial board support for exynos5260
 SoC
In-Reply-To: <1392721076-26630-2-git-send-email-rahul.sharma@samsung.com>
References: <1392721076-26630-1-git-send-email-rahul.sharma@samsung.com>
 <1392721076-26630-2-git-send-email-rahul.sharma@samsung.com>
Message-ID: <2203874.7pS2uKgoKp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 February 2014 16:27:54 Rahul Sharma wrote:
> diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
> index 7654f19..1cc52c9 100644
> --- a/arch/arm/mach-exynos/common.c
> +++ b/arch/arm/mach-exynos/common.c
> @@ -176,6 +176,15 @@ static struct map_desc exynos5250_iodesc[] __initdata = {
>  	},
>  };
>  
> +static struct map_desc exynos5260_iodesc[] __initdata = {
> +	{
> +		.virtual	= (unsigned long)S5P_VA_SYSRAM_NS,
> +		.pfn		= __phys_to_pfn(EXYNOS5260_PA_SYSRAM_NS),
> +		.length		= SZ_4K,
> +		.type		= MT_DEVICE,
> +	},
> +};
> +
>  static struct map_desc exynos5_iodesc[] __initdata = {
>  	{
>  		.virtual	= (unsigned long)S3C_VA_SYS,
> @@ -331,6 +340,8 @@ static void __init exynos_map_io(void)
>  		iotable_init(exynos4x12_iodesc, ARRAY_SIZE(exynos4x12_iodesc));
>  	if (soc_is_exynos5250())
>  		iotable_init(exynos5250_iodesc, ARRAY_SIZE(exynos5250_iodesc));
> +	if (soc_is_exynos5260())
> +		iotable_init(exynos5260_iodesc, ARRAY_SIZE(exynos5260_iodesc));
>  }

As I commented before, I think we really shouldn't do this any more: There
is no excuse why you still need to add SoC specific code here. Please put
the SYSRAM into DT and make a proper abstraction for it so you don't have
to modify the kernel every time a new SoC variant comes out.

> diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
> index 37ea261..790009e 100644
> --- a/arch/arm/mach-exynos/mach-exynos5-dt.c
> +++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
> @@ -51,6 +51,7 @@ static void __init exynos5_dt_machine_init(void)
>  
>  static char const *exynos5_dt_compat[] __initdata = {
>  	"samsung,exynos5250",
> +	"samsung,exynos5260",
>  	"samsung,exynos5420",
>  	"samsung,exynos5440",
>  	NULL

This one is ok, but I'd suggest also adding a generic "samsung,exynos5" string here,
for the same reason.

> diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-samsung/include/plat/cpu.h
> index 31164b3..0110df3 100644
> --- a/arch/arm/plat-samsung/include/plat/cpu.h
> +++ b/arch/arm/plat-samsung/include/plat/cpu.h
> @@ -46,6 +46,7 @@ extern unsigned long samsung_cpu_id;
>  #define EXYNOS4_CPU_MASK	0xFFFE0000
>  
>  #define EXYNOS5250_SOC_ID	0x43520000
> +#define EXYNOS5260_SOC_ID	0xE5260000
>  #define EXYNOS5420_SOC_ID	0xE5420000
>  #define EXYNOS5440_SOC_ID	0xE5440000
>  #define EXYNOS5_SOC_MASK	0xFFFFF000
> @@ -68,6 +69,7 @@ IS_SAMSUNG_CPU(exynos4210, EXYNOS4210_CPU_ID, EXYNOS4_CPU_MASK)
>  IS_SAMSUNG_CPU(exynos4212, EXYNOS4212_CPU_ID, EXYNOS4_CPU_MASK)
>  IS_SAMSUNG_CPU(exynos4412, EXYNOS4412_CPU_ID, EXYNOS4_CPU_MASK)
>  IS_SAMSUNG_CPU(exynos5250, EXYNOS5250_SOC_ID, EXYNOS5_SOC_MASK)
> +IS_SAMSUNG_CPU(exynos5260, EXYNOS5260_SOC_ID, EXYNOS5_SOC_MASK)
>  IS_SAMSUNG_CPU(exynos5420, EXYNOS5420_SOC_ID, EXYNOS5_SOC_MASK)
>  IS_SAMSUNG_CPU(exynos5440, EXYNOS5440_SOC_ID, EXYNOS5_SOC_MASK)
>  
> @@ -148,6 +150,12 @@ IS_SAMSUNG_CPU(exynos5440, EXYNOS5440_SOC_ID, EXYNOS5_SOC_MASK)
>  # define soc_is_exynos5250()	0
>  #endif
>  
> +#if defined(CONFIG_SOC_EXYNOS5260)
> +# define soc_is_exynos5260()	is_samsung_exynos5260()
> +#else
> +# define soc_is_exynos5260()	0
> +#endif
> +
>  #if defined(CONFIG_SOC_EXYNOS5420)
>  # define soc_is_exynos5420()	is_samsung_exynos5420()
>  #else

This doesn't seem to be used anywhere.

	Arnd
