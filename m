From: snjw23@gmail.com (Sylwester Nawrocki)
Date: Sun, 18 Sep 2011 17:40:32 +0200
Subject: [PATCH 1/3] ARM: EXYNOS4: Modify PMU register setting function
In-Reply-To: <1316052239-8361-2-git-send-email-boyko.lee@samsung.com>
References: <1316052239-8361-1-git-send-email-boyko.lee@samsung.com>
	<1316052239-8361-2-git-send-email-boyko.lee@samsung.com>
Message-ID: <4E7610F0.1050708@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jongpill,

On 09/15/2011 04:03 AM, Jongpill Lee wrote:
> This patch modifies PMU register setting function to support the other Exynos4 series.
> 
> Signed-off-by: Jongpill Lee<boyko.lee@samsung.com>
> ---
>   arch/arm/mach-exynos4/include/mach/pmu.h      |    5 +
>   arch/arm/mach-exynos4/include/mach/regs-pmu.h |    1 -
>   arch/arm/mach-exynos4/pmu.c                   |  238 +++++++++---------------
>   3 files changed, 94 insertions(+), 150 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos4/include/mach/pmu.h b/arch/arm/mach-exynos4/include/mach/pmu.h
> index a952904..430e917 100644
> --- a/arch/arm/mach-exynos4/include/mach/pmu.h
> +++ b/arch/arm/mach-exynos4/include/mach/pmu.h
> @@ -20,6 +20,11 @@ enum sys_powerdown {
>   	NUM_SYS_POWERDOWN,
>   };
> 
> +struct exynos4_pmu_conf {
> +	void __iomem *reg;
> +	unsigned long val[NUM_SYS_POWERDOWN];

Why unsigned long? It's for the registers value, wouldn't u32 fit better?

> +};
> +
>   extern void exynos4_sys_powerdown_conf(enum sys_powerdown mode);
> 
>   #endif /* __ASM_ARCH_PMU_H */
> diff --git a/arch/arm/mach-exynos4/include/mach/regs-pmu.h b/arch/arm/mach-exynos4/include/mach/regs-pmu.h
> index cdf9b47..7fa44b9 100644
> --- a/arch/arm/mach-exynos4/include/mach/regs-pmu.h
> +++ b/arch/arm/mach-exynos4/include/mach/regs-pmu.h
> @@ -27,7 +27,6 @@
>   #define S5P_USE_STANDBY_WFI1			(1<<  17)
>   #define S5P_USE_STANDBY_WFE0			(1<<  24)
>   #define S5P_USE_STANDBY_WFE1			(1<<  25)
> -#define S5P_USE_MASK				((0x3<<  16) | (0x3<<  24))
> 
>   #define S5P_SWRESET				S5P_PMUREG(0x0400)
> 
> diff --git a/arch/arm/mach-exynos4/pmu.c b/arch/arm/mach-exynos4/pmu.c
> index 7ea9eb2..0210231 100644
> --- a/arch/arm/mach-exynos4/pmu.c
> +++ b/arch/arm/mach-exynos4/pmu.c
> @@ -16,160 +16,100 @@
>   #include<mach/regs-clock.h>
>   #include<mach/pmu.h>
> 
> -static void __iomem *sys_powerdown_reg[] = {
> -	S5P_ARM_CORE0_LOWPWR,
...
> -	S5P_GPS_ALIVE_LOWPWR,
> -};
> +static struct exynos4_pmu_conf *exynos4_pmu_config;
> +
> +static unsigned int exynos4_pmu_entry_cnt;
> 
> -static const unsigned int sys_powerdown_val[][NUM_SYS_POWERDOWN] = {
> -	/* { AFTR, LPA, SLEEP }*/
> -	{ 0, 0, 2 },	/* ARM_CORE0 */
...
> -	{ 7, 0, 0 },	/* GPS_ALIVE */
> +static struct exynos4_pmu_conf exynos4210_pmu_config[] = {
> +	/* { .reg = address, .val = { AFTR, LPA, SLEEP } */
> +	{ S5P_ARM_CORE0_LOWPWR,			{ 0x0, 0x0, 0x2 } },
...
> +	{ S5P_GPS_ALIVE_LOWPWR,			{ 0x7, 0x0, 0x0 } },
>   };
> 
>   void exynos4_sys_powerdown_conf(enum sys_powerdown mode)
>   {
> -	unsigned int count = ARRAY_SIZE(sys_powerdown_reg);
> +	unsigned int count = exynos4_pmu_entry_cnt;

How about using a sentinel at the array end and getting rid of the global
'exynos4_pmu_entry_cnt' variable? For instance an empty entry { } ?  

> 
>   	for (; count>  0; count--)
> -		__raw_writel(sys_powerdown_val[count - 1][mode],
> -				sys_powerdown_reg[count - 1]);
> +		__raw_writel(exynos4_pmu_config[count - 1].val[mode],
> +				exynos4_pmu_config[count - 1].reg);
> +}
> +
> +static int __init exynos4_pmu_init(void)
> +{
> +	exynos4_pmu_config = exynos4210_pmu_config;
> +	exynos4_pmu_entry_cnt = ARRAY_SIZE(exynos4210_pmu_config);
> +	printk(KERN_INFO "EXYNOS4210 PMU Initialize\n");

	"EXYNOS4210 PMU initialized\n", "EXYNOS4210 PMU initialization completed\n" ?

	Moreover AFAIK pr_info is preferred.

> +
> +	return 0;
>   }
> +arch_initcall(exynos4_pmu_init);

--
Thanks,
Sylwester
