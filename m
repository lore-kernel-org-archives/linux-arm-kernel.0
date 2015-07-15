From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 15 Jul 2015 10:24:38 +0200
Subject: [RFC] ARM: EXYNOS: reset KFC cores when cpu is up
In-Reply-To: <1436924213-29732-1-git-send-email-parkch98@gmail.com>
References: <1436924213-29732-1-git-send-email-parkch98@gmail.com>
Message-ID: <55A618C6.3020603@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Chanho,

On 07/15/2015 03:36 AM, Chanho Park wrote:
> The cpu booting of exynos5422 has been still broken since we discussed
> it in last year[1]. I found this resetting codes from odroid-xu3 kernel of
> hardkernel, it could help to boot 8 cores well. This patch need to have
> more test like STR and other SoC especially exynos5800 which is variant
> of exynos5422. If this patch is broken on exynos5800, I'll find another
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
> [1]:http://lists.infradead.org/pipermail/linux-arm-kernel/2015-June/350632.html
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
> diff --git a/arch/arm/mach-exynos/mcpm-exynos.c b/arch/arm/mach-exynos/mcpm-exynos.c
> index 9bdf547..a076dde 100644
> --- a/arch/arm/mach-exynos/mcpm-exynos.c
> +++ b/arch/arm/mach-exynos/mcpm-exynos.c
> @@ -70,7 +70,18 @@ static int exynos_cpu_powerup(unsigned int cpu, unsigned int cluster)
>  		cluster >= EXYNOS5420_NR_CLUSTERS)
>  		return -EINVAL;
> 
> -	exynos_cpu_power_up(cpunr);
> +	if (!exynos_cpu_power_state(cpunr)) {
> +		exynos_cpu_power_up(cpunr);
> +
> +		if (soc_is_exynos5800() && cluster) {

I believe of_machine_is_compatible("samsung,exynos5800") is preferred
nowadays over soc_is_exynos5800().

Now, is correct to do this for all Exynos5422/5800 based boards? AFAIU
from the previous discussions, this behavior is specific to the Odroid
XU3 so maybe of_machine_is_compatible("hardkernel,odroid-xu3") instead?

I know this can affect other Exynos5800 boards that are shipped with a
similar binary BL1/BL2 blobs that also use SPARE2 as a sync mechanism
but maybe is better to add more exceptions later rather than do it for
all Exynos5800?

The Exynos5800 based Chromebook doesn't have this issue for example and
all the 8 cores are brought up correctly.

Having said that, I tested this patch on an Exynos5800 Peach Pi and all
the 8 cores are up and also after a S2R so seems to be a no-op when the
PMU_SPARE2 is not used for this.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
