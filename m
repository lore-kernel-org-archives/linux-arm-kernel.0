From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 07 Jan 2014 14:24:31 +0100
Subject: [PATCH V2 02/10] ARM: EXYNOS: initial board support for
 exynos5260 SoC
In-Reply-To: <1389099548-14649-3-git-send-email-rahul.sharma@samsung.com>
References: <1389099548-14649-1-git-send-email-rahul.sharma@samsung.com>
 <1389099548-14649-3-git-send-email-rahul.sharma@samsung.com>
Message-ID: <3255549.jEqQKz0UeP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 07 January 2014 18:29:00 Rahul Sharma wrote:
> From: Pankaj Dubey <pankaj.dubey@samsung.com>
> 
> This patch add basic arch side support for exynos5260 SoC.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Arun Kumar K <arun.kk@samsung.com>
> Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
> ---
> diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
> index 09e6898..e0c7108 100644
> --- a/arch/arm/mach-exynos/common.c
> +++ b/arch/arm/mach-exynos/common.c
> @@ -52,6 +52,7 @@ static const char name_exynos4210[] = "EXYNOS4210";
>  static const char name_exynos4212[] = "EXYNOS4212";
>  static const char name_exynos4412[] = "EXYNOS4412";
>  static const char name_exynos5250[] = "EXYNOS5250";
> +static const char name_exynos5260[] = "EXYNOS5260";
>  static const char name_exynos5410[] = "EXYNOS5410";
>  static const char name_exynos5420[] = "EXYNOS5420";
>  static const char name_exynos5440[] = "EXYNOS5440";
> @@ -92,6 +93,12 @@ static struct cpu_table cpu_ids[] __initdata = {
>  		.init		= exynos_init,
>  		.name		= name_exynos5410,
>  	}, {
> +		.idcode		= EXYNOS5260_SOC_ID,
> +		.idmask		= EXYNOS5_SOC_MASK,
> +		.map_io		= exynos5_map_io,
> +		.init		= exynos_init,
> +		.name		= name_exynos5260,
> +	}, {
>  		.idcode		= EXYNOS5420_SOC_ID,
>  		.idmask		= EXYNOS5_SOC_MASK,
>  		.map_io		= exynos5_map_io,

I think we've seen enough of these. Please generalize it enough
so we won't need to add any more entries whenever a new SoC
comes up. It's probably fine for now to have to tell the difference
between EXYNOS4 and EXYNOS5, but not new chips within some family.

According to rumors on the web, EXYNOS6 is going to be released
soon with a 64-bit CPU in it, and since we don't allow platform
specific code for arm64 like this any more, you should just
drop it for arm32 as well.

> @@ -279,6 +286,15 @@ static struct map_desc exynos5_iodesc[] __initdata = {
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
>  void exynos4_restart(enum reboot_mode mode, const char *cmd)
>  {
>  	__raw_writel(0x1, S5P_SWRESET);

The only difference you have is the map descriptor, and that should
go away if you only add a proper DT binding for SYSRAM. Try to get
rid of the remaining map_desc entries while you're at it.

> diff --git a/arch/arm/plat-samsung/include/plat/map-s5p.h b/arch/arm/plat-samsung/include/plat/map-s5p.h
> index 31cac97..13c802b 100644
> --- a/arch/arm/plat-samsung/include/plat/map-s5p.h
> +++ b/arch/arm/plat-samsung/include/plat/map-s5p.h
> @@ -23,6 +23,7 @@
>  
>  #define S5P_VA_SYSRAM		S3C_ADDR(0x02400000)
>  #define S5P_VA_SYSRAM_NS	S3C_ADDR(0x02410000)
> +
>  #define S5P_VA_DMC0		S3C_ADDR(0x02440000)
>  #define S5P_VA_DMC1		S3C_ADDR(0x02480000)
>  #define S5P_VA_SROMC		S3C_ADDR(0x024C0000)
> 

This hunk doesn't really belong in the patch at all.

	Arnd
