From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Fri, 17 Jul 2015 10:05:40 +0200
Subject: [RFC] ARM: EXYNOS: reset KFC cores when cpu is up
In-Reply-To: <1436924213-29732-1-git-send-email-parkch98@gmail.com>
References: <1436924213-29732-1-git-send-email-parkch98@gmail.com>
Message-ID: <1437120340.5797.46.camel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-07-15 at 10:36 +0900, Chanho Park wrote:
> The cpu booting of exynos5422 has been still broken since we 
> discussed
> it in last year[1]. I found this resetting codes from odroid-xu3 
> kernel of
> hardkernel, it could help to boot 8 cores well. This patch need to 
> have
> more test like STR and other SoC especially exynos5800 which is 
> variant
> of exynos5422. If this patch is broken on exynos5800, I'll find 
> another
> way to check exynos5422.
> 
> This patch is top of my previous exynos5422 cpu ordering patch[2] and
> need to enable CONFIG_EXYNOS5420_MCPM=y
> 
> [    0.047509] CPU0: update cpu_capacity 448
> [    0.047534] CPU0: thread -1, cpu 0, socket 1, mpidr 80000100
> [    0.047874] Setting up static identity map for 0x400082c0 -
> 0x40008318
> [    0.048340] ARM CCI driver probed
> [    0.048597] Exynos MCPM support installed
> [    0.065676] CPU1: update cpu_capacity 448
> [    0.065685] CPU1: thread -1, cpu 1, socket 1, mpidr 80000101
> [    0.070672] CPU2: update cpu_capacity 448
> [    0.070680] CPU2: thread -1, cpu 2, socket 1, mpidr 80000102
> [    0.075644] CPU3: update cpu_capacity 448
> [    0.075653] CPU3: thread -1, cpu 3, socket 1, mpidr 80000103
> [    0.080590] CPU4: update cpu_capacity 1535
> [    0.080600] CPU4: thread -1, cpu 0, socket 0, mpidr 80000000
> [    0.085591] CPU5: update cpu_capacity 1535
> [    0.085599] CPU5: thread -1, cpu 1, socket 0, mpidr 80000001
> [    0.090590] CPU6: update cpu_capacity 1535
> [    0.090598] CPU6: thread -1, cpu 2, socket 0, mpidr 80000002
> [    0.095585] CPU7: update cpu_capacity 1535
> [    0.095593] CPU7: thread -1, cpu 3, socket 0, mpidr 80000003
> [    0.095720] Brought up 8 CPUs
> 
> [1]:http://lists.infradead.org/pipermail/linux-arm-kernel/2015
> -June/350632.html
> [2]:https://patchwork.kernel.org/patch/6782891/
> 
> Cc: Joonyoung Shim <jy0922.shim@samsung.com>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Heesub Shin <heesub.shin@samsung.com>
> Cc: Mauro Ribeiro <mauro.ribeiro@hardkernel.com>
> Cc: Abhilash Kesavan <a.kesavan@samsung.com>
> Cc: Przemyslaw Marczak <p.marczak@samsung.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> Signed-off-by: Chanho Park <parkch98@gmail.com>
> ---
>  arch/arm/mach-exynos/mcpm-exynos.c | 13 ++++++++++++-
>  arch/arm/mach-exynos/regs-pmu.h    |  6 ++++++
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-exynos/mcpm-exynos.c b/arch/arm/mach
> -exynos/mcpm-exynos.c
> index 9bdf547..a076dde 100644
> --- a/arch/arm/mach-exynos/mcpm-exynos.c
> +++ b/arch/arm/mach-exynos/mcpm-exynos.c
> @@ -70,7 +70,18 @@ static int exynos_cpu_powerup(unsigned int cpu, 
> unsigned int cluster)
>  		cluster >= EXYNOS5420_NR_CLUSTERS)
>  		return -EINVAL;
> 
> -	exynos_cpu_power_up(cpunr);
> +	if (!exynos_cpu_power_state(cpunr)) {
> +		exynos_cpu_power_up(cpunr);
> +
> +		if (soc_is_exynos5800() && cluster) {

This seems a tad subtle. You're assuming here cluster 1 is the little
cluster. Would be good to make this more specific/obvious.

>From looking at other mcpm-exynos code the assumption seems valid
(otherwise more code would be broken), so it may make sense to simply
define LITTLE_CLUSTER and BIG_CLUSTER and check explicitely for that.

Krzysztof on IRC mention that the cluster layout is read from MPIDR so
in principle this assumption could be invalidated on some Exynos
versions, but then again, given the amount of fallout from that i don't
see it as a practical issue at the moment :) 

> +			while (!pmu_raw_readl(S5P_PMU_SPARE2))
> +				udelay(10);

Would love to see some documentation for this magical pmu register, but
i guess you can't have them all :)


-- 
Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Collabora Ltd.
