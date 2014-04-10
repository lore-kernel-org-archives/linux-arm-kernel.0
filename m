From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 10 Apr 2014 10:51:15 +0100
Subject: [PATCH 06/27] ARM: EXYNOS:: Enter a15 lowpower mode for
 Exynos3250 based on Cortex-a7
In-Reply-To: <1397122124-15690-7-git-send-email-cw00.choi@samsung.com>
 (Chanwoo Choi's message of "Thu, 10 Apr 2014 10:28:23 +0100")
References: <1397122124-15690-1-git-send-email-cw00.choi@samsung.com>
 <1397122124-15690-7-git-send-email-cw00.choi@samsung.com>
Message-ID: <87d2gp3430.fsf@approximate.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 10 2014 at 10:28:23 am BST, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> This patch decide proper lowpower mode of either a15 or a9 according to own ID
> from Main ID register.
>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-exynos/hotplug.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/hotplug.c b/arch/arm/mach-exynos/hotplug.c
> index 5eead53..36d3db6 100644
> --- a/arch/arm/mach-exynos/hotplug.c
> +++ b/arch/arm/mach-exynos/hotplug.c
> @@ -135,13 +135,20 @@ void __ref exynos_cpu_die(unsigned int cpu)
>  	int primary_part = 0;
>  
>  	/*
> -	 * we're ready for shutdown now, so do it.
> -	 * Exynos4 is A9 based while Exynos5 is A15; check the CPU part
> +	 * we're ready for shutdown now, so do it. Exynos4 is A9 based
> +	 * while Exynos5 is A15/Exynos7 is A7; check the CPU part
>  	 * number by reading the Main ID register and then perform the
>  	 * appropriate sequence for entering low power.
>  	 */
>  	asm("mrc p15, 0, %0, c0, c0, 0" : "=r"(primary_part) : : "cc");

While you're touching that code, how about using:

      primary_part = read_cpuid(CPUID_ID);

> -	if ((primary_part & 0xfff0) == 0xc0f0)
> +
> +	/*
> +	 * Main ID register of Cortex series
> +	 * - Cortex-a7  : 0x410F_C07x
> +	 * - Cortex-a15 : 0x410F_C0Fx
> +	 */
> +	primary_part = primary_part & 0xfff0;
> +	if (primary_part == 0xc0f0 || primary_part == 0xc070)

ARM_CPU_PART_CORTEX_A15, ARM_CPU_PART_CORTEX_A7

>  		cpu_enter_lowpower_a15();
>  	else
>  		cpu_enter_lowpower_a9();

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
