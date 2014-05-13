From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 13 May 2014 11:28:52 +0900
Subject: [PATCH v5 2/5] ARM: EXYNOS: use generic exynos cpu power control
 functions
In-Reply-To: <1399307221-8659-3-git-send-email-a.kesavan@samsung.com>
References: <1399307221-8659-1-git-send-email-a.kesavan@samsung.com>
 <1399307221-8659-3-git-send-email-a.kesavan@samsung.com>
Message-ID: <019c01cf6e53$14eab220$3ec01660$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Abhilash Kesavan wrote:
> 
> From: Leela Krishna Amudala <leela.krishna@linaro.org>
> 
> Use generic exynos cpu power control functions to power up/down
> and to know the status of the cpu.
> 
> Signed-off-by: Leela Krishna Amudala <leela.krishna@linaro.org>

Same as previous comment.

> ---
>  arch/arm/mach-exynos/platsmp.c |    9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-
> exynos/platsmp.c
> index 0aac032..d442a66 100644
> --- a/arch/arm/mach-exynos/platsmp.c
> +++ b/arch/arm/mach-exynos/platsmp.c
> @@ -130,15 +130,12 @@ static int exynos_boot_secondary(unsigned int cpu,
> struct task_struct *idle)
>  	 */
>  	write_pen_release(phys_cpu);
> 
> -	if (!(__raw_readl(S5P_ARM_CORE1_STATUS) & S5P_CORE_LOCAL_PWR_EN)) {
> -		__raw_writel(S5P_CORE_LOCAL_PWR_EN,
> -			     S5P_ARM_CORE1_CONFIGURATION);
> -
> +	if (!exynos_cpu_power_state(cpu)) {
> +		exynos_cpu_powerup(cpu);
>  		timeout = 10;
> 
>  		/* wait max 10 ms until cpu1 is on */
> -		while ((__raw_readl(S5P_ARM_CORE1_STATUS)
> -			& S5P_CORE_LOCAL_PWR_EN) != S5P_CORE_LOCAL_PWR_EN) {
> +		while (exynos_cpu_power_state(cpu) != S5P_CORE_LOCAL_PWR_EN)
> {
>  			if (timeout-- == 0)
>  				break;
> 
> --

You may cleanup the definitions of 'S5P_ARM_CORE1_CONFIGURATION/STATUS' in
regs-pmu.h once hotplug.c uses the generic power control functions.

- Kukjin
