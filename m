From: will.deacon@arm.com (Will Deacon)
Date: Thu, 6 Sep 2012 10:11:28 +0100
Subject: [PATCH v2 1/2] ARM: shmobile: sh73a0: enable PMU(Performance
 Monitoring Unit)
In-Reply-To: <1346909447-12526-2-git-send-email-koba@kmckk.co.jp>
References: <1346813317-4030-1-git-send-email-koba@kmckk.co.jp>
 <1346909447-12526-1-git-send-email-koba@kmckk.co.jp>
 <1346909447-12526-2-git-send-email-koba@kmckk.co.jp>
Message-ID: <20120906091128.GB858@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 06, 2012 at 06:30:46AM +0100, Tetsuyuki Kobayshi wrote:
> From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
> 
> This patch enables PMU(Performance Monitoring Unit) for sh73a0.
> 
> Signed-off-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
> ---
> Changes for v2:
> - Removed #ifdef CONFIG_HW_PERF_EVENTS
> - Added kzm9g_defconfig
> 
>  arch/arm/configs/kzm9g_defconfig      |    1 +
>  arch/arm/mach-shmobile/setup-sh73a0.c |   22 ++++++++++++++++++++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/arch/arm/configs/kzm9g_defconfig b/arch/arm/configs/kzm9g_defconfig
> index 2388c86..5d0c667 100644
> --- a/arch/arm/configs/kzm9g_defconfig
> +++ b/arch/arm/configs/kzm9g_defconfig
> @@ -14,6 +14,7 @@ CONFIG_NAMESPACES=y
>  CONFIG_CC_OPTIMIZE_FOR_SIZE=y
>  CONFIG_SYSCTL_SYSCALL=y
>  CONFIG_EMBEDDED=y
> +CONFIG_PERF_EVENTS=y
>  CONFIG_SLAB=y
>  CONFIG_MODULES=y
>  CONFIG_MODULE_FORCE_LOAD=y
> diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
> index d230af6..8186a08 100644
> --- a/arch/arm/mach-shmobile/setup-sh73a0.c
> +++ b/arch/arm/mach-shmobile/setup-sh73a0.c
> @@ -39,6 +39,7 @@
>  #include <asm/mach/map.h>
>  #include <asm/mach/arch.h>
>  #include <asm/mach/time.h>
> +#include <asm/pmu.h>
>  
>  static struct map_desc sh73a0_io_desc[] __initdata = {
>  	/* create a 1:1 entity map for 0xe6xxxxxx
> @@ -734,6 +735,26 @@ static struct platform_device mpdma0_device = {
>  	},
>  };
>  
> +static struct resource pmu_resources[] = {
> +	[0] = {
> +		.start	= gic_spi(55),
> +		.end	= gic_spi(55),
> +		.flags	= IORESOURCE_IRQ,
> +	},
> +	[1] = {
> +		.start	= gic_spi(56),
> +		.end	= gic_spi(56),
> +		.flags	= IORESOURCE_IRQ,
> +	},
> +};
> +
> +static struct platform_device pmu_device = {
> +	.name		= "arm-pmu",
> +	.id		= ARM_PMU_DEVICE_CPU,
> +	.num_resources	= ARRAY_SIZE(pmu_resources),
> +	.resource	= pmu_resources,
> +};

Please check my latest perf stuff to go into arm-soc (pmu/cleanup). The
ARM_PMU_DEVICE_CPU crap has disappeared and you won't need to include
asm/pmu.h anymore.

Will
