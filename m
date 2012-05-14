From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 14 May 2012 17:16:22 +0900
Subject: [PATCH] ARM: EXYNOS4: Support Suspend/Resume for EXYNOS4412
In-Reply-To: <1332991517-3083-1-git-send-email-inderpal.singh@linaro.org>
References: <1332991517-3083-1-git-send-email-inderpal.singh@linaro.org>
Message-ID: <066001cd31a9$d92d6f80$8b884e80$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Inderpal Singh wrote:
> 
> This patch provides the suspend/resume support for EXYNOS4412.
> 
> Signed-off-by: Inderpal Singh <inderpal.singh@linaro.org>
> ---
>  arch/arm/mach-exynos/include/mach/regs-pmu.h |   10 +++++++++-
>  arch/arm/mach-exynos/pm.c                    |    2 +-
>  arch/arm/mach-exynos/pmu.c                   |   24
++++++++++++++++++++----
>  3 files changed, 30 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/include/mach/regs-pmu.h b/arch/arm/mach-
> exynos/include/mach/regs-pmu.h
> index 4c53f38..606b199 100644
> --- a/arch/arm/mach-exynos/include/mach/regs-pmu.h
> +++ b/arch/arm/mach-exynos/include/mach/regs-pmu.h
> @@ -177,7 +177,7 @@
> 
>  #define S5P_PMU_LCD1_CONF		S5P_PMUREG(0x3CA0)
> 
> -/* Only for EXYNOS4212 */
> +/* Only for EXYNOS4x12 */
>  #define S5P_ISP_ARM_LOWPWR			S5P_PMUREG(0x1050)
>  #define S5P_DIS_IRQ_ISP_ARM_LOCAL_LOWPWR	S5P_PMUREG(0x1054)
>  #define S5P_DIS_IRQ_ISP_ARM_CENTRAL_LOWPWR	S5P_PMUREG(0x1058)
> @@ -218,4 +218,12 @@
>  #define S5P_SECSS_MEM_OPTION			S5P_PMUREG(0x2EC8)
>  #define S5P_ROTATOR_MEM_OPTION			S5P_PMUREG(0x2F48)
> 
> +/* Only for EXYNOS4412 */
> +#define S5P_ARM_CORE2_LOWPWR			S5P_PMUREG(0x1020)
> +#define S5P_DIS_IRQ_CORE2			S5P_PMUREG(0x1024)
> +#define S5P_DIS_IRQ_CENTRAL2			S5P_PMUREG(0x1028)
> +#define S5P_ARM_CORE3_LOWPWR			S5P_PMUREG(0x1030)
> +#define S5P_DIS_IRQ_CORE3			S5P_PMUREG(0x1034)
> +#define S5P_DIS_IRQ_CENTRAL3			S5P_PMUREG(0x1038)
> +
>  #endif /* __ASM_ARCH_REGS_PMU_H */
> diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
> index 428cfeb..f0bb467 100644
> --- a/arch/arm/mach-exynos/pm.c
> +++ b/arch/arm/mach-exynos/pm.c
> @@ -313,7 +313,7 @@ static int exynos4_pm_suspend(void)
>  	tmp &= ~S5P_CENTRAL_LOWPWR_CFG;
>  	__raw_writel(tmp, S5P_CENTRAL_SEQ_CONFIGURATION);
> 
> -	if (soc_is_exynos4212()) {
> +	if (soc_is_exynos4212() || soc_is_exynos4412()) {
>  		tmp = __raw_readl(S5P_CENTRAL_SEQ_OPTION);
>  		tmp &= ~(S5P_USE_STANDBYWFI_ISP_ARM |
>  			 S5P_USE_STANDBYWFE_ISP_ARM);
> diff --git a/arch/arm/mach-exynos/pmu.c b/arch/arm/mach-exynos/pmu.c
> index bba48f5..77c6815 100644
> --- a/arch/arm/mach-exynos/pmu.c
> +++ b/arch/arm/mach-exynos/pmu.c
> @@ -94,7 +94,7 @@ static struct exynos4_pmu_conf exynos4210_pmu_config[] =
> {
>  	{ PMU_TABLE_END,},
>  };
> 
> -static struct exynos4_pmu_conf exynos4212_pmu_config[] = {
> +static struct exynos4_pmu_conf exynos4x12_pmu_config[] = {
>  	{ S5P_ARM_CORE0_LOWPWR,			{ 0x0, 0x0, 0x2 } },
>  	{ S5P_DIS_IRQ_CORE0,			{ 0x0, 0x0, 0x0 } },
>  	{ S5P_DIS_IRQ_CENTRAL0,			{ 0x0, 0x0, 0x0 } },
> @@ -202,6 +202,16 @@ static struct exynos4_pmu_conf
exynos4212_pmu_config[]
> = {
>  	{ PMU_TABLE_END,},
>  };
> 
> +static struct exynos4_pmu_conf exynos4412_pmu_config[] = {
> +	{ S5P_ARM_CORE2_LOWPWR,			{ 0x0, 0x0, 0x2 } },
> +	{ S5P_DIS_IRQ_CORE2,			{ 0x0, 0x0, 0x0 } },
> +	{ S5P_DIS_IRQ_CENTRAL2,			{ 0x0, 0x0, 0x0 } },
> +	{ S5P_ARM_CORE3_LOWPWR,			{ 0x0, 0x0, 0x2 } },
> +	{ S5P_DIS_IRQ_CORE3,			{ 0x0, 0x0, 0x0 } },
> +	{ S5P_DIS_IRQ_CENTRAL3,			{ 0x0, 0x0, 0x0 } },
> +	{ PMU_TABLE_END,},
> +};
> +
>  void exynos4_sys_powerdown_conf(enum sys_powerdown mode)
>  {
>  	unsigned int i;
> @@ -209,6 +219,12 @@ void exynos4_sys_powerdown_conf(enum sys_powerdown
> mode)
>  	for (i = 0; (exynos4_pmu_config[i].reg != PMU_TABLE_END) ; i++)
>  		__raw_writel(exynos4_pmu_config[i].val[mode],
>  				exynos4_pmu_config[i].reg);
> +
> +	if (soc_is_exynos4412()) {
> +		for (i = 0; exynos4412_pmu_config[i].reg != PMU_TABLE_END ;
> i++)
> +			__raw_writel(exynos4412_pmu_config[i].val[mode],
> +				exynos4412_pmu_config[i].reg);
> +	}
>  }
> 
>  static int __init exynos4_pmu_init(void)
> @@ -218,9 +234,9 @@ static int __init exynos4_pmu_init(void)
>  	if (soc_is_exynos4210()) {
>  		exynos4_pmu_config = exynos4210_pmu_config;
>  		pr_info("EXYNOS4210 PMU Initialize\n");
> -	} else if (soc_is_exynos4212()) {
> -		exynos4_pmu_config = exynos4212_pmu_config;
> -		pr_info("EXYNOS4212 PMU Initialize\n");
> +	} else if (soc_is_exynos4212() || soc_is_exynos4412()) {
> +		exynos4_pmu_config = exynos4x12_pmu_config;
> +		pr_info("EXYNOS4x12 PMU Initialize\n");
>  	} else {
>  		pr_info("EXYNOS4: PMU not supported\n");
>  	}
> --
> 1.7.5.4

Looks ok to me, will apply.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
