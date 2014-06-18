From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 18 Jun 2014 11:40:37 -0400 (EDT)
Subject: [PATCH] arm: exynos: Support cluster power off on exynos5420/5800
In-Reply-To: <1403104722-14848-1-git-send-email-a.kesavan@samsung.com>
References: <1403104722-14848-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <alpine.LFD.2.11.1406181132110.16842@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 Jun 2014, Abhilash Kesavan wrote:

> Turning off a cluster when all 4 cores of the cluster are powered off
> saves power significantly. Powering off the A15 L2 alone gives around
> 100mW in savings. Add support for powering off the A15/A7 clusters on
> exynos5420/5800.
> 
> The patch enables specific register bits which ensure that:
>    - cluster L2 will be turned on before the first man is powered up.
>    - last man will be turned off before the cluster L2 is turned off.
>    - core is powered down before powering it up.
> 
> Remove the exynos_cluster_power_control function completely as we can
> rely on the above mentioned bits rather than polling the cluster power
> status register.
> 
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>

Minor nit below:

> @@ -342,6 +318,26 @@ static int __init exynos_mcpm_init(void)
>  	pr_info("Exynos MCPM support installed\n");
>  
>  	/*
> +	 * On Exynos5420/5800 for the A15 and A7 clusters:
> +	 *
> +	 * EXYNOS5420_ENABLE_AUTOMATIC_CORE_DOWN ensures that all the cores
> +	 * in a cluster are turned off before turning off the cluster L2.
> +	 *
> +	 * EXYNOS5420_USE_ARM_CORE_DOWN_STATE ensures that a cores is powered
> +	 * off before waking it up.
> +	 *
> +	 * EXYNOS5420_USE_L2_COMMON_UP_STATE ensures that cluster L2 will be
> +	 * turned on before the first man is powered up.
> +	 */
> +	for (i = 0; i < EXYNOS5420_NR_CLUSTERS; i++) {
> +		value = __raw_readl(EXYNOS_COMMON_CONFIGURATION(i) + 0x8);
> +		value |= EXYNOS5420_ENABLE_AUTOMATIC_CORE_DOWN |
> +			 EXYNOS5420_USE_ARM_CORE_DOWN_STATE    |
> +			 EXYNOS5420_USE_L2_COMMON_UP_STATE;
> +		__raw_writel(value, EXYNOS_COMMON_CONFIGURATION(i) + 0x8);

Surely you can add another define in mach-exynos/regs-pmu.h to better 
identify this register instead of EXYNOS_COMMON_CONFIGURATION()+8 ?

After that, you may add:

Acked-by: Nicolas Pitre <nico@linaro.org>


Nicolas
